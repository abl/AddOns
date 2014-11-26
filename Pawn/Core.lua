-- Pawn by Vger-Azjol-Nerub
-- www.vgermods.com
-- © 2006-2014 Green Eclipse.  This mod is released under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 license.
-- See Readme.htm for more information.

-- 
-- Core things required for localization
------------------------------------------------------------


------------------------------------------------------------
-- "Constants"
------------------------------------------------------------

PawnQuestionTexture = "|TInterface\\AddOns\\Pawn\\Textures\\Question:0|t" -- Texture string that represents a (?).  Don't need to localize this.
PawnUpgradeTexture = "|TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t" -- Texture string that represents an upgrade arrow.  Don't need to localize this.
PawnNewFeatureTexture = "|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0:0:0:-1|t" -- Texture string that represents a new feature (!) icon.  Don't need to localize this.
PawnSingleStatMultiplier = "_SingleMultiplier"
PawnMultipleStatsFixed = "_MultipleFixed"
PawnMultipleStatsExtract = "_MultipleExtract"

------------------------------------------------------------
-- Localization
------------------------------------------------------------

-- The languages that Pawn is currently translated into (http://www.wowpedia.org/API_GetLocale)
PawnLocalizedLanguages = { "deDE", "enUS", "enGB", "frFR", "ptBR", "ruRU", "zhCN", "zhTW" }

-- NOTE: These functions are not super-flexible for general purpose; they don't properly handle all sorts of Lua pattern matching syntax
-- that could be in strings, like "." and so on.  But they've been sufficient so far.

-- Turns a game constant into a regular expression.
function PawnGameConstant(Text)
	return "^" .. PawnGameConstantUnwrapped(Text) .. "$"
end

-- Turns a game constant into a regular expression but without the ^ and $ on the ends.
function PawnGameConstantUnwrapped(Text)
	-- REVIEW: This function seems like it might be pretty inefficient...
	local Ret1 = gsub(Text, "%%", "%%%%")
	return gsub(Ret1, "%-", "%%-")
end

-- Turns a game constant with one "%s" placeholder into a pattern that can be used to match that string.
function PawnGameConstantIgnoredPlaceholder(Text)
	-- Optimize for the common case where the %s is on the end.  This yields a more efficient pattern.
	if strsub(Text, strlen(Text) - 1) == "%s" then
		return "^" .. PawnGameConstantUnwrapped(strsub(Text, 1, strlen(Text) - 2))
	end
	-- If it's not at the end, replace it.
	return PawnGameConstant(gsub(Text, "%%s", ".+", 1))
end

-- Turns a game constant with "%d" placeholders into a pattern that can be used to match that string.
function PawnGameConstantIgnoredNumberPlaceholder(Text)
	return gsub(PawnGameConstant(Text), "%%%%d", "%%d+")
end
