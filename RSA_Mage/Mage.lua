---------------------------------------------
---- Raeli's Spell Announcer Mage Module ----
---------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_Mage = RSA:NewModule("Mage")
function RSA_Mage:OnInitialize()
	if RSA.db.profile.General.Class == "MAGE" then
		RSA_Mage:SetEnabledState(true)
	else
		RSA_Mage:SetEnabledState(false)
	end
end -- End OnInitialize
function RSA_Mage:OnEnable()
	local Config_Polymorph = { -- POLYMORPH
		profile = 'Polymorph',
		replacements = { TARGET = 1 }
	}
	local Config_Polymorph_End = { -- POLYMORPH
		profile = 'Polymorph',
		section = 'End',
		replacements = { TARGET = 1 }
	}
	local Config_Portals = { -- Portals
		profile = 'Portals'
	}
	local Config_Teleport = { -- Teleport
		profile = 'Teleport'
	}
	local MonitorConfig_Mage = {
		player_profile = RSA.db.profile.Mage,
		SPELL_CAST_START = {
			[10059] = Config_Portals, -- STORMWIND PORTAL
			[11416] = Config_Portals, -- IRONFORGE PORTAL
			[11417] = Config_Portals, -- ORGRIMMAR PORTAL
			[11418] = Config_Portals, -- UNDERCITY PORTAL
			[11419] = Config_Portals, -- DARNASSUS PORTAL
			[11420] = Config_Portals, -- THUNDER BLUFF PORTAL
			[32266] = Config_Portals, -- EXODAR PORTAL
			[32267] = Config_Portals, -- SILVERMOON PORTAL
			[33691] = Config_Portals, -- SHATTRATH PORTAL
			[35717] = Config_Portals, -- SHATTRATH PORTAL
			[49360] = Config_Portals, -- THERAMORE PORTAL
			[49361] = Config_Portals, -- STONARD PORTAL
			[53142] = Config_Portals, -- DALARAN PORTAL
			[88345] = Config_Portals, -- TOL BARAD PORTAL
			[88346] = Config_Portals, -- TOL BARAD PORTAL
			[120146] = Config_Portals, -- ANCIENT DALARAN PORTAL
			[132620] = Config_Portals, -- VALE OF ETERNAL BLOSSOMS PORTAL
			[132626] = Config_Portals, -- VALE OF ETERNAL BLOSSOMS PORTAL
			[43987] = { -- REFRESHMENT TABLE
				profile = 'RefreshmentTable'
			}
		},
		SPELL_CAST_SUCCESS = {
			[45438] = { -- ICE BLOCK
				profile = 'IceBlock'
			}
		},
		SPELL_AURA_APPLIED = {
			[118] = Config_Polymorph, -- SHEEP
			[28271] = Config_Polymorph, -- TURTLE
			[28272] = Config_Polymorph, -- PIG
			[61305] = Config_Polymorph, -- BLACK CAT
			[61721] = Config_Polymorph, -- RABBIT
			[61780] = Config_Polymorph, -- TURKEY
			[80353] = { -- TIME WARP
				profile = 'TimeWarp',
				targetIsMe = 1
			},
			[130] = { -- SLOW FALL
				profile = 'SlowFall',
				replacements = { TARGET = 1 }
			}
		},
		SPELL_STOLEN = {
			[30449] = { -- SPELL STEAL
				profile = 'Spellsteal',
				replacements = { TARGET = 1, extraSpellName = "[AURA]", extraSpellLink = "[AURALINK]" }
			}
		},
		SPELL_HEAL = {
			[87023] = { -- CAUTERIZE
				profile = 'Cauterize',
			}
		},
		SPELL_AURA_REMOVED = {
			[118] = Config_Polymorph_End, -- SHEEP
			[28271] = Config_Polymorph_End, -- TURTLE
			[28272] = Config_Polymorph_End, -- PIG
			[61305] = Config_Polymorph_End, -- BLACK CAT
			[61721] = Config_Polymorph_End, -- RABBIT
			[61780] = Config_Polymorph_End, -- TURKEY
			[87023] = { -- CAUTERIZE
				profile = 'Cauterize',
				section = 'End'
			},
			[80353] = { -- TIME WARP
				profile = 'TimeWarp',
				section = 'End',
				targetIsMe = 1
			},
			[130] = { -- SLOW FALL
				profile = 'SlowFall',
				section = 'End',
				replacements = { TARGET = 1 }
			},
			[45438] = { -- ICE BLOCK
				profile = 'IceBlock',
				section = 'End'
			}
		},
		SPELL_SUMMON = {
			[113724] = { -- RING OF FROST
				profile = 'RingOfFrost',
			}
		},
		SPELL_DISPEL = {
			[475] = { -- REMOVE CURSE
				profile = 'RemoveCurse',
				replacements = { TARGET = 1, extraSpellName = "[AURA]", extraSpellLink = "[AURALINK]" }
			}
		},
	}
	RSA.MonitorConfig(MonitorConfig_Mage, UnitGUID("player"))
	local MonitorAndAnnounce = RSA.MonitorAndAnnounce
	RSA.db.profile.Modules.Mage = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
	local spellinfo,spelllinkinfo,extraspellinfo,extraspellinfolink,missinfo
	local pName = UnitName("player")
	local function Mage_Spells(self, _, timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, ex2, ex3, ex4)
		local petName = UnitName("pet")
		if source == pName or source == petName then
			if (event == "SPELL_CAST_SUCCESS" and RSA.db.profile.Modules.Reminders_Loaded == true) then -- Reminder Refreshed
				local ReminderSpell = RSA.db.profile.Mage.Reminders.SpellName
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
			if event == "SPELL_CAST_START" then
				if spellID == 53140 or spellID == 3561 or spellID == 32271 or spellID == 3562 or spellID == 3567 -- TELEPORTS
				or spellID == 33690 or spellID == 35715 or spellID == 32272 or spellID == 49358 or spellID == 3565
				or spellID == 49359 or spellID == 3566 or spellID == 3563 or spellID == 88342 or spellID == 88344
				or spellID == 120145 or spellID == 132621 or spellID == 132627 then
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Mage.Spells.Teleport.Messages.Start ~= "" then
						if RSA.db.profile.Mage.Spells.Teleport.Local == true and (GetNumSubgroupMembers() > 0 or GetNumGroupMembers() > 0) then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.Teleport.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- TELEPORT
			end
			if event == "SPELL_INTERRUPT" then
				if spellID == 2139 or spellID == 119308 then -- COUNTERSPELL / IMPROVED COUNTERSPELL
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					extraspellinfo = GetSpellInfo(missType)
					extraspellinfolink = GetSpellLink(missType)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
					if RSA.db.profile.Mage.Spells.Counterspell.Messages.Start ~= "" then
						if RSA.db.profile.Mage.Spells.Counterspell.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Mage.Spells.Counterspell.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Mage.Spells.Counterspell.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Mage.Spells.Counterspell.CustomChannel.Channel)
						end
						if RSA.db.profile.Mage.Spells.Counterspell.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Mage.Spells.Counterspell.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Mage.Spells.Counterspell.Party == true then
							if RSA.db.profile.Mage.Spells.Counterspell.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Mage.Spells.Counterspell.Raid == true then
							if RSA.db.profile.Mage.Spells.Counterspell.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- COUNTERSPELL / IMPROVED COUNTERSPELL
			end -- IF EVENT IS SPELL_INTERRUPT
			if event == "SPELL_MISSED" and missType ~= "IMMUNE" then
				if spellID == 2139 then -- COUNTERSPELL
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.Mage.Spells.Counterspell.Messages.End ~= "" then
						if RSA.db.profile.Mage.Spells.Counterspell.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Mage.Spells.Counterspell.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Mage.Spells.Counterspell.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Mage.Spells.Counterspell.CustomChannel.Channel)
						end
						if RSA.db.profile.Mage.Spells.Counterspell.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Mage.Spells.Counterspell.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Mage.Spells.Counterspell.Party == true then
							if RSA.db.profile.Mage.Spells.Counterspell.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Mage.Spells.Counterspell.Raid == true then
							if RSA.db.profile.Mage.Spells.Counterspell.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- COUNTERSPELL
				if spellID == 30449 then -- SPELLSTEAL
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.Mage.Spells.Spellsteal.Messages.End ~= "" then
						if RSA.db.profile.Mage.Spells.Spellsteal.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.Spellsteal.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Mage.Spells.Spellsteal.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Mage.Spells.Spellsteal.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Mage.Spells.Spellsteal.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.Spellsteal.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Mage.Spells.Spellsteal.CustomChannel.Channel)
						end
						if RSA.db.profile.Mage.Spells.Spellsteal.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Mage.Spells.Spellsteal.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Mage.Spells.Spellsteal.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Mage.Spells.Spellsteal.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Mage.Spells.Spellsteal.Party == true then
							if RSA.db.profile.Mage.Spells.Spellsteal.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Mage.Spells.Spellsteal.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Mage.Spells.Spellsteal.Raid == true then
							if RSA.db.profile.Mage.Spells.Spellsteal.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.Spellsteal.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SPELLSTEAL
			end -- IF EVENT IS SPELL_MISSED AND NOT IMMUNE
			if event == "SPELL_MISSED" and missType == "IMMUNE" then
				if spellID == 2139 then -- COUNTERSPELL
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.Mage.Spells.Counterspell.Messages.Immune ~= "" then
						if RSA.db.profile.Mage.Spells.Counterspell.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Mage.Spells.Counterspell.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Mage.Spells.Counterspell.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.Mage.Spells.Counterspell.CustomChannel.Channel)
						end
						if RSA.db.profile.Mage.Spells.Counterspell.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Mage.Spells.Counterspell.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Mage.Spells.Counterspell.Party == true then
							if RSA.db.profile.Mage.Spells.Counterspell.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Mage.Spells.Counterspell.Raid == true then
							if RSA.db.profile.Mage.Spells.Counterspell.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Mage.Spells.Counterspell.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- COUNTERSPELL
			end -- IF EVENT IS SPELL_MISSED AND IS IMMUNE
			MonitorAndAnnounce(self, _, timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, ex2, ex3, ex4)
		end -- IF SOURCE IS PLAYER
	end -- END ENTIRELY
	RSA.CombatLogMonitor:SetScript("OnEvent", Mage_Spells)
end -- END ON ENABLED
function RSA_Mage:OnDisable()
	RSA.CombatLogMonitor:SetScript("OnEvent", nil)
end