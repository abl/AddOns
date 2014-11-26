--[[	*** LibCraftReagents ***
Written by : Thaoky, EU-Marécages de Zangar
September 21st, 2013

This library contains a database of craft reagents.

--]]

local LIB_VERSION_MAJOR, LIB_VERSION_MINOR = "LibCraftReagents-1.0", 2
local lib = LibStub:NewLibrary(LIB_VERSION_MAJOR, LIB_VERSION_MINOR)

if not lib then return end -- No upgrade needed

--	*** API ***

-- Returns the reagents required for a specific craft
function lib:GetCraftReagents(spellID)
	return lib.dataSource[spellID]
end

-- Sets the reagents required for a specific craft
function lib:SetCraftReagents(spellID, reagents)
	lib.dataSource[spellID] = reagents
end
