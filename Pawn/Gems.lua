-- Pawn by Vger-Azjol-Nerub
-- www.vgermods.com
-- © 2006-2014 Green Eclipse.  This mod is released under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 license.
-- See Readme.htm for more information.
-- 
-- Gem information
------------------------------------------------------------


-- Gem table row format:
-- { ItemID, Class, Red, Yellow, Blue, "Stat1" Quantity1, "Stat2", Quantity2 }
-- 	ItemID: The item ID of this gem.
-- 	Red: Is this gem red?
-- 	Yellow: Is this gem yellow?
-- 	Blue: Is this gem blue?
--	"Stat": The stat that this gem gives.
--	Quantity: How much of the stat that the gem gives.
--	("Stat", Quantity can be repeated again...)
--	Pawn will use the 9th slot for storing a cache of scale values.


--========================================
-- Colored level 70 uncommon-quality gems
--========================================
local PawnGemData70Uncommon =
{


------------------------------------------------------------
-- Red gems
------------------------------------------------------------

{ 23094, true, false, false, "Intellect", 6 }, -- Brilliant Blood Garnet
{ 23095, true, false, false, "Strength", 6 }, -- Bold Blood Garnet
{ 28595, true, false, false, "Agility", 6 }, -- Delicate Blood Garnet


------------------------------------------------------------
-- Orange gems
------------------------------------------------------------

{ 23098, true, true, false, "CritRating", 6, "Strength", 3 }, -- Inscribed Flame Spessarite
{ 23099, true, true, false, "HasteRating", 6, "Intellect", 3 }, -- Reckless Flame Spessarite
{ 23101, true, true, false, "CritRating", 3, "Intellect", 6 }, -- Potent Flame Spessarite
{ 31869, true, true, false, "CritRating", 3, "Agility", 6 }, -- Deadly Flame Spessarite


------------------------------------------------------------
-- Yellow gems
------------------------------------------------------------

{ 23114, false, true, false, "CritRating", 12 }, -- Smooth Golden Draenite
-- Subtle Golden Draenite (23115) had no recognized stats


------------------------------------------------------------
-- Green gems
------------------------------------------------------------

{ 23103, false, true, true, "CritRating", 6, "SpellPenetration", 3 }, -- Radiant Deep Peridot
{ 23104, false, true, true, "CritRating", 6, "Stamina", 4 }, -- Jagged Deep Peridot
{ 23105, false, true, true, "Stamina", 4 }, -- Regal Deep Peridot


------------------------------------------------------------
-- Blue gems
------------------------------------------------------------

{ 23116, false, false, true, "CritRating", 12 }, -- Rigid Azure Moonstone
{ 23118, false, false, true, "Stamina", 9 }, -- Solid Azure Moonstone
{ 23119, false, false, true, "Spirit", 12 }, -- Sparkling Azure Moonstone
{ 23120, false, false, true, "SpellPenetration", 6 }, -- Stormy Azure Moonstone


------------------------------------------------------------
-- Purple gems
------------------------------------------------------------

{ 23100, true, false, true, "CritRating", 6, "Agility", 3 }, -- Glinting Shadow Draenite
{ 23108, true, false, true, "Intellect", 3, "Stamina", 4 }, -- Timeless Shadow Draenite
{ 23109, true, false, true, "Intellect", 3, "Spirit", 6 }, -- Purified Shadow Draenite
{ 23110, true, false, true, "Stamina", 4, "Agility", 3 }, -- Shifting Shadow Draenite
{ 23111, true, false, true, "Strength", 3, "Stamina", 4 }, -- Sovereign Shadow Draenite
{ 31866, true, false, true, "Intellect", 3, "CritRating", 6 }, -- Veiled Shadow Draenite


}


--========================================
-- Colored level 70 rare-quality gems
--========================================
local PawnGemData70Rare =
{


------------------------------------------------------------
-- Red gems
------------------------------------------------------------

{ 24027, true, false, false, "Strength", 8 }, -- Bold Living Ruby
{ 24028, true, false, false, "Agility", 8 }, -- Delicate Living Ruby
{ 24030, true, false, false, "Intellect", 8 }, -- Brilliant Living Ruby
-- Flashing Living Ruby (24036) had no recognized stats


------------------------------------------------------------
-- Orange gems
------------------------------------------------------------

{ 24058, true, true, false, "CritRating", 4, "Strength", 8 }, -- Inscribed Noble Topaz
{ 24059, true, true, false, "Intellect", 4, "CritRating", 8 }, -- Potent Noble Topaz
{ 24060, true, true, false, "Intellect", 4, "HasteRating", 8 }, -- Reckless Noble Topaz
{ 31868, true, true, false, "CritRating", 8, "Agility", 4 }, -- Deadly Noble Topaz


------------------------------------------------------------
-- Yellow gems
------------------------------------------------------------

-- Subtle Dawnstone (24032) had no recognized stats
{ 24048, false, true, false, "CritRating", 16 }, -- Smooth Dawnstone
{ 24053, false, true, false, "ResilienceRating", 8 }, -- Mystic Dawnstone
{ 35315, false, true, false, "HasteRating", 16 }, -- Quick Dawnstone


------------------------------------------------------------
-- Green gems
------------------------------------------------------------

{ 24066, false, true, true, "CritRating", 8, "SpellPenetration", 4 }, -- Radiant Talasite
{ 24067, false, true, true, "CritRating", 8, "Stamina", 6 }, -- Jagged Talasite
{ 33782, false, true, true, "Stamina", 6, "ResilienceRating", 4 }, -- Steady Talasite
{ 35318, false, true, true, "HasteRating", 8, "Stamina", 6 }, -- Forceful Talasite
{ 35707, false, true, true, "Stamina", 6 }, -- Regal Talasite


------------------------------------------------------------
-- Blue gems
------------------------------------------------------------

{ 24033, false, false, true, "Stamina", 12 }, -- Solid Star of Elune
{ 24035, false, false, true, "Spirit", 16 }, -- Sparkling Star of Elune
{ 24039, false, false, true, "SpellPenetration", 8 }, -- Stormy Star of Elune
{ 24051, false, false, true, "CritRating", 16 }, -- Rigid Star of Elune


------------------------------------------------------------
-- Purple gems
------------------------------------------------------------

{ 24054, true, false, true, "Strength", 4, "Stamina", 6 }, -- Sovereign Nightseye
{ 24055, true, false, true, "Stamina", 6, "Agility", 4 }, -- Shifting Nightseye
{ 24056, true, false, true, "Intellect", 5, "Stamina", 6 }, -- Timeless Nightseye
{ 24061, true, false, true, "CritRating", 8, "Agility", 4 }, -- Glinting Nightseye
{ 24065, true, false, true, "Intellect", 4, "Spirit", 8 }, -- Purified Nightseye
{ 31867, true, false, true, "Intellect", 4, "CritRating", 8 }, -- Veiled Nightseye


}


--========================================
-- Colored level 70 epic-quality gems
--========================================
local PawnGemData70Epic =
{


------------------------------------------------------------
-- Red gems
------------------------------------------------------------

{ 32193, true, false, false, "Strength", 10 }, -- Bold Crimson Spinel
{ 32194, true, false, false, "Agility", 10 }, -- Delicate Crimson Spinel
{ 32195, true, false, false, "Intellect", 10 }, -- Brilliant Crimson Spinel
-- Flashing Crimson Spinel (32199) had no recognized stats


------------------------------------------------------------
-- Orange gems
------------------------------------------------------------

{ 32217, true, true, false, "CritRating", 10, "Strength", 5 }, -- Inscribed Pyrestone
{ 32218, true, true, false, "Intellect", 5, "CritRating", 10 }, -- Potent Pyrestone
{ 32219, true, true, false, "Intellect", 5, "HasteRating", 10 }, -- Reckless Pyrestone
{ 32222, true, true, false, "CritRating", 10, "Agility", 5 }, -- Deadly Pyrestone


------------------------------------------------------------
-- Yellow gems
------------------------------------------------------------

-- Subtle Lionseye (32198) had no recognized stats
{ 32205, false, true, false, "CritRating", 20 }, -- Smooth Lionseye
{ 32209, false, true, false, "ResilienceRating", 10 }, -- Mystic Lionseye
{ 35761, false, true, false, "HasteRating", 20 }, -- Quick Lionseye


------------------------------------------------------------
-- Green gems
------------------------------------------------------------

{ 32223, false, true, true, "Stamina", 7 }, -- Regal Seaspray Emerald
{ 32224, false, true, true, "CritRating", 10, "SpellPenetration", 5 }, -- Radiant Seaspray Emerald
{ 32226, false, true, true, "CritRating", 10, "Stamina", 7 }, -- Jagged Seaspray Emerald
{ 35758, false, true, true, "Stamina", 7, "ResilienceRating", 5 }, -- Steady Seaspray Emerald
{ 35759, false, true, true, "HasteRating", 5, "Stamina", 7 }, -- Forceful Seaspray Emerald


------------------------------------------------------------
-- Blue gems
------------------------------------------------------------

{ 32200, false, false, true, "Stamina", 15 }, -- Solid Empyrean Sapphire
{ 32201, false, false, true, "Spirit", 20 }, -- Sparkling Empyrean Sapphire
{ 32203, false, false, true, "SpellPenetration", 10 }, -- Stormy Empyrean Sapphire
{ 32206, false, false, true, "CritRating", 10 }, -- Rigid Empyrean Sapphire


------------------------------------------------------------
-- Purple gems
------------------------------------------------------------

{ 32211, true, false, true, "Strength", 5, "Stamina", 7 }, -- Sovereign Shadowsong Amethyst
{ 32212, true, false, true, "Stamina", 7, "Agility", 5 }, -- Shifting Shadowsong Amethyst
{ 32215, true, false, true, "Intellect", 5, "Stamina", 7 }, -- Timeless Shadowsong Amethyst
{ 32220, true, false, true, "CritRating", 10, "Agility", 5 }, -- Glinting Shadowsong Amethyst
{ 32221, true, false, true, "Intellect", 5, "CritRating", 10 }, -- Veiled Shadowsong Amethyst
{ 32225, true, false, true, "Intellect", 5, "Spirit", 10 }, -- Purified Shadowsong Amethyst


}


--========================================
-- Level 70 crafted meta gems
--========================================
local PawnMetaGemData70Rare =
{


------------------------------------------------------------
-- Meta gems: Earthstorm
------------------------------------------------------------

{ 25896, true, false, false, "Stamina", 18, "MetaSocketEffect", 1 }, -- Powerful Earthstorm Diamond
{ 25897, true, false, false, "Intellect", 12, "MetaSocketEffect", 1 }, -- Bracing Earthstorm Diamond
{ 25898, true, false, false, "MetaSocketEffect", 1 }, -- Tenacious Earthstorm Diamond
{ 25899, true, false, false, "MetaSocketEffect", 1 }, -- Brutal Earthstorm Diamond
{ 25901, true, false, false, "Intellect", 12, "MetaSocketEffect", 1 }, -- Insightful Earthstorm Diamond
{ 32409, true, false, false, "MetaSocketEffect", 1, "Agility", 12 }, -- Relentless Earthstorm Diamond
{ 35501, true, false, false, "MetaSocketEffect", 1 }, -- Eternal Earthstorm Diamond


------------------------------------------------------------
-- Meta gems: Skyfire
------------------------------------------------------------

{ 25890, true, true, false, "CritRating", 28, "MetaSocketEffect", 1 }, -- Destructive Skyfire Diamond
{ 25893, true, true, false, "MetaSocketEffect", 1 }, -- Mystical Skyfire Diamond
{ 25894, true, true, false, "CritRating", 24, "MetaSocketEffect", 1 }, -- Swift Skyfire Diamond
{ 25895, true, true, false, "MetaSocketEffect", 1 }, -- Enigmatic Skyfire Diamond
{ 32410, true, true, false, "MetaSocketEffect", 1 }, -- Thundering Skyfire Diamond
{ 34220, true, true, false, "CritRating", 19, "MetaSocketEffect", 1 }, -- Chaotic Skyfire Diamond
{ 35503, true, true, false, "Intellect", 12, "MetaSocketEffect", 1 }, -- Ember Skyfire Diamond


}


--========================================
-- Colored level 80 uncommon-quality gems
--========================================
local PawnGemData80Uncommon =
{


------------------------------------------------------------
-- Red gems
------------------------------------------------------------

{ 39900, true, false, false, "Strength", 6 }, -- Bold Bloodstone
{ 39905, true, false, false, "Agility", 6 }, -- Delicate Bloodstone
-- Flashing Bloodstone (39908) had no recognized stats
{ 39910, true, false, false, "HasteRating", 12 }, -- Precise Bloodstone
{ 39911, true, false, false, "Intellect", 6 }, -- Brilliant Bloodstone


------------------------------------------------------------
-- Orange gems
------------------------------------------------------------

{ 39946, true, true, false, "Intellect", 3, "HasteRating", 6 }, -- Reckless Huge Citrine
{ 39947, true, true, false, "Strength", 3, "CritRating", 6 }, -- Inscribed Huge Citrine
{ 39949, true, true, false, "Strength", 3 }, -- Champion's Huge Citrine
{ 39950, true, true, false, "Strength", 3, "ResilienceRating", 3 }, -- Resplendent Huge Citrine
{ 39951, true, true, false, "Strength", 3, "HasteRating", 6 }, -- Fierce Huge Citrine
{ 39952, true, true, false, "CritRating", 6, "Agility", 3 }, -- Deadly Huge Citrine
{ 39954, true, true, false, "ResilienceRating", 3, "Agility", 3 }, -- Lucent Huge Citrine
{ 39955, true, true, false, "HasteRating", 6, "Agility", 3 }, -- Deft Huge Citrine
{ 39956, true, true, false, "Intellect", 3, "CritRating", 6 }, -- Potent Huge Citrine
{ 39958, true, true, false, "Intellect", 3, "ResilienceRating", 3 }, -- Willful Huge Citrine
-- Stalwart Huge Citrine (39964) had no recognized stats
{ 39967, true, true, false, "HasteRating", 6 }, -- Resolute Huge Citrine


------------------------------------------------------------
-- Yellow gems
------------------------------------------------------------

-- Subtle Sun Crystal (39907) had no recognized stats
{ 39909, false, true, false, "CritRating", 12 }, -- Smooth Sun Crystal
{ 39917, false, true, false, "ResilienceRating", 6 }, -- Mystic Sun Crystal
{ 39918, false, true, false, "HasteRating", 12 }, -- Quick Sun Crystal


------------------------------------------------------------
-- Green gems
------------------------------------------------------------

{ 39933, false, true, true, "CritRating", 6, "Stamina", 4 }, -- Jagged Dark Jade
{ 39938, false, true, true, "Stamina", 4 }, -- Regal Dark Jade
{ 39975, false, true, true, "CritRating", 6 }, -- Nimble Dark Jade
{ 39977, false, true, true, "Stamina", 4, "ResilienceRating", 3 }, -- Steady Dark Jade
{ 39978, false, true, true, "HasteRating", 6, "Stamina", 4 }, -- Forceful Dark Jade
{ 39980, false, true, true, "CritRating", 6, "Spirit", 6 }, -- Misty Dark Jade
{ 39981, false, true, true, "CritRating", 6, "HasteRating", 6 }, -- Lightning Dark Jade
{ 39982, false, true, true, "Spirit", 6, "ResilienceRating", 3 }, -- Turbid Dark Jade
{ 39983, false, true, true, "HasteRating", 6, "Spirit", 6 }, -- Energized Dark Jade
{ 39990, false, true, true, "CritRating", 6, "SpellPenetration", 3 }, -- Radiant Dark Jade
{ 39992, false, true, true, "HasteRating", 6, "SpellPenetration", 3 }, -- Shattered Dark Jade


------------------------------------------------------------
-- Blue gems
------------------------------------------------------------

{ 39915, false, false, true, "CritRating", 12 }, -- Rigid Chalcedony
{ 39919, false, false, true, "Stamina", 9 }, -- Solid Chalcedony
{ 39920, false, false, true, "Spirit", 12 }, -- Sparkling Chalcedony
{ 39932, false, false, true, "SpellPenetration", 6 }, -- Stormy Chalcedony


------------------------------------------------------------
-- Purple gems
------------------------------------------------------------

{ 39934, true, false, true, "Strength", 3, "Stamina", 4 }, -- Sovereign Shadow Crystal
{ 39935, true, false, true, "Stamina", 4, "Agility", 3 }, -- Shifting Shadow Crystal
{ 39936, true, false, true, "Intellect", 3, "Stamina", 4 }, -- Timeless Shadow Crystal
{ 39939, true, false, true, "Stamina", 4 }, -- Defender's Shadow Crystal
{ 39940, true, false, true, "HasteRating", 6, "Stamina", 4 }, -- Guardian's Shadow Crystal
{ 39941, true, false, true, "Intellect", 3, "Spirit", 6 }, -- Purified Shadow Crystal
{ 39942, true, false, true, "CritRating", 6, "Agility", 3 }, -- Glinting Shadow Crystal
{ 39945, true, false, true, "Intellect", 3, "SpellPenetration", 3 }, -- Mysterious Shadow Crystal
{ 39948, true, false, true, "Strength", 3, "CritRating", 6 }, -- Etched Shadow Crystal
{ 39957, true, false, true, "Intellect", 3, "CritRating", 6 }, -- Veiled Shadow Crystal
{ 39966, true, false, true, "HasteRating", 6, "CritRating", 6 }, -- Accurate Shadow Crystal


}


--========================================
-- Colored level 80 rare-quality gems
--========================================
local PawnGemData80Rare =
{


------------------------------------------------------------
-- Red gems
------------------------------------------------------------

{ 39996, true, false, false, "Strength", 8 }, -- Bold Scarlet Ruby
{ 39997, true, false, false, "Agility", 8 }, -- Delicate Scarlet Ruby
{ 39998, true, false, false, "Intellect", 8 }, -- Brilliant Scarlet Ruby
-- Flashing Scarlet Ruby (40001) had no recognized stats
{ 40003, true, false, false, "HasteRating", 16 }, -- Precise Scarlet Ruby


------------------------------------------------------------
-- Orange gems
------------------------------------------------------------

{ 40037, true, true, false, "Strength", 4, "CritRating", 8 }, -- Inscribed Monarch Topaz
{ 40039, true, true, false, "Strength", 4 }, -- Champion's Monarch Topaz
{ 40040, true, true, false, "Strength", 4, "ResilienceRating", 4 }, -- Resplendent Monarch Topaz
{ 40041, true, true, false, "Strength", 4, "HasteRating", 8 }, -- Fierce Monarch Topaz
{ 40043, true, true, false, "CritRating", 8, "Agility", 4 }, -- Deadly Monarch Topaz
{ 40045, true, true, false, "ResilienceRating", 4, "Agility", 4 }, -- Lucent Monarch Topaz
{ 40046, true, true, false, "HasteRating", 8, "Agility", 4 }, -- Deft Monarch Topaz
{ 40047, true, true, false, "Intellect", 4, "HasteRating", 8 }, -- Reckless Monarch Topaz
{ 40048, true, true, false, "Intellect", 4, "CritRating", 8 }, -- Potent Monarch Topaz
{ 40050, true, true, false, "Intellect", 4, "ResilienceRating", 4 }, -- Willful Monarch Topaz
-- Stalwart Monarch Topaz (40056) had no recognized stats
{ 40059, true, true, false, "HasteRating", 8 }, -- Resolute Monarch Topaz


------------------------------------------------------------
-- Yellow gems
------------------------------------------------------------

-- Subtle Autumn's Glow (40000) had no recognized stats
{ 40002, false, true, false, "CritRating", 16 }, -- Smooth Autumn's Glow
{ 40016, false, true, false, "ResilienceRating", 8 }, -- Mystic Autumn's Glow
{ 40017, false, true, false, "HasteRating", 16 }, -- Quick Autumn's Glow


------------------------------------------------------------
-- Green gems
------------------------------------------------------------

{ 40031, false, true, true, "Stamina", 6 }, -- Regal Forest Emerald
{ 40033, false, true, true, "CritRating", 8, "Stamina", 6 }, -- Jagged Forest Emerald
{ 40088, false, true, true, "CritRating", 8 }, -- Nimble Forest Emerald
{ 40090, false, true, true, "Stamina", 6, "ResilienceRating", 4 }, -- Steady Forest Emerald
{ 40091, false, true, true, "HasteRating", 8, "Stamina", 6 }, -- Forceful Forest Emerald
{ 40095, false, true, true, "CritRating", 8, "Spirit", 8 }, -- Misty Forest Emerald
{ 40098, false, true, true, "CritRating", 8, "SpellPenetration", 4 }, -- Radiant Forest Emerald
{ 40099, false, true, true, "CritRating", 8, "HasteRating", 8 }, -- Lightning Forest Emerald
{ 40102, false, true, true, "Spirit", 8, "ResilienceRating", 4 }, -- Turbid Forest Emerald
{ 40104, false, true, true, "HasteRating", 8, "Spirit", 8 }, -- Energized Forest Emerald
{ 40106, false, true, true, "HasteRating", 8, "SpellPenetration", 4 }, -- Shattered Forest Emerald


------------------------------------------------------------
-- Blue gems
------------------------------------------------------------

{ 40008, false, false, true, "Stamina", 12 }, -- Solid Sky Sapphire
{ 40009, false, false, true, "Spirit", 16 }, -- Sparkling Sky Sapphire
{ 40011, false, false, true, "SpellPenetration", 8 }, -- Stormy Sky Sapphire
{ 40014, false, false, true, "CritRating", 16 }, -- Rigid Sky Sapphire


------------------------------------------------------------
-- Purple gems
------------------------------------------------------------

{ 40022, true, false, true, "Strength", 4, "Stamina", 6 }, -- Sovereign Twilight Opal
{ 40023, true, false, true, "Stamina", 6, "Agility", 4 }, -- Shifting Twilight Opal
{ 40024, true, false, true, "CritRating", 8, "Agility", 4 }, -- Glinting Twilight Opal
{ 40025, true, false, true, "Intellect", 4, "Stamina", 6 }, -- Timeless Twilight Opal
{ 40026, true, false, true, "Intellect", 4, "Spirit", 8 }, -- Purified Twilight Opal
{ 40028, true, false, true, "Intellect", 4, "SpellPenetration", 4 }, -- Mysterious Twilight Opal
{ 40032, true, false, true, "Stamina", 6 }, -- Defender's Twilight Opal
{ 40034, true, false, true, "HasteRating", 8, "Stamina", 6 }, -- Guardian's Twilight Opal
{ 40038, true, false, true, "Strength", 4, "CritRating", 8 }, -- Etched Twilight Opal
{ 40049, true, false, true, "Intellect", 4, "CritRating", 8 }, -- Veiled Twilight Opal
{ 40058, true, false, true, "HasteRating", 8, "CritRating", 8 }, -- Accurate Twilight Opal


}


--========================================
-- Colored level 80 epic-quality gems
--========================================
local PawnGemData80Epic =
{


------------------------------------------------------------
-- Red gems
------------------------------------------------------------

{ 40111, true, false, false, "Strength", 10 }, -- Bold Cardinal Ruby
{ 40112, true, false, false, "Agility", 10 }, -- Delicate Cardinal Ruby
{ 40113, true, false, false, "Intellect", 10 }, -- Brilliant Cardinal Ruby
-- Flashing Cardinal Ruby (40116) had no recognized stats
{ 40118, true, false, false, "HasteRating", 20 }, -- Precise Cardinal Ruby


------------------------------------------------------------
-- Orange gems
------------------------------------------------------------

{ 40142, true, true, false, "Strength", 5, "CritRating", 10 }, -- Inscribed Ametrine
{ 40144, true, true, false, "Strength", 5 }, -- Champion's Ametrine
{ 40145, true, true, false, "Strength", 5, "ResilienceRating", 5 }, -- Resplendent Ametrine
{ 40146, true, true, false, "Strength", 5, "HasteRating", 10 }, -- Fierce Ametrine
{ 40147, true, true, false, "CritRating", 10, "Agility", 5 }, -- Deadly Ametrine
{ 40149, true, true, false, "ResilienceRating", 5, "Agility", 5 }, -- Lucent Ametrine
{ 40150, true, true, false, "HasteRating", 10, "Agility", 5 }, -- Deft Ametrine
{ 40152, true, true, false, "Intellect", 5, "CritRating", 10 }, -- Potent Ametrine
{ 40154, true, true, false, "Intellect", 5, "ResilienceRating", 5 }, -- Willful Ametrine
{ 40155, true, true, false, "Intellect", 5, "HasteRating", 10 }, -- Reckless Ametrine
-- Stalwart Ametrine (40160) had no recognized stats
{ 40163, true, true, false, "HasteRating", 10 }, -- Resolute Ametrine


------------------------------------------------------------
-- Yellow gems
------------------------------------------------------------

-- Subtle King's Amber (40115) had no recognized stats
{ 40117, false, true, false, "CritRating", 20 }, -- Smooth King's Amber
{ 40127, false, true, false, "ResilienceRating", 10 }, -- Mystic King's Amber
{ 40128, false, true, false, "HasteRating", 20 }, -- Quick King's Amber


------------------------------------------------------------
-- Green gems
------------------------------------------------------------

{ 40138, false, true, true, "Stamina", 8 }, -- Regal Eye of Zul
{ 40140, false, true, true, "CritRating", 10, "Stamina", 8 }, -- Jagged Eye of Zul
{ 40166, false, true, true, "CritRating", 10 }, -- Nimble Eye of Zul
{ 40168, false, true, true, "Stamina", 8, "ResilienceRating", 5 }, -- Steady Eye of Zul
{ 40169, false, true, true, "HasteRating", 10, "Stamina", 8 }, -- Forceful Eye of Zul
{ 40171, false, true, true, "CritRating", 10, "Spirit", 10 }, -- Misty Eye of Zul
{ 40172, false, true, true, "CritRating", 10, "HasteRating", 10 }, -- Lightning Eye of Zul
{ 40173, false, true, true, "Spirit", 10, "ResilienceRating", 5 }, -- Turbid Eye of Zul
{ 40174, false, true, true, "HasteRating", 10, "Spirit", 10 }, -- Energized Eye of Zul
{ 40180, false, true, true, "CritRating", 10, "SpellPenetration", 5 }, -- Radiant Eye of Zul
{ 40182, false, true, true, "HasteRating", 10, "SpellPenetration", 5 }, -- Shattered Eye of Zul


------------------------------------------------------------
-- Blue gems
------------------------------------------------------------

{ 40119, false, false, true, "Stamina", 12 }, -- Solid Majestic Zircon
{ 40120, false, false, true, "Spirit", 20 }, -- Sparkling Majestic Zircon
{ 40122, false, false, true, "SpellPenetration", 10 }, -- Stormy Majestic Zircon
{ 40125, false, false, true, "CritRating", 20 }, -- Rigid Majestic Zircon


------------------------------------------------------------
-- Purple gems
------------------------------------------------------------

{ 40129, true, false, true, "Strength", 5, "Stamina", 8 }, -- Sovereign Dreadstone
{ 40130, true, false, true, "Stamina", 8, "Agility", 5 }, -- Shifting Dreadstone
{ 40131, true, false, true, "CritRating", 10, "Agility", 5 }, -- Glinting Dreadstone
{ 40132, true, false, true, "Intellect", 5, "Stamina", 8 }, -- Timeless Dreadstone
{ 40133, true, false, true, "Intellect", 5, "Spirit", 10 }, -- Purified Dreadstone
{ 40135, true, false, true, "Intellect", 5, "SpellPenetration", 5 }, -- Mysterious Dreadstone
{ 40139, true, false, true, "Stamina", 8 }, -- Defender's Dreadstone
{ 40141, true, false, true, "HasteRating", 10, "Stamina", 8 }, -- Guardian's Dreadstone
{ 40143, true, false, true, "Strength", 5, "CritRating", 10 }, -- Etched Dreadstone
{ 40153, true, false, true, "Intellect", 5, "CritRating", 10 }, -- Veiled Dreadstone
{ 40162, true, false, true, "HasteRating", 10, "CritRating", 10 }, -- Accurate Dreadstone


}


--========================================
-- Level 80 crafted meta gems
--========================================
local PawnMetaGemData80Rare =
{


------------------------------------------------------------
-- Meta gems: Earthsiege
------------------------------------------------------------

{ 41380, false, false, false, "Stamina", 16, "MetaSocketEffect", 1 }, -- Austere Earthsiege Diamond
{ 41381, false, false, false, "CritRating", 21, "MetaSocketEffect", 1 }, -- Persistent Earthsiege Diamond
{ 41382, false, false, false, "Intellect", 11, "MetaSocketEffect", 1 }, -- Trenchant Earthsiege Diamond
{ 41385, false, false, false, "HasteRating", 21, "MetaSocketEffect", 1 }, -- Invigorating Earthsiege Diamond
{ 41389, false, false, false, "CritRating", 21, "MetaSocketEffect", 1 }, -- Beaming Earthsiege Diamond
{ 41395, false, false, false, "Intellect", 11, "MetaSocketEffect", 1 }, -- Bracing Earthsiege Diamond
{ 41396, false, false, false, "MetaSocketEffect", 1 }, -- Eternal Earthsiege Diamond
{ 41397, false, false, false, "Stamina", 16, "MetaSocketEffect", 1 }, -- Powerful Earthsiege Diamond
{ 41398, false, false, false, "MetaSocketEffect", 1, "Agility", 11 }, -- Relentless Earthsiege Diamond
{ 41401, false, false, false, "Intellect", 11, "MetaSocketEffect", 1 }, -- Insightful Earthsiege Diamond


------------------------------------------------------------
-- Meta gems: Skyflare
------------------------------------------------------------

{ 41285, false, false, false, "CritRating", 21, "MetaSocketEffect", 1 }, -- Chaotic Skyflare Diamond
{ 41307, false, false, false, "CritRating", 25, "MetaSocketEffect", 1 }, -- Destructive Skyflare Diamond
{ 41333, false, false, false, "Intellect", 11, "MetaSocketEffect", 1 }, -- Ember Skyflare Diamond
{ 41335, false, false, false, "MetaSocketEffect", 1 }, -- Enigmatic Skyflare Diamond
{ 41339, false, false, false, "CritRating", 21, "MetaSocketEffect", 1 }, -- Swift Skyflare Diamond
{ 41375, false, false, false, "Intellect", 11, "MetaSocketEffect", 1 }, -- Tireless Skyflare Diamond
{ 41376, false, false, false, "Spirit", 21, "MetaSocketEffect", 1 }, -- Revitalizing Skyflare Diamond
{ 41377, false, false, false, "Stamina", 16, "MetaSocketEffect", 1 }, -- Shielded Skyflare Diamond
{ 41378, false, false, false, "Intellect", 11, "MetaSocketEffect", 1 }, -- Forlorn Skyflare Diamond
{ 41379, false, false, false, "CritRating", 21, "MetaSocketEffect", 1 }, -- Impassive Skyflare Diamond
{ 41400, false, false, false, "MetaSocketEffect", 1 }, -- Thundering Skyflare Diamond


}


--========================================
-- Colored level 85 uncommon-quality gems
--========================================
local PawnGemData85Uncommon =
{


------------------------------------------------------------
-- Red gems
------------------------------------------------------------

{ 52081, true, false, false, "Strength", 6 }, -- Bold Carnelian
{ 52082, true, false, false, "Agility", 6 }, -- Delicate Carnelian
-- Flashing Carnelian (52083) had no recognized stats
{ 52084, true, false, false, "Intellect", 6 }, -- Brilliant Carnelian
{ 52085, true, false, false, "HasteRating", 12 }, -- Precise Carnelian


------------------------------------------------------------
-- Orange gems
------------------------------------------------------------

{ 52106, true, true, false, "Agility", 3 }, -- Polished Hessonite
{ 52107, true, true, false, "HasteRating", 6 }, -- Resolute Hessonite
{ 52108, true, true, false, "Strength", 3, "CritRating", 6 }, -- Inscribed Hessonite
{ 52109, true, true, false, "CritRating", 6, "Agility", 3 }, -- Deadly Hessonite
{ 52110, true, true, false, "Intellect", 3, "CritRating", 6 }, -- Potent Hessonite
{ 52111, true, true, false, "Strength", 3, "HasteRating", 6 }, -- Fierce Hessonite
{ 52112, true, true, false, "HasteRating", 6, "Agility", 3 }, -- Deft Hessonite
{ 52113, true, true, false, "Intellect", 3, "HasteRating", 6 }, -- Reckless Hessonite
{ 52114, true, true, false, "Strength", 3, "MasteryRating", 6 }, -- Skillful Hessonite
{ 52115, true, true, false, "MasteryRating", 6, "Agility", 3 }, -- Adept Hessonite
{ 52116, true, true, false, "MasteryRating", 6 }, -- Fine Hessonite
{ 52117, true, true, false, "Intellect", 3, "MasteryRating", 6 }, -- Artful Hessonite
{ 52118, true, true, false, "HasteRating", 6, "MasteryRating", 6 }, -- Keen Hessonite


------------------------------------------------------------
-- Yellow gems
------------------------------------------------------------

-- Subtle Alicite (52090) had no recognized stats
{ 52091, false, true, false, "CritRating", 12 }, -- Smooth Alicite
{ 52092, false, true, false, "ResilienceRating", 6 }, -- Mystic Alicite
{ 52093, false, true, false, "HasteRating", 12 }, -- Quick Alicite
{ 52094, false, true, false, "MasteryRating", 12 }, -- Fractured Alicite


------------------------------------------------------------
-- Green gems
------------------------------------------------------------

{ 52119, false, true, true, "Stamina", 5 }, -- Regal Jasper
{ 52120, false, true, true, "CritRating", 6 }, -- Nimble Jasper
{ 52121, false, true, true, "CritRating", 6, "Stamina", 5 }, -- Jagged Jasper
{ 52122, false, true, true, "CritRating", 12 }, -- Piercing Jasper
{ 52123, false, true, true, "Stamina", 5, "ResilienceRating", 3 }, -- Steady Jasper
{ 52124, false, true, true, "HasteRating", 6, "Stamina", 5 }, -- Forceful Jasper
{ 52125, false, true, true, "HasteRating", 6, "CritRating", 6 }, -- Lightning Jasper
{ 52126, false, true, true, "Stamina", 5, "MasteryRating", 6 }, -- Puissant Jasper
{ 52127, false, true, true, "Spirit", 6, "MasteryRating", 6 }, -- Zen Jasper
{ 52128, false, true, true, "CritRating", 6, "MasteryRating", 6 }, -- Sensei's Jasper


------------------------------------------------------------
-- Blue gems
------------------------------------------------------------

{ 52086, false, false, true, "Stamina", 9 }, -- Solid Zephyrite
{ 52087, false, false, true, "Spirit", 12 }, -- Sparkling Zephyrite
{ 52088, false, false, true, "SpellPenetration", 6 }, -- Stormy Zephyrite
{ 52089, false, false, true, "CritRating", 12 }, -- Rigid Zephyrite


------------------------------------------------------------
-- Purple gems
------------------------------------------------------------

{ 52095, true, false, true, "Strength", 3, "Stamina", 5 }, -- Sovereign Nightstone
{ 52096, true, false, true, "Stamina", 5, "Agility", 3 }, -- Shifting Nightstone
{ 52097, true, false, true, "Stamina", 5 }, -- Defender's Nightstone
{ 52098, true, false, true, "Intellect", 3, "Stamina", 5 }, -- Timeless Nightstone
{ 52099, true, false, true, "HasteRating", 6, "Stamina", 5 }, -- Guardian's Nightstone
{ 52100, true, false, true, "Intellect", 3, "Spirit", 6 }, -- Purified Nightstone
{ 52101, true, false, true, "Strength", 3, "CritRating", 6 }, -- Etched Nightstone
{ 52102, true, false, true, "CritRating", 6, "Agility", 3 }, -- Glinting Nightstone
{ 52103, true, false, true, "CritRating", 6 }, -- Retaliating Nightstone
{ 52104, true, false, true, "Intellect", 3, "CritRating", 6 }, -- Veiled Nightstone
{ 52105, true, false, true, "HasteRating", 6, "CritRating", 6 }, -- Accurate Nightstone


}


--========================================
-- Colored level 85 rare-quality gems
--========================================
local PawnGemData85Rare =
{


------------------------------------------------------------
-- Red gems
------------------------------------------------------------

{ 52206, true, false, false, "Strength", 8 }, -- Bold Inferno Ruby
{ 52207, true, false, false, "Intellect", 8 }, -- Brilliant Inferno Ruby
{ 52212, true, false, false, "Agility", 8 }, -- Delicate Inferno Ruby
-- Flashing Inferno Ruby (52216) had no recognized stats
{ 52230, true, false, false, "HasteRating", 16 }, -- Precise Inferno Ruby


------------------------------------------------------------
-- Orange gems
------------------------------------------------------------

{ 52204, true, true, false, "MasteryRating", 8, "Agility", 4 }, -- Adept Ember Topaz
{ 52205, true, true, false, "Intellect", 4, "MasteryRating", 8 }, -- Artful Ember Topaz
{ 52208, true, true, false, "Intellect", 4, "HasteRating", 8 }, -- Reckless Ember Topaz
{ 52209, true, true, false, "CritRating", 8, "Agility", 4 }, -- Deadly Ember Topaz
{ 52211, true, true, false, "HasteRating", 8, "Agility", 4 }, -- Deft Ember Topaz
{ 52214, true, true, false, "Strength", 4, "HasteRating", 8 }, -- Fierce Ember Topaz
{ 52215, true, true, false, "MasteryRating", 8 }, -- Fine Ember Topaz
{ 52222, true, true, false, "Strength", 4, "CritRating", 8 }, -- Inscribed Ember Topaz
{ 52224, true, true, false, "HasteRating", 8, "MasteryRating", 8 }, -- Keen Ember Topaz
{ 52229, true, true, false, "Agility", 4 }, -- Polished Ember Topaz
{ 52239, true, true, false, "Intellect", 4, "CritRating", 8 }, -- Potent Ember Topaz
{ 52240, true, true, false, "Strength", 4, "MasteryRating", 8 }, -- Skillful Ember Topaz
{ 52249, true, true, false, "HasteRating", 8 }, -- Resolute Ember Topaz
{ 68356, true, true, false, "Intellect", 4, "ResilienceRating", 4 }, -- Willful Ember Topaz
{ 68357, true, true, false, "ResilienceRating", 4, "Agility", 4 }, -- Lucent Ember Topaz
{ 68358, true, true, false, "Strength", 4, "ResilienceRating", 4 }, -- Resplendent Ember Topaz


------------------------------------------------------------
-- Yellow gems
------------------------------------------------------------

{ 52219, false, true, false, "MasteryRating", 16 }, -- Fractured Amberjewel
{ 52226, false, true, false, "ResilienceRating", 8 }, -- Mystic Amberjewel
{ 52232, false, true, false, "HasteRating", 16 }, -- Quick Amberjewel
{ 52241, false, true, false, "CritRating", 16 }, -- Smooth Amberjewel
-- Subtle Amberjewel (52247) had no recognized stats


------------------------------------------------------------
-- Green gems
------------------------------------------------------------

{ 52218, false, true, true, "HasteRating", 8, "Stamina", 6 }, -- Forceful Dream Emerald
{ 52223, false, true, true, "CritRating", 8, "Stamina", 6 }, -- Jagged Dream Emerald
{ 52225, false, true, true, "HasteRating", 8, "CritRating", 8 }, -- Lightning Dream Emerald
{ 52227, false, true, true, "CritRating", 8 }, -- Nimble Dream Emerald
{ 52228, false, true, true, "CritRating", 16 }, -- Piercing Dream Emerald
{ 52231, false, true, true, "Stamina", 6, "MasteryRating", 8 }, -- Puissant Dream Emerald
{ 52233, false, true, true, "Stamina", 6 }, -- Regal Dream Emerald
{ 52237, false, true, true, "CritRating", 8, "MasteryRating", 8 }, -- Sensei's Dream Emerald
{ 52245, false, true, true, "Stamina", 6, "ResilienceRating", 4 }, -- Steady Dream Emerald
{ 52250, false, true, true, "Spirit", 8, "MasteryRating", 8 }, -- Zen Dream Emerald


------------------------------------------------------------
-- Blue gems
------------------------------------------------------------

{ 52235, false, false, true, "CritRating", 16 }, -- Rigid Ocean Sapphire
{ 52242, false, false, true, "Stamina", 12 }, -- Solid Ocean Sapphire
{ 52244, false, false, true, "Spirit", 16 }, -- Sparkling Ocean Sapphire
{ 52246, false, false, true, "SpellPenetration", 8 }, -- Stormy Ocean Sapphire


------------------------------------------------------------
-- Purple gems
------------------------------------------------------------

{ 52203, true, false, true, "HasteRating", 8, "CritRating", 8 }, -- Accurate Demonseye
{ 52210, true, false, true, "Stamina", 4 }, -- Defender's Demonseye
{ 52213, true, false, true, "Strength", 4, "CritRating", 8 }, -- Etched Demonseye
{ 52217, true, false, true, "Intellect", 4, "CritRating", 8 }, -- Veiled Demonseye
{ 52220, true, false, true, "CritRating", 8, "Agility", 4 }, -- Glinting Demonseye
{ 52221, true, false, true, "HasteRating", 8, "Stamina", 6 }, -- Guardian's Demonseye
{ 52234, true, false, true, "CritRating", 8 }, -- Retaliating Demonseye
{ 52236, true, false, true, "Intellect", 4, "Spirit", 8 }, -- Purified Demonseye
{ 52238, true, false, true, "Stamina", 6, "Agility", 4 }, -- Shifting Demonseye
{ 52243, true, false, true, "Strength", 4, "Stamina", 6 }, -- Sovereign Demonseye
{ 52248, true, false, true, "Intellect", 4, "Stamina", 6 }, -- Timeless Demonseye


}


--========================================
-- Colored level 85 epic-quality gems
--========================================
local PawnGemData85Epic =
{

------------------------------------------------------------
-- Red gems
------------------------------------------------------------

{ 71879, true, false, false, "Agility", 10 }, -- Delicate Queen's Garnet
{ 71880, true, false, false, "HasteRating", 20 }, -- Precise Queen's Garnet
{ 71881, true, false, false, "Intellect", 10 }, -- Brilliant Queen's Garnet
-- Flashing Queen's Garnet (71882) had no recognized stats
{ 71883, true, false, false, "Strength", 10 }, -- Bold Queen's Garnet


------------------------------------------------------------
-- Orange gems
------------------------------------------------------------

{ 71840, true, true, false, "CritRating", 10, "Agility", 5 }, -- Deadly Lava Coral
{ 71841, true, true, false, "HasteRating", 10, "CritRating", 10 }, -- Crafty Lava Coral
{ 71842, true, true, false, "Intellect", 5, "CritRating", 10 }, -- Potent Lava Coral
{ 71843, true, true, false, "Strength", 5, "CritRating", 10 }, -- Inscribed Lava Coral
{ 71844, true, true, false, "Agility", 5 }, -- Polished Lava Coral
{ 71845, true, true, false, "HasteRating", 10 }, -- Resolute Lava Coral
-- Stalwart Lava Coral (71846) had no recognized stats
{ 71847, true, true, false, "Strength", 5 }, -- Champion's Lava Coral
{ 71848, true, true, false, "HasteRating", 10, "Agility", 5 }, -- Deft Lava Coral
{ 71849, true, true, false, "HasteRating", 10 }, -- Wicked Lava Coral
{ 71850, true, true, false, "Intellect", 5, "HasteRating", 10 }, -- Reckless Lava Coral
{ 71851, true, true, false, "Strength", 5, "HasteRating", 10 }, -- Fierce Lava Coral
{ 71852, true, true, false, "MasteryRating", 10, "Agility", 5 }, -- Adept Lava Coral
{ 71853, true, true, false, "HasteRating", 10, "MasteryRating", 10 }, -- Keen Lava Coral
{ 71854, true, true, false, "Intellect", 5, "MasteryRating", 10 }, -- Artful Lava Coral
{ 71855, true, true, false, "MasteryRating", 10 }, -- Fine Lava Coral
{ 71856, true, true, false, "Strength", 5, "MasteryRating", 10 }, -- Skillful Lava Coral
{ 71857, true, true, false, "ResilienceRating", 5, "Agility", 5 }, -- Lucent Lava Coral
{ 71858, true, true, false, "HasteRating", 10, "ResilienceRating", 5 }, -- Tenuous Lava Coral
{ 71859, true, true, false, "Intellect", 5, "ResilienceRating", 5 }, -- Willful Lava Coral
{ 71860, true, true, false, "ResilienceRating", 5 }, -- Splendid Lava Coral
{ 71861, true, true, false, "Strength", 5, "ResilienceRating", 5 }, -- Resplendent Lava Coral


------------------------------------------------------------
-- Yellow gems
------------------------------------------------------------

{ 71874, false, true, false, "CritRating", 20 }, -- Smooth Lightstone
-- Subtle Lightstone (71875) had no recognized stats
{ 71876, false, true, false, "HasteRating", 20 }, -- Quick Lightstone
{ 71877, false, true, false, "MasteryRating", 20 }, -- Fractured Lightstone
{ 71878, false, true, false, "ResilienceRating", 10 }, -- Mystic Lightstone


------------------------------------------------------------
-- Green gems
------------------------------------------------------------

{ 71822, false, true, true, "Spirit", 10, "CritRating", 10 }, -- Misty Elven Peridot
{ 71823, false, true, true, "CritRating", 20 }, -- Piercing Elven Peridot
{ 71824, false, true, true, "HasteRating", 10, "CritRating", 10 }, -- Lightning Elven Peridot
{ 71825, false, true, true, "CritRating", 10, "MasteryRating", 10 }, -- Sensei's Elven Peridot
{ 71826, false, true, true, "SpellPenetration", 5, "MasteryRating", 10 }, -- Infused Elven Peridot
{ 71827, false, true, true, "Spirit", 10, "MasteryRating", 10 }, -- Zen Elven Peridot
{ 71828, false, true, true, "CritRating", 10, "ResilienceRating", 5 }, -- Balanced Elven Peridot
{ 71829, false, true, true, "SpellPenetration", 5, "ResilienceRating", 5 }, -- Vivid Elven Peridot
{ 71830, false, true, true, "Spirit", 10, "ResilienceRating", 5 }, -- Turbid Elven Peridot
{ 71831, false, true, true, "CritRating", 10, "SpellPenetration", 5 }, -- Radiant Elven Peridot
{ 71832, false, true, true, "HasteRating", 10, "SpellPenetration", 5 }, -- Shattered Elven Peridot
{ 71833, false, true, true, "HasteRating", 10, "Spirit", 10 }, -- Energized Elven Peridot
{ 71834, false, true, true, "CritRating", 10, "Stamina", 8 }, -- Jagged Elven Peridot
{ 71835, false, true, true, "Stamina", 8 }, -- Regal Elven Peridot
{ 71836, false, true, true, "HasteRating", 10, "Stamina", 8 }, -- Forceful Elven Peridot
{ 71837, false, true, true, "CritRating", 10 }, -- Nimble Elven Peridot
{ 71838, false, true, true, "Stamina", 8, "MasteryRating", 10 }, -- Puissant Elven Peridot
{ 71839, false, true, true, "Stamina", 8, "ResilienceRating", 5 }, -- Steady Elven Peridot


------------------------------------------------------------
-- Blue gems
------------------------------------------------------------

{ 71817, false, false, true, "CritRating", 20 }, -- Rigid Deepholm Iolite
{ 71820, false, false, true, "Stamina", 15 }, -- Solid Deepholm Iolite
{ 71819, false, false, true, "Spirit", 20 }, -- Sparkling Deepholm Iolite
{ 71818, false, false, true, "SpellPenetration", 20 }, -- Stormy Deepholm Iolite


------------------------------------------------------------
-- Purple gems
------------------------------------------------------------

{ 71862, true, false, true, "CritRating", 10, "Agility", 5 }, -- Glinting Shadow Spinel
{ 71863, true, false, true, "HasteRating", 10, "CritRating", 10 }, -- Accurate Shadow Spinel
{ 71864, true, false, true, "Intellect", 5, "CritRating", 10 }, -- Veiled Shadow Spinel
{ 71865, true, false, true, "CritRating", 10 }, -- Retaliating Shadow Spinel
{ 71866, true, false, true, "Strength", 5, "CritRating", 10 }, -- Etched Shadow Spinel
{ 71867, true, false, true, "Intellect", 5, "SpellPenetration", 5 }, -- Mysterious Shadow Spinel
{ 71868, true, false, true, "Intellect", 5, "Spirit", 10 }, -- Purified Shadow Spinel
{ 71869, true, false, true, "Stamina", 8, "Agility", 5 }, -- Shifting Shadow Spinel
{ 71870, true, false, true, "HasteRating", 10, "Stamina", 8 }, -- Guardian's Shadow Spinel
{ 71871, true, false, true, "Intellect", 5, "Stamina", 8 }, -- Timeless Shadow Spinel
{ 71872, true, false, true, "Stamina", 8 }, -- Defender's Shadow Spinel
{ 71873, true, false, true, "Strength", 5, "Stamina", 8 }, -- Sovereign Shadow Spinel


}


--========================================
-- Level 85 rare-quality cogwheels
--========================================
local PawnCogwheelData85Rare =
{


------------------------------------------------------------
-- Cogwheels
------------------------------------------------------------

{ 59477, false, false, false, "DodgeRating", 42 }, -- Subtle Cogwheel
{ 59478, false, false, false, "CritRating", 42 }, -- Smooth Cogwheel
{ 59479, false, false, false, "HasteRating", 42 }, -- Quick Cogwheel
{ 59480, false, false, false, "MasteryRating", 42 }, -- Fractured Cogwheel
{ 59489, false, false, false, "HasteRating", 42 }, -- Precise Cogwheel
{ 59491, false, false, false, "ParryRating", 42 }, -- Flashing Cogwheel
{ 59493, false, false, false, "CritRating", 42 }, -- Rigid Cogwheel
{ 59496, false, false, false, "Spirit", 42 }, -- Sparkling Cogwheel
{ 68660, false, false, false, "ResilienceRating", 42 }, -- Mystic Cogwheel


}


--========================================
-- Level 85 crafted meta gems
--========================================
local PawnMetaGemData85Rare =
{


------------------------------------------------------------
-- Meta gems: Shadowspirit
------------------------------------------------------------

{ 52289, false, false, false, "MetaSocketEffect", 1, "MasteryRating", 22 }, -- Fleet Shadowspirit Diamond
{ 52291, false, false, false, "CritRating", 22, "MetaSocketEffect", 1 }, -- Chaotic Shadowspirit Diamond
{ 52292, false, false, false, "Intellect", 11, "MetaSocketEffect", 1 }, -- Bracing Shadowspirit Diamond
{ 52293, false, false, false, "Stamina", 16, "MetaSocketEffect", 1 }, -- Eternal Shadowspirit Diamond
{ 52294, false, false, false, "Stamina", 16, "MetaSocketEffect", 1 }, -- Austere Shadowspirit Diamond
{ 52295, false, false, false, "Stamina", 16, "MetaSocketEffect", 1 }, -- Effulgent Shadowspirit Diamond
{ 52296, false, false, false, "Intellect", 11, "MetaSocketEffect", 1 }, -- Ember Shadowspirit Diamond
{ 52297, false, false, false, "Spirit", 22, "MetaSocketEffect", 1 }, -- Revitalizing Shadowspirit Diamond
{ 52298, false, false, false, "CritRating", 22, "MetaSocketEffect", 1 }, -- Destructive Shadowspirit Diamond
{ 52299, false, false, false, "Stamina", 16, "MetaSocketEffect", 1 }, -- Powerful Shadowspirit Diamond
{ 52300, false, false, false, "MetaSocketEffect", 1 }, -- Enigmatic Shadowspirit Diamond
{ 52301, false, false, false, "CritRating", 22, "MetaSocketEffect", 1 }, -- Impassive Shadowspirit Diamond
{ 52302, false, false, false, "Intellect", 11, "MetaSocketEffect", 1 }, -- Forlorn Shadowspirit Diamond


}


--========================================
-- Colored level 90 uncommon-quality gems
--========================================
local PawnGemData90Uncommon =
{


------------------------------------------------------------
-- Red gems
------------------------------------------------------------

{ 76560, true, false, false, "Agility", 8 }, -- Delicate Pandarian Garnet
{ 76561, true, false, false, "HasteRating", 16 }, -- Precise Pandarian Garnet
{ 76562, true, false, false, "Intellect", 8 }, -- Brilliant Pandarian Garnet
-- Flashing Pandarian Garnet (76563) had no recognized stats
{ 76564, true, false, false, "Strength", 8 }, -- Bold Pandarian Garnet


------------------------------------------------------------
-- Orange gems
------------------------------------------------------------

{ 76526, true, true, false, "CritRating", 8, "Agility", 4 }, -- Deadly Tiger Opal
{ 76527, true, true, false, "HasteRating", 8, "CritRating", 8 }, -- Crafty Tiger Opal
{ 76528, true, true, false, "Intellect", 4, "CritRating", 8 }, -- Potent Tiger Opal
{ 76529, true, true, false, "Strength", 4, "CritRating", 8 }, -- Inscribed Tiger Opal
{ 76530, true, true, false, "Agility", 4 }, -- Polished Tiger Opal
{ 76531, true, true, false, "HasteRating", 8 }, -- Resolute Tiger Opal
-- Stalwart Tiger Opal (76532) had no recognized stats
{ 76533, true, true, false, "Strength", 4 }, -- Champion's Tiger Opal
{ 76534, true, true, false, "HasteRating", 8, "Agility", 4 }, -- Deft Tiger Opal
{ 76535, true, true, false, "HasteRating", 16 }, -- Wicked Tiger Opal
{ 76536, true, true, false, "Intellect", 4, "HasteRating", 8 }, -- Reckless Tiger Opal
{ 76537, true, true, false, "Strength", 4, "HasteRating", 8 }, -- Fierce Tiger Opal
{ 76538, true, true, false, "MasteryRating", 8, "Agility", 4 }, -- Adept Tiger Opal
{ 76539, true, true, false, "HasteRating", 8, "MasteryRating", 8 }, -- Keen Tiger Opal
{ 76540, true, true, false, "Intellect", 4, "MasteryRating", 8 }, -- Artful Tiger Opal
{ 76541, true, true, false, "MasteryRating", 8 }, -- Fine Tiger Opal
{ 76542, true, true, false, "Strength", 4, "MasteryRating", 8 }, -- Skillful Tiger Opal
{ 76543, true, true, false, "ResilienceRating", 4, "Agility", 4 }, -- Lucent Tiger Opal
{ 76544, true, true, false, "HasteRating", 8, "ResilienceRating", 4 }, -- Tenuous Tiger Opal
{ 76545, true, true, false, "Intellect", 4, "ResilienceRating", 4 }, -- Willful Tiger Opal
{ 76546, true, true, false, "ResilienceRating", 4 }, -- Splendid Tiger Opal
{ 76547, true, true, false, "Strength", 4, "ResilienceRating", 4 }, -- Resplendent Tiger Opal


------------------------------------------------------------
-- Yellow gems
------------------------------------------------------------

{ 76565, false, true, false, "CritRating", 16 }, -- Smooth Sunstone
-- Subtle Sunstone (76566) had no recognized stats
{ 76567, false, true, false, "HasteRating", 16 }, -- Quick Sunstone
{ 76568, false, true, false, "MasteryRating", 16 }, -- Fractured Sunstone
{ 76569, false, true, false, "ResilienceRating", 8 }, -- Mystic Sunstone


------------------------------------------------------------
-- Green gems
------------------------------------------------------------

{ 76507, false, true, true, "Spirit", 8, "CritRating", 8 }, -- Misty Alexandrite
{ 76508, false, true, true, "CritRating", 16 }, -- Piercing Alexandrite
{ 76509, false, true, true, "HasteRating", 8, "CritRating", 8 }, -- Lightning Alexandrite
{ 76510, false, true, true, "CritRating", 8, "MasteryRating", 8 }, -- Sensei's Alexandrite
{ 76511, false, true, true, "SpellPenetration", 4, "MasteryRating", 8 }, -- Effulgent Alexandrite
{ 76512, false, true, true, "Spirit", 8, "MasteryRating", 5 }, -- Zen Alexandrite
{ 76513, false, true, true, "CritRating", 8, "ResilienceRating", 4 }, -- Balanced Alexandrite
{ 76514, false, true, true, "SpellPenetration", 4, "ResilienceRating", 4 }, -- Vivid Alexandrite
{ 76515, false, true, true, "Spirit", 8, "ResilienceRating", 4 }, -- Turbid Alexandrite
{ 76517, false, true, true, "CritRating", 8, "SpellPenetration", 4 }, -- Radiant Alexandrite
{ 76518, false, true, true, "HasteRating", 8, "SpellPenetration", 4 }, -- Shattered Alexandrite
{ 76519, false, true, true, "HasteRating", 8, "Spirit", 8 }, -- Energized Alexandrite
{ 76520, false, true, true, "CritRating", 8, "Stamina", 6 }, -- Jagged Alexandrite
{ 76521, false, true, true, "Stamina", 6 }, -- Regal Alexandrite
{ 76522, false, true, true, "HasteRating", 8, "Stamina", 6 }, -- Forceful Alexandrite
{ 76523, false, true, true, "CritRating", 8, "Stamina", 6 }, -- Confounded Alexandrite
{ 76524, false, true, true, "Stamina", 6, "MasteryRating", 8 }, -- Puissant Alexandrite
{ 76525, false, true, true, "Stamina", 6, "ResilienceRating", 4 }, -- Steady Alexandrite


------------------------------------------------------------
-- Blue gems
------------------------------------------------------------

{ 76502, false, false, true, "CritRating", 16 }, -- Rigid Lapis Lazuli
{ 76504, false, false, true, "SpellPenetration", 8 }, -- Stormy Lapis Lazuli
{ 76505, false, false, true, "Spirit", 16 }, -- Sparkling Lapis Lazuli
{ 76506, false, false, true, "Stamina", 12 }, -- Solid Lapis Lazuli


------------------------------------------------------------
-- Purple gems
------------------------------------------------------------

{ 76548, true, false, true, "CritRating", 8, "Agility", 4 }, -- Glinting Roguestone
{ 76549, true, false, true, "HasteRating", 8, "CritRating", 8 }, -- Accurate Roguestone
{ 76550, true, false, true, "Intellect", 4, "CritRating", 8 }, -- Veiled Roguestone
{ 76551, true, false, true, "CritRating", 8 }, -- Retaliating Roguestone
{ 76552, true, false, true, "Strength", 4, "CritRating", 8 }, -- Etched Roguestone
{ 76553, true, false, true, "Intellect", 4, "SpellPenetration", 4 }, -- Mysterious Roguestone
{ 76554, true, false, true, "Intellect", 4, "Spirit", 8 }, -- Purified Roguestone
{ 76555, true, false, true, "Stamina", 6, "Agility", 4 }, -- Shifting Roguestone
{ 76556, true, false, true, "HasteRating", 8, "Stamina", 6 }, -- Guardian's Roguestone
{ 76557, true, false, true, "Intellect", 4, "Stamina", 6 }, -- Timeless Roguestone
{ 76558, true, false, true, "Stamina", 6 }, -- Defender's Roguestone
{ 76559, true, false, true, "Strength", 4, "Stamina", 6 }, -- Sovereign Roguestone


}


--========================================
-- Colored level 90 rare-quality gems
--========================================
local PawnGemData90Rare =
{


------------------------------------------------------------
-- Red gems
------------------------------------------------------------

{ 76692, true, false, false, "Agility", 10 }, -- Delicate Primordial Ruby
{ 76693, true, false, false, "HasteRating", 20 }, -- Precise Primordial Ruby
{ 76694, true, false, false, "Intellect", 10 }, -- Brilliant Primordial Ruby
-- Flashing Primordial Ruby (76695) had no recognized stats
{ 76696, true, false, false, "Strength", 10 }, -- Bold Primordial Ruby


------------------------------------------------------------
-- Orange gems
------------------------------------------------------------

{ 76658, true, true, false, "CritRating", 10, "Agility", 5 }, -- Deadly Vermilion Onyx
{ 76659, true, true, false, "HasteRating", 10, "CritRating", 10 }, -- Crafty Vermilion Onyx
{ 76660, true, true, false, "Intellect", 5, "CritRating", 10 }, -- Potent Vermilion Onyx
{ 76661, true, true, false, "Strength", 5, "CritRating", 10 }, -- Inscribed Vermilion Onyx
{ 76662, true, true, false, "Agility", 5 }, -- Polished Vermilion Onyx
{ 76663, true, true, false, "HasteRating", 10 }, -- Resolute Vermilion Onyx
-- Stalwart Vermilion Onyx (76664) had no recognized stats
{ 76665, true, true, false, "Strength", 5 }, -- Champion's Vermilion Onyx
{ 76666, true, true, false, "HasteRating", 10, "Agility", 5 }, -- Deft Vermilion Onyx
{ 76667, true, true, false, "HasteRating", 20 }, -- Wicked Vermilion Onyx
{ 76668, true, true, false, "Intellect", 5, "HasteRating", 10 }, -- Reckless Vermilion Onyx
{ 76669, true, true, false, "Strength", 5, "HasteRating", 10 }, -- Fierce Vermilion Onyx
{ 76670, true, true, false, "MasteryRating", 10, "Agility", 5 }, -- Adept Vermilion Onyx
{ 76671, true, true, false, "HasteRating", 10, "MasteryRating", 10 }, -- Keen Vermilion Onyx
{ 76672, true, true, false, "Intellect", 5, "MasteryRating", 10 }, -- Artful Vermilion Onyx
{ 76673, true, true, false, "MasteryRating", 10 }, -- Fine Vermilion Onyx
{ 76674, true, true, false, "Strength", 5, "MasteryRating", 10 }, -- Skillful Vermilion Onyx
{ 76675, true, true, false, "ResilienceRating", 5, "Agility", 5 }, -- Lucent Vermilion Onyx
{ 76676, true, true, false, "HasteRating", 10, "ResilienceRating", 5 }, -- Tenuous Vermilion Onyx
{ 76677, true, true, false, "Intellect", 5, "ResilienceRating", 5 }, -- Willful Vermilion Onyx
{ 76678, true, true, false, "ResilienceRating", 5 }, -- Splendid Vermilion Onyx
{ 76679, true, true, false, "Strength", 5, "ResilienceRating", 5 }, -- Resplendent Vermilion Onyx


------------------------------------------------------------
-- Yellow gems
------------------------------------------------------------

{ 76697, false, true, false, "CritRating", 20 }, -- Smooth Sun's Radiance
-- Subtle Sun's Radiance (76698) had no recognized stats
{ 76699, false, true, false, "HasteRating", 20 }, -- Quick Sun's Radiance
{ 76700, false, true, false, "MasteryRating", 20 }, -- Fractured Sun's Radiance
{ 76701, false, true, false, "ResilienceRating", 10 }, -- Mystic Sun's Radiance


------------------------------------------------------------
-- Green gems
------------------------------------------------------------

{ 76640, false, true, true, "Spirit", 10, "CritRating", 10 }, -- Misty Wild Jade
{ 76641, false, true, true, "CritRating", 10 }, -- Piercing Wild Jade
{ 76642, false, true, true, "HasteRating", 10, "CritRating", 10 }, -- Lightning Wild Jade
{ 76643, false, true, true, "CritRating", 10, "MasteryRating", 10 }, -- Sensei's Wild Jade
{ 76644, false, true, true, "SpellPenetration", 5, "MasteryRating", 10 }, -- Effulgent Wild Jade
{ 76645, false, true, true, "Spirit", 10, "MasteryRating", 10 }, -- Zen Wild Jade
{ 76646, false, true, true, "CritRating", 10, "ResilienceRating", 5 }, -- Balanced Wild Jade
{ 76647, false, true, true, "SpellPenetration", 5, "ResilienceRating", 5 }, -- Vivid Wild Jade
{ 76648, false, true, true, "Spirit", 10, "ResilienceRating", 5 }, -- Turbid Wild Jade
{ 76649, false, true, true, "CritRating", 10, "SpellPenetration", 5 }, -- Radiant Wild Jade
{ 76650, false, true, true, "HasteRating", 10, "SpellPenetration", 5 }, -- Shattered Wild Jade
{ 76651, false, true, true, "HasteRating", 10, "Spirit", 10 }, -- Energized Wild Jade
{ 76652, false, true, true, "CritRating", 10, "Stamina", 8 }, -- Jagged Wild Jade
{ 76653, false, true, true, "Stamina", 8 }, -- Regal Wild Jade
{ 76654, false, true, true, "HasteRating", 10, "Stamina", 8 }, -- Forceful Wild Jade
{ 76655, false, true, true, "CritRating", 10, "Stamina", 8 }, -- Confounded Wild Jade
{ 76656, false, true, true, "Stamina", 8, "MasteryRating", 10 }, -- Puissant Wild Jade
{ 76657, false, true, true, "Stamina", 8, "ResilienceRating", 5 }, -- Steady Wild Jade


------------------------------------------------------------
-- Blue gems
------------------------------------------------------------

{ 76636, false, false, true, "CritRating", 20 }, -- Rigid River's Heart
{ 76637, false, false, true, "SpellPenetration", 10 }, -- Stormy River's Heart
{ 76638, false, false, true, "Spirit", 20 }, -- Sparkling River's Heart
{ 76639, false, false, true, "Stamina", 15 }, -- Solid River's Heart


------------------------------------------------------------
-- Purple gems
------------------------------------------------------------

{ 76680, true, false, true, "CritRating", 10, "Agility", 5 }, -- Glinting Imperial Amethyst
{ 76681, true, false, true, "HasteRating", 10, "CritRating", 10 }, -- Accurate Imperial Amethyst
{ 76682, true, false, true, "Intellect", 5, "CritRating", 10 }, -- Veiled Imperial Amethyst
{ 76683, true, false, true, "CritRating", 10 }, -- Retaliating Imperial Amethyst
{ 76684, true, false, true, "Strength", 5, "CritRating", 10 }, -- Etched Imperial Amethyst
{ 76685, true, false, true, "Intellect", 5, "SpellPenetration", 5 }, -- Mysterious Imperial Amethyst
{ 76686, true, false, true, "Intellect", 5, "Spirit", 10 }, -- Purified Imperial Amethyst
{ 76687, true, false, true, "Stamina", 8, "Agility", 5 }, -- Shifting Imperial Amethyst
{ 76688, true, false, true, "HasteRating", 10, "Stamina", 8 }, -- Guardian's Imperial Amethyst
{ 76689, true, false, true, "Intellect", 5, "Stamina", 8 }, -- Timeless Imperial Amethyst
{ 76690, true, false, true, "Stamina", 8 }, -- Defender's Imperial Amethyst
{ 76691, true, false, true, "Strength", 5, "Stamina", 8 }, -- Sovereign Imperial Amethyst


}


--========================================
-- Level 90 rare-quality cogwheels
--========================================
local PawnCogwheelData90Rare =
{


------------------------------------------------------------
-- Cogwheels
------------------------------------------------------------

{ 77540, false, false, false, "DodgeRating", 38 }, -- Subtle Tinker's Gear
{ 77541, false, false, false, "CritRating", 38 }, -- Smooth Tinker's Gear
{ 77542, false, false, false, "HasteRating", 38 }, -- Quick Tinker's Gear
{ 77543, false, false, false, "ExpertiseRating", 38 }, -- Precise Tinker's Gear
{ 77544, false, false, false, "ParryRating", 38 }, -- Flashing Tinker's Gear
{ 77545, false, false, false, "HitRating", 38 }, -- Rigid Tinker's Gear
{ 77546, false, false, false, "Spirit", 38 }, -- Sparkling Tinker's Gear
{ 77547, false, false, false, "MasteryRating", 38 }, -- Fractured Tinker's Gear


}


--========================================
-- Level 90 legendary-quality crystals of fear
--========================================
local PawnCrystalOfFearData90Legendary =
{


------------------------------------------------------------
-- Crystals of Fear (5.0)
------------------------------------------------------------

{ 89873, false, false, false, "Agility", 31 }, -- Crystallized Dread
{ 89881, false, false, false, "Strength", 31 }, -- Crystallized Terror
{ 89882, false, false, false, "Intellect", 31 }, -- Crystallized Horror


}


--========================================
-- Level 90 crafted meta gems
--========================================
local PawnMetaGemData90Rare =
{


------------------------------------------------------------
-- Meta gems: Primal
------------------------------------------------------------

{ 76879, false, false, false, "Intellect", 14, "MetaSocketEffect", 1 }, -- Ember Primal Diamond
{ 76884, false, false, false, "MetaSocketEffect", 1, "Agility", 14 }, -- Agile Primal Diamond
{ 76885, false, false, false, "Intellect", 14, "MetaSocketEffect", 1 }, -- Burning Primal Diamond
{ 76886, false, false, false, "Strength", 14, "MetaSocketEffect", 1 }, -- Reverberating Primal Diamond
{ 76887, false, false, false, "MetaSocketEffect", 1, "MasteryRating", 27 }, -- Fleet Primal Diamond
{ 76888, false, false, false, "Spirit", 27, "MetaSocketEffect", 1 }, -- Revitalizing Primal Diamond
{ 76890, false, false, false, "CritRating", 27, "MetaSocketEffect", 1 }, -- Destructive Primal Diamond
{ 76891, false, false, false, "Stamina", 20, "MetaSocketEffect", 1 }, -- Powerful Primal Diamond
{ 76892, false, false, false, "CritRating", 27, "MetaSocketEffect", 1 }, -- Enigmatic Primal Diamond
{ 76893, false, false, false, "CritRating", 27, "MetaSocketEffect", 1 }, -- Impassive Primal Diamond
{ 76894, false, false, false, "Intellect", 14, "MetaSocketEffect", 1 }, -- Forlorn Primal Diamond
{ 76895, false, false, false, "Stamina", 20, "MetaSocketEffect", 1 }, -- Austere Primal Diamond
{ 76896, false, false, false, "DodgeRating", 27, "MetaSocketEffect", 1 }, -- Eternal Primal Diamond
{ 76897, false, false, false, "Stamina", 20, "MetaSocketEffect", 1 }, -- Effulgent Primal Diamond


}


--========================================
-- Level 100 crafted uncommon prismatic gems
--========================================
local PawnGemData100Uncommon =
{


{ 115803, true, true, true, "CritRating", 35 }, -- Critical Strike Taladite
{ 115804, true, true, true, "HasteRating", 35 }, -- Haste Taladite
{ 115805, true, true, true, "MasteryRating", 35 }, -- Mastery Taladite
{ 115806, true, true, true, "Multistrike", 35 }, -- Multistrike Taladite
{ 115807, true, true, true, "Versatility", 35 }, -- Versatility Taladite
{ 115808, true, true, true, "Stamina", 35 }, -- Stamina Taladite


}


--========================================
-- Level 100 crafted rare prismatic gems
--========================================
local PawnGemData100Rare =
{


{ 115809, true, true, true, "CritRating", 50 }, -- Greater Critical Strike Taladite
{ 115811, true, true, true, "HasteRating", 50 }, -- Greater Haste Taladite
{ 115812, true, true, true, "MasteryRating", 50 }, -- Greater Mastery Taladite
{ 115813, true, true, true, "Multistrike", 50 }, -- Greater Multistrike Taladite
{ 115814, true, true, true, "Versatility", 50 }, -- Greater Versatility Taladite
{ 115815, true, true, true, "Stamina", 50 }, -- Greater Stamina Taladite


}


--========================================

-- The master list of all tables of Pawn gem data

-- Gem data metatable row format:
-- { MinItemLevel, GemData }
-- 	MinItemLevel: Minimum item level required to use that gem quality level (inclusive)
-- 	GemData: The table of gem data (as specified above)

-- The rows must be specified in descending MinItemLevel order, with the last row
-- in each table having MinItemLevel 0.

PawnGemQualityLevels =
{
	{ 640, PawnGemData100Rare }, -- Warlords of Draenor epics
	{ 600, PawnGemData100Uncommon }, -- Actual gem requirement
	{ 463, PawnGemData90Rare }, -- Mists of Pandaria heroics
	{ 417, PawnGemData90Uncommon }, -- Actual gem requirement
	{ 397, PawnGemData85Epic }, -- Dragon Soul normal mode
	{ 346, PawnGemData85Rare }, -- Wrath heroics
	{ 308, PawnGemData85Uncommon }, -- Wrath of the Lich King dungeons
	{ 232, PawnGemData80Epic }, -- Tier 9 epics
	{ 200, PawnGemData80Rare }, -- Wrath of the Lich King heroics
	{ 145, PawnGemData80Uncommon }, -- Sea King's Crown, worst Wrath socketed green
	{ 141, PawnGemData70Epic }, -- Tier 5 epics
	{ 112, PawnGemData70Rare }, -- Burning Crusade level 70 non-heroics
	{ 0, PawnGemData70Uncommon },
}

PawnMetaGemQualityLevels =
{
	{ 417, PawnMetaGemData90Rare }, -- Actual gem requirement
	{ 333, PawnMetaGemData85Rare }, -- Helm of the Skyborne
	{ 200, PawnMetaGemData80Rare }, -- Helmet of the Shrine
	{ 0, PawnMetaGemData70Rare }, -- Exorcist's
}

PawnCogwheelQualityLevels =
{
	{ 417, PawnCogwheelData90Rare }, -- Actual gem requirement; Ghost Iron Dragonling is 450
	{ 0, PawnCogwheelData85Rare }, -- Bio-Optic Killshades
}

-- *** Remove this in Warlords of Draenor
PawnCrystalOfFearQualityLevels =
{
	{ 0, PawnCrystalOfFearData90Legendary }, -- Kri'tak
}
