local addonName, ptable = ...
ptable.CONST = {}
local C = ptable.CONST

local weapon = {GetAuctionItemSubClasses(1)}
local armor = {GetAuctionItemSubClasses(2)}

C.WEAPONLABEL, C.ARMORLABEL = GetAuctionItemClasses()
C.JEWELRY = {['INVTYPE_FINGER']='', ['INVTYPE_NECK']=''}

-- Most of the constants are never used but it's convinient to have them here as a reminder and shortcut
C.ITEMS = {
	['One-Handed Axes'] = weapon[1],
	['Two-Handed Axes'] = weapon[2],
	['Bows'] = weapon[3],
	['Guns'] = weapon[4],
	['One-Handed Maces'] = weapon[5],
	['Two-Handed Maces'] = weapon[6],
	['Polearms'] = weapon[7],
	['One-Handed Swords'] = weapon[8],
	['Two-Handed Swords'] = weapon[9],
	['Staves'] = weapon[10],
	['Fist Weapons'] = weapon[11],
	--['Miscellaneous'] = select(12, weapon)
	['Daggers'] = weapon[13],
	['Thrown'] = weapon[14],
	['Crossbows'] = weapon[15],
	['Wands'] = weapon[16],
	--['Fishing Pole'] = select(17, weapon)
	-- armor
	--['Miscellaneous'] = armor[1]
	['Cloth'] = armor[2],
	['Leather'] = armor[3],
	['Mail'] = armor[4],
	['Plate'] = armor[5],
	['Shields'] = armor[7], -- from 5.4 '6' is a cosmetic
	--[[3rd slot
	['Librams'] = armor[7],
	['Idols'] = armor[8],
	['Totems'] = armor[9],
	]]--
}

C.SLOTS = {
	["INVTYPE_AMMO"]={"AmmoSlot"},
	["INVTYPE_HEAD"]={"HeadSlot"},
	["INVTYPE_NECK"]={"NeckSlot"},
	["INVTYPE_SHOULDER"]={"ShoulderSlot"},
	["INVTYPE_CHEST"]={"ChestSlot"},
	["INVTYPE_WAIST"]={"WaistSlot"},
	["INVTYPE_LEGS"]={"LegsSlot"},
	["INVTYPE_FEET"]={"FeetSlot"},
	["INVTYPE_WRIST"]={"WristSlot"},
	["INVTYPE_HAND"]={"HandsSlot"}, 
	["INVTYPE_FINGER"]={"Finger0Slot", "Finger1Slot"}, 
	["INVTYPE_TRINKET"]={"Trinket0Slot", "Trinket1Slot"},
	["INVTYPE_CLOAK"]={"BackSlot"},

	["INVTYPE_WEAPON"]={"MainHandSlot", "SecondaryHandSlot"},
	["INVTYPE_2HWEAPON"]={"MainHandSlot"},
	["INVTYPE_RANGED"]={"MainHandSlot"},
	["INVTYPE_RANGEDRIGHT"]={"MainHandSlot"},
	["INVTYPE_WEAPONMAINHAND"]={"MainHandSlot"}, 
	["INVTYPE_SHIELD"]={"SecondaryHandSlot"},
	["INVTYPE_WEAPONOFFHAND"]={"SecondaryHandSlot"},
	["INVTYPE_HOLDABLE"]={"SecondaryHandSlot"}
}


--[[ 
from GlobalStrings.lua
ITEM_MOD_CRIT_RATING_SHORT = "Critical Strike";
ITEM_MOD_DODGE_RATING_SHORT = "Dodge";
ITEM_MOD_PARRY_RATING_SHORT = "Parry";

ITEM_MOD_EXPERTISE_RATING_SHORT = "Expertise";
ITEM_MOD_HASTE_RATING_SHORT = "Haste";
ITEM_MOD_HIT_RATING_SHORT = "Hit";

ITEM_MOD_MASTERY_RATING_SHORT = "Mastery";
ITEM_MOD_SPELL_PENETRATION_SHORT = "Spell Penetration";
ITEM_MOD_SPELL_POWER_SHORT = "Spell Power";
]]--