-----------------------------------------------------
---- Raeli's Spell Announcer Death Knight Module ----
-----------------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_DeathKnight = RSA:NewModule("DeathKnight")
function RSA_DeathKnight:OnInitialize()
	if RSA.db.profile.General.Class == "DEATHKNIGHT" then
		RSA_DeathKnight:SetEnabledState(true)
	else
		RSA_DeathKnight:SetEnabledState(false)
	end
end -- End OnInitialize
function RSA_DeathKnight:OnEnable()
	RSA.db.profile.Modules.DeathKnight = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
	local pName = UnitName("player")
	local MonitorConfig_DeathKnight = {
		player_profile = RSA.db.profile.DeathKnight,
		SPELL_INTERRUPT = {
			[32747] = { -- STRANGULATE
				profile = 'Strangulate',
				replacements = { TARGET = 1, extraSpellName = "[TARSPELL]", extraSpellLink = "[TARLINK]" }
			},
			[47528] = { -- MIND FREEZE
				profile = 'MindFreeze',
				replacements = { TARGET = 1, extraSpellName = "[TARSPELL]", extraSpellLink = "[TARLINK]" }
			}
		},
		SPELL_CAST_SUCCESS = {
			[48707] = { -- ANTI MAGIC SHELL
				profile = 'AMS'
			},
			[42650] = { -- ARMY OF THE DEAD
				profile = 'Army'
			},
			[108194] = { -- ASPHYXIATE
				profile = 'Asphyxiate',
				replacements = { TARGET = 1 }
			},
			[49222] = { -- BONE SHIELD
				profile = 'BoneShield'
			},
			[49028] = { -- DANCING RUNE WEAPON
				profile = 'DancingRuneWeapon'
			},
			[48792] = { -- ICEBOUND FORTITUDE
				profile = 'IceboundFortitude'
			},
			[49039] = { -- LICHBORNE
				profile = 'Lichborne'
			},
			[51271] = { -- PILLAR OF FROST
				profile = 'PillarOfFrost'
			},
			[61999] = { -- RAISE ALLY
				profile = 'RaiseAlly',
				replacements = { TARGET = 1 }
			},
			[55233] = { -- VAMPIRIC BLOOD
				profile = 'VampiricBlood'
			}
		},
		SPELL_AURA_APPLIED = {
			[119975] ={ -- CONVERSION
				profile = 'Conversion'
			},
			[56222] ={ -- DARK COMMAND
				profile = 'DarkCommand',
				replacements = { TARGET = 1 }
			},
			[49560] = { -- DEATH GRIP
				profile = 'DeathGrip',
				replacements = { TARGET = 1 }
			},
			[116888] = { -- PURGATORY
				profile = 'Purgatory'
			},
			[171049] = { -- RUNE TAP
				profile = 'RuneTap'
			},
			[81162] ={ -- WILL OF THE NECROPOLIS
				profile = 'WotN'
			}
		},
		SPELL_AURA_REMOVED = {
			[48707] = { -- ANTI MAGIC SHELL
				profile = 'AMS',
				section = 'End'
			},
			[49222] = { -- BONE SHIELD
				profile = 'BoneShield',
				section = 'End'
			},
			[119975] ={ -- CONVERSION
				profile = 'Conversion',
				section = 'End'
			},
			[81256] = { -- DANCING RUNE WEAPON
				profile = 'DancingRuneWeapon',
				section = 'End'
			},
			[48792] = { -- ICEBOUND FORTITUDE
				profile = 'IceboundFortitude',
				section = 'End'
			},
			[49039] = { -- LICHBORNE
				profile = 'Lichborne',
				section = 'End'
			},
			[51271] = { -- PILLAR OF FROST
				profile = 'PillarOfFrost',
				section = 'End'
			},
			[116888] = { -- PURGATORY
				profile = 'Purgatory',
				section = 'End'
			},
			[171049] = { -- RUNE TAP
				profile = 'RuneTap',
				section = 'End'
			},
			[55233] = { -- VAMPIRIC BLOOD
				profile = 'VampiricBlood',
				section = 'End'
			},
			[81162] ={ -- WILL OF THE NECROPOLIS
				profile = 'WotN',
				section = 'End'
			}
		}
	}
	RSA.MonitorConfig(MonitorConfig_DeathKnight, UnitGUID("player"))
	local MonitorAndAnnounce = RSA.MonitorAndAnnounce
	local spellinfo,spelllinkinfo,extraspellinfo,extraspellinfolink,missinfo
	local function DeathKnight_Spells(self, _, timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, ex2, ex3, ex4)
		local petName = UnitName("pet")
		if source == pName or source == petName then
			if (event == "SPELL_CAST_SUCCESS" and RSA.db.profile.Modules.Reminders_Loaded == true) then -- Reminder Refreshed
				local ReminderSpell = RSA.db.profile.DeathKnight.Reminders.SpellName
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
			if event == "SPELL_MISSED" and missType ~= "IMMUNE" then
				if spellID == 56222 then -- DARK COMMAND
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.End ~= "" then
						if RSA.db.profile.DeathKnight.Spells.DarkCommand.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DarkCommand.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DarkCommand.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.DeathKnight.Spells.DarkCommand.CustomChannel.Channel)
						end
						if RSA.db.profile.DeathKnight.Spells.DarkCommand.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DarkCommand.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DarkCommand.Party == true then
							if RSA.db.profile.DeathKnight.Spells.DarkCommand.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DarkCommand.Raid == true then
							if RSA.db.profile.DeathKnight.Spells.DarkCommand.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- DARK COMMAND
				if spellID == 49560 or spellID == 49576 then -- DEATH GRIP
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.End ~= "" then
						if RSA.db.profile.DeathKnight.Spells.DeathGrip.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DeathGrip.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DeathGrip.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.DeathKnight.Spells.DeathGrip.CustomChannel.Channel)
						end
						if RSA.db.profile.DeathKnight.Spells.DeathGrip.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DeathGrip.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DeathGrip.Party == true then
							if RSA.db.profile.DeathKnight.Spells.DeathGrip.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DeathGrip.Raid == true then
							if RSA.db.profile.DeathKnight.Spells.DeathGrip.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- DEATH GRIP
				if spellID == 47476 or spellID == 108194 then -- STRANGULATE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.End ~= "" then
						if RSA.db.profile.DeathKnight.Spells.Strangulate.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.Strangulate.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.Strangulate.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.DeathKnight.Spells.Strangulate.CustomChannel.Channel)
						end
						if RSA.db.profile.DeathKnight.Spells.Strangulate.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.Strangulate.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.Strangulate.Party == true then
							if RSA.db.profile.DeathKnight.Spells.Strangulate.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.Strangulate.Raid == true then
							if RSA.db.profile.DeathKnight.Spells.Strangulate.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- STRANGULATE
				if spellID == 47528 then -- MIND FREEZE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.End ~= "" then
						if RSA.db.profile.DeathKnight.Spells.MindFreeze.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.MindFreeze.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.MindFreeze.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.DeathKnight.Spells.MindFreeze.CustomChannel.Channel)
						end
						if RSA.db.profile.DeathKnight.Spells.MindFreeze.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.MindFreeze.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.MindFreeze.Party == true then
							if RSA.db.profile.DeathKnight.Spells.MindFreeze.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.MindFreeze.Raid == true then
							if RSA.db.profile.DeathKnight.Spells.MindFreeze.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- MIND FREEZE
			end -- IF EVENT IS SPELL_MISSED AND NOT IMMUNE
			if event == "SPELL_MISSED" and missType == "IMMUNE" then
				if spellID == 56222 then -- DARK COMMAND
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Immune ~= "" then
						if RSA.db.profile.DeathKnight.Spells.DarkCommand.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DarkCommand.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DarkCommand.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.DeathKnight.Spells.DarkCommand.CustomChannel.Channel)
						end
						if RSA.db.profile.DeathKnight.Spells.DarkCommand.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DarkCommand.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DarkCommand.Party == true then
							if RSA.db.profile.DeathKnight.Spells.DarkCommand.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DarkCommand.Raid == true then
							if RSA.db.profile.DeathKnight.Spells.DarkCommand.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.DarkCommand.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- DARK COMMAND
				if spellID == 49560 or spellID == 49576 then -- DEATH GRIP
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Immune ~= "" then
						if RSA.db.profile.DeathKnight.Spells.DeathGrip.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DeathGrip.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DeathGrip.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.DeathKnight.Spells.DeathGrip.CustomChannel.Channel)
						end
						if RSA.db.profile.DeathKnight.Spells.DeathGrip.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DeathGrip.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DeathGrip.Party == true then
							if RSA.db.profile.DeathKnight.Spells.DeathGrip.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DeathGrip.Raid == true then
							if RSA.db.profile.DeathKnight.Spells.DeathGrip.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathGrip.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- DEATH GRIP
				if spellID == 47476 or spellID == 108194 then -- STRANGULATE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Immune ~= "" then
						if RSA.db.profile.DeathKnight.Spells.Strangulate.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.Strangulate.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.Strangulate.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.DeathKnight.Spells.Strangulate.CustomChannel.Channel)
						end
						if RSA.db.profile.DeathKnight.Spells.Strangulate.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.Strangulate.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.Strangulate.Party == true then
							if RSA.db.profile.DeathKnight.Spells.Strangulate.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.Strangulate.Raid == true then
							if RSA.db.profile.DeathKnight.Spells.Strangulate.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.Strangulate.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- STRANGULATE
				if spellID == 47528 then -- MIND FREEZE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Immune ~= "" then
						if RSA.db.profile.DeathKnight.Spells.MindFreeze.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.MindFreeze.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.MindFreeze.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.DeathKnight.Spells.MindFreeze.CustomChannel.Channel)
						end
						if RSA.db.profile.DeathKnight.Spells.MindFreeze.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.MindFreeze.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.MindFreeze.Party == true then
							if RSA.db.profile.DeathKnight.Spells.MindFreeze.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.MindFreeze.Raid == true then
							if RSA.db.profile.DeathKnight.Spells.MindFreeze.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.MindFreeze.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- MIND FREEZE
			end -- IF EVENT IS SPELL_MISSED AND IS IMMUNE
			if event == "SPELL_HEAL" then
				if spellID == 48743 then -- DEATH PACT
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[AMOUNT]"] = missType,}
					if RSA.db.profile.DeathKnight.Spells.DeathPact.Messages.Start ~= "" then
						if RSA.db.profile.DeathKnight.Spells.DeathPact.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathPact.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DeathPact.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathPact.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DeathPact.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathPact.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.DeathKnight.Spells.DeathPact.CustomChannel.Channel)
						end
						if RSA.db.profile.DeathKnight.Spells.DeathPact.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathPact.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DeathPact.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathPact.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DeathPact.Party == true then
							if RSA.db.profile.DeathKnight.Spells.DeathPact.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathPact.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.DeathKnight.Spells.DeathPact.Raid == true then
							if RSA.db.profile.DeathKnight.Spells.DeathPact.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.DeathKnight.Spells.DeathPact.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- DEATH PACT
			end -- IF EVENT IS SPELL_HEAL
			MonitorAndAnnounce(self, _, timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, ex2, ex3, ex4)
		end -- IF SOURCE IS PLAYER
	end -- END ENTIRELY
	RSA.CombatLogMonitor:SetScript("OnEvent", DeathKnight_Spells)
end -- END ON ENABLED
function RSA_DeathKnight:OnDisable()
	RSA.CombatLogMonitor:SetScript("OnEvent", nil)
end
