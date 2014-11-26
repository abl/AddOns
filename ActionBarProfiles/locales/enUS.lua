local addonName = ...

local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "enUS", true)
if not L then return end

L["charframe_tab"] = "Action Bars"
L["confirm_delete"] = "Are you sure you want to delete the action bar profile %s?"
L["confirm_overwrite"] = "You already have an action bar profile named %s. Would you like to overwrite it?"
L["confirm_save"] = "Would you like to save the action bar profile %s?"
L["confirm_use"] = "%s out of %s actions of that profile can not be used by the current character. Would you like to use this profile?" -- Needs review
L["error_exists"] = "An action bar profile with that name already exists."
L["new_profile"] = "New Profile"
L["option_companions"] = "Mounts and companions" -- Needs review
L["option_empty_slots"] = "Empty slots" -- Needs review
L["option_equip_sets"] = "Equipment sets" -- Needs review
L["option_items"] = "Items" -- Needs review
L["option_macros"] = "Macros" -- Needs review
L["option_pet_spells"] = "Pet or demon actions" -- Needs review
L["option_spells"] = "Spells and flyouts" -- Needs review
L["profile_name"] = "Enter Profile Name (Max 16 Characters):"
L["profile_options"] = "Save to profile:" -- Needs review

