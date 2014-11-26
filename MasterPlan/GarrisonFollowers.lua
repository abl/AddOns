local icons, _, T = {}, ...

local function Mechanic_OnEnter(self)
	local id, name = T.Garrison.GetMechanicInfo(self.id)
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
	GameTooltip:AddLine(name)
	local ci, fi = T.Garrison.GetCounterInfo()[id], T.Garrison.GetFollowerInfo()
	if ci then
		GameTooltip:AddLine("Countered by:", 1,1,1)
		T.Garrison.sortByFollowerLevels(ci, fi)
		for i=1,#ci do
			GameTooltip:AddLine(T.Garrison.GetFollowerLevelDescription(ci[i], nil, fi[ci[i]]), 1,1,1)
		end
	else
		GameTooltip:AddLine("You have no followers to counter this mechanic.", 1,0.50,0)
	end
	GameTooltip:Show()
	
end
local function Mechanic_OnLeave(self)
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide()
	end
end
local function countFreeFollowers(f, finfo)
	local ret = 0
	for i=1,#f do
		local st = finfo[f[i]].status
		if not (st == GARRISON_FOLLOWER_INACTIVE or st == GARRISON_FOLLOWER_WORKING) then
			ret = ret + 1
		end
	end
	return ret
end

setmetatable(icons, {__index=function(self, k)
	local f = CreateFrame("Button", nil, GarrisonMissionFrame.FollowerTab, "GarrisonAbilityCounterTemplate")
	f:SetNormalFontObject(GameFontHighlightOutline) f:SetText("0")
	f.Count = f:GetFontString()
	f.Count:ClearAllPoints() f.Count:SetPoint("BOTTOMRIGHT", 0, 2)
	f:SetFontString(f.Count)
	f:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")

	f.Border:Hide()
	f:SetScript("OnClick", function(self)
		GarrisonMissionFrameFollowers.SearchBox:SetText(self.name)
	end)
	f:SetScript("OnEnter", Mechanic_OnEnter)
	f:SetScript("OnLeave", Mechanic_OnLeave)
	f:SetPoint("LEFT", k == 1 and GarrisonMissionFrame.FollowerTab.NumFollowers or self[k-1], "RIGHT", k == 1 and 15 or 4, 0)
	self[k] = f
	return f
end})
local function syncTotals()
	local finfo, cinfo, i = T.Garrison.GetFollowerInfo(), T.Garrison.GetCounterInfo(), 1
	for k=1,10 do
		local _, name, tex = T.Garrison.GetMechanicInfo(k)
		if tex then
			local ico = icons[i]
			ico.Icon:SetTexture(tex)
			ico.Count:SetText(cinfo[k] and countFreeFollowers(cinfo[k], finfo) or "")
			ico:Show()
			ico.id, ico.name, i = k, name, i + 1
		end
	end
	for k, f in pairs(cinfo) do
		if k > 10 then
			local ico, _, name, tex = icons[i], T.Garrison.GetMechanicInfo(k)
			ico.Icon:SetTexture(tex)
			ico.Count:SetText(countFreeFollowers(f, finfo))
			ico:Show()
			ico.id, ico.name, i = k, name, i + 1
		end
	end
	for i=i,#icons do
		icons[i]:Hide()
	end
end
GarrisonMissionFrame.FollowerTab:HookScript("OnShow", syncTotals)