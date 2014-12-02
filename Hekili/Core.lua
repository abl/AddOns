-- Hekili.lua
-- April 2014

local H = Hekili

local SpellRange = LibStub("SpellRange-1.0")
local FormatKey, GetSpecializationID, GetResourceName, RunHandler = H.Utils.FormatKey, H.Utils.GetSpecializationID, H.Utils.GetResourceName, H.Utils.RunHandler
local trim = string.trim
local mt_resource = Hekili.MT.mt_resource
local tblCopy = Hekili.Utils.tblCopy


-- CheckBrokenImports()
-- Remove any displays or action lists that were unsuccessfully imported.
function CheckBrokenImports()
	local self = Hekili
	
	-- Check for broken imports from previous versions.
	for i, display in ipairs( self.DB.profile.displays ) do	
		if type( display ) ~= 'table' then
			table.remove( self.DB.profile.displays, i )
		end
	end
	
	for i, list in ipairs( self.DB.profile.actionLists ) do	
		if type( list ) ~= 'table' then
			for d_key, display in ipairs( self.DB.profile.displays ) do
				for h_key, hook in ipairs ( display.Queues ) do
					if hook['Action List'] == i then
						hook['Action List'] = 0
						hook.Enabled = false
					elseif hook['Action List'] > i then
						hook['Action List'] = hook['Action List'] - 1
					end
				end
			end
			table.remove( self.DB.profile.actionLists, i )
		end
	end
end


-- OnInitialize()
-- Addon has been loaded by the WoW client (1x).
function H:OnInitialize()
	self.DB = LibStub("AceDB-3.0"):New("HekiliDB", self:GetDefaults())
	
	self.Options = self:GetOptions()
	self.Options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.DB)
	
	-- Add dual-spec support
	local LibDualSpec = LibStub('LibDualSpec-1.0')
	LibDualSpec:EnhanceDatabase(self.DB, "Hekili")
	LibDualSpec:EnhanceOptions(self.Options.args.profiles, self.DB)

	self.DB.RegisterCallback(self, "OnProfileChanged",	"TotalRefresh")
	self.DB.RegisterCallback(self, "OnProfileCopied",	"TotalRefresh")
	self.DB.RegisterCallback(self, "OnProfileReset",	"TotalRefresh")
	
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Hekili", self.Options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Hekili", "Hekili")
	self:RegisterChatCommand("hekili", "CmdLine")
	self:RegisterChatCommand("hek", "CmdLine")
	
	self.ACD = LibStub("AceConfigDialog-3.0")

	self.combat		= 0
	self.Boss		= false
	self.faction	= UnitFactionGroup('player')
	self.TTD		= {}
	self.Hardcasts	= true
	
	self:RefreshBindings()

	if not Hekili.DB.profile.Version or Hekili.DB.profile.Version < 2 then
		Hekili.DB:ResetDB()
	end
	
	CheckBrokenImports()
	self:RestoreDefaults()
	self:LoadScripts()
	self:BuildUI()
	self:UnregisterAllEvents()
	
	Hekili.DB.profile.Release = 6
	
	if not Hekili.Class then
		self.DB.profile.Enabled = false
		for i, buttons in ipairs( self.UI.Buttons ) do
			for j, _ in ipairs( buttons ) do
				buttons[j]:Hide()
			end
		end
	end
	
end


-- Convert SimC syntax to Lua conditionals.
function SimToLua( str, assign )
	
	-- If no conditions were provided, function should return true.
	if not str or str == '' then return nil end
	
	-- Strip comments.
	str = str:gsub("^%-%-.-\n", "")
		
	-- Replace '%' for division with actual division operator '/'.
	str = str:gsub("%%", "/")
	
	-- Replace '&' with ' and '.
	str = str:gsub("&", " and ")
	
	-- Replace '|' with ' or '.
	str = str:gsub("||", " or "):gsub("|", " or ")
	
	-- Replace '!' with ' not '.
	str = str:gsub("!([^=])", " not %1")
	
	-- Condense whitespace.
	str = str:gsub("%s+", " ")
	
	-- Condense parenthetical spaces.
	str = str:gsub("[(][%s+]", "("):gsub("[%s+][)]", ")")

	if not assign then
		-- Replace assignment '=' with conditional '=='
		str = str:gsub("=", "==")
		
		-- Fix any conditional '==' that got impacted by previous.
		str = str:gsub("==+", "==")
		str = str:gsub(">=+", ">=")
		str = str:gsub("<=+", "<=")
		str = str:gsub("!=+", "~=")
		str = str:gsub("~=+", "~=")
	end
	
	return ( str )
end


function Hekili:ConvertScript( node, hasModifiers )
	local Translated = SimToLua( node.Script )
	local sFunction, Error
	
	if Translated then
		sFunction, Error = loadstring( 'return ' .. Translated )
	end

	if sFunction then
		setfenv( sFunction, self.State )
	end

	if Error then
		Error = Error:match( ":%d+: (.*)" )
	end

	local sElements = Translated and self:ScriptElements( Translated )
	
	local Output = {
		Conditions	= sFunction,
		Error		= Error,
		Elements	= sElements,
		Modifiers	= {},
		
		Lua			= Translated,
		SimC		= node.Script and trim( node.Script ) or nil
	}
	
	if hasModifiers and ( node.Args and node.Args ~= '' ) then
		local tModifiers	= SimToLua( node.Args, true )
		
		for m in tModifiers:gmatch("[^,|^$]+") do
			local Key, Value = m:match("(.-)=(.-)$")
			
			if Key and Value then
				local sFunction, Error = loadstring( 'return ' .. Value )
				
				if sFunction then
					setfenv( sFunction, self.State )
					Output.Modifiers[ Key ] = sFunction
				end
			end
		end
	end

	return Output
end


function Hekili:StoreValues( tbl, node )

	if not node.Elements then
		return
	end

	for k in pairs( tbl ) do
		tbl[k] = nil
	end
	
	for k, v in pairs( node.Elements ) do
		local success, result = pcall( v )
		
		if success then tbl[k] = result
		elseif type( result ) == 'string' then
			tbl[k] = result:match("lua:%d+: (.*)") or result
		else tbl[k] = 'nil' end
	end
end


function Hekili:LoadScripts()
	self.Scripts = self.Scripts or { D = {}, P = {}, A = {} }

	local Displays, Hooks, Actions = self.Scripts.D, self.Scripts.P, self.Scripts.A
	local Profile = self.DB.profile
	
	for i, _ in ipairs( Displays ) do
		Displays[i] = nil
	end
	
	for k, _ in pairs( Hooks ) do
		Hooks[k] = nil
	end
	
	for k, _ in pairs( Actions ) do
		Actions[k] = nil
	end
	
	for i, display in ipairs( self.DB.profile.displays ) do
		Displays[ i ] = self:ConvertScript( display )
		
		for j, priority in ipairs( display.Queues ) do
			local pKey = i..':'..j
			Hooks[ pKey ] = self:ConvertScript( priority )
		end
	end
	
	for i, list in ipairs( self.DB.profile.actionLists ) do
		for a, action in ipairs( list.Actions ) do
			local aKey = i..':'..a
			Actions[ aKey ] = self:ConvertScript( action, true )
		end
	end
end


function StripScript( str, thorough )
	if not str then return 'true' end
	
	-- Remove the 'return ' that was added during conversion.
	str = str:gsub("^return ", "")
	
	-- Remove comments and parentheses.
	str = str:gsub("%-%-.-\n", ""):gsub("[()]", "")
	
	-- Remove conjunctions.
	str = str:gsub("[%s-]and[%s-]", " "):gsub("[%s-]or[%s-]", " "):gsub("%(-%s-not[%s-]", " ")
	
	if not thorough then
		-- Collapse whitespace around comparison operators.
		str = str:gsub("[%s-]==[%s-]", "=="):gsub("[%s-]>=[%s-]", ">="):gsub("[%s-]<=[%s-]", "<="):gsub("[%s-]~=[%s-]", "~="):gsub("[%s-]<[%s-]", "<"):gsub("[%s-]>[%s-]", ">")
	else
		str = str:gsub("[=+]", " "):gsub("[><~]", " "):gsub("[*//-+]", " ")
	end
	
	-- Collapse the rest of the whitespace.
	str = str:gsub("[%s+]", " ")
	
	return ( str )
end


function Hekili:ScriptElements( script )
	local Elements, Check = {}, StripScript( script, true )
	
	for i in Check:gmatch( "%S+" ) do
		if not Elements[i] and not tonumber(i) then
			local eFunction = loadstring( 'return '.. (i or true) )

			if eFunction then setfenv( eFunction, Hekili.State ) end

			local success, value = pcall( eFunction )
		
			Elements[i] = eFunction
		end
	end
	
	return Elements
end			
	


function Hekili:CheckScript( cat, key, action, override )
	
	if action then self.State.this_action = action end

	local tblScript = self.Scripts[ cat ][ key ]
	
	if not tblScript then
		return false
	
	elseif tblScript.Error then
		return false, tblScript.Error

	elseif tblScript.Conditions == nil then
		return true

	else
		local success, value = pcall( tblScript.Conditions )
	
		if success then
			return value
		end
	end
	
	return false
	
end


function Hekili:GetModifiers( list, entry )

	local mods = {}
	
	if not self.Scripts['A'][list..':'..entry].Modifiers then return mods end
	
	for k,v in pairs( self.Scripts['A'][list..':'..entry].Modifiers ) do
		local success, value = pcall(v)
		if success then mods[k] = value end
	end

	return mods

end
	

	


function H:OnEnable()

	CheckBrokenImports()
	self:RefreshBindings()
	self:BuildUI()

	-- May want to refresh configuration options, key bindings.
	if self.DB.profile.Enabled then
		-- Combat Log (targets, debuffs).
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		
		-- Sanity checks, may want to just get this into the RefreshOptions() from profile handling.
		self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
		
		-- Saving UI positions.
		self:RegisterEvent("PLAYER_LOGOUT")

		-- Grab some player data.
		self:PLAYER_ENTERING_WORLD()
		
		-- Combat time / boss fight status.
		self:RegisterEvent("ENCOUNTER_START")
		self:RegisterEvent("ENCOUNTER_END")
		self:RegisterEvent("PLAYER_REGEN_DISABLED")
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
		
		self:RegisterEvent("PLAYER_TALENT_UPDATE")
		self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
		self:RegisterEvent("GLYPH_ADDED")
		self:RegisterEvent("GLYPH_REMOVED")
		self:RegisterEvent("GLYPH_UPDATED")

		-- Trigger additional refreshes and cache the last spell cast.
		self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

		-- Mainly for capturing changes to cooldowns from trinkets.
		self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")

		-- Trackers
		self:RegisterEvent("PLAYER_TARGET_CHANGED")

		-- Keybinding w/in Hekili options.
		self:RegisterEvent("UPDATE_BINDINGS")

		-- Time to die.
		self:RegisterEvent("UNIT_HEALTH")

		if self.MSQ and self.msqGroup then
			self.msqGroup:ReSkin()
		end
		
		for i = 1, #self.DB.profile.displays do
			self:ProcessHooks( i )
		end
		
		self:UpdateDisplays()
		self:Audit()
	
	else
		self:Disable()

	end
	
end


function H:OnDisable()
	self.DB.profile.Enabled = false
end


-- Texture Caching, 
local s_textures = setmetatable( {},
	{
		__index = function(t, k)
			local a = _G[ 'GetSpellTexture' ](k)
			if a then t[k] = a end
			return (a)
		end
	} )

-- Insert textures that don't work well with predictions.@
s_textures[GetSpellInfo(115356)]	= 'Interface\\Icons\\ability_skyreach_four_wind'	-- Windstrike
s_textures[GetSpellInfo(114074)]	= 'Interface\\Icons\\Spell_Fire_SoulBurn'			-- Lava Beam
s_textures[GetSpellInfo(421)]		= 'Interface\\Icons\\Spell_Nature_ChainLightning'	-- Chain Lightning
	
local function GetSpellTexture( spell )
	return ( s_textures[ spell ] )
end


local z_PVP = {
	arena = true,
	pvp = true
}


function Hekili:ResetState()
	
	local s = self.State
	
	s.now = GetTime()
	s.offset = 0
	s.false_start = 0
	s.cast_start = 0
	
	-- A decent start, but assumes our first ability is always aggressive.  Not necessarily true...
	if self.Class == 'WARRIOR' then
		s.nextMH = ( self.combat ~= 0 and self.Swing.nextMH > self.State.now ) and self.Swing.nextMH or -1
		s.nextOH = ( self.combat ~= 0 and self.Swing.nextOH > self.State.now ) and self.Swing.nextOH or -1
	end
	
	-- broke fullscan for now.  :(
	for k in pairs( s.buff ) do
		if H.Auras[ k ].id < 0 then
			s.buff[ k ].name = nil
		end
		s.buff[ k ].caster = nil
		s.buff[ k ].count = nil
		s.buff[ k ].expires = nil
		s.buff[ k ].applied = nil
	end

	for k in pairs( s.cooldown ) do
		s.cooldown[ k ].duration = nil
		s.cooldown[ k ].expires = nil
	end
	
	for k in pairs( s.debuff ) do
		s.debuff[ k ].count = nil
		s.debuff[ k ].expires = nil
	end
	
	-- s.dot currently just wraps s.debuff
	
	for k in pairs( s.pet ) do
		s.pet[ k ].expires = nil
	end

	for k in pairs( s.seal ) do
		s.seal[ k ] = nil
	end
	
	for k in pairs( s.totem ) do
		s.totem[ k ].expires = nil
	end
	
	s.target.health.current = nil
	s.target.health.max = nil
	
	-- range checks
	s.target.minR = nil
	s.target.maxR = nil
	
	-- interrupts
	s.target.casting = nil
	
	for k,_ in pairs( H.Resources ) do
		local key = GetResourceName( k )
		
		s[ key ] = rawget( s, key ) or setmetatable( {}, mt_resource )
		s[ key ].current = UnitPower( 'player', k )
		s[ key ].max = UnitPowerMax( 'player', k )
		
		if k == UnitPowerType('player') then
			local active, inactive = GetPowerRegen()
			
			if s.time > 0 then
				s[ key ].regen = active
			else
				s[ key ].regen = inactive
			end
		end
	end
	
	s.health = rawget( s, 'health' ) or setmetatable( {}, mt_resource )
	s.health.current = UnitHealth( 'player' )
	s.health.max = UnitHealthMax( 'player' )
	
	-- Special case spells that suck.
	if Hekili.Abilities[ 'ascendance' ] and s.buff.ascendance.up then
		H:SetCooldown( 'ascendance', s.buff.ascendance.remains + 165 )
	end
	
	local cast_time, casting = 0, nil

	local spellcast, _, _, _, startCast, endCast = UnitCastingInfo('player')
	if endCast ~= nil then
		s.cast_start = startCast / 1000
		cast_time = ( endCast / 1000 ) - GetTime()
		casting = FormatKey( spellcast )
	end
	
	local spellcast, _, _, _, startCast, endCast = UnitChannelInfo('player')
	if endCast ~= nil then
		s.cast_start = startCast / 1000
		cast_time = ( endCast / 1000) - GetTime()
		casting = FormatKey( spellcast )
	end				

	if cast_time and casting then
		self:Advance( cast_time )
		if self.Abilities[ casting ] then
			self.State.cooldown[ casting ].expires = self.State.now + self.State.offset + self.Abilities[ casting ].cooldown
		end
		RunHandler( casting )
	end
	
	-- Delay to end of GCD.
	if self.State.cooldown[ self.GCD ].remains > 0 then
		self:Advance( self.State.cooldown[ self.GCD ].remains )
	end

end


function H:Advance( time )
	
	local s = self.State
	
	if time <= 0 then
		return
	end
	
	s.offset = s.offset + time
	
	for k,_ in pairs( self.Resources ) do
		local resKey = GetResourceName( k )
		local resource = self.State[ resKey ]

		if resKey == 'rage' and s.target.within5 then
			local MH, OH = UnitAttackSpeed( 'player' )

			while ( MH and s.nextMH > 0 and s.nextMH < s.now + s.offset ) do
				local gain = floor( 35 * s.mainhand_speed ) / 10
				if self.Specialization == 71 then gain = gain * 2 end
				
				resource.current = min( resource.max, resource.current + gain )
				
				s.nextMH = s.nextMH + MH
			end
			
			while ( OH and s.nextOH > 0 and s.nextOH < s.now + s.offset ) do
				local gain = floor( 35 * s.offhand_speed * 0.5 ) / 10
				
				resource.current = min( resource.max, resource.current + gain )

				s.nextOH = s.nextOH + OH
			end
		
		elseif resource.regen and resource.regen ~= 0 then
			resource.current = min( resource.max, resource.current + ( resource.regen * time ) )
		end
	end

end


function HasRequiredResources( ability )

	local s, action = H.State, H.Abilities[ ability ]
	
	if not action then return end
	
	-- First, spend resources.
	if action.spend then
		local spend, resource
		
		if type( action.spend ) == 'number' then
			spend = action.spend
			resource = action.spend_type or Hekili.ClassResource
		elseif type( action.spend ) == 'function' then
			spend, resource = action.spend( s )
		end

		local resKey = GetResourceName( resource )
		
		if spend > 0 and spend < 1 then
			spend = ( spend * s[ resKey ].max )
		end
		
		return ( s[ resKey ].current >= spend )
	end
	
	return true
	
end
Hekili.HRR = HasRequiredResources
	

function H:UpdateResources( ability )

	local action = H.Abilities[ ability ]
	
	if not action then return end

	local s = self.State
	
	-- First, spend resources.
	if action.spend then
		local spend, resource
		
		if type( action.spend ) == 'number' then
			spend = action.spend
			resource = action.spend_type or Hekili.ClassResource
		elseif type( action.spend ) == 'function' then
			spend, resource = action.spend( s )
		end

		local resKey = GetResourceName( resource )
		
		if spend > 0 and spend < 1 then
			spend = ( spend * self.State[ resKey ].max )
		end
		
		self.State[ resKey ].current = min( max(0, self.State[ resKey ].current - spend ), self.State[ resKey ].max )
	end
	
	-- Now, gain resources.
	if action.gain then
		local gain, resource
		
		if type( action.gain ) == 'number' then
			gain = action.gain
			resource = action.gain_type or Hekili.ClassResource
		elseif type( action.gain ) == 'function' then
			gain, resource = action.gain( s )
		end

		local resKey = GetResourceName( resource )
		
		if gain > 0 and gain < 1 then
			gain = ( gain * self.State[ resKey ].max )
		end

		self.State[ resKey ].current = min( max(0, self.State[ resKey ].current + gain ), self.State[ resKey ].max )
	end
	
end


function Hekili.IsKnown( sID )

	if type(sID) ~= 'number' then sID = H.Abilities[ sID ].id end
	if not sID or sID < 0 then return false end
	
	local ability = H.Abilities[ sID ]
	local s = Hekili.State
	
	if ability.known then
		if type( ability.known ) == 'number' then
			return IsSpellKnown( ability.known )
		else
			return ability.known( s )
		end
	end
	
	return ( IsSpellKnown( sID ) or IsSpellKnown( sID, true ) )

end
local IsKnown = Hekili.IsKnown


-- Filter out non-resource driven issues with abilities.
function Hekili.IsUsable( spell )

	local ability = H.Abilities[ spell ]
	local s = Hekili.State
	
	if ability.usable then
		if type( ability.usable ) == 'number' then return IsUsableSpell( ability.usable )
		elseif type( ability.usable ) == 'function' then return ability.usable( s ) end
	end
	
	return true
	
end
local IsUsable = Hekili.IsUsable
	

-- Needs to be expanded to handle energy regen before Rogue, Monk, Druid will work.
function WaitTime( action )
	-- Do a basic check before 
	local delay = Hekili.State.cooldown[ action ].remains

	if action == 'ascendance' then
		if Hekili.State.buff.ascendance.up then
			delay = 180 - ( 15 - Hekili.State.buff.ascendance.remains )
		end
	end
	
	return max( delay, Hekili.State.cooldown[ Hekili.GCD ].remains ) 
end


function ImplantDebugData( queue )
	if queue.display and queue.hook then
		local scrHook = Hekili.Scripts.P[ queue.display..':'..queue.hook ]
		queue.HookScript = scrHook.SimC
		queue.HookElements = queue.HookElements or {}
		Hekili:StoreValues( queue.HookElements, scrHook )
	end
	
	if queue.actionlist and queue.action then
		local scrAction = Hekili.Scripts.A[ queue.actionlist..':'..queue.action ]
		queue.ActScript = scrAction.SimC
		queue.ActElements = queue.ActElements or {}
		Hekili:StoreValues( queue.ActElements, scrAction )
	end
end							


Hekili.Queue = {}

function Hekili:ProcessHooks( dispID )

	if not self.DB.profile.Enabled then
		return
	end

	if not self.Pause then
		local s = self.State
		local display = self.DB.profile.displays[ dispID ]

		self.Queue[ dispID ] = self.Queue[ dispID ] or {}
		local Queue = self.Queue[ dispID ]
		
		if display and self.DisplayVisible[ dispID ] then
		
			self:ResetState()
			
			if ( self.Config or self:CheckScript( 'D', dispID )  ) then 

				for i = 1, display['Icons Shown'] do

					local chosen_action, chosen_caption
					local chosen_wait   = 999
					
					Queue[i] = Queue[i] or {}
					
					for k in pairs( Queue[ i ] ) do
						if type( Queue[ i ][ k ] ) ~= 'table' then
							Queue[ i ][ k ] = nil
						end
					end
					
					for hookID, hook in ipairs( display.Queues ) do
					
						if self.HookVisible[ dispID..':'..hookID ] then
						
							local HookPassed = self:CheckScript( 'P', dispID..':'..hookID )
							
							if HookPassed then
							
								local listID = hook[ 'Action List' ]
								local list = self.DB.profile.actionLists[ listID ]
								
								-- Only action list criteria is whether it matches the spec.
								if self.ListVisible[ listID ] then

									local actID = 1
									while actID <= #list.Actions do
										if chosen_wait == 0 then
											break
										end
										
										local entry	= list.Actions[ actID ]
										s.this_action	= entry.Ability
										local wait_time = WaitTime( s.this_action )
										
										if self.ActionVisible[ listID..':'..actID ] then
											-- Check for commands before checking actual actions.
											
											if entry.Ability == 'wait' then
												if self:CheckScript( 'A', listID..':'..actID ) then
													local args = self:GetModifiers( listID, actID )
													if not args.sec then args.sec = 1 end
													if args.sec > 0 then
														self:Advance( args.sec )
														actID = 0
													end

												end
											
											elseif IsKnown( s.this_action ) and IsUsable( s.this_action ) and wait_time < chosen_wait and HasRequiredResources( s.this_action ) and ( self.Abilities[ s.this_action ].cast == 0 or self.DB.profile.Hardcasts ) and self:CheckScript( 'A', listID..':'..actID ) then
												chosen_action	= s.this_action
												chosen_caption	= entry.Caption
												chosen_wait		= wait_time

												Queue[i].display		= dispID
												Queue[i].button		= i
													
												Queue[i].hook			= hookID
													
												Queue[i].actionlist	= listID
												Queue[i].action		= actID
													
												Queue[i].alName		= list.Name
												Queue[i].actName		= s.this_action
													
												Queue[i].caption		= chosen_caption
												Queue[i].wait			= wait_time
												
											end
										
										end
										
										actID = actID + 1
									
									end
									
								end -- end Action List

							end
							
						end 
						
					end -- end Hook
					
					if chosen_action then
						-- We have our actual action, so let's get the script values if we're debugging.
						if self.DB.profile.Debug then
							ImplantDebugData( Queue[i] )
						end
					
						-- Advance through the wait time.
						self:Advance( chosen_wait )
							
						Queue[i].time	= s.offset
						Queue[i].since = i > 1 and ( s.offset - Queue[i - 1].time ) or 0
					
						local action = self.Abilities[ chosen_action ]

						-- We really need to make the timing more sophisticated.
						-- Need to differentiate between abilities being hardcast, abilities off GCD, and GCD instants.
						local gcd = 0
						
						if action.gcdType == 'totem' then
							gcd = 1.0
						elseif action.gcdType == 'spell' then
							gcd = max( 1.0, ( 1.5 * s.spell_haste ) )
						elseif action.gcdType == 'melee' then
							gcd = max( 1.0, ( 1.5 * s.melee_haste ) )
						end
						
						-- Start the GCD.
						s.cooldown[ self.GCD ].expires = s.now + s.offset + gcd
						
						-- Advance the clock by cast_time.
						self:Advance( action.cast )
						
						-- Put the action on cooldown.  (It's slightly premature, but addresses CD resets like Echo of the Elements.)
						s.cooldown[ chosen_action ].expires = s.now + s.offset + action.cooldown
						
						-- Perform the action.
						RunHandler( chosen_action )
						
						-- Spend/gain resources.
						self:UpdateResources( chosen_action )

						-- Move the clock forward if the GCD hasn't expired.
						if s.cooldown[ self.GCD ].expires > s.now + s.offset then
							self:Advance( s.cooldown[ self.GCD ].expires - ( s.now + s.offset ) )
						end

						
					else
						for n = i, display['Icons Shown'] do
							Queue[n] = nil
						end
						break
					end
					
				end
				
			end			
		
		end

	end

	C_Timer.After( 1 / self.DB.profile['Updates Per Second'], self[ 'ProcessDisplay'..dispID ] )
	
end



local pvpZones = {
	arena	= true,
	pvp		= true
}


function CheckDisplayCriteria( dispID )

	local display = Hekili.DB.profile.displays[ dispID ]
	local _, zoneType = IsInInstance()
	
	if not Hekili.DisplayVisible[ dispID ] then
		return false
		
	elseif not pvpZones[ zoneType ] and display['PvE Visibility'] ~= 'always' then
		if display['PvE Visibility'] == 'combat' and ( not UnitAffectingCombat('player') and not UnitCanAttack('player', 'target') ) then
			return false
			
		elseif display['PvE Visibility'] == 'target' and not UnitCanAttack('player', 'target') then
			return false
			
		elseif display['PvE Visibility'] == 'zzz' and not pvpZones[ zoneType ] then
			return false
			
		end
	
	elseif pvpZones[ zoneType ] and display['PvP Visibility'] ~= 'always' then
		if display['PvP Visibility'] == 'combat' and ( not UnitAffectingCombat('player') and not UnitCanAttack('player', 'target') ) then
			return false
			
		elseif display['PvP Visibility'] == 'target' and not UnitCanAttack('player', 'target') then
			return false
		
		elseif display['PvP Visibility'] == 'zzz' then
			return false
			
		end
		
	elseif not Hekili.Config and not Hekili.Queue[ dispID ] then
		return false
		
	end
	
	return true

end



function H:UpdateDisplays()

	local self = self or Hekili

	if not self.DB.profile.Enabled then
		return
	end

	for dispID, display in pairs(self.DB.profile.displays) do

		if self.Pause then
			self.UI.Buttons[ dispID ][1].Overlay:SetTexture('Interface\\Addons\\Hekili\\Textures\\Pause.blp')
			self.UI.Buttons[ dispID ][1].Overlay:Show()

		else
			self.UI.Buttons[ dispID ][1].Overlay:Hide()
		
			if CheckDisplayCriteria( dispID ) then
				local Queue = self.Queue[ dispID ]

				local gcd_start, gcd_duration = GetSpellCooldown( self.Abilities[ self.GCD ].id )
				
				for i, button in ipairs( self.UI.Buttons[dispID] ) do
					if not Queue or not Queue[i] and ( self.DB.profile.Enabled or self.Config ) then
						for n = i, display['Icons Shown'] do
							self.UI.Buttons[dispID][n].Texture:SetTexture( 'Interface\\ICONS\\Spell_Nature_BloodLust' )
							self.UI.Buttons[dispID][n].Texture:SetVertexColor(1, 1, 1)
							self.UI.Buttons[dispID][n].Caption:SetText(nil)
							if not self.Config then
								self.UI.Buttons[dispID][n]:Hide()
							else
								self.UI.Buttons[dispID][n]:Show()
							end
						end
						break
					end
					
					local aKey, caption = Queue[i].actName, Queue[i].caption
				
					if aKey then
						button:Show()
						button.Texture:SetTexture( GetSpellTexture( self.Abilities[ aKey ].name ) )
						button.Texture:Show()
						
						if display['Action Captions'] then
							if i == 1 then
								button.Caption:SetJustifyH('RIGHT')
								-- check for special captions.
								if display['Primary Caption'] == 'targets' and self:NumTargets() > 1 then
									button.Caption:SetText( self:NumTargets() )

								elseif display['Primary Caption'] == 'buff' then
									if display['Primary Caption Aura'] then
										local name, _, _, count, _, _, expires = UnitBuff( 'player', display['Primary Caption Aura'] )
										if name then button.Caption:SetText( count or 1 )
										else
											button.Caption:SetJustifyH('CENTER')
											button.Caption:SetText(caption)
										end
									end

								elseif display['Primary Caption'] == 'debuff' then
									if display['Primary Caption Aura'] then
										local name, _, _, count = UnitDebuff( 'target', display['Primary Caption Aura'] )
										if name then button.Caption:SetText( count or 1 )
										else
											button.Caption:SetJustifyH('CENTER')
											button.Caption:SetText(caption)
										end
									end

								elseif display['Primary Caption'] == 'ratio' then
									if display['Primary Caption Aura'] then
										if H:DebuffCount( display['Primary Caption Aura'] ) > 0 or H:NumTargets() > 1 then
											button.Caption:SetText( H:DebuffCount( display['Primary Caption Aura'] ) .. ' / ' .. H:NumTargets() )
										else
											button.Caption:SetJustifyH('CENTER')
											button.Caption:SetText(caption)
										end
									end

								else
									button.Caption:SetJustifyH('CENTER')
									button.Caption:SetText(caption)
									
								end
							else
								button.Caption:SetJustifyH('CENTER')
								button.Caption:SetText(caption)
							
							end
						else
							button.Caption:SetJustifyH('CENTER')
							button.Caption:SetText(nil)

						end
						
						local start, duration = GetSpellCooldown( self.Abilities[ aKey ].id )
						
						if H.Abilities[ aKey ].gcdType ~= 'off' and ( not start or start == 0 or ( start + duration ) < ( gcd_start + gcd_duration ) ) then
							start		= gcd_start
							duration	= gcd_duration
						end
						
						if i == 1 then
							button.Cooldown:SetCooldown( start, duration )
							
						else
							if ( start + duration ~= gcd_start + gcd_duration ) then
								button.Cooldown:SetCooldown( start, duration )
							else
								button.Cooldown:SetCooldown( 0, 0 )
							end
						end

						if SpellRange.IsSpellInRange( self.Abilities[ aKey ].name, 'target') == 0 then
							self.UI.Buttons[dispID][i].Texture:SetVertexColor(1, 0, 0)
						elseif i == 1 and select(2, IsUsableSpell( self.Abilities[ aKey ].name )) then
							self.UI.Buttons[dispID][i].Texture:SetVertexColor(0.4, 0.4, 0.4)
						else
							self.UI.Buttons[dispID][i].Texture:SetVertexColor(1, 1, 1)
						end
						

					else
						self.UI.Buttons[dispID][i].Texture:SetTexture( nil )
						self.UI.Buttons[dispID][i].Cooldown:SetCooldown( 0, 0 )
						self.UI.Buttons[dispID][i]:Hide()
					
					end

				end
				
			else
				for i, button in ipairs(self.UI.Buttons[dispID]) do
					button:Hide()
					
				end
			end
		end
	end
	
	C_Timer.After( 1 / self.DB.profile['Updates Per Second'], self.UpdateDisplays )
	
end


