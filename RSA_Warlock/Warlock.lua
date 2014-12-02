------------------------------------------------
---- Raeli's Spell Announcer Warlock Module ----
------------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_Warlock = RSA:NewModule("Warlock")
function RSA_Warlock:OnInitialize()
	if RSA.db.profile.General.Class == "WARLOCK" then
		RSA_Warlock:SetEnabledState(true)
	else
		RSA_Warlock:SetEnabledState(false)
	end
end -- End OnInitialize
local spellinfo,spelllinkinfo,extraspellinfo,extraspellinfolink,missinfo
function RSA_Warlock:OnEnable()
	RSA.db.profile.Modules.Warlock = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
	local pName = UnitName("player")
	local MonitorConfig_Warlock = {
		player_profile = RSA.db.profile.Warlock,
		SPELL_AURA_APPLIED = {
			[108503] = { -- GRIMOIRE OF SACRIFICE
				profile = 'GrimoireOfSacrifice',
				targetIsMe = 1
			},
			[110913] = { -- DARK BARGAIN
				profile = 'DarkBargain'
			},
			[104773] = { -- UNENDING RESOLVE
				profile = 'UnendingResolve'
			},
			[17735] = { -- SUFFERING
				profile = 'Suffering',
				replacements = { TARGET = 1 }
			},
			[710] = { -- BANISH
				profile = 'Banish',
				replacements = { TARGET = 1 }
			},
			[118699] = { -- FEAR
				profile = 'Fear',
				replacements = { TARGET = 1 }
			},
			[130616] = { -- FEAR (Glyph of Fear)
				profile = 'Fear',
				replacements = { TARGET = 1 }
			},
			[6789] = { -- MORTAL COIL
				profile = 'DeathCoil',
				replacements = { TARGET = 1 }
			},
			[30283] = { -- SHADOWFURY
				profile = 'Shadowfury',
				replacements = { TARGET = 1 }
			},
			[6358] = { -- SEDUCE
				profile = 'Seduce',
				replacements = { TARGET = 1 }
			},
			[115268] = { -- MESMERIZE (Grimoire of Supremacy version of Seduce)
				profile = 'Seduce',
				replacements = { TARGET = 1 }
			}
		},
		SPELL_CAST_SUCCESS = {
			[698] = { -- SUMMONING STONE
				profile = 'SummonStone'
			},
			[29858] = { -- SOULSHATTER
				profile = 'Soulshatter'
			},
			[5484] = { -- HOWL OF TERROR
				profile = 'HowlOfTerror',
				replacements = { TARGET = 1 }
			},
			[111771] = { -- DEMONIC GATEWAY
				profile = 'Gateway'
			},
			[20707] = { -- SOULSTONE
				profile = 'Soulstone',
				replacements = { TARGET = 1 },
				section = 'End'
			}
		},
		SPELL_AURA_REMOVED = {
			[710] = { -- BANISH
				profile = 'Banish',
				replacements = { TARGET = 1 },
				section = 'End'
			},
			[110913] = { -- DARK BARGAIN
				profile = 'DarkBargain',
				section = 'End'
			},
			[104773] = { -- UNENDING RESOLVE
				profile = 'UnendingResolve',
				section = 'End'
			},
			[118699] = { -- FEAR
				profile = 'Fear',
				replacements = { TARGET = 1 },
				section = 'End'
			},
			[130616] = { -- FEAR (Glyph of Fear)
				profile = 'Fear',
				replacements = { TARGET = 1 },
				section = 'End'
			},
			[6358] = { -- SEDUCE
				profile = 'Seduce',
				replacements = { TARGET = 1 },
				section = 'End'
			},
			[115268] = { -- MESMERIZE (Grimoire of Supremacy version of Seduce)
				profile = 'Seduce',
				replacements = { TARGET = 1 },
				section = 'End'
			},
			[5484] = { -- HOWL OF TERROR
				profile = 'HowlOfTerror',
				replacements = { TARGET = 1 },
				section = 'End'
			}
		},
		SPELL_CAST_START = {
			[29893] = { -- SOULWELL
				profile = 'SoulWell'
			}
		},
		SPELL_DISPEL = {
			[89808] = { -- SINGE MAGIC
				profile = 'SingeMagic',
				replacements = { TARGET = 1, extraSpellName = "[AURA]", extraSpellLink = "[AURALINK]" }
			},
			[115276] = { -- SEAR MAGIC (Grimoire of Supremacy version of Singe Magic)
				profile = 'SingeMagic',
				replacements = { TARGET = 1, extraSpellName = "[AURA]", extraSpellLink = "[AURALINK]" }
			},
			[19505] = { -- DEVOUR MAGIC
				profile = 'Devour',
				replacements = { TARGET = 1, extraSpellName = "[AURA]", extraSpellLink = "[AURALINK]" }
			}
		},
		SPELL_DISPEL_FAILED = {
			[19505] = { -- DEVOUR MAGIC
				profile = 'Devour',
				section = 'End',
				replacements = { TARGET = 1, extraSpellName = "[AURA]", extraSpellLink = "[AURALINK]" }
			}
		},
		SPELL_STOLEN = {
			[115284] = { -- CLONE MAGIC
				profile = 'CloneMagic',
				replacements = { TARGET = 1, extraSpellName = "[AURA]", extraSpellLink = "[AURALINK]" }
			}
		}
	}
	RSA.MonitorConfig(MonitorConfig_Warlock, UnitGUID("player"))
	local MonitorAndAnnounce = RSA.MonitorAndAnnounce
	local ResTarget = L["Unknown"]
	local Ressed
	local function Warlock_Spells(self, _, timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, ex2, ex3, ex4)
		local petName = UnitName("pet")
		if source == pName or source == petName then
			if (event == "SPELL_CAST_SUCCESS" and RSA.db.profile.Modules.Reminders_Loaded == true) then -- Reminder Refreshed
				local ReminderSpell = RSA.db.profile.Warlock.Reminders.SpellName
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
				if spellID == 19647 or spellID == 132409 or spellID == 115781 then -- SPELL LOCK / OPTICAL BLAST
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					extraspellinfo = GetSpellInfo(missType)
					extraspellinfolink = GetSpellLink(missType)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
					if RSA.db.profile.Warlock.Spells.SpellLock.Messages.Start ~= "" then
						if RSA.db.profile.Warlock.Spells.SpellLock.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.SpellLock.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.SpellLock.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Warlock.Spells.SpellLock.CustomChannel.Channel)
						end
						if RSA.db.profile.Warlock.Spells.SpellLock.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.SpellLock.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.SpellLock.Party == true then
							if RSA.db.profile.Warlock.Spells.SpellLock.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.SpellLock.Raid == true then
							if RSA.db.profile.Warlock.Spells.SpellLock.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SPELL LOCK / OPTICAL BLAST
			end -- IF EVENT IS SPELL_INTERRUPT
			if event == "SPELL_MISSED" and missType ~= "IMMUNE" then
				if spellID == 24259 or spellID == 115782 then -- SPELL LOCK / OPTICAL BLAST
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.Warlock.Spells.SpellLock.Messages.End ~= "" then
						if RSA.db.profile.Warlock.Spells.SpellLock.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.SpellLock.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.SpellLock.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Warlock.Spells.SpellLock.CustomChannel.Channel)
						end
						if RSA.db.profile.Warlock.Spells.SpellLock.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.SpellLock.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.SpellLock.Party == true then
							if RSA.db.profile.Warlock.Spells.SpellLock.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.SpellLock.Raid == true then
							if RSA.db.profile.Warlock.Spells.SpellLock.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SPELL LOCK / OPTICAL BLAST
				if spellID == 17735 then -- SUFFERING
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.Warlock.Spells.Suffering.Messages.End ~= "" then
						if RSA.db.profile.Warlock.Spells.Suffering.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Suffering.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Suffering.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Warlock.Spells.Suffering.CustomChannel.Channel)
						end
						if RSA.db.profile.Warlock.Spells.Suffering.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Suffering.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Suffering.Party == true then
							if RSA.db.profile.Warlock.Spells.Suffering.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Suffering.Raid == true then
							if RSA.db.profile.Warlock.Spells.Suffering.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SUFFERING
				if spellID == 115284 then -- CLONE MAGIC
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.Warlock.Spells.CloneMagic.Messages.End ~= "" then
						if RSA.db.profile.Warlock.Spells.CloneMagic.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.CloneMagic.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.CloneMagic.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warlock.Spells.CloneMagic.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.CloneMagic.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.CloneMagic.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Warlock.Spells.CloneMagic.CustomChannel.Channel)
						end
						if RSA.db.profile.Warlock.Spells.CloneMagic.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.CloneMagic.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.CloneMagic.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warlock.Spells.CloneMagic.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.CloneMagic.Party == true then
							if RSA.db.profile.Warlock.Spells.CloneMagic.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.CloneMagic.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.CloneMagic.Raid == true then
							if RSA.db.profile.Warlock.Spells.CloneMagic.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.CloneMagic.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- CLONE MAGIC
			end -- IF EVENT IS SPELL_MISSED AND NOT IMMUNE
			if event == "SPELL_MISSED" and missType == "IMMUNE" then
				if spellID == 24259 or spellID == 115782 then -- SPELL LOCK / OPTICAL BLAST
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.Warlock.Spells.SpellLock.Messages.Immune ~= "" then
						if RSA.db.profile.Warlock.Spells.SpellLock.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.SpellLock.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.SpellLock.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.Warlock.Spells.SpellLock.CustomChannel.Channel)
						end
						if RSA.db.profile.Warlock.Spells.SpellLock.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.SpellLock.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.SpellLock.Party == true then
							if RSA.db.profile.Warlock.Spells.SpellLock.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.SpellLock.Raid == true then
							if RSA.db.profile.Warlock.Spells.SpellLock.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.SpellLock.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SPELL LOCK / OPTICAL BLAST
				if spellID == 710 then -- BANISH
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.Warlock.Spells.Banish.Messages.Immune ~= "" then
						if RSA.db.profile.Warlock.Spells.Banish.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Banish.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Banish.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warlock.Spells.Banish.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Banish.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Banish.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.Warlock.Spells.Banish.CustomChannel.Channel)
						end
						if RSA.db.profile.Warlock.Spells.Banish.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Banish.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Banish.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warlock.Spells.Banish.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Banish.Party == true then
							if RSA.db.profile.Warlock.Spells.Banish.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Banish.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Banish.Raid == true then
							if RSA.db.profile.Warlock.Spells.Banish.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Banish.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- BANISH
				if spellID == 5782 then -- FEAR
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.Warlock.Spells.Fear.Messages.Immune ~= "" then
						if RSA.db.profile.Warlock.Spells.Fear.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Fear.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Fear.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warlock.Spells.Fear.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Fear.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Fear.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.Warlock.Spells.Fear.CustomChannel.Channel)
						end
						if RSA.db.profile.Warlock.Spells.Fear.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Fear.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Fear.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warlock.Spells.Fear.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Fear.Party == true then
							if RSA.db.profile.Warlock.Spells.Fear.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Fear.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Fear.Raid == true then
							if RSA.db.profile.Warlock.Spells.Fear.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Fear.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- FEAR
				if spellID == 17735 then -- SUFFERING
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.Warlock.Spells.Suffering.Messages.Immune ~= "" then
						if RSA.db.profile.Warlock.Spells.Suffering.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Suffering.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Suffering.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.Warlock.Spells.Suffering.CustomChannel.Channel)
						end
						if RSA.db.profile.Warlock.Spells.Suffering.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Suffering.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Suffering.Party == true then
							if RSA.db.profile.Warlock.Spells.Suffering.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Suffering.Raid == true then
							if RSA.db.profile.Warlock.Spells.Suffering.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Suffering.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SUFFERING
				if spellID == 115284 then -- CLONE MAGIC
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.Warlock.Spells.CloneMagic.Messages.Immune ~= "" then
						if RSA.db.profile.Warlock.Spells.CloneMagic.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.CloneMagic.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.CloneMagic.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warlock.Spells.CloneMagic.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.CloneMagic.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.CloneMagic.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.Warlock.Spells.CloneMagic.CustomChannel.Channel)
						end
						if RSA.db.profile.Warlock.Spells.CloneMagic.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.CloneMagic.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.CloneMagic.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warlock.Spells.CloneMagic.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.CloneMagic.Party == true then
							if RSA.db.profile.Warlock.Spells.CloneMagic.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.CloneMagic.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.CloneMagic.Raid == true then
							if RSA.db.profile.Warlock.Spells.CloneMagic.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.CloneMagic.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- CLONE MAGIC
			end -- IF EVENT IS SPELL_MISSED AND IS IMMUNE
			MonitorAndAnnounce(self, _, timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, ex2, ex3, ex4)
		end -- IF SOURCE IS PLAYER
	end -- END ENTIRELY
	RSA.CombatLogMonitor:SetScript("OnEvent", Warlock_Spells)
	------------------------------
	---- Resurrection Monitor ----
	------------------------------
	local function Warlock_Soulstone(_, event, source, spell, rank, dest, spellID)
		if UnitName(source) == pName then
			if spell == GetSpellInfo(20707) and RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start ~= "" then -- SOULSTONE
				if event == "UNIT_SPELLCAST_SENT" and UnitIsPlayer(dest) then
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
					spellinfo = GetSpellInfo(20707) spelllinkinfo = GetSpellLink(20707)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start ~= "" then
						if RSA.db.profile.Warlock.Spells.Soulstone.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Soulstone.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Soulstone.Whisper == true and dest ~= pName then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Warlock.Spells.Soulstone.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Warlock.Spells.Soulstone.CustomChannel.Channel)
						end
						if RSA.db.profile.Warlock.Spells.Soulstone.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Soulstone.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Soulstone.Party == true then
							if RSA.db.profile.Warlock.Spells.Soulstone.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warlock.Spells.Soulstone.Raid == true then
							if RSA.db.profile.Warlock.Spells.Soulstone.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warlock.Spells.Soulstone.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end
			end
		end -- SOULSTONE
	end -- END FUNCTION
	RSA.ResMon = RSA.ResMon or CreateFrame("Frame", "RSA:RM")
	RSA.ResMon:RegisterEvent("UNIT_SPELLCAST_SENT")
	RSA.ResMon:SetScript("OnEvent", Warlock_Soulstone)
end -- END ON ENABLED
function RSA_Warlock:OnDisable()
	RSA.CombatLogMonitor:SetScript("OnEvent", nil)
	RSA.ResMon:SetScript("OnEvent", nil)
end