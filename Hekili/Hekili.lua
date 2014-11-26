-- Hekili.lua
-- April 2014

Hekili		= LibStub("AceAddon-3.0"):NewAddon( "Hekili", "AceConsole-3.0", "AceEvent-3.0", "AceSerializer-3.0" )
Hekili.UI	= {}

local string = string

-- LibButtonFrame a.k.a. Masque
Hekili.MSQ = LibStub("Masque", true)
if Hekili.MSQ then
	Hekili.msqGroup = Hekili.MSQ:Group("Hekili")
	if not Hekili.msqGroup then Hekili.MSQ = nil end
end

-- LibSharedMedia (fonts, primarily)
Hekili.LSM	= LibStub("LibSharedMedia-3.0", true)


-- RangeCheck
Hekili.RC = LibStub("LibRangeCheck-2.0")


BINDING_HEADER_HEKILI_HEADER = "Hekili |cFF00FF00v2|r"

BINDING_NAME_HEKILI_TOGGLE_PAUSE		= "Pause"
BINDING_NAME_HEKILI_TOGGLE_COOLDOWNS	= "Toggle Cooldowns"
BINDING_NAME_HEKILI_TOGGLE_HARDCASTS	= "Toggle Hardcasts"
BINDING_NAME_HEKILI_TOGGLE_INTERRUPTS	= "Toggle Interrupts"
BINDING_NAME_HEKILI_TOGGLE_MODE			= "Toggle Mode"
BINDING_NAME_HEKILI_TOGGLE_1			= "Custom Toggle 1"
BINDING_NAME_HEKILI_TOGGLE_2			= "Custom Toggle 2"
BINDING_NAME_HEKILI_TOGGLE_3			= "Custom Toggle 3"
BINDING_NAME_HEKILI_TOGGLE_4			= "Custom Toggle 4"
BINDING_NAME_HEKILI_TOGGLE_5			= "Custom Toggle 5"

function Hekili:RefreshBindings()
	self.DB.profile['HEKILI_TOGGLE_MODE']		= select(1, GetBindingKey("HEKILI_TOGGLE_MODE"))
	self.DB.profile['HEKILI_TOGGLE_PAUSE']		= select(1, GetBindingKey("HEKILI_TOGGLE_PAUSE"))
	self.DB.profile['HEKILI_TOGGLE_COOLDOWNS']	= select(1, GetBindingKey("HEKILI_TOGGLE_COOLDOWNS"))
	self.DB.profile['HEKILI_TOGGLE_HARDCASTS']	= select(1, GetBindingKey("HEKILI_TOGGLE_HARDCASTS"))
	self.DB.profile['HEKILI_TOGGLE_1']			= select(1, GetBindingKey("HEKILI_TOGGLE_1"))
	self.DB.profile['HEKILI_TOGGLE_2']			= select(1, GetBindingKey("HEKILI_TOGGLE_2"))
	self.DB.profile['HEKILI_TOGGLE_3']			= select(1, GetBindingKey("HEKILI_TOGGLE_3"))
	self.DB.profile['HEKILI_TOGGLE_4']			= select(1, GetBindingKey("HEKILI_TOGGLE_4"))
	self.DB.profile['HEKILI_TOGGLE_5']			= select(1, GetBindingKey("HEKILI_TOGGLE_5"))
end


Hekili.Tooltip = CreateFrame("GameTooltip", "HekiliTooltip", UIParent, "GameTooltipTemplate")
-- We need our tooltip to use a solid background to make code legible.
local Backdrop = GameTooltip:GetBackdrop()
Backdrop.bgFile = [[Interface\Buttons\WHITE8X8]]
Hekili.Tooltip:SetBackdrop( Backdrop )


function Hekili:Error(...)
	local output = string.format( ... )
	self:Print(output)
end



