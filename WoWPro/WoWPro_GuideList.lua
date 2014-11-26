---------------------------------
--      WoWPro_Guide_List      --
---------------------------------

local L = WoWPro_Locale


function WoWPro.CreateGuideList()
    local GAP, EDGEGAP = 35, 16
	local frame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
	frame.name = L["Guide List"]
	frame.parent = "WoW-Pro"
	frame:Hide()
	WoWPro.GuideList = frame
	
	local title, subtitle = WoWPro:CreateHeading(frame, L["Guide List"], L["Use the tabs to look at different guide types. "
		.."\nSelect one and hit \"Okay\" to load. "
		.."\nShift+click a guide to clear it."])
    frame.title = title
    frame.subtitle = subtitle

	local prev = nil
	local tabs = {}
	local tabhashtable = {}
	local firstTab = nil
	local maxFormatItems = 0
	
	-- Create tab for each module --
	for name, module in WoWPro:IterateModules() do
	    if WoWPro[name].GuideList then
    		tabs[name] = WoWPro:CreateTab(name, frame)
    		if prev then
    			tabs[name]:SetPoint("LEFT", prev, "RIGHT", 0, 0)
    		else
    			tabs[name]:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", -2, -5)
    			firstTab = tabs[name]
    		end
    		tabs[name].name = name
    		tabs[name]:SetScript("OnClick", function(self, button)
    			WoWPro.ActivateTab(name)
    		end) 
    		prev = tabs[name]
    		table.insert(tabhashtable,name)
    		maxFormatItems = max(maxFormatItems, #(WoWPro[name].GuideList.Format))
		end
	end
	WoWPro.GuideList.TabTable = tabs

	if not tabhashtable[1] then 
		subtitle:SetText(L["Looks like you don't have any Wow-Pro guide modules loaded!"
			.."\nLog out to the character selection screen and open your addons menu there to select some to load."])
		frame:Hide()
	end
	WoWPro.GuideList.TabHashTable = tabhashtable
	
    local TitleRow = WoWPro:CreateBG(frame)
    TitleRow:SetHeight(25)
    TitleRow:SetWidth(InterfaceOptionsFramePanelContainer:GetWidth()-44)
    TitleRow:SetPoint("TOPLEFT", firstTab, "BOTTOMLEFT")
    frame.TitleRow = TitleRow

    local scrollBox = WoWPro:CreateBG(frame)
    scrollBox:SetPoint("TOPLEFT", TitleRow, "BOTTOMLEFT")
    scrollBox:SetPoint("TOPRIGHT", TitleRow, "BOTTOMRIGHT")
    scrollBox:SetPoint("BOTTOM",frame,"BOTTOM",0,5)
    frame.scrollBox = scrollBox
    
	local scrollBar,_,_,scrollBorder = WoWPro:CreateScrollbar(scrollBox,{-4,6},nil,"Outside")
	frame.scrollBar = scrollBar  
    
	frame.ScrollFrame = CreateFrame("ScrollFrame",nil,scrollBox)
	frame.ScrollFrame:SetPoint("TOPLEFT",10,-10)
	frame.ScrollFrame:SetPoint("BOTTOMRIGHT",-10,10)

	local f = scrollBar:GetScript("OnValueChanged")
	scrollBar:SetScript("OnValueChanged", function(self, value, ...)
		WoWPro.GuideList.ScrollFrame:SetVerticalScroll(self:GetValue())
		return f(self, value, ...)
	end)

    frame.ScrollFrame:EnableMouseWheel()
	frame.ScrollFrame:SetScript("OnMouseWheel", function(self, val)
	    local minValue, maxValue = scrollBar:GetMinMaxValues()
        scrollBar:SetValue(scrollBar:GetValue() - val*maxValue/10)
    end)

	local function OnShow(self)
		local GID = WoWProDB.char.currentguide
		if GID and WoWPro.Guides[GID] then
			WoWPro.ActivateTab(WoWPro.Guides[GID].guidetype)
		end 
	end
	scrollBox:SetScript("OnShow", OnShow)
--	OnShow(WoWPro.GuideList)
	
end

function WoWPro.ActivateTab(tabname)
	local tab
	if not tabname then
		local GID = WoWProDB.char.currentguide
		if GID and WoWPro.Guides[GID] and WoWPro.Guides[GID].guidetype then
			tabname = WoWPro.Guides[GID].guidetype
		else
			tabname = WoWPro.GuideList.TabHashTable[1]
		end 
	end
	
	if not WoWPro.GuideList.TabTable[tabname] then
		tabname = WoWPro.GuideList.TabHashTable[1]
	end
	
	if not tabname then return end
		
	tab = WoWPro.GuideList.TabTable[tabname]
	
	-- Deactivating tabs --
	for name, module in WoWPro:IterateModules() do
	    if WoWPro.GuideList.TabTable[name] then 
		    WoWPro.DeactivateTab(WoWPro.GuideList.TabTable[name])
		end
	end
	tab:SetBackdrop({
			bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
			tile = true,
			tileSize = 16,
			insets = { left = 5, right = 5, top = 10, bottom = -3 }
		})
	tab:SetBackdropColor(0.1, 0.1, 0.1, 1)
	tab.border:SetAllPoints(tab)
	if not WoWPro[tab.name].GuideList then
	    WoWPro[tab.name].GuideList = {}
	end
	if WoWPro[tab.name].GuideList.Init then
	    WoWPro[tab.name].GuideList.Init()
	end
    if not WoWPro[tab.name].GuideList.Frame then
	    WoWPro[tab.name]:CreateGuideTabFrame()
	else
	    WoWPro[tab.name]:Setup_TitleRow(WoWPro[tab.name].GuideList.Frame)
    end
    WoWPro.GuideList.TitleRow:Show()

    WoWPro[tab.name].GuideList.Frame:SetSize(WoWPro[tab.name].GuideList.Frame.frameWidth,WoWPro[tab.name].GuideList.Frame.frameHeight)
	WoWPro.GuideList.ScrollFrame:SetScrollChild(WoWPro[tab.name].GuideList.Frame)
	local vHeight = WoWPro[tab.name].GuideList.Frame.frameHeight-WoWPro.GuideList.ScrollFrame:GetHeight()
	if vHeight < 0 then
	    vHeight = WoWPro[tab.name].GuideList.Frame.frameHeight
	end
    WoWPro.GuideList.scrollBar:SetMinMaxValues(0,vHeight)
    WoWPro.GuideList.scrollBar:SetValue(0)
	WoWPro.GuideList.ScrollFrame:SetVerticalScroll(0)
	WoWPro.GuideList.ScrollFrame:Show()
	WoWPro[tab.name].GuideList.Frame:Show()

end

function WoWPro.DeactivateTab(tab)
	tab:SetBackdrop({
			bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
			tile = true,
			tileSize = 16,
			insets = { left = 5, right = 5, top = 10, bottom = 3 }
		})
	tab:SetBackdropColor(0.1, 0.1, 0.1, 1)
	tab.border:SetPoint("BOTTOM", 0, 5)
	
	if WoWPro[tab.name].GuideList and WoWPro[tab.name].GuideList.Frame  then WoWPro[tab.name].GuideList.Frame:Hide() end
end


-- Populating Guide List --
WoWPro:Export("UpdateGuideList")
function WoWPro:UpdateGuideList()
	if not self.GuideList.Frame then return end
	if not self.GuideList.Frame:IsVisible() then return end
	
	for i,row in ipairs(self.GuideList.Rows) do
		row.i = i + self.GuideList.Offset
		local iGuide = self.GuideList.Guides[row.i]
		if iGuide then
			local GID = iGuide.GID			
            local r,g,b = 1 , 1, 1
        
            if iGuide.guide.level then
                r, g, b =  unpack(WoWPro.LevelColor(iGuide.guide))
            end

			-- Walk over the list of fields, resetting the values
			for _,colDesc in pairs(self.GuideList.Format) do
			    local button = row[colDesc[1]]
			    button:SetTextColor(r, g, b, 1)
			    if type(iGuide[colDesc[1]]) == "function" then
			        button:SetText(iGuide[colDesc[1]]())
			    else
			        button:SetText(iGuide[colDesc[1]])
			    end
			end
			row.GID = GID
			row:SetChecked(WoWProDB.char.currentguide == GID)
					
			if WoWPro[iGuide.guide.guidetype].GuideTooltipInfo then
    		    row:SetScript("OnEnter", function(self)      
        		    WoWPro[iGuide.guide.guidetype].GuideTooltipInfo(row,tooltip,iGuide.guide)		            
        		    GameTooltip:Show()
        		    if iGuide.guide.icon then
        		        WoWPro:ShowTooltipIcon(iGuide.guide.icon)
        		    end
        		end)
        		row:SetScript("OnLeave", function(self)
        		    GameTooltip:Hide()
        		    WoWPro:HideTooltipIcon()
        		end)
            end
            
		else
			row:Hide()
		end
	end
end


WoWPro:Export("Setup_TitleRow")
function WoWPro:Setup_TitleRow(frame)
	-- Title Backdrop Settings --
	local titlerowBG = {
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		tile = true,
		tileSize = 16,
		insets = { left = 0, right = 0, top = 5, bottom = -5}
	}
	local ROWHEIGHT = 17 
	
	local TitleRow = WoWPro.GuideList.TitleRow 
	
	TitleRow.buffer = TitleRow.buffer or CreateFrame("CheckButton", self.name .. "TitleRow.buffer", TitleRow)
	TitleRow.buffer:SetBackdrop(titlerowBG)
	TitleRow.buffer:SetBackdropColor(0.2, 0.2, 0, 1)
	TitleRow.buffer:SetPoint("TOPLEFT", 4, 0)
	TitleRow.buffer:SetWidth(4)
	TitleRow.buffer:SetHeight(ROWHEIGHT)
--	local function OnShow(self)
--	    WoWPro:Print("TitleRow.buffer:OnShow()")
--	end
--  TitleRow.buffer:SetScript("OnShow", OnShow)
	
	
	-- Create a button for each field
	for i,colDesc in pairs(self.GuideList.Format) do
	    local button = TitleRow[i] or CreateFrame("CheckButton", self.name .. "TitleRowButtton" .. tostring(i), TitleRow)
	    TitleRow[colDesc[1]] = button
	    TitleRow[i] = button
	    TitleRow[i]:SetNormalFontObject("GameFontWhite")
	    TitleRow[i]:SetText(L[colDesc[1]])
	    TitleRow[i]:Enable()
	    button:SetBackdrop(titlerowBG)
	    button:SetBackdropColor(0.2, 0.1, i/15.0, 0.5)
	    button:SetHeight(ROWHEIGHT)
	    button:Show() 
	end
	-- Hide unused buttons
    for i = #self.GuideList.Format+1, #TitleRow do
        TitleRow[i]:SetPoint("LEFT", TitleRow, "RIGHT", 0, 0)
        TitleRow[i]:SetWidth(1)
        TitleRow[i]:Disable()
        TitleRow[i]:Hide()
        TitleRow[i]:SetText("")
    end	
	frame.frameWidth = TitleRow:GetWidth() - 12
	
	local lastButton = TitleRow.buffer
	-- Set the width of each button according to the Format
	for _,colDesc in pairs(self.GuideList.Format) do
	    TitleRow[colDesc[1]]:SetPoint("LEFT", lastButton, "RIGHT", 0, 0)
	    local buttonWidth = floor(frame.frameWidth * colDesc[2])
	    TitleRow[colDesc[1]]:SetWidth(buttonWidth)
	    local fontString = TitleRow[colDesc[1]]:GetFontString()
	    fontString:SetJustifyH("LEFT")
	    fontString:SetJustifyV("CENTER")
	    lastButton = TitleRow[colDesc[1]]
	end
	
	-- Last button gets the extra pixels!
	--lastButton:SetPoint("RIGHT", TitleRow, "RIGHT")
	
    -- Set the OnClick handlers for each column that has a handler
	for _,colDesc in pairs(self.GuideList.Format) do
        if colDesc[3] then
            TitleRow[colDesc[1]]:SetScript("OnClick", colDesc[3])
        end
    end
end

WoWPro:Export("GuideTabFrame_RowOnClick")
function WoWPro:GuideTabFrame_RowOnClick()
	if IsShiftKeyDown() then
		WoWProCharDB.Guide[self.GID] = nil
		WoWPro.Resetting = true
		WoWPro:LoadGuide(self.GID)
		WoWPro.Resetting = false
		WoWPro:LoadGuide(self.GID)
	else
		WoWPro:LoadGuide(self.GID)
	end
	self.module:UpdateGuideList()
end		


local TooltipIcon
function WoWPro:ShowTooltipIcon(icon)
end

function WoWPro:HideTooltipIcon()
end

WoWPro:Export("CreateGuideTabFrame_Rows")
function WoWPro:CreateGuideTabFrame_Rows(frame)
    local GAP = 8 
    self.GuideList.Rows = {}
    self.GuideList.Offset = 0
    
    local sample = frame:CreateFontString(nil, nil, "GameFontHighlightSmall")
    sample:SetText("Something")
    local ROWHEIGHT = floor(sample:GetStringHeight()*1.5) -- Half a space between rows
    local frameHeight = 0
    
    
	local prevrow
	for i,iGuide in ipairs(self.GuideList.Guides) do
		local row = CreateFrame("CheckButton", string.format("%s_Guide_Row%d",self.name,i), frame)
		
		if WoWPro[iGuide.guide.guidetype].GuideTooltipInfo then
		    row:SetScript("OnEnter", function(self)      
    		    WoWPro[iGuide.guide.guidetype].GuideTooltipInfo(row,tooltip,iGuide.guide)		            
    		    GameTooltip:Show()
    		    if iGuide.guide.icon then
    		        WoWPro:ShowTooltipIcon(iGuide.guide.icon)
    		    end
    		end)
    		row:SetScript("OnLeave", function(self)
    		    GameTooltip:Hide()
    		    WoWPro:HideTooltipIcon()
    		end)
        end

        local r,g,b
        
        if iGuide.guide.level then
            r, g, b =  unpack(WoWPro.LevelColor(iGuide.guide))
--            WoWPro:dbp("Guide %s Level %d: %f, %f, %f",iGuide.GID, iGuide.guide.level, r , g , b)
        else
            r, g, b = 1 , 1, 1
--            WoWPro:dbp("Defaulted Guide %s Level %s: %f, %f, %f",iGuide.GID, tostring(iGuide.guide.level), r , g , b)
        end
        
        for _,colDesc in pairs(self.GuideList.Format) do
            local fontString = row:CreateFontString(nil, nil, "GameFontHighlightSmall")
            fontString:SetTextColor(r, g, b, 1)
            fontString:SetJustifyH("LEFT")          
		    if type(iGuide[colDesc[1]]) == "function" then
		        fontString:SetText(iGuide[colDesc[1]]())
		    else
		        fontString:SetText(iGuide[colDesc[1]])
		    end
		    row[colDesc[1]] = fontString
        end
		row.GID = iGuide.GID			
		row:SetChecked(WoWProDB.char.currentguide == iGuide.GID)

		-- Anchor Settings --

		if i == 1 then 
			row:SetPoint("TOPLEFT", frame)
			row:SetPoint("TOPRIGHT", frame)
			local prevCol
            for j,colDesc in pairs(self.GuideList.Format) do
                if j == 1 then
        	        row[colDesc[1]]:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
        	        row[colDesc[1]]:SetWidth(WoWPro.GuideList.TitleRow[colDesc[1]]:GetWidth())
        	        row[colDesc[1]]:SetHeight(ROWHEIGHT)
        	        prevCol = row[colDesc[1]]
        	    else
        	        row[colDesc[1]]:SetPoint("TOPLEFT", prevCol, "TOPRIGHT", 0, 0)
        	        row[colDesc[1]]:SetWidth(WoWPro.GuideList.TitleRow[colDesc[1]]:GetWidth())
        	        row[colDesc[1]]:SetHeight(ROWHEIGHT)
        	        prevCol = row[colDesc[1]]
        	    end
            end
            prevrow = row
		else 
			row:SetPoint("TOPLEFT", prevrow, "BOTTOMLEFT", 0, 0)
			row:SetPoint("TOPRIGHT", prevrow, "BOTTOMRIGHT", 0, 0)
            for _,colDesc in pairs(self.GuideList.Format) do
        	    row[colDesc[1]]:SetPoint("TOPLEFT", prevrow[colDesc[1]], "BOTTOMLEFT", 0, 0)
        	    row[colDesc[1]]:SetPoint("TOPRIGHT", prevrow[colDesc[1]], "BOTTOMRIGHT", 0, 0)
        	    row[colDesc[1]]:SetHeight(ROWHEIGHT)               
            end
            prevrow = row
		end

       				
		row:SetPoint("LEFT", 4, 0)
		row:SetPoint("RIGHT", -4, 0)
		row:SetHeight(ROWHEIGHT)
		
		frameHeight = frameHeight + ROWHEIGHT 
		
		local highlight = row:CreateTexture()
		highlight:SetTexture("Interface\\HelpFrame\\HelpFrameButton-Highlight")
		highlight:SetTexCoord(0, 1, 0, 0.578125)
		highlight:SetAllPoints()
		row:SetHighlightTexture(highlight)
		row:SetCheckedTexture(highlight)
		
		row.module = self
		row:SetScript("OnClick", self.GuideTabFrame_RowOnClick)

		self.GuideList.Rows[i] = row
		
	end
	frame.frameHeight = frameHeight
end


WoWPro:Export("CreateGuideTabFrame")
function WoWPro:CreateGuideTabFrame()
    local frame
    
    if not self.GuideList.Frame then
	    frame = CreateFrame("Frame", self.name .. " TabFrame", WoWPro.GuideList.ScrollFrame)
	    frame.module = self
        self.GuideList.Frame = frame
--      local function OnShow(self)
--	        self.module:Print("GuideList.Frame: OnShow!")
--	    end
--      frame:SetScript("OnShow", OnShow)

	    -- Title Row --
	    self:Setup_TitleRow(frame)

	    -- Rows --
        self:CreateGuideTabFrame_Rows(frame)

    end
    
end 
-- WoWPro.GuideList
