local LFH = LibStub("LibTabbedFrame-1.0");

local FBFRAMES = {
	[1] = {
		["frame"] = "FishingLocationsFrame",
		["name"] = FBConstants.LOCATIONS_TAB,
		["tooltip"] = FBConstants.LOCATIONS_INFO,
		["toggle"] = "_LOC",
		["first"] = 1,
	},
	[2] = {
		["frame"] = "FishingOptionsFrame",
		["name"] = FBConstants.OPTIONS_TAB,
		["tooltip"] = FBConstants.OPTIONS_INFO,
		["toggle"] = "_OPT",
		["ultimate"] = 1,
	}
};

local ManagedFrames = {};
local function DisableSubFrame(target)
	FishingBuddyFrame:DisableSubFrame(target);
end
FishingBuddy.DisableSubFrame = DisableSubFrame;

local function EnableSubFrame(target)
	FishingBuddyFrame:EnableSubFrame(target);
end
FishingBuddy.EnableSubFrame = EnableSubFrame;

local function ManageFrame(target, tabname, tooltip, toggle)
	FishingBuddyFrame:ManageFrame(target, tabname, tooltip, toggle);
end
FishingBuddy.ManageFrame = ManageFrame;

function ToggleFishingBuddyFrame(target)
	FishingBuddyFrame:ToggleTab(target);
end

local function OnVariablesLoaded(self, event, ...)
	-- set up mappings
	for idx,info in pairs(FBFRAMES) do
		local tf = FishingBuddyFrame:MakeFrameTab(info.frame, info.name, info.tooltip, info.toggle);
		if ( info.first) then
			FishingBuddyFrame:MakePrimary(info.frame);
		elseif ( info.ultimate ) then
			FishingBuddyFrame:MakeUltimate(info.frame);
		end
	end
	FishingBuddyFrame:ShowSubFrame("FishingLocationsFrame");
end

local function OnShow()
	FishingBuddy.RunHandlers(FBConstants.FRAME_SHOW_EVT);
end

FishingBuddyFrame = LFH:CreateFrameHandler("FishingBuddyFrame",
			"Interface\\LootFrame\\FishingLoot-Icon", FBConstants.WINDOW_TITLE, "FISHINGBUDDY",
			OnShow, nil, OnVariablesLoaded);
FishingBuddyFrame:Show();
FishingBuddyFrame:Hide();
