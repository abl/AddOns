-- Classes.lua
-- July 2014

-- Basically, all the setup or shared attributes can stay in this file.  Anything class-specific should get moved to Classes\<classname>.lua.


local H = Hekili
local GetResourceName = H.Utils.GetResourceName


-- Metatable to return modified information about an ability, if available.
local mt_modifiers = {
	__index = function(t, k)
		if not t.mods[ k ] then
			return t.elem[ k ]
		else
			return t.mods[ k ] ( t.elem[ k ] )
		end
	end
}


-- New model requires splitting spells into categories.
H.Abilities		= {}
H.Auras			= {}
H.Glyphs		= {}
H.Talents		= {}


H.Keys			= setmetatable( {}, {
	__newindex = function(t, k, v)
		for i = 1, #t do
			if t[i] == v then return t[i] end
		end
		rawset(t, k, v)
	end
} )



function Hekili.Utils.AddAbility( key, ... )
	
	local num = select( "#", ... )
	
	if num < 2 then return end
	
	local id, values = select( 1, ...), select( num, ... )
	values.id = id
	
	local name = GetSpellInfo( id )
	if not name and id > 0 then return end
	
	H.Abilities[ key ] = setmetatable( {
		name	= name,
		elem	= {}, -- storage for each attribute
		mods	= {}  -- storage for attribute modifiers
	}, mt_modifiers )
	
	for i = 1, num - 1 do
		H.Abilities[ select( i, ... ) ] = H.Abilities[ key ]
	end
	
	H.Keys = H.Keys or {}
	H.Keys[ #H.Keys+1 ] = key
	
	AbilityElements( key, values )
	
end
local AddAbility = Hekili.Utils.AddAbility

	
function AbilityElements( key, values )
	local ability = H.Abilities[ key ]
	
	if not ability then return end
	
	for k,v in pairs( values ) do
		ability.elem[k] = v
		--[[  if k == 'id' then ability[k] = v
		else ability.elem[k] = v end ]]
	end

end


-- Modify
-- If 'value' is a function, it will be used as a modifier.
-- If 'value' is a raw value, it will replace the base element.
function Modify( tab, key, elem, value )
	local entry = H[tab][key]
	if not entry then return end
	
	if type( value ) == 'function' then
		entry.mods[elem] = setfenv( value, Hekili.State )
	else
		entry.elem[elem] = value
	end
end


-- Wrapper for the ability table.
function Hekili.Utils.ModifyAbility( key, elem, value )
	Modify( 'Abilities', key, elem, value )
end


H.Perks = {}
function Hekili.Utils.AddPerk( key, id )
	local name = GetSpellInfo(id)
	
	if name then
		H.Perks[ key ] = {
			id = id,
			key = key,
			name = name
		}
	end
	
	H.Keys[ #H.Keys + 1 ] = key
end
			


function Hekili.Utils.AuraElements( key, ... )
	local args, aura = { ... }, H.Auras[ key ]
	
	if not aura then return end
	
	for i = 1, #args, 2 do
		local k, v = args[i], args[i+1]
		
		if k and v then
			if k == 'id' then aura[k] = v
			else aura.elem[k] = v end
		end
	end

end
local AuraElements = Hekili.Utils.AuraElements


function Hekili.Utils.AddAura( key, id, ... )
	local name = id > 0 and GetSpellInfo( id ) or nil
	
	H.Auras[ key ] = setmetatable( {
		id		= id,
		key		= key,
		name	= name,
		elem	= {},
		mods	= {}
	}, mt_modifiers )
	
	H.Keys = H.Keys or {}
	H.Keys[ #H.Keys+1 ] = key

	-- Allow reference by ID as well.
	H.Auras[ id ] = H.Auras[ key ]
	
	-- Add the elements, front-loading defaults and just overriding them if something else is specified.
	AuraElements( key, 'duration', 30, 'max_stacks', 1, ... )
	
end
local AddAura = Hekili.Utils.AddAura


function Hekili.Utils.ModifyAura( key, elem, func )
	Modify( 'Auras', key, elem, func )
end


function Hekili.Utils.AddTalent( key, id )
	local name = GetSpellInfo( id )
	
	if not name then return end

	H.Talents[ key ] = {
		id		= id,
		name	= name
	}
	
	H.Keys = H.Keys or {}
	H.Keys[ #H.Keys+1 ] = key

end


function Hekili.Utils.AddGlyph( key, id )
	local name = GetSpellInfo( id )
	
	if not name then return end

	H.Glyphs[ key ] = {
		id		= id,
		name	= name
	}

	H.Keys = H.Keys or {}
	H.Keys[ #H.Keys+1 ] = key

end


H.Resources		= {}
function Hekili.Utils.AddResource( resource, primary )

	H.Resources[ resource ] = true
	
	if primary or not Hekili.ClassResource then Hekili.ClassResource = resource end

	H.Keys = H.Keys or {}
	H.Keys[ #H.Keys+1 ] = GetResourceName( resource )
	
end


H.Gear			= {}
function Hekili.Utils.AddItemSet( name, ... )

	local arg = { ... }

	H.Gear[ name ] = H.Gear[ name ] or {}
	
	for i,v in ipairs(arg) do
		H.Gear[ name ][v] = 1
	end
	
	H.Keys = H.Keys or {}
	H.Keys[ #H.Keys+1 ] = name

end
local AddItemSet = Hekili.Utils.AddItemSet


H.MetaGem		= {}
function AddMeta( ... )

	for i,v in ipairs( ... ) do
		H.MetaGem[ v ] = 1
	end

end
H.Utils.AddMeta = AddMeta


function Hekili.Utils.SetGCD( key )

	H.GCD = key

end


function AddHandler( ability, f )
	local ab = Hekili.Abilities[ ability ]
	
	if not ab then return end
	
	ab.elem[ 'handler' ] = setfenv( f, Hekili.State )
end
H.Utils.AddHandler = AddHandler


function RunHandler( ability )
	local ab = H.Abilities[ ability ]
	
	if not ab then return end
	
	if ab.elem[ 'handler' ] then
		ab.elem[ 'handler' ] ()
	end
	
	if ab.hostile and H.combat == 0 then
		Hekili.State.false_start = Hekili.State.now + Hekili.State.offset
	end
	
	Hekili.State.cast_start = 0
	
	if select(2, UnitClass( 'PLAYER' ) ) == 'WARRIOR' and ( not ab.elem.passive ) and s.nextMH < 0 then
		local s = Hekili.State
		s.nextMH = s.now + s.offset - 0.01
		s.nextOH = s.now + s.offset + 0.99
	end
	
end
H.Utils.RunHandler = RunHandler


H.Stances = {}
function H.Utils.AddStance( key, index, id )
	H.Stances[ key ] = index
end


------------------------------
-- SHARED SPELLS/BUFFS/ETC. --
------------------------------

-- Bloodlust.
AddAura( 'ancient_hysteria', 90355, 'duration', 40 )
AddAura( 'bloodlust', 2825 , 'duration', 40 )
AddAura( 'heroism', 32182, 'duration', 40 )
AddAura( 'time_warp', 80353, 'duration', 40 )

-- Sated.
AddAura( 'exhaustion', 57723, 'duration', 600 )
AddAura( 'insanity', 95809, 'duration', 600 )
AddAura( 'sated', 57724, 'duration', 600 )
AddAura( 'temporal_displacement', 80354, 'duration', 600 )

-- Enchants.
AddAura( 'dancing_steel', 104434, 'duration', 12, 'max_stacks', 2 )

-- Potions.
AddAura( 'jade_serpent_potion', 105702, 'duration', 25 )
AddAura( 'mogu_power_potion', 105706, 'duration', 25 )
AddAura( 'virmens_bite_potion', 105697, 'duration', 25 )

-- Trinkets.
AddAura( 'dextrous', 146308, 'duration', 20 )
AddAura( 'vicious', 148903, 'duration', 10 )


-- Raid Buffs
AddAura( 'attack_power_multiplier', -3, 'duration', 3600 )
AddAura( 'critical_strike', -6, 'duration', 3600 )
AddAura( 'haste', -4, 'duration', 3600 )
AddAura( 'mastery', -7, 'duration', 3600 )
AddAura( 'multistrike', -8, 'duration', 3600 )
AddAura( 'spell_power_multiplier', -5, 'duration', 3600 )
AddAura( 'stamina', -2, 'duration', 3600 )
AddAura( 'str_agi_int', -1, 'duration', 3600 )
AddAura( 'versatility', -9, 'duration', 3600 )


-- Meta Gems (for crit dmg bonus)
AddItemSet( 'crit_bonus_meta', 76885, 76888, 76886, 76884 )


-- Racials.
-- AddSpell( 26297,	"berserking",	10 )
AddAbility( 'berserking', 26297,
			{
				spend = 0,
				cast = 0,
				gcdType = 'off',
				cooldown = 180
			} )

AddHandler( 'berserking', function ()
	H:Buff( 'berserking' )
end )

AddAura( 'berserking', 26297, 'duration', 10 )


-- AddSpell( 20572,	"blood_fury",	15 )
AddAbility( 'blood_fury', 20572,
			{
				spend = 0,
				cast = 0,
				gcdType = 'off',
				cooldown = 120
			} )
			
AddHandler( 'blood_fury', function ()
	H:Buff( 'blood_fury', 15 )
end )

AddAura( 'blood_fury', 20572, 'duration', 15 )


-- Special Instructions
AddAbility( 'wait', -1,
			{
				spend = 0,
				cast = 0,
				gcdType = 'off',
				cooldown = 0
			} )
H.Abilities[ 'wait' ].name = 'Wait'










Hekili.Defaults = {}

function Hekili.Default( name, category, version, import )
	
	if not ( name and category and version and import ) then
		return
	end
	
	Hekili.Defaults[ #Hekili.Defaults + 1 ] = {
		name	= name,
		type	= category,
		version = version,
		import	= import:gsub("([^|])|([^|])", "%1||%2")
	}
end


-- Restores the defaults if they're not present.
function Hekili:RestoreDefaults( category )

	if not category or category == 'actionLists' then
		for i = 1, #self.Defaults do
			local proto = self.Defaults[i]
			
			if proto.type == 'actionLists' then
				local found = false
				for j = 1, #self.DB.profile.actionLists do
					if self.DB.profile.actionLists[j].Name == proto.name then
						found = true
						break
					end
				end
				
				if not found then
					local import = Hekili:DeserializeActionList( proto.import )
					index = #self.DB.profile.actionLists + 1
					if import and type( import ) == 'table' then
						self.DB.profile.actionLists[ index ] = import
						self.DB.profile.actionLists[ index ].Name = proto.name
						self.DB.profile.actionLists[ index ].Release = proto.version
					else
						Hekili:Print("Error importing " .. proto.name .. ".")
					end
				end
			end
		
		end
	end
	
	-- Only rebuild displays if there are 0.
	if ( #self.DB.profile.displays == 0 and not category ) or category == 'displays' then
		for i = 1, #self.Defaults do
			local proto = self.Defaults[i]
			
			if proto.type == 'displays' then
				local found = false
				for j = 1, #self.DB.profile.displays do
					if self.DB.profile.displays[j].Name == proto.name then
						found = true
						break
					end
				end
				
				if not found then
					local import = Hekili:DeserializeDisplay( proto.import )
					index = #self.DB.profile.displays + 1
					
					if import and type( import ) == 'table' then
						self.DB.profile.displays[ index ] = import
						self.DB.profile.displays[ index ].Name = proto.name
						self.DB.profile.displays[ index ].Release = proto.version
					
						for j, prio in ipairs( self.DB.profile.displays[ index ].Queues ) do
							if type( prio['Action List'] ) == 'string' then
								for k, list in ipairs( self.DB.profile.actionLists ) do
									if list.Name == prio['Action List'] then
										prio['Action List'] = k
										break
									end
								end
								if type( prio['Action List'] ) == 'string' then
									-- The list wasn't found.
									prio['Action List'] = 0
								end
							end
						end
					else
						Hekili:Print("Error importing " .. proto.name .. ".")
					end
				end
			end
		end
	end
	
	self:RefreshOptions()
	self:LoadScripts()
	
end


-- Loads the default action lists if they're not present.
function Hekili:IsDefault( name, category )

	if not name or not category then
		return nil
	end
	
	for i, default in ipairs( self.Defaults ) do
		if default.type == category and default.name == name then
			return true, i
		end
	end
	
	return false
end