--[[ 
Use this file if you want to correct an auto-generated value in one of the other data files.
Entries are usually stored into a single number, simply for faster loading.

If a spell must be modified, do it like this:

local lib = LibStub("LibCraftReagents-1.0")

Setting the reagents of a specific craft:
-----------------------------------------
lib:SetCraftReagents(spellID, reagents)

where reagents = "item1,quantity1|item2,quantity2" ...

--]]