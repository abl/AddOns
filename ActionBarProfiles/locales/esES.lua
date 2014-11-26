local addonName = ...

local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "esES", false)
if not L then return end

L["charframe_tab"] = "Barras de acción"
L["confirm_delete"] = "¿Seguras que quieres eliminiar el perfil \"%s\"?"
L["confirm_overwrite"] = "Ya tienes un perfil llamado \"%s\". ¿Quieres sobreescribirlo?"
L["confirm_save"] = "¿Quieres guardar el perfil \"%s\"?"
L["confirm_use"] = "%s de %s acciones en este perfil no se pueden ser utilizados por el personaje actual. ¿Quieres usar este perfil?"
L["error_exists"] = "Un perfil con este nombre ya existe."
L["new_profile"] = "Nuevo perfil"
-- L["option_companions"] = ""
-- L["option_empty_slots"] = ""
-- L["option_equip_sets"] = ""
-- L["option_items"] = ""
-- L["option_macros"] = ""
-- L["option_pet_spells"] = ""
-- L["option_spells"] = ""
L["profile_name"] = "Introducir nombre de perfil (máximo de 16 caracteres)" -- Needs review
-- L["profile_options"] = ""

