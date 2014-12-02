----------------------------------------------
---- Raeli's Spell Announcer Rogue Module ----
----------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_Rogue = RSA:NewModule("Rogue")
function RSA_Rogue:OnInitialize()
	if RSA.db.profile.General.Class == "ROGUE" then
		RSA_Rogue:SetEnabledState(true)
	else
		RSA_Rogue:SetEnabledState(false)
	end
end -- End OnInitialize
local spellinfo,spelllinkinfo,extraspellinfo,extraspellinfolink,missinfo
function RSA_Rogue:OnEnable()
	RSA.db.profile.Modules.Rogue = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
	local pName = UnitName("player")
	local MonitorConfig_Rogue = {
		player_profile = RSA.db.profile.Rogue,
		SPELL_AURA_APPLIED = {
			[76577] = { -- SMOKE BOMB
				profile = 'SmokeBomb',
				targetIsMe = 1
			},
			[6770] = { -- SAP
				profile = 'Sap',
				replacements = { TARGET = 1 }
			},
			[2094] = { -- BLIND
				profile = 'Blind',
				replacements = { TARGET = 1 }
			},
			[114018] = { -- SHROUD OF CONCEALMENT
				profile = 'Concealment',
				replacements = { TARGET = 1 }
			}
		},
		SPELL_AURA_REMOVED = {
			[76577] = { -- SMOKE BOMB
				profile = 'SmokeBomb',
				section = 'End',
				targetIsMe = 1
			},
			[6770] = { -- SAP
				profile = 'Sap',
				replacements = { TARGET = 1 },
				section = 'End'
			},
			[2094] = { -- BLIND
				profile = 'Blind',
				replacements = { TARGET = 1 },
				section = 'End'
			},
			[114018] = { -- SHROUD OF CONCEALMENT
				profile = 'Concealment',
				section = 'End',
				replacements = { TARGET = 1 }
			}
		},
		SPELL_DISPEL = {
			[5938] = { -- SHIV
				profile = 'Shiv',
				replacements = { TARGET = 1, extraSpellName = "[AURA]", extraSpellLink = "[AURALINK]" }
			}
		},
		SPELL_DISPEL_FAILED = {
			[5938] = { -- SHIV
				profile = 'Shiv',
				section = 'End',
				replacements = { TARGET = 1, extraSpellName = "[AURA]", extraSpellLink = "[AURALINK]" }
			}
		}
	}
	RSA.MonitorConfig(MonitorConfig_Rogue, UnitGUID("player"))
	local MonitorAndAnnounce = RSA.MonitorAndAnnounce
	local RSA_Tricks_Modifier = 1.15
	local RSA_TricksTracker = CreateFrame("Frame", "RSA:TT")
	local RSA_Tricks_Damage,RSA_Tricks_Target
	local function Rogue_Spells(self, _, timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, ex2, ex3, ex4)
		local petName = UnitName("pet")
		if source == pName or source == petName then
			if (event == "SPELL_CAST_SUCCESS" and RSA.db.profile.Modules.Reminders_Loaded == true) then -- Reminder Refreshed
				local ReminderSpell = RSA.db.profile.Rogue.Reminders.SpellName
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
			if event == "SPELL_CAST_SUCCESS" then
				if spellID == 57934 then -- TRICKS OF THE TRADE DAMAGE BUFF
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA_Tricks_Damage = 0.0
					RSA_Tricks_Target = dest
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Rogue.Spells.Tricks.Messages.Start ~= "" then
						if RSA.db.profile.Rogue.Spells.Tricks.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Tricks.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Tricks.Whisper == true and dest ~= pName and RSA.Whisperable(destFlags) then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.Start, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Rogue.Spells.Tricks.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Rogue.Spells.Tricks.CustomChannel.Channel)
						end
						if RSA.db.profile.Rogue.Spells.Tricks.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Tricks.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Tricks.Party == true then
							if RSA.db.profile.Rogue.Spells.Tricks.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Tricks.Raid == true then
							if RSA.db.profile.Rogue.Spells.Tricks.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
					if string.match(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".AMOUNT.") == "[AMOUNT]" then
						RSA_TricksTracker:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
						local function TricksTracker(_, _, _, event, _, _, source, _, _, destGUID, dest, _, _, spellID, spellName, _, amount, overkill)
							if source == RSA_Tricks_Target then
								if event == "SPELL_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE" or event == "RANGE_DAMAGE" then
									if overkill ~= -1 then
										overkill = 0
									end
									RSA_Tricks_Damage = RSA_Tricks_Damage + (amount - overkill)
								elseif event == "SWING_DAMAGE" then
									local amount, overkill = spellID, spellName
									if overkill ~= -1 then
										overkill = 0
									end
									RSA_Tricks_Damage = RSA_Tricks_Damage + (spellID - spellName)
								end
							end
						end
						RSA_TricksTracker:SetScript("OnEvent", TricksTracker)
					end
				end -- TRICKS OF THE TRADE DAMAGE BUFF
			end -- IF EVENT IS SPELL_CAST_SUCCESS
			if event == "SPELL_INTERRUPT" then
				if spellID == 1766 then -- KICK
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					extraspellinfo = GetSpellInfo(missType)
					extraspellinfolink = GetSpellLink(missType)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
					if RSA.db.profile.Rogue.Spells.Kick.Messages.Start ~= "" then
						if RSA.db.profile.Rogue.Spells.Kick.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Kick.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Kick.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Rogue.Spells.Kick.CustomChannel.Channel)
						end
						if RSA.db.profile.Rogue.Spells.Kick.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Kick.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Kick.Party == true then
							if RSA.db.profile.Rogue.Spells.Kick.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Kick.Raid == true then
							if RSA.db.profile.Rogue.Spells.Kick.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- KICK
			end -- IF EVENT IS SPELL_INTERRUPT
			if event == "SPELL_AURA_REMOVED" then
				if spellID == 57933 then -- TRICKS OF THE TRADE DAMAGE BUFF
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if string.match(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".AMOUNT.") == "[AMOUNT]" then
						RSA_TricksTracker:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
						if RSA.Glyphs(63256) == true then
							RSA_Tricks_Modifier = 1.1
						else
							RSA_Tricks_Modifier = 1.15
						end
						RSA_Tricks_Damage = floor(RSA_Tricks_Damage - (RSA_Tricks_Damage/RSA_Tricks_Modifier)) -- Final Tricks Damage gained.
						RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = RSA_Tricks_Damage,}
					else
						RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Rogue.Spells.Tricks.Messages.End ~= "" then
						if RSA.db.profile.Rogue.Spells.Tricks.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Tricks.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Tricks.Whisper == true and dest ~= pName and RSA.Whisperable(destFlags) then
							if string.match(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".AMOUNT.") == "[AMOUNT]" then
								RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"], ["[AMOUNT]"] = RSA_Tricks_Damage,}
							else
								RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							end
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".%a+.", RSA.String_Replace), dest)
							if string.match(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".AMOUNT.") == "[AMOUNT]" then
								RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = RSA_Tricks_Damage,}
							else
								RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
							end
						end
						if RSA.db.profile.Rogue.Spells.Tricks.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Rogue.Spells.Tricks.CustomChannel.Channel)
						end
						if RSA.db.profile.Rogue.Spells.Tricks.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Tricks.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Tricks.Party == true then
							if RSA.db.profile.Rogue.Spells.Tricks.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Tricks.Raid == true then
							if RSA.db.profile.Rogue.Spells.Tricks.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
					if string.match(RSA.db.profile.Rogue.Spells.Tricks.Messages.End, ".AMOUNT.") == "[AMOUNT]" then
						RSA_TricksTracker:SetScript("OnEvent", nil)
						RSA_Tricks_Damage = 0.0
					end
				end -- TRICKS OF THE TRADE DAMAGE BUFF
			end -- IF EVENT IS SPELL_AURA_REMOVED
			if event == "SPELL_MISSED" and missType ~= "IMMUNE" then
				if spellID == 1766 then -- KICK
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.Rogue.Spells.Kick.Messages.End ~= "" then
						if RSA.db.profile.Rogue.Spells.Kick.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Kick.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Kick.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Rogue.Spells.Kick.CustomChannel.Channel)
						end
						if RSA.db.profile.Rogue.Spells.Kick.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Kick.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Kick.Party == true then
							if RSA.db.profile.Rogue.Spells.Kick.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Kick.Raid == true then
							if RSA.db.profile.Rogue.Spells.Kick.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- KICK
			end -- IF EVENT IS SPELL_MISSED AND NOT IMMUNE
			if event == "SPELL_MISSED" and missType == "IMMUNE" then
				if spellID == 1766 then -- KICK
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.Rogue.Spells.Kick.Messages.Immune ~= "" then
						if RSA.db.profile.Rogue.Spells.Kick.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Kick.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Kick.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.Rogue.Spells.Kick.CustomChannel.Channel)
						end
						if RSA.db.profile.Rogue.Spells.Kick.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Kick.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Kick.Party == true then
							if RSA.db.profile.Rogue.Spells.Kick.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Rogue.Spells.Kick.Raid == true then
							if RSA.db.profile.Rogue.Spells.Kick.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Rogue.Spells.Kick.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- KICK
			end -- IF EVENT IS SPELL_MISSED AND IS IMMUNE
			MonitorAndAnnounce(self, _, timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, ex2, ex3, ex4)
		end -- IF SOURCE IS PLAYER
	end -- END ENTIRELY
	RSA.CombatLogMonitor:SetScript("OnEvent", Rogue_Spells)
end -- END ON ENABLED
function RSA_Rogue:OnDisable()
	RSA.CombatLogMonitor:SetScript("OnEvent", nil)
end