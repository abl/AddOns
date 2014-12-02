------------------------------------------------
---- Raeli's Spell Announcer Paladin Module ----
------------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_Paladin = RSA:NewModule("Paladin")
function RSA_Paladin:OnInitialize()
	if RSA.db.profile.General.Class == "PALADIN" then
		RSA_Paladin:SetEnabledState(true)
	else
		RSA_Paladin:SetEnabledState(false)
	end
end -- End OnInitialize
local spellinfo,spelllinkinfo,extraspellinfo,extraspellinfolink,missinfo
function RSA_Paladin:OnEnable()
	RSA.db.profile.Modules.Paladin = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
	local pName = UnitName("player")
	local Config_HammerOfJustice = { -- HAMMER OF JUSTICE / FIST OF JUSTICE
		profile = 'HammerOfJustice',
		replacements = { TARGET = 1 }
	}
	local Config_HammerOfJustice_End = { -- HAMMER OF JUSTICE / FIST OF JUSTICE
		profile = 'HammerOfJustice',
		section = 'End',
		replacements = { TARGET = 1 }
	}
	local Config_AvengingWrath = { -- HAMMER OF JUSTICE / FIST OF JUSTICE
		profile = 'AvengingWrath'
	}
	local Config_AvengingWrath_End = { -- HAMMER OF JUSTICE / FIST OF JUSTICE
		profile = 'AvengingWrath',
		section = 'End'
	}
	local MonitorConfig_Paladin = {
		player_profile = RSA.db.profile.Paladin,
		SPELL_DISPEL = {
			[4987] = {-- CLEANSE
				profile = 'Cleanse',
				replacements = { TARGET = 1, extraSpellName = "[AURA]", extraSpellLink = "[AURALINK]" }
			}
		},
		SPELL_CAST_SUCCESS = {
			[31842] = Config_AvengingWrath, -- AVENGING WRATH
			[31884] = Config_AvengingWrath, -- AVENGING WRATH
			[31850] = { -- ARDENT DEFENDER
				profile = 'ArdentDefender'
			},
			[53563] = { -- BEACON OF LIGHT
				profile = 'Beacon',
				replacements = { TARGET = 1 }
			},
			[31821] = { -- DEVOTION AURA
				profile = 'DevotionAura'
			},
			[498] = { -- DIVINE PROTECTION
				profile = 'DivineProtection'
			},
			[642] = { -- DIVINE SHIELD
				profile = 'DivineShield'
			},
			[1044] = { -- HAND OF FREEDOM
				profile = 'HandOfFreedom',
				replacements = { TARGET = 1 }
			},
			[1022] = { -- HAND OF PROTECTION
				profile = 'HandOfProtection',
				replacements = { TARGET = 1 }
			},
			[6940] = { -- HAND OF SACRIFICE
				profile = 'HandOfSacrifice',
				replacements = { TARGET = 1 }
			},
			[1038] = { -- HAND OF SALVATION
				profile = 'HandOfSalvation',
				replacements = { TARGET = 1 }
			},
			[20925] = { -- SACRED SHIELD
				profile = 'SacredShield',
				replacements = { TARGET = 1 }
			}
		},
		SPELL_AURA_APPLIED = {
			[853] = Config_HammerOfJustice, -- HAMMER OF JUSTICE / FIST OF JUSTICE
			[105593] = Config_HammerOfJustice, -- HAMMER OF JUSTICE / FIST OF JUSTICE
			[25771] = { -- FORBEARANCE
				profile = 'Forbearance',
				replacements = { TARGET = 1 }
			},
			[114039] = { -- HAND OF PURITY
				profile = 'HandOfPurity',
				replacements = { TARGET = 1 }
			},
			[62124] = { -- HAND OF RECKONING
				profile = 'HandOfReckoning',
				replacements = { TARGET = 1 }
			},
			[105809] = { -- HOLY AVENGER
				profile = 'HolyAvenger'
			},
			[20066] = { -- REPENTANCE
				profile = 'Repentance',
				replacements = { TARGET = 1 }
			},
			[10326] = { -- TURN EVIL
				profile = 'TurnEvil',
				replacements = { TARGET = 1 }
			}
		},
		SPELL_AURA_REMOVED = {
			[853] = Config_HammerOfJustice_End, -- HAMMER OF JUSTICE / FIST OF JUSTICE
			[105593] = Config_HammerOfJustice_End, -- HAMMER OF JUSTICE / FIST OF JUSTICE
			[31842] = Config_AvengingWrath_End, -- AVENGING WRATH
			[31884] = Config_AvengingWrath_End, -- AVENGING WRATH
			[53563] = { -- BEACON OF LIGHT
				profile = 'Beacon',
				section = 'End',
				replacements = { TARGET = 1 }
			},
			[31821] = { -- DEVOTION AURA
				profile = 'DevotionAura',
				section = 'End',
				targetIsMe = 1
			},
			[498] = { -- DIVINE PROTECTION
				profile = 'DivineProtection',
				section = 'End'
			},
			[642] = { -- DIVINE SHIELD
				profile = 'DivineShield',
				section = 'End'
			},
			[25771] = { -- FORBEARANCE
				profile = 'Forbearance',
				section = 'End',
				replacements = { TARGET = 1 }
			},
			[1044] = { -- HAND OF FREEDOM
				profile = 'HandOfFreedom',
				section = 'End',
				replacements = { TARGET = 1 }
			},
			[1022] = { -- HAND OF PROTECTION
				profile = 'HandOfProtection',
				section = 'End',
				replacements = { TARGET = 1 }
			},
			[114039] = { -- HAND OF PURITY
				profile = 'HandOfPurity',
				section = 'End',
				replacements = { TARGET = 1 }
			},
			[6940] = { -- HAND OF SACRIFICE
				profile = 'HandOfSacrifice',
				section = 'End',
				replacements = { TARGET = 1 }
			},
			[1038] = { -- HAND OF SALVATION
				profile = 'HandOfSalvation',
				section = 'End',
				replacements = { TARGET = 1 }
			},
			[105809] = { -- HOLY AVENGER
				profile = 'HolyAvenger',
				section = 'End'
			},
			[20066] = { -- REPENTANCE
				profile = 'Repentance',
				section = 'End',
				replacements = { TARGET = 1 }
			},
			[20925] = { -- SACRED SHIELD
				profile = 'SacredShield',
				section = 'End',
				replacements = { TARGET = 1 }
			},
			[10326] = { -- TURN EVIL
				profile = 'TurnEvil',
				section = 'End',
				replacements = { TARGET = 1 }
			}
		}
	}
	RSA.MonitorConfig(MonitorConfig_Paladin, UnitGUID("player"))
	local MonitorAndAnnounce = RSA.MonitorAndAnnounce
	local RSA_DivineGuardian = false
	RSA.ItemSets = {
		["T11 Prot"] = { 60358, 60357, 60356, 60355, 60354, 65228, 65227, 65226, 65225, 65224 }, -- Modifies Guardian of Ancient Kings
	}
	local RSA_GoaKTimer = CreateFrame("Frame", "RSA:GoaKTimer") -- Because GoaK (Prot) has no event for end message.
	local GoaKTimeElapsed = 0.0
	local ArdentDefenderHealed = false
	local ResTarget = L["Unknown"]
	local Ressed
	local function Paladin_Spells(self, _, timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, overheal, ex3, ex4)
		local petName = UnitName("pet")
		if source == pName or source == petName then
			if (event == "SPELL_CAST_SUCCESS" and RSA.db.profile.Modules.Reminders_Loaded == true) then -- Reminder Refreshed
				local ReminderSpell = RSA.db.profile.Paladin.Reminders.SpellName
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
			if event == "SPELL_AURA_REMOVED" then
				if spellID == 31850 and ArdentDefenderHealed == false then -- ARDENT DEFENDER
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.End ~= "" then
						if RSA.db.profile.Paladin.Spells.ArdentDefender.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.ArdentDefender.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.ArdentDefender.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Paladin.Spells.ArdentDefender.CustomChannel.Channel)
						end
						if RSA.db.profile.Paladin.Spells.ArdentDefender.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.ArdentDefender.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.ArdentDefender.Party == true then
							if RSA.db.profile.Paladin.Spells.ArdentDefender.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
								RSA.Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.ArdentDefender.Raid == true then
							if RSA.db.profile.Paladin.Spells.ArdentDefender.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- ARDENT DEFENDER
			end -- IF EVENT IS SPELL_AURA_REMOVED
			if event == "SPELL_INTERRUPT" then
				if spellID == 96231 then -- REBUKE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					extraspellinfo = GetSpellInfo(missType)
					extraspellinfolink = GetSpellLink(missType)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
					if RSA.db.profile.Paladin.Spells.Rebuke.Messages.Start ~= "" then
						if RSA.db.profile.Paladin.Spells.Rebuke.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Rebuke.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Rebuke.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Paladin.Spells.Rebuke.CustomChannel.Channel)
						end
						if RSA.db.profile.Paladin.Spells.Rebuke.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Rebuke.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Rebuke.Party == true then
							if RSA.db.profile.Paladin.Spells.Rebuke.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
								RSA.Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Rebuke.Raid == true then
							if RSA.db.profile.Paladin.Spells.Rebuke.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- REBUKE
				if spellID == 31935 then -- AVENGERS SHIELD
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					extraspellinfo = GetSpellInfo(missType)
					extraspellinfolink = GetSpellLink(missType)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
					if RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Start ~= "" then
						if RSA.db.profile.Paladin.Spells.AvengersShield.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.AvengersShield.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.AvengersShield.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Paladin.Spells.AvengersShield.CustomChannel.Channel)
						end
						if RSA.db.profile.Paladin.Spells.AvengersShield.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.AvengersShield.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.AvengersShield.Party == true then
							if RSA.db.profile.Paladin.Spells.AvengersShield.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
								RSA.Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.AvengersShield.Raid == true then
							if RSA.db.profile.Paladin.Spells.AvengersShield.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- AVENGERS SHIELD
			end -- IF EVENT IS SPELL_INTERRUPT
			if event == "SPELL_HEAL" then
				if spellID == 633 then -- LAY ON HANDS
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = missType - overheal, ["[OVERHEAL]"] = overheal}
					if missType == 0 then return end
					if RSA.db.profile.Paladin.Spells.LayOnHands.Messages.Start ~= "" then
						if RSA.db.profile.Paladin.Spells.LayOnHands.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.LayOnHands.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.LayOnHands.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Paladin.Spells.LayOnHands.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.LayOnHands.Whisper == true and dest ~= pName and RSA.Whisperable(destFlags) then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"], ["[AMOUNT]"] = missType,}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.LayOnHands.Messages.Start, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = missType,}
						end
						if RSA.db.profile.Paladin.Spells.LayOnHands.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.LayOnHands.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Paladin.Spells.LayOnHands.CustomChannel.Channel)
						end
						if RSA.db.profile.Paladin.Spells.LayOnHands.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.LayOnHands.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.LayOnHands.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Paladin.Spells.LayOnHands.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.LayOnHands.Party == true then
							if RSA.db.profile.Paladin.Spells.LayOnHands.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
								RSA.Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.LayOnHands.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.LayOnHands.Raid == true then
							if RSA.db.profile.Paladin.Spells.LayOnHands.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.LayOnHands.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- LAY ON HANDS
				if spellID == 130551 then -- WORD OF GLORY
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = missType - overheal, ["[OVERHEAL]"] = overheal}
					if (missType - overheal) >= tonumber(RSA.db.profile.Paladin.Spells.WordOfGlory.Minimum) then
						if RSA.db.profile.Paladin.Spells.WordOfGlory.Messages.Start ~= "" then
							if RSA.db.profile.Paladin.Spells.WordOfGlory.Local == true then
								RSA.Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.WordOfGlory.Messages.Start, ".%a+.", RSA.String_Replace))
							end
							if RSA.db.profile.Paladin.Spells.WordOfGlory.Yell == true then
								RSA.Print_Yell(string.gsub(RSA.db.profile.Paladin.Spells.WordOfGlory.Messages.Start, ".%a+.", RSA.String_Replace))
							end
							if RSA.db.profile.Paladin.Spells.WordOfGlory.Whisper == true and dest ~= pName and RSA.Whisperable(destFlags) then
								RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"], ["[AMOUNT]"] = missType,}
								RSA.Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.WordOfGlory.Messages.Start, ".%a+.", RSA.String_Replace), dest)
								RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = missType,}
							end
							if RSA.db.profile.Paladin.Spells.WordOfGlory.CustomChannel.Enabled == true then
								RSA.Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.WordOfGlory.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Paladin.Spells.WordOfGlory.CustomChannel.Channel)
							end
							if RSA.db.profile.Paladin.Spells.WordOfGlory.Say == true then
								RSA.Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.WordOfGlory.Messages.Start, ".%a+.", RSA.String_Replace))
							end
							if RSA.db.profile.Paladin.Spells.WordOfGlory.SmartGroup == true then
								RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Paladin.Spells.WordOfGlory.Messages.Start, ".%a+.", RSA.String_Replace))
							end
							if RSA.db.profile.Paladin.Spells.WordOfGlory.Party == true then
								if RSA.db.profile.Paladin.Spells.WordOfGlory.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
									RSA.Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.WordOfGlory.Messages.Start, ".%a+.", RSA.String_Replace))
							end
							if RSA.db.profile.Paladin.Spells.WordOfGlory.Raid == true then
								if RSA.db.profile.Paladin.Spells.WordOfGlory.SmartGroup == true and GetNumGroupMembers() > 0 then return end
								RSA.Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.WordOfGlory.Messages.Start, ".%a+.", RSA.String_Replace))
							end
						end
					end
				end -- WORD OF GLORY
				if spellID == 31850 or spellID == 66235 then -- ARDENT DEFENDER
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					ArdentDefenderHealed = true
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = missType,}
					if RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Heal ~= "" then
						if RSA.db.profile.Paladin.Spells.ArdentDefender.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Heal, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.ArdentDefender.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Heal, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.ArdentDefender.Whisper == true and dest ~= pName and RSA.Whisperable(destFlags) then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"], ["[AMOUNT]"] = missType,}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Heal, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = missType,}
						end
						if RSA.db.profile.Paladin.Spells.ArdentDefender.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Heal, ".%a+.", RSA.String_Replace), RSA.db.profile.Paladin.Spells.ArdentDefender.CustomChannel.Channel)
						end
						if RSA.db.profile.Paladin.Spells.ArdentDefender.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Heal, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.ArdentDefender.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Heal, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.ArdentDefender.Party == true then
							if RSA.db.profile.Paladin.Spells.ArdentDefender.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
								RSA.Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Heal, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.ArdentDefender.Raid == true then
							if RSA.db.profile.Paladin.Spells.ArdentDefender.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.ArdentDefender.Messages.Heal, ".%a+.", RSA.String_Replace))
						end
					end
				end -- ARDENT DEFENDER
			end -- IF EVENT IS SPELL_HEAL
			if event == "SPELL_MISSED" and missType ~= "IMMUNE" then
				if spellID == 96231 then -- REBUKE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.Paladin.Spells.Rebuke.Messages.End ~= "" then
						if RSA.db.profile.Paladin.Spells.Rebuke.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Rebuke.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Rebuke.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Paladin.Spells.Rebuke.CustomChannel.Channel)
						end
						if RSA.db.profile.Paladin.Spells.Rebuke.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Rebuke.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Rebuke.Party == true then
							if RSA.db.profile.Paladin.Spells.Rebuke.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
								RSA.Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Rebuke.Raid == true then
							if RSA.db.profile.Paladin.Spells.Rebuke.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- REBUKE
				if spellID == 31935 then -- AVENGERS SHIELD
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.Paladin.Spells.AvengersShield.Messages.End ~= "" then
						if RSA.db.profile.Paladin.Spells.AvengersShield.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.AvengersShield.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.AvengersShield.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Paladin.Spells.AvengersShield.CustomChannel.Channel)
						end
						if RSA.db.profile.Paladin.Spells.AvengersShield.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.AvengersShield.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.AvengersShield.Party == true then
							if RSA.db.profile.Paladin.Spells.AvengersShield.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
								RSA.Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.AvengersShield.Raid == true then
							if RSA.db.profile.Paladin.Spells.AvengersShield.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- AVENGERS SHIELD
				if spellID == 62124 then -- HAND OF RECKONING
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.End ~= "" then
						if RSA.db.profile.Paladin.Spells.HandOfReckoning.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.HandOfReckoning.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.HandOfReckoning.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Paladin.Spells.HandOfReckoning.CustomChannel.Channel)
						end
						if RSA.db.profile.Paladin.Spells.HandOfReckoning.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.HandOfReckoning.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.HandOfReckoning.Party == true then
							if RSA.db.profile.Paladin.Spells.HandOfReckoning.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
								RSA.Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.HandOfReckoning.Raid == true then
							if RSA.db.profile.Paladin.Spells.HandOfReckoning.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- HAND OF RECKONING
			end -- IF EVENT IS SPELL_MISSED AND NOT IMMUNE
			if event == "SPELL_MISSED" and missType == "IMMUNE" then
				if spellID == 96231 then -- REBUKE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.Paladin.Spells.Rebuke.Messages.Immune ~= "" then
						if RSA.db.profile.Paladin.Spells.Rebuke.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Rebuke.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Rebuke.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.Paladin.Spells.Rebuke.CustomChannel.Channel)
						end
						if RSA.db.profile.Paladin.Spells.Rebuke.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Rebuke.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Rebuke.Party == true then
							if RSA.db.profile.Paladin.Spells.Rebuke.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
								RSA.Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Rebuke.Raid == true then
							if RSA.db.profile.Paladin.Spells.Rebuke.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.Rebuke.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- REBUKE
				if spellID == 31935 then -- AVENGERS SHIELD
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Immune ~= "" then
						if RSA.db.profile.Paladin.Spells.AvengersShield.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.AvengersShield.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.AvengersShield.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.Paladin.Spells.AvengersShield.CustomChannel.Channel)
						end
						if RSA.db.profile.Paladin.Spells.AvengersShield.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.AvengersShield.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.AvengersShield.Party == true then
							if RSA.db.profile.Paladin.Spells.AvengersShield.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
								RSA.Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.AvengersShield.Raid == true then
							if RSA.db.profile.Paladin.Spells.AvengersShield.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.AvengersShield.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- AVENGERS SHIELD
				if spellID == 62124 then -- HAND OF RECKONING
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Immune ~= "" then
						if RSA.db.profile.Paladin.Spells.HandOfReckoning.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.HandOfReckoning.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.HandOfReckoning.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.Paladin.Spells.HandOfReckoning.CustomChannel.Channel)
						end
						if RSA.db.profile.Paladin.Spells.HandOfReckoning.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.HandOfReckoning.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.HandOfReckoning.Party == true then
							if RSA.db.profile.Paladin.Spells.HandOfReckoning.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
								RSA.Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.HandOfReckoning.Raid == true then
							if RSA.db.profile.Paladin.Spells.HandOfReckoning.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.HandOfReckoning.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- HAND OF RECKONING
			end -- IF EVENT IS SPELL_MISSED AND IS IMMUNE
			MonitorAndAnnounce(self, _, timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, overheal, ex3, ex4)
		end -- IF SOURCE IS PLAYER
	end -- END ENTIRELY
	RSA.CombatLogMonitor:SetScript("OnEvent", Paladin_Spells)
	------------------------------
	---- Resurrection Monitor ----
	------------------------------
	local function Paladin_Redemption(_, event, source, spell, rank, dest, spellID)
		if UnitName(source) == pName then
			if spell == GetSpellInfo(7328) and RSA.db.profile.Paladin.Spells.Redemption.Messages.Start ~= "" then -- REDEMPTION
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
					if RSA.db.profile.Paladin.Spells.Redemption.Messages.Start ~= "" then
						if RSA.db.profile.Paladin.Spells.Redemption.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Redemption.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Redemption.Whisper == true and dest ~= pName then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.Start, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Paladin.Spells.Redemption.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Paladin.Spells.Redemption.CustomChannel.Channel)
						end
						if RSA.db.profile.Paladin.Spells.Redemption.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Redemption.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Redemption.Party == true then
							if RSA.db.profile.Paladin.Spells.Redemption.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
								RSA.Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Redemption.Raid == true then
							if RSA.db.profile.Paladin.Spells.Redemption.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				elseif event == "UNIT_SPELLCAST_SUCCEEDED" and Ressed ~= true then
					dest = ResTarget
					Ressed = true
					if RSA.db.profile.Paladin.Spells.Redemption.Messages.End ~= "" then
						if RSA.db.profile.Paladin.Spells.Redemption.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Redemption.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Redemption.Whisper == true and dest ~= pName then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.End, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Paladin.Spells.Redemption.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Paladin.Spells.Redemption.CustomChannel.Channel)
						end
						if RSA.db.profile.Paladin.Spells.Redemption.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Redemption.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Redemption.Party == true then
							if RSA.db.profile.Paladin.Spells.Redemption.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
								RSA.Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.Redemption.Raid == true then
							if RSA.db.profile.Paladin.Spells.Redemption.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.Redemption.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end
			end -- REDEMPTION
			if spellID == 86659 and event == "UNIT_SPELLCAST_SUCCEEDED" and source == "player" then -- GUARDIAN OF ANCIENT KINGS (PROT)
				if RSA.db.profile.Paladin.Spells.GoAK.Messages.Start ~= "" then
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spell, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Paladin.Spells.GoAK.Local == true then
						RSA.Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.GoAK.Yell == true then
						RSA.Print_Yell(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.GoAK.CustomChannel.Enabled == true then
						RSA.Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Paladin.Spells.GoAK.CustomChannel.Channel)
					end
					if RSA.db.profile.Paladin.Spells.GoAK.Say == true then
						RSA.Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.GoAK.SmartGroup == true then
						RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.GoAK.Party == true then
						RSA.Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.Paladin.Spells.GoAK.Raid == true then
						RSA.Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.Start, ".%a+.", RSA.String_Replace))
					end
				end
				if RSA.db.profile.Paladin.Spells.GoAK.Messages.End ~= "" then
					GoaKTimeElapsed = 0.0 -- Start a timer for end announcement, because GoAK has no end event in combat log.
					local duration = 8.0
					if (RSA.SetBonus("T11 Prot") > 3) then
						duration = duration * 2
					end
					local function GoaKTimer(self, elapsed)
						GoaKTimeElapsed = GoaKTimeElapsed + elapsed
						if GoaKTimeElapsed < duration then return end
						GoaKTimeElapsed = GoaKTimeElapsed - floor(GoaKTimeElapsed)
						spelllinkinfo = GetSpellLink(spellID)
						RSA.Replacements = {["[SPELL]"] = spell, ["[LINK]"] = spelllinkinfo,}
						if RSA.db.profile.Paladin.Spells.GoAK.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.GoAK.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.GoAK.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Paladin.Spells.GoAK.CustomChannel.Channel)
						end
						if RSA.db.profile.Paladin.Spells.GoAK.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.GoAK.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.GoAK.Party == true then
							RSA.Print_Party(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Paladin.Spells.GoAK.Raid == true then
							RSA.Print_Raid(string.gsub(RSA.db.profile.Paladin.Spells.GoAK.Messages.End, ".%a+.", RSA.String_Replace))
						end
						RSA_GoaKTimer:SetScript("OnUpdate", nil)
					end
				RSA_GoaKTimer:SetScript("OnUpdate", GoaKTimer)
				end
			return
			end -- GUARDIAN OF ANCIENT KINGS
		end
	end -- END FUNCTION
	RSA.ResMon = RSA.ResMon or CreateFrame("Frame", "RSA:RM")
	RSA.ResMon:RegisterEvent("UNIT_SPELLCAST_SENT")
	RSA.ResMon:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	RSA.ResMon:SetScript("OnEvent", Paladin_Redemption)
end -- END ON ENABLED
function RSA_Paladin:OnDisable()
RSA.CombatLogMonitor:SetScript("OnEvent", nil)
RSA.ResMon:SetScript("OnEvent", nil)
end