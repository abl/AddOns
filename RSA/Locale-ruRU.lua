local L = LibStub("AceLocale-3.0"):NewLocale("RSA", "ruRU")
if not L then return end
------------------------------------------------------------------------------
--- IN THE PROCESS OF REDOING THIS TO MAKE IT CLEARER TO READ AND UPDATE. ----
------------------------------------------------------------------------------

-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- @@@@@@@@@@ Strings marked with #### should not be translated. They will be edited or deleted soon.
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

-- PRIMARY LOCALISATIONS
L["Tol Barad"] = "Тол Барад" -- a = select(32,GetMapZones(2)) Will this always return Tol Barad? It seems GetMapZones is alphabetised, maybe not the same order in other localisations?
L["Corpse of "] = "Тело " -- Tooltip mouseover of a released corpse.


-- PRIMARY LOCALISATIONS-->>BUFF REMINDER MODULE
L[" is Missing!"] = " - отсутствует!"
L[" Refreshed!"] = " - обновлено!"


-- PRIMARY LOCALISATIONS-->>SPELL ANNOUNCEMENTS
L["You"] = "Вы"
L["missed"] = "промахнулось"
L["was resisted by"] = "не подействовало"
L["Immune"] = "Невосприимчивость"
L["Unknown"] = "Неизвестно"


-- MAIN OPTIONS PANEL-->>GLOBAL OPTIONS & THEIR DESCRIPTIONS
L["Global Options"] = "Общие настройки"
L.Global_Options_Desc = "Здесь можно изменить общие параметры RSA, влияющие на все ваши оповещения."

L["About"] = "Об аддоне"
L.About_Desc = "Добро пожаловать в RSA! Если вы в испытываете сложности в использовании аддона, перейдите на вкладку \"Помощь\" слева. Если после этого у вас останутся затруднения, оставьте комментарий на сайте Curse: |cff33ff99http://wow.curse.com/downloads/wow-addons/details/rsa.aspx|r. Если вы нашли ошибку или у вас есть идеи по улучшению аддона, создайте тикет на сайте Curseforge: |cff33ff99http://wow.curseforge.com/addons/rsa/tickets/|r."

L["Module Settings"] = "Настройки модулей"
L.Module_Settings_Desc = "" -- None for now.

L["Enable Buff Reminder Module"] = "Включить модуль отслеживания баффов"
L.Buff_Reminders_Desc = "Данный модуль включает оповещения о недостающих у вас баффах."

L["Announcement Options"] = "Настройки оповещений"
L.Announcement_Options_Desc = "Данные настройки влияют на все залинания. Наведите курсор на параметр, чтобы получить его полное описание."

L["Smart Say"] = "\"Сказать\" в группе"
L.Smart_Say_Desc = "Включив данную настройку, вы будете оповещать о применении выбранных заклинаний в канал \"Сказать\" |cffFF0000только|r когда вы в группе."

L["Smart Custom Channel"] = "Пользовательский канал"
L.Smart_Custom_Channel_Desc = "Включив данную настройку, вы будете оповещать о применении выбранных заклинаний в указанный канал |cffFF0000только|r когда вы в группе."

L["Enable Only In Combat"] = "Только в бою"
L.Enable_Only_In_Combat_Desc = "Включив данную настройку, вы будете оповещать о применении выбранных заклинаний |cffFF0000только|r когда вы участвуете в бою."

L["Enable in Arenas"] = "Включить на арене"
L.Enable_In_Arenas_Desc = "Включив данную настройку, вы будете оповещать о применении выбранных заклинаний когда вы находитесь на арене."

L["Enable in Battlegrounds"] = "Включить на полях боя"
L.Enable_In_Battlegrounds_Desc = "Включив данную настройку, вы будете оповещать о применении выбранных заклинаний когда вы находитесь на поле боя."

L["Enable in Dungeons"] = "Включить в подземельях"
L.Enable_In_Dungeons_Desc = "Включив данную настройку, вы будете оповещать о применении выбранных заклинаний когда вы находитесь в подземельях для пяти человек."

L["Enable in Raid Instances"] = "Включить в рейдах"
L.Enable_In_Raid_Instances_Desc = "Включив данную настройку, вы будете оповещать о применении выбранных заклинаний когда вы находитесь в рейдовых подземельях."

L["Enable in Tol Barad"] = "Включить на Тол Бараде"
L.Enable_In_Tol_Barad_Desc = "Включив данную настройку, вы будете оповещать о применении выбранных заклинаний когда вы находитесь на Тол Бараде."

L["Enable in the World"] = "Включить в мире"
L.Enable_In_The_World_Desc = "Включив данную настройку, вы будете оповещать о применении выбранных заклинаний когда вы находитесь в обычных локациях. Другими словами, в случаях, не охваченных остальными настройками."

L["Enable in PvP"] = "Включить в PVP"
L.Enable_In_PvP_Desc = "Включив данную настройку, вы будете оповещать о применении выбранных заклинаний когда вы находитесь в режиме \"Игрок против игрока\", независимо от вашего местоположения. При активации данной настройки, будут скрыты настройки для конкретных областей PVP."

L["Enable in Scenarios"] = true
L.Enable_In_Scenarios_Desc = "Enabling this will allow you to announce while you are in a Scenario."

L["Enable in LFG"] = true
L.Enable_In_LFG_Desc = "Enabling this will allow you to announce while in a LFG dungeon or raid."

-- MAIN OPTIONS PANEL-->>LIB SINK OUTPUT
L["Local Message Output Area"] = "Локальный вывод сообщений"
L.Local_Message_Output_Area_Desc = "Заклинания, имеющие пометку \"Локально\" в настройках оповещений, будут выводить сообщения в указанную область."


-- MAIN OPTIONS PANEL-->>GENERAL ANNOUNCEMENTS
L["General Announcements"] = "Общие оповещения"
L.General_Announcements_Desc = "Здесь можно настроить неклассовые оповещения: расовые способности и гильдейские умения, например Массовое воскрешение, или другие события, такие как установка Дживса."

L["Racial: "] = "Расовые: "
L["Leader: "] = "Лидер: "
L["Personal: "] = "Личные: "


-- BUFF REMINDERS OPTIONS PANEL-->>GENERAL LOCALISATIONS
L["Reminder Options"] = "Настройки напоминаний"
L.Reminder_Options = "Настройки напоминаний о недостающих на вас баффах."
L.Disabled_Reminder_Options = "|cffFF0000Модуль отключен.|r Чтобы включить его, выберите \"|cff00CCFFВключить модуль отслеживания баффов|r\" в окне основных настроек."
L.Spell_To_Check = "Название заклинания, которое вы хотите отслеживать:"
L.Spell_To_Check_Desc = "Введите название заклинания, о котором хотите получать напоминания.\n|cffFF0000ВНИМАНИЕ:|r Если вы допустите ошибку при вводе названия заклинания, оповещения не будут работать."
L["Disable in PvP"] = "Отключить в PVP" -- To Be Removed and replaced with the earlier "Enable in PvP". I need to rework the Reminders module a little first though.
L["Turns off the spell reminders while you have PvP active."] = "Отключить отслеживание баффов, когда вы находитесь в режиме \"Игрок против Игрока\"." -- Will need to be changed soon also.
L.Enable_In_Spec1 = "Включить в первой специализации"
L.Enable_In_Spec1_Desc = "Включает отслеживание баффов, когда активен первый набор талантов."
L.Enable_In_Spec2 = "Включить во второй специализации"
L.Enable_In_Spec2_Desc = "Включает отслеживание баффов, когда активен второй набор талантов."
L["Remind Interval"] = "Интервал напоминаний"
L.Remind_Interval_Desc = "Как часто вы хотите получать напоминания о недостающих баффах."
L["Announce In"] = "Оповещать в"
L["Chat Window"] = "Окно чата" -- REMOVE. Buff Reminders will use LibSink soon, this will be redundant.
L["Sends reminders to your default chat window."] = "Посылает оповещения в стандартное окно чата." -- This too.
L["Raid Warning Frame"] = "Объявления рейду" -- And this.
L["Sends reminders to your Raid Warning frame at the center of the screen."] = "Посылает оповещения в окно предупреждений для рейда, находящееся по центру экрана." -- And also this.


-- SPELL OPTIONS PANEL-->>GENERAL LOCALISATIONS
L["Spell Options"] = "Настройки заклинаний"
L.Spell_Options = "Настройки для конкретных заклинаний. Выберите заклинание, которое хотите настроить из выпадающего списка справа."

L["Hostile Only"] = "Только враждебные"
L.Hostile_Only_Desc = "Оповещает только когда цель враждебна."


-- SPELL OPTIONS PANEL-->>CHANNEL OPTIONS
L["Local"] = "Локально"
L.Local_Desc = "Если включено, создает оповещения в выбранной вами области, настраиваемой в окне основных настроек в разделе \"Локальный вывод сообщений\".\nТакже эта настройка будет создавать оповещения независимо от глобальных настроек оповещений."

L["Whisper"] = "Шепот"
L.Whisper_Desc = "Шепнуть цели заклинания.\nЭта настройка также игнорирует глобальные настройки оповещений."

L["Custom Channel"] = "Свой канал"
L.Custom_Channel_Desc = "Эта настройка |cffFF0000ТОЛЬКО|r для каналов, созданных пользователями, например \"MyGuildHealerChannel\".\nВ общих настройках есть параметр, задающий выдачу оповещений в зависимости от нахождения в группе."

L["Channel Name"] = "Название канала"
L.Channel_Name_Desc = "Введите название канала для оповещений. Пожалуйста, используйте |cffFF0000ТОЛЬКО|r каналы, созданные пользователями. Предустановленные каналы, такие как \"Группа\" |cffFF0000НЕ БУДУТ|r работать."

L["Raid"] = "Рейд"
L.Raid_Desc = "Оповещения в канал рейда, если вы находитесь в рейде. Не влияет на оповещения на арене или полях боя."

L["Party"] = "Группа"
L.Party_Desc = "Оповещения в канал группы, если вы в группе или рейде. Не влияет на оповещения на полях боя."

L["Smart Group"] = "Умная группа"
L.Smart_Group_Desc = "Оповещает в канал рейда, если вы в рейде, или в канал группы, если вы в группе. Также будет оповещать в канал поля боя, если вы находитесь на поле боя."

L["Say"] = "Сказать"
L.Say_Desc = "Оповещать в канал \"Сказать\".\nВ общих настройках есть параметр, задающий выдачу оповещений в зависимости от нахождения в группе."

L.Yell = true
L.Yell_Desc = "Announces to the Yell channel."


-- SPELL OPTIONS PANEL-->>MESSAGE OPTIONS
L["Message Settings"] = "Настройки сообщений"
L.Message_Settings_Desc = "Здесь можно настроить сообщения, выдаваемые при применении заклинания. Чтобы отключить конкретное оповещение, оставьте строку пустой. Можете добавить следующие элементы в сообщения, чтобы сделать их более динамичными:\n|cFFFF75B3%%|r для знака %.\n|cFFFF75B3[SPELL]|r для названия заклинания.\n|cFFFF75B3[LINK]|r для ссылки на заклинание."
L.MST = "\n|cFFFF75B3[TARGET]|r для имени цели заклинания."
L.MSA = "\n|cFFFF75B3[AMOUNT]|r для количества исцеленного/полученного/нанесенного урона."
L.MSM = "\n|cFFFF75B3[MISSTYPE]|r для типа невосприимчивости."
L.MSI = "\n|cFFFF75B3[TARSPELL]|r для названия заклинания, применяемого целью.\n|cFFFF75B3[TARLINK]|r для ссылки на заклинание, применяемое целью."
L.MSB = "\n|cFFFF75B3[AURA]|r для названия снятого (де)баффа.\n|cFFFF75B3[AURALINK]|r для ссылки на снятый (де)бафф."
L.MSS = "\n|cFFFF75B3[STAGGER]|r for a clickable spell link of the stagger.\n|cFFFF75B3[AMOUNT]|r for the amount of damage removed."

-- SPELL OPTIONS PANEL-->>MISCELLANEOUS TRANSLATIONS
L["Dispel"] = "Рассеивание"

-- Amount minimums
L["Minimum"] = true
L.MinimumNeeded = "Minimum amount needed to announce."

-- Grounding Totem Descriptions
L["Destroyed by damage"] = "Уничтожен уроном"
L.DestroyedByDamage = "Сообщение выводится, когда ваш тотем уничтожен из-за полученного урона."

L["Destroyed by other effects"] = "Уничтожен другими эффектами"
L.DestroyedByOther = "Сообщение выводится, когда ваш тотем уничтожен эффектами, не наносящими урона, например " .. GetSpellInfo(118) .. "."


-- Load on Demand Descriptions
L.OptionsDisabled = "Модуль отключен. Пожалуйста, включите его."
L.OptionsMissing = "Модуль не обнаружен. Пожалуйста, удалите папки аддона RSA, скачайте и установите аддон заново."
L.OptionsClass = " Если вы планируете использовать RSA для этого класса, включите этот модуль."
-- Option Titles
L["Enabling Options"] = "Опции включения"
L["End"] = "Конец"
L["Help!"] = "Помощь"
L["Reminder Spell"] = "Напоминание о заклинании"
L["Resisted"] = "Не сработало"
L["Start"] = "Начало"
L["Successful"] = "Успешно"
L["Heal"] = "Исцеление"
L["Upon Placement"] = "При установке"
L["When Tripped"] = "Когда сработала"
L["Interrupt"] = "Прерывание"
L["Aura Applied"] = "Применение ауры"
L["Stolen Charges"] = true
-- Option Descriptions
L.DescSpellStartSuccess = "Сообщение выводится, когда заклинание успешно применено."
L.DescTrapPlacement = "Сообщение выводится, когда ваша ловушка размещена."
L.DescTrapTripped = "Сообщение выводится, когда ваша ловушка сработала."
L.DescSpellStartCastingMessage = "Сообщение выводится, когда вы начинаете применять заклинание или появляется соответствующий (де)бафф."
L.DescSpellEndCastingMessage = "Сообщение выводится, когда заклинание закончилось или соответствующий (де)бафф исчезает."
L.DescSpellEndResist = "Сообщение выводится, когда заклинание не проходит на цель."
L.DescSpellEndImmune = "Сообщение выводится, когда цель невосприимчива к заклинанию."
L.DescSpellProcName = "Сообщение выводится, когда заклинание прокает."
L.DescLightwellRenewStolen = "The message played when someone clicks the Lightwell too fast and uses up multiple charges."
-- Onload Messages
L.alpha_message = "|cffFF0000ВНИМАНИЕ:|r Вы используете альфа-версию RSA. Аддон может работать с ошибками!"
L.updated_message = "|cffFF0000ВНИМАНИЕ:|r Некоторые настройки RSA были изменены."
