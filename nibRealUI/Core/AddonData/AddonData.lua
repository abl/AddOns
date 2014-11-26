local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")

nibRealUI.AddOns = {
	"Aurora",
	"BugGrabber",
	"BugSack",
	"Bartender4",
	"DXE",
	"DBM-StatusBarTimers",
	"FreebTip",
	"Grid2",
	"Kui_Nameplates",
	"mikScrollingBattleText",
	"Masque",
	"Raven",
	"Skada",
}

function nibRealUI:LoadAddonData()
	for k, a in pairs(self.AddOns) do
		if self["LoadAddOnData_"..a] then
			self["LoadAddOnData_"..a]()
		end
	end
end

function nibRealUI:LoadSpecificAddOnData(addon, skipReload)
	print("nibRealUI:LoadSpecificAddOnData", addon, skipReload, self["LoadAddOnData_"..addon])
	if self["LoadAddOnData_"..addon] then
		self["LoadAddOnData_"..addon]()
		--setProfile
		if skipReload then return end
		self:ReloadUIDialog()
	end
end
