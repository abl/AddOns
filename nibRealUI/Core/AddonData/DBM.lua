local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")

function nibRealUI:LoadDBMData()
	DBM_SavedOptions = {
		["SpecialWarningFontSize"] = 50,
		["ArrowPosX"] = 0,
		["HPFramePoint"] = "TOP",
		["RangeFrameRadarY"] = -96.00019836425781,
		["StatusEnabled"] = true,
		["InfoFrameX"] = 75,
		["AprilFools"] = false,
		["RangeFrameX"] = 0,
		["WarningColors"] = {
			{
				["r"] = 0.4117647058823529,
				["g"] = 0.8,
				["b"] = 0.9411764705882353,
			}, -- [1]
			{
				["r"] = 0.9490196078431372,
				["g"] = 0.9490196078431372,
				["b"] = 0,
			}, -- [2]
			{
				["r"] = 1,
				["g"] = 0.5019607843137255,
				["b"] = 0,
			}, -- [3]
			{
				["r"] = 1,
				["g"] = 0.1019607843137255,
				["b"] = 0.1019607843137255,
			}, -- [4]
		},
		["AlwaysShowSpeedKillTimer"] = true,
		["RangeFrameY"] = 2.932909708413922,
		["EnableModels"] = true,
		["ArrowPoint"] = "TOP",
		["ModelSoundValue"] = "Short",
		["DontSendBossAnnounces"] = false,
		["InfoFramePoint"] = "CENTER",
		["RangeFrameRadarPoint"] = "CENTER",
		["SpecialWarningY"] = 182.2571854138992,
		["RangeFrameUpdates"] = "Average",
		["SpecialWarningPoint"] = "CENTER",
		["RaidWarningSound"] = "Sound\\Doodad\\BellTollNightElf.wav",
		["SpecialWarningX"] = 0.9623512279530031,
		["WhisperStats"] = true,
		["RaidWarningPosition"] = {
			["Y"] = -214.8666497364774,
			["X"] = 3.413426999031633,
			["Point"] = "TOP",
		},
		["ShowKillMessage"] = true,
		["HealthFrameWidth"] = 200,
		["DontSendBossWhispers"] = false,
		["RangeFrameSound1"] = "none",
		["HPFrameY"] = -71.14642333984375,
		["FixCLEUOnCombatStart"] = false,
		["ShowMinimapButton"] = false,
		["MoviesSeen"] = {
		},
		["SettingsMessageShown"] = true,
		["ShowWarningsInChat"] = true,
		["DontSetIcons"] = false,
		["BigBrotherAnnounceToRaid"] = false,
		["CountdownVoice"] = "Corsica",
		["InfoFrameY"] = -75,
		["ShowSpecialWarnings"] = true,
		["HealthFrameLocked"] = false,
		["HealthFrameGrowUp"] = false,
		["HideBossEmoteFrame"] = false,
		["RangeFrameRadarX"] = 101.9995193481445,
		["ShowBigBrotherOnCombatStart"] = false,
		["BlockVersionUpdatePopup"] = true,
		["InfoFrameShowSelf"] = false,
		["SpecialWarningFont"] = "Interface\\Addons\\SharedMedia_MyMedia\\font\\pixel_hr_small.ttf",
		["SpamBlockRaidWarning"] = true,
		["ShowFakedRaidWarnings"] = false,
		["LatencyThreshold"] = 200,
		["BlockVersionUpdateNotice"] = false,
		["HPFrameMaxEntries"] = 5,
		["RangeFramePoint"] = "LEFT",
		["ArrowPosY"] = -150,
		["WarningIconLeft"] = true,
		["WarningIconRight"] = true,
		["DontShowBossAnnounces"] = false,
		["ShowPizzaMessage"] = true,
		["RangeFrameSound2"] = "none",
		["ShowLHFrame"] = true,
		["RangeFrameFrames"] = "radar",
		["UseMasterVolume"] = true,
		["Enabled"] = true,
		["SpecialWarningFontColor"] = {
			0, -- [1]
			0, -- [2]
			1, -- [3]
		},
		["SpecialWarningSound"] = "Sound\\Spells\\PVPFlagTaken.wav",
		["DisableCinematics"] = false,
		["MovieFilters"] = {
		},
		["SpecialWarningSound2"] = "Sound\\Creature\\AlgalonTheObserver\\UR_Algalon_BHole01.wav",
		["ShowWipeMessage"] = true,
		["AutoRespond"] = true,
		["SetCurrentMapOnPull"] = true,
		["RangeFrameLocked"] = true,
		["AlwaysShowHealthFrame"] = false,
		["HPFrameX"] = -2.213518619537354,
		["ShowLoadMessage"] = true,
		["SpamBlockBossWhispers"] = false,
		["ShowRecoveryMessage"] = true,
		["ShowEngageMessage"] = true,
	}
end

nibRealUI["LoadAddOnData_DBM-StatusBarTimers"] = function()
	DBT_PersistentOptions = {
		["DBM"] = {
			["HugeTimerY"] = 300,
			["HugeBarXOffset"] = 0,
			["Scale"] = 1,
			["TimerX"] = 400,
			["TimerPoint"] = "CENTER",
			["HugeBarYOffset"] = 9,
			["HugeScale"] = 1,
			["HugeTimerPoint"] = "CENTER",
			["BarYOffset"] = 9,
			["HugeTimerX"] = -400,
			["TimerY"] = 300,
			["BarXOffset"] = 0,
		},
	}
end
