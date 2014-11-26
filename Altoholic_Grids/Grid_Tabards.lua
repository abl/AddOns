local addonName = "Altoholic"
local addon = _G[addonName]

local WHITE		= "|cFFFFFFFF"

local ICON_NOTREADY = "\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t"
local ICON_READY = "\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t"

local tabardList
local currentItemID

local tabardCriteriaIDs = {
	2335, 2336, 2337, 2338, 2339, 2340, 2893, 2894, 2895, 2896,
	2897, 2898, 2899, 2900, 2901, 2902, 2903, 2904, 2905, 2906,
	2907, 2908, 2909, 2910, 2911, 2912, 2913, 2914, 2915, 2916,
	2917, 2918, 2919, 2920, 2921, 2922, 2923, 2924, 2925, 2926,
	2927, 2928, 2929, 2930, 2931, 2932, 2933, 6151, 6171, 6172,
	6976, 6977, 6978, 6979, 11298, 11299, 11300, 11301, 11302, 11303,
	11304, 11305, 11306, 11378, 11307, 11308, 11309, 11760, 11761, 12598,
	12599, 12600, 13241, 13242, 16319, 16320, 16321, 16322, 16323, 16324,
	16325, 16326, 16327, 16328, 16329, 16885, 16886, 21692, 21693, 22618,
	22619, 22620, 22621, 22622, 22623, 22624, 22625, 22626
}

local tabardNames

local function BuildTabardList()
	tabardNames = tabardNames or {}
	tabardList = {}
	
	local criteriaID
	
	local TABARDS_ACHIEVEMENT_ID = 621
	local name, itemID
	
	-- do not use GetAchievementNumCriteria(621) as it returns 1
	for i = 1, #tabardCriteriaIDs do
		-- local _, _, _, _, _, _, _, _, _, criteriaID = GetAchievementCriteriaInfo(TABARDS_ACHIEVEMENT_ID, i)
		criteriaID = tabardCriteriaIDs[i]
		
		name, _, _, _, _, _, _, itemID = GetAchievementCriteriaInfoByID(TABARDS_ACHIEVEMENT_ID, criteriaID)
		
		-- if the tabard name isn't available via the achievement data ..
		if not name or name == "" then
			name = GetItemInfo(itemID) 		-- .. then get it via the item data
		end
		
		if name then	-- if get item info takes too much time, name might not be valid yet, only add valid data
			tabardNames[criteriaID] = name	
			table.insert(tabardList, criteriaID)
		end
	end
	
	-- sort on tabard name
	table.sort(tabardList, function(a,b) 
		return tabardNames[a] < tabardNames[b]
	end)
	
end

local function RefreshTabards()
	local tabardSlot = GetInventorySlotInfo("TabardSlot")
	local link = GetInventoryItemLink("player", tabardSlot)
	
	if link then
		addon.Tabs.Grids:Update()
	end
end

local callbacks = {
	OnUpdate = function() 
			if not tabardList then
				BuildTabardList()
				addon:RegisterEvent("UNIT_INVENTORY_CHANGED", RefreshTabards)
			end
		end,
	GetSize = function() return #tabardList end,
	RowSetup = function(self, entry, row, dataRowID)
			local tabardName = tabardNames[ tabardList[dataRowID] ]
			_, _, _, _, _, _, _, currentItemID = GetAchievementCriteriaInfoByID(621, tabardList[dataRowID] )
			
			if tabardName then
				local rowName = entry .. row
				_G[rowName.."Name"]:SetText(WHITE .. tabardName)
				_G[rowName.."Name"]:SetJustifyH("LEFT")
				_G[rowName.."Name"]:SetPoint("TOPLEFT", 15, 0)
			end
		end,
	ColumnSetup = function(self, entry, row, column, dataRowID, character)
			local itemName = entry.. row .. "Item" .. column;
			local itemTexture = _G[itemName .. "_Background"]
			local itemButton = _G[itemName]
			local itemText = _G[itemName .. "Name"]
			
			itemText:SetFontObject("GameFontNormalSmall")
			itemText:SetJustifyH("CENTER")
			itemText:SetPoint("BOTTOMRIGHT", 5, 0)
			itemTexture:SetDesaturated(false)
			itemTexture:SetTexCoord(0, 1, 0, 1)
			itemTexture:SetTexture(GetItemIcon(currentItemID))
			
			local criteriaID = tabardList[dataRowID]
			if DataStore:IsTabardKnown(character, criteriaID) then
				itemTexture:SetVertexColor(1.0, 1.0, 1.0);
				itemText:SetText(ICON_READY)
			else
				itemTexture:SetVertexColor(0.4, 0.4, 0.4);
				itemText:SetText(ICON_NOTREADY)
			end
			itemButton.id = currentItemID
		end,
	OnEnter = function(self) 
			self.link = nil
			addon:Item_OnEnter(self) 
		end,
	OnClick = function(self, button)
			self.link = nil
			addon:Item_OnClick(self, button)
		end,
	OnLeave = function(self)
			GameTooltip:Hide() 
		end,
		
	InitViewDDM = function(frame, title) 
			frame:Hide()
			title:Hide()
		end,
}

addon.Tabs.Grids:RegisterGrid(4, callbacks)
