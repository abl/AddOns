local _, mods = ...

tinsert(mods["Aurora"], function(F, C)
    --print("MiscSkins")
    local r, g, b = C.r, C.g, C.b

    --Travel Pass
    FriendsFrame:HookScript("OnShow", function()
        if not FriendsFrame.skinned then
            for i = 1, FRIENDS_TO_DISPLAY do
                local bu = _G["FriendsFrameFriendsScrollFrameButton"..i]

                --local frame = CreateFrame("frame", nil, bu)
                --frame:SetSize(60, 32)

                F.Reskin(bu.travelPassButton)
                bu.travelPassButton:SetAlpha(1)
                bu.travelPassButton:EnableMouse(true)
                bu.travelPassButton:SetSize(20, 32)

                bu.bg:SetSize(bu.gameIcon:GetWidth()+2, bu.gameIcon:GetHeight()+2)
                bu.bg:ClearAllPoints()
                bu.bg:SetPoint("TOPLEFT", bu.gameIcon, -1, 1)
                bu.gameIcon:SetParent(bu.bg)
                bu.gameIcon:SetPoint("TOPRIGHT", bu.travelPassButton, "TOPLEFT", -2, -5)
                bu.gameIcon.SetPoint = function() end

                bu.inv = bu.travelPassButton:CreateTexture(nil, "OVERLAY", nil, 7)
                bu.inv:SetTexture("Interface\\FriendsFrame\\PlusManz-PlusManz")
                bu.inv:SetPoint("TOPRIGHT", 1, -4)
                bu.inv:SetSize(22, 22)
            end
            FriendsFrame.skinned = true
        end
    end)

    local function UpdateScroll()
        for i = 1, FRIENDS_TO_DISPLAY do
            local bu = _G["FriendsFrameFriendsScrollFrameButton"..i]
            local en = bu.travelPassButton:IsEnabled()
            --print("UpdateScroll", i, en)

            if en then
                bu.inv:SetAlpha(0.7)
            else
                bu.inv:SetAlpha(0.3)
            end

            if bu.gameIcon:IsShown() then
                bu.bg:Show()
            else
                bu.bg:Hide()
            end
        end
    end
    hooksecurefunc("FriendsFrame_UpdateFriends", UpdateScroll)
    hooksecurefunc(FriendsFrameFriendsScrollFrame, "update", UpdateScroll)

    -- Splash Frame
    F.CreateBD(SplashFrame, nil, true)
    hooksecurefunc("SplashFrame_Display", function(tag, showStartButton)
        --print("SplashFrame", tag, showStartButton)
        SplashFrame.LeftTexture:SetDrawLayer("BACKGROUND", 7)
        F.ReskinAtlas(SplashFrame.LeftTexture, SPLASH_SCREENS[tag].leftTex)

        SplashFrame.RightTexture:SetDrawLayer("BACKGROUND", 7)
        F.ReskinAtlas(SplashFrame.RightTexture, SPLASH_SCREENS[tag].rightTex)

        SplashFrame.BottomTexture:SetDrawLayer("BACKGROUND", 7)
        local left, right, top, bottom = F.ReskinAtlas(SplashFrame.BottomTexture, SPLASH_SCREENS[tag].bottomTex, true)
        SplashFrame.BottomTexture:SetTexCoord(right, top, left, top, right, bottom, left, bottom)

        SplashFrame.Label:SetTextColor(1, 1, 1)

        SplashFrame.BottomLine:SetDrawLayer("BACKGROUND", 7)
        F.ReskinAtlas(SplashFrame.BottomLine, "splash-botleft")
    end)

    -- Objective Tracker
    F.ReskinExpandOrCollapse(ObjectiveTrackerFrame.HeaderMenu.MinimizeButton)

    -- Scroll to bottom
    for i = 1, 10 do
        local chat = _G["ChatFrame" .. i]
        local btn = chat.buttonFrame.bottomButton
        btn:SetSize(20, 20)
        F.Reskin(btn, true)

        local arrow = btn:CreateTexture(nil, "ARTWORK")
        arrow:SetPoint("TOPLEFT", 6, -6)
        arrow:SetPoint("BOTTOMRIGHT", -6, 6)
        arrow:SetTexture(C.media.arrowDown)

        local flash = _G[btn:GetName() .. "Flash"]
        flash:ClearAllPoints()
        flash:SetAllPoints(arrow)
        flash:SetTexture(C.media.arrowDown)
        flash:SetVertexColor(r, g, b, .8)
    end

    -- These addons are loaded before !Aurora_RealUI due to dependancy chains with nibRealUI.
    -- Thus, we need to call them directly until we can remove nibRealUI as a dependancy.
    mods["Clique"](F, C)
end)
