local localeMapping = {
    ["deDE"] = {
        ["hr"] = "(%d+) Std",
        ["min"] = "(%d+) Min",
        ["sec"] = "(%d+) Sek"
    },
    ["enUS"] = {
        ["hr"] = "(%d+) hr",
        ["min"] = "(%d+) min",
        ["sec"] = "(%d+) sec"
    },
    ["esMX"] = {
        ["hr"] = "(%d+) h",
        ["min"] = "(%d+) min",
        ["sec"] = "(%d+) s"
    },
    ["frFR"] = {
        ["hr"] = "(%d+) h",
        ["min"] = "(%d+) min",
        ["sec"] = "(%d+) s"
    },
    ["itIT"] = {
        ["hr"] = "(%d+) or",
        ["min"] = "(%d+) min",
        ["sec"] = "(%d+) s"
    },
    ["koKR"] = {
        ["hr"] = "(%d+)시간",
        ["min"] = "(%d+)분",
        ["sec"] = "(%d+)초"
    },
    ["ptBR"] = {
        ["hr"] = "(%d+) h",
        ["min"] = "(%d+) m",
        ["sec"] = "(%d+) s"
    },
    ["ruRU"] = {
        ["hr"] = "(%d+) ч",
        ["min"] = "(%d+) мин",
        ["sec"] = "(%d+) сек"
    },
     ["zhCN"] = {
         ["hr"] = "(%d+)小时",
         ["min"] = "(%d+)分",
         ["sec"] = "(%d+)秒"
     },
     ["zhTW"] = {
         ["hr"] = "(%d+)小時",
         ["min"] = "(%d+)分鐘",
         ["sec"] = "(%d+)秒"
     }
}

local function timeStringToMinutes(str)
    local time = 0;
    local l = GetLocale();

    if localeMapping[l] == nil then
        return 0;
    end

    local hours = string.match(str, localeMapping[l].hr);
    if hours then
        hours = tonumber(string.match(hours, '(%d+)'));

        if hours > 0 then
            time = time + (hours * 60);
        end
    end

    local minutes = string.match(str, localeMapping[l].min);
    if minutes then
        minutes = tonumber(string.match(minutes, '(%d+)'));

        if minutes > 0 then
            time = time + minutes;
        end
    end

    local seconds = string.match(str, localeMapping[l].sec);
    if seconds then
        seconds = tonumber(string.match(seconds, '(%d+)'));

        if seconds > 0 and time == 0 then
            time = 1;
        end
    end

    return time;
end

local function getMissionTimers()
    local missionStr = '';
    local missions = C_Garrison.GetInProgressMissions();

    for i = 1, #missions do
        local time = timeStringToMinutes(missions[i].timeLeft);
        if time > 0 then
            local length = string.len(missionStr);
            local str = missions[i].missionID .. ':' .. time;

            if (string.len(str) + length) <= 90 then
                missionStr = missionStr .. str .. ',';
            end
        end
    end

    return string.sub(missionStr, 1, -2);
end

local function getOrderTimers()
    local orderStr = '';
	local buildings = C_Garrison.GetBuildings();

    for i = 1, #buildings do
        local buildingID = buildings[i].buildingID;
        if (buildingID) then
            local name, texture, shipmentCapacity, shipmentsReady, shipmentsTotal, creationTime, duration, timeLeftString, itemName, itemIcon, itemQuality, itemID = C_Garrison.GetLandingPageShipmentInfo(buildingID);
            if timeLeftString then
                local time = timeStringToMinutes(timeLeftString);

                local shipmentsPending = shipmentsTotal - shipmentsReady - 1;
                if shipmentsPending > 0 then
                    time = time + (shipmentsPending * 240);
                end

                if time > 0 then
                    local length = string.len(orderStr);
                    local str = buildingID .. ':' .. time;

                    if (string.len(str) + length) <= 60 then
                        orderStr = orderStr .. str .. ',';
                    end
                end
            end
        end
    end

    return string.sub(orderStr, 1, -2);
end

local isLandingPageHooked = false;
local isMissionFrameHooked = false;

WowheadGarrisonTimerButton = CreateFrame("Button", "WowheadQRButton", UIParent, "UIPanelButtonTemplate");
WowheadGarrisonTimerButton:SetText("Generate QR Code");
WowheadGarrisonTimerButton:SetWidth(145);
WowheadGarrisonTimerButton:SetHeight(25);
WowheadGarrisonTimerButton:SetPoint("CENTER", 0, 280);
WowheadGarrisonTimerButton:SetScript(
    "OnClick",
    function()
        WowheadGarrisonTimer:Show();
        WowheadGarrisonTimer_Refresh();
    end
);
WowheadGarrisonTimerButton:Hide();

function WowheadGarrisonTimer_OnLoad(event, arg1)
    local info = "This code contains a snapshot of all your active mission and work orders. To scan into the Wowhead Garrison Timer mobile app (v1.0.8 or newer), tap the IMPORT option and follow the instructions.";
    info = info .. "\n\n";
    info = info .. "The QR code was generated when this window opened. For the more accurate times, scan as quickly as possible after this window appears, or refresh the code with the button below before scanning.";

    WowheadGarrisonTimer.frames.qrInfo.qrText:SetText(info);

    for y=1,50 do
        for x=1,50 do
            local f = CreateFrame("Frame", "qr" .. x .. "_" .. y, WowheadGarrisonTimer.frames.qrWrapper.viewFrame);
            f:SetWidth(4);
            f:SetHeight(4);
            f.texture = f:CreateTexture();
            f.texture:SetAllPoints(f);
            f.texture:SetTexture(0, 0, 0);
            f:SetPoint("BOTTOMLEFT", 4 + (y * 4), 8 + ((35 - x) * 4));
            f:Hide();
        end
    end

    if not GarrisonLandingPage or not GarrisonMissionFrame then
        Garrison_LoadUI();
    end

    if (GarrisonMissionFrame and not isMissionFrameHooked) then
        GarrisonMissionFrame:HookScript(
            "OnShow",
            function()
                WowheadGarrisonTimerButton:Show();
                WowheadGarrisonTimerButton:SetPoint("CENTER", 0, 350);
            end
        );
        GarrisonMissionFrame:HookScript("OnHide", function() WowheadGarrisonTimerButton:Hide() end);
        isMissionFrameHooked = true;

    end

    if (GarrisonLandingPage and not isLandingPageHooked) then
        GarrisonLandingPage:HookScript(
            "OnShow",
            function()
                WowheadGarrisonTimerButton:Show();
                WowheadGarrisonTimerButton:SetPoint("CENTER", 0, 280);
            end
        );
        GarrisonLandingPage:HookScript("OnHide", function() WowheadGarrisonTimerButton:Hide() end);
        isLandingPageHooked = true;
        WowheadGarrisonTimerButton:SetPoint("CENTER", 0, 280);
    end
end

local function reset()
    for y=1,50 do
        for x=1,50 do
            _G["qr"..x.."_"..y]:Hide();
        end
    end
end

local function qrgen(str)
    local a, t = qrcode(str);
    reset();
    WowheadGarrisonTimer.frames.qrWrapper.viewFrame:SetWidth((#t * 4) + 16);
    WowheadGarrisonTimer.frames.qrWrapper.viewFrame:SetHeight((#t * 4) + 16);

    for y = 1, #t do
        for x = 1, #t[1] do
            if (t[y][x] < 0) then
                _G["qr"..x.."_"..y]:Hide();
                _G["qr"..x.."_"..y]:SetPoint("BOTTOMLEFT", 4 + (y * 4), 8 + ((#t - x) * 4));
            else
                _G["qr"..x.."_"..y]:Show();
                _G["qr"..x.."_"..y]:SetPoint("BOTTOMLEFT", 4 + (y * 4), 8 + ((#t - x) * 4));
            end
        end
    end
end

SLASH_WOWHEADGQR1, SLASH_WOWHEADGQR2 = '/gqr', '/garrisonqr';

function WowheadGarrisonTimer_Refresh()
    local str = '1=' .. getMissionTimers() .. ';2=' .. getOrderTimers()
    qrgen(str);
end

local function handler(msg, editbox)
    WowheadGarrisonTimer:Show();
    WowheadGarrisonTimer_Refresh();
end

SlashCmdList["WOWHEADGQR"] = handler;
