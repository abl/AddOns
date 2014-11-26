local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")

local MODNAME = "UnitFrames"
local UnitFrames = nibRealUI:NewModule(MODNAME, "AceEvent-3.0")
local db, ndb, ndbc

local oUF = oUFembed
UnitFrames.units = {}

local ModKeys = {
    "shift",
    "ctrl",
    "alt"
}
local options
local function GetOptions()
    if not options then options = {
        type = "group",
        name = "Unit Frames",
        arg = MODNAME,
        order = 2114,
        args = {
            header = {
                type = "header",
                name = "Unit Frames",
                order = 10,
            },
            enabled = {
                type = "toggle",
                name = "Enabled",
                desc = "Enable/Disable the Unit Frames module.",
                get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
                set = function(info, value) 
                    nibRealUI:SetModuleEnabled(MODNAME, value)
                    nibRealUI:ReloadUIDialog()
                end,
                order = 20,
            },
            desc3 = {
                type = "description",
                name = "Note: You will need to reload the UI (/rl) for changes to take effect.",
                order = 21,
            },
            gap1 = {
                name = " ",
                type = "description",
                order = 22,
            },
            misc = {
                type = "group",
                name = "General",
                disabled = function() return not(nibRealUI:GetModuleEnabled(MODNAME)) end,
                order = 30,
                args = {
                    focusclick = {
                        type = "toggle",
                        name = "Click Set Focus",
                        desc = "Set focus by click+modifier on the Unit Frames.",
                        get = function() return db.misc.focusclick end,
                        set = function(info, value) 
                            db.misc.focusclick = value
                        end,
                        order = 10,
                    },
                    gap1 = {
                        name = " ",
                        type = "description",
                        order = 11,
                    },
                    focuskey = {
                        type = "select",
                        name = "Modifier Key",
                        set = function(info, value)
                            db.misc.focuskey = ModKeys[value]
                        end,
                        style = "dropdown",
                        width = nil,
                        values = ModKeys,
                        order = 20,
                    },
                    focuskeyname = {
                        name = function()
                            return db.misc.focuskey
                        end,
                        type = "description",
                        order = 21,
                    },
                    gap2 = {
                        name = " ",
                        type = "description",
                        order = 22,
                    },
                    alwaysDisplayFullHealth = {
                        type = "toggle",
                        name = "Full Health on Target",
                        desc = "Always display the full health value on the Target frame.",
                        get = function() return db.misc.alwaysDisplayFullHealth end,
                        set = function(info, value) 
                            db.misc.alwaysDisplayFullHealth = value
                        end,
                        order = 30,
                    },
                },
            },
            boss = {
                type = "group",
                name = "Boss Frames",
                disabled = function() return not(nibRealUI:GetModuleEnabled(MODNAME)) end,
                order = 50,
                args = {
                    rlnote = {
                        type = "description",
                        name = "Note: You will need to reload the UI (/rl) for changes to take effect.",
                        order = 1,
                    },
                    gap1 = {
                        name = " ",
                        type = "description",
                        order = 12,
                    },
                    gap = {
                        type = "range",
                        name = "Gap",
                        desc = "Vertical distance between each Boss Frame.",
                        min = 0, max = 10, step = 1,
                        get = function(info) return db.boss.gap end,
                        set = function(info, value) db.boss.gap = value end,
                        order = 20,
                    },
                    gap2 = {
                        name = " ",
                        type = "description",
                        order = 21,
                    },
                    auras = {
                        type = "group",
                        inline = true,
                        name = "Auras",
                        order = 50,
                        args = {
                            showPlayerAuras = {
                                type = "toggle",
                                name = "Show Player Auras",
                                desc = "Show Buffs/Debuffs cast by you.",
                                get = function() return db.boss.showPlayerAuras end,
                                set = function(info, value) 
                                    db.boss.showPlayerAuras = value
                                end,
                                order = 10,
                            },
                            showNPCAuras = {
                                type = "toggle",
                                name = "Show NPC Auras",
                                desc = "Show Buffs/Debuffs cast by NPCs.",
                                get = function() return db.boss.showNPCAuras end,
                                set = function(info, value) 
                                    db.boss.showNPCAuras = value
                                end,
                                order = 20,
                            },
                            buffCount = {
                                type = "range",
                                name = "Buff Count",
                                min = 1, max = 8, step = 1,
                                get = function(info) return db.boss.buffCount end,
                                set = function(info, value) db.boss.buffCount = value end,
                                order = 30,
                            },
                            debuffCount = {
                                type = "range",
                                name = "Debuff Count",
                                min = 1, max = 8, step = 1,
                                get = function(info) return db.boss.debuffCount end,
                                set = function(info, value) db.boss.debuffCount = value end,
                                order = 40,
                            },
                        },
                    },
                },
            },
            positions = {
                type = "group",
                name = "Positions",
                disabled = function() return not(nibRealUI:GetModuleEnabled(MODNAME)) end,
                childGroups = "tab",
                order = 60,
                args = {
                    rlnote = {
                        type = "description",
                        name = "Note: You will need to reload the UI (/rl) for changes to take effect.",
                        order = 1,
                    },
                },
            },
            overlay = {
                type = "group",
                name = "Appearance",
                disabled = function() return not(nibRealUI:GetModuleEnabled(MODNAME)) end,
                childGroups = "tab",
                order = 70,
                args = {
                    rlnote = {
                        type = "description",
                        name = "Note: You will need to reload the UI (/rl) for changes to take effect.",
                        order = 1,
                    },
                    bar = {
                        type = "group",
                        name = "Bars",
                        order = 10,
                        args = {
                            opacity = {
                                type = "group",
                                inline = true,
                                name = "Opacity",
                                order = 10,
                                args = {
                                    absorb = {
                                        type = "range",
                                        name = "Absorb Bar",
                                        min = 0, max = 1, step = 0.05,
                                        isPercent = true,
                                        get = function(info) return db.overlay.bar.opacity.absorb end,
                                        set = function(info, value) db.overlay.bar.opacity.absorb = value end,
                                        order = 10,
                                    },
                                },
                            },
                        },
                    },
                    colors = {
                        type = "group",
                        name = "Colors",
                        order = 20,
                        args = {
                            classColor = {
                                type = "toggle",
                                name = "Color Bars by Class",
                                desc = "Color Health Bars based on the player's class.",
                                get = function() return db.overlay.classColor end,
                                set = function(info, value) 
                                    db.overlay.classColor = value
                                end,
                                order = 10,
                            },
                            classColorNames = {
                                type = "toggle",
                                name = "Color Names by Class",
                                desc = "Color Player Names based on the player's class.",
                                get = function() return db.overlay.classColorNames end,
                                set = function(info, value) 
                                    db.overlay.classColorNames = value
                                end,
                                order = 11,
                            },
                        },
                    },
                },
            },
        },
    }
    end
    
    ---------------
    -- Positions --
    ---------------
    local PositionLayoutOpts, PositionOpts = {}, {}
    local Opts_PositionOrderCnt = 10
    for kl,vl in pairs(db.positions) do
        local layout = kl == 1 and "Low Res" or "High Res"
        wipe(PositionOpts)
        for ip,vp in pairs(db.positions[kl]) do
            PositionOpts[ip] = {
                type = "group",
                inline = true,
                name = ip,
                order = Opts_PositionOrderCnt,
                args = {
                    x = {
                        type = "input",
                        name = "X",
                        width = "half",
                        order = 10,
                        get = function(info) return tostring(db.positions[kl][ip].x) end,
                        set = function(info, value)
                            value = nibRealUI:ValidateOffset(value)
                            db.positions[kl][ip].x = value
                        end,
                    },
                    y = {
                        type = "input",
                        name = "Y",
                        width = "half",
                        order = 20,
                        get = function(info) return tostring(db.positions[kl][ip].y) end,
                        set = function(info, value)
                            value = nibRealUI:ValidateOffset(value)
                            db.positions[kl][ip].y = value
                        end,
                    },
                },
            };
            
            Opts_PositionOrderCnt = Opts_PositionOrderCnt + 10
        end
        
        PositionLayoutOpts["res"..kl] = {
            type = "group",
            name = layout,
            order = kl,
            args = {}
        }
        for key, val in pairs(PositionOpts) do
            PositionLayoutOpts["res"..kl].args[key] = (type(val) == "function") and val() or val
        end
    end
    for key, val in pairs(PositionLayoutOpts) do
        options.args.positions.args[key] = (type(val) == "function") and val() or val
    end
    
    ------------
    -- Colors --
    ------------
    local ColorGroupOpts, ColorOpts = {}, {}
    local Opts_ColorGroupOrderCnt, Opts_ColorsOrderCnt = 20, 10
    for kl,vl in pairs(db.overlay.colors) do
        wipe(ColorOpts)
        for ic,vc in pairs(db.overlay.colors[kl]) do
            ColorOpts[ic] = {
                type = "color",
                name = ic,
                get = function(info,r,g,b,a)
                    return db.overlay.colors[kl][ic][1], db.overlay.colors[kl][ic][2], db.overlay.colors[kl][ic][3]
                end,
                set = function(info,r,g,b,a)
                    db.overlay.colors[kl][ic][1] = r
                    db.overlay.colors[kl][ic][2] = g
                    db.overlay.colors[kl][ic][3] = b
                end,
                order = 10,
            };
            
            Opts_ColorsOrderCnt = Opts_ColorsOrderCnt + 10
        end
        
        ColorGroupOpts[kl] = {
            type = "group",
            inline = true,
            name = kl,
            order = Opts_ColorGroupOrderCnt,
            args = {}
        }
        for key, val in pairs(ColorOpts) do
            ColorGroupOpts[kl].args[key] = (type(val) == "function") and val() or val
        end
        Opts_ColorGroupOrderCnt = Opts_ColorGroupOrderCnt + 10
    end
    for key, val in pairs(ColorGroupOpts) do
        options.args.overlay.args.colors.args[key] = (type(val) == "function") and val() or val
    end

    return options
end

-- Abbreviated Name
local NameLengths = {
    [1] = {
        ["target"] = 25,
        ["pet"] = 14,
    },
    [2] = {
        ["target"] = 22,
        ["pet"] = 14,
    },
}
function UnitFrames:AbrvName(name, unit)
    --print("AbrvName", name, string.match(name, "%w+"), unit)
    if not name then return "" end
    if not string.match(name, "%w+") then
        return name
    end

    if (unit == "target") and (db.misc.alwaysDisplayFullHealth) then
        return nibRealUI:AbbreviateName(name, NameLengths[self.layoutSize][unit] - 7)
    else
        return nibRealUI:AbbreviateName(name, NameLengths[self.layoutSize][unit] or 12)
    end
end

function UnitFrames:RefreshUnits(event)
    RealUIPlayerFrame:UpdateAllElements(event)
    RealUITargetFrame:UpdateAllElements(event)
    RealUIFocusFrame:UpdateAllElements(event)
    RealUIFocusTargetFrame:UpdateAllElements(event)
    RealUIPetFrame:UpdateAllElements(event)
    RealUITargetTargetFrame:UpdateAllElements(event)
end

function UnitFrames:SetPowerColors()
    self.PowerColors = {}
    for pToken, color in pairs(db.overlay.colors.power) do
        if color[1] then
            self.PowerColors[pToken] = color
            oUF.colors.power[pToken] = color
        end
    end
    self.PowerColors["POWER_TYPE_PYRITE"] = { 0, 0.79215693473816, 1 }
    self.PowerColors["POWER_TYPE_STEAM"] = { 0.94901967048645, 0.94901967048645, 0.94901967048645 }
    self.PowerColors["POWER_TYPE_HEAT"] = { 1, 0.490019610742107, 0 }
    self.PowerColors["POWER_TYPE_BLOOD_POWER"] = { 0.73725494556129, 0, 1 }
    self.PowerColors["POWER_TYPE_OOZE"] = { 0.75686281919479, 1, 0 }
end

-- Color Retrieval for Config Bar
function UnitFrames:ToggleClassColoring(names)
	if names then
		db.overlay.classColorNames = not db.overlay.classColorNames
	else
		db.overlay.classColor = not db.overlay.classColor
	end
end

function UnitFrames:GetHealthColor()
	return db.overlay.colors.health.normal
end

function UnitFrames:GetPowerColors()
	return db.overlay.colors.power
end

function UnitFrames:GetStatusColors()
	return db.overlay.colors.status
end

-- Squelch taint popup
hooksecurefunc("UnitPopup_OnClick",function(self)
    local button = self.value
    if button == "SET_FOCUS" or button == "CLEAR_FOCUS" then
        if StaticPopup1 then
            StaticPopup1:Hide()
        end
        if db.misc.focusclick then
            nibRealUI:Notification("RealUI", true, "Use "..db.misc.focuskey.."+click to set Focus.", nil, [[Interface\AddOns\nibRealUI\Media\Icons\Notification_Alert]])
        end
    elseif button == "PET_DISMISS" then
        if StaticPopup1 then
            StaticPopup1:Hide()
        end
    end
end)

----------------------------
------ Initialization ------
----------------------------
function UnitFrames:OnInitialize()
    ---[[
    self.db = nibRealUI.db:RegisterNamespace(MODNAME)
    self.db:RegisterDefaults({
        profile = {
            misc = {
                focusclick = true,
                focuskey = "shift",
                alwaysDisplayFullHealth = true,
                steppoints = {
                    ["default"] = {0.35, 0.25},
                    ["HUNTER"]  = {0.35, 0.2},
                    ["PALADIN"] = {0.35, 0.2},
                    ["WARLOCK"] = {0.35, 0.2},
                    ["WARRIOR"] = {0.35, 0.2},
                },
            },
            units = {
                arena = false,
                tank = false,
            },
            arena = {
                announceUse = true,
            },
            boss = {
                gap = 3,
                buffCount = 3,
                debuffCount = 5,
                showPlayerAuras = true,
                showNPCAuras = true,
            },
            positions = {
                [1] = {
                    player =        { x = 0,    y = 0},     -- Anchored to Positioner
                    pet =           { x = 51,  y = -84},   -- Anchored to Player
                    focus =         { x = 29,   y = -62},   -- Anchored to Player
                    focustarget =   { x = 11,    y = -2},   -- Anchored to Focus
                    target =        { x = 0,    y = 0},     -- Anchored to Positioner
                    targettarget =  { x = -29,   y = -62},   -- Anchored to Target
                    boss =          { x = 0,    y = 0},     -- Anchored to Positioner
                },
                [2] = {
                    player =        { x = 0,    y = 0},     -- Anchored to Positioner
                    pet =           { x = 60,  y = -91},   -- Anchored to Player
                    focus =         { x = 36,   y = -67},   -- Anchored to Player
                    focustarget =   { x = 12,    y = -2},   -- Anchored to Focus
                    target =        { x = 0,    y = 0},     -- Anchored to Positioner
                    targettarget =  { x = -36,  y = -67},   -- Anchored to Target
                    boss =          { x = 0,    y = 0},     -- Anchored to Positioner
                },
            },
            overlay = {
                bar = {
                    opacity = {
                        absorb = 0.25,          -- Absorb Bar
                    },
                },
                classColor = false,
                classColorNames = true,
                colors = {
                    health = {
                        normal = {0.66, 0.22, 0.22},
                    },
                    power = {
                        ["MANA"] =        {0.00, 0.50, 0.94},
                        ["RAGE"] =        {0.75, 0.12, 0.12},
                        ["FOCUS"] =       {0.95, 0.50, 0.20},
                        ["ENERGY"] =      {0.90, 0.80, 0.20},
                        ["CHI"] =         {0.35, 0.80, 0.70},
                        ["RUNES"] =       {0.50, 0.50, 0.50},
                        ["RUNIC_POWER"] = {0.00, 0.65, 0.85},
                        ["SOUL_SHARDS"] = {0.50, 0.32, 0.55},
                        ["HOLY_POWER"] =  {0.90, 0.80, 0.50},
                        ["AMMOSLOT"] =    {0.80, 0.60, 0.00},
                        ["FUEL"] =        {0.00, 0.55, 0.50},
                        ["ALTERNATE"] =   {0.00, 0.80, 0.80},
                    },
                    status = {
                        hostile = {0.81, 0.20, 0.15},
                        neutral = {0.90, 0.90, 0.20},
                        friendly = {0.28, 0.85, 0.28},
                        damage =        {1, 0, 0},
                        incomingHeal =  {1, 1, 0},
                        heal =          {0, 1, 0},
                        resting =       {0, 1, 0},
                        combat =        {1, 0, 0},
                        afk =           {1, 1, 0},
                        offline =       {0.6, 0.6, 0.6},
                        leader =        {0, 1, 1},
                        tapped =        {0.4, 0.4, 0.4},
                        pvpEnemy =      {1, 0, 0},
                        pvpFriendly =   {0, 1, 0},
                        dead =          {0.2, 0.2, 0.2},
                        rareelite =     {1, 0.5, 0},
                        elite =         {1, 1, 0},
                        rare =          {0.75, 0.75, 0.75},
                    },
                },
            },
        },
    })
    db = self.db.profile
    ndb = nibRealUI.db.profile
    ndbc = nibRealUI.db.char

    local otherFaction = nibRealUI:OtherFaction(nibRealUI.faction)

    self.layoutSize = ndb.settings.hudSize
    --print("Layout", self.layoutSize)


    self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
    nibRealUI:RegisterHuDOptions(MODNAME, GetOptions)
    ---]]
end

function UnitFrames:OnEnable()
    self:SetPowerColors()
    self.colorStrings = {
        health = nibRealUI:ColorTableToStr(db.overlay.colors.health.normal),
        mana = nibRealUI:ColorTableToStr(db.overlay.colors.power["MANA"]),
    }

    self:InitializeLayout()
end
