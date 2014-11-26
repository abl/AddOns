----------------------------------
--      WoWPro_Widgets.lua      --
----------------------------------

function WoWPro:CreateCheck(parent)
	local check = CreateFrame("CheckButton", nil, parent)
	check:RegisterForClicks("AnyUp")
	check:SetPoint("TOPLEFT")
	check:SetWidth(15)
	check:SetHeight(15)
	check:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
	check:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
	check:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
	check:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
	check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
	check:Hide()
	
	return check
end

function WoWPro:CreateAction(parent, anchor)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetPoint("LEFT", anchor, "RIGHT", 3, 0)
	frame:SetWidth(15)
	frame:SetHeight(15)

	local action = frame:CreateTexture()
	action.frame = frame
	action:SetAllPoints()
	
	return action
end
	
function WoWPro:CreateStep(parent, anchor)
	local step = parent:CreateFontString(nil, nil, "GameFontHighlight")
	step:SetPoint("LEFT", anchor, "RIGHT", 3, 0)
	step:SetPoint("RIGHT")
	step:SetJustifyH("LEFT")
	
	return step
end

function WoWPro:CreateNote(parent, anchor1)
	local note = parent:CreateFontString(nil, nil, "GameFontNormalSmall")
	note:SetPoint("TOPLEFT", anchor1, "BOTTOMLEFT", 0, -3)
	note:SetPoint("RIGHT")
	note:SetJustifyH("LEFT")
	note:SetJustifyV("TOP")
	
	return note
end

function WoWPro:CreateTrack(parent, anchor1)
	local track = parent:CreateFontString(nil, nil, "GameFontNormalSmall")
	track:SetPoint("TOPLEFT", anchor1, "BOTTOMLEFT", 0, -3)
	track:SetPoint("RIGHT")
	track:SetJustifyH("LEFT")
	track:SetJustifyV("TOP")
	
	return track
end

function WoWPro:CreateItemButton(parent, id)
	local itembutton = CreateFrame("Button", "WoWPro_itembutton"..id, parent, "SecureActionButtonTemplate")
	itembutton:SetAttribute("type", "item")
	itembutton:SetFrameStrata("LOW")
	itembutton:SetHeight(32)
	itembutton:SetWidth(32)
	itembutton:SetPoint("TOPRIGHT", parent, "TOPLEFT", -10, -7)

	local cooldown = CreateFrame("Cooldown", nil, itembutton)
	cooldown:SetAllPoints(itembutton)

	local itemicon = itembutton:CreateTexture(nil, "ARTWORK")
	itemicon:SetWidth(36) itemicon:SetHeight(36)
	itemicon:SetTexture("Interface\\Icons\\INV_Misc_Bag_08")
	itemicon:SetAllPoints(itembutton)

	itembutton:RegisterForClicks("anyUp")
	itembutton:Hide()
	
	return itembutton, itemicon, cooldown
end

function WoWPro:CreateTargetButton(parent, id)
	local targetbutton = CreateFrame("Button", "WoWPro_targetbutton"..id, parent, "SecureActionButtonTemplate")
	targetbutton:SetAttribute("type", "macro")
	targetbutton:SetFrameStrata("LOW")
	targetbutton:SetHeight(32)
	targetbutton:SetWidth(32)
	targetbutton:SetPoint("TOPRIGHT", parent, "TOPLEFT", -35, -7)

	local targeticon = targetbutton:CreateTexture(nil, "ARTWORK")
	targeticon:SetWidth(36) targeticon:SetHeight(36)
	targeticon:SetTexture("Interface\\Icons\\Ability_Marksmanship")
	targeticon:SetAllPoints(targetbutton)

	targetbutton:RegisterForClicks("anyUp")
	targetbutton:Hide()
	
	return targetbutton, targeticon
end

function WoWPro:CreateHeading(parent, text, subtext)
	local title = parent:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(text)

	local subtitle = parent:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	subtitle:SetHeight(32)
	subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	subtitle:SetPoint("RIGHT", parent, -32, 0)
	subtitle:SetNonSpaceWrap(true)
	subtitle:SetJustifyH("LEFT")
	subtitle:SetJustifyV("TOP")
	subtitle:SetText(subtext)

	return title, subtitle
end

function WoWPro:CreateBG(parent)
	local bg = {
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	}
	local box = CreateFrame('Frame', nil, parent)
	box:SetBackdrop(bg)
	box:SetBackdropBorderColor(0.2, 0.2, 0.2)
	box:SetBackdropColor(0.1, 0.2, 0.1, 0.5)
	
	return box
end

function WoWPro:CreateTab(name, parent)

	local bg = {
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		tile = true,
		tileSize = 16,
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	}
	local tab = CreateFrame('Button', nil, parent)
	tab:SetBackdrop(bg)
	tab:SetBackdropColor(0.1, 0.1, 0.1, 1)
	tab:RegisterForClicks("anyUp")
	
	tab.border = tab:CreateTexture('border')
	tab.border:SetAllPoints(tab)
	tab.border:SetPoint("BOTTOM", 0, 5)
	tab.border:SetTexture("Interface\\OPTIONSFRAME\\UI-OptionsFrame-InactiveTab")
	
	tab.text = tab:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	tab.text:SetHeight(35)
	tab.text:SetPoint("TOPLEFT", tab, "TOPLEFT", 0, -3)
	tab.text:SetPoint("TOPRIGHT", tab, "TOPRIGHT", 0, -3)
	tab.text:SetJustifyH("CENTER")
	tab.text:SetText(name)
	
	tab:SetWidth(tab.text:GetWidth()+20)
	tab:SetHeight(35)
	
	return tab
end

-- Creates a scrollbar
-- Parent is required, offset and step are optional
function WoWPro:CreateScrollbar(parent, offset, step, where)

	local bg = {
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 12,
		insets = { left = 0, right = 0, top = 5, bottom = 5 }
	}

	local f = CreateFrame("Slider", nil, parent)
	f:SetWidth(16)

    local offsetX, offsetY = offset, offset
    if type(offset) == "table" then
        offsetX = offset[1]
        offsetY = offset[2]
    end

    if not where then
	    f:SetPoint("TOPRIGHT", 0 - (offsetX or 0), -16 - (offsetY or 0))
	    f:SetPoint("BOTTOMRIGHT", 0 - (offsetX or 0), 16 + (offsetY or 0))
	elseif where == "Outside" then
	    f:SetPoint("TOPLEFT",parent,"TOPRIGHT",0 - (offsetX or 0), -16 - (offsetY or 0)) 
	    f:SetPoint("BOTTOMLEFT", parent,"BOTTOMRIGHT",0 - (offsetX or 0), 16 + (offsetY or 0))    
    end	

	local up = CreateFrame("Button", nil, f)
	up:SetPoint("BOTTOM", f, "TOP")
	up:SetWidth(16) up:SetHeight(16)
	up:SetNormalTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Up")
	up:SetPushedTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Down")
	up:SetDisabledTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Disabled")
	up:SetHighlightTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Highlight")

	up:GetNormalTexture():SetTexCoord(1/4, 3/4, 1/4, 3/4)
	up:GetPushedTexture():SetTexCoord(1/4, 3/4, 1/4, 3/4)
	up:GetDisabledTexture():SetTexCoord(1/4, 3/4, 1/4, 3/4)
	up:GetHighlightTexture():SetTexCoord(1/4, 3/4, 1/4, 3/4)
	up:GetHighlightTexture():SetBlendMode("ADD")

	up:SetScript("OnClick", function(self)
		local parent = self:GetParent()
		parent:SetValue(parent:GetValue() - (step or parent:GetHeight()/2))
		PlaySound("UChatScrollButton")
	end)

	local down = CreateFrame("Button", nil, f)
	down:SetPoint("TOP", f, "BOTTOM")
	down:SetWidth(16) down:SetHeight(16)
	down:SetNormalTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Up")
	down:SetPushedTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Down")
	down:SetDisabledTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Disabled")
	down:SetHighlightTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Highlight")

	down:GetNormalTexture():SetTexCoord(1/4, 3/4, 1/4, 3/4)
	down:GetPushedTexture():SetTexCoord(1/4, 3/4, 1/4, 3/4)
	down:GetDisabledTexture():SetTexCoord(1/4, 3/4, 1/4, 3/4)
	down:GetHighlightTexture():SetTexCoord(1/4, 3/4, 1/4, 3/4)
	down:GetHighlightTexture():SetBlendMode("ADD")

	down:SetScript("OnClick", function(self)
		local parent = self:GetParent()
		parent:SetValue(parent:GetValue() + (step or parent:GetHeight()/2))
		PlaySound("UChatScrollButton")
	end)

	f:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
	local thumb = f:GetThumbTexture()
	thumb:SetWidth(16) thumb:SetHeight(24)
	thumb:SetTexCoord(1/4, 3/4, 1/8, 7/8)

	f:SetScript("OnValueChanged", function(self, value)
		local min, max = self:GetMinMaxValues()
		if value == min then up:Disable() else up:Enable() end
		if value == max then down:Disable() else down:Enable() end
	end)

	local border = CreateFrame("Frame", nil, f)
	border:SetPoint("TOPLEFT", up, -5, 5)
	border:SetPoint("BOTTOMRIGHT", down, 5, -3)
	border:SetBackdrop(bg)
	border:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 0.5)

	return f, up, down, border
end

local ErrorLog = nil
-- Creates a Scrolling Text Window for Error Logs
-- Parent is required, offset and step are optional
function WoWPro:CreateErrorLog(title)
    if ErrorLog then return ErrorLog end
    
    ErrorLog = CreateFrame("Frame", "WoWProErrorLog", UIParent)
    ErrorLog:Hide()
    ErrorLog:SetPoint("CENTER", "UIParent", "CENTER")
    ErrorLog:SetFrameStrata("TOOLTIP")
    ErrorLog:SetHeight(512)
    ErrorLog:SetWidth(768)
    ErrorLog:SetBackdrop({
    	bgFile = "Interface/Tooltips/ChatBubble-Background",
    	edgeFile = "Interface/Tooltips/ChatBubble-BackDrop",
    	tile = true, tileSize = 32, edgeSize = 32,
    	insets = { left = 32, right = 32, top = 32, bottom = 32 }
    })
    ErrorLog:SetBackdropColor(0,0,0, 1)
    ErrorLog:SetMovable(true)
    ErrorLog:SetClampedToScreen(true)

    ErrorLog.Drag = CreateFrame("Button", nil, ErrorLog)
    ErrorLog.Drag:SetPoint("TOPLEFT", ErrorLog, "TOPLEFT", 10,-5)
    ErrorLog.Drag:SetPoint("TOPRIGHT", ErrorLog, "TOPRIGHT", -10,-5)
    ErrorLog.Drag:SetHeight(8)
    ErrorLog.Drag:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")
    
    ErrorLog.Drag:SetScript("OnMouseDown", function() ErrorLog:StartMoving() end)
    ErrorLog.Drag:SetScript("OnMouseUp", function() ErrorLog:StopMovingOrSizing() end)
    
    ErrorLog.Mesg = ErrorLog:CreateFontString("", "OVERLAY", "GameFontNormalSmall")
    ErrorLog.Mesg:SetJustifyH("CENTER")
    ErrorLog.Mesg:SetPoint("BOTTOMLEFT",ErrorLog, "BOTTOMLEFT", -10, 0)
    ErrorLog.Mesg:SetPoint("RIGHT", ErrorLog, "RIGHT", 15, 0)
    ErrorLog.Mesg:SetHeight(20)
    ErrorLog.Mesg:SetText("Select All and Copy the above error message to report this log. Hit ESC to close.")
    
    ErrorLog.Title = ErrorLog:CreateFontString("", "OVERLAY", "GameFontNormal")
    ErrorLog.Title:SetJustifyH("CENTER")
    ErrorLog.Title:SetPoint("TOPRIGHT",ErrorLog, "TOPRIGHT", -5, -5)
    ErrorLog.Title:SetPoint("TOPLEFT", ErrorLog, "RIGHT", 5, -5)
    ErrorLog.Title:SetHeight(20)
    ErrorLog.Title:SetText(title)
    
    ErrorLog.Scroll = CreateFrame("ScrollFrame", "WoWProErrorLogScroll", ErrorLog, "UIPanelScrollFrameTemplate")
    ErrorLog.Scroll:SetPoint("TOPLEFT", ErrorLog, "TOPLEFT", 20, -20)
    ErrorLog.Scroll:SetPoint("RIGHT", ErrorLog, "RIGHT", -30, 0)
    ErrorLog.Scroll:SetPoint("BOTTOM", ErrorLog, "BOTTOM", 0, 20)
    
    ErrorLog.Box = CreateFrame("EditBox", "WoWProErrorLogEditBox", ErrorLog.Scroll)
    ErrorLog.Box:SetHeight(512)
    ErrorLog.Box:SetWidth(768)
    ErrorLog.Box:SetMultiLine(true)
    ErrorLog.Box:SetFontObject(GameFontHighlight)
    ErrorLog.Box:SetScript("OnEscapePressed", function () ErrorLog:Hide() end)
    ErrorLog.Box:SetScript("OnEditFocusGained", function () ErrorLog.Box:HighlightText() end)
    
    ErrorLog.Scroll:SetScrollChild(ErrorLog.Box)
    
    return ErrorLog
end


