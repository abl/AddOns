-- FishingBuddy
--
-- Everything you wanted support for in your fishing endeavors

local FL = LibStub("LibFishing-1.0");

local gotSetupDone = false;
local lastVersion;
local lastPlayerVersion;
local playerName;
local realmName;

local zmto = FishingBuddy.ZoneMarkerTo;
local zmex = FishingBuddy.ZoneMarkerEx;

FishingBuddy.IsLoaded = function()
	return gotSetupDone;
end

-- if the old information is still there, then we might not have per
-- character saved info, so let's save it away just in case. It'll go
-- away the second time we load the add-on
FishingBuddy.SavePlayerInfo = function()
	if ( FishingBuddy_Info[realmName] and
		  FishingBuddy_Info[realmName]["Settings"] and
		  FishingBuddy_Info[realmName]["Settings"][playerName] ) then
		local tabs = { "Settings", "Outfit", "WasWearing" };
		for _,tab in pairs(tabs) do
			for k,v in pairs(FishingBuddy_Player[tab]) do
				FishingBuddy_Info[realmName][tab][playerName][k] = v;
			end
		end
	end
end

local FishingInit = {};

local function copytable(tab, level)
	return FL:copytable(tab, level);
end

FishingInit.ResetHelpers = function()
	FishingBuddy.SortedZones = {};
	FishingBuddy.SortedByZone = {};
	FishingBuddy.SortedSubZones = {};
	FishingBuddy.UniqueSubZones = {};
	FishingBuddy.SubZoneMap = {};
end

FishingInit.CopyFishingHoles = function()
	local sorted = FishingBuddy.SortedZones;
	local zonecount = table.getn(sorted);
	
	local fh = {};
	local fbfh = FishingBuddy_Info[GetLocale()]["FishingHoles"];
	for i=1,zonecount,1 do
		local zone = sorted[i];
		local subsorted = FishingBuddy.SortedByZone[zone];
		if ( subsorted ) then
			local subcount = table.getn(subsorted);
			for s=1,subcount,1 do
				local subzone = subsorted[s];
				local where = FishingBuddy.GetZoneIndex(zone, subzone, true);
				local _, total = FishingBuddy.FishCount(where);
				if ( fbfh[where] and total > 0) then
					if ( not fh[zone] ) then
						fh[zone] = {};
					end
					if ( not fh[zone][subzone] ) then
						fh[zone][subzone] = {};
					end
					for fishid,count in pairs(fbfh[where]) do
						fh[zone][subzone][fishid] = count;
					end
				end
			end
		end
	end
	return fh;
end

FishingInit.CopyFishSchools = function()
	schools = {};
	if ( FishingBuddy_Info["FishSchools"] ) then
		for zidx,holes in pairs(FishingBuddy_Info["FishSchools"]) do
			local zone = FishingBuddy_Info["ZoneIndex"][zidx];
			schools[zone] = copytable(holes);
		end
	end
	return schools;
end

-- Fill in the player name and realm
FishingInit.SetupNameInfo = function()
	playerName = UnitName("player");
	realmName = GetRealmName();
	return playerName, realmName;
end

FishingInit.CheckPlayerInfo = function()
	local tabs = { "Settings", "Outfit", "WasWearing" };
	if ( not FishingBuddy_Player ) then
		FishingBuddy_Player = {};
		for _,tab in pairs(tabs) do
			FishingBuddy_Player[tab] = { };
		end
		if ( FishingBuddy_Info[realmName] and
			  FishingBuddy_Info[realmName]["Settings"] and
			  FishingBuddy_Info[realmName]["Settings"][playerName] ) then
			for _,tab in pairs(tabs) do
				if ( FishingBuddy_Info[realmName][tab] and
					  FishingBuddy_Info[realmName][tab][playerName] ) then
					for k,v in pairs(FishingBuddy_Info[realmName][tab][playerName]) do
						FishingBuddy_Player[tab][k] = v;
					end
				end
			end
		end
	elseif ( FishingBuddy_Info[realmName] and
			  FishingBuddy_Info[realmName]["Settings"] ) then
		-- the saved information is there, kill the old stuff
		for _,tab in pairs(tabs) do
			if ( FishingBuddy_Info[realmName][tab] ) then
				FishingBuddy_Info[realmName][tab][playerName] = nil;
				-- Duh, table.getn doesn't work because there
				-- aren't any integer keys in this table
				if ( next(FishingBuddy_Info[realmName][tab]) == nil ) then
					FishingBuddy_Info[realmName][tab] = nil;
				end
			end
		end
		if ( next(FishingBuddy_Info[realmName]) == nil ) then
			FishingBuddy_Info[realmName] = nil;
		end
	end
end

FishingInit.CheckPlayerSetting = function(setting, defaultvalue)
	if ( not FishingBuddy_Player["Settings"] ) then
		FishingBuddy_Player["Settings"] = { };
	end
	if ( not FishingBuddy_Player["Settings"][setting] ) then
		FishingBuddy_Player["Settings"][setting] = defaultvalue;
	end
end

FishingInit.CheckGlobalSetting = function(setting, defaultvalue)
	if ( not FishingBuddy_Info[setting] ) then
		if ( not defaultvalue ) then
			FishingBuddy_Info[setting] = {};
		else
			FishingBuddy_Info[setting] = defaultvalue;
		end
	end
end

FishingInit.CheckRealm = function()
	local tabs = { "Settings", "Outfit", "WasWearing" };
	for _,tab in pairs(tabs) do
		if ( FishingBuddy_Info[tab] ) then
			local old = FishingBuddy_Info[tab][playerName];
			if ( old ) then
				if ( not FishingBuddy_Info[realmName] ) then
					FishingBuddy_Info[realmName] = { };
					for _,tab in pairs(tabs) do
						FishingBuddy_Info[realmName][tab] = { };
					end
				end

				FishingBuddy_Info[realmName][tab][playerName] = { };
				for k, v in pairs(old) do
					FishingBuddy_Info[realmName][tab][playerName][k] = v;
				end
				FishingBuddy_Info[tab][playerName] = nil;
			end

			-- clean out cruft, if we have some
			FishingBuddy_Info[tab][UNKNOWNOBJECT] = nil;
			FishingBuddy_Info[tab][UKNOWNBEING] = nil;

			-- Duh, table.getn doesn't work because there
			-- aren't any integer keys in this table
			if ( next(FishingBuddy_Info[tab]) == nil ) then
				FishingBuddy_Info[tab] = nil;
			end
		end
	end
end

FishingInit.SetupZoneMapping = function()
	local continentNames = { GetMapContinents() };
	if ( not FishingBuddy_Info["ZoneIndex"] ) then
		FishingBuddy_Info["ZoneIndex"] = {};
	end
	if ( not FishingBuddy_Info["SubZones"] ) then
		FishingBuddy_Info["SubZones"] = {};
	end
end

FishingInit.CleanLocales = function(loc)
	local locales = {};
	local havelocs = false;
	for oldloc,_ in pairs(FishingBuddy_Info["Locales"]) do
		if ( oldloc ~= loc ) then
			locales[oldloc] = 1;
			havelocs = true;
		end
	end
	if (havelocs) then
		FishingBuddy_Info["Locales"] = locales;
	else
		FishingBuddy_Info["Locales"] = nil;
	end
	return havelocs, locales;
end

FishingInit.ResetFishies = function(zones, subzones, holes, skills)
	local AddFishie = FishingBuddy.AddFishie;
	local questIndex = select('#', GetAuctionItemClasses());
	local questType = select(questIndex, GetAuctionItemClasses());
	FishingInit.ResetHelpers();

	local FI = FishingBuddy_Info["Fishies"];
	for zidx,zone in ipairs(zones) do
		local zmarker = zmto(zidx, 0);
		local szcount = subzones[zmarker];
		if ( szcount ) then
			for sidx=1,szcount do
				local marker = zmto(zidx,sidx);
				local subzone = subzones[marker];
				if ( subzone and holes[marker] ) then
					subzone = FL:GetBaseSubZone(subzone);
					 local level = skills[marker];
					 for fid,count in pairs(holes[marker]) do
						 local color = FI[fid].color;
						 local texture = FI[fid].texture;
						 local name = FI[fid][loc];
						 local quality = FI[fid].quality;
						 local level = skills[marker] or nil;
						 local it, st;
						 if ( FI[fid].quest ) then
							 it = questType;
							 st = questType;
						 end
						 if ( zone == UNKNOWN ) then
							 zone = FBConstants.UNKNOWN;
						 end
						 AddFishie(color, fid, name, zone, subzone, texture, count, quality, level, it, st)
					 end
				end
			end
		end
	end
end

-- Now that we have LibBabble-SubZone, let's just use one table (yay!)
FishingInit.MergeLocale = function(loc)
	if ( not FishingBuddy_Info[loc] ) then
		FishingInit.CleanLocales(loc);
		return;
	end

	local GetZoneIndex = FishingBuddy.GetZoneIndex;
	local AddZoneIndex = FishingBuddy.AddZoneIndex;

	local subzones = copytable(FishingBuddy_Info[loc]["SubZones"], 0);
	local totals = copytable(FishingBuddy_Info[loc]["FishTotals"], 0);
	local skills = copytable(FishingBuddy_Info[loc]["FishingSkill"], 0);
	local holes = copytable(FishingBuddy_Info[loc]["FishingHoles"], 0);
	
	FishingBuddy_Info[loc]["SubZones"] = nil;
	FishingBuddy_Info[loc]["FishTotals"] = nil;
	FishingBuddy_Info[loc]["FishingSkill"] = nil;
	FishingBuddy_Info[loc]["FishingHoles"] = nil;
	FishingBuddy_Info[loc] = nil;

	-- moving data to the top if we're doing this the first time
	if ( not FishingBuddy_Info["FishingHoles"] ) then
		for zidx,name in pairs(FishingBuddy_Info["ZoneIndex"]) do
			local zmarker = zmto(zidx, 0);
			local szcount = subzones[zmarker];
			if ( szcount ) then
				for sidx=1,szcount do
					local marker = zmto(zidx,sidx);
					local name = subzones[marker];
					local newname = FL:GetBaseSubZone(name);
					if ( newname ~= name ) then
						subzones[marker] = newname;
					end
				end
			end
		end
		
		FishingBuddy_Info["SubZones"] = subzones;
		FishingBuddy_Info["FishTotals"] = totals;
		FishingBuddy_Info["FishingSkill"] = skills;
		FishingBuddy_Info["FishingHoles"] = holes;
		
		FishingInit.CleanLocales(loc);
		-- we're done the first time...
		return;
	end

	-- since we're leaving the zones "as is", we don't need to redo FishSchools
	FishingInit.ResetFishies(FishingBuddy_Info["ZoneIndex"], subzones, holes, skills);
	FishingInit.CleanLocales(loc);
end

FishingInit.ResetZones = function()
	FishingInit.ResetHelpers();

	local zones = copytable(FishingBuddy_Info["ZoneIndex"], 0);
	local subzones = copytable(FishingBuddy_Info["SubZones"], 0);
	local totals = copytable(FishingBuddy_Info["FishTotals"], 0);
	local skills = copytable(FishingBuddy_Info["FishingSkill"], 0);
	local holes = copytable(FishingBuddy_Info["FishingHoles"], 0);

	FishingBuddy_Info["ZoneIndex"] = {};
	tinsert(FishingBuddy_Info["ZoneIndex"], FBConstants.UNKNOWN);

	FishingBuddy_Info["SubZones"] = {};
	FishingBuddy_Info["FishTotals"] = {};
	FishingBuddy_Info["FishingSkill"] = {};
	FishingBuddy_Info["FishingHoles"] = {};
	
	FishingInit.ResetFishies(zones, subzones, holes, skills);

	local GetZoneIndex = FishingBuddy.GetZoneIndex;
	local schools = copytable(FishingBuddy_Info["FishSchools"], 0);
	FishingBuddy_Info["FishSchools"] = {};
	for zold,school in pairs(schools) do
		local zidx = GetZoneIndex(zones[zold]);
		if ( zidx ) then
			FishingBuddy_Info["FishSchools"][zidx] = school;
		else
			FishingBuddy.Debug("Failed to find zone '%s' (%d)", zones[zold] or "nil", zold);
		end
	end
end

FishingInit.UpdateFishingDB = function()
	local version = FishingBuddy_Info["Version"];
	if ( not version ) then
		version = 8700; -- be really old
	end

	-- We should have been doing this all along, so let's go way, way back
	playerversion = FishingBuddy_Player["Version"];
	if ( not playerversion ) then
		playerversion = 8700;
	end
	
	local loc = GetLocale();
	-- keep doing this for really, really old versions.
	if ( version < 9701 ) then
		FishingBuddy_Info[loc] = {};
		FishingBuddy_Info[loc]["SubZones"] = copytable(FishingBuddy_Info["SubZones"], 0);
		FishingBuddy_Info[loc]["FishTotals"] = copytable(FishingBuddy_Info["FishTotals"], 0);
		FishingBuddy_Info[loc]["FishingSkill"] = copytable(FishingBuddy_Info["FishingSkill"], 0);
		FishingBuddy_Info[loc]["FishingHoles"] = copytable(FishingBuddy_Info["FishingHoles"], 0);

		FishingBuddy_Info["SubZones"] = nil;
		FishingBuddy_Info["FishTotals"] = nil;
		FishingBuddy_Info["FishingSkill"] = nil;
		FishingBuddy_Info["FishingHoles"] = nil;
		
		for id,info in pairs(FishingBuddy_Info["Fishies"]) do
			if ( info.name ) then
				info[loc] = info.name;
				info.name = nil;
			end
		end
	end
	
	if ( playerversion < 9701 ) then
		if ( FishingBuddy_Player["Settings"]["ClickToSwitch"] ) then
			FishingBuddy_Player["Settings"]["ClickToSwitch"] = 1;
		end
		if ( FishingBuddy_Player["Settings"]["MinimapClickToSwitch"] ) then
			FishingBuddy_Player["Settings"]["MinimapClickToSwitch"] = 1;
		end
	end
	
	if ( not FishingBuddy_Info["Locales"] ) then
		local locales = {};
		for k,v in pairs(FishingBuddy_Info) do
			if ( type(v) == "table" and v["SubZones"] and v["FishingHoles"] ) then
				locales[k] = 1;
			end
		end
		FishingBuddy_Info["Locales"] = locales;
	end

	if (version < 9817) then
		-- Same id, different fish :-(
		local fish = FishingBuddy_Info["Fishies"][45328];
		if ( fish ) then
			local info = {};
			info.mods = fish.mods;
			info.quality = fish.quality;
			info.quest = true;
			info.level = fish.level;
			info.skill = fish.skill;
			info.texture = fish.texture;
			FishingBuddy_Info["Fishies"][45328] = info;
		end
	end

	if (version < 9901) then
		FishingBuddy_Info["GreatAndSmall"] = nil;
		local buddy = FishingBuddy_Info["FishingBuddy"];
		if ( buddy and buddy > 0) then
			FishingBuddy_Info["FishingPetBuddies"] = { buddy  };
		end
		FishingBuddy_Info["FishingBuddy"] = nil;
	end
	
	if (version < 9907) then
		-- throw away bad top level copies of these, we have "loc" versions, which we'll merge below
		FishingBuddy_Info["SubZones"] = nil;
		FishingBuddy_Info["FishTotals"] = nil;
		FishingBuddy_Info["FishingSkill"] = nil;
		FishingBuddy_Info["FishingHoles"] = nil;
		
		-- for now, just do the current locale
		FishingInit.MergeLocale(loc);
	else
		if ( FishingBuddy_Info["Locales"] and FishingBuddy_Info["Locales"][loc] ) then
			-- for now, just do the current locale
			FishingInit.MergeLocale(loc);
		end
	end

	if ( not FishingBuddy_Info["Locales"] or #FishingBuddy_Info["Locales"] == 0 ) then
		-- look for broken ZoneIndex
		local broken = false;
		local check = {};
		for zidx,zone in ipairs(FishingBuddy_Info["ZoneIndex"]) do
			if ( check[zone] ) then
				broken = true;
			else
				check[zone] = zidx;
			end
		end
		if ( broken ) then
			FishingBuddy.Message("Duplicate zones, fixing");
			FishingInit.ResetZones();
		end
	end

	if ( playerversion < 10003 ) then
		FishingBuddy_Player["MinimapButtonVisible"] = nil;
		FishingBuddy_Player["ResetWatcher"] = nil;
	end
	
	if ( playerversion < 10005) then
		if (not FishingBuddy_Player["WatcherLocation"]) then
			FishingBuddy_Player["WatcherLocation"] = {};

			local loc = FishingBuddy_Player["Settings"]["WatcherLocation"];
			if (loc) then
				FishingBuddy_Player["WatcherLocation"].y = loc.y;
				FishingBuddy_Player["WatcherLocation"].x = loc.x;
				FishingBuddy_Player["WatcherLocation"]["point"] = "TOPLEFT";
				FishingBuddy_Player["WatcherLocation"]["scale"] = 1;
			end
		end
		FishingBuddy_Player["Settings"]["WatcherLocation"] = nil;
	end
	
	if (type(FishingBuddy_Player["TotalTimeFishing"]) ~= "number") then
		FishingBuddy_Player["TotalTimeFishing"] = 1;
	end
	
	-- save this for other pieces that might need to update
	lastVersion = version;
	lastPlayerVersion = playerversion;

	FishingBuddy_Info["Version"] = FBConstants.CURRENTVERSION;
	FishingBuddy_Player["Version"] = FBConstants.CURRENTVERSION;
end

FishingBuddy.GetLastVersion = function()
	return lastVersion, lastPlayerVersion;
end

-- Based on code in QuickMountEquip
FishingInit.HookFunction = function(func, newfunc)
	local oldValue = _G[func];
	if ( oldValue ~= _G[newfunc] ) then
		setglobal(func, _G[newfunc]);
		return true;
	end
	return false;
end

-- set up alternate view of fish data. do this as startup to
-- lower overall dynamic hit when loading the window
FishingInit.SetupByFishie = function()
	if ( not FishingBuddy.ByFishie ) then
		local loc = GetLocale();
		local fh = FishingBuddy_Info["FishingHoles"];
		local ff = FishingBuddy_Info["Fishies"];
		FishingBuddy.ByFishie = { };
		FishingBuddy.SortedFishies = { };
		for idx,info in pairs(fh) do
			for id,quantity in pairs(info) do
				if ( not FishingBuddy.ByFishie[id] ) then
					FishingBuddy.ByFishie[id] = { };
					if ( ff[id] ) then
						tinsert(FishingBuddy.SortedFishies,
								  { text = ff[id][loc], id = id });
					end
				end
				if ( not FishingBuddy.ByFishie[id][idx] ) then
					FishingBuddy.ByFishie[id][idx] = quantity;
				else
					FishingBuddy.ByFishie[id][idx] = FishingBuddy.ByFishie[id][idx] + quantity;
				end
			end
		end
		FishingBuddy.FishSort(FishingBuddy.SortedFishies, true);
	end
end

FishingInit.InitSortHelpers = function()
	local fh = FishingBuddy_Info["FishingHoles"];
	FishingInit.ResetHelpers();
	for zidx,zone in ipairs(FishingBuddy_Info["ZoneIndex"]) do
		zone = FL:GetLocZone(zone);
		tinsert(FishingBuddy.SortedZones, zone);
		FishingBuddy.SortedByZone[zone] = {};
		local idx = zmto(zidx, 0);
		local count = FishingBuddy_Info["SubZones"][idx];
		if ( count ) then
			for s=1,count,1 do
				idx = zmto(zidx,s);
				local subzone = FL:GetLocSubZone(FishingBuddy_Info["SubZones"][idx]);
				tinsert(FishingBuddy.SortedByZone[zone], subzone);
				FishingBuddy.UniqueSubZones[subzone] = 1;
				if ( not FishingBuddy.SubZoneMap[subzone] ) then
					FishingBuddy.SubZoneMap[subzone] = {};
				end
				FishingBuddy.SubZoneMap[subzone][idx] = 1;
			end
			table.sort(FishingBuddy.SortedByZone[zone]);
		end
	end
	table.sort(FishingBuddy.SortedZones);
	for subzone,_ in pairs(FishingBuddy.UniqueSubZones) do
		tinsert(FishingBuddy.SortedSubZones, subzone);
	end
	table.sort(FishingBuddy.SortedSubZones);
end

FishingInit.SetupSchoolCounts = function()
	local counts = {};
	local zmto = FishingBuddy.ZoneMarkerTo;
	if ( FishingBuddy_Info["FishSchools"] ) then
		for zidx,holes in pairs(FishingBuddy_Info["FishSchools"]) do
			for _,hole in pairs(holes) do
				local sidx = hole.sidx;
				if ( sidx ) then
					-- Fix bad data
					if ( sidx < 1000 ) then
						sidx = zmto(zidx, sidx);
						hole.sidx = sidx;
					end
					if ( hole.fish ) then
						counts[sidx] = counts[sidx] or {};
						for fishid,count in pairs(hole.fish) do
							counts[sidx][fishid] = counts[sidx][fishid] or 0;
							counts[sidx][fishid] = counts[sidx][fishid] + count;
						end
					end
				end
			end
		end
	end
	FishingBuddy.SZSchoolCounts = counts;
end

FishingInit.InitSettings = function()
	if( not FishingBuddy_Info ) then
		FishingBuddy_Info = { };
	end
	-- global stuff
	FishingInit.SetupZoneMapping();
	FishingInit.CheckRealm();

	FishingInit.CheckGlobalSetting("ImppDBLoaded", 0);
	FishingInit.CheckGlobalSetting("FishInfo2", 0);
	FishingInit.CheckGlobalSetting("DataFish", 0);
	FishingInit.CheckGlobalSetting("FishTotals");
	FishingInit.CheckGlobalSetting("FishingHoles");
	FishingInit.CheckGlobalSetting("FishingSkill");
	FishingInit.CheckGlobalSetting("Fishies");
	FishingInit.CheckGlobalSetting("HiddenFishies");

	FishingInit.CheckPlayerInfo();

	-- per user stuff
	if ( not FishingBuddy_Player["Settings"] ) then
		FishingBuddy_Player["Settings"] = { };
	end
	FishingInit.UpdateFishingDB();
	FishingInit.SetupByFishie();
	FishingInit.InitSortHelpers();
	FishingInit.SetupSchoolCounts();
end

FishingInit.RegisterMyAddOn = function()
	-- Register the addon in myAddOns
	if (myAddOnsFrame_Register) then
		local details = {
			name = FBConstants.ID,
			description = FBConstants.DESCRIPTION,
			version = FBConstants.VERSION,
			releaseDate = 'July 21, 2005',
			author = 'Sutorix',
			email = 'Windrunner',
			category = MYADDONS_CATEGORY_PROFESSIONS,
			frame = "FishingBuddy",
			optionsframe = "FishingBuddyFrame",
		};
		myAddOnsFrame_Register(details);
	end
end

FishingInit.RegisterFunctionTraps = function()
	FishingBuddy.TrapWorldMouse();
end

FishingBuddy.Initialize = function()
	if ( FishingInit ) then
		-- Set everything up, then dump the code we don't need anymore
		playerName, realmName = FishingInit.SetupNameInfo();
		FishingInit.RegisterFunctionTraps();
		FishingInit.InitSettings();
		-- register with myAddOn
		FishingInit.RegisterMyAddOn();

		gotSetupDone = true;
		FishingBuddy.WatchUpdate();
		-- debugging state
		FishingBuddy.Debugging = FishingBuddy.BaseGetSetting("FishDebug");
		
		-- we don't need these functions anymore, gc 'em
		FishingInit = nil;
	end
end
