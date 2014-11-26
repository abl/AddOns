
-------------------------------
--      WoWPro_WorldEvents      --
-------------------------------

WoWPro.WorldEvents = WoWPro:NewModule("WorldEvents")
local myUFG = UnitFactionGroup("player")
WoWPro:Embed(WoWPro.WorldEvents)
local bucket = LibStub("AceBucket-3.0")

-- Called before all addons have loaded, but after saved variables have loaded. --
function WoWPro.WorldEvents:OnInitialize()
    -- Legacy option.  Destroy!
	WoWProCharDB.AutoHideWorldEventsInsideInstances = nil
end

-- Called when the module is enabled, and on log-in and /reload, after all addons have loaded. --
function WoWPro.WorldEvents:OnEnable()
	WoWPro:dbp("|cff33ff33Enabled|r: WorldEvents Module")
	
	-- Event Registration --
	WoWPro.WorldEvents.Events = {"QUEST_COMPLETE", 
		"ZONE_CHANGED", "ZONE_CHANGED_INDOORS", "MINIMAP_ZONE_CHANGED", "ZONE_CHANGED_NEW_AREA", 
		"UI_INFO_MESSAGE", "CHAT_MSG_SYSTEM"
	}
	WoWPro:RegisterEvents(WoWPro.WorldEvents.Events)
	
	--Loading Frames--
	if not WoWPro.WorldEvents.FramesLoaded then --First time the addon has been enabled since UI Load
		WoWPro.WorldEvents:CreateConfig()
		WoWPro.WorldEvents.FramesLoaded = true
	end
	
	WoWPro.FirstMapCall = true
	
end

-- Called when the module is disabled --
function WoWPro.WorldEvents:OnDisable()
	-- Unregistering WorldEvents Module Events --
	WoWPro:UnregisterEvents(WoWPro.WorldEvents.Events)
	
	--[[ If the current guide is a WorldEvents guide, removes the map point, stores the guide's ID to be resumed later, 
	sets the current guide to nil, and loads the nil guide. ]]
	if WoWPro.Guides[WoWProDB.char.currentguide] and WoWPro.Guides[WoWProDB.char.currentguide].guidetype == "WorldEvents" then
		WoWPro:RemoveMapPoint()
		WoWProDB.char.lastWorldEventsguide = WoWProDB.char.currentguide
		WoWProDB.char.currentguide = nil
		WoWPro:LoadGuide()
	end
end

-- Guide Registration Function --
function WoWPro.WorldEvents:RegisterGuide(GIDvalue, zonename, guidename, categoryname, authorname, factionname, sequencevalue)
	
--[[ Purpose: 
		Called by guides to register them to the WoWPro.Guide table. All members
		of this table must have a quidetype parameter to let the addon know what 
		module should handle that guide.]]
		
	if factionname and factionname ~= myUFG and factionname ~= "Neutral" then return end 
		-- If the guide is not of the correct faction, don't register it
		

	WoWPro.Guides[GIDvalue] = {
		guidetype = "WorldEvents",
		GID = GIDvalue,
		zone = zonename,
		name = guidename,
		category = categoryname,
		author = authorname,
		sequence = sequencevalue,
		faction = factionname
	}
end


function WoWPro.WorldEvents:GuideHoliday(guide,holiday, name)
    -- The holiday needs to be a word to match the texture returned from the CalendarGetHolidayInfo() function 
    guide['holiday']=holiday
    if name then
        guide['name']=name
    end

    guide['category']='Holiday'

end

function WoWPro.WorldEvents:GuideWorldEvent(guide, name)
    -- No holiday means World Event
    if name then
        guide['name']=name
    end

    guide['category']='World Event'

end


function WoWPro.WorldEvents:LoadAllGuides()
    self:Print("Test Load of WorldEvents Guides")
    local aCount=0
    local hCount=0
    local nCount=0
    local zed
	for guidID,guide in pairs(WoWPro.Guides) do
	    if WoWPro.Guides[guidID].guidetype == "WorldEvents" then
            self:Print("Test Loading " .. guidID)
	        WoWPro:LoadGuide(guidID)
	        zed = strtrim(string.match(WoWPro.Guides[guidID].zone, "([^%(%-]+)" ))
	        if not WoWPro:ValidZone(zed) then
			    WoWPro:Error("Invalid guide zone:"..(WoWPro.Guides[guidID].zone))
			end
	        if WoWPro.Guides[guidID].faction == "Alliance" then aCount = aCount + 1 end
	        if WoWPro.Guides[guidID].faction == "Neutral"  then nCount = nCount + 1 end
	        if WoWPro.Guides[guidID].faction == "Horde"    then hCount = hCount + 1 end
	    end
	end
        self:Print(string.format("Done! %d A, %d N, %d H guides present", aCount, nCount, hCount))
end	    

