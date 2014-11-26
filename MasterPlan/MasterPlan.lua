local api, bgapi, addonName, T = {}, {}, ...

local defaults = {
	availableMissionSort="threats",
	version="0.4"
}
local conf = setmetatable({}, {__index=defaults})
T.Evie.RegisterEvent("ADDON_LOADED", function(ev, addon)
	if addon == addonName then
		if type(MasterPlanConfig) == "table" then
			for k,v in pairs(MasterPlanConfig) do
				if type(v) == type(defaults[k]) then
					conf[k] = v
				end
			end
		end
		conf.version = defaults.version
		T.Evie.RaiseEvent("MP_SETTINGS_CHANGED")
		return "remove"
	end
end)
T.Evie.RegisterEvent("PLAYER_LOGOUT", function()
	MasterPlanConfig = conf
end)

setmetatable(api, {__index=bgapi})
bgapi.GarrisonAPI = T.Garrison

function api:SetMissionOrder(order)
	assert(type(order) == "string", 'Syntax: MasterPlan:SetMissionOrder("order")')
	conf.availableMissionSort = order
	T.Evie.RaiseEvent("MP_SETTINGS_CHANGED", "availableMissionSort")
	if GarrisonMissionFrameMissions and GarrisonMissionFrameMissions:IsShown() then
		GarrisonMissionList_UpdateMissions()
	end
end
function api:GetMissionOrder()
	return conf.availableMissionSort
end

MasterPlan = api