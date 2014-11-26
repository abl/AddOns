-- Pawn by Vger-Azjol-Nerub
-- www.vgermods.com
-- © 2006-2014 Green Eclipse.  This mod is released under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 license.
-- See Readme.htm for more information.

-- 
-- UI strings
------------------------------------------------------------

local L


------------------------------------------------------------
-- Master table of stats
------------------------------------------------------------

-- For conciseness
L = PawnLocal.Stats

-- The master list of all stats that Pawn supports.
-- First column is the friendly translated name of the stat.
-- Second column is the Pawn name of the stat; this can't be translated.
-- Third column is the description of the stat; if not present, then it won't show up on the Values tab.
-- Fourth column is true if the stat can't be ignored.
-- Fifth column is an optional chunk of text instead of the "1 ___ is worth:" prompt.
-- If only a name is present, the row becomes an uneditable header in the UI and is otherwise ignored.
PawnStats =
{
	{L.PrimaryStats},
	{SPELL_STAT1_NAME, "Strength", L.StrengthInfo, true},
	{SPELL_STAT2_NAME, "Agility", L.AgilityInfo, true},
	{SPELL_STAT4_NAME, "Intellect", L.IntellectInfo, true},
	{SPELL_STAT3_NAME, "Stamina", L.StaminaInfo, true},

	{L.WeaponStats},
	{STAT_DPS_SHORT, "Dps", L.DpsInfo, true},
	{WEAPON_SPEED, "Speed", L.SpeedInfo, true, L.SpeedIs},
	{L.SpellPower, "SpellPower", L.SpellPowerInfo},

	{L.SecondaryStats},
	{SPELL_STAT5_NAME, "Spirit", L.SpiritInfo},
	{L.Ap, "Ap", L.ApInfo},
	{ARMOR, "Armor", L.ArmorInfo},
	{BONUS_ARMOR, "BonusArmor", L.BonusArmorInfo},
	{L.Crit, "CritRating", L.CritInfo},
	{STAT_HASTE, "HasteRating", L.HasteInfo},
	{STAT_MASTERY, "MasteryRating", L.MasteryInfo},
	{STAT_MULTISTRIKE, "Multistrike", L.MultistrikeInfo},
	{STAT_VERSATILITY, "Versatility", L.VersatilityInfo},

	{L.MinorStats},
	{STAT_MOVEMENT_SPEED, "MovementSpeed", L.MovementSpeedInfo},
	{STAT_AVOIDANCE, "Avoidance", L.AvoidanceInfo},
	{STAT_LIFESTEAL, "Leech", L.LeechInfo},
	{STAT_STURDINESS, "Indestructible", L.IndestructibleInfo, false, L.IndestructibleIs},

	{L.ArmorTypes},
	{L.Cloth, "IsCloth", L.ClothInfo},
	{L.Leather, "IsLeather", L.LeatherInfo},
	{L.Mail, "IsMail", L.MailInfo},
	{L.Plate, "IsPlate", L.PlateInfo},
	{L.Shield, "IsShield", L.ShieldInfo},

	{L.WeaponTypes},
	{L.WeaponType1HAxe, "IsAxe", L.WeaponType1HAxeInfo},
	{L.WeaponType2HAxe, "Is2HAxe", L.WeaponType2HAxeInfo},
	{L.WeaponTypeBow, "IsBow", L.WeaponTypeBowInfo},
	{L.WeaponTypeCrossbow, "IsCrossbow", L.WeaponTypeCrossbowInfo},
	{L.WeaponTypeDagger, "IsDagger", L.WeaponTypeDaggerInfo},
	{L.WeaponTypeFistWeapon, "IsFist", L.WeaponTypeFistWeaponInfo},
	{L.WeaponTypeGun, "IsGun", L.WeaponTypeGunInfo},
	{L.WeaponType1HMace, "IsMace", L.WeaponType1HMaceInfo},
	{L.WeaponType2HMace, "Is2HMace", L.WeaponType2HMaceInfo},
	{L.WeaponTypePolearm, "IsPolearm", L.WeaponTypePolearmInfo},
	{L.WeaponTypeStaff, "IsStaff", L.WeaponTypeStaffInfo},
	{L.WeaponType1HSword, "IsSword", L.WeaponType1HSwordInfo},
	{L.WeaponType2HSword, "Is2HSword", L.WeaponType2HSwordInfo},
	{L.WeaponTypeWand, "IsWand", L.WeaponTypeWandInfo},
	{L.WeaponTypeOffHand, "IsOffHand", L.WeaponTypeOffHandInfo},
	{L.WeaponTypeFrill, "IsFrill", L.WeaponTypeFrillInfo},

	{L.PvPStats},
	{L.PvPPower, "SpellPenetration", L.PvPPowerInfo},
	{L.PvPResilience, "ResilienceRating", L.PvPResilienceInfo},

	{L.Sockets},
	{L.MetaSocket, "MetaSocketEffect", L.MetaSocketInfo, true},

	{L.SpecialWeaponStats},
	{L.WeaponMinDamage, "MinDamage", L.WeaponMinDamageInfo, true},
	{L.WeaponMaxDamage, "MaxDamage", L.WeaponMaxDamageInfo, true},
	{L.WeaponMeleeDps, "MeleeDps", L.WeaponMeleeDpsInfo, true},
	{L.WeaponMeleeMinDamage, "MeleeMinDamage", L.WeaponMeleeMinDamageInfo, true},
	{L.WeaponMeleeMaxDamage, "MeleeMaxDamage", L.WeaponMeleeMaxDamageInfo, true},
	{L.WeaponMeleeSpeed, "MeleeSpeed", L.WeaponMeleeSpeedInfo, true},
	{L.WeaponRangedDps, "RangedDps", L.WeaponRangedDpsInfo, true},
	{L.WeaponRangedMinDamage, "RangedMinDamage", L.WeaponRangedMinDamageInfo, true},
	{L.WeaponRangedMaxDamage, "RangedMaxDamage", L.WeaponRangedMaxDamageInfo, true},
	{L.WeaponRangedSpeed, "RangedSpeed", L.WeaponRangedSpeedInfo, true},
	{L.WeaponMainHandDps, "MainHandDps", L.WeaponMainHandDpsInfo, true},
	{L.WeaponMainHandMinDamage, "MainHandMinDamage", L.WeaponMainHandMinDamageInfo, true},
	{L.WeaponMainHandMaxDamage, "MainHandMaxDamage", L.WeaponMainHandMaxDamageInfo, true},
	{L.WeaponMainHandSpeed, "MainHandSpeed", L.WeaponMainHandSpeedInfo, true},
	{L.WeaponOffHandDps, "OffHandDps", L.WeaponOffHandDpsInfo, true},
	{L.WeaponOffHandMinDamage, "OffHandMinDamage", L.WeaponOffHandMinDamageInfo, true},
	{L.WeaponOffHandMaxDamage, "OffHandMaxDamage", L.WeaponOffHandMaxDamageInfo, true},
	{L.WeaponOffHandSpeed, "OffHandSpeed", L.WeaponOffHandSpeedInfo, true},
	{L.WeaponOneHandDps, "OneHandDps", L.WeaponOneHandDpsInfo, true},
	{L.WeaponOneHandMinDamage, "OneHandMinDamage", L.WeaponOneHandMinDamageInfo, true},
	{L.WeaponOneHandMaxDamage, "OneHandMaxDamage", L.WeaponOneHandMaxDamageInfo, true},
	{L.WeaponOneHandSpeed, "OneHandSpeed", L.WeaponOneHandSpeedInfo, true},
	{L.WeaponTwoHandDps, "TwoHandDps", L.WeaponTwoHandDpsInfo, true},
	{L.WeaponTwoHandMinDamage, "TwoHandMinDamage", L.WeaponTwoHandMinDamageInfo, true},
	{L.WeaponTwoHandMaxDamage, "TwoHandMaxDamage", L.WeaponTwoHandMaxDamageInfo, true},
	{L.WeaponTwoHandSpeed, "TwoHandSpeed", L.WeaponTwoHandSpeedInfo, true},
	{L.SpeedBaseline, "SpeedBaseline", L.SpeedBaselineInfo, true, L.SpeedBaselineIs},
}


------------------------------------------------------------
-- UI strings
------------------------------------------------------------

-- For conciseness
L = PawnLocal.UI


-- Translation note: All of the strings ending in _Text should be translated; those will show up in the UI.  The strings ending
-- in _Tooltip are only used in tooltips, and can be safely left out.  If you don't want to translate them right now, delete those
-- lines or set them to nil, and Pawn won't show tooltips for those UI elements.


-- Configuration UI
PawnUIHeaders = -- (%s is the name of the current scale)
{
	L.ScaleHeader, -- Scale tab
	L.ValuesHeader, -- Values tab
	L.CompareHeader, -- Compare tab
	L.GemsHeader, -- Gems tab
	L.OptionsHeader, -- Options tab
	L.AboutHeader, -- About tab
	L.HelpHeader, -- Getting Started tab
}

-- Configuration UI, Scale selector
PawnUIFrame_ScaleSelector_Header_Text = L.ScaleSelectorHeader
PawnUIFrame_ShowScaleCheck_Label_Text = L.ScaleSelectorShowScale
PawnUIFrame_ShowScaleCheck_Tooltip = L.ScaleSelectorShowScaleTooltip

-- Configuration UI, Scale tab
PawnUIFrame_ScalesTab_Text = L.ScaleTab

PawnUIFrame_ScalesWelcomeLabel_Text = L.ScaleWelcome

PawnUIFrame_RenameScaleButton_Text = L.ScaleRename
PawnUIFrame_RenameScaleButton_Tooltip = L.ScaleRenameTooltip
PawnUIFrame_DeleteScaleButton_Text = DELETE
PawnUIFrame_DeleteScaleButton_Tooltip = L.ScaleDeleteTooltip
PawnUIFrame_ScaleColorSwatch_Label_Text = L.ScaleChangeColor
PawnUIFrame_ScaleColorSwatch_Tooltip = L.ScaleChangeColorTooltip
PawnUIFrame_ScaleTypeLabel_NormalScaleText = L.ScaleTypeNormal
PawnUIFrame_ScaleTypeLabel_ReadOnlyScaleText = L.ScaleTypeReadOnly

PawnUIFrame_ScaleSettingsShareHeader_Text = L.ScaleShareHeader

PawnUIFrame_ImportScaleButton_Text = L.ScaleImport
PawnUIFrame_ImportScaleButton_Label_Text = L.ScaleImportTooltip
PawnUIFrame_ExportScaleButton_Text = L.ScaleExport
PawnUIFrame_ExportScaleButton_Label_Text = L.ScaleExportTooltip

PawnUIFrame_ScaleSettingsNewHeader_Text = L.ScaleNewHeader

PawnUIFrame_CopyScaleButton_Text = L.ScaleCopy
PawnUIFrame_CopyScaleButton_Label_Text = L.ScaleCopyTooltip
PawnUIFrame_NewScaleButton_Text = L.ScaleEmpty
PawnUIFrame_NewScaleButton_Label_Text = L.ScaleEmptyTooltip
PawnUIFrame_NewScaleFromDefaultsButton_Text = L.ScaleDefaults
PawnUIFrame_NewScaleFromDefaultsButton_Label_Text = L.ScaleDefaultsTooltip

-- Configuration UI, Values tab (previously the Scales tab)
PawnUIFrame_ValuesTab_Text = L.ValuesTab

PawnUIFrame_ValuesWelcomeLabel_NormalText = L.ValuesWelcome
PawnUIFrame_ValuesWelcomeLabel_NoScalesText = L.ValuesWelcomeNoScales
PawnUIFrame_ValuesWelcomeLabel_ReadOnlyScaleText = L.ValuesWelcomeReadOnly

PawnUIFrame_ClearValueButton_Text = L.ValuesRemove
PawnUIFrame_ClearValueButton_Tooltip = L.ValuesRemoveTooltip

PawnUIFrame_IgnoreStatCheck_Text = L.ValuesIgnoreStat
PawnUIFrame_IgnoreStatCheck_Tooltip = L.ValuesIgnoreStatTooltip

PawnUIFrame_NoUpgradesCheck_Tooltip = L.ValuesDoNotShowUpgradesTooltip

PawnUIFrame_FollowSpecializationCheck_Text = L.ValuesFollowSpecialization
PawnUIFrame_FollowSpecializationCheck_Tooltip = L.ValuesFollowSpecializationTooltip

PawnUIFrame_NormalizeValuesCheck_Text = L.ValuesNormalize
PawnUIFrame_NormalizeValuesCheck_Tooltip = L.ValuesNormalizeTooltip

-- Configuration UI, Compare tab
PawnUIFrame_CompareTab_Text = L.CompareTab

PawnUIFrame_VersusHeader_Text = L.CompareVersus -- Short for "versus."  Appears between the names of the two items.
PawnUIFrame_VersusHeader_NoItem = L.CompareSlotEmpty -- Text displayed next to empty item slots.

PawnUIFrame_CompareMissingItemInfo_TextLeft = L.CompareWelcomeLeft
PawnUIFrame_CompareMissingItemInfo_TextRight = L.CompareWelcomeRight

PawnUIFrame_ClearItemsButton_Label = L.CompareClearItems
PawnUIFrame_ClearItemsButton_Tooltip = L.CompareClearItemsTooltip
PawnUIFrame_EquippedItemsHeader_Text = L.CompareEquipped
PawnUIFrame_BestItemsHeader_Text = L.CompareYourBest

PawnUIFrame_CompareSwapButton_Text = L.CompareSwap
PawnUIFrame_CompareSwapButton_Tooltip = L.CompareSwapTooltip

-- Configuration UI, Gems tab
PawnUIFrame_GemsTab_Text = L.GemsTab
PawnUIFrame_GemsHeaderLabel_Text = L.GemsWelcome

PawnUIFrame_BestGemsRadio_Text = L.GemsShowBest
PawnUIFrame_BestGemsRadio_Tooltip = L.GemsShowBestTooltip
PawnUIFrame_GemsForItemLevelRadio_Text = L.GemsShowForItemLevel
PawnUIFrame_GemsForItemLevelRadio_Tooltip = L.GemsShowForItemLevelTooltip
PawnUIFrame_GemQualityLevelBox_Label = L.GemsQualityLevel
PawnUIFrame_GemQualityLevelBox_Tooltip = L.GemsQualityLevelTooltip

-- Configuration UI, Options tab
PawnUIFrame_OptionsTab_Text = L.OptionsTab
PawnUIFrame_OptionsHeaderLabel_Text = L.OptionsWelcome

PawnUIFrame_TooltipOptionsHeaderLabel_Text = L.OptionsTooltipHeader
PawnUIFrame_EnchantedValuesCheck_Text = L.OptionsCurrentValue
PawnUIFrame_EnchantedValuesCheck_Tooltip = L.OptionsCurrentValueTooltip
PawnUIFrame_ShowIconsCheck_Text = L.OptionsInventoryIcon
PawnUIFrame_ShowIconsCheck_Tooltip = L.OptionsInventoryIconTooltip
PawnUIFrame_ShowExtraSpaceCheck_Text = L.OptionsBlankLine
PawnUIFrame_ShowExtraSpaceCheck_Tooltip = L.OptionsBlankLineTooltip
PawnUIFrame_AlignRightCheck_Text = L.OptionsAlignRight
PawnUIFrame_AlignRightCheck_Tooltip = L.OptionsAlignRightTooltip
PawnUIFrame_ColorTooltipBorderCheck_Text = L.OptionsColorBorder
PawnUIFrame_ColorTooltipBorderCheck_Tooltip = L.OptionsColorBorderTooltip
PawnUIFrame_TooltipUpgradeHeaderLabel_Text = L.OptionsUpgradeHeader
PawnUIFrame_TooltipUpgradeOnRadio_Text = L.OptionsTooltipValuesAndUpgrades
PawnUIFrame_TooltipUpgradeOnRadio_Tooltip = L.OptionsTooltipValuesAndUpgradesTooltip
PawnUIFrame_TooltipUpgradeOnUpgradesOnlyRadio_Text = L.OptionsTooltipUpgradesOnly
PawnUIFrame_TooltipUpgradeOnUpgradesOnlyRadio_Tooltip = L.OptionsTooltipUpgradesOnlyTooltip
PawnUIFrame_TooltipUpgradeOffRadio_Text = L.OptionsTooltipValuesOnly
PawnUIFrame_TooltipUpgradeOffRadio_Tooltip = L.OptionsTooltipValuesOnlyTooltip

PawnUIFrame_AdvisorOptionsHeaderLabel_Text = L.OptionsAdvisorHeader
PawnUIFrame_ShowLootUpgradeAdvisorCheck_Text = L.OptionsLootAdvisor
PawnUIFrame_ShowLootUpgradeAdvisorCheck_Tooltip = L.OptionsLootAdvisorTooltip
PawnUIFrame_ShowQuestUpgradeAdvisorCheck_Text = L.OptionsQuestUpgradeAdvisor
PawnUIFrame_ShowQuestUpgradeAdvisorCheck_Tooltip = L.OptionsQuestUpgradeAdvisorTooltip
PawnUIFrame_ShowSocketingAdvisorCheck_Text = L.OptionsSocketingAdvisor
PawnUIFrame_ShowSocketingAdvisorCheck_Tooltip = L.OptionsSocketingAdvisorTooltip
PawnUIFrame_ShowBoth1HAnd2HUpgradesCheck_Text = L.OptionsUpgradesForBothWeaponTypes
PawnUIFrame_ShowBoth1HAnd2HUpgradesCheck_Tooltip = L.OptionsUpgradesForBothWeaponTypesTooltip
PawnUIFrame_IgnoreGemsWhileLevelingCheck_Text = L.OptionsIgnoreGemsWhileLevelingCheck
PawnUIFrame_IgnoreGemsWhileLevelingCheck_Tooltip = L.OptionsIgnoreGemsWhileLevelingCheckTooltip

PawnUIFrame_OtherOptionsHeaderLabel_Text = L.OptionsOtherHeader
PawnUIFrame_DebugCheck_Text = L.OptionsDebug
PawnUIFrame_DebugCheck_Tooltip = L.OptionsDebugTooltip
PawnUIFrame_ButtonPositionHeaderLabel_Text = L.OptionsButtonPosition
PawnUIFrame_ButtonRightRadio_Text = L.OptionsButtonPositionRight
PawnUIFrame_ButtonRightRadio_Tooltip = L.OptionsButtonPositionRightTooltip
PawnUIFrame_ButtonLeftRadio_Text = L.OptionsButtonPositionLeft
PawnUIFrame_ButtonLeftRadio_Tooltip = L.OptionsButtonPositionLeftTooltip
PawnUIFrame_ButtonOffRadio_Text = L.OptionsButtonHidden
PawnUIFrame_ButtonOffRadio_Tooltip = L.OptionsButtonHiddenTooltip
PawnUIFrame_ShowItemIDsCheck_Text = L.OptionsItemIDs
PawnUIFrame_ShowItemIDsCheck_Tooltip = L.OptionsItemIDsTooltip
PawnUIFrame_ResetUpgradesButton_Text = L.OptionsResetUpgrades
PawnUIFrame_ResetUpgradesButton_Tooltip = L.OptionsResetUpgradesTooltip

-- Configuration UI, About tab
PawnUIFrame_AboutTab_Text = L.AboutTab
PawnUIFrame_AboutHeaderLabel_Text = format(PETITION_CREATOR, "Vger-Azjol-Nerub")
PawnUIFrame_AboutVersionLabel_Text = L.AboutVersion
PawnUIFrame_AboutTranslationLabel_Text = L.AboutTranslation -- Translators: credit yourself here... "Klingon translation by Stovokor"
PawnUIFrame_ReadmeLabel_Text = L.AboutReadme
PawnUIFrame_WebsiteLabel_Text = L.AboutWebsite

-- Configuration UI, Help tab
PawnUIFrame_HelpTab_Text = L.HelpTab
PawnUIFrame_GettingStartedLabel_Text = L.HelpText
	
-- Interface Options page
PawnInterfaceOptionsFrame_OptionsHeaderLabel_Text = L.InterfaceOptionsWelcome
PawnInterfaceOptionsFrame_OptionsSubHeaderLabel_Text = L.InterfaceOptionsBody

-- Bindings UI
BINDING_HEADER_PAWN = "Pawn"
BINDING_NAME_PAWN_TOGGLE_UI = L.KeyBindingShowUI -- Show or hide the Pawn UI
PAWN_TOGGLE_UI_DEFAULT_KEY = "P" -- Default key to assign to this command
BINDING_NAME_PAWN_COMPARE_LEFT = L.KeyBindingCompareItemLeft -- Set the currently hovered item to be the left-side Compare item
PAWN_COMPARE_LEFT_DEFAULT_KEY = "[" -- Default key to assign to this command
BINDING_NAME_PAWN_COMPARE_RIGHT = L.KeyBindingCompareItemRight -- Set the currently hovered item to be the right-side Compare item
PAWN_COMPARE_RIGHT_DEFAULT_KEY = "]" -- Default key to assign to this command
