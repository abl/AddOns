local api, _, T = {}, ...
local EV = T.Evie

local f, data, mechanics = CreateFrame("Frame"), {}, {}
f:SetScript("OnUpdate", function() wipe(data) f:Hide() end)

local unfreeStatusOrder = {[GARRISON_FOLLOWER_WORKING]=2, [GARRISON_FOLLOWER_INACTIVE]=1}

local function populateMechanics()
	local q = C_Garrison.GetFollowerAbilityCounterMechanicInfo
	for _, aid in pairs({11, 100, 168, 148, 160, 101, 105, 157, 122}) do
		local mid, _, tex = q(aid)
		mechanics[mid], mechanics[tex:lower():gsub("%.blp$","")] = aid, aid
	end
end
local function AddCounterMechanic(fit, fabid)
	if fabid and fabid > 0 then
		local mid, _, tex = C_Garrison.GetFollowerAbilityCounterMechanicInfo(fabid)
		if tex then
			fit.counters[mid], mechanics[mid], mechanics[tex:lower():gsub("%.blp$","")] = fabid, fabid, fabid
		end
	end
end
function api.GetFollowerInfo()
	if not data.followers then
		local ft = {}
		local t = C_Garrison.GetFollowers()
		for i=1,#t do
			local v = t[i]
			if v.isCollected then
				local fid, fit = v.followerID, v
				v.counters, v.isCombat = {}, v.isCollected and not unfreeStatusOrder[v.status] or false
				for i=1,4 do
					AddCounterMechanic(fit, C_Garrison.GetFollowerAbilityAtIndex(fid, i))
					AddCounterMechanic(fit, C_Garrison.GetFollowerTraitAtIndex(fid, i))
				end
				ft[fid] = fit
			end
		end
		for k, v in pairs(C_Garrison.GetInProgressMissions()) do
			for i=1,#v.followers do
				ft[v.followers[i]].mission, ft[v.followers[i]].missionTimeLeft = v.missionID, v.timeLeft
			end
		end
		data.followers = ft
		f:Show()
	end
	return data.followers
end
function api.GetCounterInfo()
	if not data.counters then
		local ci = {}
		for fid, info in pairs(api.GetFollowerInfo()) do
			for k,v in pairs(info.counters) do
				ci[k] = ci[k] or {}
				ci[k][#ci[k]+1] = fid
			end
		end
		data.counters = ci
		f:Show()
	end
	return data.counters
end
function api.GetMechanicInfo(mid)
	if populateMechanics then
		populateMechanics = populateMechanics()
	end
	if not mechanics[mid] then api.GetFollowerInfo() end
	if mechanics[mid] then
		return C_Garrison.GetFollowerAbilityCounterMechanicInfo(mechanics[mid])
	end
end
function api.GetMissionThreats(missionID)
	local ret, rn, en = {}, 1, select(8,C_Garrison.GetMissionInfo(missionID))
	for i=1,#en do
		for id in pairs(en[i].mechanics) do
			ret[rn], rn = id, rn + 1
		end
	end
	return ret
end
do -- sortByFollowerLevels
	local lvl
	local function cmp(a,b)
		local af, bf, ac, bc = lvl[a], lvl[b], a, b
		if (not af) ~= (not bf) then
			return not not af
		elseif af and bf then
			ac, bc = unfreeStatusOrder[af.status] or 3, unfreeStatusOrder[bf.status] or 3
			if ac == bc then
				ac, bc = af.level or 0, bf.level or 0
			end
			if ac == bc then
				ac, bc = C_Garrison.GetFollowerQuality(a), C_Garrison.GetFollowerQuality(b)
			end
		end
		if ac == bc then ac, bc = a, b end
		return ac > bc
	end
	function api.sortByFollowerLevels(counters, finfo)
		lvl = finfo
		table.sort(counters, cmp)
		return counters
	end
end
function api.GetFMLevel(fmInfo)
	return fmInfo and (fmInfo.iLevel > 600 and fmInfo.iLevel or fmInfo.level) or 0
end
function api.GetLevelEfficiency(fLevel, mLevel)
	if (mLevel or 0) <= fLevel then
		return 1
	elseif mLevel - fLevel <= (mLevel > 100 and 14 or 2) then
		return 0.5
	end
	return 0
end
function api.GetFollowerLevelDescription(fid, mlvl, finfo)
	local finfo, q = finfo or api.GetFollowerInfo()[fid], C_Garrison.GetFollowerQuality(fid)
	local tooLow = api.GetLevelEfficiency(api.GetFMLevel(finfo), mlvl) == 0
	local lc, away = ITEM_QUALITY_COLORS[tooLow and 0 or q].hex, finfo.missionTimeLeft
	if finfo.status == GARRISON_FOLLOWER_INACTIVE then
		away = RED_FONT_COLOR_CODE .. " (" .. GARRISON_FOLLOWER_INACTIVE .. ")"
	elseif finfo.status == GARRISON_FOLLOWER_WORKING then
		away = YELLOW_FONT_COLOR_CODE .. " (" .. GARRISON_FOLLOWER_WORKING .. ")"
	else
		away = away and ("|cffa0a0a0 (" .. away .. ")") or ""
	end
	return ("%s[%d]|r %s%s|r%s"):format(lc, finfo.level < 100 and finfo.level or finfo.iLevel, HIGHLIGHT_FONT_COLOR_CODE, finfo.name, away)
end

do -- CompleteMissions/AbortCompleteMissions
	local curStack, curRewards, curFollowers, curCallback
	local curState, curIndex, completionStep, lastAction, delayIndex, delayMID
	local delayOpen, delayRoll, delayStep do
		local function delay(state, f, d)
			local function delay(minDelay)
				if curState == state and curIndex == delayIndex and curStack[delayIndex].missionID == delayMID then
					local time = GetTime()
					if minDelay then lastAction = math.max(lastAction or (time-d), time - minDelay) end
					if not lastAction or (time-lastAction >= d) then
						lastAction = GetTime()
						f(curStack[curIndex].missionID)
						C_Timer.After(d, delay)
					else
						C_Timer.After(math.max(0.1, d + lastAction - time), delay)
					end
				end
			end
			return delay
		end
		delayOpen = delay("COMPLETE", C_Garrison.MarkMissionComplete, 0.4)
		delayRoll = delay("BONUS", C_Garrison.MissionBonusRoll, 0.4)
		function delayStep()
			completionStep("GARRISON_MISSION_NPC_OPENED")
		end
	end
	function completionStep(ev, ...)
		if not curState then return end
		local mi = curStack[curIndex]
		while mi and (mi.succeeded or mi.failed) do
			mi, curIndex = curStack[curIndex+1], curIndex + 1
		end
		if (ev == "GARRISON_MISSION_NPC_CLOSED" and mi) or not mi then
			securecall(curCallback, mi and "ABORT" or "DONE", curStack, curRewards, curFollowers)
			curState, curStack, curRewards, curFollowers, curIndex, curCallback, delayMID, delayIndex = nil
		elseif curState == "NEXT" and ev == "GARRISON_MISSION_NPC_OPENED" then
			if mi.state == -1 then
				curState, delayIndex, delayMID = "COMPLETE", curIndex, mi.missionID
				delayOpen(... == "IMMEDIATE" and 0 or 0.2)
			else
				mi.materialMultiplier = select(8, C_Garrison.GetPartyMissionInfo(mi.missionID))
				curState, delayIndex, delayMID = "BONUS", curIndex, mi.missionID
				delayRoll(... == "IMMEDIATE" and 0 or 0.2)
			end
		elseif curState == "COMPLETE" and ev == "GARRISON_MISSION_COMPLETE_RESPONSE" then
			local mid, cc, ok = ...
			if mid ~= mi.missionID and not cc then return end
			assert(mid == mi.missionID, "Unexpected mission completion")
			if ok then
				mi.state, curState = 0, "BONUS"
				if not mi.materialMultiplier then
					mi.materialMultiplier = select(8, C_Garrison.GetPartyMissionInfo(mi.missionID))
				end
			else
				mi.failed, curState, curIndex = cc and true or nil, "NEXT", curIndex + 1
			end
			securecall(curCallback, "STEP", curStack, curRewards, curFollowers)
			if ok then
				delayIndex, delayMID = curIndex, mi.missionID
				delayRoll(0.2)
			else
				C_Timer.After(0.25, delayStep)
			end
		elseif curState == "BONUS" and ev == "GARRISON_MISSION_BONUS_ROLL_COMPLETE" then
			local mid, _ok = ...
			assert(mid == mi.missionID, "Unexpected bonus roll completion")
			mi.succeeded, curState, curIndex = true, "NEXT", curIndex + 1
			if mi.rewards then
				for k,r in pairs(mi.rewards) do
					if r.currencyID and r.quantity then
						local ik, q = "cur:" .. r.currencyID, r.quantity
						if r.currencyID == GARRISON_CURRENCY then
							q = floor(q*(mi.materialMultiplier or 1))
						end
						curRewards[ik] = curRewards[ik] or {quantity=0, currencyID=r.currencyID}
						curRewards[ik].quantity = curRewards[ik].quantity + q
					elseif r.itemID and r.quantity then
						local ik = "item:" .. r.itemID
						curRewards[ik] = curRewards[ik] or {itemID=r.itemID, quantity=0}
						curRewards[ik].quantity = curRewards[ik].quantity + r.quantity
					end
				end
			end
			securecall(curCallback, "STEP", curStack, curRewards, curFollowers)
		end
	end
	local function lootEvent(event, msg)
		if curState then
			local id = msg:match("item:(%d+)")
			if id == "114120" or id == "114119" or id == "114116" then
				local ik = "item:" .. id
				curRewards[ik] = curRewards[ik] or {itemID=tonumber(id), quantity=0}
				curRewards[ik].quantity = (curRewards[ik].quantity or 0) + 1
			end
		end
	end
	EV.RegisterEvent("GARRISON_FOLLOWER_XP_CHANGED", function(ev, fid, xpAward, oldXP, olvl, oqual)
		if curState then
			curFollowers[fid] = curFollowers[fid] or {olvl=olvl, oqual=oqual, xpAward=0, oxp=oldXP}
			curFollowers[fid].xpAward = curFollowers[fid].xpAward + xpAward
		end
	end)
	EV.RegisterEvent("GARRISON_MISSION_NPC_OPENED", completionStep)
	EV.RegisterEvent("GARRISON_MISSION_NPC_CLOSED", completionStep)
	EV.RegisterEvent("GARRISON_MISSION_BONUS_ROLL_COMPLETE", completionStep)
	EV.RegisterEvent("GARRISON_MISSION_COMPLETE_RESPONSE", completionStep)
	EV.RegisterEvent("CHAT_MSG_LOOT", lootEvent)
	function api.CompleteMissions(stack, callback)
		curStack, curCallback, curRewards, curFollowers = stack, callback, {}, {}
		curState, curIndex = "NEXT", 1
		completionStep("GARRISON_MISSION_NPC_OPENED", "IMMEDIATE")
	end
	function api.AbortCompleteMissions()
		completionStep("GARRISON_MISSION_NPC_CLOSED")
	end
	function api.GetCompletionState()
		return curState, curIndex, curStack, curRewards, curFollowers
	end
end

T.Garrison = api