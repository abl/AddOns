-- Code from BlizzBugsSuck (http://www.wowace.com/addons/blizzbugssuck/)

local wow_version, wow_build, wow_data, tocversion = GetBuildInfo()
wow_build = tonumber(wow_build)

-- Fix incorrect translations in the German Locale.  For whatever reason
-- Blizzard changed the oneletter time abbreviations to be 3 letter in
-- the German Locale.
if GetLocale() == "deDE" then
	-- This one confirmed still bugged as of Mists of Pandaria build 16030
	DAY_ONELETTER_ABBR = "%d d"
end

-- fixes the issue with InterfaceOptionsFrame_OpenToCategory not actually opening the Category (and not even scrolling to it)
-- Confirmed still broken in Mists of Pandaria as of build 17538 (5.4.1)
do
	local function get_panel_name(panel)
		local tp = type(panel)
		local cat = INTERFACEOPTIONS_ADDONCATEGORIES
		if tp == "string" then
			for i = 1, #cat do
				local p = cat[i]
				if p.name == panel then
					if p.parent then
						return get_panel_name(p.parent)
					else
						return panel
					end
				end
			end
		elseif tp == "table" then
			for i = 1, #cat do
				local p = cat[i]
				if p == panel then
					if p.parent then
						return get_panel_name(p.parent)
					else
						return panel.name
					end
				end
			end
		end
	end

	local function InterfaceOptionsFrame_OpenToCategory_Fix(panel)
		if doNotRun or InCombatLockdown() then return end
		local panelName = get_panel_name(panel)
		if not panelName then return end -- if its not part of our list return early
		local noncollapsedHeaders = {}
		local shownpanels = 0
		local mypanel
		local t = {}
		local cat = INTERFACEOPTIONS_ADDONCATEGORIES
		for i = 1, #cat do
			local panel = cat[i]
			if not panel.parent or noncollapsedHeaders[panel.parent] then
				if panel.name == panelName then
					panel.collapsed = true
					t.element = panel
					InterfaceOptionsListButton_ToggleSubCategories(t)
					noncollapsedHeaders[panel.name] = true
					mypanel = shownpanels + 1
				end
				if not panel.collapsed then
					noncollapsedHeaders[panel.name] = true
				end
				shownpanels = shownpanels + 1
			end
		end
		local Smin, Smax = InterfaceOptionsFrameAddOnsListScrollBar:GetMinMaxValues()
		if shownpanels > 15 and Smin < Smax then 
		  local val = (Smax/(shownpanels-15))*(mypanel-2)
		  InterfaceOptionsFrameAddOnsListScrollBar:SetValue(val)
		end
		doNotRun = true
		InterfaceOptionsFrame_OpenToCategory(panel)
		doNotRun = false
	end

	hooksecurefunc("InterfaceOptionsFrame_OpenToCategory", InterfaceOptionsFrame_OpenToCategory_Fix)
end

-- Avoid taint from the UIFrameFlash usage of the chat frames.  More info here:
-- http://forums.wowace.com/showthread.php?p=324936

-- Fixed by embedding LibChatAnims


-- Fix an issue where the PetJournal drag buttons cannot be clicked to link a pet into chat
-- The necessary code is already present, but the buttons are not registered for the correct click
-- Confirmed still broken in Mists of Pandaria as of build 17538 (5.4.1)
if true then
        local frame = CreateFrame("Frame")
        frame:RegisterEvent("ADDON_LOADED")
        frame:SetScript("OnEvent", function(self, event, name)
                if event == "ADDON_LOADED" and name == "Blizzard_PetJournal" then
			for i=1,3 do
				local d = _G["PetJournalLoadoutPet"..i]
				d = d and d.dragButton
				if d then d:RegisterForClicks("LeftButtonUp") end
			end
                end
        end)
end


----------------------------------------------------------------------------------------
--	Fix blank tooltip
----------------------------------------------------------------------------------------
local FixTooltip = CreateFrame("Frame")
FixTooltip:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
FixTooltip:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
FixTooltip:SetScript("OnEvent", function()
	for i = 1, 12 do
		local button = _G["ActionButton" .. i]
		if GameTooltip:GetOwner() == button then
			GameTooltip:Hide()
		end
	end
end)

local FixTooltipBags = CreateFrame("Frame")
FixTooltipBags:RegisterEvent("BAG_UPDATE_DELAYED")
FixTooltipBags:SetScript("OnEvent", function()
	if StuffingFrameBags and StuffingFrameBags:IsShown() then
		GameTooltip:Hide()
	end
end)

----------------------------------------------------------------------------------------
--	Disable tooltip for player arrow on map
----------------------------------------------------------------------------------------
WorldMapPlayerUpper:EnableMouse(false)
WorldMapPlayerLower:EnableMouse(false)

----------------------------------------------------------------------------------------
--	Fix SearchLFGLeave() taint
----------------------------------------------------------------------------------------
local TaintFix = CreateFrame("Frame")
TaintFix:SetScript("OnUpdate", function(self, elapsed)
	if LFRBrowseFrame.timeToClear then
		LFRBrowseFrame.timeToClear = nil
	end
end)