-- Pawn by Vger-Azjol-Nerub
-- www.vgermods.com
-- © 2006-2014 Green Eclipse.  This mod is released under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 license.
-- See Readme.htm for more information.
--
-- WoW 6.0 starter scales
------------------------------------------------------------

local ScaleProviderName = "Starter"

function PawnStarterScaleProvider_AddScales()


------------------------------------------------------------
-- Death Knight
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"DeathKnightBloodTank",
	PawnLocal.Wowhead.DeathKnightBloodTank,
	"ff4d6b",
	{
		["Stamina"] = 1, ["Armor"] = 0.5, ["BonusArmor"] = 2.4, ["Strength"] = 2, ["Dps"] = 5, ["Ap"] = 1.9, ["CritRating"] = 1, ["HasteRating"] = 1, ["MasteryRating"] = 1, ["Multistrike"] = 1.05, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsShield"] = -1000000, ["IsDagger"] = -1000000, ["IsFist"] = -1000000, ["IsStaff"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil,
	1 -- hide 1H upgrades
)

PawnAddPluginScale(
	ScaleProviderName,
	"DeathKnightFrostDps",
	PawnLocal.Wowhead.DeathKnightFrostDps,
	"ff4d6b",
	{
		["Strength"] = 2, ["Dps"] = 5, ["Ap"] = 1.9, ["CritRating"] = 1, ["HasteRating"] = 1.05, ["MasteryRating"] = 1, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsShield"] = -1000000, ["IsDagger"] = -1000000, ["IsFist"] = -1000000, ["IsStaff"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

PawnAddPluginScale(
	ScaleProviderName,
	"DeathKnightUnholyDps",
	PawnLocal.Wowhead.DeathKnightUnholyDps,
	"ff4d6b",
	{
		["Strength"] = 2, ["Dps"] = 5, ["Ap"] = 1.9, ["CritRating"] = 1, ["HasteRating"] = 1, ["MasteryRating"] = 1, ["Multistrike"] = 1.05, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsShield"] = -1000000, ["IsDagger"] = -1000000, ["IsFist"] = -1000000, ["IsStaff"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil,
	1 -- hide 1H upgrades
)

------------------------------------------------------------
-- Druid
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"DruidBalance",
	PawnLocal.Wowhead.DruidBalance,
	"ff7d0a",
	{
		["Intellect"] = 2, ["SpellPower"] = 1.9, ["CritRating"] = 1, ["HasteRating"] = 1, ["MasteryRating"] = 1.05, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

PawnAddPluginScale(
	ScaleProviderName,
	"DruidFeralDps",
	PawnLocal.Wowhead.DruidFeralDps,
	"ff7d0a",
	{
		["Agility"] = 2, ["Dps"] = 5, ["Ap"] = 1.9, ["CritRating"] = 1.05, ["HasteRating"] = 1, ["MasteryRating"] = 1, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil,
	1 -- hide 1H upgrades
)

PawnAddPluginScale(
	ScaleProviderName,
	"DruidFeralTank",
	PawnLocal.Wowhead.DruidFeralTank,
	"ff7d0a",
	{
		["Stamina"] = 1, ["Armor"] = 0.5, ["BonusArmor"] = 2.4, ["Agility"] = 2, ["Dps"] = 5, ["Ap"] = 1.9, ["CritRating"] = 1, ["HasteRating"] = 1, ["MasteryRating"] = 1.05, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil,
	1 -- hide 1H upgrades
)

PawnAddPluginScale(
	ScaleProviderName,
	"DruidRestoration",
	PawnLocal.Wowhead.DruidRestoration,
	"ff7d0a",
	{
		["Intellect"] = 2, ["SpellPower"] = 1.9, ["Spirit"] = 1, ["CritRating"] = 1, ["HasteRating"] = 1.05, ["MasteryRating"] = 1, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

------------------------------------------------------------
-- Hunter
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"HunterBeastMastery",
	PawnLocal.Wowhead.HunterBeastMastery,
	"abd473",
	{
		["Agility"] = 2, ["Dps"] = 5, ["Ap"] = 1.9, ["CritRating"] = 1, ["HasteRating"] = 1, ["MasteryRating"] = 1.05, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsShield"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["IsOffHand"] = -1000000, ["IsDagger"] = -1000000, ["IsPolearm"] = -1000000, ["IsStaff"] = -1000000, ["IsFist"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["IsMace"] = -1000000, ["Is2HMace"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

PawnAddPluginScale(
	ScaleProviderName,
	"HunterMarksman",
	PawnLocal.Wowhead.HunterMarksman,
	"abd473",
	{
		["Agility"] = 2, ["Dps"] = 5, ["Ap"] = 1.9, ["CritRating"] = 1.05, ["HasteRating"] = 1, ["MasteryRating"] = 1, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsShield"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["IsOffHand"] = -1000000, ["IsDagger"] = -1000000, ["IsPolearm"] = -1000000, ["IsStaff"] = -1000000, ["IsFist"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["IsMace"] = -1000000, ["Is2HMace"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

PawnAddPluginScale(
	ScaleProviderName,
	"HunterSurvival",
	PawnLocal.Wowhead.HunterSurvival,
	"abd473",
	{
		["Agility"] = 2, ["Dps"] = 5, ["Ap"] = 1.9, ["CritRating"] = 1, ["HasteRating"] = 1, ["MasteryRating"] = 1, ["Multistrike"] = 1.05, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsShield"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["IsOffHand"] = -1000000, ["IsDagger"] = -1000000, ["IsPolearm"] = -1000000, ["IsStaff"] = -1000000, ["IsFist"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["IsMace"] = -1000000, ["Is2HMace"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

------------------------------------------------------------
-- Mage
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"MageArcane",
	PawnLocal.Wowhead.MageArcane,
	"69ccf0",
	{
		["Intellect"] = 2, ["SpellPower"] = 1.9, ["CritRating"] = 1, ["HasteRating"] = 1, ["MasteryRating"] = 1.05, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsLeather"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsFist"] = -1000000, ["IsMace"] = -1000000, ["Is2HMace"] = -1000000, ["IsPolearm"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

PawnAddPluginScale(
	ScaleProviderName,
	"MageFire",
	PawnLocal.Wowhead.MageFire,
	"69ccf0",
	{
		["Intellect"] = 2, ["SpellPower"] = 1.9, ["CritRating"] = 1.05, ["HasteRating"] = 1, ["MasteryRating"] = 1, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsLeather"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsFist"] = -1000000, ["IsMace"] = -1000000, ["Is2HMace"] = -1000000, ["IsPolearm"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

PawnAddPluginScale(
	ScaleProviderName,
	"MageFrost",
	PawnLocal.Wowhead.MageFrost,
	"69ccf0",
	{
		["Intellect"] = 2, ["SpellPower"] = 1.9, ["CritRating"] = 1, ["HasteRating"] = 1, ["MasteryRating"] = 1, ["Multistrike"] = 1.05, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsLeather"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsFist"] = -1000000, ["IsMace"] = -1000000, ["Is2HMace"] = -1000000, ["IsPolearm"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

------------------------------------------------------------
-- Monk
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"MonkBrewmaster",
	PawnLocal.Wowhead.MonkBrewmaster,
	"00ff96",
	{
		["Stamina"] = 1, ["Armor"] = 0.5, ["BonusArmor"] = 2.4, ["Agility"] = 2, ["Dps"] = 5, ["Ap"] = 1.9, ["CritRating"] = 1.05, ["HasteRating"] = 1, ["MasteryRating"] = 1, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsShield"] = -1000000, ["IsDagger"] = -1000000, ["Is2HSword"] = -1000000, ["Is2HAxe"] = -1000000, ["Is2HMace"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

PawnAddPluginScale(
	ScaleProviderName,
	"MonkMistweaver",
	PawnLocal.Wowhead.MonkMistweaver,
	"00ff96",
	{
		["Intellect"] = 2, ["SpellPower"] = 1.9, ["Spirit"] = 1, ["CritRating"] = 1, ["HasteRating"] = 1, ["MasteryRating"] = 1, ["Multistrike"] = 1.05, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsShield"] = -1000000, ["IsDagger"] = -1000000, ["Is2HSword"] = -1000000, ["Is2HAxe"] = -1000000, ["Is2HMace"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

PawnAddPluginScale(
	ScaleProviderName,
	"MonkWindwalker",
	PawnLocal.Wowhead.MonkWindwalker,
	"00ff96",
	{
		["Agility"] = 2, ["Dps"] = 5, ["Ap"] = 1.9, ["CritRating"] = 1, ["HasteRating"] = 1, ["MasteryRating"] = 1, ["Multistrike"] = 1.05, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsShield"] = -1000000, ["IsDagger"] = -1000000, ["Is2HSword"] = -1000000, ["Is2HAxe"] = -1000000, ["Is2HMace"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

------------------------------------------------------------
-- Paladin
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"PaladinHoly",
	PawnLocal.Wowhead.PaladinHoly,
	"f58cba",
	{
		["Intellect"] = 2, ["SpellPower"] = 1.9, ["Spirit"] = 1, ["CritRating"] = 1.05, ["HasteRating"] = 1, ["MasteryRating"] = 1, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsDagger"] = -1000000, ["IsFist"] = -1000000, ["IsStaff"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil,
	2 -- hide 2H upgrades
)

PawnAddPluginScale(
	ScaleProviderName,
	"PaladinTank",
	PawnLocal.Wowhead.PaladinTank,
	"f58cba",
	{
		["Strength"] = 2, ["Stamina"] = 1, ["Dps"] = 5, ["Ap"] = 1.9, ["Armor"] = 0.5, ["BonusArmor"] = 2.4, ["CritRating"] = 1, ["HasteRating"] = 1.05, ["MasteryRating"] = 1, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsDagger"] = -1000000, ["IsFist"] = -1000000, ["IsStaff"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsOffHand"] = -1000000, ["IsFrill"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil,
	2 -- hide 2H upgrades
)

PawnAddPluginScale(
	ScaleProviderName,
	"PaladinRetribution",
	PawnLocal.Wowhead.PaladinRetribution,
	"f58cba",
	{
		["Strength"] = 2, ["Dps"] = 5, ["Ap"] = 1.9, ["CritRating"] = 1, ["HasteRating"] = 1, ["MasteryRating"] = 1.05, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsDagger"] = -1000000, ["IsFist"] = -1000000, ["IsStaff"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsOffHand"] = -1000000, ["IsFrill"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil,
	1 -- hide 1H upgrades
)

------------------------------------------------------------
-- Priest
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"PriestDiscipline",
	PawnLocal.Wowhead.PriestDiscipline,
	"e0e0e0",
	{
		["Intellect"] = 2, ["SpellPower"] = 1.9, ["Spirit"] = 1, ["CritRating"] = 1.05, ["HasteRating"] = 1, ["MasteryRating"] = 1, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsLeather"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsFist"] = -1000000, ["IsPolearm"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["Is2HMace"] = -1000000, ["IsOffHand"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

PawnAddPluginScale(
	ScaleProviderName,
	"PriestHoly",
	PawnLocal.Wowhead.PriestHoly,
	"e0e0e0",
	{
		["Intellect"] = 2, ["SpellPower"] = 1.9, ["Spirit"] = 1, ["CritRating"] = 1, ["HasteRating"] = 1, ["MasteryRating"] = 1, ["Multistrike"] = 1.05, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsLeather"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsFist"] = -1000000, ["IsPolearm"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["Is2HMace"] = -1000000, ["IsOffHand"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

PawnAddPluginScale(
	ScaleProviderName,
	"PriestShadow",
	PawnLocal.Wowhead.PriestShadow,
	"e0e0e0",
	{
		["Intellect"] = 2, ["SpellPower"] = 1.9, ["CritRating"] = 1, ["HasteRating"] = 1.05, ["MasteryRating"] = 1, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsLeather"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsFist"] = -1000000, ["IsPolearm"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["Is2HMace"] = -1000000, ["IsOffHand"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

------------------------------------------------------------
-- Rogue
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"RogueAssassination",
	PawnLocal.Wowhead.RogueAssassination,
	"fff569",
	{
		["Agility"] = 2, ["Dps"] = 5, ["Ap"] = 1.9, ["CritRating"] = 1, ["HasteRating"] = 1, ["MasteryRating"] = 1.05, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsShield"] = -1000000, ["IsPolearm"] = -1000000, ["IsStaff"] = -1000000, ["Is2HAxe"] = -1000000, ["Is2HMace"] = -1000000, ["Is2HSword"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsAxe"] = -1000000, ["IsFist"] = -1000000, ["IsMace"] = -1000000, ["IsSword"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil,
	2 -- hide 2H upgrades
)

PawnAddPluginScale(
	ScaleProviderName,
	"RogueCombat",
	PawnLocal.Wowhead.RogueCombat,
	"fff569",
	{
		["Agility"] = 2, ["Dps"] = 5, ["Ap"] = 1.9, ["CritRating"] = 1, ["HasteRating"] = 1.05, ["MasteryRating"] = 1, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsShield"] = -1000000, ["IsPolearm"] = -1000000, ["IsStaff"] = -1000000, ["Is2HAxe"] = -1000000, ["Is2HMace"] = -1000000, ["Is2HSword"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil,
	2 -- hide 2H upgrades
)

PawnAddPluginScale(
	ScaleProviderName,
	"RogueSubtlety",
	PawnLocal.Wowhead.RogueSubtlety,
	"fff569",
	{
		["Agility"] = 2, ["Dps"] = 5, ["Ap"] = 1.9, ["CritRating"] = 1, ["HasteRating"] = 1, ["MasteryRating"] = 1, ["Multistrike"] = 1.05, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsShield"] = -1000000, ["IsPolearm"] = -1000000, ["IsStaff"] = -1000000, ["Is2HAxe"] = -1000000, ["Is2HMace"] = -1000000, ["Is2HSword"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil,
	2 -- hide 2H upgrades
)

------------------------------------------------------------
-- Shaman
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"ShamanElemental",
	PawnLocal.Wowhead.ShamanElemental,
	"6e95ff",
	{
		["Intellect"] = 2, ["SpellPower"] = 1.9, ["CritRating"] = 1, ["HasteRating"] = 1, ["MasteryRating"] = 1, ["Multistrike"] = 1.05, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsPolearm"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

PawnAddPluginScale(
	ScaleProviderName,
	"ShamanEnhancement",
	PawnLocal.Wowhead.ShamanEnhancement,
	"6e95ff",
	{
		["Agility"] = 2, ["Dps"] = 5, ["Ap"] = 1.9, ["CritRating"] = 1, ["HasteRating"] = 1.05, ["MasteryRating"] = 1, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsPolearm"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil,
	2 -- hide 2H upgrades
)

PawnAddPluginScale(
	ScaleProviderName,
	"ShamanRestoration",
	PawnLocal.Wowhead.ShamanRestoration,
	"6e95ff",
	{
		["Intellect"] = 2, ["SpellPower"] = 1.9, ["Spirit"] = 1, ["CritRating"] = 1, ["HasteRating"] = 1, ["MasteryRating"] = 1.05, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsPolearm"] = -1000000, ["IsSword"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsWand"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

------------------------------------------------------------
-- Warlock
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"WarlockAffliction",
	PawnLocal.Wowhead.WarlockAffliction,
	"bca5ff",
	{
		["Intellect"] = 2, ["SpellPower"] = 1.9, ["CritRating"] = 1, ["HasteRating"] = 1.05, ["MasteryRating"] = 1, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsLeather"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsFist"] = -1000000, ["IsMace"] = -1000000, ["Is2HMace"] = -1000000, ["IsPolearm"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

PawnAddPluginScale(
	ScaleProviderName,
	"WarlockDemonology",
	PawnLocal.Wowhead.WarlockDemonology,
	"bca5ff",
	{
		["Intellect"] = 2, ["SpellPower"] = 1.9, ["CritRating"] = 1, ["HasteRating"] = 1, ["MasteryRating"] = 1.05, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsLeather"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsFist"] = -1000000, ["IsMace"] = -1000000, ["Is2HMace"] = -1000000, ["IsPolearm"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

PawnAddPluginScale(
	ScaleProviderName,
	"WarlockDestruction",
	PawnLocal.Wowhead.WarlockDestruction,
	"bca5ff",
	{
		["Intellect"] = 2, ["SpellPower"] = 1.9, ["CritRating"] = 1.05, ["HasteRating"] = 1, ["MasteryRating"] = 1, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsPlate"] = -1000000, ["IsMail"] = -1000000, ["IsLeather"] = -1000000, ["IsShield"] = -1000000, ["IsAxe"] = -1000000, ["Is2HAxe"] = -1000000, ["IsFist"] = -1000000, ["IsMace"] = -1000000, ["Is2HMace"] = -1000000, ["IsPolearm"] = -1000000, ["Is2HSword"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

------------------------------------------------------------
-- Warrior
------------------------------------------------------------

PawnAddPluginScale(
	ScaleProviderName,
	"WarriorArms",
	PawnLocal.Wowhead.WarriorArms,
	"c79c6e",
	{
		["Strength"] = 2, ["Dps"] = 5, ["Ap"] = 1.9, ["CritRating"] = 1, ["HasteRating"] = 1, ["MasteryRating"] = 1.05, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

PawnAddPluginScale(
	ScaleProviderName,
	"WarriorFury",
	PawnLocal.Wowhead.WarriorFury,
	"c79c6e",
	{
		["Strength"] = 2, ["Dps"] = 5, ["Ap"] = 1.9, ["CritRating"] = 1.05, ["HasteRating"] = 1, ["MasteryRating"] = 1, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil
)

PawnAddPluginScale(
	ScaleProviderName,
	"WarriorTank",
	PawnLocal.Wowhead.WarriorTank,
	"c79c6e",
	{
		["Strength"] = 2, ["Stamina"] = 1, ["Dps"] = 5, ["Ap"] = 1.9, ["Armor"] = 0.3, ["BonusArmor"] = 2.4, ["CritRating"] = 1, ["HasteRating"] = 1, ["MasteryRating"] = 1.05, ["Multistrike"] = 1, ["Versatility"] = 1, ["MovementSpeed"] = 0.1, ["Avoidance"] = 0.1, ["Leech"] = 0.1, ["IsWand"] = -1000000, ["IsFrill"] = -1000000, ["IsBow"] = -1000000, ["IsCrossbow"] = -1000000, ["IsGun"] = -1000000, ["IsOffHand"] = -1000000, ["MetaSocketEffect"] = 80
	},
	nil,
	2 -- hide 2H upgrades
)

------------------------------------------------------------

-- PawnStarterScaleProviderOptions.LastAdded keeps track of the last time that we tried to automatically enable scales for this character.
if not PawnStarterScaleProviderOptions then PawnStarterScaleProviderOptions = { } end
if not PawnStarterScaleProviderOptions.LastAdded then PawnStarterScaleProviderOptions.LastAdded = 0 end

local _, Class = UnitClass("player")
if PawnStarterScaleProviderOptions.LastClass ~= nil and Class ~= PawnStarterScaleProviderOptions.LastClass then
	-- If the character has changed class since last time, let's start over.
	PawnSetAllScaleProviderScalesVisible(ScaleProviderName, false)
	PawnStarterScaleProviderOptions.LastAdded = 0
end
PawnStarterScaleProviderOptions.LastClass = Class

if PawnStarterScaleProviderOptions.LastAdded < 1 then
	if Class == "WARRIOR" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "WarriorArms"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "WarriorFury"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "WarriorTank"), true)
	elseif Class == "PALADIN" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "PaladinHoly"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "PaladinTank"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "PaladinRetribution"), true)
	elseif Class == "HUNTER" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "HunterBeastMastery"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "HunterMarksman"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "HunterSurvival"), true)
	elseif Class == "ROGUE" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "RogueAssassination"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "RogueCombat"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "RogueSubtlety"), true)
	elseif Class == "PRIEST" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "PriestDiscipline"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "PriestHoly"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "PriestShadow"), true)
	elseif Class == "DEATHKNIGHT" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "DeathKnightBloodTank"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "DeathKnightFrostDps"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "DeathKnightUnholyDps"), true)
	elseif Class == "SHAMAN" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "ShamanElemental"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "ShamanEnhancement"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "ShamanRestoration"), true)
	elseif Class == "MAGE" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "MageArcane"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "MageFire"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "MageFrost"), true)
	elseif Class == "WARLOCK" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "WarlockAffliction"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "WarlockDemonology"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "WarlockDestruction"), true)
	elseif Class == "DRUID" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "DruidBalance"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "DruidFeralDps"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "DruidFeralTank"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "DruidRestoration"), true)
	elseif Class == "MONK" then
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "MonkBrewmaster"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "MonkMistweaver"), true)
		PawnSetScaleVisible(PawnGetProviderScaleName(ScaleProviderName, "MonkWindwalker"), true)
	end
end

-- Don't reenable those scales again after the user has disabled them previously.
PawnStarterScaleProviderOptions.LastAdded = 1

-- After this function terminates there's no need for it anymore, so cause it to self-destruct to save memory.
PawnStarterScaleProvider_AddScales = nil

end -- PawnStarterScaleProvider_AddScales

------------------------------------------------------------

PawnAddPluginScaleProvider(ScaleProviderName, PawnLocal.Wowhead.ProviderStarter, PawnStarterScaleProvider_AddScales)
