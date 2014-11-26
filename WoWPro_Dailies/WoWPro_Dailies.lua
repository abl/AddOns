------------------------------
--      WoWPro_Dailies      --
------------------------------

WoWPro.Dailies = WoWPro:NewModule("Dailies")
local myUFG = UnitFactionGroup("player")
WoWPro:Embed(WoWPro.Dailies)
local bucket = LibStub("AceBucket-3.0")

-- Called before all addons have loaded, but after saved variables have loaded. --
function WoWPro.Dailies:OnInitialize()
    -- Nothing for now
end

-- Called when the module is enabled, and on log-in and /reload, after all addons have loaded. --
function WoWPro.Dailies:OnEnable()
	WoWPro:dbp("|cff33ff33Enabled|r: Dailies Module")

	
	-- Event Registration --
	WoWPro.Dailies.Events = {"QUEST_COMPLETE", "GOSSIP_SHOW",
		"ZONE_CHANGED", "ZONE_CHANGED_INDOORS", "MINIMAP_ZONE_CHANGED", "ZONE_CHANGED_NEW_AREA", 
		"CHAT_MSG_SYSTEM"
	}
	WoWPro:RegisterEvents(WoWPro.Dailies.Events)
	--Loading Frames--
	if not WoWPro.Dailies.FramesLoaded then --First time the addon has been enabled since UI Load
		WoWPro.Dailies:CreateConfig()
		WoWPro.Dailies.FramesLoaded = true
	end
	
	-- Creating empty user settings if none exist --
	WoWPro_DailiesDB = WoWPro_DailiesDB or {}
	WoWProCharDB.Guide = WoWProCharDB.Guide or {} 
	WoWProCharDB.completedQIDs = WoWProCharDB.completedQIDs or {}
	WoWPro.Dailies.RecordQIDs = true
	
	if WoWProDB.char.lastdailiesguide and not WoWProDB.char.currentguide then
		WoWPro:LoadGuide(WoWProDB.char.lastdailiesguide)
	end
	
	WoWPro.FirstMapCall = true
	
end

-- Called when the module is disabled --
function WoWPro.Dailies:OnDisable()
	-- Unregistering Dailies Module Events --
	WoWPro:UnregisterEvents(WoWPro.Dailies.Events)
	
	--[[ If the current guide is a dailies guide, removes the map point, stores the guide's ID to be resumed later, 
	sets the current guide to nil, and loads the nil guide. ]]
	if WoWPro.Guides[WoWProDB.char.currentguide] and WoWPro.Guides[WoWProDB.char.currentguide].guidetype == "Dailies" then
		WoWPro:RemoveMapPoint()
		WoWProDB.char.lastdailiesguide = WoWProDB.char.currentguide
	end
end

-- Guide Registration Function --
function WoWPro.Dailies:RegisterGuide(GIDvalue, zonename, guidename, categoryname, authorname, factionname, sequencevalue)
	
--[[ Purpose: 
		Called by guides to register them to the WoWPro.Guide table. All members
		of this table must have a quidetype parameter to let the addon know what 
		module should handle that guide.]]
		
	if factionname and factionname ~= myUFG and factionname ~= "Neutral" then return end 
		-- If the guide is not of the correct faction, don't register it
		
	WoWPro.Guides[GIDvalue] = {
		guidetype = "Dailies",
		GID = GIDvalue,
		zone = zonename,
		name = guidename,
		category = categoryname,
		author = authorname,
		sequence = sequencevalue,
	}
end

function WoWPro.Dailies:GuideFaction(guide,faction)
    guide.faction = tonumber(faction)
end

function WoWPro.Dailies:GuideNameAndCategory(guide,name,cat)
    guide.name = name
    if cat then  
        guide.category = cat
    else
        guide.category = zone
    end
end

-- Use Grail to go a crude guide for a zone.  Pass in the mapID and it will find all the quests that start/end in that zone.
function WoWPro.Dailies:DumpInfo()
    local zoneID = 951
    WoWPro.Dailies.eBox = WoWPro.Dailies.eBox or CreateFrame("EditBox", nil,UIParent,ChatFrameEditBoxTemplate)
    local eBox = WoWPro.Dailies.eBox
    eBox:SetWidth(512)
    eBox:SetHeight(256)
    eBox:SetMultiLine(true)
    eBox:SetAutoFocus(true)
    eBox:SetFontObject(GameFontHighlight)
    local text=""
    Grail:CreateIndexedQuestList()
    -- Ask for the list of quests in the zone 
    for _,quid in pairs(Grail:QuestsInMap(zoneID,true)) do
        local pre = WoWPro:GrailQuestPrereq(quid)
        local turnin_npc = Grail:QuestNPCTurnins(quid)
        local accept_npc = Grail:QuestNPCAccepts(quid)
        local name = Grail:QuestName(quid)
        local accept_m = (accept_npc and accept_npc[1] and Grail:NPCLocations(accept_npc[1],true,true)) 
        local turnin_m = (turnin_npc and turnin_npc[1] and Grail:NPCLocations(turnin_npc[1],true,true))
        local line
        
        if pre then
            pre = "PRE|"..pre.."||"
        else
            pre = ""
        end
        if accept_m then
            
            accept_m = string.format("%s,%s",accept_m[1].x,accept_m[1].y)
        else
            accept_m = "unknown"
        end
        if turnin_m then         
            turnin_m = string.format("%s,%s",turnin_m[1].x,turnin_m[1].y)
        else
            turnin_m = "unknown"
        end
        accept_npc = (accept_npc and accept_npc[1] and Grail:NPCName(accept_npc[1])) or "???"
        turnin_npc = (turnin_npc and turnin_npc[1] and Grail:NPCName(turnin_npc[1])) or "???"
        line = string.format("A %s|QID|%d|M|%s||%sN|From %s.|",name,quid,accept_m,pre,accept_npc)
        text = text .. line .. "\n"
        line = string.format("T %s|QID|%d|M|%s||N|To %s.|",name,quid,turnin_m,turnin_npc)
        text = text .. line .. "\n"
    end
    eBox:SetText(text)
    eBox:SetPoint("CENTER")
    eBox:Show()
    eBox:SetScript("OnEscapePressed", function (self) self:Hide() end)
end
