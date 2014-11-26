--[[	*** DataStore_Agenda ***
Written by : Thaoky, EU-Marécages de Zangar
April 2nd, 2011
--]]

if not DataStore then return end

local addonName = "DataStore_Agenda"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0", "AceSerializer-3.0", "AceTimer-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"

local AddonDB_Defaults = {
	global = {
		Options = {
			WeeklyResetDay = nil,		-- weekday (0 = Sunday, 6 = Saturday)
			WeeklyResetHour = nil,		-- 0 to 23
			NextWeeklyReset = nil,
		},
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"]
				lastUpdate = nil,
				Calendar = {},
				Contacts = {},
				DungeonIDs = {},		-- raid timers
				ItemCooldowns = {},	-- mysterious egg, disgusting jar, etc..
				LFGDungeons = {},		-- info about LFG dungeons/raids
								
				Notes = {},
				Tasks = {},
				Mail = {},			-- This is for intenal mail only, unrelated to wow's
			}
		}
	}
}

-- *** Utility functions ***
local function GetOption(option)
	return addon.db.global.Options[option]
end

local function SetOption(option, value)
	addon.db.global.Options[option] = value
end

-- *** Scanning functions ***
local function ScanContacts()
	local contacts = addon.ThisCharacter.Contacts

	local oldValues = {}

	-- if a known contact disconnected, preserve the info we know about him
	for name, info in pairs(contacts) do
		if type(info) == "table" then		-- contacts were only saved as strings in earlier versions,  make sure they're not taken into account
			if info.level then
				oldValues[name] = {}
				oldValues[name].level = info.level
				oldValues[name].class = info.class
			end
		end
	end

	wipe(contacts)

	for i = 1, GetNumFriends() do	-- only friends, not real id, as they're always visible
	   local name, level, class, zone, isOnline, note = GetFriendInfo(i);

		if name then
			contacts[name] = contacts[name] or {}
			contacts[name].note = note

			if isOnline then	-- level, class, zone will be ok
				contacts[name].level = level
				contacts[name].class = class
			elseif oldValues[name] then	-- did we save information earlier about this contact ?
				contacts[name].level = oldValues[name].level
				contacts[name].class = oldValues[name].class
			end
		end
	end

	addon.ThisCharacter.lastUpdate = time()
end

local function ScanDungeonIDs()
	local dungeons = addon.ThisCharacter.DungeonIDs
	wipe(dungeons)

	for i = 1, GetNumSavedInstances() do
		local instanceName, instanceID, instanceReset, difficulty, _, extended, _, isRaid, maxPlayers, difficultyName = GetSavedInstanceInfo(i)

		if instanceReset > 0 then		-- in 3.2, instances with reset = 0 are also listed (to support raid extensions)
			extended = extended and 1 or 0
			isRaid = isRaid and 1 or 0

			if difficulty > 1 then
				instanceName = format("%s %s", instanceName, difficultyName)
			end

			local key = instanceName.. "|" .. instanceID
			dungeons[key] = format("%s|%s|%s|%s", instanceReset, time(), extended, isRaid )
		end
	end
end

local function ScanLFGDungeon(dungeonID)
   -- name, typeId, subTypeID, 
	-- minLvl, maxLvl, recLvl, minRecLvl, maxRecLvl, 
	-- expansionId, groupId, textureName, difficulty, 
	-- maxPlayers, dungeonDesc, isHoliday  = GetLFGDungeonInfo(dungeonID)
   
	local dungeonName, typeID, subTypeID, _, _, _, _, _, expansionID, _, _, difficulty = GetLFGDungeonInfo(dungeonID)
	
	-- unknown ? exit
	if not dungeonName then return end
	
	-- type 1 = instance, 2 = raid. We don't want the rest
	if typeID > 2 then return end
		
	-- difficulty levels we don't need
	--	0 = invalid (pvp 10v10 rated bg has this)
	-- 1 = normal (no lock)
	-- 8 = challenge
	-- 12 = normal mode scenario
	if (difficulty < 2) or (difficulty == 8) or (difficulty == 12) then return end

	-- how many did we kill in that instance ?
	local numEncounters, numCompleted = GetLFGDungeonNumEncounters(dungeonID)
	if not numCompleted or numCompleted == 0 then return end		-- no kills ? exit
	
	local dungeons = addon.ThisCharacter.LFGDungeons
	local count = 0
	local key
	
	for i = 1, numEncounters do
		local bossName, _, isKilled = GetLFGDungeonEncounterInfo(dungeonID, i)

		key = format("%s.%s", dungeonID, bossName)
		if isKilled then
			dungeons[key] = true
			count = count + 1
		else
			dungeons[key] = nil
		end
	end

	-- save how many we have killed in that dungeon
	if count > 0 then
		dungeons[format("%s.Count", dungeonID)] = count
	end
end

local function ScanLFGDungeons()
	local dungeons = addon.ThisCharacter.LFGDungeons
	wipe(dungeons)
	
	for i = 1, 1000 do
		ScanLFGDungeon(i)
	end
end

local function ScanCalendar()
	-- Save the current month
	local currentMonth, currentYear = CalendarGetMonth()
	local _, thisMonth, thisDay, thisYear = CalendarGetDate()
	CalendarSetAbsMonth(thisMonth, thisYear)

	local calendar = addon.ThisCharacter.Calendar
	wipe(calendar)

	local today = date("%Y-%m-%d")
	local now = date("%H:%M")

	-- Save this month (from today) + 6 following months
	for monthOffset = 0, 6 do
		local month, year, numDays = CalendarGetMonth(monthOffset)
		local startDay = (monthOffset == 0) and thisDay or 1

		for day = startDay, numDays do
			for i = 1, CalendarGetNumDayEvents(monthOffset, day) do		-- number of events that day ..
				-- http://www.wowwiki.com/API_CalendarGetDayEvent
				local title, hour, minute, calendarType, _, eventType, _, _, inviteStatus = CalendarGetDayEvent(monthOffset, day, i)
				if calendarType ~= "HOLIDAY" and calendarType ~= "RAID_LOCKOUT"
					and calendarType ~= "RAID_RESET" and inviteStatus ~= CALENDAR_INVITESTATUS_INVITED
					and inviteStatus ~= CALENDAR_INVITESTATUS_DECLINED then
					-- don't save holiday events, they're the same for all chars, and would be redundant..who wants to see 10 fishing contests every sundays ? =)

					local eventDate = format("%04d-%02d-%02d", year, month, day)
					local eventTime = format("%02d:%02d", hour, minute)

					-- Only add events older than "now"
					if eventDate > today or (eventDate == today and eventTime > now) then
						table.insert(calendar, format("%s|%s|%s|%d|%d", eventDate, eventTime, title, eventType, inviteStatus ))
					end
				end
			end
		end
	end

	-- Restore current month
	CalendarSetAbsMonth(currentMonth, currentYear)

	addon:SendMessage("DATASTORE_CALENDAR_SCANNED")
end

-- *** Event Handlers ***
local function OnPlayerAlive()
	ScanContacts()
end

local function OnFriendListUpdate()
	ScanContacts()
end

local function OnUpdateInstanceInfo()
	ScanDungeonIDs()
end

local function OnRaidInstanceWelcome()
	RequestRaidInfo()
end

local function OnLFGUpdateRandomInfo()
	ScanLFGDungeons()
end

-- local function OnLFGLockInfoReceived()
	-- DEFAULT_CHAT_FRAME:AddMessage("LFG_LOCK_INFO_RECEIVED")
-- end

local function OnEncounterEnd(event, dungeonID, name, difficulty, raidSize, endStatus)
	ScanLFGDungeon(dungeonID)
end

local function OnChatMsgSystem(event, arg)
	if arg then
		if tostring(arg) == INSTANCE_SAVED then
			RequestRaidInfo()
		end
	end
end

local function OnCalendarUpdateEventList()
	-- The Calendar addon is LoD, and most functions return nil if the calendar is not loaded, so unless the CalendarFrame is valid, exit right away
	if not CalendarFrame then return end

	-- prevent CalendarSetAbsMonth from triggering a scan (= avoid infinite loop)
	addon:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	ScanCalendar()
	addon:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST", OnCalendarUpdateEventList)
end

local trackedItems = {
	[39878] = 259200, -- Mysterious Egg, 3 days
	[44717] = 259200, -- Disgusting Jar, 3 days
}

local lootMsg = gsub(LOOT_ITEM_SELF, "%%s", "(.+)")

local function OnChatMsgLoot(event, arg)
	local _, _, link = strfind(arg, lootMsg)
	if not link then return end

	local id = tonumber(link:match("item:(%d+)"))
	id = tonumber(id)
	if not id then return end

	for itemID, duration in pairs(trackedItems) do
		if itemID == id then
			local name = GetItemInfo(itemID)
			if name then
				table.insert(addon.ThisCharacter.ItemCooldowns, format("%s|%s|%s", name, time(), duration))
				addon:SendMessage("DATASTORE_ITEM_COOLDOWN_UPDATED", itemID)
			end
		end
	end
end

-- ** Mixins **

--[[ clientServerTimeGap

	Number of seconds between client time & server time
	A positive value means that the server time is ahead of local time.
	Ex: server: 21:05, local 21.02 could lead to something like 180 (or close to it, depending on seconds)
--]]
local clientServerTimeGap

local function _GetClientServerTimeGap()
	return clientServerTimeGap or 0
end

-- * Contacts *
local function _GetContacts(character)
	return character.Contacts

	--[[	Typical usage:

		for name, _ in pairs(DataStore:GetContacts(character) do
			myvar1, myvar2, .. = DataStore:GetContactInfo(character, name)
		end
	--]]
end

local function _GetContactInfo(character, key)
	local contact = character.Contacts[key]
	if type(contact) == "table" then
		return contact.level, contact.class, contact.note
	end
end

-- * Dungeon IDs *
local function _GetSavedInstances(character)
	return character.DungeonIDs

	--[[	Typical usage:

		for dungeonKey, _ in pairs(DataStore:GetSavedInstances(character) do
			myvar1, myvar2, .. = DataStore:GetSavedInstanceInfo(character, dungeonKey)
		end
	--]]
end

local function _GetSavedInstanceInfo(character, key)
	local instanceInfo = character.DungeonIDs[key]
	if not instanceInfo then return end

	local hasExpired
	local reset, lastCheck, isExtended, isRaid = strsplit("|", instanceInfo)

	return tonumber(reset), tonumber(lastCheck), (isExtended == "1") and true or nil, (isRaid == "1") and true or nil
end

local function _HasSavedInstanceExpired(character, key)
	local reset, lastCheck = _GetSavedInstanceInfo(character, key)
	if not reset or not lastCheck then return end

	local hasExpired
	local expiresIn = reset - (time() - lastCheck)

	if expiresIn <= 0 then	-- has expired
		hasExpired = true
	end

	return hasExpired, expiresIn
end

local function _DeleteSavedInstance(character, key)
	character.DungeonIDs[key] = nil
end

-- * LFG Dungeons *
local function _IsBossAlreadyLooted(character, dungeonID, boss)
	local key = format("%s.%s", dungeonID, boss)
	return character.LFGDungeons[key]
end

local function _GetLFGDungeonKillCount(character, dungeonID)
	local key = format("%s.Count", dungeonID)
	return character.LFGDungeons[key] or 0
end

-- * Calendar *
local function _GetNumCalendarEvents(character)
	return #character.Calendar
end

local function _GetCalendarEventInfo(character, index)
	local event = character.Calendar[index]
	if event then
		return strsplit("|", event)		-- eventDate, eventTime, title, eventType, inviteStatus
	end
end

local function _HasCalendarEventExpired(character, index)
	local eventDate, eventTime = _GetCalendarEventInfo(character, index)
	if eventDate and eventTime then
		local today = date("%Y-%m-%d")
		local now = date("%H:%M")

		if eventDate < today or (eventDate == today and eventTime <= now) then
			return true
		end
	end
end

local function _DeleteCalendarEvent(character, index)
	table.remove(character.Calendar, index)
end

-- * Item Cooldowns *
local function _GetNumItemCooldowns(character)
	return character.ItemCooldowns and #character.ItemCooldowns or 0
end

local function _GetItemCooldownInfo(character, index)
	local item = character.ItemCooldowns[index]
	if item then
		local name, lastCheck, duration = strsplit("|", item)
		return name, tonumber(lastCheck), tonumber(duration)
	end
end

local function _HasItemCooldownExpired(character, index)
	local _, lastCheck, duration = _GetItemCooldownInfo(character, index)

	local expires = duration + lastCheck + _GetClientServerTimeGap()
	if (expires - time()) <= 0 then
		return true
	end
end

local function _DeleteItemCooldown(character, index)
	table.remove(character.ItemCooldowns, index)
end

local timerHandle
local timeTable = {}	-- to pass as an argument to time()	see http://lua-users.org/wiki/OsLibraryTutorial for details
local lastServerMinute

local function SetClientServerTimeGap()
	-- this function is called every second until the server time changes (track minutes only)
	local ServerHour, ServerMinute = GetGameTime()

	if not lastServerMinute then		-- ServerMinute not set ? this is the first pass, save it
		lastServerMinute = ServerMinute
		return
	end

	if lastServerMinute == ServerMinute then return end	-- minute hasn't changed yet, exit

	-- next minute ? do our stuff and stop
	addon:CancelTimer(timerHandle)

	lastServerMinute = nil	-- won't be needed anymore
	timerHandle = nil

	local _, ServerMonth, ServerDay, ServerYear = CalendarGetDate()
	timeTable.year = ServerYear
	timeTable.month = ServerMonth
	timeTable.day = ServerDay
	timeTable.hour = ServerHour
	timeTable.min = ServerMinute
	timeTable.sec = 0					-- minute just changed, so second is 0

	-- our goal is achieved, we can calculate the difference between server time and local time, in seconds.
	clientServerTimeGap = difftime(time(timeTable), time())

	addon:SendMessage("DATASTORE_CS_TIMEGAP_FOUND", clientServerTimeGap)
end

local function GetWeeklyResetDayByRegion(region)
	local day = 2		-- default to US, 2 = Tuesday
	
	if region then
		if region == "EU" then 
			day = 3 
		elseif region == "CN" or region == "KR" or region == "TW" then
			day = 4
		end
	end
	
	return day
end

local function GetNextWeeklyReset(weeklyResetDay)
	local year = tonumber(date("%Y"))
	local month = tonumber(date("%m"))
	local day = tonumber(date("%d"))
	local todaysWeekDay = tonumber(date("%w"))
	local numDays = 0		-- number of days to add
	
	-- how many days should we add to today's date ?
	if todaysWeekDay < weeklyResetDay then					-- if it is Monday (1), and reset is on Wednesday (3)
		numDays = weeklyResetDay - todaysWeekDay		-- .. then we add 2 days
	elseif todaysWeekDay > weeklyResetDay then			-- if it is Friday (5), and reset is on Wednesday (3)
		numDays = weeklyResetDay - todaysWeekDay + 7	-- .. then we add 5 days (3 - 5 + 7)
	else
		-- Same day : if the weekly reset period has passed, add 7 days, if not yet, than 0 days
		numDays = (tonumber(date("%H")) > GetOption("WeeklyResetHour")) and 7 or 0
	end

	if numDays == 0 then return end
	
	local newDay = day + numDays	-- 25th + 2 days = 27, or 28th + 10 days = 38 days (used to check days overflow in a month)

	local daysPerMonth = { 31,28,31,30,31,30,31,31,30,31,30,31 }
	if (year % 4 == 0) and (year % 100 ~= 0 or year % 400 == 0) then	-- is leap year ?
		daysPerMonth[2] = 29
	end	
	
	-- no overflow ? (25th + 2 days = 27, we stay in the same month)
	if newDay <= daysPerMonth[month] then
		return format("%04d-%02d-%02d", year, month, newDay)
	end
	
	-- we have a "day" overflow, but still in the same year
	if month <= 11 then
		-- 27/03 + 10 days = 37 - 31 days in March, so 6/04
		return format("%04d-%02d-%02d", year, month+1, newDay - daysPerMonth[month])
	end
	
	-- at this point, we had a day overflow in December, so jump to next year
	return format("%04d-%02d-%02d", year+1, 1, newDay - daysPerMonth[month])
end

local function ClearExpiredDungeons()
	-- WeeklyResetDay = nil,		-- weekday (0 = Sunday, 6 = Saturday)
	-- WeeklyResetHour = nil,		-- 0 to 23
	-- NextWeeklyReset = nil,
	
	local weeklyResetDay = GetOption("WeeklyResetDay")
	
	if not weeklyResetDay then			-- if the weekly reset day has not been set yet ..
		weeklyResetDay = GetWeeklyResetDayByRegion(GetCVar("portal"))
		
		SetOption("WeeklyResetDay", weeklyResetDay)
		SetOption("WeeklyResetHour", 6)			-- 6 am should be ok in most zones
		SetOption("NextWeeklyReset", GetNextWeeklyReset(weeklyResetDay))
		return	-- initial pass, nothing to clear
	end
	
	local today = date("%Y-%m-%d")
	local nextReset = GetOption("NextWeeklyReset")

	if (today < nextReset) then return end		-- not yet ? exit
	if (today == nextReset) and (tonumber(date("%H")) < GetOption("WeeklyResetHour")) then return end
	
	-- at this point, we may reset
	for key, character in pairs(addon.db.global.Characters) do
		wipe(character.LFGDungeons)
	end
	
	-- finally, set the next reset day
	SetOption("NextWeeklyReset", GetNextWeeklyReset(weeklyResetDay))
end

local PublicMethods = {
	GetClientServerTimeGap = _GetClientServerTimeGap,
	GetNumContacts = _GetNumContacts,
	GetContactInfo = _GetContactInfo,

	GetSavedInstances = _GetSavedInstances,
	GetSavedInstanceInfo = _GetSavedInstanceInfo,
	HasSavedInstanceExpired = _HasSavedInstanceExpired,
	DeleteSavedInstance = _DeleteSavedInstance,

	IsBossAlreadyLooted = _IsBossAlreadyLooted,
	GetLFGDungeonKillCount = _GetLFGDungeonKillCount,
	
	GetNumCalendarEvents = _GetNumCalendarEvents,
	GetCalendarEventInfo = _GetCalendarEventInfo,
	HasCalendarEventExpired = _HasCalendarEventExpired,
	DeleteCalendarEvent = _DeleteCalendarEvent,

	GetNumItemCooldowns = _GetNumItemCooldowns,
	GetItemCooldownInfo = _GetItemCooldownInfo,
	HasItemCooldownExpired = _HasItemCooldownExpired,
	DeleteItemCooldown = _DeleteItemCooldown,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetNumContacts")
	DataStore:SetCharacterBasedMethod("GetContactInfo")

	DataStore:SetCharacterBasedMethod("GetSavedInstances")
	DataStore:SetCharacterBasedMethod("GetSavedInstanceInfo")
	DataStore:SetCharacterBasedMethod("HasSavedInstanceExpired")
	DataStore:SetCharacterBasedMethod("DeleteSavedInstance")
	DataStore:SetCharacterBasedMethod("IsBossAlreadyLooted")
	DataStore:SetCharacterBasedMethod("GetLFGDungeonKillCount")

	DataStore:SetCharacterBasedMethod("GetNumCalendarEvents")
	DataStore:SetCharacterBasedMethod("GetCalendarEventInfo")
	DataStore:SetCharacterBasedMethod("HasCalendarEventExpired")
	DataStore:SetCharacterBasedMethod("DeleteCalendarEvent")

	DataStore:SetCharacterBasedMethod("GetNumItemCooldowns")
	DataStore:SetCharacterBasedMethod("GetItemCooldownInfo")
	DataStore:SetCharacterBasedMethod("HasItemCooldownExpired")
	DataStore:SetCharacterBasedMethod("DeleteItemCooldown")
end

function addon:OnEnable()
	-- Contacts
	addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
	addon:RegisterEvent("FRIENDLIST_UPDATE", OnFriendListUpdate)

	-- Dungeon IDs
	addon:RegisterEvent("UPDATE_INSTANCE_INFO", OnUpdateInstanceInfo)
	addon:RegisterEvent("RAID_INSTANCE_WELCOME", OnRaidInstanceWelcome)
	addon:RegisterEvent("LFG_UPDATE_RANDOM_INFO", OnLFGUpdateRandomInfo)
	-- addon:RegisterEvent("LFG_LOCK_INFO_RECEIVED", OnLFGLockInfoReceived)
	addon:RegisterEvent("ENCOUNTER_END", OnEncounterEnd)
		
	addon:RegisterEvent("CHAT_MSG_SYSTEM", OnChatMsgSystem)

	ClearExpiredDungeons()
	
	-- Calendar (only register after setting the current month)
	local _, thisMonth, _, thisYear = CalendarGetDate()
	CalendarSetAbsMonth(thisMonth, thisYear)
	addon:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST", OnCalendarUpdateEventList)

	-- Item Cooldowns
	addon:RegisterEvent("CHAT_MSG_LOOT", OnChatMsgLoot)

	timerHandle = addon:ScheduleRepeatingTimer(SetClientServerTimeGap, 1)
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("FRIENDLIST_UPDATE")
	addon:UnregisterEvent("UPDATE_INSTANCE_INFO")
	addon:UnregisterEvent("RAID_INSTANCE_WELCOME")
	addon:UnregisterEvent("CHAT_MSG_SYSTEM")
	addon:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")
end
