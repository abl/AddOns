-- Constants.lua
-- June 2014

local H	= Hekili
local HU	= Hekili.Utils

-- Adding this to the globals, since it's a possible return value from GetSpellInfo() regarding power costs.
if not SPELL_POWER_HEALTH then SPELL_POWER_HEALTH = -2 end

local resource_t = {
	[SPELL_POWER_HEALTH]			= "health",
	[SPELL_POWER_MANA]				= "mana",
	[SPELL_POWER_RAGE]				= "rage",
	[4]								= "combo_points", -- 4
	[SPELL_POWER_FOCUS]				= "focus",
	[SPELL_POWER_ENERGY]			= "energy",
	[SPELL_POWER_RUNES]				= "runes",
	[SPELL_POWER_RUNIC_POWER]		= "runic_power",
	[SPELL_POWER_SOUL_SHARDS]		= "soul_shards",
	[SPELL_POWER_ECLIPSE]			= "eclipse",
	[SPELL_POWER_HOLY_POWER]		= "holy_power",
	[SPELL_POWER_ALTERNATE_POWER]	= "alternate_power",
	[SPELL_POWER_CHI]				= "chi",
	[SPELL_POWER_SHADOW_ORBS]		= "shadow_orbs",
	[SPELL_POWER_BURNING_EMBERS]	= "burning_embers",
	[SPELL_POWER_DEMONIC_FURY]		= "demonic_fury"
}
HU.Resources = resource_t


function HU.GetResourceName( key )
	return resource_t[key]
end


local specialization_t = {
	death_knight_blood		= 250,
	death_knight_frost		= 251,
	death_knight_unholy		= 252,

	druid_balance			= 102,
	druid_feral				= 103,
	druid_guardian			= 104,
	druid_restoration		= 105,

	hunter_beast_mastery	= 253,
	hunter_marksmanship		= 254,
	hunter_survival			= 255,

	mage_arcane				= 62,
	mage_fire				= 63,
	mage_frost				= 64,

	monk_brewmaster			= 268,
	monk_windwalker			= 269,
	monk_mistweaver			= 270,

	paladin_holy			= 65,
	paladin_protection		= 66,
	paladin_retribution		= 70,

	priest_discipline		= 256,
	priest_holy				= 257,
	priest_shadow			= 258,

	rogue_assassination		= 259,
	rogue_combat			= 260,
	rogue_subtlety			= 261,

	shaman_elemental		= 262,
	shaman_enhancement		= 263,
	shaman_restoration		= 264,

	warlock_affliction		= 265,
	warlock_demonology		= 266,
	warlock_destruction		= 267,

	warrior_arms			= 71,
	warrior_fury			= 72,
	warrior_protection		= 73
}


function HU.GetSpecializationIDByKey( key )
	return specialization_t[ key ]
end
