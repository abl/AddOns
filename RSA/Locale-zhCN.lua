local L = LibStub("AceLocale-3.0"):NewLocale("RSA", "zhCN")
if not L then return end
------------------------------------------------------------------------------
--- IN THE PROCESS OF REDOING THIS TO MAKE IT CLEARER TO READ AND UPDATE. ----
------------------------------------------------------------------------------

-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- @@@@@@@@@@ Strings marked with #### should not be translated. They will be edited or deleted soon.
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

-- PRIMARY LOCALISATIONS
L["Tol Barad"] = "托巴拉德" -- a = select(32,GetMapZones(2)) Will this always return Tol Barad? It seems GetMapZones is alphabetised, maybe not the same order in other localisations?
L["Corpse of "] = "死掉的 " -- Tooltip mouseover of a released corpse.


-- PRIMARY LOCALISATIONS-->>BUFF REMINDER MODULE
L[" is Missing!"] = " 失效！"
L[" Refreshed!"] = " 刷新！"


-- PRIMARY LOCALISATIONS-->>SPELL ANNOUNCEMENTS
L["You"] = "你"
L["missed"] = "未命中"
L["was resisted by"] = "抵抗了"
L["Immune"] = "免疫"
L["Unknown"] = "未知"


-- MAIN OPTIONS PANEL-->>GLOBAL OPTIONS & THEIR DESCRIPTIONS
L["Global Options"] = "全区选项"
L.Global_Options_Desc = "在这里您可以配置一些常规设置的RSA，这将影响您所有的通告。"

L["About"] = "关于"
L.About_Desc = "欢迎使用RSA！如果您有使用上的问题，请给我一个Curse评论于：|cff33ff99http://wow.curse.com/downloads/wow-addons/details/rsa.aspx|r。如果你发现一个bug，或者有功能上的要求，请在Curse给我一个ticket留言于：|cff33ff99http://wow.curseforge.com/addons/rsa/tickets/|r。"

L["Module Settings"] = "模组设置"
L.Module_Settings_Desc = "" -- None for now.

L["Enable Buff Reminder Module"] = "启用增益提醒模组"
L.Buff_Reminders_Desc = "当你有一个buff失效时这个模组将给你提醒。"

L["Announcement Options"] = "通报选项"
L.Announcement_Options_Desc = "这些选项影响所有法术，悬停在选项上以看到完整作用的描述。"

L["Smart Say"] = "智能说"
L.Smart_Say_Desc = "启用此将会让你通报选择的法术在说频（|cffFF0000只有|r当你在群体中）。"

L["Smart Custom Channel"] = "智能自订频道"
L.Smart_Custom_Channel_Desc = "启用此将会让你通报选择的法术在自订频道（|cffFF0000只有|r当你在群体中）。"

L["Enable Only In Combat"] = "仅在战斗中启用"
L.Enable_Only_In_Combat_Desc = "启用此将使法术通报只在战斗中作用。"

L["Enable in Arenas"] = "启用于竞技场"
L.Enable_In_Arenas_Desc = "启用此将允许法术在竞技场时通报。"

L["Enable in Battlegrounds"] = "启用于战场"
L.Enable_In_Battlegrounds_Desc = "启用此将允许法术在战场中通报。"

L["Enable in Dungeons"] = "启用于副本"
L.Enable_In_Dungeons_Desc = "启用此将使法术通报在5人普通/英雄副本时作用。"

L["Enable in Raid Instances"] = "启用于团队副本"
L.Enable_In_Raid_Instances_Desc = "启用此将使法术通报在团队副本中作用。"

L["Enable in Tol Barad"] = "启用于托巴拉德"
L.Enable_In_Tol_Barad_Desc = "启用此将于托拉巴德中使用法术通报。"

L["Enable in the World"] = "启用于世界环境"
L.Enable_In_The_World_Desc = "启用此将于正常世界中使用法术通报，也就是说在任何情况下未列出的所有其他选项。"

L["Enable in PvP"] = "启用于PVP"
L.Enable_In_PvP_Desc = "启用此将在PvP状态时使用法术通报，无论身在何处。将隐藏PVP区域的具体位置选项。"

L["Enable in Scenarios"] = "启用于事件中"
L.Enable_In_Scenarios_Desc = "启用此将于事件副本中使用法术通报。"

L["Enable in LFG"] = "启用于随机副本中"
L.Enable_In_LFG_Desc = "启用此将于随机副本中使用法术通报。"


-- MAIN OPTIONS PANEL-->>LIB SINK OUTPUT
L["Local Message Output Area"] = "本地讯息输出区域"
L.Local_Message_Output_Area_Desc = "当法术设定为“本地”时他们的讯息将被发送到下列其中一个地方，在这里你可以自己选择。"


-- MAIN OPTIONS PANEL-->>GENERAL ANNOUNCEMENTS
L["General Announcements"] = "一般通报"
L.General_Announcements_Desc = "在这里可以配置非职业性的通报。例如种族技能、公会技能（如群体复活），或其他事情（如放置吉福斯）。"

L["Racial: "] = "种族："
L["Leader: "] = "领队："
L["Personal: "] = "个人："


-- BUFF REMINDERS OPTIONS PANEL-->>GENERAL LOCALISATIONS
L["Reminder Options"] = "增益提醒选项"
L.Reminder_Options = "提醒您某些增益失效的选项。"
L.Disabled_Reminder_Options = "|cffFF0000此模组已关闭|r，欲启用请在主选项视窗勾选“|cff00CCFF启用增益提醒模组|r”。"
L.Spell_To_Check = "欲检查的法术名称："
L.Spell_To_Check_Desc = "输入希望提醒的法术名称。\n|cffFF0000警告：|r如果你输入的法术名称不正确将无法作用。"
L["Disable in PvP"] = "于pvp中禁用" -- To Be Removed and replaced with the earlier "Enable in PvP". I need to rework the Reminders module a little first though. ####
L["Turns off the spell reminders while you have PvP active."] = "当你在PVP状态时关闭法术提醒" -- Will need to be changed soon also. ####
L.Enable_In_Spec1 = "于主天赋启用"
L.Enable_In_Spec1_Desc = "启用主天赋时提醒您失效的增益。"
L.Enable_In_Spec2 = "于副天赋启用"
L.Enable_In_Spec2_Desc = "启用副天赋时提醒您失效的增益。"
L["Remind Interval"] = "提醒间隔"
L.Remind_Interval_Desc = "提醒增益失效的频率"
L["Announce In"] = "通报选项"
L["Chat Window"] = "聊天视窗" -- REMOVE. Buff Reminders will use LibSink soon, this will be redundant. ####
L["Sends reminders to your default chat window."] = "通报讯息发送至预设聊天视窗" -- This too. ####
L["Raid Warning Frame"] = "团队警告" -- And this. ####
L["Sends reminders to your Raid Warning frame at the center of the screen."] = "通报讯息发送至萤幕中央的团队警告框" -- And also this. ####


-- SPELL OPTIONS PANEL-->>GENERAL LOCALISATIONS
L["Spell Options"] = "法术选项"
L.Spell_Options = "设置个人法术选项，从右侧的下拉选单选择要设置的法术。"

L["Hostile Only"] = "仅敌对的"
L.Hostile_Only_Desc = "仅在目标敌对时通报。"


-- SPELL OPTIONS PANEL-->>CHANNEL OPTIONS
L["Local"] = "本地"
L.Local_Desc = "勾选时，通报讯息将发送至所选择的区域，设置于主选项面板中的“本地讯息输出区域”。\n此选项并无按照全区选项的设置，发送通报时将忽略这些设置。"

L["Whisper"] = "悄悄话"
L.Whisper_Desc = "发送密语至法术目标。\n此选项并无按照全区选项的设置，发送通报时将忽略这些设置。"

L["Custom Channel"] = "自订频道"
L.Custom_Channel_Desc = "讯息发送至玩家自订频道，例如“公会补师频道”\n在全区选项中的设置将决定是否仅用于组队时。"

L["Channel Name"] = "频道名称"
L.Channel_Name_Desc = "输入欲发送讯息的频道，请|cffFF0000仅|r用玩家自订且已存在的频道。例如“队伍”频道将|cffFF0000不会|r作用。"

L["Raid"] = "团队"
L.Raid_Desc = "如果在团队中，讯息将通报于团队频道。战场或竞技场中将不会发挥作用。"

L["Party"] = "队伍"
L.Party_Desc = "如果在[团队/队伍]中，讯息将通报于队伍频道。战场中将不会发挥作用。"

L["Smart Group"] = "智能团体"
L.Smart_Group_Desc = "如果在团队中讯息将通报至团队，若在队伍中则通报至队伍。若是在战场或竞技场中，讯息也将发送至战场频道。"

L["Say"] = "说"
L.Say_Desc = "讯息通报在说频。\n全区选项中的设置将会判别群体中是否通报。"

L.Yell = true
L.Yell_Desc = "Announces to the Yell channel."


-- SPELL OPTIONS PANEL-->>MESSAGE OPTIONS
L["Message Settings"] = "讯息设置"
L.Message_Settings_Desc = "此处可以设置法术通报的自订讯息，空白将禁用此通报。讯息中可使用下列参数以提供动态讯息：\n|cFFFF75B3%%|r 一个 % 符号。\n|cFFFF75B3[SPELL]|r 法术名称。\n|cFFFF75B3[LINK]|r 法术连结。"
L.MST = "\n|cFFFF75B3[TARGET]|r 目标名称。"
L.MSA = "\n|cFFFF75B3[AMOUNT]|r 治疗/伤害的数值。"
L.MSM = "\n|cFFFF75B3[MISSTYPE]|r 抵抗类型。"
L.MSI = "\n|cFFFF75B3[TARSPELL]|r 被中断的法术名称。\n|cFFFF75B3[TARLINK]|r 被中断的法术连结。"
L.MSB = "\n|cFFFF75B3[AURA]|r 可移除的增(减)益法术名称。\n|cFFFF75B3[AURALINK]|r 可移除的增(减)益法术连结。"
L.MSS = "\n|cFFFF75B3[STAGGER]|r for a clickable spell link of the stagger.\n|cFFFF75B3[AMOUNT]|r 移除的伤害数值。"

-- SPELL OPTIONS PANEL-->>MISCELLANEOUS TRANSLATIONS
L["Dispel"] = "驱散"

-- Amount minimums
L["Minimum"] = "最小值"
L.MinimumNeeded = "需通报的最小数值。"

-- Grounding Totem Descriptions
L["Destroyed by damage"] = "受到伤害摧毁"
L.DestroyedByDamage = "当图腾受到伤害而摧毁时通报。"

L["Destroyed by other effects"] = "受到其他效果摧毁"
L.DestroyedByOther = "当图腾被其他非伤害性效果摧毁时通报，如" .. GetSpellInfo(118) .. "。"


-- Load on Demand Descriptions
L.OptionsDisabled = "模组已停用，请启用。"
L.OptionsMissing = "模组无法找到，请删除RSA资料夹，并重新下载安装。"
L.OptionsClass = "假如你想使用此职业的RSA，请启用此模组。"

-- Option Titles
L["Enabling Options"] = "启用选项" -- ####
L["End"] = "结束"
L["Help!"] = "求救！"
L["Reminder Spell"] = "法术提醒"
L["Resisted"] = "抵抗"
L["Start"] = "开始"
L["Successful"] = "成功"
L["Heal"] = "治疗"
L["Upon Placement"] = "已经放置"
L["When Tripped"] = "开始放置"
L["Interrupt"] = "中断"
L["Aura Applied"] = "光环已作用"
L["Stolen Charges"] = "额外消耗"
-- Option Descriptions -- THESE THAT FOLLOW WILL LIKELY BE CHANGED, DO NOT BOTHER TRANSLATING.
L.DescSpellStartSuccess = "法术成功施放时发送此讯息。"
L.DescTrapPlacement = "陷阱开始放置时发送此讯息。"
L.DescTrapTripped = "陷阱已经放置时发送此讯息。"
L.DescSpellStartCastingMessage = "法术开始施放，或相关的增(减)益开始作用时发送此讯息。"
L.DescSpellEndCastingMessage = "法术结束施放，或相关的增(减)益已经移除时发送此讯息。"
L.DescSpellEndResist = "法术抵抗时发送此讯息。"
L.DescSpellEndImmune = "法术免疫时发送此讯息。"
L.DescSpellProcName = "法术触发时发送此讯息。"
L.DescLightwellRenewStolen = "当某人多次快速点取光束泉而消耗额外使用次数时通报。"
-- Onload Messages
L.alpha_message = "|cffFF0000警告：|r 你正在使用Alpha版本的RSA，可能无法实现所有预期的功能！"
L.updated_message = "|cffFF0000警告：|r RSA内的一些选项已被更改。"
