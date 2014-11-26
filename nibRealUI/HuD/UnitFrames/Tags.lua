local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")

local MODNAME = "UnitFrames"
local UnitFrames = nibRealUI:GetModule(MODNAME)

local oUF = oUFembed
local tags = oUF.Tags

------------------
------ Tags ------
------------------
-- Name
tags.Methods["realui:name"] = function(unit)
    local isDead = false
    if UnitIsDead(unit) or UnitIsGhost(unit) or not(UnitIsConnected(unit)) then
        isDead = true
    end

    local unitTag = unit:match("(boss)%d?$") or unit
    local name = UnitFrames:AbrvName(UnitName(unit), unitTag)

    local nameColor = "ffffff"
    if isDead then
        nameColor = "3f3f3f"
    elseif UnitFrames.db.profile.overlay.classColorNames then 
        --print("Class color names", unit)
        local _, class = UnitClass(unit)
        nameColor = nibRealUI:ColorTableToStr(nibRealUI:GetClassColor(class))
    end
    return string.format("|cff%s%s|r", nameColor, name)
end
tags.Events["realui:name"] = "UNIT_NAME_UPDATE"

-- Level
tags.Methods["realui:level"] = function(unit)
    if UnitIsDead(unit) or UnitIsGhost(unit) or not(UnitIsConnected(unit)) then return end

    local level, levelColor
    if (UnitIsWildBattlePet(unit) or UnitIsBattlePetCompanion(unit)) then
        level = UnitBattlePetLevel(unit)
    else
        level = UnitLevel(unit)
    end
    if level <= 0 then
        level = "??"
        levelColor = GetQuestDifficultyColor(105)
    else
        levelColor = GetQuestDifficultyColor(level)
    end
    return string.format("|cff%02x%02x%02x%s|r", levelColor.r * 255, levelColor.g * 255, levelColor.b * 255, level)
end
tags.Events["realui:level"] = "UNIT_NAME_UPDATE"

-- Health
tags.Methods["realui:health"] = function(unit)
    if UnitIsDead(unit) or UnitIsGhost(unit) or not(UnitIsConnected(unit)) then return end

    return nibRealUI:ReadableNumber(UnitHealth(unit))
end
tags.Events["realui:health"] = "UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_TARGETABLE_CHANGED"

-- Health %
tags.Methods["realui:healthPercent"] = function(unit)
    if UnitIsDead(unit) or UnitIsGhost(unit) or not(UnitIsConnected(unit)) then return end

    local percent = UnitHealth(unit) / UnitHealthMax(unit) * 100
    if unit == "target" or unit == "player" then
        if percent > 90 then 
            return
        end
    end
    return ("%d|cff%s%%|r"):format(percent, nibRealUI:ColorTableToStr(UnitFrames.db.profile.overlay.colors.health.normal))
end
tags.Events["realui:healthPercent"] = "UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_TARGETABLE_CHANGED"

-- Smart Health
tags.Methods["realui:smartHealth"] = function(unit)
    local healthPer = tags.Methods["realui:healthPercent"](unit)
    if healthPer then
        return healthPer
    else
        return tags.Methods["realui:health"](unit)
    end
end
tags.Events["realui:smartHealth"] = "UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_TARGETABLE_CHANGED"

-- Power
tags.Methods["realui:power"] = function(unit)
    if UnitIsDead(unit) or UnitIsGhost(unit) or not(UnitIsConnected(unit)) then return end

    return nibRealUI:ReadableNumber(UnitPower(unit))
end
tags.Events["realui:power"] = "UNIT_POWER_FREQUENT UNIT_MAXPOWER UNIT_TARGETABLE_CHANGED"

-- PvP Timer
tags.Methods["realui:pvptimer"] = function(unit)
    --print("Tag:pvptimer", unit)
    if not IsPVPTimerRunning() then return "" end

    return nibRealUI:ConvertSecondstoTime(floor(GetPVPTimer() / 1000))
end
tags.Events["realui:pvptimer"] = "UNIT_FACTION PLAYER_FLAGS_CHANGED"
