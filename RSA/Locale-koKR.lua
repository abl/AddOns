local L = LibStub("AceLocale-3.0"):NewLocale("RSA", "koKR")
if not L then return end

------------------------------------------------------------------------------
--- IN THE PROCESS OF REDOING THIS TO MAKE IT CLEARER TO READ AND UPDATE. ----
------------------------------------------------------------------------------
-- PRIMARY LOCALISATIONS
L["Tol Barad"] = "톨 바라드" -- a = select(32,GetMapZones(2)) Will this always return Tol Barad? It seems GetMapZones is alphabetised, maybe not the same order in other localisations?
L["Corpse of "] = "의 시체" -- Tooltip mouseover of a released corpse.


-- PRIMARY LOCALISATIONS-->>BUFF REMINDER MODULE
L[" is Missing!"] = " 사라짐!"
L[" Refreshed!"] = " 재활성됨!"


-- PRIMARY LOCALISATIONS-->>SPELL ANNOUNCEMENTS
L["You"] = "당신"
L["missed"] = "빗나감"
L["was resisted by"] = "저항함"
L["Immune"] = "면역"
L["Unknown"] = "알 수 없음"


-- MAIN OPTIONS PANEL-->>GLOBAL OPTIONS & THEIR DESCRIPTIONS
L["Global Options"] = "옵션"
L.Global_Options_Desc = "RSA에 대한 여러가지 설정을 할 수 있습니다."

L["About"] = "정보"
L.About_Desc = "환영합니다! 문제가 있을 시, 왼쪽의 도움말 탭을 이용하세요. 여전히 문제가 지속되면, Curse에 글을 확인해주세요: |cff33ff99http://wow.curse.com/downloads/wow-addons/details/rsa.aspx|r. 버그를 발견하거나 특별한 요구가 있을 땐 Curse ticket란에 올려주세요: |cff33ff99http://wow.curseforge.com/addons/rsa/tickets/|r."

L["Module Settings"] = "모듈 설정"
L.Module_Settings_Desc = "" -- None for now.

L["Enable Buff Reminder Module"] = "버프 유지 확인 모듈 사용"
L.Buff_Reminders_Desc = "이 모듈은 당신의 버프가 사라지면 알려줍니다."

L["Announcement Options"] = "알림 옵션"
L.Announcement_Options_Desc = "이 옵션들은 모든 주문에 영향을 미칩니다, 마우스를 올리면 자세한 설명을 볼 수 있습니다."

L["Smart Say"] = "스마트 대화"
L.Smart_Say_Desc = "|cffFF0000오직|r 파티 중일 때만 선택된 주문의 알림을 일반 대화로 알립니다."

L["Smart Custom Channel"] = "스마트 사설 채널"
L.Smart_Custom_Channel_Desc = "|cffFF0000오직|r 파티 중일 때만 선택된 주문의 알림을 사설 채널에 알립니다."

L["Enable Only In Combat"] = "전투 중일때만 알림"
L.Enable_Only_In_Combat_Desc = "전투 중일 때만 알리도록 설정합니다."

L["Enable in Arenas"] = "투기장에서 알림"
L.Enable_In_Arenas_Desc = "투기장에서 알리도록 설정합니다."

L["Enable in Battlegrounds"] = "전장에서 알림"
L.Enable_In_Battlegrounds_Desc = "전장에서 알리도록 설정합니다."

L["Enable in Dungeons"] = "던전에서 알림"
L.Enable_In_Dungeons_Desc = "5인 던전이나 영웅 던전에서 알리도록 설정합니다."

L["Enable in Raid Instances"] = "공격대 던전에서 알림"
L.Enable_In_Raid_Instances_Desc = "공격대 던전에서 알리도록 설정합니다."

L["Enable in Tol Barad"] = "톨 바라드에서 알림"
L.Enable_In_Tol_Barad_Desc = "톨 바라드에서 알리도록 설정합니다."

L["Enable in the World"] = "야외에서 알림"
L.Enable_In_The_World_Desc = "야외에서 알리도록 설정합니다. 어떠한 상황에서도 다른 모든 옵션이 표시되지 않습니다."

L["Enable in PvP"] = "PvP 활성화 시 알림"
L.Enable_In_PvP_Desc = "지역에 상관없이 PvP 활성화 되어있을 때 알리도록 설정합니다. 이 기능을 사용하면 PVP 지역에서 특정 옵션을 숨깁니다."

L["Enable in Scenarios"] = "시나리오에서 알림"
L.Enable_In_Scenarios_Desc = "시나리오 진행 중일 때 알리도록 설정합니다."

L["Enable in LFG"] = "무작위 던전에서 알림"
L.Enable_In_LFG_Desc = "무작위 던전에서 알리도록 설정합니다."

-- MAIN OPTIONS PANEL-->>LIB SINK OUTPUT
L["Local Message Output Area"] = "개인 메시지 출력"
L.Local_Message_Output_Area_Desc = "\"개인 알림\" 으로 설정한 주문의 알림이 표시될 장소를 설정합니다."


-- MAIN OPTIONS PANEL-->>GENERAL ANNOUNCEMENTS
L["General Announcements"] = "기본 알림"
L.General_Announcements_Desc = "비 직업 스킬에 대한 알림을 설정합니다. 종족 기술, 대규모 부활 같은 길드 혜택, 지브스 사용 같은 것들이 해당됩니다."

L["Racial: "] = "종족: "
L["Leader: "] = "리더: "
L["Personal: "] = "개인: "


-- BUFF REMINDERS OPTIONS PANEL-->>GENERAL LOCALISATIONS
L["Reminder Options"] = "유지 확인 옵션"
L.Reminder_Options = "특정 버프가 사라질 때 알림에 대하여 설정합니다."
L.Disabled_Reminder_Options = "|cffFF0000이 모듈은 비활성 상태입니다.|r 사용하려면, 메인 옵션 창에서 \"|cff00CCFF버프 유지 확인 모듈 활성|r\" 에 체크하세요."
L.Spell_To_Check = "확인하고 싶은 버프의 이름:"
L.Spell_To_Check_Desc = "확인할 주문의 이름을 입력하세요. |cffFF0000경고:|r 정확한 주문 이름을 입력하지 않으면 작동하지 않습니다."
L["Disable in PvP"] = "PvP 활성화시 사용 안함" -- To Be Removed and replaced with the earlier "Enable in PvP". I need to rework the Reminders module a little first though.
L["Turns off the spell reminders while you have PvP active."] = "PvP 활성화 되어있으면 버프 유지 확인을 끕니다." -- Will need to be changed soon also.
L.Enable_In_Spec1 = "1 특성일 때 사용"
L.Enable_In_Spec1_Desc = "1 특성일 때 버프가 사라지면 알려줍니다"
L.Enable_In_Spec2 = "2 특성일 때 사용"
L.Enable_In_Spec2_Desc = "2 특성일 때 버프가 사라지면 알려줍니다"
L["Remind Interval"] = "알림 간격"
L.Remind_Interval_Desc = "사라진 버프에 대해 알림을 표시할 시간 간격입니다."
L["Announce In"] = "표시하기"
L["Chat Window"] = "대화창" -- REMOVE. Buff Reminders will use LibSink soon, this will be redundant.
L["Sends reminders to your default chat window."] = "기본 대화창에 알림을 표시합니다." -- This too.
L["Raid Warning Frame"] = "공격대 경보 창" -- And this.
L["Sends reminders to your Raid Warning frame at the center of the screen."] = "화면 중앙의 공격대 경보 창에 알림을 표시합니다." -- And also this.


-- SPELL OPTIONS PANEL-->>GENERAL LOCALISATIONS
L["Spell Options"] = "주문 옵션"
L.Spell_Options = "개인 주문에 대해 설정합니다. 오른쪽의 드롭 다운 목록에서 주문을 선택하세요."

L["Hostile Only"] = "적대적일 때만"
L.Hostile_Only_Desc = "대상이 공격 가능할 때만 알립니다."


-- SPELL OPTIONS PANEL-->>CHANNEL OPTIONS
L["Local"] = "개인 알림"
L.Local_Desc = "메인 옵션의 \"개인 메시지 출력\"에서 선택한 곳에만 알림을 표시합니다.\n다른 알림 설정을 따르지 않고 단독적으로 동작합니다."

L["Whisper"] = "귓속말"
L.Whisper_Desc = "주문의 대상에게 귓속말 합니다.\n다른 알림 설정을 따르지 않고 단독적으로 동작합니다."

L["Custom Channel"] = "사설 채널"
L.Custom_Channel_Desc = "|cffFF0000오직|r 플레이어가 생성한 채널만 사용합니다. 예) \"길드힐러채널\"\n메인 옵션과 상관없이 파티중이거나 파티중이 아닐 때도 작동합니다."

L["Channel Name"] = "채널 이름"
L.Channel_Name_Desc = "알림을 표시할 채널 이름을 입력하세요. |cffFF0000오직|r 플레이어가 생성한 채널만 사용합니다. \"파티\"와 같이 이미 존재하는 이름을 사용하면 작동하지 |cffFF0000않습니다|r."

L["Raid"] = "공격대"
L.Raid_Desc = "공격대에 참여중일 때 공격대 채널로 알립니다. 전장이나 투기장에선 작동하지 않습니다."

L["Party"] = "파티"
L.Party_Desc = "어떤 형태의 그룹, 공격대나 파티에 참여중일 때 파티 채널로 알립니다. 전장에선 작동하지 않습니다."

L["Smart Group"] = "스마트 그룹"
L.Smart_Group_Desc = "공격대에 참여중일 땐 공격대, 파티에 참여중일 땐 파티 말로 알립니다. 전장이나 투기장에 참여중이면 전장 채널로 알림을 표시합니다."

L["Say"] = "일반대화"
L.Say_Desc = "일반 대화로 알립니다.\n메인 옵션의 영향을 받아 파티중이거나 파티중이 아닐때도 알릴 수 있습니다."

L.Yell = true
L.Yell_Desc = "Announces to the Yell channel."


-- SPELL OPTIONS PANEL-->>MESSAGE OPTIONS
L["Message Settings"] = "메시지 설정"
L.Message_Settings_Desc = "이 주문의 알림 메시지를 설정합니다. 아무것도 적지 않으면 알리지 않습니다. 여러가지 구문을 사용해 메시지를 더 다양하게 만들수 있습니다:\n|cFFFF75B3%%|r % 표시.\n|cFFFF75B3[SPELL]|r 주문의 이름.\n|cFFFF75B3[LINK]|r 클릭 가능한 주문 링크."
L.MST = "\n|cFFFF75B3[TARGET]|r 대상의 이름."
L.MSA = "\n|cFFFF75B3[AMOUNT]|r 치유/피해/획득량."
L.MSM = "\n|cFFFF75B3[MISSTYPE]|r 빗나간 유형."
L.MSI = "\n|cFFFF75B3[TARSPELL]|r 대상의 주문 이름.\n|cFFFF75B3[TARLINK]|r 클릭 가능한 대상의 주문 링크."
L.MSB = "\n|cFFFF75B3[AURA]|r 사라진 버프(디버프)의 이름.\n|cFFFF75B3[AURALINK]|r 클릭 가능한 사라진 버프(디버프)의 주문 링크."
L.MSS = "\n|cFFFF75B3[STAGGER]|r for a clickable spell link of the stagger.\n|cFFFF75B3[AMOUNT]|r for the amount of damage removed." -- Not translation yet

-- SPELL OPTIONS PANEL-->>MISCELLANEOUS TRANSLATIONS
L["Dispel"] = "마법 무효화"

-- Amount minimums
L["Minimum"] = "최소량"
L.MinimumNeeded = "알릴 최소량."

-- Grounding Totem Descriptions
L["Destroyed by damage"] = "피해에 의해 파괴됨"
L.DestroyedByDamage = "토템이 피해를 받아 파괴되면 메시지를 표시합니다."

L["Destroyed by other effects"] = "다른 효과에 의해 파괴됨"
L.DestroyedByOther = "" .. GetSpellInfo(118) .. " 같이 토템이 피해를 받지 않고 파괴되었을 때 메시지를 표시합니다."


-- Load on Demand Descriptions
L.OptionsDisabled = "모듈 비활성, 활성화 해주세요."
L.OptionsMissing = "모듈을 찾을 수 없습니다, RSA 폴더를 삭제하고 다시 다운로드 받은 후에 설치해주세요."
L.OptionsClass = " 이 직업에서 RSA를 사용하려면 모듈을 활성화 해주세요."
-- Option Titles
L["Enabling Options"] = "옵션 활성"
L["End"] = "종료"
L["Help!"] = "도움말!"
L["Reminder Spell"] = "주문 유지 확인"
L["Resisted"] = "저항함"
L["Start"] = "시작"
L["Successful"] = "성공"
L["Heal"] = "치유"
L["Upon Placement"] = "덫 설치"
L["When Tripped"] = "덫 발동"
L["Interrupt"] = "차단"
L["Aura Applied"] = "오라 활성"
L["Stolen Charges"] = "중첩 훔쳐짐"
-- Option Descriptions
L.DescSpellStartSuccess = "주문 시전 성공시 메시지 표시."
L.DescTrapPlacement = "덫을 설치하면 메시지 표시."
L.DescTrapTripped = "덫이 작동하면 메시지 표시."
L.DescSpellStartCastingMessage = "주문 시전 시작시 메시지 표시, 또는 버프(디버프) 적용시."
L.DescSpellEndCastingMessage = "주문 시전 종료시 메시지 표시, 또는 버프(디버프) 사라질 때."
L.DescSpellEndResist = "주문 저항 시 메시지 표시."
L.DescSpellEndImmune = "대상이 면역 상태일 때 메시지 표시."
L.DescSpellProcName = "주문 발동시 메시지 표시."
L.DescLightwellRenewStolen = "누군가 빛샘을 너무 빠르게 클릭하거나 중첩해서 사용할 경우 메시지 표시."
-- Onload Messages
L.alpha_message = "|cffFF0000경고:|r 알파버전의 RSA를 사용 중입니다. 제대로 작동하지 않을 수 있습니다!"
L.updated_message = "|cffFF0000경고:|r RSA의 몇가지 옵션이 변경되었습니다."
