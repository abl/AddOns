local L = LibStub("AceLocale-3.0"):NewLocale("RSA", "enUS", true)

------------------------------------------------------------------------------
--- IN THE PROCESS OF REDOING THIS TO MAKE IT CLEARER TO READ AND UPDATE. ----
------------------------------------------------------------------------------
-- PRIMARY LOCALISATIONS
L["Tol Barad"] = true -- a = select(32,GetMapZones(2)) Will this always return Tol Barad? It seems GetMapZones is alphabetised, maybe not the same order in other localisations?
L["Corpse of "] = true -- Tooltip mouseover of a released corpse.


-- PRIMARY LOCALISATIONS-->>BUFF REMINDER MODULE
L[" is Missing!"] = true
L[" Refreshed!"] = true


-- PRIMARY LOCALISATIONS-->>SPELL ANNOUNCEMENTS
L["You"] = true
L["missed"] = true
L["was resisted by"] = true
L["Immune"] = true
L["Unknown"] = true


-- MAIN OPTIONS PANEL-->>GLOBAL OPTIONS & THEIR DESCRIPTIONS
L["Global Options"] = true
L.Global_Options_Desc = "Here you can configure some general settings for RSA that will affect all of your announcements."

L["About"] = true
L.About_Desc = "Welcome to RSA! If you're stuck, go to the help tab on the left. If you still aren't sure, leave me a comment on Curse at: |cff33ff99http://wow.curse.com/downloads/wow-addons/details/rsa.aspx|r. If you find a bug, or have a feature request, make a ticket on Curse at: |cff33ff99http://wow.curseforge.com/addons/rsa/tickets/|r."

L["Module Settings"] = true
L.Module_Settings_Desc = "" -- None for now.

L["Enable Buff Reminder Module"] = true
L.Buff_Reminders_Desc = "This Module allows you to be reminded when you have a buff missing."

L["Announcement Options"] = true
L.Announcement_Options_Desc = "These options affect all spells, hover over each to see a full description of what it does."

L["Smart Say"] = "Smart Say/Yell"
L.Smart_Say_Desc = "Enabling this will only cause you to announce selected spells in say or yell |cffFF0000only|r while you are grouped."

L["Smart Custom Channel"] = true
L.Smart_Custom_Channel_Desc = "Enabling this will only cause you to announce selected spells in your custom channel |cffFF0000only|r while you are grouped."

L["Enable Only In Combat"] = true
L.Enable_Only_In_Combat_Desc = "Enabling this will cause you to only send announcements while you are in combat."

L["Enable in Arenas"] = true
L.Enable_In_Arenas_Desc = "Enabling this will allow you to announce while in Arenas."

L["Enable in Battlegrounds"] = true
L.Enable_In_Battlegrounds_Desc = "Enabling this will allow you to announce while in Battlegrounds."

L["Enable in Dungeons"] = true
L.Enable_In_Dungeons_Desc = "Enabling this will allow you to announce while in 5 Person Dungeons and Heroics."

L["Enable in Raid Instances"] = true
L.Enable_In_Raid_Instances_Desc = "Enabling this will allow you to announce while in Raid Instances."

L["Enable in Tol Barad"] = true
L.Enable_In_Tol_Barad_Desc = "Enabling this will allow you to announce while in Tol Barad."

L["Enable in the World"] = true
L.Enable_In_The_World_Desc = "Enabling this will allow you to announce while in the normal World. In other words, in any situation not listed by all other options."

L["Enable in PvP"] = true
L.Enable_In_PvP_Desc = "Enabling this will allow you to announce while you are PvP active, regardless of location. Enabling this will hide the specific location options for PvP areas."

L["Enable in Scenarios"] = true
L.Enable_In_Scenarios_Desc = "Enabling this will allow you to announce while you are in a Scenario."

L["Enable in LFG"] = true
L.Enable_In_LFG_Desc = "Enabling this will allow you to announce while in a LFG dungeon or raid."

-- MAIN OPTIONS PANEL-->>LIB SINK OUTPUT
L["Local Message Output Area"] = true
L.Local_Message_Output_Area_Desc = "Spells that are set \"local\" in their settings will be sent to one of the following places, here you can select which."


-- MAIN OPTIONS PANEL-->>GENERAL ANNOUNCEMENTS
L["General Announcements"] = true
L.General_Announcements_Desc = "Here you can configure non class specific announcements. Things such as racial abilities, guild perks such as Mass Ressurrection, or other things such as the placement of a Jeeves."

L["Racial: "] = true
L["Leader: "] = true
L["Personal: "] = true


-- BUFF REMINDERS OPTIONS PANEL-->>GENERAL LOCALISATIONS
L["Reminder Options"] = true
L.Reminder_Options = "Options for reminding you when certain buffs are missing."
L.Disabled_Reminder_Options = "|cffFF0000This module is disabled.|r To enable it, check \"|cff00CCFFEnable Buff Reminder Module|r\" in the main options window."
L.Spell_To_Check = "Name of the Spell you want to check:"
L.Spell_To_Check_Desc = "Enter the name of the spell you wish to be reminded of.\n|cffFF0000WARNING:|r If you do not enter the name of the spell accurately, it will not work."
L["Disable in PvP"] = true -- To Be Removed and replaced with the earlier "Enable in PvP". I need to rework the Reminders module a little first though.
L["Turns off the spell reminders while you have PvP active."] = true -- Will need to be changed soon also.
L.Enable_In_Spec1 = "Enable in Primary Specialisation"
L.Enable_In_Spec1_Desc = "Enables reminding of missing buffs while in your Primary Talent Specialisation"
L.Enable_In_Spec2 = "Enable in Secondary Specialisation"
L.Enable_In_Spec2_Desc = "Enables reminding of missing buffs while in your Secondary Talent Specialisation"
L["Remind Interval"] = true
L.Remind_Interval_Desc = "How often you want to be reminded about missing buffs."
L["Announce In"] = true
L["Chat Window"] = true -- REMOVE. Buff Reminders will use LibSink soon, this will be redundant.
L["Sends reminders to your default chat window."] = true -- This too.
L["Raid Warning Frame"] = true -- And this.
L["Sends reminders to your Raid Warning frame at the center of the screen."] = true -- And also this.


-- SPELL OPTIONS PANEL-->>GENERAL LOCALISATIONS
L["Spell Options"] = true
L.Spell_Options = "Settings for individual spells. Select the spell you want to configure from the drop down list on the right."

L["Hostile Only"] = true
L.Hostile_Only_Desc = "Announces only if the target is attackable."


-- SPELL OPTIONS PANEL-->>CHANNEL OPTIONS
L["Local"] = true
L.Local_Desc = "If selected, announces in an area of your choice, that is set in the main options panel in the \"Local Message Output Area\" section.\nThis setting also does not follow the global announcement settings, and will, if checked, announce regardless of those settings."

L["Whisper"] = true
L.Whisper_Desc = "Whispers the target of the spell.\nThis setting also does not follow the global announcement settings, and will, if checked, announce regardless of those settings."

L["Custom Channel"] = true
L.Custom_Channel_Desc = "This is for player created channels |cffFF0000ONLY|r. e.g \"MyGuildHealerChannel\"\nThere is a setting in the main options that affects if this can announce while you are in a group or not."

L["Channel Name"] = true
L.Channel_Name_Desc = "Enter the name of the channel you want to announce in. Please |cffFF0000ONLY|r use player created channels. Channels that already exist, such as \"Party\" will |cffFF0000NOT|r work."

L["Raid"] = true
L.Raid_Desc = "Announces to the Raid channel, if you are in a raid. Does not serve any function in Battlegrounds or Arenas."

L["Party"] = true
L.Party_Desc = "Announces to the Party channel, if you are in a group of any kind, raid or party. Does not serve any function in Battlegrounds."

L["Smart Group"] = true
L.Smart_Group_Desc = "Announces to the Raid if you're in a raid, or party if you're in a party. It will also send to the Battleground channel if you're in a Battleground or Arena."

L["Say"] = true
L.Say_Desc = "Announces to the Say channel.\nThere is a setting in the main options that affects if this can announce while you are in a group or not."

L.Yell = true
L.Yell_Desc = "Announces to the Yell channel."

-- SPELL OPTIONS PANEL-->>MESSAGE OPTIONS
L["Message Settings"] = true
L.Message_Settings_Desc = "Here you can customise the messages that are sent when you announce this spell. To disable a certain announcement, leave it blank. You can put any of the following into your messages to make them more dynamic:\n|cFFFF75B3%%|r for a % sign.\n|cFFFF75B3[SPELL]|r for the name of the spell.\n|cFFFF75B3[LINK]|r for a clickable spell link."
L.MST = "\n|cFFFF75B3[TARGET]|r for the name of the target."
L.MSA = "\n|cFFFF75B3[AMOUNT]|r for the amount of damage healed/dealt/gained."
L.MSM = "\n|cFFFF75B3[MISSTYPE]|r for the type of resist."
L.MSI = "\n|cFFFF75B3[TARSPELL]|r for the name of the target\'s spell.\n|cFFFF75B3[TARLINK]|r for a clickable spell link for the target\'s spell."
L.MSB = "\n|cFFFF75B3[AURA]|r for the name of the (de)buff removed.\n|cFFFF75B3[AURALINK]|r for a clickable spell link of the (de)buff removed."
L.MSS = "\n|cFFFF75B3[STAGGER]|r for a clickable spell link of the stagger.\n|cFFFF75B3[AMOUNT]|r for the amount of damage removed."

-- SPELL OPTIONS PANEL-->>MISCELLANEOUS TRANSLATIONS
L["Dispel"] = true

-- Amount minimums
L["Minimum"] = true
L.MinimumNeeded = "Minimum amount needed to announce."

-- Grounding Totem Descriptions
L["Destroyed by damage"] = true
L.DestroyedByDamage = "The message played when your totem is destroyed by damage."

L["Destroyed by other effects"] = true
L.DestroyedByOther = "The message played when your totem is destroyed by effects which do no damage, such as " .. GetSpellInfo(118) .. "."


-- Load on Demand Descriptions
L.OptionsDisabled = "Module disabled, please enable it."
L.OptionsMissing = "Module could not be found, please delete your RSA folders, download, and install again."
L.OptionsClass = " If you want to use RSA with this class, please enable the module."
-- Option Titles
L["Enabling Options"] = true
L["End"] = true
L["Help!"] = true
L["Reminder Spell"] = true
L["Resisted"] = true
L["Start"] = true
L["Successful"] = true
L["Heal"] = true
L["Upon Placement"] = true
L["When Tripped"] = true
L["Interrupt"] = true
L["Aura Applied"] = true
L["Stolen Charges"] = true
-- Option Descriptions
L.DescSpellStartSuccess = "The message played when the spell is successfully cast."
L.DescTrapPlacement = "The message when your trap is first deployed."
L.DescTrapTripped = "The message played when your trap is tripped."
L.DescSpellStartCastingMessage = "The message played upon casting the spell, or the relevant (de)buff being applied."
L.DescSpellEndCastingMessage = "The message played upon the spell ending, or the relevant (de)buff being removed."
L.DescSpellEndResist = "The message played on resists."
L.DescSpellEndImmune = "The message played when the target is immune."
L.DescSpellProcName = "The message played when the spell procs."
L.DescLightwellRenewStolen = "The message played when someone clicks the Lightwell too fast and uses up multiple charges."
-- Onload Messages
L.alpha_message = "|cffFF0000WARNING:|r You are using an Alpha version of RSA. It may not function as intended!"
L.updated_message = "|cffFF0000Warning:|r Some options have changed in RSA."
