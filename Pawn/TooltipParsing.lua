﻿-- Pawn by Vger-Azjol-Nerub
-- www.vgermods.com
-- © 2006-2014 Green Eclipse.  This mod is released under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 license.
-- See Readme.htm for more information.

-- 
-- Tooltip parsing strings
------------------------------------------------------------

-- For conciseness
local L = PawnLocal.TooltipParsing


------------------------------------------------------------
-- Tooltip parsing expressions
------------------------------------------------------------

-- These strings indicate that a given line might contain multiple stats, such as complex enchantments
-- (ZG, AQ) and gems.  These are sorted in priority order.  If a string earlier in the table is present, any
-- string later in the table can be ignored.
PawnSeparators =
{
	", ",
	"/",
	" & ",
	" " .. L.MultiStatSeparator1 .. " ", -- and
}

-- Lines that match any of the following patterns will cause all further tooltip parsing to stop.
PawnKillLines =
{
	"^ \n$", -- The blank line before set items before WoW 2.3
	" %(%d+/%d+%)$", -- The (1/8) on set items for all versions of WoW
}
-- MobInfo-2 compatibility
if MI_LightBlue and MI_TXT_DROPPED_BY then
	tinsert(PawnKillLines, "^" .. MI_LightBlue .. MI_TXT_DROPPED_BY)
end

-- Lines that begin with any of the following strings will not be searched for separator strings.
PawnSeparatorIgnorePrefixes =
{
	'"', -- double quote
	L.Equip,
	L.Use,
	L.ChanceOnHit,
}

-- Items that begin with any of the following strings will never be parsed.
PawnIgnoreNames =
{
	L.Design,
	L.Formula,
	L.Manual,
	L.Pattern,
	L.Plans,
	L.Recipe,
	L.Schematic,
}

-- This is a list of regular expression substitutions that Pawn performs to normalize stat names before running
-- them through the normal gauntlet of expressions.
PawnNormalizationRegexes =
{
	{"^\|c........(.+)$", "%1"}, -- "|cFF 0FF 0Heroic" --> "Heroic"
	{"^([%w%s%.]+) %+(%d+)$", "+%2 %1"}, -- "Stamina +5" --> "+5 Stamina"
	{"^(.-)|r.*", "%1"}, -- For removing meta gem requirements
	{L.NormalizationEnchant, "%1"}, -- "Enchanted: +50 Strength" --> "+50 Strength" (ENCHANTED_TOOLTIP_LINE)
}

-- These regular expressions are used to parse item tooltips.
-- The first string is the regular expression to match.  Stat values should be denoted with "(%d+)".
-- Subsequent strings follow this pattern: Stat, Number, Source
-- Stat is the name of a statistic.
-- Number is either the amount of that stat to include, or the 1-based index into the matches array produced by the regex.
-- If it's an index, it can also be negative to mean that the stat should be subtracted instead of added.  If nil, defaults to 1.
-- Source is either PawnMultipleStatsFixed if Number is the amount of the stat, or PawnSingleStatMultiplier if Number is an
-- amount of the stat to multiply by the extracted number, or PawnMultipleStatsExtract or nil if Number is the matches array index.
-- Note that certain strings don't need to be translated: for example, the game defines
-- ITEM_BIND_ON_PICKUP to be "Binds when picked up" in English, and the correct string
-- in other languages automatically.
PawnRegexes =
{
	-- ========================================
	-- Common strings that are ignored (rare ones are at the bottom of the file)
	-- ========================================
	{PawnGameConstant(ITEM_QUALITY0_DESC)}, -- Poor
	{PawnGameConstant(ITEM_QUALITY1_DESC)}, -- Common
	{PawnGameConstant(ITEM_QUALITY2_DESC)}, -- Uncommon
	{PawnGameConstant(ITEM_QUALITY3_DESC)}, -- Rare
	{PawnGameConstant(ITEM_QUALITY4_DESC)}, -- Epic
	{PawnGameConstant(ITEM_QUALITY5_DESC)}, -- Legendary
	{PawnGameConstant(ITEM_QUALITY7_DESC)}, -- Heirloom
	{L.RaidFinder}, -- Raid Finder
	{L.Flexible}, -- Flexible raids
	{L.Heroic}, -- Items from heroic dungeons
	{L.Elite}, -- one version of Regail's Band of the Endless (http://www.wowhead.com/item=90517)
	{L.HeroicElite}, -- one version of Regail's Band of the Endless (http://www.wowhead.com/item=90503)
	{L.Thunderforged}, -- one version of Shoulders of the Crackling Protector (http://ptr.wowhead.com/item=96329)
	{L.HeroicThunderforged}, -- one version of Shoulders of the Crackling Protector (http://ptr.wowhead.com/item=97073)
	{L.Timeless}, -- level 535 version of Ordon Legend-Keeper Spaulders (http://ptr.wowhead.com/item=101925)
	{L.Warforged}, -- level 559 Black Blood of Y'Shaarj (http://www.wowhead.com/item=105399)
	{L.HeroicWarforged}, -- level 572 Black Blood of Y'Shaarj (http://www.wowhead.com/item=105648)
	{"^" .. ITEM_LEVEL}, -- Item Level 200
	{L.UpgradeLevel}, -- Upgrade Level 0/2 (ITEM_UPGRADE_TOOLTIP_FORMAT)
	{PawnGameConstantIgnoredPlaceholder(EQUIPMENT_SETS)}, -- String is from the Blizzard UI, but only used by Outfitter
	{PawnGameConstant(ITEM_UNSELLABLE)}, -- No sell price
	{PawnGameConstant(ITEM_SOULBOUND)}, -- Soulbound
	{PawnGameConstant(ITEM_BIND_ON_EQUIP)}, -- Binds when equipped
	{PawnGameConstant(ITEM_BIND_ON_PICKUP)}, -- Binds when picked up
	{PawnGameConstant(ITEM_BIND_ON_USE)}, -- Binds when used
	{PawnGameConstant(ITEM_BIND_TO_ACCOUNT)}, -- Binds to account
	{PawnGameConstant(ITEM_ACCOUNTBOUND)}, -- Account Bound
	{PawnGameConstant(ITEM_BIND_TO_BNETACCOUNT)}, -- Binds to Battle.net account (Polished Spaulders of Valor)
	{PawnGameConstant(ITEM_BNETACCOUNTBOUND)}, -- Battle.net Account Bound (Polished Spaulders of Valor)
	{"^" .. PawnGameConstantUnwrapped(ITEM_UNIQUE)}, -- Unique; leave off the $ for Unique (20)
	{"^" .. PawnGameConstantUnwrapped(ITEM_UNIQUE_EQUIPPABLE)}, -- Unique-Equipped; leave off the $ for Unique-Equipped: Curios of the Shado-Pan Assault (1)
	{"^" .. PawnGameConstantUnwrapped(ITEM_BIND_QUEST)}, -- Leave off the $ for MonkeyQuest mod compatibility
	{PawnGameConstant(ITEM_STARTS_QUEST)}, -- This Item Begins a Quest
	{PawnGameConstant(ITEM_CONJURED)}, -- Conjured Item
	{PawnGameConstant(ITEM_PROSPECTABLE)}, -- Prospectable
	{PawnGameConstant(ITEM_MILLABLE)}, -- Millable
	{PawnGameConstant(ITEM_DISENCHANT_NOT_DISENCHANTABLE)}, -- Cannot be disenchanted
	{PawnGameConstantIgnoredPlaceholder(ITEM_PROPOSED_ENCHANT)}, -- Appears in the trade window when an item is about to be enchanted ("Will receive +8 Stamina")
	{L.DisenchantingRequires}, -- Appears on item tooltips when the Disenchant ability is specified ("Disenchanting requires Enchanting (25)")
	{PawnGameConstant(ITEM_ENCHANT_DISCLAIMER)}, -- Item will not be traded!
	{L.Charges}, -- Brilliant Mana Oil
	{PawnGameConstant(LOCKED)}, -- Locked
	{PawnGameConstant(ENCRYPTED)}, -- Encrypted (does not seem to exist in the game yet)
	{PawnGameConstant(ITEM_SPELL_KNOWN)}, -- Already Known
	{PawnGameConstant(INVTYPE_HEAD)}, -- Head
	{PawnGameConstant(INVTYPE_NECK)}, -- Neck
	{PawnGameConstant(INVTYPE_SHOULDER)}, -- Shoulder
	{PawnGameConstant(INVTYPE_CLOAK)}, -- Back
	{PawnGameConstant(INVTYPE_ROBE)}, -- Chest
	{PawnGameConstant(INVTYPE_BODY)}, -- Shirt
	{PawnGameConstant(INVTYPE_TABARD)}, -- Tabard
	{PawnGameConstant(INVTYPE_WRIST)}, -- Wrist
	{PawnGameConstant(INVTYPE_HAND)}, -- Hands
	{PawnGameConstant(INVTYPE_WAIST)}, -- Waist
	{PawnGameConstant(INVTYPE_FEET)}, -- Feet
	{PawnGameConstant(INVTYPE_LEGS)}, -- Legs
	{PawnGameConstant(INVTYPE_FINGER)}, -- Finger
	{PawnGameConstant(INVTYPE_TRINKET)}, -- Trinket
	{PawnGameConstant(MAJOR_GLYPH)}, -- Major Glyph
	{PawnGameConstant(MINOR_GLYPH)}, -- Minor Glyph
	{PawnGameConstant(PRIME_GLYPH)}, -- Prime Glyph
	{PawnGameConstant(PawnLocal.CogwheelName)}, -- Cogwheel
	{PawnGameConstant(MOUNT)}, -- Cenarion War Hippogryph
	{PawnGameConstantIgnoredPlaceholder(ITEM_CLASSES_ALLOWED)}, -- Classes:
	{PawnGameConstantIgnoredPlaceholder(ITEM_RACES_ALLOWED)}, -- Races:
	{PawnGameConstantIgnoredNumberPlaceholder(DURABILITY_TEMPLATE)}, -- Durability X / Y
	{L.Duration},
	{L.CooldownRemaining},
	{"<.+>"}, -- Made by, Right-click to read, etc. (No ^$; can be prefixed by a color)
	{PawnGameConstantIgnoredPlaceholder(ITEM_WRITTEN_BY)}, -- Written by
	{L.MetaGemRequirements}, -- Meta gem requirements
	{L.BagSlots}, -- Bags of all kinds
	{L.TemporaryBuffSeconds}, -- Temporary item buff
	{L.TemporaryBuffMinutes}, -- Temporary item buff
	{PawnGameConstantIgnoredPlaceholder(ENCHANT_ITEM_REQ_SKILL)}, -- Seen on the enchanter-only ring enchantments when you're not an enchanter, and socketed jewelcrafter-only BoP gems
	
	-- ========================================
	-- Strings that represent statistics that Pawn cares about
	-- ========================================
	{L.HeirloomLevelRange, "MaxScalingLevel"}, -- Scaling heirloom items
	{L.HeirloomXpBoost, "XpBoost", 1, PawnMultipleStatsFixed}, -- Experience-granting heirloom items
	{L.HeirloomXpBoost2, "XpBoost", 1, PawnMultipleStatsFixed}, -- unused in English
	{PawnGameConstant(INVTYPE_RANGED), "IsRanged", 1, PawnMultipleStatsFixed}, -- Ranged
	{PawnGameConstant(INVTYPE_RANGEDRIGHT), "IsRanged", 1, PawnMultipleStatsFixed}, -- Ranged (but the translation is different in Russian)
	{PawnGameConstant(INVTYPE_WEAPON), "IsOneHand", 1, PawnMultipleStatsFixed}, -- One-Hand
	{PawnGameConstant(INVTYPE_2HWEAPON), "IsTwoHand", 1, PawnMultipleStatsFixed}, -- Two-Hand
	{PawnGameConstant(INVTYPE_WEAPONMAINHAND), "IsMainHand", 1, PawnMultipleStatsFixed}, -- Main Hand
	{PawnGameConstant(INVTYPE_WEAPONOFFHAND), "IsOffHand", 1, PawnMultipleStatsFixed}, -- Off Hand
	{PawnGameConstant(INVTYPE_HOLDABLE), "IsFrill", 1, PawnMultipleStatsFixed}, -- Held In Off-Hand
	{L.WeaponDamage, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 2, PawnMultipleStatsExtract}, -- Standard weapon (heirlooms can have decimal points in their damage values)
	{L.WeaponDamageFire, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 2, PawnMultipleStatsExtract}, -- Wand
	{L.WeaponDamageShadow, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 2, PawnMultipleStatsExtract}, -- Wand
	{L.WeaponDamageNature, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 2, PawnMultipleStatsExtract}, -- Wand, Thunderfury
	{L.WeaponDamageArcane, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 2, PawnMultipleStatsExtract}, -- Wand
	{L.WeaponDamageFrost, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 2, PawnMultipleStatsExtract}, -- Wand
	{L.WeaponDamageHoly, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 2, PawnMultipleStatsExtract}, -- Wand, Ashbringer
	{L.WeaponDamageEnchantment, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 1, PawnMultipleStatsExtract}, -- Weapon enchantments
	{L.WeaponDamageEquip, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 1, PawnMultipleStatsExtract}, -- Braided Eternium Chain (it's an item, not an enchantment)
	{L.WeaponDamageExact, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 1, PawnMultipleStatsExtract}, -- Weapons with no damage range: Crossbow of the Albatross
	{L.Scope, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 1, PawnMultipleStatsExtract}, -- Ranged weapon scopes
	{L.AllStats, "Strength", 1, PawnMultipleStatsExtract, "Agility", 1, PawnMultipleStatsExtract, "Stamina", 1, PawnMultipleStatsExtract, "Intellect", 1, PawnMultipleStatsExtract, "Spirit", 1, PawnMultipleStatsExtract}, -- Enchanted Pearl, Enchanted Tear, chest enchantments
	{L.Strength, "Strength"},
	{L.Agility, "Agility"},
	{L.Stamina, "Stamina"},
	{L.Intellect, "Intellect"}, -- negative Intellect: Kreeg's Mug
	{L.Spirit, "Spirit"},
	{L.EnchantmentTitaniumWeaponChain, "HasteRating", 28, PawnMultipleStatsFixed}, -- Weapon enchantment; also reduces disarm duration -- *** Needs update in WoW 6.0
	{L.EnchantmentPyriumWeaponChain, "HasteRating", 8, PawnMultipleStatsFixed}, -- Weapon enchantment; also reduces disarm duration
	{L.EnchantmentLivingSteelWeaponChain, "CritRating", 13, PawnMultipleStatsFixed}, -- Weapon enchantment; also reduces disarm duration
	{L.Dodge, "BonusArmor", 0.5, PawnSingleStatMultiplier}, -- Uppercase: Subtle Alicite, Arctic Ring of Eluding, Cata head enchantment for tanks
	{L.Dodge2, "BonusArmor", 0.5, PawnSingleStatMultiplier}, -- unused in English
	{L.Parry, "BonusArmor", 0.5, PawnSingleStatMultiplier},
	{L.Parry2, "BonusArmor", 0.5, PawnSingleStatMultiplier}, -- unused in English
	{L.Dps}, -- Ignore this; DPS is calculated manually
	{L.DpsAdd, "Dps"},
	{L.EnchantmentFieryWeapon, "Dps", 4, PawnMultipleStatsFixed}, -- weapon enchantment
	{L.Crit, "CritRating"},
	{L.Crit2, "CritRating"}, -- unused in English
	{L.ScopeCrit, "CritRating"},
	{L.ScopeRangedCrit, "CritRating"}, -- Heartseeker Scope
	{L.Resilience, "ResilienceRating"}, -- Mystic Dawnstone
	{L.Resilience2, "ResilienceRating"}, -- unused in English
	{L.PvPPower, "SpellPenetration"}, -- Stormy Chalcedony
	{L.EnchantmentCounterweight, "HasteRating"},
	{L.Haste, "HasteRating"}, -- Leggings of the Betrayed
	{L.Haste2, "HasteRating"}, -- unused in English
	{L.Mastery, "MasteryRating"}, -- Zen Dream Emerald
	{L.Mastery2, "MasteryRating"}, -- unused in English
	{L.Multistrike, "Multistrike"}, -- http://wod.wowhead.com/item=100945
	{L.Versatility, "Versatility"}, -- http://wod.wowhead.com/item=100945
	{L.Leech, "Leech"}, -- http://wod.wowhead.com/item=100945
	{L.Avoidance, "Avoidance"}, -- http://wod.wowhead.com/item=100945
	{PawnGameConstant(STAT_STURDINESS), "Indestructible", 1, PawnMultipleStatsFixed}, -- http://wod.wowhead.com/item=100945
	{L.MovementSpeed, "MovementSpeed"}, -- http://wod.wowhead.com/item=100945
	{L.Ap, "Ap"},
	{L.Hp5, "Stamina", 3, PawnSingleStatMultiplier}, -- (counting 1 HP5 = 3 Stamina)
	{L.Hp52, "Stamina", 3, PawnSingleStatMultiplier}, -- Demon's Blood (counting 1 HP5 = 3 Stamina)
	{L.Hp53, "Stamina", 3, PawnSingleStatMultiplier}, -- Aquamarine Signet of Regeneration
	{L.Hp54, "Stamina", 3, PawnSingleStatMultiplier}, -- Lifestone
	{L.EnchantmentHealth, "Stamina", 1/12.5, PawnSingleStatMultiplier}, -- +100 health head/leg enchantment (counting 1 HP = 1/12.5 Stamina)
	{L.EnchantmentHealth2, "Stamina", 1/12.5, PawnSingleStatMultiplier}, -- +150 health enchantment (counting 1 HP = 1/12.5 Stamin)
	{L.Armor, "Armor"}, -- normal armor and cloak armor enchantments
	{L.Armor2, "Armor"}, -- unused in English
	{L.EnchantmentArmorKit, "Armor"}, -- armor kits
	{L.BonusArmor, "BonusArmor"}, -- Chef's Hat: http://wod.wowhead.com/item=46349#links
	{L.SpellPower, "SpellPower"}, -- enchantments and weapons
	{PawnGameConstant(EMPTY_SOCKET_RED), "RedSocket", 1, PawnMultipleStatsFixed},
	{PawnGameConstant(EMPTY_SOCKET_YELLOW), "YellowSocket", 1, PawnMultipleStatsFixed},
	{PawnGameConstant(EMPTY_SOCKET_BLUE), "BlueSocket", 1, PawnMultipleStatsFixed},
	{PawnGameConstant(EMPTY_SOCKET_PRISMATIC), "PrismaticSocket", 1, PawnMultipleStatsFixed},
	{PawnGameConstant(EMPTY_SOCKET_NO_COLOR), "PrismaticSocket", 1, PawnMultipleStatsFixed}, -- unused
	{PawnGameConstant(EMPTY_SOCKET_META), "MetaSocket", 1, PawnMultipleStatsFixed},
	{PawnGameConstant(EMPTY_SOCKET_COGWHEEL), "CogwheelSocket", 1, PawnMultipleStatsFixed}, -- level 85+ epic Engineering crafted helms (Retinal Armor)
	{PawnGameConstant(EMPTY_SOCKET_HYDRAULIC), "ShaTouchedSocket", 1, PawnMultipleStatsFixed}, -- Sha-Touched items (Kri'tak)
	{L.OnlyFitsInMetaGemSlot, "MetaSocketEffect", 1, PawnMultipleStatsFixed}, -- Actual meta gems, not the socket
	{PawnGameConstant(PawnLocal.CrystalOfFearName)}, -- Actual crystals of fear, not the socket

	-- ========================================
	-- Rare strings that are ignored (common ones are at the top of the file)
	-- ========================================
	{'^"'}, -- Flavor text
	{PawnGameConstantIgnoredPlaceholder(ITEM_MIN_LEVEL)}, -- "Requires Level XX"... but "Requires level XX to YY" we DO care about.
	{PawnGameConstantIgnoredPlaceholder(ITEM_REQ_SKILL)}, -- "Requires SKILL (XX)"
	{L.Requires2}, -- unused in English
	{L.Season}, -- Honor and Conquest gear
	{L.BladesEdgeMountains}, -- Felsworn Gas Mask
	{L.ShadowmoonValley}, -- Enchanted Illidari Tabard
	{L.TempestKeep}, -- Cosmic Infuser
}

-- These regexes work exactly the same as PawnRegexes, but they're used to parse the right side of tooltips.
-- Unrecognized stats on the right side are always ignored.
-- Two-handed Axes, Maces, and Swords will have their stats converted to the 2H version later.
PawnRightHandRegexes =
{
	{L.Speed, "Speed"},
	{L.Speed2, "Speed"}, -- unused in English
	{L.Axe, "IsAxe", 1, PawnMultipleStatsFixed},
	{L.Bow, "IsBow", 1, PawnMultipleStatsFixed},
	{L.Crossbow, "IsCrossbow", 1, PawnMultipleStatsFixed},
	{L.Dagger, "IsDagger", 1, PawnMultipleStatsFixed},
	{L.FistWeapon, "IsFist", 1, PawnMultipleStatsFixed},
	{L.Gun, "IsGun", 1, PawnMultipleStatsFixed},
	{L.Mace, "IsMace", 1, PawnMultipleStatsFixed},
	{L.Polearm, "IsPolearm", 1, PawnMultipleStatsFixed},
	{L.Staff, "IsStaff", 1, PawnMultipleStatsFixed},
	{L.Sword, "IsSword", 1, PawnMultipleStatsFixed},
	{L.Wand, "IsWand", 1, PawnMultipleStatsFixed},
	{L.Cloth, "IsCloth", 1, PawnMultipleStatsFixed},
	{L.Leather, "IsLeather", 1, PawnMultipleStatsFixed},
	{L.Mail, "IsMail", 1, PawnMultipleStatsFixed},
	{L.Plate, "IsPlate", 1, PawnMultipleStatsFixed},
	{L.Shield, "IsShield", 1, PawnMultipleStatsFixed},
}
