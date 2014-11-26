--[[	*** DataStore_Reputations ***
Written by : Thaoky, EU-Marécages de Zangar
June 22st, 2009
--]]
if not DataStore then return end

local addonName = "DataStore_Reputations"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

local addon = _G[addonName]


local THIS_ACCOUNT = "Default"

local AddonDB_Defaults = {
	global = {
		Reference = {
			UIDsRev = {},		-- ex: Reverse lookup of Faction UIDs, now in the database since opposite faction is no longer provided by the API
		},
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				guildName = nil,		-- nil = not in a guild, as returned by GetGuildInfo("player")
				guildRep = nil,
				Factions = {},
			}
		}
	}
}

-- ** Reference tables **
local BottomLevelNames = {
	[-42000] = FACTION_STANDING_LABEL1,	 -- "Hated"
	[-6000] = FACTION_STANDING_LABEL2,	 -- "Hostile"
	[-3000] = FACTION_STANDING_LABEL3,	 -- "Unfriendly"
	[0] = FACTION_STANDING_LABEL4,		 -- "Neutral"
	[3000] = FACTION_STANDING_LABEL5,	 -- "Friendly"
	[9000] = FACTION_STANDING_LABEL6,	 -- "Honored"
	[21000] = FACTION_STANDING_LABEL7,	 -- "Revered"
	[42000] = FACTION_STANDING_LABEL8,	 -- "Exalted"
}

local BottomLevels = { -42000, -6000, -3000, 0, 3000, 9000, 21000, 42000 }

local BF = LibStub("LibBabble-Faction-3.0"):GetUnstrictLookupTable()

--[[	*** Faction UIDs ***
These UIDs have 2 purposes: 
- avoid saving numerous copies of the same string (the faction name)
- minimize the amount of data sent across the network when sharing accounts (since both sides have the same reference table)

Note: Let the system manage the ids, DO NOT delete entries from this table, if a faction is removed from the game, mark it as OLD_ or whatever.
--]]

-- Since WoD, GetFactionInfoByID does not return a value when an alliance player asks for an horde function, so at least default to an english text


local factions = {
	{ id = 69, name = BF["Darnassus"] },
	{ id = 930, name = BF["Exodar"] },
	{ id = 54, name = BF["Gnomeregan"] },
	{ id = 47, name = BF["Ironforge"] },
	{ id = 72, name = BF["Stormwind"] },
	{ id = 530, name = BF["Darkspear Trolls"] },
	{ id = 76, name = BF["Orgrimmar"] },
	{ id = 81, name = BF["Thunder Bluff"] },
	{ id = 68, name = BF["Undercity"] },
	{ id = 911, name = BF["Silvermoon City"] },
	{ id = 509, name = BF["The League of Arathor"] },
	{ id = 890, name = BF["Silverwing Sentinels"] },
	{ id = 730, name = BF["Stormpike Guard"] },
	{ id = 510, name = BF["The Defilers"] },
	{ id = 889, name = BF["Warsong Outriders"] },
	{ id = 729, name = BF["Frostwolf Clan"] },
	{ id = 21, name = BF["Booty Bay"] },
	{ id = 577, name = BF["Everlook"] },
	{ id = 369, name = BF["Gadgetzan"] },
	{ id = 470, name = BF["Ratchet"] },
	{ id = 529, name = BF["Argent Dawn"] },
	{ id = 87, name = BF["Bloodsail Buccaneers"] },
	{ id = 910, name = BF["Brood of Nozdormu"] },
	{ id = 609, name = BF["Cenarion Circle"] },
	{ id = 909, name = BF["Darkmoon Faire"] },
	{ id = 92, name = BF["Gelkis Clan Centaur"] },
	{ id = 749, name = BF["Hydraxian Waterlords"] },
	{ id = 93, name = BF["Magram Clan Centaur"] },
	{ id = 349, name = BF["Ravenholdt"] },
	{ id = 809, name = BF["Shen'dralar"] },
	{ id = 70, name = BF["Syndicate"] },
	{ id = 59, name = BF["Thorium Brotherhood"] },
	{ id = 576, name = BF["Timbermaw Hold"] },
	{ id = 922, name = BF["Tranquillien"] },
	{ id = 589, name = BF["Wintersaber Trainers"] },
	{ id = 270, name = BF["Zandalar Tribe"] },
	{ id = 1012, name = BF["Ashtongue Deathsworn"] },
	{ id = 942, name = BF["Cenarion Expedition"] },
	{ id = 933, name = BF["The Consortium"] },
	{ id = 946, name = BF["Honor Hold"] },
	{ id = 978, name = BF["Kurenai"] },
	{ id = 941, name = BF["The Mag'har"] },
	{ id = 1015, name = BF["Netherwing"] },
	{ id = 1038, name = BF["Ogri'la"] },
	{ id = 970, name = BF["Sporeggar"] },
	{ id = 947, name = BF["Thrallmar"] },
	{ id = 1011, name = BF["Lower City"] },
	{ id = 1031, name = BF["Sha'tari Skyguard"] },
	{ id = 1077, name = BF["Shattered Sun Offensive"] },
	{ id = 932, name = BF["The Aldor"] },
	{ id = 934, name = BF["The Scryers"] },
	{ id = 935, name = BF["The Sha'tar"] },
	{ id = 989, name = BF["Keepers of Time"] },
	{ id = 990, name = BF["The Scale of the Sands"] },
	{ id = 967, name = BF["The Violet Eye"] },
	{ id = 1106, name = BF["Argent Crusade"] },
	{ id = 1090, name = BF["Kirin Tor"] },
	{ id = 1073, name = BF["The Kalu'ak"] },
	{ id = 1091, name = BF["The Wyrmrest Accord"] },
	{ id = 1098, name = BF["Knights of the Ebon Blade"] },
	{ id = 1119, name = BF["The Sons of Hodir"] },
	{ id = 1156, name = BF["The Ashen Verdict"] },
	{ id = 1037, name = BF["Alliance Vanguard"] },
	{ id = 1068, name = BF["Explorers' League"] },
	{ id = 1126, name = BF["The Frostborn"] },
	{ id = 1094, name = BF["The Silver Covenant"] },
	{ id = 1050, name = BF["Valiance Expedition"] },
	{ id = 1052, name = BF["Horde Expedition"] },
	{ id = 1067, name = BF["The Hand of Vengeance"] },
	{ id = 1124, name = BF["The Sunreavers"] },
	{ id = 1064, name = BF["The Taunka"] },
	{ id = 1085, name = BF["Warsong Offensive"] },
	{ id = 1104, name = BF["Frenzyheart Tribe"] },
	{ id = 1105, name = BF["The Oracles"] },
	{ id = 469, name = BF["Alliance"] },
	{ id = 67, name = BF["Horde"] },
	{ id = 1134, name = BF["Gilneas"] },
	{ id = 1133, name = BF["Bilgewater Cartel"] },

	-- cataclysm
	{ id = 1158, name = BF["Guardians of Hyjal"] },
	{ id = 1135, name = BF["The Earthen Ring"] },
	{ id = 1171, name = BF["Therazane"] },
	{ id = 1174, name = BF["Wildhammer Clan"] },
	{ id = 1173, name = BF["Ramkahen"] },
	{ id = 1177, name = BF["Baradin's Wardens"] },
	{ id = 1172, name = BF["Dragonmaw Clan"] },
	{ id = 1178, name = BF["Hellscream's Reach"] },
	{ id = 1204, name = BF["Avengers of Hyjal"] },

	-- Mists of Pandaria
	{ id = 1277, name = BF["Chee Chee"] },
	{ id = 1275, name = BF["Ella"] },
	{ id = 1283, name = BF["Farmer Fung"] },
	{ id = 1282, name = BF["Fish Fellreed"] },
	{ id = 1228, name = BF["Forest Hozen"] },
	{ id = 1281, name = BF["Gina Mudclaw"] },
	{ id = 1269, name = BF["Golden Lotus"] },
	{ id = 1279, name = BF["Haohan Mudclaw"] },
	{ id = 1273, name = BF["Jogu the Drunk"] },
	{ id = 1358, name = BF["Nat Pagle"] },
	{ id = 1276, name = BF["Old Hillpaw"] },
	{ id = 1271, name = BF["Order of the Cloud Serpent"] },
	{ id = 1242, name = BF["Pearlfin Jinyu"] },
	{ id = 1270, name = BF["Shado-Pan"] },
	{ id = 1216, name = BF["Shang Xi's Academy"] },
	{ id = 1278, name = BF["Sho"] },
	{ id = 1302, name = BF["The Anglers"] },
	{ id = 1341, name = BF["The August Celestials"] },
	{ id = 1359, name = BF["The Black Prince"] },
	{ id = 1351, name = BF["The Brewmasters"] },
	{ id = 1337, name = BF["The Klaxxi"] },
	{ id = 1345, name = BF["The Lorewalkers"] },
	{ id = 1272, name = BF["The Tillers"] },
	{ id = 1280, name = BF["Tina Mudclaw"] },
	{ id = 1353, name = BF["Tushui Pandaren"] },
	{ id = 1352, name = BF["Huojin Pandaren"] },

	{ id = 1376, name = BF["Operation: Shieldwall"] },
	{ id = 1387, name = BF["Kirin Tor Offensive"] },
	{}, -- was "Akama's Trust", keep this index empty
	{ id = 1375, name = BF["Dominance Offensive"] },
	{ id = 1388, name = BF["Sunreaver Onslaught"] },
	{ id = 1435, name = BF["Shado-Pan Assault"] },
	{ id = 1440, name = BF["Darkspear Rebellion"] },
	{ id = 1492, name = GetFactionInfoByID(1492) },		-- BF["Emperor Shaohao"]
	
	-- Warlords of Draenor
	{ id = 1515, name = GetFactionInfoByID(1515) },		-- Arrakoa Outcasts
	{ id = 1731, name = GetFactionInfoByID(1731) },		-- Council of Exarchs
	{ id = 1445, name = GetFactionInfoByID(1445) },		-- Frostwold Orcs
	{ id = 1710, name = GetFactionInfoByID(1710) },		-- Sha'tari Defense
	{ id = 1711, name = GetFactionInfoByID(1711) },		-- Steamwheedle Preservation Society
	{ id = 1682, name = GetFactionInfoByID(1682) },		-- Wrynn's Vanguard
	{ id = 1708, name = GetFactionInfoByID(1708) },		-- Laughing Skull Orcs
	{ id = 1681, name = GetFactionInfoByID(1681) },		-- Vol'jin's Spear
}

local FactionUIDsRev = {}
local FactionIdToName = {}

for k, v in pairs(factions) do
	if v.id and v.name then
		FactionIdToName[v.id] = v.name
		FactionUIDsRev[v.name] = k	-- ex : [BZ["Darnassus"]] = 1
	end
end

-- *** Utility functions ***

local headersState = {}
local inactive = {}

local function SaveHeaders()
	local headerCount = 0		-- use a counter to avoid being bound to header names, which might not be unique.
	
	for i = GetNumFactions(), 1, -1 do		-- 1st pass, expand all categories
		local name, _, _, _, _, _, _,	_, isHeader, isCollapsed = GetFactionInfo(i)
		if isHeader then
			headerCount = headerCount + 1
			if isCollapsed then
				ExpandFactionHeader(i)
				headersState[headerCount] = true
			end
		end
	end
	
	-- code disabled until I can find the other addon that conflicts with this and slows down the machine.
	
	-- If a header faction, like alliance or horde, has all child factions set to inactive, it will not be visible, so activate it, and deactivate it after the scan (thanks Zaphon for this)
	-- for i = GetNumFactions(), 1, -1 do
		-- if IsFactionInactive(i) then
			-- local name = GetFactionInfo(i)
			-- inactive[name] = true
			-- SetFactionActive(i)
		-- end
	-- end
end

local function RestoreHeaders()
	local headerCount = 0
	for i = GetNumFactions(), 1, -1 do
		local name, _, _, _, _, _, _,	_, isHeader = GetFactionInfo(i)
		
		-- if inactive[name] then
			-- SetFactionInactive(i)
		-- end
		
		if isHeader then
			headerCount = headerCount + 1
			if headersState[headerCount] then
				CollapseFactionHeader(i)
			end
		end
	end
	wipe(headersState)
end

local function GetLimits(earned)
	-- return the bottom & top values of a given rep level based on the amount of earned rep
	local top = 43000
	local index = #BottomLevels
	
	while (earned < BottomLevels[index]) do
		top = BottomLevels[index]
		index = index - 1
	end
	
	return BottomLevels[index], top
end

local function GetEarnedRep(character, faction)
	local earned 
	if character.guildName and faction == character.guildName then
		return character.guildRep
	end
	return character.Factions[FactionUIDsRev[faction]]
end

-- *** Scanning functions ***
local currentGuildName

local function ScanReputations()
	SaveHeaders()
	local f = addon.ThisCharacter.Factions
	wipe(f)
	
	for i = 1, GetNumFactions() do		-- 2nd pass, data collection
		local name, _, _, _, _, earned = GetFactionInfo(i)
		if (earned and earned > 0) then		-- new in 3.0.2, headers may have rep, ex: alliance vanguard + horde expedition
			if FactionUIDsRev[name] then		-- is this a faction we're tracking ?
				f[FactionUIDsRev[name]] = earned
			end
		end
	end

	RestoreHeaders()
	addon.ThisCharacter.lastUpdate = time()
end

local function ScanGuildReputation()
	SaveHeaders()
	for i = 1, GetNumFactions() do		-- 2nd pass, data collection
		local name, _, _, _, _, earned = GetFactionInfo(i)
		if name and name == currentGuildName then
			addon.ThisCharacter.guildRep = earned
		end
	end
	RestoreHeaders()
end

-- *** Event Handlers ***
local function OnPlayerAlive()
	ScanReputations()
end

local function OnPlayerGuildUpdate()
	-- at login this event is called between OnEnable and PLAYER_ALIVE, where GetGuildInfo returns a wrong value
	-- however, the value returned here is correct
	if IsInGuild() and not currentGuildName then		-- the event may be triggered multiple times, and GetGuildInfo may return incoherent values in subsequent calls, so only save if we have no value.
		currentGuildName = GetGuildInfo("player")
		if currentGuildName then	
			addon.ThisCharacter.guildName = currentGuildName
			ScanGuildReputation()
		end
	end
end

local function OnFactionChange(event, messageType, faction, amount)
	if messageType ~= "FACTION" then return end
	
	if faction == GUILD then
		ScanGuildReputation()
		return
	end
	
	local bottom, top, earned = DataStore:GetRawReputationInfo(DataStore:GetCharacter(), faction)
	if not earned then 	-- faction not in the db, scan all
		ScanReputations()	
		return 
	end
	
	local newValue = earned + amount
	if newValue >= top then	-- rep status increases (to revered, etc..)
		ScanReputations()					-- so scan all
	else
		addon.ThisCharacter.Factions[FactionUIDsRev[faction]] = newValue
		addon.ThisCharacter.lastUpdate = time()
	end
end


-- ** Mixins **
local function _GetReputationInfo(character, faction)
	local earned = GetEarnedRep(character, faction)
	if not earned then return end

	local bottom, top = GetLimits(earned)
	local rate = (earned - bottom) / (top - bottom) * 100

	-- ex: "Revered", 15400, 21000, 73%
	return BottomLevelNames[bottom], (earned - bottom), (top - bottom), rate 
end

local function _GetRawReputationInfo(character, faction)
	-- same as GetReputationInfo, but returns raw values
	
	local earned = GetEarnedRep(character, faction)
	if not earned then return end

	local bottom, top = GetLimits(earned)
	return bottom, top, earned
end

local function _GetReputations(character)
	return character.Factions
end

local function _GetGuildReputation(character)
	return character.guildRep or 0
end

local function _GetReputationLevels()
	return BottomLevels
end

local function _GetReputationLevelText(bottom)
	return BottomLevelNames[bottom]
end

local function _GetFactionName(id)
	return FactionIdToName[id]
end

local PublicMethods = {
	GetReputationInfo = _GetReputationInfo,
	GetRawReputationInfo = _GetRawReputationInfo,
	GetReputations = _GetReputations,
	GetGuildReputation = _GetGuildReputation,
	GetReputationLevels = _GetReputationLevels,
	GetReputationLevelText = _GetReputationLevelText,
	GetFactionName = _GetFactionName,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetReputationInfo")
	DataStore:SetCharacterBasedMethod("GetRawReputationInfo")
	DataStore:SetCharacterBasedMethod("GetReputations")
	DataStore:SetCharacterBasedMethod("GetGuildReputation")
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
	addon:RegisterEvent("COMBAT_TEXT_UPDATE", OnFactionChange)
	addon:RegisterEvent("PLAYER_GUILD_UPDATE", OnPlayerGuildUpdate)				-- for gkick, gquit, etc..
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("COMBAT_TEXT_UPDATE")
	addon:UnregisterEvent("PLAYER_GUILD_UPDATE")
end

-- *** Utility functions ***
local PT = LibStub("LibPeriodicTable-3.1")

function addon:GetSource(searchedID)
	-- returns the faction where a given item ID can be obtained, as well as the level
	local level, repData = PT:ItemInSet(searchedID, "Reputation.Reward")
	if level and repData then
		local _, _, faction = strsplit(".", repData)		-- ex: "Reputation.Reward.Sporeggar"
	
		-- level = 7,  29150:7 where 7 means revered
		return faction, _G["FACTION_STANDING_LABEL"..level]
	end
end
