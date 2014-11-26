-- Targets.lua
-- June 2014


local H = Hekili

-- Table to collect enemies that are damaged or debuffed by us or our minions.
local tCount = 0
local targets = {}

Hekili.Targets = targets

function H:UpdateTarget( id, time )

	if time then
		
		if not targets[id] then
			tCount = tCount + 1
		end
		targets[id]	= time
	
	else
		if targets[id] then
			tCount = max(0, tCount - 1)
			targets[id] = nil
		end
	end
end


function H:NumTargets()
	return tCount
end


function H:KnownTarget( id )
	return self.Targets[ id ] ~= nil
end


-- MINIONS
local minions = {}


function H:UpdateMinion( id, time )
	minions[id]	= time
end


function H:IsMinion( id )
	return ( minions[id] ~= nil )
end


-- DEBUFFS (was AURAS)
local dbCount		= {}
local debuffs		= {}
local dbPower		= {}


function H:WipeDebuffs()
	for k,_ in pairs( debuffs ) do
		table.wipe( debuffs[k] )
	end
end


function H:TrackDebuff( spell, target, time, new )

	debuffs[ spell ] = debuffs[ spell ] or {}
	dbCount[ spell ] = dbCount[ spell ] or 0
	
	if not time then
		if debuffs[ spell ][ target ] then
			-- Remove it.
			debuffs[ spell ][ target ]	= nil
			dbCount[ spell ] = max(0, dbCount[ spell ] - 1)
		end
		
	else
		if not debuffs[ spell ][ target ] then
			debuffs[ spell ][ target ]	= {}
			dbCount[ spell ] = dbCount[ spell ] + 1
		end

		local debuff = debuffs[ spell ][ target ]
		debuff.last_seen = time
	
		if new then
			debuff.applied = time
			if dbPower[ spell ] then
				debuff.modifier, debuff.tick_dmg, debuff.ticks_remain,
				debuff.spell_power, debuff.attack_power, debuff.multiplier,
				debuff.haste_pct, debuff.crit_pct, debuff.crit_dmg, debuff.num_ticks = dbPower[ spell ].handler()
			end
		end
	end

end


function H:DebuffCount( spell )
	-- v1 would manually count table entries.  I don't think we need to.
	if debuffs[ spell ] then
		return ( dbCount[ spell ] or 0 )
	end
	
	return 0
end


function H:IsDebuffWatched( spell )
	return ( debuffs[ spell ] ~= nil )
end


function H:WatchDoT( dot, func, tick, duration )
	if debuff and func then
		dbPower[ dot ] = {
			tick		= tick or 0,
			duration	= duration or 0,
			handler		= func
		}
		setfenv( dbPower[dot].handler, self.State )
	end
end

function H:IsDoTWatched( dot )
	return ( dbPower[ dot ] ~= nil )
end


function H:GetWatchedDoT( dot )
	return ( dbPower[ dot ] )
end


function H:Eliminate( id )
	self:UpdateMinion( id )
	self:UpdateTarget( id )
	
	self.TTD[ id ] = nil
	
	for k,v in pairs( debuffs ) do
		self:TrackDebuff( k, id )
	end
end


-- Remove debuffs or 
function Hekili:Audit()
	local self = self or Hekili
	
	local now			= GetTime()
	local grace_period	= self.DB.profile['Audit Targets']
	
	for aura, targets in pairs( debuffs ) do
		for unit, aura_info in pairs( targets ) do
			-- NYI: Check for dot vs. debuff, since debuffs won't 'tick'
			if now - aura_info.last_seen > grace_period then
				self:TrackDebuff( aura, unit )
			end
		end
	end
	
	for whom, when in pairs( targets ) do
		if now - when > grace_period then
			self:UpdateTarget( whom )
			self.TTD[ whom ] = nil
		end
	end
	
	if self.DB.profile.Enabled then
		C_Timer.After( 1, self.Audit )
	end
	
end
