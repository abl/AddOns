--------------------------------------
---- Raeli's Spell Announcer Core ----
--------------------------------------
RSA = LibStub("AceAddon-3.0"):NewAddon("RSA", "AceConsole-3.0", "LibSink-2.0")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local db
local pName = UnitName("player")
RSA.DefaultOptions = {
	global = {
		version = 1.0, -- Automatically updates to the .toc version in OnInitialize, allows me to warn users if something big has changed.
	--[===[@alpha@
	DisableAlphaWarning == false,
	--@end-alpha@]===]
	},
	profile = {
		Modules = {
			['*'] = false, -- By default, don't load any modules. This will be set and saved once a user has logged in once. Possibly should be under class section, but seems fine here for now.
		},
		General = {
			['*'] = true,
			Class = "",
			GlobalAnnouncements = {
				['*'] = true,
				InPvP = false,
				InWorld = false,
				OnlyInCombat = false,
				Battlegrounds = false,
			},
			Local = {
				['*'] = true,
			},
			GlobalCustomChannel = "MyCustomChannel",
			Spells = {
				-- RACIALS --
				Stoneform = {
					Messages = {
						Start = "[LINK] Activated!",
						End = "[LINK] Ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				EMFH = {
					Messages = {
						Start = "[LINK] Activated!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				GOTN = {
					Messages = {
						Start = "[LINK] on [TARGET]!",
						End = "[LINK] ended on [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				WarStomp = {
					Messages = {
						Start = "[LINK] Activated!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				WOTF = {
					Messages = {
						Start = "[LINK] Activated!",
						End = "[LINK] Ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				EscapeArtist = {
					Messages = {
						Start = "[LINK] Activated!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				ArcaneTorrent = {
					Messages = {
						Start = "[LINK] Activated!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				-- LEADER --
				Jeeves = {
					Messages = {
						Start = "[TARGET] has placed a [LINK]!",
						End = "[TARGET]'s [LINK] faded.",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Cauldron = {
					Messages = {
						Start = "[TARGET] has placed a [LINK]!",
						End = "[TARGET]'s [LINK] faded.",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Feasts = {
					Messages = {
						Start = "[TARGET] has placed a [LINK]!",
						End = "[TARGET]'s [LINK] faded.",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				MobileBank = {
					Messages = {
						Start = "[TARGET] has placed a [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				-- PERSONAL --
				MassRess = {
					Messages = {
						Start = "Casting [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				PotionOfConcentration = {
					Messages = {
						Start = "[LINK] Activated!",
						End = "[LINK] Ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
			},
		},
		Reminders = {
			DisableInPvP = true,
			EnableInSpec1 = true,
			EnableInSpec2 = false,
			CheckInterval = 10,
			RemindInterval = 15,
			RemindChannels = {
				['*'] = true,
			},
		},
		sink20OutputSink = "ChatFrame", -- Default for LibSink-2.0
		--sink20ScrollArea = ,
		DeathKnight = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				Army = {
					Messages = {
						Start = "Casting [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = true,
				}, -- End
				AMS = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				DarkCommand = {
					Messages = {
						Start = "Taunted [TARGET]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				IceboundFortitude = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Strangulate = {
					Messages = {
						Start = "Strangulated [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Asphyxiate = {
					Messages = {
						Start = "Asphyxiated [TARGET]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				MindFreeze = {
					Messages = {
						Start = "Mind Freezed [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				DeathGrip = {
					Messages = {
						Start = "Death Gripped [TARGET]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				VampiricBlood = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				BoneShield = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				RuneTap = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				DancingRuneWeapon = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				WotN = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Conversion = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				DeathPact = {
					Messages = {
						Start = "Activated [LINK] for [AMOUNT]!!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				RaiseAlly = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Lichborne = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				PillarOfFrost = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Purgatory = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
			},
		},
		Druid = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				SurvivalInstincts = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Cyclone = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				FrenziedRegeneration = {
					Messages = {
						Start = "[LINK] activated!"
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Ironbark = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				SkullBash = {
					Messages = {
						Start = "Interrupted [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Growl = {
					Messages = {
						Start = "Taunted [TARGET]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Revive = {
					Messages = {
						Start = "Casting [LINK] on [TARGET]!",
						End = "Successfully resurrected [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Rebirth = {
					Messages = {
						Start = "Casting [LINK] on [TARGET]!",
						End = "Successfully resurrected [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				TreeOfLife = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Barkskin = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				HeartOfTheWild = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				SavageDefense = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				MightyBash = {
					Messages = {
						Start = "Stunned [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Tranquility = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Berserk = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				RemoveCorruption = {
					Messages = {
						Start = "Removed [TARGET]'s [AURALINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Roots = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Soothe = {
					Messages = {
						Start = "Purged [TARGET]'s [AURALINK]!",
						End = "[TARGET] resisted [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				StampedingRoar = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = true,
				}, -- End
				SolarBeam = {
					Messages = {
						Start = "Interrupted [TARGET]'s [TARLINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				} -- End
			}
		},
		Hunter = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				Misdirection = {
					Messages = {
						Primer = "[LINK] primed on [TARGET]!",
						Start = "[LINK] started on [TARGET]!",
						End = "[LINK] on [TARGET] ended! [AMOUNT] additional threat for 30 seconds.",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				ConcussiveShot = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				FreezingTrap = {
					Messages = {
						Placement = "[LINK] Placed!",
						Start = "[LINK] hit [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				SilencingShot = {
					Messages = {
						Start = "Interrupted [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				TranquilizingShot = {
					Messages = {
						Start = "Removed [TARGET]'s [AURALINK]!",
						End = "[TARGET] resisted [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				WyvernSting = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Deterrence = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Camoflage = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				DistractingShot = {
					Messages = {
						Start = "Taunted [TARGET]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = true,
				}, -- End
				MastersCall = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				RoarOfSacrifice = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				EternalGuardian = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				AncientHysteria = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
			},
		},
		Mage = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				TimeWarp = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Spellsteal = {
					Messages = {
						Start = "Stole [TARGET]'s [AURALINK]!",
						End = "[TARGET] resisted [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Polymorph = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				RemoveCurse = {
					Messages = {
						Start = "Removed [TARGET]'s [AURALINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Counterspell = {
					Messages = {
						Start = "Counterspelled [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Portals = {
					Messages = {
						Start = "Casting [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Teleport = {
					Messages = {
						Start = "Warning you are Teleporting, and leaving your friends behind!",
					},
					Local = true,
				}, -- End
				RefreshmentTable = {
					Messages = {
						Start = "Casting [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				RingOfFrost = {
					Messages = {
						Start = "[LINK] activated!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Cauterize = {
					Messages = {
						Start = "[LINK] activated, please heal me!",
						End = "[LINK] faded, I'm no longer burning!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				IceBlock = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				SlowFall = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
			},
		},
		Monk = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				ZenMeditation = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = true,
				}, -- End
				Provoke = {
					Messages = {
						Start = "Taunted [TARGET]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
						StatueOfTheBlackOx = "Taunted everything around [TARGET]",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				FortifyingBrew = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				SpearHandStrike = {
					Messages = {
						Start = "Interrupted [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Paralysis = {
					Messages = {
						Start = "Paralyzed [TARGET]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Guard = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				ElusiveBrew = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				PurifyingBrew = {
					Messages = {
						Start = "Used [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				DampenHarm = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				LifeCocoon = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				DiffuseMagic = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Detox = {
					Messages = {
						Start = "Removed [TARGET]'s [AURALINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Resuscitate = {
					Messages = {
						Start = "Casting [LINK] on [TARGET]!",
						End = "Successfully resurrected [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
			},
		},
		Paladin = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				ArdentDefender = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
						Heal = "[LINK] saved my life and healed me for [AMOUNT] hp!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				DevotionAura = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				DivineProtection = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Forbearance = {
					Messages = {
						Start = "",
						End = "[LINK] on [TARGET] faded!",
					},
					Local = true,
				}, -- End
				HandOfFreedom = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				HandOfProtection = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				HandOfSacrifice = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				HandOfSalvation = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				LayOnHands = {
					Messages = {
						Start = "[LINK] on [TARGET] for [AMOUNT]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				GoAK = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				HolyAvenger = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Repentance = {
					Messages = {
						Start = "[LINK] on [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Rebuke = {
					Messages = {
						Start = "Interrupted [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				HandOfReckoning = {
					Messages = {
						Start = "Taunted [TARGET]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Beacon = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = true,
					Whisper = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Redemption = {
					Messages = {
						Start = "Casting [LINK] on [TARGET]!",
						End = "Successfully resurrected [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				AvengersShield = {
					Messages = {
						Start = "Interrupted [TARGET]'s [TARLINK]!",
						End = "",
						Immune = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				TurnEvil = {
					Messages = {
						Start = "[LINK] [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				HammerOfJustice = {
					Messages = {
						Start = "[LINK] on [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Cleanse = {
					Messages = {
						Start = "Cleansed [TARGET]'s [AURALINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				SacredShield = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				DivineShield = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				AvengingWrath = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				WordOfGlory = {
					Messages = {
						Start = "[LINK] on [TARGET] for [AMOUNT]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
					Minimum = 10000,
				}, -- End
				HandOfPurity = {
					Messages = {
						Start = "[LINK] on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
			},
		},
		Priest = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				MassDispel = {
					Messages = {
						Start = "Casting [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				VampiricEmbrace = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] over!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				LeapOfFaith = {
					Messages = {
						Start = "Pulling [TARGET] to Me!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				DivineHymn = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] over!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				FearWard = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Levitate = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				ShackleUndead = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				DispelMagic = {
					Messages = {
						Start = "Dispelled [AURALINK] on [TARGET]!",
						End = "[TARGET] resisted [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				GuardianSpirit = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
						Proc = "[LINK] just healed [TARGET] for [AMOUNT]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				PainSuppression = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Lightwell = {
					Messages = {
						Start = "[LINK] activated!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				PowerInfusion = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				LightwellRenew = {
					Messages = {
						Start = "[TARGET] clicked the Lightwell. [AMOUNT] remain!",
						End = "[TARGET] stole an additional Lightwell charge! [AMOUNT] remain!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = true,
					Whisper = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				PowerWordBarrier = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Purify = {
					Messages = {
						Start = "Removed [TARGET]'s [AURALINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Resurrection = {
					Messages = {
						Start = "Casting [LINK] on [TARGET]!",
						End = "Successfully resurrected [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Fade = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				AngelicBulwark = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				PsychicScream = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				MindControl = {
					Messages = {
						Casting = "Casting [LINK] on [TARGET]!",
						Start = "Mindcontrolling [TARGET] Now!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Silence = {
					Messages = {
						Start = "Interrupted [TARGET]'s [TARLINK]!",
						End = "[LINK] on [TARGET] ended!",
						Debuff = "[LINK] on [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				SpiritShell = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				PsychicHorror = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				BodyAndSoul = {
					Messages = {
						Start = "[LINK] on [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Shadowfiend = {
					Messages = {
						Start = "[LINK] activated!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
			},
		},
		Rogue = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				Sap = {
					Messages = {
						Start = "[LINK] on [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Blind = {
					Messages = {
						Start = "[LINK] on [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
						Resist = "My [LINK] [MISSTYPE] [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Kick = {
					Messages = {
						Start = "Interrupted [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Tricks = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] gave you an additional [AMOUNT] damage!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Concealment = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				SmokeBomb = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Shiv = {
					Messages = {
						Start = "Shived [TARGET]'s [AURALINK]!",
						End = "[TARGET] resisted [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
			},
		},
		Shaman = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				Hex = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Heroism = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				ShamanisticRage = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				WindShear = {
					Messages = {
						Start = "Interrupted [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Purge = {
					Messages = {
						Start = "Purged [TARGET]'s [AURALINK]!",
						End = "[TARGET] resisted [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				CleanseSpirit = {
					Messages = {
						Start = "Cleansed [TARGET]'s [AURALINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				HealingTide = {
					Messages = {
						Start = "[LINK] placed!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				EarthElementalTotem = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				FireElementalTotem = {
					Messages = {
						Start = "[LINK] placed!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				AncestralSpirit = {
					Messages = {
						Start = "Casting [LINK] on [TARGET]!",
						End = "Successfully resurrected [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				SpiritLink = {
					Messages = {
						Start = "[LINK] placed!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				TremorTotem = {
					Messages = {
						Start = "[LINK] placed!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Thunderstorm = {
					Messages = {
						Start = "[LINK] activated!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				AncestralGuidance = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				AstralShift = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				GroundingTotem = {
					Messages = {
						Start = "[LINK] placed!",
						End = "[LINK] absorbed [AMOUNT] from [TARGET]'s [TARLINK]!",
						Immune = "[LINK] absorbed [TARGET]'s [TARLINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				WindwalkTotem = {
					Messages = {
						Start = "[LINK] placed!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				CapacitorTotem = {
					Messages = {
						Start = "[LINK] placed!",
						End = "[LINK] exploded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Ascendance = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
			},
		},
		Warlock = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				SoulWell = {
					Messages = {
						Start = "Casting [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				SummonStone = {
					Messages = {
						Start = "Casting [LINK], please assist!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Suffering = {
					Messages = {
						Start = "Taunted [TARGET]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				SingeMagic = {
					Messages = {
						Start = "[LINK] on [TARGET] removed [AURALINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Banish = {
					Messages = {
						Start = "Banished [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Fear = {
					Messages = {
						Start = "Fearing [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				GrimoireOfSacrifice = {
					Messages = {
						Start = "Gained [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				-- MESMERIZE
				Seduce = {
					Messages = {
						Start = "Casting [SPELL] on [TARGET]!",
						End = "[LINK] on [TARGET] has ended!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				SpellLock = {
					Messages = {
						Start = "Interrupted [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Devour = {
					Messages = {
						Start = "Devoured [TARGET]'s [AURALINK]!",
						End = "[TARGET] resisted [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				CloneMagic = {
					Messages = {
						Start = "Stolen [TARGET]'s [AURALINK]!",
						End = "[TARGET] resisted [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Soulstone = {
					Messages = {
						Start = "Casting [LINK] on [TARGET]!",
						End = "Successfully Soulstoned [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				DeathCoil = {
					Messages = {
						Start = "[LINK] on [TARGET]!"
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Shadowfury = {
					Messages = {
						Start = "[LINK] on [TARGET]!"
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				HowlOfTerror = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				DarkBargain = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				UnendingResolve = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Soulshatter = {
					Messages = {
						Start = "[LINK] activated!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Gateway = {
					Messages = {
						Start = "[LINK] placed!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
			}, -- End Spells
		}, -- End Warlock
		Warrior = {
			Reminders = {
				SpellName = "",
			},
			Spells = {
				ShatteringThrow = {
					Messages = {
						Start = "[LINK] on [TARGET]!",
						End = "[LINK] on [TARGET] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				ShieldWall = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Pummel = {
					Messages = {
						Start = "Pummeled [TARGET]'s [TARLINK]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
						Gag = "[TARGET] is Silenced by my Gag Order!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				DemoralizingShout = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Taunt = {
					Messages = {
						Start = "Taunted [TARGET]!",
						End = "My [LINK] [MISSTYPE] [TARGET]!",
						Immune = "[TARGET] is [MISSTYPE] to my [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				Vigilance = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
						End = "[LINK] on [TARGET] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				LastStand = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				EnragedRegeneration = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				ShieldBlock = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				ShieldBarrier= {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				SpellReflect = {
					Messages = {
						Start = "Reflected [TARGET]'s [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				Recklessness = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				ShieldSlamDispel = {
					Messages = {
						Start = "Dispelled [TARGET]'s [AURALINK]!",
						End = "[TARGET] resisted [LINK]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				RallyingCry = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				-- SAFEGUARD
				Intervene = {
					Messages = {
						Start = "[LINK] cast on [TARGET]!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Whisper = true,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = false,
					Say = false,
				}, -- End
				MockingBanner = {
					Messages = {
						Start = "[LINK] placed!",
						End = "[LINK] ended!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
				DieByTheSword = {
					Messages = {
						Start = "[LINK] activated!",
						End = "[LINK] faded!",
					},
					CustomChannel = {
						Enabled = false,
						Channel = "",
					},
					Local = false,
					Raid = false,
					Party = false,
					Yell = false,
					SmartGroup = true,
					Say = false,
				}, -- End
			},
		},
	}, -- End Profile
} -- End Defaults
local spellinfo,spelllinkinfo
local botguids = {}
function RSA:OnInitialize() -- Do all this when the addon loads.
	self.db = LibStub("AceDB-3.0"):New("RSADB", RSA.DefaultOptions) -- Setup Saved Variables
	self:SetSinkStorage(self.db.profile) -- Setup Saved Variables for LibSink
	-- Check what class and race we are and save it. Used to determine what options to show.
	local pRace = select(2, UnitRace("player"))
	self.db.profile.General.Race = pRace
	local pClass = select(2, UnitClass("player"))
	self.db.profile.General.Class = pClass
	-- Profile Management --
	self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
	local LibDualSpec = LibStub('LibDualSpec-1.0')
	LibDualSpec:EnhanceDatabase(self.db, "RSA")
	------------------------
	db = self.db
	-- Register /RSA command
	self:RegisterChatCommand("RSA", "ChatCommand")
	--@non-alpha@
	if tonumber(GetAddOnMetadata("RSA", "Version")) > tonumber(self.db.global.version) then -- Print when addon is updated.
		print("|cFFFF75B3Raeli's Spell Announcer|r updated to version " .. "|cff00FF00" .. GetAddOnMetadata("RSA", "Version") .. "|r.")
	end
	--@end-non-alpha@
	--[===[@alpha@
	if RSA.db.global.DisableAlphaWarning == false then
	print("|cFFFF75B3Raeli's Spell Announcer|r |cffFF0000alpha|r version " .. "|cff00FF00" .. GetAddOnMetadata("RSA", "Version") .. " r116|r.")
	local RWColor = {r=1, g=1, b=1}
	RaidNotice_AddMessage(RaidWarningFrame, format(L.alpha_message), RWColor)
	end
	--@end-alpha@]===]
	if tonumber(self.db.global.version) < 2.71 then -- Print when addon is updated from an old version.
		print(L.updated_message)
		local RWColor = {r=1, g=1, b=1}
		RaidNotice_AddMessage(RaidWarningFrame, format(L.updated_message), RWColor)
		--message(L.updated_message) -- Creates a Small "Ok" box with the message.
	end
	-- Register current version of RSA
	self.db.global.version = GetAddOnMetadata("RSA", "Version")
	-- Load Reminder Module on startup if it's turned on.
	if RSA.db.profile.Modules.Reminders == true then
		LoadAddOn("RSA_Reminders")
	else
		RSA.db.profile.Modules.Reminders_Loaded = false
	end
	if pClass == "DEATHKNIGHT" then -- Load Class Modules
		local loaded, reason = LoadAddOn("RSA_DeathKnight")
		if not loaded then
			RSA.db.profile.Modules.DeathKnight = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Death Knight " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Death Knight " .. L.OptionsMissing)
			end
		end
	elseif pClass == "DRUID" then
		local loaded, reason = LoadAddOn("RSA_Druid")
		if not loaded then
			RSA.db.profile.Modules.Druid = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Druid " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Druid " .. L.OptionsMissing)
			end
		end
	elseif pClass == "HUNTER" then
		local loaded, reason = LoadAddOn("RSA_Hunter")
		if not loaded then
			RSA.db.profile.Modules.Hunter = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Hunter " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Hunter " .. L.OptionsMissing)
			end
		end
	elseif pClass == "MAGE" then
		local loaded, reason = LoadAddOn("RSA_Mage")
		if not loaded then
			RSA.db.profile.Modules.Mage = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Mage " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Mage " .. L.OptionsMissing)
			end
		end
	elseif pClass == "MONK" then
		local loaded, reason = LoadAddOn("RSA_Monk")
		if not loaded then
			RSA.db.profile.Modules.Monk = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Monk " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Monk " .. L.OptionsMissing)
			end
		end
	elseif pClass == "PALADIN" then
		local loaded, reason = LoadAddOn("RSA_Paladin")
		if not loaded then
			RSA.db.profile.Modules.Paladin = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Paladin " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Paladin " .. L.OptionsMissing)
			end
		end
	elseif pClass == "PRIEST" then
		local loaded, reason = LoadAddOn("RSA_Priest")
		if not loaded then
			RSA.db.profile.Modules.Priest = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Priest " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Priest " .. L.OptionsMissing)
			end
		end
	elseif pClass == "ROGUE" then
		local loaded, reason = LoadAddOn("RSA_Rogue")
		if not loaded then
			RSA.db.profile.Modules.Rogue = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Rogue " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Rogue " .. L.OptionsMissing)
			end
		end
	elseif pClass == "SHAMAN" then
		local loaded, reason = LoadAddOn("RSA_Shaman")
		if not loaded then
			RSA.db.profile.Modules.Shaman = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Shaman " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Shaman " .. L.OptionsMissing)
			end
		end
	elseif pClass == "WARLOCK" then
		local loaded, reason = LoadAddOn("RSA_Warlock")
		if not loaded then
			RSA.db.profile.Modules.Warlock = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Warlock " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Warlock " .. L.OptionsMissing)
			end
		end
	elseif pClass == "WARRIOR" then
		local loaded, reason = LoadAddOn("RSA_Warrior")
		if not loaded then
			RSA.db.profile.Modules.Warrior = false
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Warrior " .. L.OptionsDisabled .. L.OptionsClass)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Warrior " .. L.OptionsMissing)
			end
		end
	end
end -- End OnInitialize
function RSA:RefreshConfig()
	self:SetSinkStorage(self.db.profile)
	self:Disable()
	self:Enable()
end -- End RefreshConfig
function RSA:ChatCommand(input) -- Handle slash commands. Due to new loading, removed all commands.
	--[===[@alpha@
	if input == "DisableAlphaWarning" then
	RSA.db.global.DisableAlphaWarning = true
	RSA.Print_Self("Will no longer create warnings about alpha version files.")
	elseif input == "EnableAlphaWarning" then
	RSA.db.global.DisableAlphaWarning = false
	RSA.Print_Self("Will create warnings about alpha version files upon login.")
	else
	--@end-alpha@]===]
	if not IsAddOnLoaded("RSA_Options") then
		InterfaceOptionsFrame_OpenToCategory("RSA")
	end
	InterfaceOptionsFrame_OpenToCategory("Spell Options","RSA")
	InterfaceOptionsFrame_OpenToCategory("RSA","RSA")
	--[===[@alpha@
	end
	--@end-alpha@]===]
end
do -- Adds a blank RSA Panel to the Blizzard Addon Options window, which upon clicked loads RSA Options. No more need to use /rsa.
	local frame = CreateFrame("Frame", nil, UIParent)
	frame.name = "RSA"
	frame:Hide()
	local function removeFrame()
		for k, f in next, INTERFACEOPTIONS_ADDONCATEGORIES do
			if f == frame then
				tremove(INTERFACEOPTIONS_ADDONCATEGORIES, k)
				break
			end
		end
	end
	frame:SetScript("OnShow", function()
		removeFrame()
		local loaded, reason = LoadAddOn("RSA_Options")
		InterfaceOptionsFrame_OpenToCategory("Spell Options","RSA")
		InterfaceOptionsFrame_OpenToCategory("RSA","RSA")
		if not loaded then
			if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Options " .. L.OptionsDisabled)
			elseif reason == "MISSING" or reason == "CORRUPT" then
				ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Options " .. L.OptionsMissing)
			end
		end
	end)
	InterfaceOptions_AddCategory(frame)
end
--------------------------
---- Global Functions ----
--------------------------
function RSA.AnnouncementCheck() -- Checks against user settings to see if we are allowed to announce.
	local InInstance, InstanceType = IsInInstance()
	if RSA.db.profile.General.GlobalAnnouncements.OnlyInCombat and not InCombatLockdown() then return false end -- If we're not in combat and only announce in combat, stop right here.
	if RSA.db.profile.General.GlobalAnnouncements.InPvP and UnitIsPVP("player") == 1 then return true end
	if RSA.db.profile.General.GlobalAnnouncements.Arena and InstanceType == "arena" then return true end
	if RSA.db.profile.General.GlobalAnnouncements.Battlegrounds and InstanceType == "pvp" then return true end
	if RSA.db.profile.General.GlobalAnnouncements.InDungeon and (InstanceType == "party") then return true end
	if RSA.db.profile.General.GlobalAnnouncements.InRaid and InstanceType == "raid" then return true end
	if RSA.db.profile.General.GlobalAnnouncements.InTolBarad and GetZoneText() == L["Tol Barad"] then return true end
	if RSA.db.profile.General.GlobalAnnouncements.InWorld and InstanceType == "none" and GetZoneText() ~= L["Tol Barad"] and UnitIsPVP("player") ~= 1 then return true end
	if RSA.db.profile.General.GlobalAnnouncements.InScenario and IsInScenarioGroup("player") == true then return true end
	if RSA.db.profile.General.GlobalAnnouncements.InLFG and (IsInGroup(LE_PARTY_CATEGORY_INSTANCE) or IsInRaid(LE_PARTY_CATEGORY_INSTANCE)) then return true end
	return false
end
function RSA.String_Replace(str) -- Used for custom messages to replace text.
	return RSA.Replacements [str] or str
end
function RSA.CopyText(text) -- Not used at the moment, but perhaps useful in the future.
	ChatFrame1EditBox:Show();
	ChatFrame1EditBox:SetFocus();
	ChatFrame1EditBox:Insert(text);
	ChatFrame1EditBox:HighlightText();
end
function RSA.Print_Self(message) -- Send a message to your default chat window.
	ChatFrame1:AddMessage("|cFFFF75B3RSA:|r " .. format(message))
end
function RSA.Print_LibSink(message) -- Sends a message set by LibSink-2.0. Could just use :Pour on the messages themselves, but this is here to save work later if I need to add any additional checks.
	RSA:Pour("|cFFFF75B3RSA:|r " .. message, 1, 1, 1)
end
function RSA.Print_SmartGroup(message) -- Send a message to battleground, raid, party, or nothing, depending on group size or location.
	local InInstance, InstanceType = IsInInstance()
	local Announced = false
	if RSA.AnnouncementCheck() == true then
		-- If player is in an instance
		if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) or IsInRaid(LE_PARTY_CATEGORY_INSTANCE) then
			if RSA.db.profile.General.GlobalAnnouncements.InLFG == true then
				SendChatMessage(format(message), "INSTANCE_CHAT", nil)
				Announced = true
			elseif RSA.db.profile.General.GlobalAnnouncements.InLFG == false then
				Announced = true
			end
			return end
		-- PVP and arenas
		if InstanceType == "pvp" or InstanceType == "arena" and Announced == false then
			SendChatMessage(format(message), "INSTANCE_CHAT", nil)
			Announced = true
			return end
		-- Any other situation of RAID or GROUP
		if GetNumGroupMembers() > 0 and Announced == false then
			if IsInRaid(LE_PARTY_CATEGORY_HOME) then
				SendChatMessage(format(message), "RAID", nil)
				Announced = true
			elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
				SendChatMessage(format(message), "PARTY", nil)
				Announced = true
			end
			return end
		if RSA.db.profile.General.GlobalAnnouncements.SmartSay == true and Announced == false then
			if GetNumGroupMembers() > 0 or GetNumSubgroupMembers() > 0 then
				SendChatMessage(format(message), "SAY", nil)
			end
		elseif RSA.db.profile.General.GlobalAnnouncements.SmartSay == false then
			SendChatMessage(format(message), "SAY", nil)
		end
	end
end
function RSA.Print_Raid(message) -- Send a message to raid or an LFR instance. Additionally, will not try to send a message if in a Battleground or Arena.
	local InInstance, InstanceType = IsInInstance()
	if RSA.AnnouncementCheck() == true and InstanceType ~= "pvp" and InstanceType ~= "arena" then
		if IsInRaid(LE_PARTY_CATEGORY_INSTANCE) then
			SendChatMessage(format(message), "INSTANCE_CHAT", nil)
		elseif IsInRaid(LE_PARTY_CATEGORY_HOME) then
			SendChatMessage(format(message), "RAID", nil)
		end
	end
end
function RSA.Print_Party(message) -- Send a message to 5-man instance or a party. Additionally, will not try to send a message if in a Battleground.
	local InInstance, InstanceType = IsInInstance()
	if RSA.AnnouncementCheck() == true and InstanceType ~= "pvp" then
		if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
			SendChatMessage(format(message), "INSTANCE_CHAT", nil)
		elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
			SendChatMessage(format(message), "PARTY", nil)
		end
	end
end
function RSA.Print_Channel(message, channel) -- Send a message to the custom channel that the user defines.
	if RSA.AnnouncementCheck() == true then
		if RSA.db.profile.General.GlobalAnnouncements.SmartCustomChannel == true then
			if GetNumGroupMembers() > 0 or GetNumSubgroupMembers() > 0 then
				SendChatMessage(format(message), "CHANNEL", nil, GetChannelName(channel))
			end
		elseif RSA.db.profile.General.GlobalAnnouncements.SmartCustomChannel == false then
			SendChatMessage(format(message), "CHANNEL", nil, GetChannelName(channel))
		end
	end
end
function RSA.Print_Self_RW(message) -- Send a message locally to the raid warning frame. Only visible to the user.
	local RWColor = {r=1, g=1, b=1}
	RaidNotice_AddMessage(RaidWarningFrame, "|cFFFF75B3RSA:|r " .. format(message), RWColor)
end
function RSA.Print_RW(message) -- Send a proper message to the raid warning frame.
	if RSA.AnnouncementCheck() == true then
		SendChatMessage(format(message), "RAID_WARNING", nil)
	end
end
function RSA.Print_Whisper(message, target) -- Send a whisper to the target.
	if RSA.AnnouncementCheck() == true then
		SendChatMessage(format(message), "WHISPER", nil, target)
	end
end
local bor,band = bit.bor, bit.band -- get a local reference to some bitlib functions for faster lookups
local CL_OBJECT_FRIENDLY_PLAYER = bor(COMBATLOG_OBJECT_TYPE_PLAYER,COMBATLOG_OBJECT_REACTION_FRIENDLY) -- construct a friendly player bitmask
function RSA.Whisperable(destFlags) -- Checks if the unit is a player or not. We can't use Blizzard's API for this since RSA can announce casts for any unit, not just units that fall under UnitID.
	if band(CL_OBJECT_FRIENDLY_PLAYER,destFlags) == CL_OBJECT_FRIENDLY_PLAYER then -- check if players in vehicle need special handling
		return true
	end
end
function RSA.Print_Say(message) -- Send a message to Say.
	if RSA.AnnouncementCheck() == true then
		if RSA.db.profile.General.GlobalAnnouncements.SmartSay == true then
			if GetNumGroupMembers() > 0 or GetNumSubgroupMembers() > 0 then
				SendChatMessage(format(message), "SAY", nil)
			end
		elseif RSA.db.profile.General.GlobalAnnouncements.SmartSay == false then
			SendChatMessage(format(message), "SAY", nil)
		end
	end
end
function RSA.Print_Yell(message) -- Send a message to Yell.
	if RSA.AnnouncementCheck() == true then
		if RSA.db.profile.General.GlobalAnnouncements.SmartSay == true then
			if GetNumGroupMembers() > 0 or GetNumSubgroupMembers() > 0 then
				SendChatMessage(format(message), "YELL", nil)
			end
		elseif RSA.db.profile.General.GlobalAnnouncements.SmartSay == false then
			SendChatMessage(format(message), "YELL", nil)
		end
	end
end
function RSA.Reload_Link(message1, message2) -- Generates a message with a hyperlink to reload their UI.
	ChatFrame1:AddMessage("|cFFFF75B3RSA:|r " .. format(message1) .. "|cffffa0a0|Hrldui:RSA|h[Reload]|h|r" .. format(message2))
end
function RSA.Talents() -- Detects which talent tree a user has primarily.
	if not GetSpecializationInfo( 1 ) then
		return -- Talents aren't loaded yet!
	end
	local specID = GetSpecialization()
	if specID then
		return specID
	end
end
function RSA.RaceCheck(Race) -- Detects what race we are. Returns false if it is the same as the arg, true if not.
	if db.profile.General.Race == Race then
		return false
	else
		return true
	end
end
function RSA.CanAnnounce() -- If we are the Raid or Party Leader, or If we have assist in a raid, used for Leader section of General Announcements. TODO: Improve upon this vastly so we can never potentially have multiple raid assistants announcing.
	if UnitIsGroupLeader(pName) then return true end
	if UnitIsGroupAssistant(pName) then return true end
	return false
end
function RSA.SetBonus(Name) -- Returns the number of items we are wearing of a set passed in the first argument. This would be a table in the class module.
	local Equipped = 0
	local items = RSA.ItemSets[Name]
	if items then
		for i = 1,#items do
			if IsEquippedItem(items[i]) then
				Equipped = Equipped + 1
			end
		end
	end
	return Equipped
end
function RSA.Glyphs(spellID) -- Returns true if the glyph id we pass to it is equipped.
	for i = 1,9 do
		local _, _, _, spell = GetGlyphSocketInfo(i)
		if spell and tonumber(spell) == tonumber(spellID) then
			return true
		end
	end
	return false
end
-------------------------------------------
---- Global Frames and Event Registers ----
-------------------------------------------
RSA.CombatLogMonitor = CreateFrame("Frame", "RSA:CLM")
RSA.CombatLogMonitor:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
RSA.GeneralSpellsMonitor = CreateFrame("Frame", "RSA:GSM")
RSA.GeneralSpellsMonitor:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
---------------------------------------
---- General Announcements Monitor ----
---------------------------------------
local function General_Spells(self, _, timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, ex2, ex3, ex4)
	local petName = UnitName("pet")
	if UnitPlayerOrPetInParty(source) or UnitInRaid(source) or source == pName or source == petName then
		if event == "SPELL_CAST_START" then
			if (spellID == 57426 or spellID == 57426 or spellID == 87643 or spellID == 87915 or spellID == 87644
					or spellID == 126449 or spellID == 105193 or spellID == 126496 or spellID == 126498 or spellID == 126504
					or spellID == 126502 or spellID == 126500 or spellID == 126494 or spellID == 104958 or spellID == 126495
					or spellID == 126497 or spellID == 126503 or spellID == 126501 or spellID == 126492) and RSA.CanAnnounce() then -- FEASTS
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.Feasts.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.Feasts.Local == true then
						RSA.Print_LibSink(string.gsub(RSA.db.profile.General.Spells.Feasts.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Feasts.Yell == true then
						RSA.Print_Yell(string.gsub(RSA.db.profile.General.Spells.Feasts.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Feasts.CustomChannel.Enabled == true then
						RSA.Print_Channel(string.gsub(RSA.db.profile.General.Spells.Feasts.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.General.Spells.Feasts.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.Feasts.Say == true then
						RSA.Print_Say(string.gsub(RSA.db.profile.General.Spells.Feasts.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Feasts.SmartGroup == true then
						RSA.Print_SmartGroup(string.gsub(RSA.db.profile.General.Spells.Feasts.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Feasts.Party == true then
						if RSA.db.profile.General.Spells.Feasts.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
						RSA.Print_Party(string.gsub(RSA.db.profile.General.Spells.Feasts.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Feasts.Raid == true then
						if RSA.db.profile.General.Spells.Feasts.SmartGroup == true and GetNumGroupMembers() > 0 then return end
						RSA.Print_Raid(string.gsub(RSA.db.profile.General.Spells.Feasts.Messages.Start, ".%a+.", RSA.String_Replace))
					end
				end
			end -- FEASTS
			if (spellID == 92712 or spellID == 92649) and RSA.CanAnnounce() then -- CAULDRON
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.Cauldron.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.Cauldron.Local == true then
						RSA.Print_LibSink(string.gsub(RSA.db.profile.General.Spells.Cauldron.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Cauldron.Yell == true then
						RSA.Print_Yell(string.gsub(RSA.db.profile.General.Spells.Cauldron.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Cauldron.CustomChannel.Enabled == true then
						RSA.Print_Channel(string.gsub(RSA.db.profile.General.Spells.Cauldron.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.General.Spells.Cauldron.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.Cauldron.Say == true then
						RSA.Print_Say(string.gsub(RSA.db.profile.General.Spells.Cauldron.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Cauldron.SmartGroup == true then
						RSA.Print_SmartGroup(string.gsub(RSA.db.profile.General.Spells.Cauldron.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Cauldron.Party == true then
						if RSA.db.profile.General.Spells.Cauldron.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
						RSA.Print_Party(string.gsub(RSA.db.profile.General.Spells.Cauldron.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Cauldron.Raid == true then
						if RSA.db.profile.General.Spells.Cauldron.SmartGroup == true and GetNumGroupMembers() > 0 then return end
						RSA.Print_Raid(string.gsub(RSA.db.profile.General.Spells.Cauldron.Messages.Start, ".%a+.", RSA.String_Replace))
					end
				end
			end -- CAULDRON
			if spellID == 83968 and source == pName then -- MASS RESURRECTION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.General.Spells.MassRess.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.MassRess.Local == true then
						RSA.Print_LibSink(string.gsub(RSA.db.profile.General.Spells.MassRess.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.MassRess.Yell == true then
						RSA.Print_Yell(string.gsub(RSA.db.profile.General.Spells.MassRess.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.MassRess.CustomChannel.Enabled == true then
						RSA.Print_Channel(string.gsub(RSA.db.profile.General.Spells.MassRess.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.General.Spells.MassRess.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.MassRess.Say == true then
						RSA.Print_Say(string.gsub(RSA.db.profile.General.Spells.MassRess.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.MassRess.SmartGroup == true then
						RSA.Print_SmartGroup(string.gsub(RSA.db.profile.General.Spells.MassRess.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.MassRess.Party == true then
						if RSA.db.profile.General.Spells.MassRess.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
						RSA.Print_Party(string.gsub(RSA.db.profile.General.Spells.MassRess.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.MassRess.Raid == true then
						if RSA.db.profile.General.Spells.MassRess.SmartGroup == true and GetNumGroupMembers() > 0 then return end
						RSA.Print_Raid(string.gsub(RSA.db.profile.General.Spells.MassRess.Messages.Start, ".%a+.", RSA.String_Replace))
					end
				end
			end -- MASS RESURRECTION
			if spellID == 83958 and RSA.CanAnnounce() then -- MOBILE BANKING
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.MobileBank.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.MobileBank.Local == true then
						RSA.Print_LibSink(string.gsub(RSA.db.profile.General.Spells.MobileBank.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.MobileBank.Yell == true then
						RSA.Print_Yell(string.gsub(RSA.db.profile.General.Spells.MobileBank.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.MobileBank.CustomChannel.Enabled == true then
						RSA.Print_Channel(string.gsub(RSA.db.profile.General.Spells.MobileBank.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.General.Spells.MobileBank.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.MobileBank.Say == true then
						RSA.Print_Say(string.gsub(RSA.db.profile.General.Spells.MobileBank.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.MobileBank.SmartGroup == true then
						RSA.Print_SmartGroup(string.gsub(RSA.db.profile.General.Spells.MobileBank.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.MobileBank.Party == true then
						if RSA.db.profile.General.Spells.MobileBank.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
						RSA.Print_Party(string.gsub(RSA.db.profile.General.Spells.MobileBank.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.MobileBank.Raid == true then
						if RSA.db.profile.General.Spells.MobileBank.SmartGroup == true and GetNumGroupMembers() > 0 then return end
						RSA.Print_Raid(string.gsub(RSA.db.profile.General.Spells.MobileBank.Messages.Start, ".%a+.", RSA.String_Replace))
					end
				end
			end -- MOBILE BANKING
		end -- IF EVENT IS SPELL_CAST_START
		if event == "SPELL_SUMMON" then
			if (spellID == 67826 or spellID == 44389 or spellID == 54711 or spellID == 22700) and RSA.CanAnnounce() then -- JEEVES
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				botguids[destGUID] = {["source"] = source, ["spellID"] = spellID }
				if RSA.db.profile.General.Spells.Jeeves.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.Jeeves.Local == true then
						RSA.Print_LibSink(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Jeeves.Yell == true then
						RSA.Print_Yell(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Jeeves.CustomChannel.Enabled == true then
						RSA.Print_Channel(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.General.Spells.Jeeves.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.Jeeves.Say == true then
						RSA.Print_Say(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Jeeves.SmartGroup == true then
						RSA.Print_SmartGroup(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Jeeves.Party == true then
						if RSA.db.profile.General.Spells.Jeeves.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
						RSA.Print_Party(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Jeeves.Raid == true then
						if RSA.db.profile.General.Spells.Jeeves.SmartGroup == true and GetNumGroupMembers() > 0 then return end
						RSA.Print_Raid(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.Start, ".%a+.", RSA.String_Replace))
					end
				end
			end -- JEEVES
		end -- IF EVENT IS SPELL_SUMMON
		if event == "SPELL_CAST_SUCCESS" then
			if (spellID == 145166 or spellID == 145169 or spellID == 145196) and RSA.CanAnnounce() then -- FEASTS (Noodle Carts)
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.Feasts.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.Feasts.Local == true then
						RSA.Print_LibSink(string.gsub(RSA.db.profile.General.Spells.Feasts.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Feasts.Yell == true then
						RSA.Print_Yell(string.gsub(RSA.db.profile.General.Spells.Feasts.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Feasts.CustomChannel.Enabled == true then
						RSA.Print_Channel(string.gsub(RSA.db.profile.General.Spells.Feasts.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.General.Spells.Feasts.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.Feasts.Say == true then
						RSA.Print_Say(string.gsub(RSA.db.profile.General.Spells.Feasts.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Feasts.SmartGroup == true then
						RSA.Print_SmartGroup(string.gsub(RSA.db.profile.General.Spells.Feasts.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Feasts.Party == true then
						if RSA.db.profile.General.Spells.Feasts.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
						RSA.Print_Party(string.gsub(RSA.db.profile.General.Spells.Feasts.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Feasts.Raid == true then
						if RSA.db.profile.General.Spells.Feasts.SmartGroup == true and GetNumGroupMembers() > 0 then return end
						RSA.Print_Raid(string.gsub(RSA.db.profile.General.Spells.Feasts.Messages.Start, ".%a+.", RSA.String_Replace))
					end
				end
			end -- FEASTS (Noodle Carts)
			if (spellID == 28880 or spellID == 59547 or spellID == 59544 or spellID == 59542 or spellID == 59548 or spellID == 59543 or spellID == 59545) and source == pName then -- GIFT OF THE NAARU
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
				if RSA.db.profile.General.Spells.GOTN.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.GOTN.Local == true then
						RSA.Print_LibSink(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.GOTN.Yell == true then
						RSA.Print_Yell(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.GOTN.CustomChannel.Enabled == true then
						RSA.Print_Channel(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.General.Spells.GOTN.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.GOTN.Say == true then
						RSA.Print_Say(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.GOTN.SmartGroup == true then
						RSA.Print_SmartGroup(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.GOTN.Party == true then
						if RSA.db.profile.General.Spells.GOTN.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
						RSA.Print_Party(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.GOTN.Raid == true then
						if RSA.db.profile.General.Spells.GOTN.SmartGroup == true and GetNumGroupMembers() > 0 then return end
						RSA.Print_Raid(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.Start, ".%a+.", RSA.String_Replace))
					end
				end
			end -- GIFT OF THE NAARU
			if spellID == 59752 and source == pName then -- EVERY MAN FOR HIMSELF
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.General.Spells.EMFH.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.EMFH.Local == true then
						RSA.Print_LibSink(string.gsub(RSA.db.profile.General.Spells.EMFH.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.EMFH.Yell == true then
						RSA.Print_Yell(string.gsub(RSA.db.profile.General.Spells.EMFH.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.EMFH.CustomChannel.Enabled == true then
						RSA.Print_Channel(string.gsub(RSA.db.profile.General.Spells.EMFH.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.General.Spells.EMFH.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.EMFH.Say == true then
						RSA.Print_Say(string.gsub(RSA.db.profile.General.Spells.EMFH.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.EMFH.SmartGroup == true then
						RSA.Print_SmartGroup(string.gsub(RSA.db.profile.General.Spells.EMFH.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.EMFH.Party == true then
						if RSA.db.profile.General.Spells.EMFH.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
						RSA.Print_Party(string.gsub(RSA.db.profile.General.Spells.EMFH.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.EMFH.Raid == true then
						if RSA.db.profile.General.Spells.EMFH.SmartGroup == true and GetNumGroupMembers() > 0 then return end
						RSA.Print_Raid(string.gsub(RSA.db.profile.General.Spells.EMFH.Messages.Start, ".%a+.", RSA.String_Replace))
					end
				end
			end -- EVERY MAN FOR HIMSELF
			if spellID == 20549 and source == pName then -- WARSTOMP
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.General.Spells.WarStomp.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.WarStomp.Local == true then
						RSA.Print_LibSink(string.gsub(RSA.db.profile.General.Spells.WarStomp.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.WarStomp.Yell == true then
						RSA.Print_Yell(string.gsub(RSA.db.profile.General.Spells.WarStomp.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.WarStomp.CustomChannel.Enabled == true then
						RSA.Print_Channel(string.gsub(RSA.db.profile.General.Spells.WarStomp.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.General.Spells.WarStomp.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.WarStomp.Say == true then
						RSA.Print_Say(string.gsub(RSA.db.profile.General.Spells.WarStomp.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.WarStomp.SmartGroup == true then
						RSA.Print_SmartGroup(string.gsub(RSA.db.profile.General.Spells.WarStomp.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.WarStomp.Party == true then
						if RSA.db.profile.General.Spells.WarStomp.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
						RSA.Print_Party(string.gsub(RSA.db.profile.General.Spells.WarStomp.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.WarStomp.Raid == true then
						if RSA.db.profile.General.Spells.WarStomp.SmartGroup == true and GetNumGroupMembers() > 0 then return end
						RSA.Print_Raid(string.gsub(RSA.db.profile.General.Spells.WarStomp.Messages.Start, ".%a+.", RSA.String_Replace))
					end
				end
			end -- WARSTOMP
			if spellID == 7744 and source == pName then -- WILL OF THE FORSAKEN
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.WOTF.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.WOTF.Local == true then
						RSA.Print_LibSink(string.gsub(RSA.db.profile.General.Spells.WOTF.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.WOTF.Yell == true then
						RSA.Print_Yell(string.gsub(RSA.db.profile.General.Spells.WOTF.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.WOTF.CustomChannel.Enabled == true then
						RSA.Print_Channel(string.gsub(RSA.db.profile.General.Spells.WOTF.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.General.Spells.WOTF.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.WOTF.Say == true then
						RSA.Print_Say(string.gsub(RSA.db.profile.General.Spells.WOTF.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.WOTF.SmartGroup == true then
						RSA.Print_SmartGroup(string.gsub(RSA.db.profile.General.Spells.WOTF.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.WOTF.Party == true then
						if RSA.db.profile.General.Spells.WOTF.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
						RSA.Print_Party(string.gsub(RSA.db.profile.General.Spells.WOTF.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.WOTF.Raid == true then
						if RSA.db.profile.General.Spells.WOTF.SmartGroup == true and GetNumGroupMembers() > 0 then return end
						RSA.Print_Raid(string.gsub(RSA.db.profile.General.Spells.WOTF.Messages.Start, ".%a+.", RSA.String_Replace))
					end
				end
			end -- WILL OF THE FORSAKEN
			if spellID == 20589 and source == pName then -- ESCAPE ARTIST
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.EscapeArtist.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.EscapeArtist.Local == true then
						RSA.Print_LibSink(string.gsub(RSA.db.profile.General.Spells.EscapeArtist.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.EscapeArtist.Yell == true then
						RSA.Print_Yell(string.gsub(RSA.db.profile.General.Spells.EscapeArtist.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.EscapeArtist.CustomChannel.Enabled == true then
						RSA.Print_Channel(string.gsub(RSA.db.profile.General.Spells.EscapeArtist.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.General.Spells.EscapeArtist.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.EscapeArtist.Say == true then
						RSA.Print_Say(string.gsub(RSA.db.profile.General.Spells.EscapeArtist.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.EscapeArtist.SmartGroup == true then
						RSA.Print_SmartGroup(string.gsub(RSA.db.profile.General.Spells.EscapeArtist.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.EscapeArtist.Party == true then
						if RSA.db.profile.General.Spells.EscapeArtist.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
						RSA.Print_Party(string.gsub(RSA.db.profile.General.Spells.EscapeArtist.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.EscapeArtist.Raid == true then
						if RSA.db.profile.General.Spells.EscapeArtist.SmartGroup == true and GetNumGroupMembers() > 0 then return end
						RSA.Print_Raid(string.gsub(RSA.db.profile.General.Spells.EscapeArtist.Messages.Start, ".%a+.", RSA.String_Replace))
					end
				end
			end -- ESCAPE ARTIST
			if (spellID == 78993 or spellID == 105701) and source == pName then -- POTION OF FOCUS / CONCENTRATION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.PotionOfConcentration.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.PotionOfConcentration.Local == true then
						RSA.Print_LibSink(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.Yell == true then
						RSA.Print_Yell(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.CustomChannel.Enabled == true then
						RSA.Print_Channel(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.General.Spells.PotionOfConcentration.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.Say == true then
						RSA.Print_Say(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.SmartGroup == true then
						RSA.Print_SmartGroup(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.Party == true then
						if RSA.db.profile.General.Spells.PotionOfConcentration.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
						RSA.Print_Party(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.Raid == true then
						if RSA.db.profile.General.Spells.PotionOfConcentration.SmartGroup == true and GetNumGroupMembers() > 0 then return end
						RSA.Print_Raid(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.Start, ".%a+.", RSA.String_Replace))
					end
				end
			end -- POTION OF FOCUS / CONCENTRATION
			if (spellID == 28730 or spellID == 50613 or spellID == 80483 or spellID == 25046 or spellID == 69179) and source == pName then -- ARCANE TORRENT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.ArcaneTorrent.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.ArcaneTorrent.Local == true then
						RSA.Print_LibSink(string.gsub(RSA.db.profile.General.Spells.ArcaneTorrent.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.ArcaneTorrent.Yell == true then
						RSA.Print_Yell(string.gsub(RSA.db.profile.General.Spells.ArcaneTorrent.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.ArcaneTorrent.CustomChannel.Enabled == true then
						RSA.Print_Channel(string.gsub(RSA.db.profile.General.Spells.ArcaneTorrent.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.General.Spells.ArcaneTorrent.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.ArcaneTorrent.Say == true then
						RSA.Print_Say(string.gsub(RSA.db.profile.General.Spells.ArcaneTorrent.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.ArcaneTorrent.SmartGroup == true then
						RSA.Print_SmartGroup(string.gsub(RSA.db.profile.General.Spells.ArcaneTorrent.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.ArcaneTorrent.Party == true then
						if RSA.db.profile.General.Spells.ArcaneTorrent.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
						RSA.Print_Party(string.gsub(RSA.db.profile.General.Spells.ArcaneTorrent.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.ArcaneTorrent.Raid == true then
						if RSA.db.profile.General.Spells.ArcaneTorrent.SmartGroup == true and GetNumGroupMembers() > 0 then return end
						RSA.Print_Raid(string.gsub(RSA.db.profile.General.Spells.ArcaneTorrent.Messages.Start, ".%a+.", RSA.String_Replace))
					end
				end
			end -- ARCANE TORRENT
		end -- IF EVENT IS SPELL_CAST_SUCCESS
		if event == "SPELL_AURA_APPLIED" then
			if spellID == 65116 and source == pName then -- STONEFORM
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
				if RSA.db.profile.General.Spells.Stoneform.Messages.Start ~= "" then
					if RSA.db.profile.General.Spells.Stoneform.Local == true then
						RSA.Print_LibSink(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Stoneform.Yell == true then
						RSA.Print_Yell(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Stoneform.CustomChannel.Enabled == true then
						RSA.Print_Channel(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.General.Spells.Stoneform.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.Stoneform.Say == true then
						RSA.Print_Say(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Stoneform.SmartGroup == true then
						RSA.Print_SmartGroup(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Stoneform.Party == true then
						if RSA.db.profile.General.Spells.Stoneform.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
						RSA.Print_Party(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Stoneform.Raid == true then
						if RSA.db.profile.General.Spells.Stoneform.SmartGroup == true and GetNumGroupMembers() > 0 then return end
						RSA.Print_Raid(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.Start, ".%a+.", RSA.String_Replace))
					end
				end
			end -- STONEFORM
		end -- IF EVENT IS SPELL_AURA_APPLIED
		if event == "SPELL_AURA_REMOVED" then
			if spellID == 59547 and source == pName then -- GIFT OF THE NAARU
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.GOTN.Messages.End ~= "" then
					if RSA.db.profile.General.Spells.GOTN.Local == true then
						RSA.Print_LibSink(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.End, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.GOTN.Yell == true then
						RSA.Print_Yell(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.End, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.GOTN.CustomChannel.Enabled == true then
						RSA.Print_Channel(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.General.Spells.GOTN.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.GOTN.Say == true then
						RSA.Print_Say(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.End, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.GOTN.SmartGroup == true then
						RSA.Print_SmartGroup(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.End, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.GOTN.Party == true then
						if RSA.db.profile.General.Spells.GOTN.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
						RSA.Print_Party(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.End, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.GOTN.Raid == true then
						if RSA.db.profile.General.Spells.GOTN.SmartGroup == true and GetNumGroupMembers() > 0 then return end
						RSA.Print_Raid(string.gsub(RSA.db.profile.General.Spells.GOTN.Messages.End, ".%a+.", RSA.String_Replace))
					end
				end
			end -- GIFT OF THE NAARU
			if spellID == 65116 and source == pName then -- STONEFORM
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.Stoneform.Messages.End ~= "" then
					if RSA.db.profile.General.Spells.Stoneform.Local == true then
						RSA.Print_LibSink(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.End, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Stoneform.Yell == true then
						RSA.Print_Yell(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.End, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Stoneform.CustomChannel.Enabled == true then
						RSA.Print_Channel(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.General.Spells.Stoneform.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.Stoneform.Say == true then
						RSA.Print_Say(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.End, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Stoneform.SmartGroup == true then
						RSA.Print_SmartGroup(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.End, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Stoneform.Party == true then
						if RSA.db.profile.General.Spells.Stoneform.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
						RSA.Print_Party(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.End, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.Stoneform.Raid == true then
						if RSA.db.profile.General.Spells.Stoneform.SmartGroup == true and GetNumGroupMembers() > 0 then return end
						RSA.Print_Raid(string.gsub(RSA.db.profile.General.Spells.Stoneform.Messages.End, ".%a+.", RSA.String_Replace))
					end
				end
			end -- STONEFORM
			if (spellID == 78993 or spellID == 105701) and source == pName then -- POTION OF FOCUS / CONCENTRATION
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.General.Spells.PotionOfConcentration.Messages.End ~= "" then
					if RSA.db.profile.General.Spells.PotionOfConcentration.Local == true then
						RSA.Print_LibSink(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.End, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.Yell == true then
						RSA.Print_Yell(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.End, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.CustomChannel.Enabled == true then
						RSA.Print_Channel(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.General.Spells.PotionOfConcentration.CustomChannel.Channel)
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.Say == true then
						RSA.Print_Say(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.End, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.SmartGroup == true then
						RSA.Print_SmartGroup(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.End, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.Party == true then
						if RSA.db.profile.General.Spells.PotionOfConcentration.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
						RSA.Print_Party(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.End, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.General.Spells.PotionOfConcentration.Raid == true then
						if RSA.db.profile.General.Spells.PotionOfConcentration.SmartGroup == true and GetNumGroupMembers() > 0 then return end
						RSA.Print_Raid(string.gsub(RSA.db.profile.General.Spells.PotionOfConcentration.Messages.End, ".%a+.", RSA.String_Replace))
					end
				end
			end -- POTION OF FOCUS / CONCENTRATION
		end -- IF EVENT IS SPELL_AURA_REMOVED
	end -- IF SOURCE IS PLAYER OR PET
	if event == "SPELL_AURA_REMOVED" then
		if spellID == 68054 and botguids[destGUID] and RSA.CanAnnounce() then -- JEEVES
			spellinfo = GetSpellInfo(botguids[destGUID]["spellID"])
			spelllinkinfo = GetSpellLink(botguids[destGUID]["spellID"])
			RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = botguids[destGUID]["source"],}
			botguids[destGUID] = nil
			if RSA.db.profile.General.Spells.Jeeves.Messages.End ~= "" then
				if RSA.db.profile.General.Spells.Jeeves.Local == true then
					RSA.Print_LibSink(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.End, ".%a+.", RSA.String_Replace))
				end
				if RSA.db.profile.General.Spells.Jeeves.Yell == true then
					RSA.Print_Yell(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.End, ".%a+.", RSA.String_Replace))
				end
				if RSA.db.profile.General.Spells.Jeeves.CustomChannel.Enabled == true then
					RSA.Print_Channel(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.General.Spells.Jeeves.CustomChannel.Channel)
				end
				if RSA.db.profile.General.Spells.Jeeves.Say == true then
					RSA.Print_Say(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.End, ".%a+.", RSA.String_Replace))
				end
				if RSA.db.profile.General.Spells.Jeeves.SmartGroup == true then
					RSA.Print_SmartGroup(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.End, ".%a+.", RSA.String_Replace))
				end
				if RSA.db.profile.General.Spells.Jeeves.Party == true then
					if RSA.db.profile.General.Spells.Jeeves.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
					RSA.Print_Party(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.End, ".%a+.", RSA.String_Replace))
				end
				if RSA.db.profile.General.Spells.Jeeves.Raid == true then
					if RSA.db.profile.General.Spells.Jeeves.SmartGroup == true and GetNumGroupMembers() > 0 then return end
					RSA.Print_Raid(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.End, ".%a+.", RSA.String_Replace))
				end
			end
		end -- JEEVES
	end -- IF EVENT IS SPELL AURA REMOVED
	if event == "UNIT_DIED" then
		if botguids[destGUID] and RSA.CanAnnounce() then -- JEEVES (Field Repair Bot 110G, Scrapbot)
			spellinfo = GetSpellInfo(botguids[destGUID]["spellID"])
			spelllinkinfo = GetSpellLink(botguids[destGUID]["spellID"])
			RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = botguids[destGUID]["source"],}
			botguids[destGUID] = nil
			if RSA.db.profile.General.Spells.Jeeves.Messages.End ~= "" then
				if RSA.db.profile.General.Spells.Jeeves.Local == true then
					RSA.Print_LibSink(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.End, ".%a+.", RSA.String_Replace))
				end
				if RSA.db.profile.General.Spells.Jeeves.Yell == true then
					RSA.Print_Yell(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.End, ".%a+.", RSA.String_Replace))
				end
				if RSA.db.profile.General.Spells.Jeeves.CustomChannel.Enabled == true then
					RSA.Print_Channel(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.General.Spells.Jeeves.CustomChannel.Channel)
				end
				if RSA.db.profile.General.Spells.Jeeves.Say == true then
					RSA.Print_Say(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.End, ".%a+.", RSA.String_Replace))
				end
				if RSA.db.profile.General.Spells.Jeeves.SmartGroup == true then
					RSA.Print_SmartGroup(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.End, ".%a+.", RSA.String_Replace))
				end
				if RSA.db.profile.General.Spells.Jeeves.Party == true then
					if RSA.db.profile.General.Spells.Jeeves.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
					RSA.Print_Party(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.End, ".%a+.", RSA.String_Replace))
				end
				if RSA.db.profile.General.Spells.Jeeves.Raid == true then
					if RSA.db.profile.General.Spells.Jeeves.SmartGroup == true and GetNumGroupMembers() > 0 then return end
					RSA.Print_Raid(string.gsub(RSA.db.profile.General.Spells.Jeeves.Messages.End, ".%a+.", RSA.String_Replace))
				end
			end
		end -- JEEVES (Field Repair Bot 110G, Scrapbot)
	end -- IF EVENT IS UNIT_DIED
end -- END ENTIRELY
RSA.GeneralSpellsMonitor:SetScript("OnEvent", General_Spells)
