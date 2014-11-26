--------------------------
--  WoWPro_Events.lua   --
--------------------------

local L = WoWPro_Locale

-- Remeber Taxi Locations
function WoWPro:RecordTaxiLocations(...)
    for i = 1, NumTaxiNodes() do
        local nomen = TaxiNodeName(i)
        local location,zone = string.split(",",nomen)
        if not WoWProCharDB.Taxi[location] then
            WoWProCharDB.Taxi[location] = true
            WoWPro:Print("Discovered Flight Point: [%s]",location)
        end
    end
end

-- Auto-Complete: Use flight point --
function WoWPro:TakeTaxi(index,destination)
    for i = 1, NumTaxiNodes() do
        local nomen = TaxiNodeName(i)
        local location,zone = string.split(",",nomen)
        if location == destination then
            WoWPro:Print("Taking flight to: [%s]",location)
            if IsMounted() then
                Dismount()
            end
            TakeTaxiNode(i)
            WoWPro.CompleteStep(index)
            return
        end
    end
    WoWPro:Warning("Unable to find flight point to: [%s]",destination)
end

-- Auto-Complete: Get flight point --
function WoWPro:AutoCompleteGetFP(...)
	for i = 1,15 do
		local index = WoWPro.rows[i].index
		if ... == ERR_NEWTAXIPATH and WoWPro.action[index] == "f" 
		and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[index] then
			WoWPro.CompleteStep(index)
		end
	end
end

function WoWPro:CheckPlayerForBuffs(buffs)
	local buffies = {}
    local buffIdx
    for buffIdx = 1, select("#",string.split(";",buffs)) do
        local buff = select(buffIdx,string.split(";",buffs))
        buffies[buffIdx] = tonumber(buff)
    end
    local BuffIndex = 1
    local BuffName, _, _, _, _, _, _, _, _, _, BuffSpellId = UnitBuff("player",BuffIndex)
    while BuffName and not skip do
        for buffIdx = 1, #buffies do
            if BuffSpellId == buffies[buffIdx] then
                return BuffSpellId
            end
        end
        BuffIndex = BuffIndex + 1
        BuffName, _, _, _, _, _, _, _, _, _, BuffSpellId = UnitBuff("player",BuffIndex)
    end
    return nil
end

-- Auto-Complete: Do we have a buff? --
function WoWPro:AutoCompleteBuff(unit,...)
    if unit ~= "player" then return end
	for i = 1,15 do
		local index = WoWPro.rows[i].index
		if WoWPro.buff and WoWPro.buff[index] and  WoWPro:CheckPlayerForBuffs(WoWPro.buff[index]) then
		    WoWPro.CompleteStep(index)
		end
	end
end


-- Update Item Tracking --
function WoWPro.GetLootTrackingInfo(lootitem,lootqty)
--[[Purpose: Creates a string containing:
	- tracked item's name
	- how many the user has
	- how many the user needs
	- a complete symbol if the ammount the user has is equal to the ammount they need 
]]
	if not GetItemInfo(lootitem) then return "" end
	local track = "" 												--If the function did have a track string, adds a newline
	track = track.." - "..GetItemInfo(lootitem)..": " 	--Adds the item's name to the string
	numinbag = GetItemCount(lootitem)		--Finds the number in the bag, and adds a count if supplied
	track = track..numinbag										--Adds the number in bag to the string
	track = track.."/"..lootqty								--Adds the total number needed to the string
	if lootqty == numinbag then
		track = track.." (C)"									--If the user has the requisite number of items, adds a complete marker
	end
	return track													--Returns the track string to the calling function
end

-- Auto-Complete: Loot based --
function WoWPro.AutoCompleteLoot()
	for i = 1,1+WoWPro.ActiveStickyCount do
	    local lootqtyi
		local index = WoWPro.rows[i].index
		if WoWPro.lootitem[index] then
    		if tonumber(WoWPro.lootqty[index]) ~= nil then lootqtyi = tonumber(WoWPro.lootqty[index]) else lootqtyi = 1 end
    		if WoWProDB.profile.track then
    			local track = WoWPro.GetLootTrackingInfo(WoWPro.lootitem[index],lootqtyi)
    			WoWPro.rows[i].track:SetText(strtrim(track))
    			WoWPro:dbp("AutoCompleteLoot: Update tracking text to %s",track)
    		end
    		local itemCount = GetItemCount(WoWPro.lootitem[index])
    		if itemCount >= lootqtyi and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[index] then
    		    WoWPro:dbp("AutoCompleteLoot: Time to complete step.")
    			WoWPro.CompleteStep(index)
    		else
    			WoWPro:dbp("AutoCompleteLoot: Not enough yet!")
    		end
    	end
	end
end

-- Auto-Complete: Quest Update --
function WoWPro:AutoCompleteQuestUpdate(questComplete)
	local GID = WoWProDB.char.currentguide
	if not GID or not WoWPro.Guides[GID] then return end
	if not WoWProCharDB.Guide then return end
	
    WoWPro:dbp("Running: AutoCompleteQuestUpdate(questComplete=%s)",tostring(questComplete))

	for i=1,#WoWPro.action do
	
		local action = WoWPro.action[i]
		local completion = WoWProCharDB.Guide[GID].completion[i]
	    
		if WoWPro.QID[i] then
			local numQIDs = select("#", string.split(";", WoWPro.QID[i]))
			for j=1,numQIDs do
				local QID = select(numQIDs-j+1, string.split(";", WoWPro.QID[i]))
				QID = tonumber(QID)

		        -- Quest Turn-Ins --
		        if WoWPro.CompletingQuest and action == "T" and not completion and WoWPro.missingQuest == QID then
			        WoWPro.CompleteStep(i)
			        WoWProCharDB.completedQIDs[QID] = true
			        WoWPro.CompletingQuest = false
			        WoWPro.missingQuest = nil  -- We got it, dont let the recorder get it!
		        end
		
		        -- Abandoned Quests --
		        if not WoWPro.CompletingQuest and ( action == "A" or action == "C" ) 
		        and completion and WoWPro.missingQuest == QID then
			        WoWProCharDB.Guide[GID].completion[i] = nil
			        WoWPro:UpdateGuide("ACQU: Abandoned Quest")
		        end
		
                -- Quest AutoComplete --
                if questComplete and (action == "A" or action == "C" or action == "T" or action == "N") and QID == questComplete then
                    WoWPro.CompleteStep(i)
                end
		        -- Quest Accepts --
		        if WoWPro.newQuest == QID and action == "A" and not completion then
			        WoWPro.CompleteStep(i)
			        WoWPro.newQuest = nil -- We got it, dont let the recorder get it!
		        end
		
		        -- Quest Completion via QuestLog--
		        if WoWPro.QuestLog[QID] and action == "C" and not completion and WoWPro.QuestLog[QID].complete then
			        WoWPro.CompleteStep(i)
			        WoWPro.oldQuests[QID].complete = true -- We got it, dont let the recorder get it!
		        end
		
		        -- Partial Completion --
		        if WoWPro.QuestLog[QID] and WoWPro.QuestLog[QID].leaderBoard and WoWPro.questtext[i] 
		        and not WoWProCharDB.Guide[GID].completion[i] then 
			        local numquesttext = select("#", string.split(";", WoWPro.questtext[i]))
			        local complete = true
			        for l=1,numquesttext do
				        local lquesttext = select(numquesttext-l+1, string.split(";", WoWPro.questtext[i]))
				        local lcomplete = false
				        if tonumber(lquesttext) then
				            lcomplete = WoWPro.QuestLog[QID].ocompleted[tonumber(lquesttext)]
				        else
    				        for _, objective in pairs(WoWPro.QuestLog[QID].leaderBoard) do --Checks each of the quest log objectives
    					        if lquesttext == objective then --if the objective matches the step's criteria, mark true
    						        lcomplete = true
    					        end
    				        end
    				    end
				        if not lcomplete then complete = false end --if one of the listed objectives isn't complete, then the step is not complete.
			        end
			        if complete then WoWPro.CompleteStep(i) end --if the step has not been found to be incomplete, run the completion function
		        end
		    end
		end		
	end
	
	-- First Map Point --
	if WoWPro.FirstMapCall then
		WoWPro:MapPoint()
		WoWPro.FirstMapCall = false
	end
	
end

			
-- Auto-Complete: Set hearth --
function WoWPro:AutoCompleteSetHearth(...)
	local msg = ...
	local _, _, loc = msg:find(L["(.*) is now your home."])
	if loc then
		WoWProCharDB.Guide.hearth = loc
		for i = 1,15 do
			local index = WoWPro.rows[i].index
			if WoWPro.action[index] == "h" and WoWPro.step[index] == loc 
			and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[index] then
				WoWPro.CompleteStep(index)
			end
		end
	end	
end

-- Auto-Complete: Zone based --
function WoWPro:AutoCompleteZone()
	WoWPro.ActiveStickyCount = WoWPro.ActiveStickyCount or 0
	local currentindex = WoWPro.rows[1+WoWPro.ActiveStickyCount].index
	local action = WoWPro.action[currentindex]
	local step = WoWPro.step[currentindex]
	local coord = WoWPro.map[currentindex]
	local waypcomplete = WoWPro.waypcomplete[currentindex]
	local zonetext, subzonetext = GetZoneText(), string.trim(GetSubZoneText())
	if action == "F" or action == "H" or action == "b" or (action == "R" and not waypcomplete) then
		if step == zonetext or step == subzonetext 
		and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[currentindex] then
			WoWPro.CompleteStep(currentindex)
		end
	end
end

-- Auto-Complete: Criteria Change
function WoWPro.AutoCompleteCriteria()
    if not WoWProDB.char.currentguide then return end

	local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
	local GID = WoWProDB.char.currentguide
	if WoWPro.QID[qidx] and WoWPro:IsQuestFlaggedCompleted(WoWPro.QID[qidx],true) then
		    WoWProCharDB.Guide[GID].completion[qidx] = true
		    WoWProCharDB.completedQIDs[WoWPro.QID[qidx]] = true
		    WoWPro:UpdateGuide("AutoCompleteCriteria") 
	end			
	
end

-- Auto-Complete: Chest Loot, for the silly timeless isle chests
function WoWPro.AutoCompleteChest()
    if not WoWProDB.char.currentguide then return end
    if 951 ~= GetCurrentMapAreaID() then return end

	local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
	local GID = WoWProDB.char.currentguide
	if WoWPro.QID[qidx] and WoWPro:IsQuestFlaggedCompleted(WoWPro.QID[qidx],true) then
		    WoWProCharDB.Guide[GID].completion[qidx] = true
		    WoWProCharDB.completedQIDs[WoWPro.QID[qidx]] = true
		    WoWPro:UpdateGuide("AutoCompleteChest") 
	end			
	
end

-- Auto-Complete: Level based --
function WoWPro:AutoCompleteLevel(...)
	local newlevel = ... or UnitLevel("player")
	if WoWProCharDB.Guide then
		local GID = WoWProDB.char.currentguide
		if not WoWProCharDB.Guide[GID] then return end
		for i=1,WoWPro.stepcount do
			if not WoWProCharDB.Guide[GID].completion[i] 
				and WoWPro.level[i] 
				and tonumber(WoWPro.level[i]) <= newlevel then
					WoWPro.CompleteStep(i)
			end
		end
	end
end


-- Update Quest Tracker --
function WoWPro:UpdateQuestTracker()
	if not WoWPro.GuideFrame:IsVisible() then
	    WoWPro:print("Punting: WoWPro:UpdateQuestTracker()")
	    return
	end
	local GID = WoWProDB.char.currentguide
	if not GID or not WoWPro.Guides[GID] then return end
	
	WoWPro:print("Running WoWPro:UpdateQuestTracker()")
	for i,row in ipairs(WoWPro.rows) do
		local index = row.index
		local questtext = WoWPro.questtext[index] 
		local action = WoWPro.action[index] 
		local lootitem = WoWPro.lootitem[index]
		local step = WoWPro.step[index] 
		local lootqty = WoWPro.lootqty[index] 
		local QID = WoWPro.QID[index]
		local track = ""
		
		if tonumber(lootqty) ~= nil then lootqty = tonumber(lootqty) else lootqty = 1 end
		-- Setting up quest tracker --
		row.trackcheck = false
		
		
        -- Clean up any leftovers
		row.track:SetText(track)

        if action then
            WoWPro:dbp("profile.track=%s action=%s questtext=%s lootitem=%s",tostring(WoWProDB.profile.track),tostring(action),tostring(questtext),tostring(lootitem))		
        end
		if WoWProDB.profile.track and ( action == "C" or questtext or lootitem) then	    
			if QID and WoWPro:QIDsInTable(QID,WoWPro.QuestLog) and WoWPro:QIDsInTable(QID,WoWPro.QuestLog,'leaderBoard') then
			    local qid = WoWPro:QIDInTable(QID,WoWPro.QuestLog)
				local j = WoWPro.QuestLog[qid].index
				row.trackcheck = true
				if not questtext and action == "C" then
				    -- no QO tag specified, lets set something up
				    WoWPro:dbp("UQT: QID %d active, but no QO tag, lets make something up.", qid)
					if WoWPro.QuestLog[qid].leaderBoard[1] then
						track = "- "..WoWPro.QuestLog[qid].leaderBoard[1]
						if select(3,GetQuestLogLeaderBoard(1, j)) then
							track =  track.." (C)"
						end
					end
					for l=1,#WoWPro.QuestLog[qid].leaderBoard do 
						if l > 1 then
							if WoWPro.QuestLog[qid].leaderBoard[l] then
								track = track.."\n- "..WoWPro.QuestLog[qid].leaderBoard[l]
								if select(3,GetQuestLogLeaderBoard(l, j)) then
									track =  track.." (C)"
								end
							end
						end
					end
				elseif questtext then
				    --Partial completion steps only track pertinent objective.
				    WoWPro:dbp("UQT: QID %d active and QO tag of [%s]", qid, questtext)
					local numquesttext = select("#", string.split(";", questtext))
					for l=1,numquesttext do
						local lquesttext = select(numquesttext-l+1, string.split(";", questtext))
						if tonumber(lquesttext) then
						    if WoWPro.QuestLog[qid].leaderBoard[tonumber(lquesttext)] then
						        track = "- " .. WoWPro.QuestLog[qid].leaderBoard[tonumber(lquesttext)]
						    else
						        track = "- " .. "?"
						    end
						    if WoWPro.QuestLog[qid].ocompleted[tonumber(lquesttext)] then
						        track =  track.." (C)"
						    end
						else
    						for m=1,GetNumQuestLeaderBoards(j) do 
    							if GetQuestLogLeaderBoard(m, j) then
    								local _, _, itemName, _, _ = string.find(GetQuestLogLeaderBoard(m, j), "(.*):%s*([%d]+)%s*/%s*([%d]+)");
    								if itemName and string.find(lquesttext,itemName) then
    									track = "- "..GetQuestLogLeaderBoard(m, j)
    									if select(3,GetQuestLogLeaderBoard(m, j)) then
    										track =  track.." (C)"
    									end
    								end
    							end
    						end
    					end
					end
				end
			end
			if lootitem then
				row.trackcheck = true
				if tonumber(lootqty) ~= nil then lootqty = tonumber(lootqty) else lootqty = 1 end
				track = WoWPro.GetLootTrackingInfo(lootitem,lootqty)
			end
		end
        if action then
		    WoWPro:dbp("UQT: Track Text for %s [%s] to '%s'",tostring(action),tostring(step),track)
		end
		row.track:SetText(track)
	end
	if not MaybeCombatLockdown() then WoWPro:RowSizeSet(); WoWPro:PaddingSet() end
end


function WoWPro.EventHandler(frame, event, ...)
    WoWPro:LogEvent(event,...)

	-- Unlocking event processong after things get settled --
	if event == "PLAYER_ENTERING_WORLD" or event == "CINEMATIC_STOP" then
	    WoWPro:print("Setting Timer PEW/CS")
	    WoWPro.InitLockdown = true
	    if event == "PLAYER_ENTERING_WORLD" then
    	    WoWPro.LockdownCounter = 5  -- times until release and give up to wait for other addons
    	    WoWPro.LockdownTimer = 1.5
    	else
    	    WoWPro.LockdownCounter = 3  -- times until release and give up to wait for other addons
    	    WoWPro.LockdownTimer = 0.5
    	end
	end
		
	-- Locking event processong till after things get settled --
	if event == "PLAYER_LEAVING_WORLD" or event == "CINEMATIC_START" then
	    WoWPro:print("Locking Down PLW/CS")
	    WoWPro.InitLockdown = true
	end
	
	if event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" or event == "MINIMAP_ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD" then
	    -- Check to see if the current zone is mapped properly.
	    WoWPro.CheckAstrolabeData()
	end

	if WoWPro.InitLockdown and event == "QUEST_LOG_UPDATE" then
	    WoWPro:SendMessage("WoWPro_PuntedQLU")
	    return
	end
	if WoWPro.InitLockdown and event ~= "ZONE_CHANGED_NEW_AREA" then
	    return
	end
	
	-- Noticing if we are doing a pet battle!
	local guidetype = "WoWPro"
	if WoWProDB.char.currentguide and WoWPro.Guides[WoWProDB.char.currentguide] and WoWPro.Guides[WoWProDB.char.currentguide].guidetype then
	    guidetype = WoWPro.Guides[WoWProDB.char.currentguide].guidetype
	end
	
	if event == "PET_BATTLE_OPENING_START" and (not WoWPro.Hidden) then
		WoWPro:Print("|cff33ff33Pet Battle Auto Hide|r: %s Module",guidetype)
		WoWPro.MainFrame:Hide()
		WoWPro.Titlebar:Hide()
		WoWPro.Hidden = true
			return
	end
	if event == "PET_BATTLE_CLOSE" and WoWPro.Hidden then
		WoWPro:Print("|cff33ff33Pet Battle Exit Auto Show|r: %s Module",guidetype)
		WoWPro.MainFrame:Show()
		WoWPro.Titlebar:Show()
		WoWPro.Hidden = nil		
	end
	
	-- Stop processing if no guide is active or something is odd!
	if not WoWProDB.char.currentguide then return end
	if not WoWPro.Guides[WoWProDB.char.currentguide] then return end
	if  not WoWPro.GuideLoaded then
	    WoWPro:dbp("Suppresssed event processing. Guide %s is not loaded yet!",tostring(WoWProDB.char.currentguide))
        return 
	end
	
	-- Common event Handling across addons
	
	-- Noticing if we have entered a Dungeon!
	if event == "ZONE_CHANGED_NEW_AREA" and WoWProCharDB.AutoHideInsideInstances == true then
	    local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
	    if WoWPro.zone[qidx] and WoWPro:IsInstanceZone(WoWPro.zone[qidx]) and IsInInstance() then
	        WoWPro:Print("|cff33ff33 Suppressing Instance Auto Hide, turn it on after you are done with this guide.|r")
	        WoWProCharDB.AutoHideWorldEventsInsideInstances = false
	        return
	    end
		if IsInInstance() then
			WoWPro:Print("|cff33ff33Instance Auto Hide|r: %s Module",guidetype)
			WoWPro.MainFrame:Hide()
			WoWPro.Titlebar:Hide()
			WoWPro.Hidden = true
			return
		elseif WoWPro.Hidden == true then
			WoWPro:Print("|cff33ff33Instance Exit Auto Show|r: %s Module",guidetype)
			WoWPro.MainFrame:Show()
			WoWPro.Titlebar:Show()
			WoWPro.Hidden = nil
		end
	end


	-- Unlocking guide frame when leaving combat --
	if event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_ENTERING_WORLD" then
		WoWPro:UpdateGuide(event) 
	end
	
	-- Updating party-dependant options --
	if event == "PARTY_MEMBERS_CHANGED" and not MaybeCombatLockdown() then
		WoWPro:UpdateGuide(event) 
	end

	-- Updating WoWPro keybindings --
	if event == "UPDATE_BINDINGS" and not MaybeCombatLockdown() then
		WoWPro:UpdateGuide(event) 
	end

    -- Did we get a buff?
    if event == "UNIT_AURA" and not MaybeCombatLockdown() then
        WoWPro:AutoCompleteBuff(...)
    end
        
	-- Lets see what quests the NPC has:
    if event == "GOSSIP_SHOW" and WoWProCharDB.AutoSelect == true then
        local npcQuests = {GetGossipAvailableQuests()};
        local npcCount = GetNumGossipAvailableQuests();
        local index = 0
        local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
        local myNPC = WoWPro:TargetNpcId()
        for _,item in pairs(npcQuests) do
            if type(item) == "string" then
                index = index + 1
                WoWPro:dbp("ZT: GOSSIP_SHOW index %d/%d, considering [%s]",index,npcCount,item)
                if WoWPro.action[qidx] == "A" then
    		        if WoWPro.QID[qidx] == "*" and WoWPro.NPC[qidx] and tonumber(WoWPro.NPC[qidx]) == myNPC then
    		            WoWPro:dbp("ZZZT %d: GOSSIP_SHOW Inhale %s, prev qcount was %d, new is %d",qidx,item, WoWPro.qcount[qidx], npcCount)
    	                WoWPro.qcount[qidx] = npcCount
    		            SelectGossipAvailableQuest(index)
    		            return
    		        end
    		        if WoWPro.action[qidx] == "A" and item == WoWPro.step[qidx] then
    		            WoWPro:dbp("ZZZT %d: GOSSIP_SHOW Name matches [%s], selecting.",index,item)
    		            SelectGossipAvailableQuest(index)
    		        end
    		    end
            end
        end
        npcQuests =  {GetGossipActiveQuests()};
        index = 0 
        for _,item in pairs(npcQuests) do
            if type(item) == "string" then
                index = index + 1       
		        if WoWPro.action[qidx] == "T" and item == WoWPro.step[qidx] then
		            SelectGossipActiveQuest(index)
		            return
		        end
            end
        end
    end
    
    if event == "QUEST_GREETING" and WoWProCharDB.AutoSelect == true then
        local numAvailableQuests = GetNumAvailableQuests()
        local numActiveQuests = GetNumActiveQuests()
        local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
        local myNPC = WoWPro:TargetNpcId()
        for i=1, numActiveQuests do
            if WoWPro.action[qidx] == "T" and GetActiveTitle(i) == WoWPro.step[qidx] then
		        SelectActiveQuest(i)
		        return
		    end
		end
        for i=1, numAvailableQuests do
            if WoWPro.action[qidx] == "A" then
                if WoWPro.QID[qidx] == "*" and WoWPro.NPC[qidx] and tonumber(WoWPro.NPC[qidx]) == myNPC then
                    WoWPro:dbp("ZZZT %d: QUEST_GREETING Inhale %s, prev qcount was %d, new is %d",qidx, GetAvailableTitle(i), WoWPro.qcount[qidx], -numAvailableQuests)
	                WoWPro.qcount[qidx] = -numAvailableQuests
		            SelectGossipAvailableQuest(i)
		            return
                end
                if GetAvailableTitle(i) == WoWPro.step[qidx] then
                    WoWPro:dbp("ZZZT %d: QUEST_GREETING Name matches [%s], selecting.", i, WoWPro.step[qidx])
		            SelectAvailableQuest(i)
		            return
		        end
		    end
		end
    end
    
    if event == "QUEST_DETAIL" and WoWProCharDB.AutoAccept == true then
        local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
        local questtitle = GetTitleText();
        local myNPC = WoWPro:TargetNpcId()
        WoWPro:dbp("ZZZT %d: QUEST_DETAIL [%s], QID %s",qidx,questtitle,tostring(WoWPro.QID[qidx]))
		if WoWPro.action[qidx] == "A" and (questtitle == WoWPro.step[qidx] or WoWPro.QID[qidx] == "*") then
		    if  WoWPro.QID[qidx] == "*" then
		        if WoWPro.NPC[qidx] and tonumber(WoWPro.NPC[qidx]) == myNPC then
    		        WoWPro:dbp("ZZZT %d: Auto Accept wildcard [%s], %d qcount",qidx,questtitle,WoWPro.qcount[qidx])
    		        WoWPro.qcount[qidx] = WoWPro.qcount[qidx] or 0
    		    else
    		        WoWPro:dbp("ZZZT %d: Auto Accept wildcard [%s] REJECT! Expected NPC %s and found %d",qidx,questtitle,tostring(WoWPro.NPC[qidx]), myNPC)
    		        return
    		    end
		    end
		    AcceptQuest()
		    if WoWPro.QID[qidx] == "*" and WoWProCharDB.AutoSelect then
    		    -- OK, now get the next quest if qcount is set
    		    if WoWPro.qcount[qidx] ~= 0  then
    		        if  WoWPro.qcount[qidx] > 1 then
        		        WoWPro:dbp("ZZZT %d Faking GOSSIP_SHOW, qcount is %d",qidx, WoWPro.qcount[qidx])
        		        WoWPro.EventHandler(frame,"GOSSIP_SHOW")
        		        return
        		    end
        		    if WoWPro.qcount[qidx] < 1 then
        		        WoWPro:dbp("ZZZT %d Faking QUEST_GREETING, qcount is %d",qidx, WoWPro.qcount[qidx])
        		        WoWPro.EventHandler(frame,"QUEST_GREETING")
        		        return
        		    end        		            		    
                    -- We accepted the last quest.
                    WoWPro:dbp("ZZZT: Suck done, finishing %d",qidx)
                    WoWPro.CompleteStep(qidx)
                end
    		end
		end
    end


    if event == "QUEST_PROGRESS" and WoWProCharDB.AutoTurnin == true then
        local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
        local questtitle = GetTitleText();
        WoWPro:dbp("Quest is [%s], matching [%s]",tostring(questtitle),tostring(WoWPro.step[qidx]))
		if WoWPro.action[qidx] == "T" and questtitle == WoWPro.step[qidx] then
		    CompleteQuest()
		end  
    end

    -- Noting that a quest is being completed for quest log update events --
	if event == "QUEST_COMPLETE" then
	    local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
        local questtitle = GetTitleText();
		if WoWProCharDB.AutoTurnin == true and (WoWPro.action[qidx] == "T" or WoWPro.action[qidx] == "A") and questtitle == WoWPro.step[qidx] then
		    if (GetNumQuestChoices() <= 1) then
		        GetQuestReward(1)
		    end
        end
		WoWPro.CompletingQuest = true
		WoWProCharDB.completedQIDs[GetQuestID()] = true
		WoWPro:AutoCompleteQuestUpdate(GetQuestID())
	end
	
	if event == "QUEST_TURNED_IN" or event == "QUEST_ACCEPTED" then
	    local qlidx, qid = ...
	    WoWPro:dbp("%s(%s,%s)",event,qlidx,qid)
	    -- just watch for now
	end
	    
	if event == "TRADE_SKILL_SHOW" then
	    WoWPro:ScanTrade()
    end

	-- Module Event Handlers --
	for name, module in WoWPro:IterateModules() do
		if WoWPro[name].EventHandler 
		and WoWProDB.char.currentguide 
		and WoWPro.Guides[WoWProDB.char.currentguide]
		and guidetype == name 
		then WoWPro[name]:EventHandler(frame, event, ...) end
	end
	
		-- Auto-Completion --
	if event == "TAXIMAP_OPENED" then
		WoWPro:RecordTaxiLocations(...)
		local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
		if WoWPro.action[qidx] == "F" and WoWProCharDB.AutoAccept == true then
		    WoWPro:TakeTaxi(qidx,WoWPro.step[qidx])   
		end
	end
	if event == "CHAT_MSG_SYSTEM" then
		WoWPro:AutoCompleteSetHearth(...)
	end	
	if event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" or event == "MINIMAP_ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" then
		WoWPro:AutoCompleteZone(...)
	end
	if event == "QUEST_LOG_UPDATE" then
		WoWPro:PopulateQuestLog()
		WoWPro:AutoCompleteQuestUpdate(nil)
		WoWPro:UpdateQuestTracker()
		WoWPro:UpdateGuide(event)
		if WoWPro.Recorder then
	        WoWPro:SendMessage("WoWPro_PostQuestLogUpdate")
	    end
	end

	if event == "UI_INFO_MESSAGE" then
		WoWPro:AutoCompleteGetFP(...)
	end
	if event == "GOSSIP_SHOW" then
	    WoWPro.GossipText = strupper(GetGossipText())
	    WoWPro:dbp("GetGossipText: %s",WoWPro.GossipText)
	    WoWPro:UpdateGuide(event)
	end
	if event == "GOSSIP_CLOSED" then
	    WoWPro.GossipText = nil
	end
end

function WoWPro.PuntedQLU()
    if WoWPro.InitLockdown then
        WoWPro:SendMessage("WoWPro_PuntedQLU")
        return
    end
    WoWPro.EventHandler(nil, "QUEST_LOG_UPDATE","-punted-")
end
