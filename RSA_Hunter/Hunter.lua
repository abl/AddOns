-----------------------------------------------
---- Raeli's Spell Announcer Hunter Module ----
-----------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_Hunter = RSA:NewModule("Hunter")
function RSA_Hunter:OnInitialize()
	if RSA.db.profile.General.Class == "HUNTER" then
		RSA_Hunter:SetEnabledState(true)
	else
		RSA_Hunter:SetEnabledState(false)
	end
end -- End OnInitialize
local spellinfo,spelllinkinfo,extraspellinfo,extraspellinfolink,missinfo
function RSA_Hunter:OnEnable()
	RSA.db.profile.Modules.Hunter = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
	local pName = UnitName("player")
	local RSA_MD_TAR = nil
	local RSA_Misdirection_Damage = 0.0
	local RSA_MDPTimer = CreateFrame("Frame", "RSA:MDPTimer")
	local MDPTimeElapsed = 0.0
	local RSA_MisdirectionTracker = CreateFrame("Frame", "RSA:MDT")
	local function Hunter_Spells(self, _, timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, ex2, ex3, ex4)
		local petName = UnitName("pet")
		if source == pName or source == petName then
			if (event == "SPELL_CAST_SUCCESS" and RSA.db.profile.Modules.Reminders_Loaded == true) then -- Reminder Refreshed
				local ReminderSpell = RSA.db.profile.Hunter.Reminders.SpellName
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
			if event == "SPELL_AURA_APPLIED" then
				if spellID == 20736 then -- DISTRACTING SHOT
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Start ~= "" then
						if RSA.db.profile.Hunter.Spells.DistractingShot.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.DistractingShot.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.DistractingShot.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.DistractingShot.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.DistractingShot.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.DistractingShot.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.DistractingShot.Party == true then
							if RSA.db.profile.Hunter.Spells.DistractingShot.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.DistractingShot.Raid == true then
							if RSA.db.profile.Hunter.Spells.DistractingShot.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- DISTRACTING SHOT
				if spellID == 3355 then -- FREEZING TRAP
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Start ~= "" then
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.FreezingTrap.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.FreezingTrap.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.FreezingTrap.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Party == true then
							if RSA.db.profile.Hunter.Spells.FreezingTrap.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Raid == true then
							if RSA.db.profile.Hunter.Spells.FreezingTrap.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- FREEZING TRAP
				if spellID == 19386 then -- WYVERN STING
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Hunter.Spells.WyvernSting.Messages.Start ~= "" then
						if RSA.db.profile.Hunter.Spells.WyvernSting.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.WyvernSting.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.WyvernSting.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.WyvernSting.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.WyvernSting.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.WyvernSting.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.WyvernSting.Party == true then
							if RSA.db.profile.Hunter.Spells.WyvernSting.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.WyvernSting.Raid == true then
							if RSA.db.profile.Hunter.Spells.WyvernSting.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- WYVERN STING
				if spellID == 35079 then -- MISDIRECTION THREAT TRANSFER BUFF
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					dest = RSA_MD_TAR
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Hunter.Spells.Misdirection.Messages.Start ~= "" then
						if RSA.db.profile.Hunter.Spells.Misdirection.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.Whisper == true and dest ~= pName and RSA.Whisperable(destFlags) then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Start, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.Misdirection.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.Party == true then
							if RSA.db.profile.Hunter.Spells.Misdirection.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.Raid == true then
							if RSA.db.profile.Hunter.Spells.Misdirection.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- MISDIRECTION THREAT TRANSFER BUFF
				if spellID == 90355 and dest == pName then -- ANCIENT HYSTERIA
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo}
					if RSA.db.profile.Hunter.Spells.AncientHysteria.Messages.Start ~= "" then
						if RSA.db.profile.Hunter.Spells.AncientHysteria.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.AncientHysteria.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.AncientHysteria.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.AncientHysteria.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.AncientHysteria.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.AncientHysteria.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.AncientHysteria.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.AncientHysteria.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.AncientHysteria.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.AncientHysteria.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.AncientHysteria.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.AncientHysteria.Party == true then
							if RSA.db.profile.Hunter.Spells.AncientHysteria.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.AncientHysteria.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.AncientHysteria.Raid == true then
							if RSA.db.profile.Hunter.Spells.AncientHysteria.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.AncientHysteria.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- ANCIENT HYSTERIA
			end -- IF EVENT IS SPELL_AURA_APPLIED
			if event == "SPELL_CREATE" then
				if spellID == 1499 or spellID == 60202 then -- FREEZING TRAP
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Placement ~= "" then
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Placement, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Placement, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.FreezingTrap.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Placement, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.FreezingTrap.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Placement, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.FreezingTrap.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Placement, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Party == true then
							if RSA.db.profile.Hunter.Spells.FreezingTrap.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Placement, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Raid == true then
							if RSA.db.profile.Hunter.Spells.FreezingTrap.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.Placement, ".%a+.", RSA.String_Replace))
						end
					end
				end -- FREEZING TRAP
			end -- IF EVENT IS SPELL_CREATE
			if event == "SPELL_CAST_SUCCESS" then
				if spellID == 5116 then -- CONCUSSIVE SHOT
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.Start ~= "" then
						if RSA.db.profile.Hunter.Spells.ConcussiveShot.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.ConcussiveShot.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.ConcussiveShot.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.ConcussiveShot.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.ConcussiveShot.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.ConcussiveShot.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.ConcussiveShot.Party == true then
							if RSA.db.profile.Hunter.Spells.ConcussiveShot.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.ConcussiveShot.Raid == true then
							if RSA.db.profile.Hunter.Spells.ConcussiveShot.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- CONCUSSIVE SHOT
				if spellID == 19263 then -- DETERRENCE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Hunter.Spells.Deterrence.Messages.Start ~= "" then
						if RSA.db.profile.Hunter.Spells.Deterrence.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Deterrence.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Deterrence.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.Deterrence.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.Deterrence.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Deterrence.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Deterrence.Party == true then
							if RSA.db.profile.Hunter.Spells.Deterrence.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Deterrence.Raid == true then
							if RSA.db.profile.Hunter.Spells.Deterrence.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- DETERRENCE
				if spellID == 51753 then -- CAMOFLAGE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Hunter.Spells.Camoflage.Messages.Start ~= "" then
						if RSA.db.profile.Hunter.Spells.Camoflage.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Camoflage.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Camoflage.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.Camoflage.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.Camoflage.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Camoflage.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Camoflage.Party == true then
							if RSA.db.profile.Hunter.Spells.Camoflage.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Camoflage.Raid == true then
							if RSA.db.profile.Hunter.Spells.Camoflage.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- CAMOFLAGE
				if spellID == 34477 and dest ~= pName then -- MISDIRECTION PRIMER
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA_MD_TAR = dest
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Hunter.Spells.Misdirection.Messages.Primer ~= "" then
						if RSA.db.profile.Hunter.Spells.Misdirection.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Primer, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Primer, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.Whisper == true and dest ~= pName and RSA.Whisperable(destFlags) then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Primer, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Primer, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.Misdirection.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Primer, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Primer, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.Party == true then
							if RSA.db.profile.Hunter.Spells.Misdirection.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Primer, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.Raid == true then
							if RSA.db.profile.Hunter.Spells.Misdirection.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.Primer, ".%a+.", RSA.String_Replace))
						end
					end
					---- START MISDIRECTION TRACKING ----
					if string.match(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".AMOUNT.") == "[AMOUNT]" then
						RSA_MisdirectionTracker:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
						local function MisdirectionTracker(_, _, _, event, _, _, source, _, _, destGUID, dest, _, _, spellID, spellName, _, amount, overkill)
							if source == pName then
								if event == "SPELL_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE" or event == "RANGE_DAMAGE" then
									if overkill ~= -1 then
										overkill = 0
									end
									RSA_Misdirection_Damage = RSA_Misdirection_Damage + (amount - overkill)
								elseif event == "SWING_DAMAGE" then
									local amount, overkill = spellID, spellName
									if overkill ~= -1 then
										overkill = 0
									end
									RSA_Misdirection_Damage = RSA_Misdirection_Damage + (spellID - spellName)
								end
							end
						end
						RSA_MisdirectionTracker:SetScript("OnEvent", MisdirectionTracker)
					end
					MDPTimeElapsed = 0.0
					local function SBMDPTimer(self, elapsed)
						MDPTimeElapsed = MDPTimeElapsed + elapsed
						if MDPTimeElapsed < 20 then return end
						MDPTimeElapsed = MDPTimeElapsed - floor(MDPTimeElapsed)
						if RSA_Misdirection_Damage == 0.0 then
							RSA_MisdirectionTracker:SetScript("OnEvent", nil)
						end
						RSA_MDPTimer:SetScript("OnUpdate", nil)
					end
					RSA_MDPTimer:SetScript("OnUpdate", SBMDPTimer)
					---- END OF MISDIRECTION TRACKING ----
				end -- MISDIRECTION PRIMER
				if spellID == 53271 then -- MASTER'S CALL
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Hunter.Spells.MastersCall.Messages.Start ~= "" then
						if RSA.db.profile.Hunter.Spells.MastersCall.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.MastersCall.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.MastersCall.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.MastersCall.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.MastersCall.Whisper == true and dest ~= pName and RSA.Whisperable(destFlags) then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Hunter.Spells.MastersCall.Messages.Start, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Hunter.Spells.MastersCall.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.MastersCall.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.MastersCall.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.MastersCall.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.MastersCall.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.MastersCall.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.MastersCall.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.MastersCall.Party == true then
							if RSA.db.profile.Hunter.Spells.MastersCall.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.MastersCall.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.MastersCall.Raid == true then
							if RSA.db.profile.Hunter.Spells.MastersCall.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.MastersCall.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- MASTER'S CALL
				if spellID == 53480 then -- ROAR OF SACRIFICE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.Start ~= "" then
						if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Whisper == true and dest ~= pName and RSA.Whisperable(destFlags) then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.Start, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.RoarOfSacrifice.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Party == true then
							if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Raid == true then
							if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- ROAR OF SACRIFICE
				if spellID == 126393 then -- ETERNAL GUARDIAN
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Hunter.Spells.EternalGuardian.Messages.Start ~= "" then
						if RSA.db.profile.Hunter.Spells.EternalGuardian.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.EternalGuardian.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.EternalGuardian.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.EternalGuardian.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.EternalGuardian.Whisper == true and dest ~= pName and RSA.Whisperable(destFlags) then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Hunter.Spells.EternalGuardian.Messages.Start, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Hunter.Spells.EternalGuardian.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.EternalGuardian.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.EternalGuardian.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.EternalGuardian.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.EternalGuardian.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.EternalGuardian.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.EternalGuardian.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.EternalGuardian.Party == true then
							if RSA.db.profile.Hunter.Spells.EternalGuardian.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.EternalGuardian.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.EternalGuardian.Raid == true then
							if RSA.db.profile.Hunter.Spells.EternalGuardian.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.EternalGuardian.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- ETERNAL GUARDIAN
			end -- IF EVENT IS SPELL_CAST_SUCCESS
			if event == "SPELL_INTERRUPT" then
				if  (spellID == 147362) then -- SILENCING SHOT / COUNTER SHOT
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					extraspellinfo = GetSpellInfo(missType)
					extraspellinfolink = GetSpellLink(missType)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
					if RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Start ~= "" then
						if RSA.db.profile.Hunter.Spells.SilencingShot.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.SilencingShot.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.SilencingShot.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.SilencingShot.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.SilencingShot.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.SilencingShot.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.SilencingShot.Party == true then
							if RSA.db.profile.Hunter.Spells.SilencingShot.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.SilencingShot.Raid == true then
							if RSA.db.profile.Hunter.Spells.SilencingShot.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SILENCING SHOT
			end -- IF EVENT IS SPELL_INTERRUPT
			if event == "SPELL_DISPEL" then
				if spellID == 19801 then -- TRANQUILIZING SHOT
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					extraspellinfo = GetSpellInfo(missType)
					extraspellinfolink = GetSpellLink(missType)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
					if RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.Start ~= "" then
						if RSA.db.profile.Hunter.Spells.TranquilizingShot.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.TranquilizingShot.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.TranquilizingShot.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.TranquilizingShot.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.TranquilizingShot.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.TranquilizingShot.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.TranquilizingShot.Party == true then
							if RSA.db.profile.Hunter.Spells.TranquilizingShot.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.TranquilizingShot.Raid == true then
							if RSA.db.profile.Hunter.Spells.TranquilizingShot.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- TRANQUILIZING SHOT
			end -- IF EVENT IS SPELL_DISPEL
			if event == "SPELL_DISPEL_FAILED" then
				if spellID == 19801 then -- TRANQUILIZING SHOT
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					extraspellinfo = GetSpellInfo(missType)
					extraspellinfolink = GetSpellLink(missType)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
					if RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.End ~= "" then
						if RSA.db.profile.Hunter.Spells.TranquilizingShot.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.TranquilizingShot.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.TranquilizingShot.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.TranquilizingShot.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.TranquilizingShot.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.TranquilizingShot.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.TranquilizingShot.Party == true then
							if RSA.db.profile.Hunter.Spells.TranquilizingShot.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.TranquilizingShot.Raid == true then
							if RSA.db.profile.Hunter.Spells.TranquilizingShot.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.TranquilizingShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- TRANQUILIZING SHOT
			end -- IF EVENT IS SPELL_DISPEL_FAILED
			if event == "SPELL_AURA_REMOVED" then
				if spellID == 5116 then -- CONCUSSIVE SHOT
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.End ~= "" then
						if RSA.db.profile.Hunter.Spells.ConcussiveShot.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.ConcussiveShot.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.ConcussiveShot.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.ConcussiveShot.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.ConcussiveShot.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.ConcussiveShot.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.ConcussiveShot.Party == true then
							if RSA.db.profile.Hunter.Spells.ConcussiveShot.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.ConcussiveShot.Raid == true then
							if RSA.db.profile.Hunter.Spells.ConcussiveShot.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.ConcussiveShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- CONCUSSIVE SHOT
				if spellID == 3355 then -- FREEZING TRAP
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.End ~= "" then
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.FreezingTrap.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.FreezingTrap.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.FreezingTrap.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Party == true then
							if RSA.db.profile.Hunter.Spells.FreezingTrap.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.FreezingTrap.Raid == true then
							if RSA.db.profile.Hunter.Spells.FreezingTrap.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.FreezingTrap.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- FREEZING TRAP
				if spellID == 19263 then -- DETERRENCE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Hunter.Spells.Deterrence.Messages.End ~= "" then
						if RSA.db.profile.Hunter.Spells.Deterrence.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Deterrence.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Deterrence.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.Deterrence.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.Deterrence.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Deterrence.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Deterrence.Party == true then
							if RSA.db.profile.Hunter.Spells.Deterrence.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Deterrence.Raid == true then
							if RSA.db.profile.Hunter.Spells.Deterrence.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.Deterrence.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- DETERRENCE
				if spellID == 51755 then -- CAMOFLAGE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Hunter.Spells.Camoflage.Messages.End ~= "" then
						if RSA.db.profile.Hunter.Spells.Camoflage.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Camoflage.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Camoflage.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.Camoflage.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.Camoflage.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Camoflage.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Camoflage.Party == true then
							if RSA.db.profile.Hunter.Spells.Camoflage.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Camoflage.Raid == true then
							if RSA.db.profile.Hunter.Spells.Camoflage.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.Camoflage.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- CAMOFLAGE
				if spellID == 19386 then -- WYVERN STING
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Hunter.Spells.WyvernSting.Messages.End ~= "" then
						if RSA.db.profile.Hunter.Spells.WyvernSting.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.WyvernSting.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.WyvernSting.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.WyvernSting.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.WyvernSting.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.WyvernSting.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.WyvernSting.Party == true then
							if RSA.db.profile.Hunter.Spells.WyvernSting.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.WyvernSting.Raid == true then
							if RSA.db.profile.Hunter.Spells.WyvernSting.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.WyvernSting.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- WYVERN STING
				if spellID == 35079 then -- MISDIRECTION THREAT TRANSFER BUFF
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					dest = RSA_MD_TAR
					if string.match(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".AMOUNT.") == "[AMOUNT]" then
						RSA_MisdirectionTracker:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
						RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = RSA_Misdirection_Damage,}
					else
						RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					end
					if RSA.db.profile.Hunter.Spells.Misdirection.Messages.End ~= "" then
						if RSA.db.profile.Hunter.Spells.Misdirection.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.Whisper == true and dest ~= pName and RSA.Whisperable(destFlags) and dest ~= petName then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"], ["[AMOUNT]"] = RSA_Misdirection_Damage or 0,}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AMOUNT]"] = RSA_Misdirection_Damage or 0,}
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.Misdirection.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.Party == true then
							if RSA.db.profile.Hunter.Spells.Misdirection.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.Misdirection.Raid == true then
							if RSA.db.profile.Hunter.Spells.Misdirection.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
					if string.match(RSA.db.profile.Hunter.Spells.Misdirection.Messages.End, ".AMOUNT.") == "[AMOUNT]" then
						RSA_MisdirectionTracker:SetScript("OnEvent", nil)
						RSA_Misdirection_Damage = 0.0
					end
				end -- MISDIRECTION THREAT TRANSFER BUFF
				if spellID == 53480 then -- ROAR OF SACRIFICE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.End ~= "" then
						if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Whisper == true and dest ~= pName and RSA.Whisperable(destFlags) then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.End, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.RoarOfSacrifice.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Party == true then
							if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Raid == true then
							if RSA.db.profile.Hunter.Spells.RoarOfSacrifice.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.RoarOfSacrifice.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- ROAR OF SACRIFICE
				if spellID == 90355 and dest == pName then -- ANCIENT HYSTERIA
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo}
					if RSA.db.profile.Hunter.Spells.AncientHysteria.Messages.End ~= "" then
						if RSA.db.profile.Hunter.Spells.AncientHysteria.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.AncientHysteria.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.AncientHysteria.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.AncientHysteria.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.AncientHysteria.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.AncientHysteria.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.AncientHysteria.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.AncientHysteria.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.AncientHysteria.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.AncientHysteria.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.AncientHysteria.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.AncientHysteria.Party == true then
							if RSA.db.profile.Hunter.Spells.AncientHysteria.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.AncientHysteria.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.AncientHysteria.Raid == true then
							if RSA.db.profile.Hunter.Spells.AncientHysteria.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.AncientHysteria.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- ANCIENT HYSTERIA
			end -- IF EVENT IS SPELL_AURA_REMOVED
			if event == "SPELL_MISSED" and missType ~= "IMMUNE" then
				if spellID == 20736 then -- DISTRACTING SHOT
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.Hunter.Spells.DistractingShot.Messages.End ~= "" then
						if RSA.db.profile.Hunter.Spells.DistractingShot.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.DistractingShot.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.DistractingShot.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.DistractingShot.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.DistractingShot.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.DistractingShot.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.DistractingShot.Party == true then
							if RSA.db.profile.Hunter.Spells.DistractingShot.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.DistractingShot.Raid == true then
							if RSA.db.profile.Hunter.Spells.DistractingShot.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- DISTRACTING SHOT
				if  (spellID == 147362)  then -- SILENCING SHOT / COUNTER SHOT
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.Hunter.Spells.SilencingShot.Messages.End ~= "" then
						if RSA.db.profile.Hunter.Spells.SilencingShot.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.SilencingShot.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.SilencingShot.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.SilencingShot.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.SilencingShot.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.SilencingShot.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.SilencingShot.Party == true then
							if RSA.db.profile.Hunter.Spells.SilencingShot.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.SilencingShot.Raid == true then
							if RSA.db.profile.Hunter.Spells.SilencingShot.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SILENCING SHOT
			end -- IF EVENT IS SPELL_MISSED AND NOT IMMUNE
			if event == "SPELL_MISSED" and missType == "IMMUNE" then
				if spellID == 20736 then -- DISTRACTING SHOT
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Immune ~= "" then
						if RSA.db.profile.Hunter.Spells.DistractingShot.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.DistractingShot.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.DistractingShot.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.DistractingShot.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.DistractingShot.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.DistractingShot.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.DistractingShot.Party == true then
							if RSA.db.profile.Hunter.Spells.DistractingShot.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.DistractingShot.Raid == true then
							if RSA.db.profile.Hunter.Spells.DistractingShot.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.DistractingShot.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- DISTRACTING SHOT
				if (spellID == 147362) then -- SILENCING SHOT / COUNTER SHOT
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Immune ~= "" then
						if RSA.db.profile.Hunter.Spells.SilencingShot.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.SilencingShot.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.SilencingShot.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.Hunter.Spells.SilencingShot.CustomChannel.Channel)
						end
						if RSA.db.profile.Hunter.Spells.SilencingShot.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.SilencingShot.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.SilencingShot.Party == true then
							if RSA.db.profile.Hunter.Spells.SilencingShot.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Hunter.Spells.SilencingShot.Raid == true then
							if RSA.db.profile.Hunter.Spells.SilencingShot.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Hunter.Spells.SilencingShot.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SILENCING SHOT
			end -- IF EVENT IS SPELL_MISSED AND IS IMMUNE
		end -- IF SOURCE IS PLAYER
	end -- END ENTIRELY
	RSA.CombatLogMonitor:SetScript("OnEvent", Hunter_Spells)
end -- END ON ENABLED
function RSA_Hunter:OnDisable()
	RSA.CombatLogMonitor:SetScript("OnEvent", nil)
end