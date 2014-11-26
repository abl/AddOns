local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")

function nibRealUI:MiniPatch(ver)
	if ver == "81r1" then
        SetCVar("countdownForCooldowns", 0)
		if IsAddOnLoaded("Aurora") then
			if AuroraConfig then
				AuroraConfig["useButtonGradientColour"] = false
				AuroraConfig["chatBubbles"] = false
				AuroraConfig["bags"] = false
				AuroraConfig["tooltips"] = false
				AuroraConfig["loot"] = false
				AuroraConfig["useCustomColour"] = false
				AuroraConfig["enableFont"] = false
				AuroraConfig["buttonSolidColour"] = {0.09, 0.09, 0.09, 1}
			end
		end
		if IsAddOnLoaded("DBM-StatusBarTimers") then
			if DBT_PersistentOptions["DBM"] then
				DBT_PersistentOptions["DBM"]["HugeTimerY"] = 300
				DBT_PersistentOptions["DBM"]["HugeBarXOffset"] = 0
				DBT_PersistentOptions["DBM"]["Scale"] = 1
				DBT_PersistentOptions["DBM"]["TimerX"] = 400
				DBT_PersistentOptions["DBM"]["TimerPoint"] = "CENTER"
				DBT_PersistentOptions["DBM"]["HugeBarYOffset"] = 9
				DBT_PersistentOptions["DBM"]["HugeScale"] = 1
				DBT_PersistentOptions["DBM"]["HugeTimerPoint"] = "CENTER"
				DBT_PersistentOptions["DBM"]["BarYOffset"] = 9
				DBT_PersistentOptions["DBM"]["HugeTimerX"] = -400
				DBT_PersistentOptions["DBM"]["TimerY"] = 300
				DBT_PersistentOptions["DBM"]["BarXOffset"] = 0
			end
		end
		if IsAddOnLoaded("BugSack") then
			if BugSackLDBIconDB then
				BugSackLDBIconDB["hide"] = false
			end
		end
	elseif ver == "81r8" then
		if IsAddOnLoaded("Bartender4") and Bartender4DB then
			if Bartender4DB["namespaces"]["PetBar"]["profiles"]["RealUI-Healing"] then
				Bartender4DB["namespaces"]["PetBar"]["profiles"]["RealUI-Healing"] = Bartender4DB["namespaces"]["PetBar"]["profiles"]["RealUI"]
			end
		end
	end
end
