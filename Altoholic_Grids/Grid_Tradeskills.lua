local addonName = "Altoholic"
local addon = _G[addonName]

local LCI = LibStub("LibCraftInfo-1.0")
local LCL = LibStub("LibCraftLevels-1.0")

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"

local RECIPE_GREY		= "|cFF808080"
local RECIPE_GREEN	= "|cFF40C040"
local RECIPE_ORANGE	= "|cFFFF8040"

local ICON_NOTREADY = "\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t"
local ICON_READY = "\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t"
local ICON_QUESTIONMARK = "Interface\\RaidFrame\\ReadyCheck-Waiting"

local tradeskills = {
	2259,
	3100,
	7411,
	4036,
	45357,
	25229,
	2108,
	2656,
	3908,
	2550,
	3273,
}

local xPacks = {
	EXPANSION_NAME0,	-- "Classic"
	EXPANSION_NAME1,	-- "The Burning Crusade"
	EXPANSION_NAME2,	-- "Wrath of the Lich King"
	EXPANSION_NAME3,	-- "Cataclysm"
	EXPANSION_NAME4,	-- "Mists of Pandaria"
	EXPANSION_NAME5,	-- "Warlords of Draenor"
}

local OPTION_XPACK = "UI.Tabs.Grids.Tradeskills.CurrentXPack"
local OPTION_TRADESKILL = "UI.Tabs.Grids.Tradeskills.CurrentTradeSkill"

local currentDDMText
local currentItemID
local currentList

local DDM_Add = addon.Helpers.DDM_Add
local DDM_AddCloseMenu = addon.Helpers.DDM_AddCloseMenu
local DDM_AddTitle = addon.Helpers.DDM_AddTitle

local function OnXPackChange(self)
	local currentXPack = self.value
	
	addon:SetOption(OPTION_XPACK, currentXPack)

	addon.Tabs.Grids:SetViewDDMText(xPacks[currentXPack])
	addon.Tabs.Grids:Update()
end

local function OnTradeSkillChange(self)
	CloseDropDownMenus()
	addon:SetOption(OPTION_TRADESKILL, self.value)
	addon.Tabs.Grids:Update()
end

local function DropDown_Initialize(self, level)

	if not level then return end

	local currentXPack = addon:GetOption(OPTION_XPACK)
	local currentTradeSkill = addon:GetOption(OPTION_TRADESKILL)
	
	local info = UIDropDownMenu_CreateInfo()
	
	if level == 1 then
		-- Sub Menu : Primary Skills
		info.text = PRIMARY_SKILLS
		info.hasArrow = 1
		info.value = 1
		UIDropDownMenu_AddButton(info, level)

		-- Sub Menu : Secondary Skills
		info.text = SECONDARY_SKILLS
		info.hasArrow = 1
		info.value = 2
		UIDropDownMenu_AddButton(info, level)

		info.isTitle	= 1
		info.hasArrow = nil
		info.text = ""
		info.icon = nil
		info.checked = nil
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)
		
		info = UIDropDownMenu_CreateInfo()
		
		-- XPack Selection
		for i, xpack in pairs(xPacks) do
			info.text = xpack
			info.hasArrow = nil
			info.value = i
			info.func = OnXPackChange
			info.icon = nil
			info.checked = (i==currentXPack)
			UIDropDownMenu_AddButton(info, level)
		end
		
		DDM_AddCloseMenu()
	
	elseif level == 2 then
		local spell, icon, _
		local firstSecondarySkill = 10
	
		if UIDROPDOWNMENU_MENU_VALUE == 1 then				-- Primary professions
			for i = 1, (firstSecondarySkill - 1) do
				spell, _, icon = GetSpellInfo(tradeskills[i])
				
				info.text = spell
				info.hasArrow = nil
				info.value = i
				info.func = OnTradeSkillChange
				info.icon = icon
				info.checked = (i==currentTradeSkill)
				UIDropDownMenu_AddButton(info, level)				
			end
		
		elseif UIDROPDOWNMENU_MENU_VALUE == 2 then		-- Secondary professions
			for i = firstSecondarySkill, #tradeskills do
				spell, _, icon = GetSpellInfo(tradeskills[i])
				
				info.text = spell
				info.hasArrow = nil
				info.value = i
				info.func = OnTradeSkillChange
				info.icon = icon
				info.checked = (i==currentTradeSkill)
				UIDropDownMenu_AddButton(info, level)				
			end
		end
	end
end

local function SortByCraftLevel(a, b)
	local o1, y1, g1, gr1 = LCL:GetCraftLevels(a)	-- get color level : orange, yellow, green, grey
	local o2, y2, g2, gr2 = LCL:GetCraftLevels(b)
	
	-- try the most common cases = by orange, then by yellow, then by green
	if o1 and o2 and o1 ~= o2 then
		return o1 < o2
	elseif y1 and y2 and y1 ~= y2 then
		return y1 < y2
	elseif g1 and g2 and g1 ~= g2 then
		return g1 < g2
	end	
	
	-- if none has worked, we have a craft with no value for one or multiple colors, so basically skip the missing ones
	-- ex: if no orange value, sort on yellow .. to be able to do so, start from the grey, then green, then yellow
	gr1 = gr1 or 0
	gr2 = gr2 or 0
	
	if gr1 ~= gr2 then
		return gr1 < gr2
	end
	
	g1 = g1 or gr1
	g2 = g2 or gr2
	
	if g1 ~= g2 then
		return g1 < g2
	end
	
	y1 = y1 or g1
	y2 = y2 or g2
	
	if y1 ~= y2 then
		return y1 < y2
	end
	
	-- if nothing worked, sort on spell id
	return a < b
end

local callbacks = {
	OnUpdate = function() 
			local currentXPack = addon:GetOption(OPTION_XPACK)
			local currentTradeSkill = addon:GetOption(OPTION_TRADESKILL)
			
			currentList = LCI:GetProfessionCraftList(tradeskills[currentTradeSkill], currentXPack)
			if not currentList.isSorted then
				table.sort(currentList, SortByCraftLevel)
				currentList.isSorted = true
			end
			
			local prof = GetSpellInfo(tradeskills[currentTradeSkill])
			addon.Tabs.Grids:SetStatus(format("%s / %s", GREEN..prof, WHITE .. xPacks[currentXPack]))
		end,
	OnUpdateComplete = function() end,
	GetSize = function() return #currentList end,
	RowSetup = function(self, entry, row, dataRowID)
			local spellID = currentList[dataRowID]
			local itemName = GetSpellInfo(spellID)
			local text
			
			-- if not itemName then
				-- DEFAULT_CHAT_FRAME:AddMessage("spell : " .. spellID)
			-- end
			
			currentItemID = LCI:GetCraftResultItem(spellID)
			local orange, yellow, green, grey = LCL:GetCraftLevels(spellID)
			
			if orange then
				text = format("%s\n%s %s %s %s",
					WHITE..itemName, 
					-- WHITE..spellID, 
					RECIPE_ORANGE..orange, 
					YELLOW..yellow, 
					RECIPE_GREEN..green, 
					RECIPE_GREY..grey )
			end
			
			text = text or format("%s", WHITE..itemName)
			
			local rowName = entry .. row
			_G[rowName.."Name"]:SetText(text)
			_G[rowName.."Name"]:SetJustifyH("LEFT")
			_G[rowName.."Name"]:SetPoint("TOPLEFT", 15, 0)
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
			
			itemTexture:SetTexture(GetItemIcon(currentItemID) or ICON_QUESTIONMARK)

			local text = ICON_NOTREADY
			local vc = 0.25	-- vertex color
			local profession = DataStore:GetProfession(character, GetSpellInfo(tradeskills[addon:GetOption(OPTION_TRADESKILL)]))			

			if profession.NumCrafts ~= 0 then
				-- do not enable this yet .. working fine, but better if more filtering allowed. ==> filtering on rarity
				
				-- local _, _, itemRarity, itemLevel = GetItemInfo(currentItemID)
				-- if itemRarity and itemRarity >= 2 then
					-- local r, g, b = GetItemQualityColor(itemRarity)
					-- itemButton.border:SetVertexColor(r, g, b, 0.5)
					-- itemButton.border:Show()
				-- end
				
				if DataStore:IsCraftKnown(profession, currentList[dataRowID]) then
					vc = 1.0
					text = ICON_READY
				else
					vc = 0.4
				end
			end

			itemTexture:SetVertexColor(vc, vc, vc)
			itemText:SetText(text)
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
			UIDropDownMenu_SetText(frame, xPacks[addon:GetOption(OPTION_XPACK)])
			addon:DDM_Initialize(frame, DropDown_Initialize)
		end,
}

addon.Tabs.Grids:RegisterGrid(7, callbacks)
