local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local L = LibStub("AceLocale-3.0"):GetLocale("nibRealUI")
local db, ndb

local _
local MODNAME = "ClassResource_ResolveBar"
local ClassResourceBar = nibRealUI:GetModule("ClassResourceBar")
local ResolveBar = nibRealUI:NewModule(MODNAME, "AceEvent-3.0", "AceBucket-3.0")
local Resolve = nibRealUI:GetModule("ClassResource_Resolve")

local class
local MinLevel = 10

-- Options
local options
local function GetOptions()
    if not options then options = {
        type = "group",
        name = "Resolve",
        desc = "Resolve tracker for Druids, Paladins and Warriors.",
        arg = MODNAME,
        childGroups = "tab",
        args = {
            header = {
                type = "header",
                name = "Resolve",
                order = 10,
            },
            desc = {
                type = "description",
                name = "Resolve tracker for Druids, Paladins and Warriors.",
                fontSize = "medium",
                order = 20,
            },
            enabled = {
                type = "toggle",
                name = "Enabled",
                desc = "Enable/Disable the Resolve module.",
                get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
                set = function(info, value) 
                    nibRealUI:SetModuleEnabled(MODNAME, value)
                end,
                order = 30,
            },
        },
    }
    end
    return options
end

---------------------------
---- Resolve Updates ----
---------------------------
function ResolveBar:UpdateAuras(units)
    --print("UpdateAuras", units)
    -- if units then
    --     for k, v in pairs(units) do
    --         --print(k, v)
    --     end
    -- end
    if units and not(units.player) then return end

    Resolve:UpdateCurrent()

    self.rBar:SetText("middle", nibRealUI:ReadableNumber(Resolve.current, 0))
    if Resolve.percent < 0.5 then
        self.rBar:SetValue("left", Resolve.percent * 2)
        self.rBar:SetValue("right", 0)
    else
        self.rBar:SetValue("right", (Resolve.percent - 0.5) * 2)
        self.rBar:SetValue("left", 1)
    end

    if ((Resolve.current > floor(Resolve.base)) and not(self.rBar:IsShown())) or
        ((Resolve.current <= floor(Resolve.base)) and self.rBar:IsShown()) then
            self:UpdateShown()
    end
end

function ResolveBar:UpdateShown()
    --print("UpdateShown")

    if self.configMode then
        self.rBar:Show()
        return
    end

    if ( (Resolve.current and (Resolve.current > floor(Resolve.base))) and not(UnitIsDeadOrGhost("player")) and (UnitLevel("player") >= MinLevel) ) then
        self.rBar:Show()
    else
        self.rBar:Hide()
    end
end

function ResolveBar:PLAYER_ENTERING_WORLD()
    self.guid = UnitGUID("player")
    self:UpdateAuras()
    self:UpdateShown()
end

function ResolveBar:UpdateGlobalColors()
    if not nibRealUI:GetModuleEnabled(MODNAME) then return end
    self.rBar:SetBarColor("left", nibRealUI.media.colors.orange)
    self.rBar:SetBarColor("right", nibRealUI.media.colors.orange)
end

------------
function ResolveBar:ToggleConfigMode(val)
    --print("UpdateShown", val)
    if not nibRealUI:GetModuleEnabled(MODNAME) then return end
    if Resolve.special[class] then return end
    if self.configMode == val then return end

    self.configMode = val
    self:UpdateShown()
end

function ResolveBar:OnInitialize()
    self.db = nibRealUI.db:RegisterNamespace(MODNAME)
    self.db:RegisterDefaults({
        profile = {},
    })
    db = self.db.profile
    ndb = nibRealUI.db.profile

    class = nibRealUI.class
    
    self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
    nibRealUI:RegisterHuDOptions(MODNAME, GetOptions, "ClassResource")
    nibRealUI:RegisterConfigModeModule(self)
end

function ResolveBar:OnEnable()
    if Resolve.special[class] then return end
    self.configMode = false

    if not self.rBar then 
        self.rBar = ClassResourceBar:New("short")
        self.rBar:SetEndBoxShown("left", false)
        self.rBar:SetEndBoxShown("right", false)
    end

    self:UpdateGlobalColors()

    local updateSpeed
    if nibRealUI.db.profile.settings.powerMode == 1 then
        updateSpeed = 1/6
    elseif nibRealUI.db.profile.settings.powerMode == 2 then
        updateSpeed = 1/4
    else
        updateSpeed = 1/8
    end

    -- Events
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("PLAYER_TALENT_UPDATE", "UpdateShown")
    self:RegisterEvent("PLAYER_UNGHOST", "UpdateShown")
    self:RegisterEvent("PLAYER_ALIVE", "UpdateShown")
    self:RegisterEvent("PLAYER_DEAD", "UpdateShown")
    self:RegisterEvent("PLAYER_LEVEL_UP", "UpdateShown")
    self:RegisterBucketEvent("UNIT_AURA", updateSpeed, "UpdateAuras")
end

function ResolveBar:OnDisable()
    self:UnregisterAllEvents()
    self:UnregisterAllBuckets()
end
