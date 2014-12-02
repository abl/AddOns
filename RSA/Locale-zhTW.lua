local L = LibStub("AceLocale-3.0"):NewLocale("RSA", "zhTW")
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
L["Global Options"] = "全區選項"
L.Global_Options_Desc = "在這裡您可以配置一些常規設置的RSA，這將影響您所有的通告。"

L["About"] = "關於"
L.About_Desc = "歡迎使用RSA！如果您有使用上的問題，請給我一個Curse評論於：|cff33ff99http://wow.curse.com/downloads/wow-addons/details/rsa.aspx|r。如果你發現一個bug，或者有功能上的要求，請在Curse給我一個ticket留言於：|cff33ff99http://wow.curseforge.com/addons/rsa/tickets/|r。"

L["Module Settings"] = "模組設置"
L.Module_Settings_Desc = "" -- None for now.

L["Enable Buff Reminder Module"] = "啟用增益提醒模組"
L.Buff_Reminders_Desc = "當你有一個buff失效時這個模組將給你提醒。"

L["Announcement Options"] = "通報選項"
L.Announcement_Options_Desc = "這些選項影響所有法術，懸停在選項上以看到完整作用的描述。"

L["Smart Say"] = "智能說"
L.Smart_Say_Desc = "啟用此將會讓你通報選擇的法術在說頻（|cffFF0000只有|r當你在群體中）。"

L["Smart Custom Channel"] = "智能自訂頻道"
L.Smart_Custom_Channel_Desc = "啟用此將會讓你通報選擇的法術在自訂頻道（|cffFF0000只有|r當你在群體中）。"

L["Enable Only In Combat"] = "僅在戰鬥中啟用"
L.Enable_Only_In_Combat_Desc = "啟用此將使法術通報只在戰鬥中作用。"

L["Enable in Arenas"] = "啟用於競技場"
L.Enable_In_Arenas_Desc = "啟用此將允許法術在競技場時通報。"

L["Enable in Battlegrounds"] = "啟用於戰場"
L.Enable_In_Battlegrounds_Desc = "啟用此將允許法術在戰場中通報。"

L["Enable in Dungeons"] = "啟用於副本"
L.Enable_In_Dungeons_Desc = "啟用此將使法術通報在5人普通/英雄副本時作用。"

L["Enable in Raid Instances"] = "啟用於團隊副本"
L.Enable_In_Raid_Instances_Desc = "啟用此將使法術通報在團隊副本中作用。"

L["Enable in Tol Barad"] = "啟用於托巴拉德"
L.Enable_In_Tol_Barad_Desc = "啟用此將於托拉巴德中使用法術通報。"

L["Enable in the World"] = "啟用於世界環境"
L.Enable_In_The_World_Desc = "啟用此將於正常世界中使用法術通報，也就是說在任何情況下未列出的所有其他選項。"

L["Enable in PvP"] = "啟用於PVP"
L.Enable_In_PvP_Desc = "啟用此將在PvP狀態時使用法術通報，無論身在何處。將隱藏PVP區域的具體位置選項。"

L["Enable in Scenarios"] = "啟用於事件中"
L.Enable_In_Scenarios_Desc = "啟用此將於事件副本中使用法術通報。"

L["Enable in LFG"] = "啟用於隨機副本中"
L.Enable_In_LFG_Desc = "啟用此將於隨機副本中使用法術通報。"


-- MAIN OPTIONS PANEL-->>LIB SINK OUTPUT
L["Local Message Output Area"] = "本地訊息輸出區域"
L.Local_Message_Output_Area_Desc = "當法術設定為“本地”時他們的訊息將被發送到下列其中一個地方，在這裡你可以自己選擇。"


-- MAIN OPTIONS PANEL-->>GENERAL ANNOUNCEMENTS
L["General Announcements"] = "一般通報"
L.General_Announcements_Desc = "在這裡可以配置非職業性的通報。例如種族技能、公會技能（如群體復活），或其他事情（如放置吉福斯）。"

L["Racial: "] = "種族："
L["Leader: "] = "領隊："
L["Personal: "] = "個人："


-- BUFF REMINDERS OPTIONS PANEL-->>GENERAL LOCALISATIONS
L["Reminder Options"] = "增益提醒選項"
L.Reminder_Options = "提醒您某些增益失效的選項。"
L.Disabled_Reminder_Options = "|cffFF0000此模組已關閉|r，欲啟用請在主選項視窗勾選“|cff00CCFF啟用增益提醒模組|r”。"
L.Spell_To_Check = "欲檢查的法術名稱："
L.Spell_To_Check_Desc = "輸入希望提醒的法術名稱。\n|cffFF0000警告：|r如果你輸入的法術名稱不正確將無法作用。"
L["Disable in PvP"] = "於pvp中禁用" -- To Be Removed and replaced with the earlier "Enable in PvP". I need to rework the Reminders module a little first though. ####
L["Turns off the spell reminders while you have PvP active."] = "當你在PVP狀態時關閉法術提醒" -- Will need to be changed soon also. ####
L.Enable_In_Spec1 = "於主天賦啟用"
L.Enable_In_Spec1_Desc = "啟用主天賦時提醒您失效的增益。"
L.Enable_In_Spec2 = "於副天賦啟用"
L.Enable_In_Spec2_Desc = "啟用副天賦時提醒您失效的增益。"
L["Remind Interval"] = "提醒間隔"
L.Remind_Interval_Desc = "提醒增益失效的頻率"
L["Announce In"] = "通報選項"
L["Chat Window"] = "聊天視窗" -- REMOVE. Buff Reminders will use LibSink soon, this will be redundant. ####
L["Sends reminders to your default chat window."] = "通報訊息發送至預設聊天視窗" -- This too. ####
L["Raid Warning Frame"] = "團隊警告" -- And this. ####
L["Sends reminders to your Raid Warning frame at the center of the screen."] = "通報訊息發送至螢幕中央的團隊警告框" -- And also this. ####


-- SPELL OPTIONS PANEL-->>GENERAL LOCALISATIONS
L["Spell Options"] = "法術選項"
L.Spell_Options = "設置個人法術選項，從右側的下拉選單選擇要設置的法術。"

L["Hostile Only"] = "僅敵對的"
L.Hostile_Only_Desc = "僅在目標敵對時通報。"


-- SPELL OPTIONS PANEL-->>CHANNEL OPTIONS
L["Local"] = "本地"
L.Local_Desc = "勾選時，通報訊息將發送至所選擇的區域，設置於主選項面板中的“本地訊息輸出區域”。\n此選項並無按照全區選項的設置，發送通報時將忽略這些設置。"

L["Whisper"] = "悄悄話"
L.Whisper_Desc = "發送密語至法術目標。\n此選項並無按照全區選項的設置，發送通報時將忽略這些設置。"

L["Custom Channel"] = "自訂頻道"
L.Custom_Channel_Desc = "訊息發送至玩家自訂頻道，例如“公會補師頻道”\n在全區選項中的設置將決定是否僅用於組隊時。"

L["Channel Name"] = "頻道名稱"
L.Channel_Name_Desc = "輸入欲發送訊息的頻道，請|cffFF0000僅|r用玩家自訂且已存在的頻道。例如“隊伍”頻道將|cffFF0000不會|r作用。"

L["Raid"] = "團隊"
L.Raid_Desc = "如果在團隊中，訊息將通報於團隊頻道。戰場或競技場中將不會發揮作用。"

L["Party"] = "隊伍"
L.Party_Desc = "如果在[團隊/隊伍]中，訊息將通報於隊伍頻道。戰場中將不會發揮作用。"

L["Smart Group"] = "智能團體"
L.Smart_Group_Desc = "如果在團隊中訊息將通報至團隊，若在隊伍中則通報至隊伍。若是在戰場或競技場中，訊息也將發送至戰場頻道。"

L["Say"] = "說"
L.Say_Desc = "訊息通報在說頻。\n全區選項中的設置將會判別群體中是否通報。"

L.Yell = true
L.Yell_Desc = "Announces to the Yell channel."


-- SPELL OPTIONS PANEL-->>MESSAGE OPTIONS
L["Message Settings"] = "訊息設置"
L.Message_Settings_Desc = "此處可以設置法術通報的自訂訊息，空白將禁用此通報。訊息中可使用下列參數以提供動態訊息：\n|cFFFF75B3%%|r 一個 % 符號。\n|cFFFF75B3[SPELL]|r 法術名稱。\n|cFFFF75B3[LINK]|r 法術連結。"
L.MST = "\n|cFFFF75B3[TARGET]|r 目標名稱。"
L.MSA = "\n|cFFFF75B3[AMOUNT]|r 治療/傷害的數值。"
L.MSM = "\n|cFFFF75B3[MISSTYPE]|r 抵抗類型。"
L.MSI = "\n|cFFFF75B3[TARSPELL]|r 被中斷的法術名稱。\n|cFFFF75B3[TARLINK]|r 被中斷的法術連結。"
L.MSB = "\n|cFFFF75B3[AURA]|r 可移除的增(減)益法術名稱。\n|cFFFF75B3[AURALINK]|r 可移除的增(減)益法術連結。"
L.MSS = "\n|cFFFF75B3[STAGGER]|r for a clickable spell link of the stagger.\n|cFFFF75B3[AMOUNT]|r 移除的傷害數值。"

-- SPELL OPTIONS PANEL-->>MISCELLANEOUS TRANSLATIONS
L["Dispel"] = "驅散"

-- Amount minimums
L["Minimum"] = "最小值"
L.MinimumNeeded = "需通報的最小數值。"

-- Grounding Totem Descriptions
L["Destroyed by damage"] = "受到傷害摧毀"
L.DestroyedByDamage = "當圖騰受到傷害而摧毀時通報。"

L["Destroyed by other effects"] = "受到其他效果摧毀"
L.DestroyedByOther = "當圖騰被其他非傷害性效果摧毀時通報，如" .. GetSpellInfo(118) .. "。"


-- Load on Demand Descriptions
L.OptionsDisabled = "模組已停用，請啟用。"
L.OptionsMissing = "模組無法找到，請刪除RSA資料夾，並重新下載安裝。"
L.OptionsClass = "假如你想使用此職業的RSA，請啟用此模組。"

-- Option Titles
L["Enabling Options"] = "啟用選項" -- ####
L["End"] = "結束"
L["Help!"] = "求救！"
L["Reminder Spell"] = "法術提醒"
L["Resisted"] = "抵抗"
L["Start"] = "開始"
L["Successful"] = "成功"
L["Heal"] = "治療"
L["Upon Placement"] = "已經放置"
L["When Tripped"] = "開始放置"
L["Interrupt"] = "中斷"
L["Aura Applied"] = "光環已作用"
L["Stolen Charges"] = "額外消耗"
-- Option Descriptions -- THESE THAT FOLLOW WILL LIKELY BE CHANGED, DO NOT BOTHER TRANSLATING.
L.DescSpellStartSuccess = "法術成功施放時發送此訊息。"
L.DescTrapPlacement = "陷阱開始放置時發送此訊息。"
L.DescTrapTripped = "陷阱已經放置時發送此訊息。"
L.DescSpellStartCastingMessage = "法術開始施放，或相關的增(減)益開始作用時發送此訊息。"
L.DescSpellEndCastingMessage = "法術結束施放，或相關的增(減)益已經移除時發送此訊息。"
L.DescSpellEndResist = "法術抵抗時發送此訊息。"
L.DescSpellEndImmune = "法術免疫時發送此訊息。"
L.DescSpellProcName = "法術觸發時發送此訊息。"
L.DescLightwellRenewStolen = "當某人多次快速點取光束泉而消耗額外使用次數時通報。"
-- Onload Messages
L.alpha_message = "|cffFF0000警告：|r 你正在使用Alpha版本的RSA，可能無法實現所有預期的功能！"
L.updated_message = "|cffFF0000警告：|r RSA內的一些選項已被更改。"
