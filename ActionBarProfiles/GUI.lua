local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local STRIPE_COLOR = { r = 0.9, g = 0.9, b = 1 }
local ACTION_BAR_PROFILE_BUTTON_HEIGHT = 44

local frame = PaperDollActionBarProfilesPane

function frame:OnInitialize()
    StaticPopupDialogs.CONFIRM_DELETE_ACTION_BAR_PROFILE = {
        text = L.confirm_delete,
        button1 = YES,
        button2 = NO,
        OnAccept = function(popup) self:OnDeleteConfirm(popup) end,
        OnCancel = function(popup) end,
        OnHide = function(popup) end,
        hideOnEscape = 1,
        timeout = 0,
        exclusive = 1,
        whileDead = 1,
    }

    StaticPopupDialogs.CONFIRM_SAVE_ACTION_BAR_PROFILE = {
        text = L.confirm_save,
        button1 = YES,
        button2 = NO,
        OnAccept = function(popup) self:OnSaveConfirm(popup) end,
        OnCancel = function(popup) end,
        OnHide = function(popup) end,
        hideOnEscape = 1,
        timeout = 0,
        exclusive = 1,
        whileDead = 1,
    }

    StaticPopupDialogs.CONFIRM_USE_ACTION_BAR_PROFILE = {
        text = L.confirm_use,
        button1 = YES,
        button2 = NO,
        OnAccept = function(popup) self:OnUseConfirm(popup) end,
        OnCancel = function(popup) end,
        OnHide = function(popup) end,
        hideOnEscape = 1,
        timeout = 0,
        exclusive = 1,
        whileDead = 1,
    }

    self.scrollBar.doNotHide = 1

    self:SetFrameLevel(CharacterFrameInsetRight:GetFrameLevel() + 1)

    self.UseProfile:SetFrameLevel(self:GetFrameLevel() + 3)
    self.SaveProfile:SetFrameLevel(self:GetFrameLevel() + 3)

    HybridScrollFrame_OnLoad(self)
    self.update = function() self:Update() end

    HybridScrollFrame_CreateButtons(self, "ActionBarProfileButtonTemplate", 2, -(self.UseProfile:GetHeight() + 4))
    self:Update()
end

function frame:OnShow()
    HybridScrollFrame_CreateButtons(self, "ActionBarProfileButtonTemplate")
    self:Update()
end

function frame:OnHide()
    PaperDollActionBarProfilesSaveDialog:Hide()
end

function frame:OnUpdate()
    local button
    for button in valuesIterator(self.buttons) do
        if button:IsMouseOver() then
            if button.name then
                button.DeleteButton:Show()
                button.EditButton:Show()
            else
                button.DeleteButton:Hide()
                button.EditButton:Hide()
            end

            button.HighlightBar:Show()
        else
            button.DeleteButton:Hide()
            button.EditButton:Hide()

            button.HighlightBar:Hide()
        end
    end
end

function frame:OnDeleteClick(button)
    local popup = StaticPopup_Show("CONFIRM_DELETE_ACTION_BAR_PROFILE", button.name)
    if popup then
        popup.name = button.name
    else
        UIErrorsFrame:AddMessage(ERR_CLIENT_LOCKED_OUT, 1.0, 0.1, 0.1, 1.0)
    end
end

function frame:OnDeleteConfirm(popup)
    addon:DeleteProfile(popup.name)
    self:Update()
end

function frame:OnEditClick(button)
    self:OnProfileClick(button)

    PaperDollActionBarProfilesSaveDialog:SetProfile(button.name)
    PaperDollActionBarProfilesSaveDialog:Show()
end

function frame:OnProfileDoubleClick(button)
    local fail, total = addon:UseProfile(button.name, true)
    if fail > 0 then
        local popup = StaticPopup_Show("CONFIRM_USE_ACTION_BAR_PROFILE", fail, total)
        if popup then
            popup.name = self.selectedName
        else
            UIErrorsFrame:AddMessage(ERR_CLIENT_LOCKED_OUT, 1.0, 0.1, 0.1, 1.0)
        end
    else
        addon:UseProfile(button.name)
        self:Update()
    end
end

function frame:OnProfileClick(button)
    if button.name and button.name ~= "" then
        self.selectedName = button.name
        self:Update()

        PaperDollActionBarProfilesSaveDialog:Hide()
    else
        self.selectedName = nil
        self:Update()

        PaperDollActionBarProfilesSaveDialog:SetProfile()
        PaperDollActionBarProfilesSaveDialog:Show()
    end
end

function frame:OnUseClick()
    local fail, total = addon:UseProfile(self.selectedName, true)
    if fail > 0 then
        local popup = StaticPopup_Show("CONFIRM_USE_ACTION_BAR_PROFILE", fail, total)
        if popup then
            popup.name = self.selectedName
        else
            UIErrorsFrame:AddMessage(ERR_CLIENT_LOCKED_OUT, 1.0, 0.1, 0.1, 1.0)
        end
    else
        addon:UseProfile(self.selectedName)
        self:Update()
    end
end

function frame:OnUseConfirm(popup)
    addon:UseProfile(popup.name)
    self:Update()
end

function frame:OnSaveClick()
    local popup = StaticPopup_Show("CONFIRM_SAVE_ACTION_BAR_PROFILE", self.selectedName)
    if popup then
        popup.name = self.selectedName
    else
        UIErrorsFrame:AddMessage(ERR_CLIENT_LOCKED_OUT, 1.0, 0.1, 0.1, 1.0)
    end
end

function frame:OnSaveConfirm(popup)
    addon:UpdateProfileBars(popup.name)
    self:Update()
end

function frame:Update()
    local profiles = addon:GetSortedProfiles()
    local numRows = #profiles + 1

    HybridScrollFrame_Update(self, numRows * ACTION_BAR_PROFILE_BUTTON_HEIGHT + self.UseProfile:GetHeight() + 20, self:GetHeight())

    local scrollOffset = HybridScrollFrame_GetOffset(self)
    local class = select(2, UnitClass("player"))

    local selectedName = self.selectedName
    self.selectedName = nil

    local cache = addon:MakeCache()

    local i
    for i = 1, #self.buttons do
        local button = self.buttons[i]

        if scrollOffset + i <= numRows then
            if scrollOffset + i ==  1 then
                button.name = nil

                button.text:SetText(L.new_profile)
                button.text:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)

                button.icon:SetTexture("Interface\\PaperDollInfoFrame\\Character-Plus")
                button.icon:SetTexCoord(0, 1, 0, 1)

                button.icon:SetSize(30, 30)
                button.icon:SetPoint("LEFT", 7, 0)

                button.SelectedBar:Hide()
            else
                local profile = profiles[scrollOffset + i - 1]

                button.name = profile.name

                button.text:SetText(profile.name)
                if profile.class ~= class then
                    button.text:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)

                elseif addon:UseProfile(profile.name, true, cache) > 0 then
                    button.text:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)

                else
                    button.text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
                end

                button.icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
                button.icon:SetTexCoord(unpack(CLASS_ICON_TCOORDS[profile.class]))

                button.icon:SetSize(36, 36)
                button.icon:SetPoint("LEFT", 4, 0)

                if selectedName and selectedName == profile.name then
                    button.SelectedBar:Show()
                    self.selectedName = selectedName
                else
                    button.SelectedBar:Hide()
                end
            end

            if (i + scrollOffset) == 1 then
                button.BgTop:Show()
                button.BgMiddle:SetPoint("TOP", button.BgTop, "BOTTOM")
            else
                button.BgTop:Hide()
                button.BgMiddle:SetPoint("TOP")
            end

            if (i + scrollOffset) == numRows then
                button.BgBottom:Show()
                button.BgMiddle:SetPoint("BOTTOM", button.BgBottom, "TOP")
            else
                button.BgBottom:Hide()
                button.BgMiddle:SetPoint("BOTTOM")
            end

            if (i + scrollOffset) % 2 == 0 then
                button.Stripe:SetTexture(STRIPE_COLOR.r, STRIPE_COLOR.g, STRIPE_COLOR.b)
                button.Stripe:SetAlpha(0.1)

                button.Stripe:Show()
            else
                button.Stripe:Hide()
            end

            button:Show()
            button:Enable()
        else
            button:Hide()
        end
    end

    if self.selectedName then
        self.UseProfile:Enable()
        self.SaveProfile:Enable()
    else
        self.UseProfile:Disable()
        self.SaveProfile:Disable()
    end
end
