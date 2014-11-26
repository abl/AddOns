-- Pawn by Vger-Azjol-Nerub
-- www.vgermods.com
-- © 2006-2014 Green Eclipse.  This mod is released under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 license.
-- See Readme.htm for more information.

-- 
-- Spanish resources
------------------------------------------------------------

-- *** Not currently used.  Update Localization.lua (add to list of languages), Core.lua (add to list of languages), and this file (remove "false and" at the bottom) to enable testing.

local function PawnUseThisLocalization()
PawnLocal =
{

}
end

if false and (GetLocale() == "esES" or GetLocale() == "esMX") then
	PawnUseThisLocalization()
end

-- After using this localization or deciding that we don't need it, remove it from memory.
PawnUseThisLocalization = nil
