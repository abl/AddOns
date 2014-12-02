-- Support for schools

local FL = LibStub("LibFishing-1.0");
local LT = LibStub("LibTourist-3.0");

-- 5.0.4 has a problem with a global "_" (see some for loops below)
local _

local zmto = FishingBuddy.ZoneMarkerTo;

FishingBuddy.Schools = {};

local CLOSEENOUGH = 15; -- fifteen yards

-- Let's store fishing holes like this
-- FishingBuddy_Info["Schools"][ZONE]
-- Store everything to two digits?

local function AddFishingSchool(kind, fishid, zidx, sidx, x, y)
	local entry = {};
	if ( not zidx ) then
		zidx, sidx = FishingBuddy.GetZoneIndex();
	elseif ( type(zidx) == "string" ) then
		zidx, sidx = FishingBuddy.GetZoneIndex(zidx, 0);
	end
	if ( not x or not y ) then
		_,_,x,y = FL:GetCurrentPlayerPosition();
	end

	-- Okay, the fishing hole is actually between 10 and 20 yards away
	-- roughly in the direction that we're pointing now
	-- since most people face the hole directly, it's a good bet anyway
	local facing = GetPlayerFacing();
	if ( facing ) then
		local zone = FishingBuddy_Info["ZoneIndex"][zidx];
		if ( zone == "UNKNOWN") then
			return;
		end
		
		local yx, yy = LT:GetZoneYardSize(zone);
		if ( yx ) then
			facing = facing + math.pi;
			-- let's average the distance and say 15 yards
			x, y = x * yx, y * yy;
			x, y = x + math.cos(facing)*15, y + math.sin(facing)*15;
			-- put them back in non-yard adjusted format
			x, y = x / yx, y / yy;
		end
	end
	
	local fszc = FishingBuddy.SZSchoolCounts;
	local midx = zmto(zidx, sidx);
	if ( fishid ) then
		if (not fszc[midx]) then
			fszc[midx] = {};
		end
		if ( fszc[midx][fishid] ) then
			fszc[midx][fishid] = fszc[midx][fishid] + 1;
		else
			fszc[midx][fishid] = 1;
		end
	end
	
	if ( not FishingBuddy_Info["FishSchools"] ) then
		FishingBuddy_Info["FishSchools"] = {};
	end
	if ( not FishingBuddy_Info["FishSchools"][zidx] ) then
		FishingBuddy_Info["FishSchools"][zidx] = {};
	else
		-- how do we find the same pool?
		local C, _, x1, y1 = FL:GetCurrentPlayerPosition();
		-- if we're in an instance, don't do math
		if ( C ) then
			local Z = FishingBuddy.GetBaseZoneIndex(zidx);
			if ( Z == "UNKNOWN") then
				return;
			end
			
			for _,hole in pairs(FishingBuddy_Info["FishSchools"][zidx]) do
				local d,_,_ = LT:GetYardDistance(Z, x, y, Z, hole.x or x, hole.y or y);
				
				if ( d and d < CLOSEENOUGH ) then
					hole.x = hole.x or x;
					hole.y = hole.y or y;
					hole.sidx = hole.sidx or midx;
					if ( fishid ) then
						if ( hole.count ) then
							hole.count = hole.count + 1;
						else
							hole.count = 1;
						end
						if ( hole.fish ) then
							if ( hole.fish[fishid] ) then
								hole.fish[fishid] = hole.fish[fishid] + 1;
								return;
							end
						else
							hole.fish = {};
						end
						hole.fish[fishid] = 1;
					end
					return;
				end
			end
		end
	end
	entry.kind = kind;
	entry.x = x;
	entry.y = y;
	entry.sidx = midx;
	entry.count = 1;
	if ( fishid ) then
		entry.fish = {};
		entry.fish[fishid] = 1;
	end
	tinsert(FishingBuddy_Info["FishSchools"][zidx], entry);

	FishingBuddy.RunHandlers(FBConstants.ADD_SCHOOL_EVT, kind, fishid, zidx, sidx, x, y);

	return true;
end

local function LastCastInPool(poolhint, text)
	if (poolhint) then
		return true;
	else
		return FL:IsFishingPool(text or FL:GetLastTooltipText());
	end
end

local function CheckFishingPool(fishid, poolhint)
	local info = FL:IsFishingPool();
	if ( poolhint or info ) then
		-- if it definitely was a pool (achievement) but we don't recognize it...
		if ( not info ) then
			info = FL:IsFishingPool(FL.SCHOOL);
		end
		if ( AddFishingSchool(info.kind, fishid) and FishingBuddy.GetSettingBool("ShowNewSchools") ) then
			local zone,_ = FL:GetZoneInfo();
			FishingBuddy.Print(FBConstants.ADDSCHOOLMSG, text, zone);
		end
	end
end

local function GetSchools(zidx)
	if ( not zidx ) then
		zidx = FishingBuddy.GetZoneIndex();
	elseif ( type(zidx) == "string" ) then
		zidx = FishingBuddy.GetZoneIndex(zidx);
	end
	if ( FishingBuddy_Info["FishSchools"] and FishingBuddy_Info["FishSchools"][zidx] ) then
		return FishingBuddy_Info["FishSchools"][zidx];
	else
		return {};
	end
end
FishingBuddy.Schools.GetSchools = GetSchools;

local function CollapseHoles()
	if ( FishingBuddy_Info["FishSchools"] ) then
		local zonecopy = {};
		for zidx,holes in pairs(FishingBuddy_Info["FishSchools"]) do
			local copy = {};
			for _,hole in pairs(holes) do
				tinsert(copy, hole);
			end
			zonecopy[zidx] = copy;
		end
		for zidx,holes in pairs(zonecopy) do
			FishingBuddy_Info["FishSchools"][zidx] = nil;
			for _,hole in pairs(holes) do
				if ( hole.fish ) then
					for f,c in pairs(hole.fish) do
						for i=1,c do
							AddFishingSchool(hole.kind, f, zidx, hole.sidx, hole.x or 0, hole.y or 0);
						end
					end
				else
					AddFishingSchool(hole.kind, nil, zidx, hole.sidx, hole.x or 0, hole.y or 0);
				end
			end
		end
	end
end
FishingBuddy.Schools.CollapseHoles = CollapseHoles;

-- The ones that have "school" in their names shouldn't be
-- necessary, but do they all translate that way? We'll skip
-- them for now, and just do the ones that aren't schools
local nonschoolfish = {
	13422,			-- Stonescale Eel Swarm
	
	74857,			-- Giant Mantis Shrimp Swarm
	74864,			-- Reef Octopus Swarm
};

-- In Outland, the names don't match at all, so we have to
-- depend on finding "School" in the pool name
local schoolfish = {
	6359,			-- Firefin Snapper School
	6358,			-- Oily Blackmouth School
	21153,			-- Greater Sagefish School
	21071,			-- Sagefish School
	6522,			-- School of Deviate Fish

	41805,			-- Borean Man O' War School
	41800,			-- Deep Sea Monster Belly School
	41807,			-- Dragonfin Angelfish School
	41810,			-- Fangtooth Herring School
	41809,			-- Glacial Salmo School
	41814,			-- Glassfin Minnow School
	41802,			-- Imperial Manta Ray School
	41801,			-- Moonglow Cuttlefish School
	41806,			-- Musselback Sculpin School
	41813,			-- Nettlefish School
	
	53065,			-- Albino Cavefish School
	53066,			-- Blackbelly Mudfish School
	53072,			-- Deepsea Sagefish School
	53070,			-- Fathom Eel School
	53064,			-- Highland Guppy School
	53063,			-- Mountain Trout School
	52325,			-- Volatile Fire (this won't actually work)
	
	74856,			-- Jade Lungfish School
	74859,			-- Emperor Salmon School
	74860,			-- Redbelly Mandarin School
	74861,			-- Tiger Gourami School
	74863,			-- Jewel Danio School
	74865,			-- Krasarang Paddlefish School
	83064,			-- Spine Fish School
};

FishingBuddy.AddSchoolFish = function()
	local loc = GetLocale();
	local raw = FishingBuddy.StripRaw;
	local fi = FishingBuddy_Info["Fishies"];
	if ( fi ) then
		for _,id in ipairs(nonschoolfish) do
			if ( fi[id] and fi[id][loc] ) then
				local name = raw(fi[id][loc]);
				FL:AddSchoolName(name);
			end
		end
	end
end

local SchoolEvents = {};
SchoolEvents[FBConstants.ADD_FISHIE_EVT] = function(id, name, zone, subzone, texture, quantity, quality, level, idx, poolhint)
	CheckFishingPool(id, poolhint);
end

SchoolEvents[FBConstants.RESET_FISHDATA_EVT] = function()
	FishingBuddy_Info["FishSchools"] = {};
end

FishingBuddy.RegisterHandlers(SchoolEvents);

if (FishingBuddy.Debugging) then
	-- let an external entity forcibly mark a school
	local function MarkSchool()
		local zone, subzone = FL:GetZoneInfo();
		if ( zone == FBConstants.STVZONENAME ) then
			AddFishingSchool(FL.SCHOOL_TASTY, 19807, zone);
		end
	end
end
