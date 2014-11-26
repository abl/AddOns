local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local RED		= "|cFFFF0000"

-- *** Dungeons ***
local ICON_NOTREADY = "\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t"
local ICON_READY = "\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t"

local DIFFICULTY_DUNGEON_HEROIC = 2
local DIFFICULTY_RAID_10P = 3
local DIFFICULTY_RAID_25P = 4
local DIFFICULTY_RAID_40P = 9
local DIFFICULTY_RAID_10PH = 5
local DIFFICULTY_RAID_25PH = 6
local DIFFICULTY_RAID_LFR = 7
local DIFFICULTY_RAID_FLEX = 14
local DIFFICULTY_SCENARIO_HEROIC = 11

local Dungeons = {
	{	-- [1]
		name = EXPANSION_NAME0,	-- "Classic"
		{	-- [1] 10 player raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_10P)),
			{ id = 160, achID = 689 },	-- Ahn'Qiraj Ruins
		},
		{	-- [2] 40 player raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_40P)),
			{ id = 48, achID = 686 },	-- Molten Core
			{ id = 50, achID = 685 },	-- Blackwing Lair
			{ id = 161, achID = 687 },	-- Ahn'Qiraj Temple
		},
	},
	{	-- [2]
		name = EXPANSION_NAME1,	-- "The Burning Crusade"
		{	-- [1] heroic dungeons
			name = format("%s - %s", DUNGEONS, GetDifficultyInfo(DIFFICULTY_DUNGEON_HEROIC)),
			{ id = 178, achID = 672 },	-- Auchenai Crypts
			{ id = 179, achID = 671 },	-- Mana-Tombs
			{ id = 180, achID = 674 },	-- Sethekk Halls
			{ id = 181, achID = 675 },	-- Shadow Labyrinth
			{ id = 182, achID = 676 },	-- Opening of the Dark Portal
			{ id = 183, achID = 673 },	-- The Escape From Durnholde
			{ id = 184, achID = 669 },	-- Slave Pens
			{ id = 185, achID = 677 },	-- The Steamvault
			{ id = 186, achID = 670 },	-- Underbog
			{ id = 187, achID = 668 },	-- Blood Furnace
			{ id = 188, achID = 667 },	-- Hellfire Ramparts
			{ id = 189, achID = 678 },	-- Shattered Halls
			{ id = 190, achID = 681 },	-- The Arcatraz
			{ id = 191, achID = 680 },	-- The Botanica
			{ id = 192, achID = 679 },	-- The Mechanar
			{ id = 201, achID = 682 },	-- Magisters' Terrace
		},
		{	-- [2] 10 player raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_10P)),
			{ id = 175, achID = 690 },	-- Karazhan
		},
		{	-- [3] 25 player raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_25P)),
			{ id = 176, achID = 693 },	-- Magtheridon's Lair
			{ id = 177, achID = 692 },	-- Gruul's Lair
			{ id = 193, achID = 696 },	-- Tempest Keep
			{ id = 194, achID = 694 },	-- Serpentshrine Cavern
			{ id = 195, achID = 695 },	-- Hyjal Past
			{ id = 196, achID = 697 },	-- Black Temple
			{ id = 199, achID = 698 },	-- The Sunwell
		},
	},
	{	-- [3]
		name = EXPANSION_NAME2,	-- "Wrath of the Lich King"
		{	-- [1] heroic dungeons
			name = format("%s - %s", DUNGEONS, GetDifficultyInfo(DIFFICULTY_DUNGEON_HEROIC)),
			{ id = 205, achID = 499 },	--	Utgarde Pinnacle
			{ id = 210, achID = 500 },	--	The Culling of Stratholme
			{ id = 211, achID = 498 },	--	The Oculus
			{ id = 212, achID = 497 },	--	Halls of Lightning
			{ id = 213, achID = 496 },	--	Halls of Stone
			{ id = 215, achID = 493 },	--	Drak'Tharon Keep
			{ id = 217, achID = 495 },	--	Gundrak
			{ id = 219, achID = 492 },	--	Ahn'kahet: The Old Kingdom
			{ id = 221, achID = 494 },	--	Violet Hold
			{ id = 226, achID = 490 },	--	The Nexus
			{ id = 241, achID = 491 },	--	Azjol-Nerub
			{ id = 242, achID = 489 },	--	Utgarde Keep
			{ id = 249, achID = 4298 },	--	Trial of the Champion
			{ id = 252, achID = 4519 },	--	The Forge of Souls
			{ id = 254, achID = 4520 },	--	Pit of Saron
			{ id = 256, achID = 4521 },	--	Halls of Reflection
		},
		{	-- [2] 10 player raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_10P)),
			{ id = 46 , achID = 4396 },	--	Onyxia's Lair
			{ id = 159, achID = 576 },	--	Naxxramas
			{ id = 223, achID = 622 },	--	The Eye of Eternity
			{ id = 224, achID = 1876 },	--	The Obsidian Sanctum
			{ id = 239, achID = 4016 },	--	Vault of Archavon
			{ id = 243, achID = 2894 },	--	Ulduar
			{ id = 246, achID = 3917 },	--	Trial of the Crusader
			{ id = 279, achID = 4530 },	--	Icecrown Citadel
			{ id = 293, achID = 4817 },	--	Ruby Sanctum
		},
		{	-- [3] 25 player raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_25P)),
			{ id = 227, achID = 577 },	--	Naxxramas
			{ id = 237, achID = 623 },	--	The Eye of Eternity
			{ id = 238, achID = 625 },	--	The Obsidian Sanctum
			{ id = 240, achID = 4017 },	--	Vault of Archavon
			{ id = 244, achID = 2895 },	--	Ulduar
			{ id = 248, achID = 3916 },	--	Trial of the Crusader
			{ id = 257, achID = 4397 },	--	Onyxia's Lair
			{ id = 280, achID = 4597 },	--	Icecrown Citadel
			{ id = 294, achID = 4815 },	--	Ruby Sanctum
		},		
		{	-- [4] 10 player heroic raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_10PH)),
			{ id = 247, achID = 3918 },	--	Trial of the Grand Crusader
		},
		{	-- [5] 25 player heroic raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_25PH)),
			{ id = 250, achID = 3812 },	--	Trial of the Grand Crusader
		},
	},
	{	-- [4]
		name = EXPANSION_NAME3,	-- "Cataclysm"
		{	-- [1] heroic dungeons
			name = format("%s - %s", DUNGEONS, GetDifficultyInfo(DIFFICULTY_DUNGEON_HEROIC)),
			{ id = 319, achID = 5064 },	--	The Vortex Pinnacle
			{ id = 320, achID = 5063 },	--	The Stonecore
			{ id = 321, achID = 5065 },	--	Halls of Origination
			{ id = 322, achID = 5062 },	--	Grim Batol
			{ id = 323, achID = 5060 },	--	Blackrock Caverns
			{ id = 324, achID = 5061 },	--	Throne of the Tides
			{ id = 325, achID = 5066 },	--	Lost City of the Tol'vir
			{ id = 326, achID = 5083 },	--	Deadmines
			{ id = 327, achID = 5093 },	--	Shadowfang Keep
			{ id = 334, achID = 5768 },	--	Zul'Gurub
			{ id = 340, achID = 5769 },	--	Zul'Aman
			{ id = 435, achID = 6117 },	--	End Time
			{ id = 437, achID = 6118 },	--	Well of Eternity
			{ id = 439, achID = 6119 },	--	Hour of Twilight
		},
		{	-- [2] LFR Raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_LFR)),
			{ id = 416, achID = 6107, bosses = 4 },	--	The Siege of Wyrmrest Temple
			{ id = 417, achID = 6107, bosses = 4 },	--	Fall of Deathwing
		},
		{	-- [3] 10 player raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_10P)),
			{ id = 313, achID = 4842 },	--	Blackwing Descent
			{ id = 315, achID = 4850 },	--	The Bastion of Twilight
			{ id = 317, achID = 4851 },	--	Throne of the Four Winds
			{ id = 328, achID = 5425 },	--	Baradin Hold
			{ id = 361, achID = 5802 },	--	Firelands
			{ id = 447, achID = 6177 },	--	Dragon Soul
		},
		{	-- [4] 25 player raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_25P)),
			{ id = 314, achID = 4842 },	--	Blackwing Descent
			{ id = 316, achID = 4850 },	--	The Bastion of Twilight
			{ id = 318, achID = 4851 },	--	Throne of the Four Winds
			{ id = 329, achID = 5425 },	--	Baradin Hold
			{ id = 362, achID = 5802 },	--	Firelands
			{ id = 448, achID = 6177 },	--	Dragon Soul
		},		
	},
	{	-- [5]
		name = EXPANSION_NAME4,	-- "Mists of Pandaria"
		{	-- [1] heroic dungeons
			name = format("%s - %s", DUNGEONS, GetDifficultyInfo(DIFFICULTY_DUNGEON_HEROIC)),
			{ id = 468, achID = 6758 },	--	Temple of the Jade Serpent
			{ id = 469, achID = 6456 },	--	Stormstout Brewery
			{ id = 470, achID = 6470 },	--	Shado-Pan Monastery
			{ id = 471, achID = 6759 },	--	Gate of the Setting Sun
			{ id = 472, achID = 6762 },	--	Scholomance
			{ id = 473, achID = 6760 },	--	Scarlet Halls
			{ id = 474, achID = 6761 },	--	Scarlet Monastery
			{ id = 519, achID = 6756 },	--	Mogu'shan Palace
			{ id = 554, achID = 6763 },	--	Siege of Niuzao Temple
		},
		{	-- [2] LFR Raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_LFR)),
			{ id = 526, achID = 6689, bosses = 4 },	--	Terrace of Endless Spring
			{ id = 527, achID = 6458, bosses = 3 },	--	Guardians of Mogu'shan
			{ id = 528, achID = 6844, bosses = 3 },	--	The Vault of Mysteries
			{ id = 529, achID = 6718, bosses = 3 },	--	The Dread Approach
			{ id = 530, achID = 6845, bosses = 3 },	--	Nightmare of Shek'zeer
			{ id = 610, achID = 8069, bosses = 3 },	--	Last Stand of the Zandalari
			{ id = 611, achID = 8070, bosses = 3 },	--	Forgotten Depths
			{ id = 612, achID = 8071, bosses = 3 },	--	Halls of Flesh-Shaping
			{ id = 613, achID = 8072, bosses = 3 },	--	Pinnacle of Storms
			{ id = 716, achID = 8458, bosses = 4 },	--	Vale of Eternal Sorrows
			{ id = 717, achID = 8459, bosses = 4 },	--	Gates of Retribution
			{ id = 724, achID = 8461, bosses = 3 },	--	The Underhold
			{ id = 725, achID = 8462, bosses = 3 },	--	Downfall
		},
		{	-- [3] heroic scenarios
			name = format("%s - %s", SCENARIOS, GetDifficultyInfo(DIFFICULTY_SCENARIO_HEROIC)),
			{ id = 588, achID = 8364 },	--	Battle on the High Seas
			{ id = 624, achID = 8318 },	--	Dark Heart of Pandaria
			{ id = 625, achID = 8327 },	--	The Secrets of Ragefire
			{ id = 637, achID = 8312 },	--	Blood in the Snow
			{ id = 639, achID = 8310 },	--	A Brewing Storm
			-- { id = 645, achID =  },	--	Greenstone Village
			{ id = 648, achID = 8311 },	--	Crypt of Forgotten Kings
			-- { id = 652, achID =  },	--	Battle on the High Seas
			-- { id = 749, achID =  },	--	Noodle Time
		},
		{	-- [4] Flex Raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_FLEX)),
			{ id = 726, achID = 8458, bosses = 4 },	--	Vale of Eternal Sorrows
			{ id = 728, achID = 8459, bosses = 4 },	--	Gates of Retribution
			{ id = 729, achID = 8461, bosses = 3 },	--	The Underhold
			{ id = 730, achID = 8462, bosses = 3 },	--	Downfall
		},
		{	-- [5] 10 player raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_10P)),
			{ id = 531, achID = 6844 },	--	Mogu'shan Vaults
			{ id = 533, achID = 6845 },	--	Heart of Fear
			{ id = 535, achID = 6689, bosses = 4 },	--	Terrace of Endless Spring
			{ id = 633, achID = 8072 },	--	Throne of Thunder
			{ id = 714, achID = 8462 },	--	Siege of Orgrimmar
		},
		{	-- [6] 25 player raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_25P)),
			{ id = 532, achID = 6844 },	--	Mogu'shan Vaults
			{ id = 534, achID = 6845 },	--	Heart of Fear
			{ id = 536, achID = 6689 },	--	Terrace of Endless Spring
			{ id = 634, achID = 8072 },	--	Throne of Thunder
			{ id = 715, achID = 8462 },	--	Siege of Orgrimmar
			{ id = 767, achID = 8533 },	--	Ordos
			{ id = 768, achID = 8535 },	--	Celestials
		},
		{	-- [7] Flex raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_FLEX)),
			{ id = 771, achID = 8458, bosses = 4 },	--	Vale of Eternal Sorrows
			{ id = 772, achID = 8459, bosses = 4 },	--	Gates of Retribution
			{ id = 773, achID = 8461, bosses = 3 },	--	The Underhold
			{ id = 774, achID = 8462, bosses = 3 },	--	Downfall
		},
	},
	
	-- {	-- [6]
		-- name = EXPANSION_NAME5,	-- "Warlords of Draenor"
	-- },
	
}

local view
local isViewValid

local OPTION_XPACK = "UI.Tabs.Grids.Dungeons.CurrentXPack"
local OPTION_RAIDS = "UI.Tabs.Grids.Dungeons.CurrentRaids"

local currentDDMText
local currentTexture

local function BuildView()
	view = view or {}
	wipe(view)
	
	local currentXPack = addon:GetOption(OPTION_XPACK)
	local currentRaids = addon:GetOption(OPTION_RAIDS)

	for index, raidList in ipairs(Dungeons[currentXPack][currentRaids]) do
		table.insert(view, raidList)	-- insert the table pointer
	end
	
	isViewValid = true
end

local DDM_AddCloseMenu = addon.Helpers.DDM_AddCloseMenu

local function OnRaidListChange(self, xpackIndex, raidListIndex)
	CloseDropDownMenus()

	addon:SetOption(OPTION_XPACK, xpackIndex)
	addon:SetOption(OPTION_RAIDS, raidListIndex)
		
	local raidList = Dungeons[xpackIndex][raidListIndex]
	currentDDMText = raidList.name
	addon.Tabs.Grids:SetViewDDMText(currentDDMText)
	
	isViewValid = nil
	addon.Tabs.Grids:Update()
end

local function DropDown_Initialize(self, level)
	if not level then return end

	local info = UIDropDownMenu_CreateInfo()
	
	local currentXPack = addon:GetOption(OPTION_XPACK)
	local currentRaids = addon:GetOption(OPTION_RAIDS)
	
	if level == 1 then
		for xpackIndex = 1, #Dungeons do
			info.text = Dungeons[xpackIndex].name
			info.hasArrow = 1
			info.checked = (currentXPack == xpackIndex)
			info.value = xpackIndex
			UIDropDownMenu_AddButton(info, level)
		end
		DDM_AddCloseMenu()
	
	elseif level == 2 then
		for raidListIndex, raidList in ipairs(Dungeons[UIDROPDOWNMENU_MENU_VALUE]) do
			info.text = raidList.name
			info.func = OnRaidListChange
			info.checked = ((currentXPack == UIDROPDOWNMENU_MENU_VALUE) and (currentRaids == raidListIndex))
			info.arg1 = UIDROPDOWNMENU_MENU_VALUE
			info.arg2 = raidListIndex
			UIDropDownMenu_AddButton(info, level)
		end
	end
end

local callbacks = {
	OnUpdate = function() 
			if not isViewValid then
				BuildView()
			end

			local currentXPack = addon:GetOption(OPTION_XPACK)
			local currentRaids = addon:GetOption(OPTION_RAIDS)
			
			addon.Tabs.Grids:SetStatus(format("%s / %s", Dungeons[currentXPack].name, Dungeons[currentXPack][currentRaids].name))
		end,
	GetSize = function() return #view end,
	RowSetup = function(self, entry, row, dataRowID)
			local dungeonID = view[dataRowID].id
			
			local rowName = entry .. row
			_G[rowName.."Name"]:SetText(WHITE .. GetLFGDungeonInfo(dungeonID))
			_G[rowName.."Name"]:SetJustifyH("LEFT")
			_G[rowName.."Name"]:SetPoint("TOPLEFT", 15, 0)
		end,
	ColumnSetup = function(self, entry, row, column, dataRowID, character)
			local itemName = entry.. row .. "Item" .. column;
			local itemTexture = _G[itemName .. "_Background"]
			local itemButton = _G[itemName]
			local itemText = _G[itemName .. "Name"]

			local _, _, _, _, _, _, _, _, _, achImage = GetAchievementInfo(view[dataRowID].achID)
			itemTexture:SetTexture(achImage)
			itemTexture:SetTexCoord(0, 1, 0, 1)
			itemTexture:SetDesaturated(false)
			
			local dungeonID = view[dataRowID].id
			local count = DataStore:GetLFGDungeonKillCount(character, dungeonID)
			
			if count > 0 then 
				itemTexture:SetVertexColor(1.0, 1.0, 1.0)
				itemButton.key = character
				itemButton:SetID(dungeonID)

				itemText:SetJustifyH("CENTER")
				itemText:SetPoint("BOTTOMRIGHT", 3, 2)
				itemText:SetFontObject("NumberFontNormalLarge")

				if view[dataRowID].bosses then
					itemText:SetText(GREEN..format("%s/%s", count, view[dataRowID].bosses))
				else
					itemText:SetText(GREEN..format("%s/%s", count, GetLFGDungeonNumEncounters(view[dataRowID].id)))
				end
				
				-- itemText:SetText(GREEN..count)
			else
				itemTexture:SetVertexColor(0.3, 0.3, 0.3)		-- greyed out
				itemText:SetJustifyH("CENTER")
				itemText:SetPoint("BOTTOMRIGHT", 5, 0)
				itemText:SetFontObject("GameFontNormalSmall")
				itemText:SetText(ICON_NOTREADY)
				itemButton:SetID(0)
				itemButton.key = nil
			end
		end,
		
	OnEnter = function(frame) 
			local character = frame.key
			if not character then return end

			local dungeonID = frame:GetID()
			local dungeonName, _, _, _, _, _, _, _, _, _, _, difficulty = GetLFGDungeonInfo(dungeonID)
			
			AltoTooltip:SetOwner(frame, "ANCHOR_LEFT")
			AltoTooltip:ClearLines()
			AltoTooltip:AddLine(DataStore:GetColoredCharacterName(character),1,1,1)
			AltoTooltip:AddLine(dungeonName,1,1,1)
			AltoTooltip:AddLine(GetDifficultyInfo(difficulty),1,1,1)
			
			AltoTooltip:AddLine(" ",1,1,1)
			
			local color
			for i = 1, GetLFGDungeonNumEncounters(dungeonID) do
				local bossName = GetLFGDungeonEncounterInfo(dungeonID, i)
				
				if DataStore:IsBossAlreadyLooted(character, dungeonID, bossName) then
					AltoTooltip:AddDoubleLine(bossName, RED..ERR_LOOT_GONE)
				else
					AltoTooltip:AddDoubleLine(bossName, GREEN..BOSS_ALIVE)
				end
			end
			
			AltoTooltip:Show()
			
		end,
	OnClick = nil,
	OnLeave = function(self)
			AltoTooltip:Hide() 
		end,
	InitViewDDM = function(frame, title) 
			frame:Show()
			title:Show()

			local currentXPack = addon:GetOption(OPTION_XPACK)
			local currentRaids = addon:GetOption(OPTION_RAIDS)
			
			currentDDMText = Dungeons[currentXPack][currentRaids].name
			
			UIDropDownMenu_SetWidth(frame, 100) 
			UIDropDownMenu_SetButtonWidth(frame, 20)
			UIDropDownMenu_SetText(frame, currentDDMText)
			addon:DDM_Initialize(frame, DropDown_Initialize)
		end,
}

addon.Tabs.Grids:RegisterGrid(10, callbacks)
