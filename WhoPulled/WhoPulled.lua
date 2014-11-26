WhoPulled_GUIDs = {}; 
WhoPulled_MobToPlayer = {};
WhoPulled_LastMob = "";
WhoPulled_PetsToMaster = {};
WhoPulled_Tanks = "";
WhoPulled_RageList = {};
WhoPulled_NotifiedOf = {};
WhoPulled_Settings = {};
WhoPulled_RageList = {};
WhoPulled_Ignore = {};
WhoPulled_Ignored = {
	"Adder",
	"Arctic Hare",
	"Beetle",
	"Crab",
	"Crystal Spider",
	"Devout Follower",
	"Frog",
	"Gold Beetle",
	"Larva",
	"Maggot",
	"Rat",
	"Risen Zombie",
	"Roach",
	"Snake",
	"Spider",
	"Toad",
	"Zul'Drak Rat",
};
WhoPulled_Settings = {
["yonboss"] = false,
["rwonboss"] = false,
["silent"] = false,
["msg"] = "%p PULLED %e!!!",
}


do
	local locNoReportMsg = "Silent Mode (Will not say or do anything, ever)"
	local locYellReportMsg = "Yell when someone pulls a boss"
	local locRWReportMsg = "Raid Warning when someone pulls a boss"

	local WhoPulledOpt = CreateFrame("Frame", "WhoPulledConfig", InterfaceOptionsFramePanelContainer)
	WhoPulledOpt:Hide()
	WhoPulledOpt.name = "WhoPulled"
	InterfaceOptions_AddCategory(WhoPulledOpt)

	WhoPulledOpt:SetScript("OnShow", function()
		WhoPulledOptSilenceButton:SetChecked(WhoPulled_Settings["silent"])
		WhoPulledOptyonbossButton:SetChecked(WhoPulled_Settings["yonboss"])
		WhoPulledOptrwonbossButton:SetChecked(WhoPulled_Settings["rwonboss"])
	end)

	local title = WhoPulledOpt:CreateFontString("WhoPulledOptConfigTitle", "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText("Who Pulled? " .. GetAddOnMetadata("WhoPulled", "Version"))

	local btnNoReportMsg = CreateFrame("CheckButton", "WhoPulledOptSilenceButton", WhoPulledOpt)
	btnNoReportMsg:SetWidth(26)
	btnNoReportMsg:SetHeight(26)
	btnNoReportMsg:SetPoint("TOPLEFT", 16, -35)
	btnNoReportMsg:SetScript("OnClick", function(frame)
		local tick = frame:GetChecked()
		if tick then
			PlaySound("igMainMenuOptionCheckBoxOn")
			WhoPulled_Silent()
		else
			PlaySound("igMainMenuOptionCheckBoxOff")
			WhoPulled_Silent()
		end
	end)

	btnNoReportMsg:SetHitRectInsets(0, -200, 0, 0)
	btnNoReportMsg:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
	btnNoReportMsg:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
	btnNoReportMsg:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
	btnNoReportMsg:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")

	local btnNoReportMsgText = btnNoReportMsg:CreateFontString("WhoPulledOptSilenceButtonTitle", "ARTWORK", "GameFontHighlight")
	btnNoReportMsgText:SetPoint("LEFT", btnNoReportMsg, "RIGHT", 0, 1)
	btnNoReportMsgText:SetText((locNoReportMsg):format(COMPLAINT_ADDED))

	local btnYellReport = CreateFrame("CheckButton", "WhoPulledOptyonbossButton", WhoPulledOpt)
	btnYellReport:SetWidth(26)
	btnYellReport:SetHeight(26)
	btnYellReport:SetPoint("TOPLEFT", 16, -57)
	btnYellReport:SetScript("OnClick", function(frame)
		local tick = frame:GetChecked()
		if tick then
			PlaySound("igMainMenuOptionCheckBoxOn")
			WhoPulled_Settings["yonboss"] = true
		else
			PlaySound("igMainMenuOptionCheckBoxOff")
			WhoPulled_Settings["yonboss"] = false
		end
	end)

	btnYellReport:SetHitRectInsets(0, -200, 0, 0)
	btnYellReport:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
	btnYellReport:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
	btnYellReport:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
	btnYellReport:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")

	local btnlocYellReport = btnYellReport:CreateFontString("WhoPulledOptyonbossButtonTitle", "ARTWORK", "GameFontHighlight")
	btnlocYellReport:SetPoint("LEFT", btnYellReport, "RIGHT", 0, 1)
	btnlocYellReport:SetText(locYellReportMsg)

	local btnRWReport = CreateFrame("CheckButton", "WhoPulledOptrwonbossButton", WhoPulledOpt)
	btnRWReport:SetWidth(26)
	btnRWReport:SetHeight(26)
	btnRWReport:SetPoint("TOPLEFT", 16, -79)
	btnRWReport:SetScript("OnClick", function(frame)
		local tick = frame:GetChecked()
		if tick then
			PlaySound("igMainMenuOptionCheckBoxOn")
			WhoPulled_Settings["rwonboss"] = true
		else
			PlaySound("igMainMenuOptionCheckBoxOff")
			WhoPulled_Settings["rwonboss"] = false
		end
	end)

	btnRWReport:SetHitRectInsets(0, -200, 0, 0)
	btnRWReport:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
	btnRWReport:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
	btnRWReport:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
	btnRWReport:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")

	local btnlocRWReport = btnRWReport:CreateFontString("WhoPulledOptrwonbossButtonTitle", "ARTWORK", "GameFontHighlight")
	btnlocRWReport:SetPoint("LEFT", btnRWReport, "RIGHT", 0, 1)
	btnlocRWReport:SetText(locRWReportMsg)

	local WPIgnoreTitle = WhoPulledOpt:CreateFontString("WhoPulledOptConfigTitle", "ARTWORK", "GameFontNormalLarge")
	WPIgnoreTitle:SetPoint("TOPLEFT", 16, -158)
	WPIgnoreTitle:SetText("Ignore list") 

	local IgnoreInput = CreateFrame("EditBox", "WPIgnoreInput", WhoPulledOpt, "InputBoxTemplate")
	IgnoreInput:SetPoint("TOPLEFT", WPIgnoreTitle, "BOTTOMLEFT", 10, -5)
	IgnoreInput:SetAutoFocus(false)
	IgnoreInput:EnableMouse(true)
	IgnoreInput:SetWidth(250)
	IgnoreInput:SetHeight(20)
	IgnoreInput:SetMaxLetters(30)
	IgnoreInput:SetScript("OnEscapePressed", function(frame)
		frame:SetText("")
		frame:ClearFocus()
	end)
	IgnoreInput:SetScript("OnTextChanged", function(_, changed)
		if changed then
			local msg = (WPIgnoreInput:GetText()) --:":lower()" taken off the end....was GetText()):lower()
			msg = (msg):gsub("[%(%)%.%%%+%-%*%?%[%^%$%]]", "") -- I'll make it all lower during the check later
			WPIgnoreInput:SetText(msg)
		end
	end)
	IgnoreInput:Show()

	local IgnoreButton = CreateFrame("Button", "WPIgnoreButton", IgnoreInput, "UIPanelButtonTemplate")
	IgnoreButton:SetWidth(110)
	IgnoreButton:SetHeight(20)
	IgnoreButton:SetPoint("LEFT", IgnoreInput, "RIGHT")
	IgnoreButton:SetText(ADD.."/"..REMOVE)
	IgnoreButton:SetScript("OnClick", function(frame) 
		WPIgnoreInput:ClearFocus()
		local t = WPIgnoreInput:GetText()
		if t == "" or t:find("^ *$") then WPIgnoreInput:SetText("") return end
		t = (t):gsub("[%(%)%.%%%+%-%*%?%[%^%$%]]", "")
		local found
		for i=1, #WhoPulled_Ignored do
			if WhoPulled_Ignored[i] == t then found = i end
		end
		if found then
			tremove(WhoPulled_Ignored, found)
		else
			tinsert(WhoPulled_Ignored, t)
		end
		table.sort(WhoPulled_Ignored)
		local text
		for i=1, #WhoPulled_Ignored do
			if not text then
				text = WhoPulled_Ignored[i]
			else
				text = text.."\n"..WhoPulled_Ignored[i]
			end
		end
		WPIgnoreEditBox:SetText(text or "")
		WPIgnoreInput:SetText("")
	end)
	IgnoreInput:SetScript("OnEnterPressed", function() WPIgnoreButton:Click() end)

	local IgnoreScrollArea = CreateFrame("ScrollFrame", "WPIgnoreScroll", WhoPulledOpt, "UIPanelScrollFrameTemplate")
	IgnoreScrollArea:SetPoint("TOPLEFT", IgnoreInput, "BOTTOMLEFT", 0, -7)
	IgnoreScrollArea:SetPoint("BOTTOMRIGHT", WhoPulledOpt, "BOTTOMRIGHT", -30, 10)

	local IgnoreEditBox = CreateFrame("EditBox", "WPIgnoreEditBox", WhoPulledOpt)
	IgnoreEditBox:SetMultiLine(true)
	IgnoreEditBox:SetMaxLetters(99999)
	IgnoreEditBox:EnableMouse(false)
	IgnoreEditBox:SetAutoFocus(false)
	IgnoreEditBox:SetFontObject(ChatFontNormal)
	IgnoreEditBox:SetWidth(350)
	IgnoreEditBox:SetHeight(250)
	IgnoreEditBox:Show()

	IgnoreScrollArea:SetScrollChild(IgnoreEditBox)
	
	local WPIgnoreBackdrop = CreateFrame("Frame", "IgnoreBackdrop", WhoPulledOpt)
	WPIgnoreBackdrop:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = {left = 3, right = 3, top = 5, bottom = 3}}
	)
	WPIgnoreBackdrop:SetBackdropColor(0,0,0,1)
	WPIgnoreBackdrop:SetPoint("TOPLEFT", IgnoreInput, "BOTTOMLEFT", -5, 0)
	WPIgnoreBackdrop:SetPoint("BOTTOMRIGHT", WhoPulledOpt, "BOTTOMRIGHT", -27, 5)
end


function WhoPulled_ClearPulledList() 
	wipe(WhoPulled_GUIDs);
end



function WhoPulled_PullBlah(wplayer,enemy,msg)
	local iggy = 1;
	if(GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) > 0) or (GetNumGroupMembers(LE_PARTY_CATEGORY_INSTANCE) > 0) then -- added to make it silent when soloing no matter what(qod)
		if(not WhoPulled_GUIDs[enemy[1]]) then
			WhoPulled_GUIDs[enemy[1]] = true;
			WhoPulled_MobToPlayer[enemy[2]] = wplayer;
			WhoPulled_LastMob = enemy[2];
			local wp_tanks = string.gsub(WhoPulled_Tanks, "%s%-%s", "-");
			WhoPulled_Tanks = wp_tanks;
			if (not WhoPulled_Settings["silent"]) then
				if(WhoPulled_Settings["yonboss"]) then
					local i,boss;
					i = 1;
					while(UnitExists("boss"..i)) do
						if(UnitName("boss"..i) == enemy[2]) then
							for i=1, #WhoPulled_Ignored do
								if strlower(WhoPulled_Ignored[i]) == strlower(enemy[2]) then iggy = 2; end
							end
							if(not string.find(WhoPulled_Tanks,wplayer,1,true) and iggy == 1) then
								if(UnitInRaid("player") and WhoPulled_Settings["rwonboss"] and (UnitIsGroupAssistant() or UnitIsGroupLeader())) then 
									WhoPulled_RaidWarning(enemy[2]);
								else
									WhoPulled_Yell(enemy[2]);
								end
							end
							break;
						end
						i = i+1;
					end
				else
					for i=1, #WhoPulled_Ignored do
						if strlower(WhoPulled_Ignored[i]) == strlower(enemy[2]) then iggy = 2; end
					end
					if(iggy == 1 and not strfind(WhoPulled_Tanks,wplayer,1,true)) then
						DEFAULT_CHAT_FRAME:AddMessage(msg);
					end
				end
			end
		end
	end
end

function WhoPulled_GetPetOwner(pet)
	if(WhoPulled_PetsToMaster[pet]) then return WhoPulled_PetsToMaster[pet]; end
	if(UnitInRaid("player")) then
		for i=1,40,1 do
			if(UnitGUID("raidpet"..i) == pet) then
				return UnitName("raid"..i);
			end
		end
	else
		if(UnitGUID("pet") == pet) then return UnitName("player"); end
		for i=1,5,1 do
			if(UnitGUID("partypet"..i) == pet) then
				return UnitName("party"..i);
			end
		end
	end
	return "Unknown";
end

function WhoPulled_ScanForPets()
	if(UnitInRaid("player")) then
		for i=1,39,1 do
			if(UnitExists("raidpet"..i)) then
				WhoPulled_PetsToMaster[UnitGUID("raidpet"..i)] = UnitName("raid"..i);
			end
		end
	else
		if(UnitExists("pet")) then WhoPulled_PetsToMaster[UnitGUID("pet")] = UnitName("player"); end
		for i=1,4,1 do
			if(UnitExists("partypet"..i)) then
				WhoPulled_PetsToMaster[UnitGUID("partypet"..i)] = UnitName("party"..i);
			end
		end
	end
end

function WhoPulled_ScanMembersSub(combo)
	local wpname,wpserv;
	wpname,wpserv = WhoPulled_GetNameServ(combo);
	if(wpname and WhoPulled_RageList[wpserv] and WhoPulled_RageList[wpserv][wpname] and not WhoPulled_NotifiedOf[wpname.."-"..wpserv]) then
		DEFAULT_CHAT_FRAME:AddMessage(wpname.." who pulled "..WhoPulled_RageList[wpserv][wpname].." against your team is in this team!");
		WhoPulled_NotifiedOf[wpname.."-"..wpserv] = true;
	end
end

function WhoPulled_ScanMembers()
	local num,num1,wpname,wpplayer,wprole,WhoPulled_Tankappend;
	if(UnitInRaid("player")) then 
		num=GetNumGroupMembers(LE_PARTY_CATEGORY_HOME);
		num1=GetNumGroupMembers(LE_PARTY_CATEGORY_INSTANCE);
		if (num < num1) then 
			num = num1;
		end
		while num > 0 do
			wpname=GetUnitName("raid"..num,1,true);
			wprole = UnitGroupRolesAssigned("raid"..num);
			if(wprole == "TANK") then
				WhoPulled_Tankappend = WhoPulled_Tanks.." "..wpname;
				WhoPulled_Tanks = WhoPulled_Tankappend;
				local wp_tanks = string.gsub(WhoPulled_Tanks, "%s%-%s", "-");
				WhoPulled_Tanks = wp_tanks;
				if(not string.find(WhoPulled_Tanks,wpname,1,true)) then
					WhoPulled_Tankappend = WhoPulled_Tanks.." "..wpname;
					WhoPulled_Tanks = WhoPulled_Tankappend;
				else
				end
			elseif GetPartyAssignment("MAINTANK", "raid"..num) then
				if(not string.find(WhoPulled_Tanks,wpname,1,true)) then 
					WhoPulled_Tankappend = WhoPulled_Tanks.." "..wpname;
					WhoPulled_Tanks = WhoPulled_Tankappend;
				else 
				end

			else
				if string.find(WhoPulled_Tanks,wpname,1,true) then
					wp_tanks = string.gsub(WhoPulled_Tanks, wpname, "");
					WhoPulled_Tanks = wp_tanks;
				else
				
				end
			
			end
		WhoPulled_ScanMembersSub(wpname);
		num = num-1;
		end
	else
		num=GetNumGroupMembers(LE_PARTY_CATEGORY_HOME);
		num1=GetNumGroupMembers(LE_PARTY_CATEGORY_INSTANCE);
		if (num < num1) then 
			num = num1;
		end
		while num > 0 do
			num = num - 1;
			if wpname == nil then wpname = "Unknown" end
			if num > 0 then
				wpname = GetUnitName("party"..num,true);
				wprole = UnitGroupRolesAssigned("party"..num);
				if(wprole == "TANK") then
					local wp_tanks = string.gsub(WhoPulled_Tanks, "%s%-%s", "-");
					WhoPulled_Tanks = wp_tanks; 
					if(not string.find(WhoPulled_Tanks,wpname,1,true)) then 
						WhoPulled_Tankappend = WhoPulled_Tanks.." "..wpname; 
						WhoPulled_Tanks = WhoPulled_Tankappend; 
					else 
					end
				else 
					if string.find(WhoPulled_Tanks,wpname,1,true) then 
						local wp_tanks = string.gsub(WhoPulled_Tanks, wpname, "");
						WhoPulled_Tanks = wp_tanks; 
					end
				end
			end
			wpname = UnitName("player");
			wprole = UnitGroupRolesAssigned(wpname);
			if(wprole == "TANK") then
				local wp_tanks = string.gsub(WhoPulled_Tanks, "%s%-%s", "-");
				WhoPulled_Tanks = wp_tanks; 
				if(not string.find(WhoPulled_Tanks,wpname,1,true)) then 
					WhoPulled_Tankappend = WhoPulled_Tanks.." "..wpname; 
					WhoPulled_Tanks = WhoPulled_Tankappend; 
				else 
				end
			else 
				if string.find(WhoPulled_Tanks,wpname,1,true) then 
					local wp_tanks = string.gsub(WhoPulled_Tanks, wpname, "");
					WhoPulled_Tanks = wp_tanks; 
				end
			end
		end
		WhoPulled_ScanMembersSub(wpname);
		wpplayer = UnitName("player"); 
		wprole = UnitGroupRolesAssigned(wpplayer);
		if(wprole == "TANK") then
				local wp_tanks = string.gsub(WhoPulled_Tanks, "%s%-%s", "-");
			WhoPulled_Tanks = wp_tanks; 
			if(not string.find(WhoPulled_Tanks,wpplayer,1,true)) then
				WhoPulled_Tankappend = WhoPulled_Tanks.." "..wpplayer; 
				WhoPulled_Tanks = WhoPulled_Tankappend;
			else 
			end
		else 	
		end
	end
end

function WhoPulled_OnLeaveParty()
	wipe(WhoPulled_PetsToMaster);
	WhoPulled_Tanks = "";
	wipe(WhoPulled_NotifiedOf);
end

function WhoPulled_IgnoreddSpell(spell)
	if(spell == "Hunter's Mark" or spell == "Sap" or spell == "Soothe") then
		return true;
	end
	return false;
end

function WhoPulled_CheckWho(...)
	local time,event,hidecaster,sguid,sname,sflags,sraidflags,dguid,dname,dflags,draidflags,arg1,arg2,arg3,itype;
	
	if(IsInInstance()) then
		time,event,hidecaster,sguid,sname,sflags,sraidflags,dguid,dname,dflags,draidflags,arg1,arg2,arg3 = select(1, ...);
		if(dname and sname and dname ~= sname and not string.find(event,"_RESURRECT") and not string.find(event,"_CREATE") and (string.find(event,"SWING") or string.find(event,"RANGE") or string.find(event,"SPELL"))) then
			if(not string.find(event,"_SUMMON")) then
				if(bit.band(sflags,COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 and bit.band(dflags,COMBATLOG_OBJECT_TYPE_NPC) ~= 0) then
					--A player is attacking a mob
					if(not WhoPulled_IgnoreddSpell(arg2)) then
						--Put this here so it still counts as aggro if a mob casts one of these on a player.
						WhoPulled_PullBlah(sname,{dguid,dname},sname.." pulled "..dname.."! /ywho to tell everyone!");
					end
				elseif(bit.band(dflags,COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 and bit.band(sflags,COMBATLOG_OBJECT_TYPE_NPC) ~= 0) then
					--A mob is attacking a player (stepped onto, perhaps?)
					WhoPulled_PullBlah(dname,{sguid,sname},dname.." pulled "..sname.."! /ywho to tell everyone!");
				elseif(bit.band(sflags,COMBATLOG_OBJECT_CONTROL_PLAYER) ~= 0 and bit.band(dflags,COMBATLOG_OBJECT_TYPE_NPC) ~= 0) then
					--Player's pet attacks a mob
					local pullname;
					pname = WhoPulled_GetPetOwner(sguid);
					if(pname == "Unknown") then pullname = sname.." (pet)";
					else pullname = pname;
					end
					WhoPulled_PullBlah(pullname,{dguid,dname},pname.."'s "..sname.." pulled "..dname.."! /ywho to tell everyone!");

				elseif(bit.band(sflags,COMBATLOG_OBJECT_CONTROL_PLAYER) ~= 0 and bit.band(sflags,COMBATLOG_OBJECT_TYPE_NPC) ~= 0) then
					--Mob attacks a player's pet
					local pullname;
					pname = WhoPulled_GetPetOwner(dguid);
					if(pname == "Unknown") then pullname = dname.." (pet)";
					else pullname = pname;
					end
					WhoPulled_PullBlah(pullname,{sguid,sname},pname.."'s "..dname.." pulled "..sname.."! /ywho to tell everyone!");
				end
			else
		 	--Record summon
			WhoPulled_PetsToMaster[dguid] = sname;
			end
		end
	end
end

function WhoPulled_GetNameServ(combo)
	if not combo then return nil; end
	local wpname,wpserv = combo:match("([^%- ]+)%-?(.*)");
	if(wpname == "") then return nil,nil; end
	if(wpserv == "") then
		wpserv = GetRealmName();
		if not wpserv then wpserv = ""; end --whatever
	end
	return wpname,wpserv;
end

function WhoPulled_NameOrTarget(combo)
	if(wpname == "%t") then return UnitName("playertarget");
	else return combo;
	end
end

function WhoPulled_CLI(line)
	if line == "" then
		InterfaceOptionsFrame_OpenToCategory("WhoPulled")
	end
	local pos,comm;
	pos = string.find(line," ");
	if(pos) then
		comm = strlower(strsub(line,1,pos-1));
		line = strsub(line,pos+1);
	else
		comm = line;
		line = "";
	end
	if(comm == "clear")then
		wipe(WhoPulled_MobToPlayer);
		WhoPulled_LastMob = "";
	elseif(comm == "boss")then
		line = strlower(line);
		if(line == "rw") then
			WhoPulled_Settings["rwonboss"] = true;
			WhoPulled_Settings["yonboss"] = true;
			DEFAULT_CHAT_FRAME:AddMessage("Automatic raid warning of who pulled a boss: on");
		elseif(line == "true" or line == "yell" or line == "on") then
			WhoPulled_Settings["rwonboss"] = false;
			WhoPulled_Settings["yonboss"] = true;
			DEFAULT_CHAT_FRAME:AddMessage("Automatic yell who pulled a boss: on");
		else
			WhoPulled_Settings["rwonboss"] = false;
			WhoPulled_Settings["yonboss"] = false;
			DEFAULT_CHAT_FRAME:AddMessage("Automatic yell who pulled a boss: off");
		end
	elseif(comm == "msg")then
		WhoPulled_Settings["msg"] = line;
	elseif(comm == "silent")then
		line = strlower(line);
		if(line == "true" or line == "yell" or line == "on") then
			WhoPulled_Settings["silent"] = true;
			DEFAULT_CHAT_FRAME:AddMessage("Silent mode: on");
		else
			WhoPulled_Settings["silent"] = false;
			DEFAULT_CHAT_FRAME:AddMessage("Silent mode: off");
		end
	elseif(comm == "cleartanks" or comm == "ct")then
		WhoPulled_OnLeaveParty();
		DEFAULT_CHAT_FRAME:AddMessage("Tank list cleared");
	elseif(comm == "tank" or comm == "tanks") then
		line = WhoPulled_NameOrTarget(line);
		WhoPulled_Tanks = " "..line.." ";
		WhoPulled_ScanMembers();
		DEFAULT_CHAT_FRAME:AddMessage("Set tanks to:"..WhoPulled_Tanks);
	elseif(comm == "rage") then
		line = WhoPulled_NameOrTarget(line);
		if(WhoPulled_MobToPlayer[line]) then
			local wpname,wpserv = WhoPulled_GetNameServ(WhoPulled_MobToPlayer[line]);
			if not WhoPulled_RageList[wpserv] then WhoPulled_RageList[wpserv] = {}; end
			WhoPulled_RageList[wpserv][wpname] = line;
			DEFAULT_CHAT_FRAME:AddMessage("Your rage for "..wpname.." from "..wpserv.." for pulling "..line.." is now set in stone. You will be reminded should they ever join your party again.");
		else
			DEFAULT_CHAT_FRAME:AddMessage("No one pulled a "..line..".");
		end
	elseif(comm == "forgive") then -- needs testing, doesn't look right
		local wpname,wpserv = WhoPulled_GetNameServ(line);
		if(wpname) then
			local i,v,x;
			WhoPulled_RageList[wpserv][wpname] = nil;
			x=0;
			for i,v in pairs(WhoPulled_RageList[wpserv]) do
				x=x+1;
			end
			if(x == 0) then WhoPulled_RageList[wpserv] = nil; end
			DEFAULT_CHAT_FRAME:AddMessage("You have decided to give "..wpname.." of "..wpserv.." a second chance.");
		else
			DEFAULT_CHAT_FRAME:AddMessage("You have nothing against that player anyway.");
		end
	elseif(comm == "list") then
		local i,i2,v,v2,t;
		if(line ~= "") then
			line = WhoPulled_NameOrTarget(line);
			t = {};
			for i2,v2 in pairs(WhoPulled_RageList) do
				for i,v in pairs(v2) do
					if(i2 == line or v == line) then
						if not t[i2] then t[i2] = {}; end
						t[i2][i] = v;
					end
				end
			end
		else
			t = WhoPulled_RageList;
		end
		for i2,v2 in pairs(t) do
			DEFAULT_CHAT_FRAME:AddMessage("~~~~["..i2.."]~~~~");
			for i,v in pairs(v2) do
				DEFAULT_CHAT_FRAME:AddMessage(" * "..i..": Pulled "..v);
			end
		end
	elseif(comm == "ignore")then
		line = WhoPulled_NameOrTarget(line);
				line = (line):gsub("[%(%)%.%%%+%-%*%?%[%^%$%]]", "");
		local found;
		for i=1, #WhoPulled_Ignored do
			if WhoPulled_Ignored[i] == line then found = i; end
		end
		if found then
			tremove(WhoPulled_Ignored, found);
			DEFAULT_CHAT_FRAME:AddMessage("Now listening to pulls of "..line);
		else
			tinsert(WhoPulled_Ignored, line);
			DEFAULT_CHAT_FRAME:AddMessage("Now ignoring pulls of "..line);
		end
		table.sort(WhoPulled_Ignored);
		local text;
		for i=1, #WhoPulled_Ignored do
			if not text then
				text = WhoPulled_Ignored[i];
			else
				text = text.."\n"..WhoPulled_Ignored[i];
			end
		end
		WPIgnoreEditBox:SetText(text or "");
	elseif(comm == "showtanks" or comm == "st") then
		DEFAULT_CHAT_FRAME:AddMessage("Tanks are set to: "..WhoPulled_Tanks);
	elseif(comm == "help") then
		line = strlower(line);
		if(line == "clear") then
			DEFAULT_CHAT_FRAME:AddMessage("Clears stored data on who pulled what for this session.");
		elseif(line == "boss" or line == "wpyb") then
			DEFAULT_CHAT_FRAME:AddMessage("Turns automatically yelling on boss pull on or off. Say rw if you want to use raid warning insted of yell. The short hand toggle for this is /wpyb");
		elseif(line == "msg") then
			DEFAULT_CHAT_FRAME:AddMessage("Message that you say. Use %p for the player who pulled, and %e for the enemy he pulled.");
		elseif(line == "who" or line == "swho" or line == "ywho" or line == "rwho" or line == "pwho" or line == "bwho" or line == "gwho" or line == "owho" or line == "rwwho") then
			DEFAULT_CHAT_FRAME:AddMessage("/Xwho Announce who pulled the latest pull or the given enemy where X can be s for Say, y for Yell, r for Raid, rw for Raid Warning, p for Party, g for Guild, o for Officer, b for Battlground, or m (Me/My) for only showing it to yourself.");
		elseif(line == "silent" or line == "wpsm") then
			DEFAULT_CHAT_FRAME:AddMessage("When active, do not show who pulled what when it happens. The short hand toggle for this is /wpsm");
		elseif(line == "tank" or line == "tanks") then
			DEFAULT_CHAT_FRAME:AddMessage("Any players you pass in this list will not be shown to pull enemies. This way you can ignore tank pulls, and only see when someone else pulls. List can be space, comma, period, or | separated. This list will be cleared when you leave the party or raid group.  Also automatically adds tanks based on party or raid role.");
		elseif(line == "rage") then
			DEFAULT_CHAT_FRAME:AddMessage("Add the player who killed the given enemy to your rage list for future warnings about that player.");
		elseif(line == "forgive") then
			DEFAULT_CHAT_FRAME:AddMessage("Remove the given player from your rage list. Remember to give the name as Name-Realm if they're not on the realm you're currently on.");
		elseif(line == "list") then
			DEFAULT_CHAT_FRAME:AddMessage("Dump your rage list to the console, optionally filtered by what they killed or what realm they're from.");
		elseif(line == "ignore") then
			DEFAULT_CHAT_FRAME:AddMessage("Toggles ignoring messages about pulls of a certain enemy, such as critters.");
		elseif(line == "help") then
			DEFAULT_CHAT_FRAME:AddMessage("Are you serious? lol");
		else
			DEFAULT_CHAT_FRAME:AddMessage("{} surround required parameters, [] surround optional ones.");
			DEFAULT_CHAT_FRAME:AddMessage("/wp help [topic] For help on a specific function.");
			DEFAULT_CHAT_FRAME:AddMessage("/wp clear");
			DEFAULT_CHAT_FRAME:AddMessage("/wp boss {on/off}");
			DEFAULT_CHAT_FRAME:AddMessage("/wp silent {on/off}");
			DEFAULT_CHAT_FRAME:AddMessage("/wp msg {custom message}");
			DEFAULT_CHAT_FRAME:AddMessage("/wp tanks [list of tanks]");
			DEFAULT_CHAT_FRAME:AddMessage("/wp rage {enemy}");
			DEFAULT_CHAT_FRAME:AddMessage("/wp forgive {player}");
			DEFAULT_CHAT_FRAME:AddMessage("/wp list [enemy/realm]");
			DEFAULT_CHAT_FRAME:AddMessage("/wp ignore [enemy]");
			DEFAULT_CHAT_FRAME:AddMessage("/swho [enemy]");
			DEFAULT_CHAT_FRAME:AddMessage("/ywho [enemy]");
			DEFAULT_CHAT_FRAME:AddMessage("/rwho [enemy]");
			DEFAULT_CHAT_FRAME:AddMessage("/rwwho [enemy]");
			DEFAULT_CHAT_FRAME:AddMessage("/pwho [enemy]");
			DEFAULT_CHAT_FRAME:AddMessage("/bwho [enemy]");
			DEFAULT_CHAT_FRAME:AddMessage("/gwho [enemy]");
			DEFAULT_CHAT_FRAME:AddMessage("/owho [enemy]");
			DEFAULT_CHAT_FRAME:AddMessage("/mwho [enemy]");
		end
	end
end

function WhoPulled_SendMsg(chat,enemy)
	local msg,player;
	if enemy == "" then enemy = WhoPulled_LastMob; end
	player = WhoPulled_MobToPlayer[enemy];
	if player then
		msg = WhoPulled_Settings["msg"]:gsub("%%p",player);
		msg = msg:gsub("%%e",enemy);
		if(chat == "ECHO") then
			DEFAULT_CHAT_FRAME:AddMessage(msg);
		else
			SendChatMessage(msg,chat);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("No information on who pulled that enemy.");
	end
end

function WhoPulled_Say(enemy)
	WhoPulled_SendMsg("SAY",enemy);
end
function WhoPulled_Yell(enemy)
	WhoPulled_SendMsg("YELL",enemy);
end
function WhoPulled_Raid(enemy) -- needs check if in a raid
	WhoPulled_SendMsg("RAID",enemy);
end
function WhoPulled_Party(enemy) -- needs checks to force /i if not in a real party, and default chat frame if not in a party at all
	WhoPulled_SendMsg("PARTY",enemy);
end
function WhoPulled_BG(enemy) -- needs check if in a bg
	WhoPulled_SendMsg("BATTLEGROUND",enemy);
end
function WhoPulled_Guild(enemy) -- needs check if in a guild
	WhoPulled_SendMsg("GUILD",enemy);
end
function WhoPulled_Officer(enemy) -- needs check if in a guild and if officer chat is available (if such check is even possible)
	WhoPulled_SendMsg("OFFICER",enemy);
end
function WhoPulled_RaidWarning(enemy) -- needs check if in a raid
	WhoPulled_SendMsg("RAID_WARNING",enemy);
end
function WhoPulled_Me(enemy)
	WhoPulled_SendMsg("ECHO",enemy);
end

function WhoPulled_YoB()
	WhoPulled_Settings["yonboss"] = not WhoPulled_Settings["yonboss"];
	if(WhoPulled_Settings["yonboss"]) then DEFAULT_CHAT_FRAME:AddMessage("Automatic yell who pulled a boss: on");
	else DEFAULT_CHAT_FRAME:AddMessage("Automatic yell who pulled a boss: off");
	end
end

function WhoPulled_Silent()
	WhoPulled_Settings["silent"] = not WhoPulled_Settings["silent"];
	if(WhoPulled_Settings["silent"]) then DEFAULT_CHAT_FRAME:AddMessage("Silent mode: on");
	else DEFAULT_CHAT_FRAME:AddMessage("Silent mode: off");
	end
end

function WhoPulled_Options()
	InterfaceOptionsFrame_OpenToCategory("WhoPulled?");
end

function WhoPulled_World()

        local i,i2,found,v2,t,WhoPulled_variablesLoaded;
        if(WhoPulled_variablesLoaded == nil) then
            WhoPulled_variablesLoaded = false
        end
		if ( not WhoPulled_variablesLoaded ) then
			if(WhoPulled_Ignore ~= nil) then
				t = WhoPulled_Ignore;
				found = 1
				for i2,v2 in pairs(t) do
					found = 1
					for i=1, #WhoPulled_Ignored do
						if WhoPulled_Ignored[i] == i2 then found = 2 
						end
					end
					if found == 1 then
						tinsert(WhoPulled_Ignored, i2)
					end
				end
			end
			found = 1 -- Healing Stream, Flametongue, and Bloodworms mandatory ignore(qod)
			for i=1, #WhoPulled_Ignored do
				if WhoPulled_Ignored[i] == "Healing Stream Totem" then found = 2
				end
			end
			if found == 1 then
				tinsert(WhoPulled_Ignored, "Healing Stream Totem")
			end
			found = 1
			for i=1, #WhoPulled_Ignored do
				if WhoPulled_Ignored[i] == "Bloodworm" then found = 2
				end
			end
			if found == 1 then
				tinsert(WhoPulled_Ignored, "Bloodworm")
			end
			found = 1
			for i=1, #WhoPulled_Ignored do
				if WhoPulled_Ignored[i] == "Flametongue Totem" then found = 2
				end
			end
			if found == 1 then
				tinsert(WhoPulled_Ignored, "Flametongue Totem")
			end -- end of mandatory ignore items
			wipe(WhoPulled_Ignore)
			table.sort(WhoPulled_Ignored)
			WhoPulled_variablesLoaded = true
		end
	local text
	for i=1, #WhoPulled_Ignored do
		if not text then
			text = WhoPulled_Ignored[i]
		else
			text = text.."\n"..WhoPulled_Ignored[i]
		end
	end
	WPIgnoreEditBox:SetText(text or "")

end

	SLASH_YWHOPULLED1 = "/ywho"
	SlashCmdList["YWHOPULLED"] = WhoPulled_Yell
	SLASH_SWHOPULLED1 = "/swho"
	SlashCmdList["SWHOPULLED"] = WhoPulled_Say
	SLASH_RWHOPULLED1 = "/rwho"
	SlashCmdList["RWHOPULLED"] = WhoPulled_Raid
	SLASH_PWHOPULLED1 = "/pwho"
	SlashCmdList["PWHOPULLED"] = WhoPulled_Party
	SLASH_BWHOPULLED1 = "/bwho"
	SlashCmdList["BWHOPULLED"] = WhoPulled_BG
	SLASH_MWHOPULLED1 = "/mwho"
	SlashCmdList["MWHOPULLED"] = WhoPulled_Me
	SLASH_BWHOPULLED1 = "/gwho"
	SlashCmdList["GWHOPULLED"] = WhoPulled_Guild
	SLASH_BWHOPULLED1 = "/owho"
	SlashCmdList["OWHOPULLED"] = WhoPulled_Officer
	SLASH_RWWHOPULLED1 = "/rwwho"
	SlashCmdList["RWWHOPULLED"] = WhoPulled_RaidWarning
	SLASH_WHOPULLED1 = "/wp"
	SlashCmdList["WHOPULLED"] = WhoPulled_CLI
	SLASH_WHOPULLEDB1 = "/wpyb"
	SlashCmdList["WHOPULLEDB"] = WhoPulled_YoB
	SLASH_WHOPULLEDSM1 = "/wpsm"
	SlashCmdList["WHOPULLEDSM"] = WhoPulled_Silent

