-- Interface with the Blizz Equipment Manager

-- 5.0.4 has a problem with a global "_" (see some for loops below)
local _

local FL = LibStub("LibFishing-1.0");

local lastOutfit;

local FB_TEMP_OUTFIT = "FB_TEMP_OUTFIT";
local FINAL_STATE = 4;
local gearframe = CreateFrame("Frame");
gearframe:Hide();
gearframe:SetScript("OnUpdate", function(self)
	FishingBuddy.Debug("gearframe state "..self.state);
	if ( self.state == 0 ) then
		local icon, idxm1 = GetEquipmentSetInfoByName(self.name);
		if ( not icon or self.force ) then
			-- make sure we're wearing everything we think we should be
			local wearing = 1;
			local mslot = GetInventorySlotInfo("MainHandSlot");			
			for invslot,info in pairs(self.outfit) do
				local link = GetInventoryItemLink("player", invslot);
				-- FishingBuddy.Debug("link "..link.." "..info.link);
				if (link ~= info.link) then
					wearing = nil;
				end
				if (not self.maintexture) then
					if (mslot == invslot) then
						local _, _, _, _, _, _, _, _, _, t, _ = GetItemInfo(info.link);
						self.maintexture = gsub( strupper(t), "INTERFACE\\ICONS\\", "" );
						-- FishingBuddy.Debug("texture "..self.maintexture);
					end
				end
			end
			
			-- Are we wearing everything?
			if (wearing) then
				SaveEquipmentSet(self.name, self.maintexture);
				self.state = 1;
			end
		else
			self.state = FINAL_STATE;
		end
	elseif ( self.state == 1 ) then
		-- reset slot ignore flags
		EquipmentManagerClearIgnoredSlotsForSave();
		local icon, _ = GetEquipmentSetInfoByName(FB_TEMP_OUTFIT);
		if ( icon ) then
			EquipmentManager_EquipSet(FB_TEMP_OUTFIT);
			self.state = 2;
			self.nextstate = 3;
		else
			self.state = FINAL_STATE;
		end
	elseif ( self.state == 2 ) then
		-- waiting for EQUIPMENT_SWAP_FINISHED
	elseif (self.state == 3) then
		local icon, _ = GetEquipmentSetInfoByName(FB_TEMP_OUTFIT);
		if ( icon ) then
			DeleteEquipmentSet(FB_TEMP_OUTFIT);
		end
		self.state = FINAL_STATE;
	else
		self.force = nil;
		self:Hide();
	end
end)

gearframe:SetScript("OnEvent", function(self,...)
	self.state = self.nextstate;
end)
gearframe:RegisterEvent("EQUIPMENT_SWAP_FINISHED");

local function PrepGearFrame(name, outfit, force)
	gearframe.laststate = -1;
	gearframe.name = name;
	gearframe.state = 0;
	gearframe.outfit = outfit;
	gearframe.force = force;
	gearframe.maintexture = nil;
	gearframe:Show();
end

local function GearManagerInitialize(force)
	local known, name = FL:GetFishingSkillInfo();
	if ( known ) then
		if (force) then
			FishingBuddy.Debug("GearManagerInitialize forced");
		end
		FishingBuddy.Debug("GearManagerInitialize name "..FBConstants.NAME);
		local icon, _ = GetEquipmentSetInfoByName(FBConstants.NAME);
		if ( icon ) then
			-- Validate outfit, CurseForge bug #218
			local itemArray = GetEquipmentSetItemIDs(FBConstants.NAME);
			-- If there is a Ranged slot, nuke this outfit
			FishingBuddy.Dump(itemArray)
			if (itemArray[18] and itemArray[18] ~= 0) then
				force = true;
			end
		end
		if ( not icon or force ) then
			-- Let's build a fishing outfit
			-- but we actually have to equip the items for this to work
			-- let's save what we have on now...
			SaveEquipmentSet(FB_TEMP_OUTFIT, 1);
			for slot=1,17 do
				EquipmentManagerIgnoreSlotForSave(slot);
			end

			local outfit = FL:GetFishingOutfitItems(false) or {};
			for invslot,info in pairs(outfit) do
				EquipItemByName(info.link, invslot);
				EquipmentManagerUnignoreSlotForSave(invslot);
			end  -- for bags
			-- let's save this puppy
			PrepGearFrame(FBConstants.NAME, outfit, force);
		end
	end
	-- we can (and need to) reinitialize every time we're selected
	return false;
end

local function GuessCurrentOutfit()
	local ret = {};
	local location_array = {};
	local numsets = GetNumEquipmentSets();
	for set = 1, numsets do
		ret[set] = 0;
		local eq_set_name, _, _ = GetEquipmentSetInfo(set);
		GetEquipmentSetLocations(eq_set_name, location_array);
		for s,location in pairs(location_array) do
			local onplayer, _, bags, _, _, _ = EquipmentManager_UnpackLocation(location);
			if onplayer and not bags then
				ret[set] = ret[set] + 1;
			end	
		end
	end
	local best_set = 1;
	local best_value = 0;
	for i = 1, numsets do
		if (best_value < ret[i]) then
			best_value = ret[i];
			best_set = i;
		end
	end
	local best_name, _, _ = GetEquipmentSetInfo(best_set);
	return best_name;
end

local function GetCurrentOutfit()
	local setname = PaperDollEquipmentManagerPane.selectedSetName;
	if ( setname ) then
		return setname;
	end
	if ( GetNumEquipmentSets() == 0 ) then
        return nil; -- there are no gear sets, give up
    end
	-- no gear set active, take best fit
	return GuessCurrentOutfit();
end

local function GearManagerSwitch(outfitName)
	local GSB = FishingBuddy.GetSettingBool;
	if ( FL:IsFishingReady(GSB("PartialGear")) ) then
		local name = FishingBuddy_Info["LastGearSet"];
		if ( not name ) then
			name, _, _ = GetEquipmentSetInfo(1);
		end
		EquipmentManager_EquipSet(name);
		FishingBuddy_Info["LastGearSet"] = nil;
		return false;
	else
		local icon, idxm1 = GetEquipmentSetInfoByName(FBConstants.NAME);
		if ( icon ) then
			FishingBuddy_Info["LastGearSet"] = GetCurrentOutfit();
			EquipmentManager_EquipSet(FBConstants.NAME);
			return true;
		end
	end
	-- return nil;
end

local function OutfitPoints(outfit)
	local sp = 0;
	local bp = 0;
	if ( outfit )then
		local isp = FishingBuddy.OutfitManager.ItemStylePoints;
		local ibp = function(link) return FL:FishingBonusPoints(link); end;
		local items = GetEquipmentSetLocations(outfit);
		for slot,loc in pairs(items) do
			local player, bank, bags, void, slot, bag = EquipmentManager_UnpackLocation(loc);
			local link;
			if ( not bags ) then -- and (player or bank) 
				link = GetInventoryItemLink("player", slot);
			else -- bags
				link = GetContainerItemLink(bag, slot);
			end
			if ( link ) then
				_, link, _ = FL:SplitLink(link);
				sp = sp + isp(link);
				bp = bp + ibp(link);
			end
		end
	end
	return bp, sp;
end

local Saved_GearSetButton_OnEnter = GearSetButton_OnEnter;
local function Patch_GearSetButton_OnEnter(self)
	Saved_GearSetButton_OnEnter(self);
	local _, name = FL:GetFishingSkillInfo();
	if ( self.name and self.name == name ) then
		local bp, sp = OutfitPoints(name)
		if ( bp >= 0 ) then
			bp = "+"..bp;
		else
			bp = 0 - bp;
			bp = "-"..bp;
		end
		bp = name.." "..bp;
		local pstring;
		if ( points == 1 ) then
			pstring = FBConstants.POINT;
		else
			pstring = FBConstants.POINTS;
		end
		GameTooltip:AddDoubleLine(SKILL..": "..bp, "Draznar: "..sp, 1, 1, 1, 1, 1, 1);
		GameTooltip:Show();
	end
end
-- point to our new function so we get our own tooltip
GearSetButton_OnEnter = Patch_GearSetButton_OnEnter;

FishingBuddy.OutfitManager.RegisterManager(EQUIPMENT_MANAGER,
															 GearManagerInitialize,
															 function(useme) end,
															 GearManagerSwitch);

if ( FishingBuddy.Debugging ) then
	FishingBuddy.Commands["checkset"] = {};
	FishingBuddy.Commands["checkset"].func =
		function(what)
			local Debug = FishingBuddy.Debug;
			local set = GetEquipmentSetItemIDs(FBConstants.NAME);
			for slot, item in ipairs(set) do
				if ( item == EQUIPMENT_SET_IGNORED_SLOT ) then
					Debug("Ignored slot "..slot);
				end
			end
			return true;
		end

	FishingBuddy.Commands["newset"] = {};
	FishingBuddy.Commands["newset"].func =
		function(what)
			GearManagerInitialize(true);
			return true;
		end
end
