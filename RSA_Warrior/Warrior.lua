------------------------------------------------
---- Raeli's Spell Announcer Warrior Module ----
------------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_Warrior = RSA:NewModule("Warrior")
function RSA_Warrior:OnInitialize()
	if RSA.db.profile.General.Class == "WARRIOR" then
		RSA_Warrior:SetEnabledState(true)
	else
		RSA_Warrior:SetEnabledState(false)
	end
end -- End OnInitialize
local spellinfo,spelllinkinfo,extraspellinfo,extraspellinfolink,missinfo
function RSA_Warrior:OnEnable()
	RSA.db.profile.Modules.Warrior = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
	local pName = UnitName("player")
	local RSA_RallyingCry = false
	local RSA_DSTimer = CreateFrame("Frame", "RSA:DSTimer")
	local DSTimeElapsed = 0.0
	-- Banners
	local function Warrior_Spells(self, _, timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, ex2, ex3, ex4)
		local petName = UnitName("pet")
		if dest == pName then
			if missType == "REFLECT" then -- SPELL REFLECT
				spellinfo = GetSpellInfo(spellID)
				spelllinkinfo = GetSpellLink(spellID)
				RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = source,}
				if RSA.db.profile.Warrior.Spells.SpellReflect.Messages.Start ~= "" then
					if RSA.db.profile.Warrior.Spells.SpellReflect.Local == true then
						RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.SpellReflect.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.SpellReflect.Yell == true then
						RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.SpellReflect.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.SpellReflect.CustomChannel.Enabled == true then
						RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.SpellReflect.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.SpellReflect.CustomChannel.Channel)
					end
					if RSA.db.profile.Warrior.Spells.SpellReflect.Say == true then
						RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.SpellReflect.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.SpellReflect.SmartGroup == true then
						RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.SpellReflect.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.SpellReflect.Party == true then
						if RSA.db.profile.Warrior.Spells.SpellReflect.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
						RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.SpellReflect.Messages.Start, ".%a+.", RSA.String_Replace))
					end
					if RSA.db.profile.Warrior.Spells.SpellReflect.Raid == true then
						if RSA.db.profile.Warrior.Spells.SpellReflect.SmartGroup == true and GetNumGroupMembers() > 0 then return end
						RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.SpellReflect.Messages.Start, ".%a+.", RSA.String_Replace))
					end
				end
				--SpellReflectSource = source
				--SpellReflectID = spellID
			end -- SPELL REFLECT
		end
		-- Maybe Later for Tracking Spell Reflected Damage.
		--[[if source == SpellReflectSource and dest == SpellReflectSource and spellID == SpellReflectID then
		print(spellName)
		print(missType)
		end]]--
		if source == pName or source == petName then
			if (event == "SPELL_CAST_SUCCESS" and RSA.db.profile.Modules.Reminders_Loaded == true) then -- Reminder Refreshed
				local ReminderSpell = RSA.db.profile.Warrior.Reminders.SpellName
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
				if spellID == 355 then -- TAUNT
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Warrior.Spells.Taunt.Messages.Start ~= "" then
						if RSA.db.profile.Warrior.Spells.Taunt.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Taunt.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Taunt.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.Taunt.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.Taunt.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Taunt.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Taunt.Party == true then
							if RSA.db.profile.Warrior.Spells.Taunt.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Taunt.Raid == true then
							if RSA.db.profile.Warrior.Spells.Taunt.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- TAUNT
				if spellID == 64382 then -- SHATTERING THROW
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.Start ~= "" then
						if RSA.db.profile.Warrior.Spells.ShatteringThrow.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShatteringThrow.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShatteringThrow.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.ShatteringThrow.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.ShatteringThrow.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShatteringThrow.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShatteringThrow.Party == true then
							if RSA.db.profile.Warrior.Spells.ShatteringThrow.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShatteringThrow.Raid == true then
							if RSA.db.profile.Warrior.Spells.ShatteringThrow.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SHATTERING THROW
				if spellID == 1719 then -- RECKLESSNESS
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Warrior.Spells.Recklessness.Messages.Start ~= "" then
						if RSA.db.profile.Warrior.Spells.Recklessness.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Recklessness.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Recklessness.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.Recklessness.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.Recklessness.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Recklessness.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Recklessness.Party == true then
							if RSA.db.profile.Warrior.Spells.Recklessness.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Recklessness.Raid == true then
							if RSA.db.profile.Warrior.Spells.Recklessness.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- RECKLESSNESS
				if spellID == 114030 then -- VIGILANCE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Warrior.Spells.Vigilance.Messages.Start ~= "" then
						if RSA.db.profile.Warrior.Spells.Vigilance.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Vigilance.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Vigilance.Whisper == true and dest ~= pName and RSA.Whisperable(destFlags) then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.Start, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Warrior.Spells.Vigilance.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.Vigilance.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.Vigilance.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Vigilance.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Vigilance.Party == true then
							if RSA.db.profile.Warrior.Spells.Vigilance.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Vigilance.Raid == true then
							if RSA.db.profile.Warrior.Spells.Vigilance.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- VIGILANCE
				if spellID == 18498 then -- PUMMEL (GAG ORDER)
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					extraspellinfo = GetSpellInfo(missType)
					extraspellinfolink = GetSpellLink(missType)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
					if RSA.db.profile.Warrior.Spells.Pummel.Messages.Gag ~= "" then
						if RSA.db.profile.Warrior.Spells.Pummel.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Gag, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Pummel.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Gag, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Pummel.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Gag, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.Pummel.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.Pummel.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Gag, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Pummel.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Gag, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Pummel.Party == true then
							if RSA.db.profile.Warrior.Spells.Pummel.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Gag, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Pummel.Raid == true then
							if RSA.db.profile.Warrior.Spells.Pummel.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Gag, ".%a+.", RSA.String_Replace))
						end
					end
				end -- PUMMEL (GAG ORDER)
				if spellID == 132404 then -- SHIELD BLOCK
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.Start ~= "" then
						if RSA.db.profile.Warrior.Spells.ShieldBlock.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldBlock.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldBlock.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.ShieldBlock.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.ShieldBlock.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldBlock.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldBlock.Party == true then
							if RSA.db.profile.Warrior.Spells.ShieldBlock.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldBlock.Raid == true then
							if RSA.db.profile.Warrior.Spells.ShieldBlock.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SHIELD BLOCK
				if spellID == 112048 then -- SHIELD BARRIER
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Warrior.Spells.ShieldBarrier.Messages.Start ~= "" then
						if RSA.db.profile.Warrior.Spells.ShieldBarrier.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBarrier.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldBarrier.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBarrier.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldBarrier.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBarrier.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.ShieldBarrier.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.ShieldBarrier.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBarrier.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldBarrier.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBarrier.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldBarrier.Party == true then
							if RSA.db.profile.Warrior.Spells.ShieldBarrier.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBarrier.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldBarrier.Raid == true then
							if RSA.db.profile.Warrior.Spells.ShieldBarrier.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBarrier.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SHIELD BARRIER
				if spellID == 114192 then -- MOCKING BANNER
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Warrior.Spells.MockingBanner.Messages.Start ~= "" then
						if RSA.db.profile.Warrior.Spells.MockingBanner.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.MockingBanner.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.MockingBanner.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.MockingBanner.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.MockingBanner.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.MockingBanner.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.MockingBanner.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.MockingBanner.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.MockingBanner.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.MockingBanner.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.MockingBanner.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.MockingBanner.Party == true then
							if RSA.db.profile.Warrior.Spells.MockingBanner.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.MockingBanner.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.MockingBanner.Raid == true then
							if RSA.db.profile.Warrior.Spells.MockingBanner.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.MockingBanner.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- MOCKING BANNER
				if spellID == 118038 then -- DIE BY THE SWORD
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Warrior.Spells.DieByTheSword.Messages.Start ~= "" then
						if RSA.db.profile.Warrior.Spells.DieByTheSword.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.DieByTheSword.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.DieByTheSword.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.DieByTheSword.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.DieByTheSword.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.DieByTheSword.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.DieByTheSword.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.DieByTheSword.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.DieByTheSword.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.DieByTheSword.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.DieByTheSword.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.DieByTheSword.Party == true then
							if RSA.db.profile.Warrior.Spells.DieByTheSword.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.DieByTheSword.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.DieByTheSword.Raid == true then
							if RSA.db.profile.Warrior.Spells.DieByTheSword.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.DieByTheSword.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- DIE BY THE SWORD
			end -- IF EVENT IS SPELL_AURA_APPLIED
			if event == "SPELL_CAST_SUCCESS" then
				if spellID == 871 then -- SHIELD WALL
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Warrior.Spells.ShieldWall.Messages.Start ~= "" then
						if RSA.db.profile.Warrior.Spells.ShieldWall.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldWall.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldWall.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.ShieldWall.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.ShieldWall.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldWall.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldWall.Party == true then
							if RSA.db.profile.Warrior.Spells.ShieldWall.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldWall.Raid == true then
							if RSA.db.profile.Warrior.Spells.ShieldWall.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SHIELD WALL
				if spellID == 12975 then -- LAST STAND
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Warrior.Spells.LastStand.Messages.Start ~= "" then
						if RSA.db.profile.Warrior.Spells.LastStand.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.LastStand.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.LastStand.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.LastStand.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.LastStand.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.LastStand.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.LastStand.Party == true then
							if RSA.db.profile.Warrior.Spells.LastStand.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.LastStand.Raid == true then
							if RSA.db.profile.Warrior.Spells.LastStand.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- LAST STAND
				if spellID == 55694 then -- ENRAGED REGENERATION
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.Start ~= "" then
						if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.EnragedRegeneration.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.EnragedRegeneration.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.EnragedRegeneration.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Party == true then
							if RSA.db.profile.Warrior.Spells.EnragedRegeneration.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Raid == true then
							if RSA.db.profile.Warrior.Spells.EnragedRegeneration.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- ENRAGED REGENERATION
				if spellID == 97462 then -- RALLYING CRY
					RSA_RallyingCry = false
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Warrior.Spells.RallyingCry.Messages.Start ~= "" then
						if RSA.db.profile.Warrior.Spells.RallyingCry.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.RallyingCry.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.RallyingCry.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.RallyingCry.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.RallyingCry.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.RallyingCry.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.RallyingCry.Party == true then
							if RSA.db.profile.Warrior.Spells.RallyingCry.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.RallyingCry.Raid == true then
							if RSA.db.profile.Warrior.Spells.RallyingCry.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- RALLYING CRY
				if spellID == 3411 or spellID == 114029 then -- INTERVENE / SAFEGUARD
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Warrior.Spells.Intervene.Messages.Start ~= "" then
						if RSA.db.profile.Warrior.Spells.Intervene.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Intervene.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Intervene.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.Intervene.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Intervene.Whisper == true and dest ~= pName and RSA.Whisperable(destFlags) then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Warrior.Spells.Intervene.Messages.Start, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Warrior.Spells.Intervene.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Intervene.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.Intervene.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.Intervene.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Intervene.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Intervene.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.Intervene.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Intervene.Party == true then
							if RSA.db.profile.Warrior.Spells.Intervene.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Intervene.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Intervene.Raid == true then
							if RSA.db.profile.Warrior.Spells.Intervene.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Intervene.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- INTERVENE /SAFEGUARD
				if spellID == 1160 then -- DEMORALIZING SHOUT
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Warrior.Spells.DemoralizingShout.Messages.Start ~= "" then
						if RSA.db.profile.Warrior.Spells.DemoralizingShout.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.DemoralizingShout.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.DemoralizingShout.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.DemoralizingShout.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.DemoralizingShout.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.DemoralizingShout.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.DemoralizingShout.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.DemoralizingShout.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.DemoralizingShout.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.DemoralizingShout.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.DemoralizingShout.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.DemoralizingShout.Party == true then
							if RSA.db.profile.Warrior.Spells.DemoralizingShout.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.DemoralizingShout.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.DemoralizingShout.Raid == true then
							if RSA.db.profile.Warrior.Spells.DemoralizingShout.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.DemoralizingShout.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
					if RSA.db.profile.Warrior.Spells.DemoralizingShout.Messages.End ~= "" then -- Demoralizing Shout ending doesn't appear on combat log
						DSTimeElapsed = 0.0 -- Start timer for end announcement.
						local function DSTimer(self, elapsed)
							DSTimeElapsed = DSTimeElapsed + elapsed
							if DSTimeElapsed < 10 then return end
							if RSA_DemoralizingShoutProcced == true then
								RSA_DSTimer:SetScript("OnUpdate", nil)
								return end
							DSTimeElapsed = DSTimeElapsed - floor(DSTimeElapsed)
							spellinfo = GetSpellInfo(spellID)
							spelllinkinfo = GetSpellLink(spellID)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
							if RSA.db.profile.Warrior.Spells.DemoralizingShout.Local == true then
								RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.DemoralizingShout.Messages.End, ".%a+.", RSA.String_Replace))
							end
							if RSA.db.profile.Warrior.Spells.DemoralizingShout.Yell == true then
								RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.DemoralizingShout.Messages.End, ".%a+.", RSA.String_Replace))
							end
							if RSA.db.profile.Warrior.Spells.DemoralizingShout.Whisper == true and dest ~= pName and RSA.Whisperable(destFlags) then
								RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
								RSA.Print_Whisper(string.gsub(RSA.db.profile.Warrior.Spells.DemoralizingShout.Messages.End, ".%a+.", RSA.String_Replace), dest)
								RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
							end
							if RSA.db.profile.Warrior.Spells.DemoralizingShout.CustomChannel.Enabled == true then
								RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.DemoralizingShout.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.DemoralizingShout.CustomChannel.Channel)
							end
							if RSA.db.profile.Warrior.Spells.DemoralizingShout.Say == true then
								RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.DemoralizingShout.Messages.End, ".%a+.", RSA.String_Replace))
							end
							if RSA.db.profile.Warrior.Spells.DemoralizingShout.SmartGroup == true then
								RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.DemoralizingShout.Messages.End, ".%a+.", RSA.String_Replace))
							end
							if RSA.db.profile.Warrior.Spells.DemoralizingShout.Party == true then
								if RSA.db.profile.Warrior.Spells.DemoralizingShout.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
								RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.DemoralizingShout.Messages.End, ".%a+.", RSA.String_Replace))
							end
							if RSA.db.profile.Warrior.Spells.DemoralizingShout.Raid == true then
								if RSA.db.profile.Warrior.Spells.DemoralizingShout.SmartGroup == true and GetNumGroupMembers() > 0 then return end
								RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.DemoralizingShout.Messages.End, ".%a+.", RSA.String_Replace))
							end
							RSA_DSTimer:SetScript("OnUpdate", nil)
						end
						RSA_DSTimer:SetScript("OnUpdate", DSTimer)
					end -- DEMORALIZING SHOUT TIMER
				end --DEMORALIZING SHOUT
			end -- IF EVENT IS SPELL_CAST_SUCCESS
			if event == "SPELL_INTERRUPT" then
				if spellID == 6552 then -- PUMMEL
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					extraspellinfo = GetSpellInfo(missType)
					extraspellinfolink = GetSpellLink(missType)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[TARSPELL]"] = extraspellinfo, ["[TARLINK]"] = extraspellinfolink,}
					if RSA.db.profile.Warrior.Spells.Pummel.Messages.Start ~= "" then
						if RSA.db.profile.Warrior.Spells.Pummel.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Pummel.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Pummel.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.Pummel.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.Pummel.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Pummel.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Pummel.Party == true then
							if RSA.db.profile.Warrior.Spells.Pummel.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Pummel.Raid == true then
							if RSA.db.profile.Warrior.Spells.Pummel.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- PUMMEL
			end -- IF EVENT IS SPELL_INTERRUPT
			if event == "SPELL_AURA_REMOVED" then
				if spellID == 64382 then -- SHATTERING THROW
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.End ~= "" then
						if RSA.db.profile.Warrior.Spells.ShatteringThrow.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShatteringThrow.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShatteringThrow.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.ShatteringThrow.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.ShatteringThrow.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShatteringThrow.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShatteringThrow.Party == true then
							if RSA.db.profile.Warrior.Spells.ShatteringThrow.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShatteringThrow.Raid == true then
							if RSA.db.profile.Warrior.Spells.ShatteringThrow.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ShatteringThrow.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SHATTERING THROW
				if spellID == 114030 then -- VIGILANCE
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
					if RSA.db.profile.Warrior.Spells.Vigilance.Messages.End ~= "" then
						if RSA.db.profile.Warrior.Spells.Vigilance.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Vigilance.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Vigilance.Whisper == true and dest ~= pName and RSA.Whisperable(destFlags) then
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = L["You"],}
							RSA.Print_Whisper(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.End, ".%a+.", RSA.String_Replace), dest)
							RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest,}
						end
						if RSA.db.profile.Warrior.Spells.Vigilance.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.Vigilance.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.Vigilance.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Vigilance.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Vigilance.Party == true then
							if RSA.db.profile.Warrior.Spells.Vigilance.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Vigilance.Raid == true then
							if RSA.db.profile.Warrior.Spells.Vigilance.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Vigilance.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- VIGILANCE
				if spellID == 871 then -- SHIELD WALL
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Warrior.Spells.ShieldWall.Messages.End ~= "" then
						if RSA.db.profile.Warrior.Spells.ShieldWall.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldWall.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldWall.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.ShieldWall.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.ShieldWall.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldWall.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldWall.Party == true then
							if RSA.db.profile.Warrior.Spells.ShieldWall.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldWall.Raid == true then
							if RSA.db.profile.Warrior.Spells.ShieldWall.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ShieldWall.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SHIELD WALL
				if spellID == 12976 then -- LAST STAND
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Warrior.Spells.LastStand.Messages.End ~= "" then
						if RSA.db.profile.Warrior.Spells.LastStand.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.LastStand.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.LastStand.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.LastStand.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.LastStand.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.LastStand.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.LastStand.Party == true then
							if RSA.db.profile.Warrior.Spells.LastStand.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.LastStand.Raid == true then
							if RSA.db.profile.Warrior.Spells.LastStand.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.LastStand.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- LAST STAND
				if spellID == 55694 then -- ENRAGED REGENERATION
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.End ~= "" then
						if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.EnragedRegeneration.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.EnragedRegeneration.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.EnragedRegeneration.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Party == true then
							if RSA.db.profile.Warrior.Spells.EnragedRegeneration.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.EnragedRegeneration.Raid == true then
							if RSA.db.profile.Warrior.Spells.EnragedRegeneration.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.EnragedRegeneration.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- ENRAGED REGENERATION
				if spellID == 2565 then -- SHIELD BLOCK
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.End ~= "" then
						if RSA.db.profile.Warrior.Spells.ShieldBlock.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldBlock.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldBlock.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.ShieldBlock.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.ShieldBlock.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldBlock.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldBlock.Party == true then
							if RSA.db.profile.Warrior.Spells.ShieldBlock.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldBlock.Raid == true then
							if RSA.db.profile.Warrior.Spells.ShieldBlock.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBlock.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SHIELD BLOCK
				if spellID == 112048 then -- SHIELD BARRIER
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Warrior.Spells.ShieldBarrier.Messages.End ~= "" then
						if RSA.db.profile.Warrior.Spells.ShieldBarrier.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBarrier.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldBarrier.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBarrier.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldBarrier.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBarrier.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.ShieldBarrier.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.ShieldBarrier.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBarrier.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldBarrier.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBarrier.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldBarrier.Party == true then
							if RSA.db.profile.Warrior.Spells.ShieldBarrier.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBarrier.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldBarrier.Raid == true then
							if RSA.db.profile.Warrior.Spells.ShieldBarrier.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ShieldBarrier.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SHIELD BARRIER
				if spellID == 1719 then -- RECKLESSNESS
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Warrior.Spells.Recklessness.Messages.End ~= "" then
						if RSA.db.profile.Warrior.Spells.Recklessness.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Recklessness.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Recklessness.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.Recklessness.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.Recklessness.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Recklessness.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Recklessness.Party == true then
							if RSA.db.profile.Warrior.Spells.Recklessness.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Recklessness.Raid == true then
							if RSA.db.profile.Warrior.Spells.Recklessness.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Recklessness.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- RECKLESSNESS
				if spellID == 97463 and RSA_RallyingCry == false then -- RALLYING CRY
					RSA_RallyingCry = true
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Warrior.Spells.RallyingCry.Messages.End ~= "" then
						if RSA.db.profile.Warrior.Spells.RallyingCry.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.RallyingCry.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.RallyingCry.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.RallyingCry.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.RallyingCry.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.RallyingCry.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.RallyingCry.Party == true then
							if RSA.db.profile.Warrior.Spells.RallyingCry.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.RallyingCry.Raid == true then
							if RSA.db.profile.Warrior.Spells.RallyingCry.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.RallyingCry.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- RALLYING CRY
				if spellID == 114192 then -- MOCKING BANNER
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Warrior.Spells.MockingBanner.Messages.End ~= "" then
						if RSA.db.profile.Warrior.Spells.MockingBanner.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.MockingBanner.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.MockingBanner.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.MockingBanner.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.MockingBanner.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.MockingBanner.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.MockingBanner.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.MockingBanner.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.MockingBanner.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.MockingBanner.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.MockingBanner.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.MockingBanner.Party == true then
							if RSA.db.profile.Warrior.Spells.MockingBanner.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.MockingBanner.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.MockingBanner.Raid == true then
							if RSA.db.profile.Warrior.Spells.MockingBanner.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.MockingBanner.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- MOCKING BANNER
				if spellID == 118038 then -- DIE BY THE SWORD
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo,}
					if RSA.db.profile.Warrior.Spells.DieByTheSword.Messages.End ~= "" then
						if RSA.db.profile.Warrior.Spells.DieByTheSword.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.DieByTheSword.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.DieByTheSword.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.DieByTheSword.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.DieByTheSword.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.DieByTheSword.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.DieByTheSword.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.DieByTheSword.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.DieByTheSword.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.DieByTheSword.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.DieByTheSword.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.DieByTheSword.Party == true then
							if RSA.db.profile.Warrior.Spells.DieByTheSword.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.DieByTheSword.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.DieByTheSword.Raid == true then
							if RSA.db.profile.Warrior.Spells.DieByTheSword.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.DieByTheSword.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- DIE BY THE SWORD
			end -- IF EVENT IS SPELL_AURA_REMOVED
			if event == "SPELL_DISPEL" then
				if spellID == 23922 then -- SHIELD SLAM DISPEL
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					extraspellinfo = GetSpellInfo(missType)
					extraspellinfolink = GetSpellLink(missType)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
					if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.Start ~= "" then
						if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.Start, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.ShieldSlamDispel.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Party == true then
							if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.Start, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Raid == true then
							if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.Start, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SHIELD SLAM DISPEL
			end -- IF EVENT IS SPELL_DISPEL
			if event == "SPELL_DISPEL_FAILED" then
				if spellID == 23922 then -- SHIELD SLAM DISPEL
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					extraspellinfo = GetSpellInfo(missType)
					extraspellinfolink = GetSpellLink(missType)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[AURA]"] = extraspellinfo, ["[AURALINK]"] = extraspellinfolink,}
					if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.End ~= "" then
						if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.ShieldSlamDispel.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Party == true then
							if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Raid == true then
							if RSA.db.profile.Warrior.Spells.ShieldSlamDispel.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.ShieldSlamDispel.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- SHIELD SLAM DISPEL
			end -- IF EVENT IS SPELL_DISPEL_FAILED
			if event == "SPELL_MISSED" and missType ~= "IMMUNE" then
				if spellID == 355 then -- TAUNT
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.Warrior.Spells.Taunt.Messages.End ~= "" then
						if RSA.db.profile.Warrior.Spells.Taunt.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Taunt.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Taunt.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.Taunt.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.Taunt.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Taunt.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Taunt.Party == true then
							if RSA.db.profile.Warrior.Spells.Taunt.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Taunt.Raid == true then
							if RSA.db.profile.Warrior.Spells.Taunt.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- TAUNT
				if spellID == 6552 then -- PUMMEL
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					if missType == "MISS" then
						missinfo = L["missed"]
					elseif missType ~= "MISS" then
						missinfo = L["was resisted by"]
					end
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = missinfo,}
					if RSA.db.profile.Warrior.Spells.Pummel.Messages.End ~= "" then
						if RSA.db.profile.Warrior.Spells.Pummel.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Pummel.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Pummel.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.End, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.Pummel.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.Pummel.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Pummel.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Pummel.Party == true then
							if RSA.db.profile.Warrior.Spells.Pummel.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.End, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Pummel.Raid == true then
							if RSA.db.profile.Warrior.Spells.Pummel.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.End, ".%a+.", RSA.String_Replace))
						end
					end
				end -- PUMMEL
			end -- IF EVENT IS SPELL_MISSED AND NOT IMMUNE
			if event == "SPELL_MISSED" and missType == "IMMUNE" then
				if spellID == 355 then -- TAUNT
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.Warrior.Spells.Taunt.Messages.Immune ~= "" then
						if RSA.db.profile.Warrior.Spells.Taunt.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Taunt.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Taunt.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.Taunt.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.Taunt.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Taunt.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Taunt.Party == true then
							if RSA.db.profile.Warrior.Spells.Taunt.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Taunt.Raid == true then
							if RSA.db.profile.Warrior.Spells.Taunt.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Taunt.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- TAUNT
				if spellID == 6552 then -- PUMMEL
					spellinfo = GetSpellInfo(spellID)
					spelllinkinfo = GetSpellLink(spellID)
					RSA.Replacements = {["[SPELL]"] = spellinfo, ["[LINK]"] = spelllinkinfo, ["[TARGET]"] = dest, ["[MISSTYPE]"] = L["Immune"],}
					if RSA.db.profile.Warrior.Spells.Pummel.Messages.Immune ~= "" then
						if RSA.db.profile.Warrior.Spells.Pummel.Local == true then
							RSA.Print_LibSink(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Pummel.Yell == true then
							RSA.Print_Yell(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Pummel.CustomChannel.Enabled == true then
							RSA.Print_Channel(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Immune, ".%a+.", RSA.String_Replace), RSA.db.profile.Warrior.Spells.Pummel.CustomChannel.Channel)
						end
						if RSA.db.profile.Warrior.Spells.Pummel.Say == true then
							RSA.Print_Say(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Pummel.SmartGroup == true then
							RSA.Print_SmartGroup(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Pummel.Party == true then
							if RSA.db.profile.Warrior.Spells.Pummel.SmartGroup == true and GetNumGroupMembers() == 0 and InstanceType ~= "arena" then return end
							RSA.Print_Party(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
						if RSA.db.profile.Warrior.Spells.Pummel.Raid == true then
							if RSA.db.profile.Warrior.Spells.Pummel.SmartGroup == true and GetNumGroupMembers() > 0 then return end
							RSA.Print_Raid(string.gsub(RSA.db.profile.Warrior.Spells.Pummel.Messages.Immune, ".%a+.", RSA.String_Replace))
						end
					end
				end -- PUMMEL
			end -- IF EVENT IS SPELL_MISSED AND IS IMMUNE
		end -- IF SOURCE IS PLAYER
	end -- END ENTIRELY
	RSA.CombatLogMonitor:SetScript("OnEvent", Warrior_Spells)
end -- END ON ENABLED
function RSA_Warrior:OnDisable()
	RSA.CombatLogMonitor:SetScript("OnEvent", nil)
end