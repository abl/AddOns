----------------------------------------------
---- Raeli's Spell Announcer Druid Module ----
----------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_Druid = RSA:NewModule("Druid")
function RSA_Druid:OnInitialize()
	if RSA.db.profile.General.Class == "DRUID" then
		RSA_Druid:SetEnabledState(true)
	else
		RSA_Druid:SetEnabledState(false)
	end
end -- End OnInitialize
function RSA_Druid:OnEnable()
	RSA.db.profile.Modules.Druid = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
	local pName = UnitName("player")
	local Config_StampedingRoar = { -- STAMPEDING ROAR
		profile = 'StampedingRoar',
		targetIsMe = 1
	}
	local Config_StampedingRoar_End = { -- STAMPEDING ROAR
		profile = 'StampedingRoar',
		section = 'End',
		targetIsMe = 1
	}
	local Config_Berserk = { -- BERSERK
		profile = 'Berserk'
	}
	local Config_Berserk_End = { -- BERSERK
		profile = 'Berserk',
		section = 'End'
	}
	local Config_HeartOfTheWild = { -- HEART OF THE WILD
		profile = 'HeartOfTheWild'
	}
	local Config_HeartOfTheWild_End = { -- HEART OF THE WILD
		profile = 'HeartOfTheWild',
		section = 'End'
	}
	local MonitorConfig_Druid = {
		player_profile = RSA.db.profile.Druid,
		SPELL_DISPEL = {
			[2782] = { -- REMOVE CORRUPTION
				profile = 'RemoveCorruption',
				replacements = { TARGET = 1, extraSpellName = "[AURA]", extraSpellLink = "[AURALINK]" }
			},
			[88423] = { -- NATURE'S CURE
				profile = 'RemoveCorruption',
				replacements = { TARGET = 1, extraSpellName = "[AURA]", extraSpellLink = "[AURALINK]" }
			},
			[2908] = { -- SOOTHE
				profile = 'Soothe',
				replacements = { TARGET = 1, extraSpellName = "[AURA]", extraSpellLink = "[AURALINK]" }
			}
		},
		SPELL_AURA_APPLIED = {
			[106898] = Config_StampedingRoar,
			[77764] = Config_StampedingRoar,
			[77761] = Config_StampedingRoar,
			[50334] = Config_Berserk,
			[106951] = Config_Berserk,
			[108291] = Config_HeartOfTheWild,
			[108294] = Config_HeartOfTheWild,
			[6795] = { -- GROWL
				profile = 'Growl',
				replacements = { TARGET = 1 }
			},
			[33786] = { -- CYCLONE
				profile = 'Cyclone',
				replacements = { TARGET = 1 }
			},
			[339] = { -- ENTANGLING ROOTS
				profile = 'Roots',
				replacements = { TARGET = 1 }
			},
			[102342] = { -- IRONBARK
				profile = 'Ironbark',
				replacements = { TARGET = 1 }
			},
			[132402] = { -- SAVAGE DEFENSE
				profile = 'SavageDefense'
			},
			[33891] = { -- TREE OF LIFE
				profile = 'TreeOfLife'
			},
			[22812] = { -- BARKSKIN
				profile = 'Barkskin'
			},
			[5211] = { -- MIGHTY BASH
				profile = 'MightyBash',
				replacements = { TARGET = 1 }
			}
		},
		SPELL_CAST_SUCCESS = {
			[22842] = { -- FRENZIED REGENERATION
				profile = 'FrenziedRegeneration'
			},
			[740] = { -- TRANQUILITY
				profile = 'Tranquility'
			},
			[61336] = { -- SURVIVAL INSTINCTS
				profile = 'SurvivalInstincts'
			}
		},
		SPELL_AURA_REMOVED = {
			[50334] = Config_Berserk_End,
			[106951] = Config_Berserk_End,
			[106898] = Config_StampedingRoar_End,
			[77764] = Config_StampedingRoar_End,
			[77761] = Config_StampedingRoar_End,
			[108291] = Config_HeartOfTheWild_End,
			[108294] = Config_HeartOfTheWild_End,
			[61336] = { -- SURVIVAL INSTINCTS
				profile = 'SurvivalInstincts',
				section = 'End'
			},
			[33891] = { -- TREE OF LIFE
				profile = 'TreeOfLife',
				section = 'End'
			},
			[22812] = { -- BARKSKIN
				profile = 'Barkskin',
				section = 'End'
			},
			[132402] = { -- SAVAGE DEFENSE
				profile = 'SavageDefense',
				section = 'End'
			},
			[740] = { -- TRANQUILITY
				profile = 'Tranquility',
				section = 'End'
			},
			[33786] = { -- CYCLONE
				profile = 'Cyclone',
				section = 'End',
				replacements = { TARGET = 1 }
			},
			[339] = { -- ENTANGLING ROOTS
				profile = 'Roots',
				section = 'End',
				replacements = { TARGET = 1 }
			},
			[102342] = { -- IRONBARK
				profile = 'Ironbark',
				section = 'End',
				replacements = { TARGET = 1 }
			},
			[5211] = { -- MIGHTY BASH
				profile = 'MightyBash',
				section = 'End',
				replacements = { TARGET = 1 }
			}
		}
	}
	RSA.MonitorConfig(MonitorConfig_Druid, UnitGUID("player"))
	local MonitorAndAnnounce = RSA.MonitorAndAnnounce
	local ResTarget = L["Unknown"]
	local Ressed
	local spellinfo,spelllinkinfo,extraspellinfo,extraspellinfolink,missinfo
	local function Druid_Spells(self, _, timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, ex2, ex3, ex4)
		local petName = UnitName("pet")
		if source == pName or source == petName then
			if (event == "SPELL_CAST_SUCCESS" and RSA.db.profile.Modules.Reminders_Loaded == true) then -- Reminder Refreshed
				local ReminderSpell = RSA.db.profile.Druid.Reminders.SpellName
				if spellName == ReminderSpell and (dest == pName or dest == nil) then
					RSA.Reminder:SetScript("OnUpdate", nil)
					if RSA.db.profile.Reminders.RemindChannels.Chat == true then
						RSA.Print_Self(ReminderSpell .. L[" Refreshed!"])
					end
					if RSA.db.profile.Reminders.RemindChannels.RaidWarn == true then
						RSA.Print_Self_RW(ReminderSpell .. L[" Refreshed!"])
					end
				end
			end -- BUFF REMINDER
			if event == "SPELL_INTERRUPT" then
				if spellID == 93985 then -- SKULL BASH
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					extraspellinfo = GetSpellInfo(missType)
					extraspellinfolink = GetSpellLink(missType)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
					if RSA.db.profile.Druid.Spells.SkullBash.Messages.Start ~= "" then
						if RSA.db.profile.Druid.Spells.SkullBash.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.SkullBash.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.SkullBash.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Druid.Spells.SkullBash.CustomChannel.Channel)
						end
						if RSA.db.profile.Druid.Spells.SkullBash.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.SkullBash.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.SkullBash.Party == true then
							if RSA.db.profile.Druid.Spells.SkullBash.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.SkullBash.Raid == true then
							if RSA.db.profile.Druid.Spells.SkullBash.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SKULL BASH
				if spellID == 97547 then -- SOLAR BEAM
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					extraspellinfo = GetSpellInfo(missType)
					extraspellinfolink = GetSpellLink(missType)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
					if RSA.db.profile.Druid.Spells.SolarBeam.Messages.Start ~= "" then
						if RSA.db.profile.Druid.Spells.SolarBeam.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.SolarBeam.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.SolarBeam.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Druid.Spells.SolarBeam.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.SolarBeam.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.SolarBeam.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Druid.Spells.SolarBeam.CustomChannel.Channel)
						end
						if RSA.db.profile.Druid.Spells.SolarBeam.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Druid.Spells.SolarBeam.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.SolarBeam.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Druid.Spells.SolarBeam.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.SolarBeam.Party == true then
							if RSA.db.profile.Druid.Spells.SolarBeam.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Druid.Spells.SolarBeam.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.SolarBeam.Raid == true then
							if RSA.db.profile.Druid.Spells.SolarBeam.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.SolarBeam.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SOLAR BEAM
			end -- IF EVENT IS SPELL_INTERRUPT
			if event == "SPELL_DISPEL_FAILED" then
				if spellID == 2908 then -- SOOTHE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					extraspellinfo = GetSpellInfo(missType)
					extraspellinfolink = GetSpellLink(missType)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
					if RSA.db.profile.Druid.Spells.Soothe.Messages.End ~= "" then
						if RSA.db.profile.Druid.Spells.Soothe.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Soothe.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Soothe.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Druid.Spells.Soothe.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Soothe.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Soothe.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Druid.Spells.Soothe.CustomChannel.Channel)
						end
						if RSA.db.profile.Druid.Spells.Soothe.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Soothe.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Soothe.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Druid.Spells.Soothe.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Soothe.Party == true then
							if RSA.db.profile.Druid.Spells.Soothe.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Soothe.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Soothe.Raid == true then
							if RSA.db.profile.Druid.Spells.Soothe.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Soothe.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SOOTHE
			end -- IF EVENT IS SPELL_DISPEL_FAILED
			if event == "SPELL_MISSED" and missType ~= "IMMUNE" then
				if spellID == 6795 then -- GROWL
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.Druid.Spells.Growl.Messages.End ~= "" then
						if RSA.db.profile.Druid.Spells.Growl.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Growl.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Growl.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Druid.Spells.Growl.CustomChannel.Channel)
						end
						if RSA.db.profile.Druid.Spells.Growl.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Growl.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Growl.Party == true then
							if RSA.db.profile.Druid.Spells.Growl.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Growl.Raid == true then
							if RSA.db.profile.Druid.Spells.Growl.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- GROWL
				if spellID == 93985 then -- SKULL BASH
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.Druid.Spells.SkullBash.Messages.End ~= "" then
						if RSA.db.profile.Druid.Spells.SkullBash.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.SkullBash.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.SkullBash.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Druid.Spells.SkullBash.CustomChannel.Channel)
						end
						if RSA.db.profile.Druid.Spells.SkullBash.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.SkullBash.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.SkullBash.Party == true then
							if RSA.db.profile.Druid.Spells.SkullBash.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.SkullBash.Raid == true then
							if RSA.db.profile.Druid.Spells.SkullBash.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SKULL BASH
			end -- IF EVENT IS SPELL_MISSED AND NOT IMMUNE
			if event == "SPELL_MISSED" and missType == "IMMUNE" then
				if spellID == 6795 then -- GROWL
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.Druid.Spells.Growl.Messages.Immune ~= "" then
						if RSA.db.profile.Druid.Spells.Growl.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Growl.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Growl.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.Druid.Spells.Growl.CustomChannel.Channel)
						end
						if RSA.db.profile.Druid.Spells.Growl.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Growl.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Growl.Party == true then
							if RSA.db.profile.Druid.Spells.Growl.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Growl.Raid == true then
							if RSA.db.profile.Druid.Spells.Growl.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Growl.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- GROWL
				if spellID == 93985 then -- SKULL BASH
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.Druid.Spells.SkullBash.Messages.Immune ~= "" then
						if RSA.db.profile.Druid.Spells.SkullBash.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.SkullBash.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.SkullBash.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.Druid.Spells.SkullBash.CustomChannel.Channel)
						end
						if RSA.db.profile.Druid.Spells.SkullBash.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.SkullBash.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.SkullBash.Party == true then
							if RSA.db.profile.Druid.Spells.SkullBash.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.SkullBash.Raid == true then
							if RSA.db.profile.Druid.Spells.SkullBash.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.SkullBash.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SKULL BASH
			end -- IF EVENT IS SPELL_MISSED AND IS IMMUNE
			MonitorAndAnnounce(self, _, timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, ex2, ex3, ex4)
		end -- IF SOURCE IS PLAYER
	end -- END ENTIRELY
	RSA.CombatLogMonitor:SetScript("OnEvent", Druid_Spells)
	------------------------------
	---- Resurrection Monitor ----
	------------------------------
	local function Druid_Resurrections(_, event, source, spell, rank, dest, _)
		if UnitName(source) == pName then
			if spell == GetSpellInfo(50769) and RSA.db.profile.Druid.Spells.Revive.Messages.Start ~= "" then -- REVIVE
				if event == "UNIT_SPELLCAST_SENT" then
					Ressed = false
					if (dest == L["Unknown"] or dest == nil) then
						if UnitExists("target") ~= 1 or (UnitHealth("target") > 1 and UnitIsDeadOrGhost("target") ~= 1) then
							if GameTooltipTextLeft1:GetText() == nil then
								dest = L["Unknown"]
								ResTarget = L["Unknown"]
							else
								dest = string.gsub(GameTooltipTextLeft1:GetText(), L["Corpse of "], "")
								ResTarget = string.gsub(GameTooltipTextLeft1:GetText(), L["Corpse of "], "")
							end
						else
							dest = UnitName("target")
							ResTarget = UnitName("target")
						end
					else
						ResTarget = dest
					end
					spellinfo = GetSpellInfo(spell) spelllinkinfo = GetSpellLink(spell)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Druid.Spells.Revive.Messages.Start ~= "" then
						if RSA.db.profile.Druid.Spells.Revive.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Revive.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Revive.Whisper == true and dest ~= pName then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.Start, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Druid.Spells.Revive.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Druid.Spells.Revive.CustomChannel.Channel)
						end
						if RSA.db.profile.Druid.Spells.Revive.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Revive.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Revive.Party == true then
							if RSA.db.profile.Druid.Spells.Revive.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Revive.Raid == true then
							if RSA.db.profile.Druid.Spells.Revive.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				elseif event == "UNIT_SPELLCAST_SUCCEEDED" and Ressed ~= true then
					dest = ResTarget
					Ressed = true
					if RSA.db.profile.Druid.Spells.Revive.Messages.End ~= "" then
						if RSA.db.profile.Druid.Spells.Revive.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Revive.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Revive.Whisper == true and dest ~= pName then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.End, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Druid.Spells.Revive.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Druid.Spells.Revive.CustomChannel.Channel)
						end
						if RSA.db.profile.Druid.Spells.Revive.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Revive.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Revive.Party == true then
							if RSA.db.profile.Druid.Spells.Revive.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Revive.Raid == true then
							if RSA.db.profile.Druid.Spells.Revive.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Revive.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end
			end -- REVIVE
			if spell == GetSpellInfo(20484) and RSA.db.profile.Druid.Spells.Rebirth.Messages.Start ~= "" then -- REBIRTH
				if event == "UNIT_SPELLCAST_SENT" then
					Ressed = false
					if (dest == L["Unknown"] or dest == nil) then
						if UnitExists("target") ~= 1 or (UnitHealth("target") > 1 and UnitIsDeadOrGhost("target") ~= 1) then
							if GameTooltipTextLeft1:GetText() == nil then
								dest = L["Unknown"]
								ResTarget = L["Unknown"]
							else
								dest = string.gsub(GameTooltipTextLeft1:GetText(), L["Corpse of "], "")
								ResTarget = string.gsub(GameTooltipTextLeft1:GetText(), L["Corpse of "], "")
							end
						else
							dest = UnitName("target")
							ResTarget = UnitName("target")
						end
					else
						ResTarget = dest
					end
					spellinfo = GetSpellInfo(spell) spelllinkinfo = GetSpellLink(spell)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Druid.Spells.Rebirth.Messages.Start ~= "" then
						if RSA.db.profile.Druid.Spells.Rebirth.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Rebirth.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Rebirth.Whisper == true and dest ~= pName then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.Start, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Druid.Spells.Rebirth.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Druid.Spells.Rebirth.CustomChannel.Channel)
						end
						if RSA.db.profile.Druid.Spells.Rebirth.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Rebirth.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Rebirth.Party == true then
							if RSA.db.profile.Druid.Spells.Rebirth.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Rebirth.Raid == true then
							if RSA.db.profile.Druid.Spells.Rebirth.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				elseif event == "UNIT_SPELLCAST_SUCCEEDED" and Ressed ~= true then
					dest = ResTarget
					Ressed = true
					if RSA.db.profile.Druid.Spells.Rebirth.Messages.End ~= "" then
						if RSA.db.profile.Druid.Spells.Rebirth.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Rebirth.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Rebirth.Whisper == true and dest ~= pName then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.End, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Druid.Spells.Rebirth.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Druid.Spells.Rebirth.CustomChannel.Channel)
						end
						if RSA.db.profile.Druid.Spells.Rebirth.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Rebirth.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Rebirth.Party == true then
							if RSA.db.profile.Druid.Spells.Rebirth.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Druid.Spells.Rebirth.Raid == true then
							if RSA.db.profile.Druid.Spells.Rebirth.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Druid.Spells.Rebirth.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end
			end -- REBIRTH
		end
	end -- END FUNCTION
	RSA.ResMon = RSA.ResMon or CreateFrame("Frame", "RSA:RM")
	RSA.ResMon:RegisterEvent("UNIT_SPELLCAST_SENT")
	RSA.ResMon:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	RSA.ResMon:SetScript("OnEvent", Druid_Resurrections)
end -- END ON ENABLED
function RSA_Druid:OnDisable()
	RSA.CombatLogMonitor:SetScript("OnEvent", nil)
	RSA.ResMon:SetScript("OnEvent", nil)
end