-- FishingSetup
--
-- Load out translation strings and such

local Crayon = LibStub("LibCrayon-3.0");

FBConstants = {};

FBConstants.CURRENTVERSION = 10005;
FBConstants.DEFAULT_MINIMAP_POSITION = 256;
FBConstants.DEFAULT_MINIMAP_RADIUS = 80;

-- don't override debugging code, if it loaded
if ( not FishingBuddy ) then
	FishingBuddy = {};
	FishingBuddy.Commands = {};

	FishingBuddy.Debug = function(msg, fixlinks)
	end

	FishingBuddy.DebugVars = function()
	end

	FishingBuddy.Dump = function(thing)
	end
end

FishingBuddy.Output = function(msg, r, g, b)
	if ( DEFAULT_CHAT_FRAME ) then
		if ( not r ) then
			DEFAULT_CHAT_FRAME:AddMessage(msg);
		else
			DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
		end
	end
end

FishingBuddy.Message = function(msg, r, g, b)
	FishingBuddy.Output(Crayon:Green(FBConstants.NAME)..": "..msg, r, g, b);
end

FishingBuddy.Error = function(msg)
	FishingBuddy.Output(FBConstants.NAME..": "..msg, 1.0, 0, 0);
end

local FL = LibStub("LibFishing-1.0");

local uselocale = FishingBuddy.DebugLocale;

local major,_,_ = FL:WOWVersion();
local printfunc;
if ( major > 1 ) then
	printfunc = "function(...) FishingBuddy.Message(string.format(...)); end;";
else
	printfunc = "function(...) FishingBuddy.Message(string.format(unpack(arg))); end;";
end
local func, err = loadstring("return "..printfunc);
if ( func ) then
	FishingBuddy.Print = func();
else
	FishingBuddy.DebugOutput("Print function failed "..err);
end

FL:Translate("FishingBuddy", FishingTranslations, FBConstants, uselocale);
FishingBuddy.Missing = nil;

-- FishingBuddy.Missing = FL:Translate("FishingBuddy", FishingTranslations, FBConstants, "frFR");
FishingBuddy.Commands["missing"] = {};
FishingBuddy.Commands["missing"].func =
	function()
		FishingBuddy_Info["Missing"] = FishingBuddy.Missing;
		return true;
	end

-- Set the bobber name if we have a custom translation for it
if ( FBConstants.BOBBER_NAME ~= FishingTranslations["enUS"].BOBBER_NAME) then
	FL:SetBobberName(FBConstants.BOBBER_NAME);
end

-- dump the memory we've allocated for all the translations
FishingTranslations = nil;

FishingBuddy.ChatLink = function(...)
	return FL:ChatLink(...);
end

FBConstants.ID = "FishingBuddy";
FBConstants.MSGID = "FBAM";	-- Fishing Buddy Addon Message

FBConstants.UNKNOWN = "UNKNOWN";

FBConstants.FISHINGTEXTURE = "Interface\\Icons\\Trade_Fishing";
FBConstants.FINDFISHTEXTURE = "Interface\\Icons\\INV_Misc_Fish_02";

FBConstants.SPELL_FAILED_FISHING_TOO_LOW = string.gsub(SPELL_FAILED_FISHING_TOO_LOW, "%%d", "(%%d+)");

FBConstants.KEYS_NONE = 0;
FBConstants.KEYS_SHIFT = 1;
FBConstants.KEYS_CTRL = 2;
FBConstants.KEYS_ALT = 3;
FBConstants.Keys = {};
FBConstants.Keys[FBConstants.KEYS_NONE] = FBConstants.KEYS_NONE_TEXT;
FBConstants.Keys[FBConstants.KEYS_SHIFT] = FBConstants.KEYS_SHIFT_TEXT;
FBConstants.Keys[FBConstants.KEYS_CTRL] = FBConstants.KEYS_CTRL_TEXT;
FBConstants.Keys[FBConstants.KEYS_ALT] = FBConstants.KEYS_ALT_TEXT;

FBConstants.MOUSE1 = "RightButtonUp";
FBConstants.MOUSE2 = "Button4Up";
FBConstants.MOUSE3 = "Button5Up";
FBConstants.CastClick = {};
FBConstants.CastClick[FBConstants.MOUSE1] = KEY_BUTTON2;
FBConstants.CastClick[FBConstants.MOUSE2] = KEY_BUTTON4;
FBConstants.CastClick[FBConstants.MOUSE3] = KEY_BUTTON5;

FBConstants.WILDCARD_EVT = "*";
FBConstants.ADD_FISHIE_EVT = "ADD_FISHIE";
FBConstants.ADD_SCHOOL_EVT = "ADD_SCHOOL";
FBConstants.RESET_FISHDATA_EVT = "RESET_FISHDATA";

FBConstants.FISHING_ENABLED_EVT = "FISHING_ENABLED";
FBConstants.FISHING_DISABLED_EVT = "FISHING_DISABLED";

FBConstants.LOGIN_EVT = "LOGIN";
FBConstants.LOGOUT_EVT = "LOGOUT";
FBConstants.LEAVING_EVT = "LEAVING";

-- option frame
FBConstants.OPT_UPDATE_EVT = "OPT_UPDATE_EVT";

-- main FB frame handler
FBConstants.FRAME_SHOW_EVT = "FRAME_SHOW_EVT";

-- register "fake" events

FBConstants.FBEvents = {};
-- FB will call your routine for every event it receives
FBConstants.FBEvents[FBConstants.WILDCARD_EVT] = 1;

-- FB will call your function when a fish is caught
FBConstants.FBEvents[FBConstants.ADD_FISHIE_EVT] = 1;
-- FB will call your function when a school is added
FBConstants.FBEvents[FBConstants.ADD_SCHOOL_EVT] = 1;

-- FB will call your function after the player is fully logged in
FBConstants.FBEvents[FBConstants.LOGIN_EVT] = 1;
-- FB will call your function when the user is logging out
FBConstants.FBEvents[FBConstants.LOGOUT_EVT] = 1;
-- FB will call your function when the user leaves the world
FBConstants.FBEvents[FBConstants.LEAVING_EVT] = 1;

-- FB will call your function when the user starts fishing (equips a pole)
FBConstants.FBEvents[FBConstants.FISHING_ENABLED_EVT] = 1;
-- FB will call your function when the user stops fishing (unequips a pole)
FBConstants.FBEvents[FBConstants.FISHING_DISABLED_EVT] = 1;

-- FB will call your function any options are changed
FBConstants.FBEvents[FBConstants.OPT_UPDATE_EVT] = 1;

-- FB will call your function when the fishing buddy frame is about to display
FBConstants.FBEvents[FBConstants.FRAME_SHOW_EVT] = 1;
