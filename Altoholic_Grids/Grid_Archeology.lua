local addonName = "Altoholic"
local addon = _G[addonName]

local ICON_NOTREADY = "\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t"
local ICON_READY = "\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t"

local OPTION_RACE = "UI.Tabs.Grids.Archaeology.CurrentRace"
local currentItemID

local DDM_Add = addon.Helpers.DDM_Add
local DDM_AddCloseMenu = addon.Helpers.DDM_AddCloseMenu

local function OnRaceChange(self)
	addon:SetOption(OPTION_RACE, self.value)

	addon.Tabs.Grids:SetViewDDMText(GetArchaeologyRaceInfo(self.value))
	addon.Tabs.Grids:Update()
end

local function DropDown_Initialize()
	local numRaces = GetNumArchaeologyRaces()
	local race, icon
	
	local currentRace = addon:GetOption(OPTION_RACE)
	
	for i = 1, numRaces do
		if i ~= 13 then	-- 13 = UNUSED
			race, icon = GetArchaeologyRaceInfo(i)
			DDM_Add(race, i, OnRaceChange, icon, (i==currentRace))
		end
	end

	DDM_AddCloseMenu()
end

local callbacks = {
	OnUpdate = function()
			addon.Tabs.Grids:SetStatus(GetArchaeologyRaceInfo(addon:GetOption(OPTION_RACE)))
		end,
	GetSize = function() return DataStore:GetRaceNumArtifacts(addon:GetOption(OPTION_RACE)) end,
	RowSetup = function(self, entry, row, dataRowID)
			local artifact = DataStore:GetArtifactInfo(addon:GetOption(OPTION_RACE), dataRowID)
			currentItemID = artifact.itemID
			
			if currentItemID then
				local _, _, _, hexColor = GetItemQualityColor(artifact.rarity)
				local itemName = GetSpellInfo(artifact.spellID)
				
				local rowName = entry .. row
				_G[rowName.."Name"]:SetText("|c" .. hexColor .. itemName)
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
			
			local artifact = DataStore:GetArtifactInfo(addon:GetOption(OPTION_RACE), dataRowID)
			if DataStore:IsArtifactKnown(character, artifact.spellID) then
				itemTexture:SetVertexColor(1.0, 1.0, 1.0);
				itemText:SetText(ICON_READY)
				
				local _, _, itemRarity, itemLevel = GetItemInfo(currentItemID)
				if itemRarity and itemRarity >= 2 then
					local r, g, b = GetItemQualityColor(itemRarity)
					itemButton.border:SetVertexColor(r, g, b, 0.5)
					itemButton.border:Show()
				end
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
			frame:Show()
			title:Show()
			
			UIDropDownMenu_SetWidth(frame, 100) 
			UIDropDownMenu_SetButtonWidth(frame, 20)
			UIDropDownMenu_SetText(frame, GetArchaeologyRaceInfo(addon:GetOption(OPTION_RACE)))
			addon:DDM_Initialize(frame, DropDown_Initialize)
		end,
}

addon.Tabs.Grids:RegisterGrid(8, callbacks)