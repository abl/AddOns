--[[	*** DataStore_Quests ***
Written by : Thaoky, EU-Marécages de Zangar
July 8th, 2009
--]]

if not DataStore then return end

local addonName = "DataStore_Quests"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"

local AddonDB_Defaults = {
	global = {
		Options = {
			TrackTurnIns = 1,					-- by default, save the ids of completed quests in the history
			AutoUpdateHistory = 1,			-- if history has been queried at least once, auto update it at logon (fast operation - already in the game's cache)
		},
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"]
				lastUpdate = nil,
				Quests = {},
				QuestLinks = {},
				Rewards = {},
				Dailies = {},
				History = {},		-- a list of completed quests, hash table ( [questID] = true )
				HistoryBuild = nil,	-- build version under which the history has been saved
				HistorySize = 0,
				HistoryLastUpdate = nil,
			}
		}
	}
}

-- *** Utility functions ***
local bAnd = bit.band
local bOr = bit.bor

local function GetOption(option)
	return addon.db.global.Options[option]
end

local function GetQuestLogIndexByName(name)
	-- helper function taken from QuestGuru
	for i = 1, GetNumQuestLogEntries() do
		local title = GetQuestLogTitle(i);
		if title == strtrim(name) then
			return i
		end
	end
end

local function TestBit(value, pos)
   local mask = 2^pos
   if bAnd(value, mask) == mask then
      return true
   end
end

local function ClearExpiredDailies()
	-- this function will clear all the dailies from the day(s) before (or same day, but before the reset hour)

	local timeTable = {}

	timeTable.year = date("%Y")
	timeTable.month = date("%m")
	timeTable.day = date("%d")
	timeTable.hour = 3
	timeTable.min = 0

	local now = time()
	local resetTime = time(timeTable)

	-- gap is positive if reset time was earlier in the day (ex: it is now 9am, reset was at 3am) => simply make sure that:
	--		the elapsed time since the quest was turned in is bigger than  (ex: 10 hours ago)
	--		the elapsed time since the last reset (ex: 6 hours ago)

	-- gap is negative if reset time is later on the same day (ex: it is 1am, reset is at 3am)
	--		the elapsed time since the quest was turned in is bigger than
	--		the elapsed time since the last reset 1 day before

	local gap = now - resetTime
	gap = (gap < 0) and (86400 + gap) or gap	-- ex: it's 1am, next reset is in 2 hours, so previous reset was (24 + (-2)) = 22 hours ago

	for characterKey, character in pairs(addon.Characters) do
		-- browse dailies history backwards, to avoid messing up the indexes when removing
		for i = #character.Dailies, 1, -1 do

			if (now - character.Dailies[i].timestamp) > gap then
				table.remove(character.Dailies, i)
			end
		end
	end
end

-- *** Scanning functions ***
local headersState = {}

local function SaveHeaders()
	local headerCount = 0		-- use a counter to avoid being bound to header names, which might not be unique.

	for i = GetNumQuestLogEntries(), 1, -1 do		-- 1st pass, expand all categories
		local _, _, _, _, isHeader, isCollapsed = GetQuestLogTitle(i)
		if isHeader then
			headerCount = headerCount + 1
			if isCollapsed then
				ExpandQuestHeader(i)
				headersState[headerCount] = true
			end
		end
	end
end

local function RestoreHeaders()
	local headerCount = 0
	for i = GetNumQuestLogEntries(), 1, -1 do
		local _, _, _, _, isHeader = GetQuestLogTitle(i)
		if isHeader then
			headerCount = headerCount + 1
			if headersState[headerCount] then
				CollapseQuestHeader(i)
			end
		end
	end
	wipe(headersState)
end

local REWARD_TYPE_CHOICE = "c"
local REWARD_TYPE_REWARD = "r"
local REWARD_TYPE_SPELL = "s"

local function ScanQuests()
	local char = addon.ThisCharacter
	local quests = char.Quests
	local links = char.QuestLinks
	local rewards = char.Rewards

	wipe(quests)
	wipe(links)
	wipe(rewards)

	local currentSelection = GetQuestLogSelection()		-- save the currently selected quest
	SaveHeaders()

	local RewardsCache = {}
	
	local numEntries, numQuests = GetNumQuestLogEntries()
	
	for i = 1, GetNumQuestLogEntries() do
		local title, _, groupSize, isHeader, _, isComplete, isDaily = GetQuestLogTitle(i);

		if isHeader then
			quests[i] = "0|" .. (title or "")
		else
			SelectQuestLogEntry(i)
			local money = GetQuestLogRewardMoney()
			quests[i] = format("1|%d|%d|%d", groupSize, money, isComplete or 0)
			links[i] = GetQuestLink(i)

			wipe(RewardsCache)
			local num = GetNumQuestLogChoices()		-- these are the actual item choices proposed to the player
			if num > 0 then
				for i = 1, num do
					local _, _, numItems, _, isUsable = GetQuestLogChoiceInfo(i)
					isUsable = isUsable and 1 or 0	-- this was 1 or 0, in WoD, it is a boolean, convert back to 0 or 1
					local link = GetQuestLogItemLink("choice", i)
					if link then
						local id = tonumber(link:match("item:(%d+)"))
						if id then
							table.insert(RewardsCache, REWARD_TYPE_CHOICE .."|"..id.."|"..numItems.."|"..isUsable)
						end
					end
				end
			end

			num = GetNumQuestLogRewards()				-- these are the rewards given anyway
			if num > 0 then
				for i = 1, num do
					local _, _, numItems, _, isUsable = GetQuestLogRewardInfo(i)
					isUsable = isUsable and 1 or 0	-- this was 1 or 0, in WoD, it is a boolean, convert back to 0 or 1
					local link = GetQuestLogItemLink("reward", i)
					if link then
						local id = tonumber(link:match("item:(%d+)"))
						if id then
							table.insert(RewardsCache, REWARD_TYPE_REWARD .. "|"..id.."|"..numItems.."|"..isUsable)
						end
					end
				end
			end

			if GetQuestLogRewardSpell() then		-- apparently, there is only one spell as reward
				local _, _, isTradeskillSpell, isSpellLearned = GetQuestLogRewardSpell()
				if isTradeskillSpell or isSpellLearned then
					local link = GetQuestLogSpellLink()
					if link then
						local id = tonumber(link:match("spell:(%d+)"))
						if id then
							table.insert(RewardsCache, REWARD_TYPE_SPELL .. "|"..id)
						end
					end
				end
			end

			if #RewardsCache > 0 then
				rewards[i] = table.concat(RewardsCache, ",")
			end
		end
	end

	RestoreHeaders()
	SelectQuestLogEntry(currentSelection)		-- restore the selection to match the cursor, must be properly set if a user abandons a quest

	addon.ThisCharacter.lastUpdate = time()
end

local queryVerbose

-- *** Event Handlers ***
local function OnPlayerAlive()
	ScanQuests()
end

local function OnQuestLogUpdate()
	addon:UnregisterEvent("QUEST_LOG_UPDATE")		-- .. and unregister it right away, since we only want it to be processed once (and it's triggered way too often otherwise)
	ScanQuests()
end

local function OnUnitQuestLogChanged()			-- triggered when accepting/validating a quest .. but too soon to refresh data
	addon:RegisterEvent("QUEST_LOG_UPDATE", OnQuestLogUpdate)		-- so register for this one ..
end

local function RefreshQuestHistory()
	local thisChar = addon.ThisCharacter
	local history = thisChar.History
	wipe(history)
	local quests = {}
	GetQuestsCompleted(quests)

	--[[	In order to save memory, we'll save the completion status of 32 quests into one number (by setting bits 0 to 31)
		Ex:
			in history[1] , we'll save quests 0 to 31		(note: questID 0 does not exist, we're losing one bit, doesn't matter :p)
			in history[2] , we'll save quests 32 to 63
			...
			index = questID / 32 (rounded up)
			bit position = questID % 32
	--]]

	local count = 0
	local index, bitPos
	for questID in pairs(quests) do
		bitPos = (questID % 32)
		index = ceil(questID / 32)

		history[index] = bOr((history[index] or 0), 2^bitPos)	-- read: value = SetBit(value, bitPosition)
		count = count + 1
	end

	local _, version = GetBuildInfo()				-- save the current build, to know if we can requery and expect immediate execution
	thisChar.HistoryBuild = version
	thisChar.HistorySize = count
	thisChar.HistoryLastUpdate = time()

	if queryVerbose then
		addon:Print("Quest history successfully retrieved!")
		queryVerbose = nil
	end
end

-- ** Mixins **
local function _GetQuestLogSize(character)
	return #character.Quests
end

local function _GetQuestLogInfo(character, index)
	local quest = character.Quests[index]
	local link = character.QuestLinks[index]
	local isHeader, groupSize, money, isComplete = strsplit("|", quest)

	if isHeader == "0" then
		return true, groupSize	-- groupSize contains the title in a header line (clean this code, it works but is not clean)
	end

	return nil, link, tonumber(groupSize), tonumber(money), tonumber(isComplete)
end

local function _GetQuestLogNumRewards(character, index)
	local reward = character.Rewards[index]
	if reward then
		return select(2, gsub(reward, ",", ",")) + 1		-- returns the number of rewards (=count of ^ +1)
	end
	return 0
end

local function _GetQuestLogRewardInfo(character, index, rewardIndex)
	local reward = character.Rewards[index]
	if not reward then return end

	local i = 1
	for v in reward:gmatch("([^,]+)") do
		if rewardIndex == i then
			local rewardType, id, numItems, isUsable = strsplit("|", v)

			numItems = tonumber(numItems) or 0
			isUsable = (isUsable and isUsable == 1) and true or nil

			return rewardType, tonumber(id), numItems, isUsable
		end
		i = i + 1
	end
end

local function _GetQuestInfo(link)
	assert(type(link) == "string")

	local questID, questLevel = link:match("quest:(%d+):(-?%d+)")
	local questName = link:match("%[(.+)%]")

	return questName, tonumber(questID), tonumber(questLevel)
end

local function _QueryQuestHistory()
	queryVerbose = true
	RefreshQuestHistory()		-- this call triggers "QUEST_QUERY_COMPLETE"
end

local function _GetQuestHistory(character)
	return character.History
end

local function _GetQuestHistoryInfo(character)
	-- return the size of the history, the timestamp, and the build under which it was saved
	return character.HistorySize, character.HistoryLastUpdate, character.HistoryBuild
end

local function _GetDailiesHistory(character)
	return character.Dailies
end

local function _GetDailiesHistorySize(character)
	return #character.Dailies
end

local function _GetDailiesHistoryInfo(character, index)
	local quest = character.Dailies[index]
	return quest.id, quest.title, quest.timestamp
end

local function _IsQuestCompletedBy(character, questID)
	local bitPos = (questID % 32)
	local index = ceil(questID / 32)

	if character.History[index] then
		return TestBit(character.History[index], bitPos)		-- nil = not completed (not in the table), true = completed
	end
end

local PublicMethods = {
	GetQuestLogSize = _GetQuestLogSize,
	GetQuestLogInfo = _GetQuestLogInfo,
	GetQuestLogNumRewards = _GetQuestLogNumRewards,
	GetQuestLogRewardInfo = _GetQuestLogRewardInfo,
	GetQuestInfo = _GetQuestInfo,
	QueryQuestHistory = _QueryQuestHistory,
	GetQuestHistory = _GetQuestHistory,
	GetQuestHistoryInfo = _GetQuestHistoryInfo,
	IsQuestCompletedBy = _IsQuestCompletedBy,
	GetDailiesHistory = _GetDailiesHistory,
	GetDailiesHistorySize = _GetDailiesHistorySize,
	GetDailiesHistoryInfo = _GetDailiesHistoryInfo,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetQuestLogSize")
	DataStore:SetCharacterBasedMethod("GetQuestLogInfo")
	DataStore:SetCharacterBasedMethod("GetQuestLogNumRewards")
	DataStore:SetCharacterBasedMethod("GetQuestLogRewardInfo")
	DataStore:SetCharacterBasedMethod("GetQuestHistory")
	DataStore:SetCharacterBasedMethod("GetQuestHistoryInfo")
	DataStore:SetCharacterBasedMethod("IsQuestCompletedBy")
	DataStore:SetCharacterBasedMethod("GetDailiesHistory")
	DataStore:SetCharacterBasedMethod("GetDailiesHistorySize")
	DataStore:SetCharacterBasedMethod("GetDailiesHistoryInfo")
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
	addon:RegisterEvent("UNIT_QUEST_LOG_CHANGED", OnUnitQuestLogChanged)

	addon:SetupOptions()

	if GetOption("AutoUpdateHistory") == 1 then		-- if history has been queried at least once, auto update it at logon (fast operation - already in the game's cache)
		addon:ScheduleTimer(RefreshQuestHistory, 5)	-- refresh quest history 5 seconds later, to decrease the load at startup
	end

	ClearExpiredDailies()
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("UNIT_QUEST_LOG_CHANGED")
	addon:UnregisterEvent("QUEST_QUERY_COMPLETE")
end

-- *** Hooks ***
-- GetQuestReward is the function that actually turns in a quest
hooksecurefunc("GetQuestReward", function(choiceIndex)
	local questID = GetQuestID() -- returns the last displayed quest dialog's questID
	if GetOption("TrackTurnIns") == 1 and questID then
		local history = addon.ThisCharacter.History
		local bitPos  = (questID % 32)
		local index   = ceil(questID / 32)

		if type(history[index]) == "boolean" then		-- temporary workaround for all players who have not cleaned their SV for 4.0
			history[index] = 0
		end

		-- mark the current quest ID as completed
		history[index] = bOr((history[index] or 0), 2^bitPos)	-- read: value = SetBit(value, bitPosition)

		-- track daily quests turn-ins
		if QuestIsDaily() then
			local dailies = addon.ThisCharacter.Dailies

			table.insert(dailies, { title = GetTitleText(), id = questID, timestamp = time() })
		end
		-- TODO: there's also QuestIsWeekly() which should probably also be tracked

		addon:SendMessage("DATASTORE_QUEST_TURNED_IN", questID)		-- trigger the DS event
	end
end)
