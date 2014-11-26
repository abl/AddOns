local addonName = "Altoholic"
local addon = _G[addonName]

local WHITE		= "|cFFFFFFFF"

local ICON_NOTREADY = "\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t"
local ICON_READY = "\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t"
local ICON_VIEW_QUESTS = "Interface\\LFGFrame\\LFGIcon-Quest"

local questList
local view

local function BuildView()
	questList = {}
	view = {}
	
	local realm, account = addon.Tabs.Grids:GetRealm()
	
	for _, character in pairs(DataStore:GetCharacters(realm, account)) do	-- all alts on this realm
		local num = DataStore:GetDailiesHistorySize(character) or 0
		for i = 1, num do
			local id, title = DataStore:GetDailiesHistoryInfo(character, i)
			
			if not questList[id] then
				questList[id] = {}
				questList[id].title = title
				questList[id].completedBy = {}
			end
			
			questList[id].completedBy[character] = true
		end
	end
	
	for k, v in pairs(questList) do
		table.insert(view, k)
	end

	table.sort(view, function(a,b) 
		return questList[a].title < questList[b].title
	end)
end

local callbacks = {
	OnUpdate = function() 
			if not questList then
				BuildView()
				addon:RegisterMessage("DATASTORE_QUEST_TURNED_IN")
			end
		end,
	GetSize = function() return #view end,
	RowSetup = function(self, entry, row, dataRowID)
			local name = questList[ view[dataRowID] ].title
			if name then
				local rowName = entry .. row
				_G[rowName.."Name"]:SetText(WHITE .. name)
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
			itemTexture:SetTexture(ICON_VIEW_QUESTS)
			
			if questList[view[dataRowID]].completedBy[character]  then
				itemTexture:SetVertexColor(1.0, 1.0, 1.0);
				itemText:SetText(ICON_READY)
			else
				itemTexture:SetVertexColor(0.4, 0.4, 0.4);
				itemText:SetText(ICON_NOTREADY)
			end
		end,
	OnEnter = function(self) 
			self.link = nil
			addon:Item_OnEnter(self) 
		end,
	OnClick = nil,
	OnLeave = function(self)
			GameTooltip:Hide() 
		end,
		
	InitViewDDM = function(frame, title) 
			frame:Hide()
			title:Hide()
		end,
}

function addon:DATASTORE_QUEST_TURNED_IN(event, sender, character)
	BuildView()
	addon.Tabs.Grids:Update()
end

addon.Tabs.Grids:RegisterGrid(9, callbacks)
