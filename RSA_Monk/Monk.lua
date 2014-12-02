---------------------------------------------
---- Raeli's Spell Announcer Monk Module ----
---------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_Monk = RSA:NewModule("Monk")
function RSA_Monk:OnInitialize()
	if RSA.db.profile.General.Class == "MONK" then
		RSA_Monk:SetEnabledState(true)
	else
		RSA_Monk:SetEnabledState(false)
	end
end -- End OnInitialize
local spellinfo,spelllinkinfo,extraspellinfo,extraspellinfolink,missinfo
function RSA_Monk:OnEnable()
	RSA.db.profile.Modules.Monk = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
	local pName = UnitName("player")
	local MonitorConfig_Monk = {
		player_profile = RSA.db.profile.Monk,
		SPELL_DISPEL = {
			[115450] = {-- DETOX
				profile = 'Detox',
				replacements = { TARGET = 1, extraSpellName = "[AURA]", extraSpellLink = "[AURALINK]" }
			},
		}
	}
	RSA.MonitorConfig(MonitorConfig_Monk, UnitGUID("player"))
	local MonitorAndAnnounce = RSA.MonitorAndAnnounce
	local function Monk_Spells(self, _, timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, ex2, ex3, ex4)
		local petName = UnitName("pet")
		if source == pName or source == petName then
			if (event == "SPELL_CAST_SUCCESS" and RSA.db.profile.Modules.Reminders_Loaded == true) then -- Reminder Refreshed
				local ReminderSpell = RSA.db.profile.Monk.Reminders.SpellName
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
				if spellID == 115546 then -- PROVOKE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if UnitName(dest) == "Statue of the Black Ox" and RSA.db.profile.Monk.Spells.Provoke.Messages.StatueOfTheBlackOx ~= "" then -- FIND OUT HOW TO OBTAIN NAME, ID OR WHATEVER
						if RSA.db.profile.Monk.Spells.Provoke.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.StatueOfTheBlackOx, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Provoke.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.StatueOfTheBlackOx, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Provoke.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.StatueOfTheBlackOx, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.Provoke.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.Provoke.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.StatueOfTheBlackOx, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Provoke.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.StatueOfTheBlackOx, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Provoke.Party == true then
							if RSA.db.profile.Monk.Spells.Provoke.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.StatueOfTheBlackOx, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Provoke.Raid == true then
							if RSA.db.profile.Monk.Spells.Provoke.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.StatueOfTheBlackOx, ".%a+.", RSA.String_Replace))
						end
					end
				end -- PROVOKE
				if spellID == 119582 then -- PURIFYING BREW
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Monk.Spells.PurifyingBrew.Messages.Start ~= "" then
						if RSA.db.profile.Monk.Spells.PurifyingBrew.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.PurifyingBrew.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.PurifyingBrew.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.PurifyingBrew.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.PurifyingBrew.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.PurifyingBrew.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.PurifyingBrew.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.PurifyingBrew.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.PurifyingBrew.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.PurifyingBrew.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.PurifyingBrew.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.PurifyingBrew.Party == true then
							if RSA.db.profile.Monk.Spells.PurifyingBrew.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.PurifyingBrew.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.PurifyingBrew.Raid == true then
							if RSA.db.profile.Monk.Spells.PurifyingBrew.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.PurifyingBrew.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- PURIFYING BREW
			end -- IF EVENT IS SPELL_CAST_SUCCESS
			if event == "SPELL_AURA_APPLIED" then
				if spellID == 115176 and dest == pName then -- ZEN MEDITATION
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Monk.Spells.ZenMeditation.Messages.Start ~= "" then
						if RSA.db.profile.Monk.Spells.ZenMeditation.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.ZenMeditation.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.ZenMeditation.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.ZenMeditation.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.ZenMeditation.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.ZenMeditation.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.ZenMeditation.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.ZenMeditation.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.ZenMeditation.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.ZenMeditation.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.ZenMeditation.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.ZenMeditation.Party == true then
							if RSA.db.profile.Monk.Spells.ZenMeditation.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.ZenMeditation.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.ZenMeditation.Raid == true then
							if RSA.db.profile.Monk.Spells.ZenMeditation.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.ZenMeditation.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- ZEN MEDITATION
				if spellID == 116189 then -- PROVOKE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Monk.Spells.Provoke.Messages.Start ~= "" then
						if RSA.db.profile.Monk.Spells.Provoke.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Provoke.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Provoke.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.Provoke.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.Provoke.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Provoke.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Provoke.Party == true then
							if RSA.db.profile.Monk.Spells.Provoke.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Provoke.Raid == true then
							if RSA.db.profile.Monk.Spells.Provoke.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- PROVOKE
				if spellID == 120954 then -- FORTIFYING BREW
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Monk.Spells.FortifyingBrew.Messages.Start ~= "" then
						if RSA.db.profile.Monk.Spells.FortifyingBrew.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.FortifyingBrew.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.FortifyingBrew.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.FortifyingBrew.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.FortifyingBrew.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.FortifyingBrew.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.FortifyingBrew.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.FortifyingBrew.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.FortifyingBrew.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.FortifyingBrew.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.FortifyingBrew.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.FortifyingBrew.Party == true then
							if RSA.db.profile.Monk.Spells.FortifyingBrew.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.FortifyingBrew.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.FortifyingBrew.Raid == true then
							if RSA.db.profile.Monk.Spells.FortifyingBrew.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.FortifyingBrew.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- FORTIFYING BREW
				if spellID == 115078 then -- PARALYSIS
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Monk.Spells.Paralysis.Messages.Start ~= "" then
						if RSA.db.profile.Monk.Spells.Paralysis.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Paralysis.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Paralysis.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.Paralysis.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.Paralysis.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Paralysis.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Paralysis.Party == true then
							if RSA.db.profile.Monk.Spells.Paralysis.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Paralysis.Raid == true then
							if RSA.db.profile.Monk.Spells.Paralysis.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- PARALYSIS
				if spellID == 115295 then -- GUARD
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Monk.Spells.Guard.Messages.Start ~= "" then
						if RSA.db.profile.Monk.Spells.Guard.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.Guard.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Guard.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.Guard.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Guard.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.Guard.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.Guard.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.Guard.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.Guard.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Guard.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.Guard.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Guard.Party == true then
							if RSA.db.profile.Monk.Spells.Guard.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.Guard.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Guard.Raid == true then
							if RSA.db.profile.Monk.Spells.Guard.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.Guard.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- GUARD
				if spellID == 115308 then -- ELUSIVE BREW
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Monk.Spells.ElusiveBrew.Messages.Start ~= "" then
						if RSA.db.profile.Monk.Spells.ElusiveBrew.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.ElusiveBrew.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.ElusiveBrew.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.ElusiveBrew.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.ElusiveBrew.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.ElusiveBrew.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.ElusiveBrew.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.ElusiveBrew.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.ElusiveBrew.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.ElusiveBrew.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.ElusiveBrew.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.ElusiveBrew.Party == true then
							if RSA.db.profile.Monk.Spells.ElusiveBrew.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.ElusiveBrew.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.ElusiveBrew.Raid == true then
							if RSA.db.profile.Monk.Spells.ElusiveBrew.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.ElusiveBrew.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- ELUSIVE BREW
				if spellID == 122278 then -- DAMPEN HARM
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Monk.Spells.DampenHarm.Messages.Start ~= "" then
						if RSA.db.profile.Monk.Spells.DampenHarm.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.DampenHarm.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DampenHarm.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.DampenHarm.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DampenHarm.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.DampenHarm.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.DampenHarm.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.DampenHarm.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.DampenHarm.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DampenHarm.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.DampenHarm.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DampenHarm.Party == true then
							if RSA.db.profile.Monk.Spells.DampenHarm.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.DampenHarm.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DampenHarm.Raid == true then
							if RSA.db.profile.Monk.Spells.DampenHarm.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.DampenHarm.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- DAMPEN HARM
				if spellID == 116849 then -- LIFE COCOON
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Monk.Spells.LifeCocoon.Messages.Start ~= "" then
						if RSA.db.profile.Monk.Spells.LifeCocoon.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.LifeCocoon.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.LifeCocoon.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.LifeCocoon.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.LifeCocoon.Whisper == true and dest ~= pName and RSA.Whisperable(destFlags) then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Monk.Spells.LifeCocoon.Messages.Start, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Monk.Spells.LifeCocoon.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.LifeCocoon.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.LifeCocoon.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.LifeCocoon.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.LifeCocoon.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.LifeCocoon.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.LifeCocoon.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.LifeCocoon.Party == true then
							if RSA.db.profile.Monk.Spells.LifeCocoon.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.LifeCocoon.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.LifeCocoon.Raid == true then
							if RSA.db.profile.Monk.Spells.LifeCocoon.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.LifeCocoon.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- LIFE COCOON
				if spellID == 122783 then -- DIFFUSE MAGIC
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Monk.Spells.DiffuseMagic.Messages.Start ~= "" then
						if RSA.db.profile.Monk.Spells.DiffuseMagic.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.DiffuseMagic.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DiffuseMagic.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.DiffuseMagic.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DiffuseMagic.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.DiffuseMagic.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.DiffuseMagic.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.DiffuseMagic.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.DiffuseMagic.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DiffuseMagic.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.DiffuseMagic.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DiffuseMagic.Party == true then
							if RSA.db.profile.Monk.Spells.DiffuseMagic.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.DiffuseMagic.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DiffuseMagic.Raid == true then
							if RSA.db.profile.Monk.Spells.DiffuseMagic.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.DiffuseMagic.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- DIFFUSE MAGIC
			end -- IF EVENT IS SPELL_AURA_APPLIED
			if event == "SPELL_AURA_REMOVED" then
				if spellID == 115176 and dest == pName then -- ZEN MEDITATION
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Monk.Spells.ZenMeditation.Messages.End ~= "" then
						if RSA.db.profile.Monk.Spells.ZenMeditation.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.ZenMeditation.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.ZenMeditation.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.ZenMeditation.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.ZenMeditation.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.ZenMeditation.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.ZenMeditation.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.ZenMeditation.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.ZenMeditation.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.ZenMeditation.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.ZenMeditation.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.ZenMeditation.Party == true then
							if RSA.db.profile.Monk.Spells.ZenMeditation.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.ZenMeditation.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.ZenMeditation.Raid == true then
							if RSA.db.profile.Monk.Spells.ZenMeditation.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.ZenMeditation.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- ZEN MEDITATION
				if spellID == 120954 then -- FORTIFYING BREW
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Monk.Spells.FortifyingBrew.Messages.End ~= "" then
						if RSA.db.profile.Monk.Spells.FortifyingBrew.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.FortifyingBrew.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.FortifyingBrew.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.FortifyingBrew.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.FortifyingBrew.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.FortifyingBrew.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.FortifyingBrew.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.FortifyingBrew.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.FortifyingBrew.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.FortifyingBrew.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.FortifyingBrew.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.FortifyingBrew.Party == true then
							if RSA.db.profile.Monk.Spells.FortifyingBrew.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.FortifyingBrew.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.FortifyingBrew.Raid == true then
							if RSA.db.profile.Monk.Spells.FortifyingBrew.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.FortifyingBrew.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- FORTIFYING BREW
				if spellID == 115078 then -- PARALYSIS
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Monk.Spells.Paralysis.Messages.End ~= "" then
						if RSA.db.profile.Monk.Spells.Paralysis.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Paralysis.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Paralysis.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.Paralysis.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.Paralysis.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Paralysis.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Paralysis.Party == true then
							if RSA.db.profile.Monk.Spells.Paralysis.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Paralysis.Raid == true then
							if RSA.db.profile.Monk.Spells.Paralysis.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- PARALYSIS
				if spellID == 115295 then -- GUARD
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Monk.Spells.Guard.Messages.End ~= "" then
						if RSA.db.profile.Monk.Spells.Guard.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.Guard.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Guard.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.Guard.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Guard.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.Guard.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.Guard.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.Guard.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.Guard.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Guard.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.Guard.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Guard.Party == true then
							if RSA.db.profile.Monk.Spells.Guard.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.Guard.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Guard.Raid == true then
							if RSA.db.profile.Monk.Spells.Guard.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.Guard.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- GUARD
				if spellID == 115308 then -- ELUSIVE BREW
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Monk.Spells.ElusiveBrew.Messages.End ~= "" then
						if RSA.db.profile.Monk.Spells.ElusiveBrew.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.ElusiveBrew.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.ElusiveBrew.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.ElusiveBrew.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.ElusiveBrew.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.ElusiveBrew.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.ElusiveBrew.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.ElusiveBrew.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.ElusiveBrew.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.ElusiveBrew.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.ElusiveBrew.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.ElusiveBrew.Party == true then
							if RSA.db.profile.Monk.Spells.ElusiveBrew.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.ElusiveBrew.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.ElusiveBrew.Raid == true then
							if RSA.db.profile.Monk.Spells.ElusiveBrew.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.ElusiveBrew.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- ELUSIVE BREW
				if spellID == 122278 then -- DAMPEN HARM
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Monk.Spells.DampenHarm.Messages.End ~= "" then
						if RSA.db.profile.Monk.Spells.DampenHarm.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.DampenHarm.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DampenHarm.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.DampenHarm.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DampenHarm.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.DampenHarm.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.DampenHarm.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.DampenHarm.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.DampenHarm.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DampenHarm.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.DampenHarm.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DampenHarm.Party == true then
							if RSA.db.profile.Monk.Spells.DampenHarm.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.DampenHarm.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DampenHarm.Raid == true then
							if RSA.db.profile.Monk.Spells.DampenHarm.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.DampenHarm.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- DAMPEN HARM
				if spellID == 116849 then -- LIFE COCOON
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Monk.Spells.LifeCocoon.Messages.End ~= "" then
						if RSA.db.profile.Monk.Spells.LifeCocoon.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.LifeCocoon.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.LifeCocoon.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.LifeCocoon.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DiffuseMagic.Whisper == true and dest ~= pName and RSA.Whisperable(destFlags) then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Monk.Spells.DiffuseMagic.Messages.Start, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Monk.Spells.LifeCocoon.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.LifeCocoon.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.LifeCocoon.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.LifeCocoon.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.LifeCocoon.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.LifeCocoon.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.LifeCocoon.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.LifeCocoon.Party == true then
							if RSA.db.profile.Monk.Spells.LifeCocoon.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.LifeCocoon.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.LifeCocoon.Raid == true then
							if RSA.db.profile.Monk.Spells.LifeCocoon.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.LifeCocoon.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- LIFE COCOON
				if spellID == 122783 then -- DIFFUSE MAGIC
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Monk.Spells.DiffuseMagic.Messages.End ~= "" then
						if RSA.db.profile.Monk.Spells.DiffuseMagic.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.DiffuseMagic.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DiffuseMagic.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.DiffuseMagic.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DiffuseMagic.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.DiffuseMagic.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.DiffuseMagic.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.DiffuseMagic.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.DiffuseMagic.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DiffuseMagic.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.DiffuseMagic.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DiffuseMagic.Party == true then
							if RSA.db.profile.Monk.Spells.DiffuseMagic.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.DiffuseMagic.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.DiffuseMagic.Raid == true then
							if RSA.db.profile.Monk.Spells.DiffuseMagic.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.DiffuseMagic.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- DIFFUSE MAGIC
			end -- IF EVENT IS SPELL_AURA_REMOVED
			if event == "SPELL_INTERRUPT" then
				if spellID == 116705 then -- SPEAR HAND STRIKE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					extraspellinfo = GetSpellInfo(missType)
					extraspellinfolink = GetSpellLink(missType)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
					if RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.Start ~= "" then
						if RSA.db.profile.Monk.Spells.SpearHandStrike.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.SpearHandStrike.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.SpearHandStrike.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.SpearHandStrike.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.SpearHandStrike.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.SpearHandStrike.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.SpearHandStrike.Party == true then
							if RSA.db.profile.Monk.Spells.SpearHandStrike.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.SpearHandStrike.Raid == true then
							if RSA.db.profile.Monk.Spells.SpearHandStrike.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SPEAR HAND STRIKE
			end -- IF EVENT IS SPELL_INTERRUPT
			if event == "SPELL_HEAL" then
			end -- IF EVENT IS SPELL_HEAL
			if event == "SPELL_MISSED" and missType ~= "Immune" then
				if spellID == 116189 then -- PROVOKE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.Monk.Spells.Provoke.Messages.End ~= "" then
						if RSA.db.profile.Monk.Spells.Provoke.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Provoke.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Provoke.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.Provoke.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.Provoke.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Provoke.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Provoke.Party == true then
							if RSA.db.profile.Monk.Spells.Provoke.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Provoke.Raid == true then
							if RSA.db.profile.Monk.Spells.Provoke.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- PROVOKE
				if spellID == 116705 then -- SPEAR HAND STRIKE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.End ~= "" then
						if RSA.db.profile.Monk.Spells.SpearHandStrike.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.SpearHandStrike.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.SpearHandStrike.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.SpearHandStrike.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.SpearHandStrike.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.SpearHandStrike.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.SpearHandStrike.Party == true then
							if RSA.db.profile.Monk.Spells.SpearHandStrike.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.SpearHandStrike.Raid == true then
							if RSA.db.profile.Monk.Spells.SpearHandStrike.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SPEAR HAND STRIKE
				if spellID == 115078 then -- PARALYSIS
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.Monk.Spells.Paralysis.Messages.Immune ~= "" then
						if RSA.db.profile.Monk.Spells.Paralysis.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Paralysis.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Paralysis.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.Paralysis.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.Paralysis.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Paralysis.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Paralysis.Party == true then
							if RSA.db.profile.Monk.Spells.Paralysis.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Paralysis.Raid == true then
							if RSA.db.profile.Monk.Spells.Paralysis.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- PARALYSIS
			end -- IF EVENT IS SPELL_MISSED NOT Immune
			if event == "SPELL_MISSED" and missType == "Immune" then
				if spellID == 116189 then -- PROVOKE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Monk.Spells.Provoke.Messages.Immune ~= "" then
						if RSA.db.profile.Monk.Spells.Provoke.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Provoke.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Provoke.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.Provoke.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.Provoke.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Provoke.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Provoke.Party == true then
							if RSA.db.profile.Monk.Spells.Provoke.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Provoke.Raid == true then
							if RSA.db.profile.Monk.Spells.Provoke.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.Provoke.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- PROVOKE
				if spellID == 116705 then -- SPEAR HAND STRIKE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.Immune ~= "" then
						if RSA.db.profile.Monk.Spells.SpearHandStrike.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.SpearHandStrike.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.SpearHandStrike.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.SpearHandStrike.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.SpearHandStrike.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.SpearHandStrike.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.SpearHandStrike.Party == true then
							if RSA.db.profile.Monk.Spells.SpearHandStrike.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.SpearHandStrike.Raid == true then
							if RSA.db.profile.Monk.Spells.SpearHandStrike.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.SpearHandStrike.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SPEAR HAND STRIKE
				if spellID == 115078 then -- PARALYSIS
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.Monk.Spells.Paralysis.Messages.Immune ~= "" then
						if RSA.db.profile.Monk.Spells.Paralysis.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Paralysis.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Paralysis.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.Paralysis.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.Paralysis.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Paralysis.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Paralysis.Party == true then
							if RSA.db.profile.Monk.Spells.Paralysis.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Paralysis.Raid == true then
							if RSA.db.profile.Monk.Spells.Paralysis.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.Paralysis.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- PARALYSIS
			end -- IF EVENT IS SPELL_MISSED AND IS Immune
			MonitorAndAnnounce(self, _, timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, ex2, ex3, ex4)
		end -- IF SOURCE IS PLAYER
	end -- END ENTIRELY
	RSA.CombatLogMonitor:SetScript("OnEvent", Monk_Spells)
	------------------------------
	---- Resurrection Monitor ----
	------------------------------
	local Ressed,ResTarget
	local function Monk_Resuscitate(_, event, source, spell, rank, dest, _)
		if UnitName(source) == pName then
			if spell == GetSpellInfo(115178) and RSA.db.profile.Monk.Spells.Resuscitate.Messages.Start ~= "" then -- RESUSCITATE
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
					if RSA.db.profile.Monk.Spells.Resuscitate.Messages.Start ~= "" then
						if RSA.db.profile.Monk.Spells.Resuscitate.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.Resuscitate.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Resuscitate.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.Resuscitate.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Resuscitate.Whisper == true and dest ~= pName then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Monk.Spells.Resuscitate.Messages.Start, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Monk.Spells.Resuscitate.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.Resuscitate.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.Resuscitate.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.Resuscitate.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.Resuscitate.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Resuscitate.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.Resuscitate.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Resuscitate.Party == true then
							if RSA.db.profile.Monk.Spells.Resuscitate.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.Resuscitate.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Resuscitate.Raid == true then
							if RSA.db.profile.Monk.Spells.Resuscitate.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.Resuscitate.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				elseif event == "UNIT_SPELLCAST_SUCCEEDED" and Ressed ~= true then
					dest = ResTarget
					Ressed = true
					if RSA.db.profile.Monk.Spells.Resuscitate.Messages.End ~= "" then
						if RSA.db.profile.Monk.Spells.Resuscitate.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Monk.Spells.Resuscitate.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Resuscitate.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Monk.Spells.Resuscitate.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Resuscitate.Whisper == true and dest ~= pName then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Monk.Spells.Resuscitate.Messages.End, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Monk.Spells.Resuscitate.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Monk.Spells.Resuscitate.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Monk.Spells.Resuscitate.CustomChannel.Channel)
						end
						if RSA.db.profile.Monk.Spells.Resuscitate.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Monk.Spells.Resuscitate.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Resuscitate.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Monk.Spells.Resuscitate.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Resuscitate.Party == true then
							if RSA.db.profile.Monk.Spells.Resuscitate.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Monk.Spells.Resuscitate.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Monk.Spells.Resuscitate.Raid == true then
							if RSA.db.profile.Monk.Spells.Resuscitate.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Monk.Spells.Resuscitate.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end
			end -- RESUSCITATE
		end
	end -- END FUNCTION
	RSA.ResMon = RSA.ResMon or CreateFrame("Frame", "RSA:RM")
	RSA.ResMon:RegisterEvent("UNIT_SPELLCAST_SENT")
	RSA.ResMon:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	RSA.ResMon:SetScript("OnEvent", Monk_Resuscitate)
end -- END ON ENABLED
function RSA_Monk:OnDisable()
	RSA.CombatLogMonitor:SetScript("OnEvent", nil)
end