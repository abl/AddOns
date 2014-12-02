local addonName, vars = ...
local L = vars.L
Arh = {}
local addon = Arh
addon.vars = vars
vars.svnrev = vars.svnrev or {}
local svnrev = vars.svnrev
svnrev["Arh.lua"] = tonumber(("$Revision: 71 $"):match("%d+"))

local MapData = nil
local Config = nil -- AceConfig-3.0
local minimapIcon = LibStub("LibDBIcon-1.0")
local LDB, LDBo

local cfg = nil

local ARH_GREEN = 1
local ARH_YELLOW = 2
local ARH_RED = 3

local CONYARDS = {[ARH_GREEN] = 40, [ARH_YELLOW] = 80, [ARH_RED] = 640}

local minimap_size =
{
	indoor =
	{
		[0] = 300, -- scale
		[1] = 240, -- 1.25
		[2] = 180, -- 5/3
		[3] = 120, -- 2.5
		[4] = 80,  -- 3.75
		[5] = 50,  -- 6
	},
	outdoor =
	{
		[0] = 466 + 2/3, -- scale
		[1] = 400,       -- 7/6
		[2] = 333 + 1/3, -- 1.4
		[3] = 266 + 2/6, -- 1.75
		[4] = 200,       -- 7/3
		[5] = 133 + 1/3, -- 3.5
	},
}
local minimap_scale =
{
	indoor =
	{
		[0] = 1,
		[1] = 1.25,
		[2] = 5/3,
		[3] = 2.5,
		[4] = 3.75,
		[5] = 6,
	},
	outdoor =
	{
		[0] = 1,
		[1] = 7/6,
		[2] = 1.4,
		[3] = 1.75,
		[4] = 7/3,
		[5] = 3.5,
	},
}

local function CopyByValue(t)
	if type(t) ~= "table" then return t end
	local t2 = {}
	for k,v in pairs(t) do
		t2[CopyByValue(k)] = CopyByValue(v)
	end
	return t2
end

local function GetNewestStructure(old, new)
	if new == nil then return nil end
	if old == nil then return CopyByValue(new) end					-- field added
	if type(old) ~= type(new) then return CopyByValue(new) end		-- structure changed
	if type(old) ~= "table" then return old end						-- same structure, using old value
	local t = {}
	for k,v in pairs(new) do										-- using new structure
		t[CopyByValue(k)] = GetNewestStructure(old[k], v)
	end
	return t
end

local function SetVisible(self, visible)
	if visible then
		self:Show()
	else
		self:Hide()
	end
end

local SOUND_SHOWMAINFRAME = "Sound\\interface\\uMiniMapOpen.wav"
local SOUND_HIDEMAINFRAME = "Sound\\interface\\uMiniMapClose.wav"
local SOUND_ADDCON = "Sound\\Interface\\iUiInterfaceButtonA.ogg"
local SOUND_SHOWCOLOR = "Sound\\Universal\\TomeUnSheath.wav"
local SOUND_HIDECOLOR = "Sound\\Universal\\TomeSheath.wav"
local SOUND_BACK = "Sound\\interface\\PickUp\\PickUpMeat.wav"
--local SOUND_GATHERING = "Sound\\interface\\PickUp\\PickUpMeat.wav"

local function PlaySound(soundfile)
	if cfg.MainFrame.PlaySounds then
		PlaySoundFile(soundfile)
	end
end

local function ArchyShown()
  return Archy and Archy.db and Archy.db.profile and Archy.db.profile.general and Archy.db.profile.general.show
end

local function ArchyUpdate()
  local shown = ArchyShown()
  if addon.archy_state == shown then return end -- no change
  addon.archy_state = shown
  local follow = cfg and cfg.MainFrame and cfg.MainFrame.FollowArchy
  if not follow then return end -- disabled
  addon:ToggleMainFrame(shown)
end

function addon:HookArchy()
  if Archy and Archy.ConfigUpdated and not addon.archy_hooked then
    hooksecurefunc(Archy, "ConfigUpdated", ArchyUpdate)
    addon.archy_hooked = true
    addon.archy_state = ArchyShown()
  end
end

local function DigsiteUpdate(self, elapsed)
  if InCombatLockdown() then return end
  local shown = CanScanResearchSite()
  local follow = cfg and cfg.MainFrame and cfg.MainFrame.FollowDigsite
  if follow and not cfg.MainFrame.Visible ~= not shown then 
    addon:ToggleMainFrame(shown)
  end
end

addon.hiddenFrame = CreateFrame("Button", "ArhHiddenFrame", UIParent)
addon.hiddenFrame:SetScript("OnUpdate",DigsiteUpdate)

function addon:ToggleMainFrame(enable)
	if enable ~= nil then
		cfg.MainFrame.Visible = enable
	else
		cfg.MainFrame.Visible = not Arh_MainFrame:IsVisible()
	end
	if not InCombatLockdown() then SetVisible(Arh_MainFrame, cfg.MainFrame.Visible) end
	addon:ToggleHUD(cfg.MainFrame.Visible)
	if cfg.MainFrame.Visible then
		PlaySound(SOUND_SHOWMAINFRAME)
	else
		PlaySound(SOUND_HIDEMAINFRAME)
	end
end

function addon:ToggleHUD(enable)
	if enable ~= nil then
		cfg.HUD.Visible = enable
	else
		cfg.HUD.Visible = not Arh_HudFrame:IsVisible()
	end
	Arh_MainFrame_ButtonDig.Canceled = not cfg.HUD.Visible
	SetVisible(Arh_MainFrame_ButtonDig.CanceledTexture, not cfg.HUD.Visible)
	SetVisible(Arh_HudFrame, cfg.HUD.Visible)
        addon.suppress = false -- manual override disables suppression
	--[[
	if cfg.HUD.Visible then
		PlaySound(SOUND_SHOWMAINFRAME)
	else
		PlaySound(SOUND_HIDEMAINFRAME)
	end
	--]]
end

function addon:CheckSuppress()
  local shouldsuppress = false
  if UnitIsGhost("player") or 
     UnitInBattleground("player") or 
     UnitInVehicle("player") or
     IsInInstance() or
     (C_PetBattles and C_PetBattles.IsInBattle()) or -- in pet battle
     not select(3,GetProfessions()) -- lacks archaeology
     then
    shouldsuppress = true
  elseif cfg.MainFrame.HideCombat and (InCombatLockdown() or UnitAffectingCombat("player") or UnitAffectingCombat("pet")) then
    shouldsuppress = true
  elseif cfg.MainFrame.HideResting and IsResting() then
    shouldsuppress = true
  end
  if shouldsuppress and not addon.suppress then -- begin suppress
    if not InCombatLockdown() then SetVisible(Arh_MainFrame, false) end
    SetVisible(Arh_HudFrame, false)
    addon.suppress = true  
  elseif not shouldsuppress and addon.suppress then -- end suppress
    if not InCombatLockdown() then SetVisible(Arh_MainFrame, cfg.MainFrame.Visible) end
    SetVisible(Arh_HudFrame, cfg.HUD.Visible)
    addon.suppress = false
  end
end

function addon:Config()
    if InterfaceOptionsFrame:IsShown() then
        InterfaceOptionsFrame:Hide()
    else
	InterfaceOptionsFrame_OpenToCategory("Arh")
    end
end

function addon:ToggleArch()
  if not IsAddOnLoaded("Blizzard_ArchaeologyUI") then
    local loaded, reason = LoadAddOn("Blizzard_ArchaeologyUI")
    if not loaded then return end
  end
  if ArchaeologyFrame:IsShown() then
    HideUIPanel(ArchaeologyFrame)
  else
    ShowUIPanel(ArchaeologyFrame)
  end
end

local function cs(str)
	return "|cffffff78"..str.."|r"
end

Arh_DefaultConfig =
{
	MainFrame =
	{
		Visible = true,
		FollowArchy = true,
		FollowDigsite = true,
		HideCombat = true,
		HideResting = true,
		Locked = false,
		Scale = 1,
		Alpha = 1,
		ShowTooltips = true,
		TooltipsScale = 1,
		PlaySounds = true,
		posX = 0,
		posY = 0,
		point = "CENTER",
	},
	HUD =
	{
		Visible = true,
		UseGatherMate2 = true,
		Scale = 1,
		Alpha = 1,
		PosX = 0,
		PosY = 0,
		ShowArrow = true,
		ArrowScale = 1,
		ArrowAlpha = 1,
		ArchOnly = true,
		ShowSuccessCircle = true,
		SuccessCircleColor = {r=1, g=0, b=0, a=1},
		ShowCompass = false,
		CompassRadius = 120,
		CompassColor = {r=0, g=1, b=0, a=0.5},
		CompassTextColor = {r=0, g=1, b=0, a=0.5},
		RedSectAlpha = 0.1,
		RedLineAlpha = 0.05,
		YellowSectAlpha = 0.1,
		YellowLineAlpha = 0.2,
		GreenSectAlpha = 0.1,
		GreenLineAlpha = 0.2,
	},
	DigSites =
	{
		ShowOnBattlefieldMinimap = true,
	},
	Minimap =
	{
		hide = false,
		minimapPos = 0,
	},
}

BINDING_HEADER_ARH = L["Archaeology Helper"]
_G["BINDING_NAME_CLICK Arh_MainFrame_ButtonDig:LeftButton"] = L["Cast Survey"]
BINDING_NAME_ARH_TOGGLEMAIN = L["Show/Hide the Main Window"]
BINDING_NAME_ARH_TOGGLEHUD = L["Show/Hide the HUD"]
BINDING_NAME_ARH_SHOWARCHAEOLOGYFRAME = L["Open archaeology window"]
BINDING_NAME_ARH_ADDRED = 	L["Add %s area to the HUD"]:format(L["red"])
BINDING_NAME_ARH_ADDYELLOW = 	L["Add %s area to the HUD"]:format(L["yellow"])
BINDING_NAME_ARH_ADDGREEN = 	L["Add %s area to the HUD"]:format(L["green"])
BINDING_NAME_ARH_TOGGLERED = 	L["Show/Hide all %s areas"]:format(L["red"])
BINDING_NAME_ARH_TOGGLEYELLOW = L["Show/Hide all %s areas"]:format(L["yellow"])
BINDING_NAME_ARH_TOGGLEGREEN = 	L["Show/Hide all %s areas"]:format(L["green"])
BINDING_NAME_ARH_BACK = L["Remove one previously added area"]

function addon:ResetSettings()
	local c

-- MainFrame
	SetVisible(Arh_MainFrame, cfg.MainFrame.Visible)
    Arh_MainFrame:SetScale(cfg.MainFrame.Scale)
	Arh_MainFrame:SetAlpha(cfg.MainFrame.Alpha)
	Arh_MainFrame:ClearAllPoints()
	Arh_MainFrame:SetPoint("CENTER")

	-- HUD
	Arh_SetUseGatherMate2(cfg.HUD.UseGatherMate2)
	addon:HUD_config_update()
	Arh_UpdateHudFrameSizes(true)

	-- Annulus Sectors
	addon:UpdateAlphaEverything()
	addon:ToggleHUD(cfg.HUD.Visible)

-- Dig Sites
	SetVisible(Arh_ArchaeologyDigSites_BattlefieldMinimap, cfg.DigSites.ShowOnBattlefieldMinimap)

end

local function SafeSetBinding(key, action)
	if key == "" then
		oldkey = GetBindingKey(action)
		if oldkey then
			SetBinding(oldkey, nil)
		end
	else
		SetBinding(key, action)
	end
	SaveBindings(GetCurrentBindingSet())
end

-- return current value of minimap arch tracking
function addon:GetDigsiteTracking()
  local id, active
  for i=1,GetNumTrackingTypes() do 
    local name, texture, a, category = GetTrackingInfo(i)
    if texture:find("ArchBlob") then
      id = i
      active = a
      break
    end
  end
  return active, id
end
-- set minimap arch tracking and return the old enabled value
function addon:SetDigsiteTracking(on)
  local active, id = addon:GetDigsiteTracking()
  if id then
    MiniMapTracking_SetTracking(Minimap, id, nil, on)
  end
  return active
end

local OptionsTable =
{
	type = "group",
	args =
		{
			ResetToDefaults =
			{
				order = 1,
				name = L["Reset All Settings"],
				desc = L["Resets all settings to defaults"],
				type = "execute",
				confirm = true,
				confirmText = L["This will overwrite current settings!"],
				func =
						function()
							Arh_Config = CopyByValue(Arh_DefaultConfig)
							cfg = Arh_Config
							addon:ResetSettings()
						end,
			},
			MainFrame =
			{
				order = 2,
				name = L["Main Window"],
				desc = L["Main window settings"],
				type = "group",
				args =
				{
					VisualOptions =
					{
						order = 1,
						type = "group",
						name = L["Visual Settings"],
						inline = true,
						args =
						{
							reset =
							{
								order = 1,
								name = L["Reset Position"],
								desc = L["Resets window position to the center of the screen"],
								type = "execute",
								width = "full",
								confirm = true,
								confirmText = L["This will reset Main Window position"],
								func =
										function()
											Arh_MainFrame:ClearAllPoints()
											Arh_MainFrame:SetPoint("CENTER")
										end,
							},
							visible =
							{
								order = 2,
								name = L["Visible"],
								desc = L["Whether window is visible"],
								type = "toggle",
								get = function(info) return cfg.MainFrame.Visible end,
								set =
									function(info, val)
										addon:ToggleMainFrame(val)
									end,
							},
							archy =
							{
								order = 2.5,
								name = L["Toggle with Archy"],
								desc = L["Show/Hide window when you show/hide Archy addon"],
								type = "toggle",
								disabled = function(info) return not Archy end,
								get = function(info) return cfg.MainFrame.FollowArchy end,
								set = function(info, val) cfg.MainFrame.FollowArchy = val end,
							},
							digsite =
							{
								order = 2.5,
								name = L["Toggle with digsite"],
								desc = L["Show/Hide window when entering/leaving a digsite"],
								type = "toggle",
								get = function(info) return cfg.MainFrame.FollowDigsite end,
								set = function(info, val) cfg.MainFrame.FollowDigsite = val end,
							},
							hidecombat =
							{
								order = 2.7,
								name = L["Hide on combat"],
								desc = L["Hide on combat"],
								type = "toggle",
								get = function(info) return cfg.MainFrame.HideCombat end,
								set = function(info, val) cfg.MainFrame.HideCombat = val end,
							},
							hideresting =
							{
								order = 2.9,
								name = L["Hide when resting"],
								desc = L["Hide when resting"],
								type = "toggle",
								get = function(info) return cfg.MainFrame.HideResting end,
								set = function(info, val) cfg.MainFrame.HideResting = val end,
							},
							locked =
							{
								order = 3,
								name = L["Locked"],
								desc = L["Locks window to prevent accidental repositioning"],
								type = "toggle",
								get = function(info) return cfg.MainFrame.Locked end,
								set =
									function(info, val)
										cfg.MainFrame.Locked = val
									end,
							},
      							minimap = {
        							order = 3.5,
        							name = L["Minimap Icon"],
        							desc = L["Display minimap icon"],
        							type = "toggle",
        							set = function(info,val)
          								cfg.Minimap.hide = not val
									minimapIcon:Refresh(addonName)
        							end,
        							get = function() return not cfg.Minimap.hide end,
      							},
							scale =
							{
								order = 4,
								name = L["Scaling"],
								desc = L["Size of the main window"],
								type = "range",
								min = 0.1,
								max = 100,
								softMin = 0.5,
								softMax = 5,
								step = 0.1,
								get = function(info) return cfg.MainFrame.Scale end,
								set =
									function(info, val)
										cfg.MainFrame.Scale = val
										Arh_MainFrame:SetScale(val)
									end,
							},
							alpha =
							{
								order = 5,
								name = L["Alpha"],
								desc = L["How transparent is window"],
								type = "range",
								min = 0,
								max = 1,
								step = 0.01,
								isPercent = true,
								get = function(info) return cfg.MainFrame.Alpha end,
								set =
									function(info, val)
										cfg.MainFrame.Alpha = val
										Arh_MainFrame:SetAlpha(val)
									end,
							},
							ShowTooltips =
							{
								order = 6,
								name = L["Show Tooltips"],
								desc = L["Show Tooltips in the main window"],
								type = "toggle",
								get = function(info) return cfg.MainFrame.ShowTooltips end,
								set = function(info, val) cfg.MainFrame.ShowTooltips = val end,
							},
							TooltipsScaling =
							{
								order = 7,
								name = L["Tooltips Scaling"],
								desc = L["Scale main window Tooltips"],
								type = "range",
								min = 0.10,
								max = 3.00,
								step = 0.05,
								isPercent = true,
								disabled = function(info) return not cfg.MainFrame.ShowTooltips end,
								get = function(info) return cfg.MainFrame.TooltipsScale end,
								set =
									function(info, val)
										cfg.MainFrame.TooltipsScale = val
										Arh_Tooltip:SetScale(val)
									end,
							},
						},
					},
					AudioOptions =
					{
						order = 2,
						type = "group",
						name = L["Audio Settings"],
						inline = true,
						args =
						{
							PlaySounds =
							{
								order = 1,
								name = L["Play Sounds"],
								desc = L["Play confirmation sounds for various actions"],
								type = "toggle",
								get = function(info) return cfg.MainFrame.PlaySounds end,
								set =
									function(info, val)
										cfg.MainFrame.PlaySounds = val
									end,
							},
						},
					},
					KeyBindings =
					{
						order = 3,
						type = "group",
						name = L["Key Bindings Settings"],
						inline = true,
						args = 
						{
							CastSurveyKeyBinding =
							{
								order = 1,
								width = "full",
								type = "keybinding",
								name = _G["BINDING_NAME_CLICK Arh_MainFrame_ButtonDig:LeftButton"],
								desc = L["Cast Survey"],
								get =
										function()
											return GetBindingKey("CLICK Arh_MainFrame_ButtonDig:LeftButton")
										end,
								set =
										function(info, v)
											SafeSetBinding(v, "CLICK Arh_MainFrame_ButtonDig:LeftButton")
										end
							},
							ToggleMainKeyBinding =
							{
								order = 1.5,
								width = "full",
								type = "keybinding",
								name = BINDING_NAME_ARH_TOGGLEMAIN,
								desc = string.format(L["You can also use %s command for this action"],"|cff69ccf0/arh t|r"),
								get =
										function()
											return GetBindingKey("ARH_TOGGLEMAIN")
										end,
								set =
										function(info, v)
											SafeSetBinding(v, "ARH_TOGGLEMAIN")
										end
							},
							ToggleHudKeyBinding =
							{
								order = 2,
								width = "full",
								type = "keybinding",
								name = BINDING_NAME_ARH_TOGGLEHUD,
								desc = string.format(L["You can also use %s command for this action"],"|cff69ccf0/arh h|r"),
								get =
										function()
											return GetBindingKey("ARH_TOGGLEHUD")
										end,
								set =
										function(info, v)
											SafeSetBinding(v, "ARH_TOGGLEHUD")
										end
							},
							ShowArchaeologyFrameKeyBinding =
							{
								order = 3,
								width = "full",
								type = "keybinding",
								name = BINDING_NAME_ARH_SHOWARCHAEOLOGYFRAME,
								desc = L["Open archaeology window"],
								get =
										function()
											return GetBindingKey("ARH_SHOWARCHAEOLOGYFRAME")
										end,
								set =
										function(info, v)
											SafeSetBinding(v, "ARH_SHOWARCHAEOLOGYFRAME")
										end
							},
							RedButtonKeyBinding =
							{
								order = 4,
								width = "full",
								type = "keybinding",
								name = BINDING_NAME_ARH_ADDRED,
								desc = string.format(L["You can also use %s command for this action"],"|cff69ccf0/arh ar|r"),
								get =
										function()
											return GetBindingKey("ARH_ADDRED")
										end,
								set =
										function(info, v)
											SafeSetBinding(v, "ARH_ADDRED")
										end
							},
							YellowButtonKeyBinding =
							{
								order = 5,
								width = "full",
								type = "keybinding",
								name = BINDING_NAME_ARH_ADDYELLOW,
								desc = string.format(L["You can also use %s command for this action"],"|cff69ccf0/arh ay|r"),
								get =
										function()
											return GetBindingKey("ARH_ADDYELLOW")
										end,
								set =
										function(info, v)
											SafeSetBinding(v, "ARH_ADDYELLOW")
										end
							},
							GreenButtonKeyBinding =
							{
								order = 6,
								width = "full",
								type = "keybinding",
								name = BINDING_NAME_ARH_ADDGREEN,
								desc = string.format(L["You can also use %s command for this action"],"|cff69ccf0/arh ag|r"),
								get =
										function()
											return GetBindingKey("ARH_ADDGREEN")
										end,
								set =
										function(info, v)
											SafeSetBinding(v, "ARH_ADDGREEN")
										end
							},
							ToggleRedButtonKeyBinding =
							{
								order = 7,
								width = "full",
								type = "keybinding",
								name = BINDING_NAME_ARH_TOGGLERED,
								desc = L["Show/Hide all %s areas"]:format(L["red"]),
								get =
										function()
											return GetBindingKey("ARH_TOGGLERED")
										end,
								set =
										function(info, v)
											SafeSetBinding(v, "ARH_TOGGLERED")
										end
							},
							ToggleYellowButtonKeyBinding =
							{
								order = 8,
								width = "full",
								type = "keybinding",
								name = BINDING_NAME_ARH_TOGGLEYELLOW,
								desc = L["Show/Hide all %s areas"]:format(L["yellow"]),
								get =
										function()
											return GetBindingKey("ARH_TOGGLEYELLOW")
										end,
								set =
										function(info, v)
											SafeSetBinding(v, "ARH_TOGGLEYELLOW")
										end
							},
							ToggleGreenButtonKeyBinding =
							{
								order = 9,
								width = "full",
								type = "keybinding",
								name = BINDING_NAME_ARH_TOGGLEGREEN,
								desc = L["Show/Hide all %s areas"]:format(L["green"]),
								get =
										function()
											return GetBindingKey("ARH_TOGGLEGREEN")
										end,
								set =
										function(info, v)
											SafeSetBinding(v, "ARH_TOGGLEGREEN")
										end
							},
							BackButtonKeyBinding =
							{
								order = 10,
								width = "full",
								type = "keybinding",
								name = BINDING_NAME_ARH_BACK,
								desc = L["Remove one previously added area"],
								get =
										function()
											return GetBindingKey("ARH_BACK")
										end,
								set =
										function(info, v)
											SafeSetBinding(v, "ARH_BACK")
										end
							},
						},
					},

				},
			},
			HUD =
			{
				order = 3,
				name = L["HUD"],
				desc = L["HUD settings"],
				type = "group",
				args =
				{
					General =
					{
						order = 1,
						type = "group",
						name = L["General HUD Settings"],
						inline = true,
						args = 
						{
							ShowGatherMate2 =
							{
								order = 1,
								name = L["Show GatherMate2 pins on the HUD (recomended)"],
								desc = L["Redirect GatherMate2 output to the HUD when visible"],
								type = "toggle",
								width = "full",
								disabled = function(info) return not GatherMate2 end,
								get = function(info) return cfg.HUD.UseGatherMate2 end,
								set = function(info,val) Arh_SetUseGatherMate2(val) end,
							},
							ArchOnly =
							{
								order = 1.5,
								name = L["Arch nodes only"],
								desc = L["Only show Archaeology nodes from GatherMate2 on the HUD"],
								type = "toggle",
								width = "full",
								get = function(info) return cfg.HUD.ArchOnly end,
								set =
									function(info,val)
										cfg.HUD.ArchOnly = val
										addon:ToggleHUD();addon:ToggleHUD()
									end,
								disabled = function(info) return not cfg.HUD.UseGatherMate2 end,
							},
							scale =
							{
								order = 2,
								name = L["HUD Scaling"],
								desc = L["Size of the HUD\nIf you need ZOOM - use Minimap ZOOM instead"],
								type = "range",        
								min = 0.1,
								max = 100,
								softMin = 0.1,
								softMax = 3,
								step = 0.1,
								get = function(info) return cfg.HUD.Scale end,
								set =
									function(info,val)
										cfg.HUD.Scale = val
										addon:HUD_config_update()
									end,
							},
							alpha =
							{
								order = 3,
								name = L["HUD Alpha"],
								desc = L["How transparent is HUD"],
								type = "range",        
								min = 0,
								max = 1,
								step = 0.01,
								isPercent = true,
								get = function(info) return cfg.HUD.Alpha end,
								set =
									function(info,val)
										cfg.HUD.Alpha = val
										addon:HUD_config_update()
									end,
							},
							posx =
							{
								order = 3,
								name = L["HUD X-Offset"],
								desc = L["Horizontal position of HUD relative to screen center"],
								type = "range",        
								min = -0.5,
								max = 0.5,
								step = 0.01,
								isPercent = true,
								get = function(info) return cfg.HUD.PosX end,
								set = function(info,val)
										cfg.HUD.PosX = val
										addon:HUD_config_update()
									end,
							},
							posy =
							{
								order = 3,
								name = L["HUD Y-Offset"],
								desc = L["Vertical position of HUD relative to screen center"],
								type = "range",        
								min = -0.5,
								max = 0.5,
								step = 0.01,
								isPercent = true,
								get = function(info) return cfg.HUD.PosY end,
								set = function(info,val)
										cfg.HUD.PosY = val
										addon:HUD_config_update()
									end,
							},
							ShowArrow =
							{
								order = 4,
								name = L["Show Player Arrow"],
								desc = L["Draw arrow in the center of the HUD"],
								type = "toggle",
								width = "full",
								get = function(info) return cfg.HUD.ShowArrow end,
								set =
									function(info,val)
										cfg.HUD.ShowArrow = val
										addon:HUD_config_update()
									end,
							},
							ArrowScale =
							{
								order = 5,
								name = L["Arrow Scaling"],
								desc = L["Size of the Player Arrow"],
								type = "range",
								disabled = function(info) return not cfg.HUD.ShowArrow end,
								min = 0.1,
								max = 100,
								softMin = 0.1,
								softMax = 10,
								step = 0.1,
								get = function(info) return cfg.HUD.ArrowScale end,
								set =
									function(info,val)
										cfg.HUD.ArrowScale = val
										addon:HUD_config_update()
									end,
							},
							ArrowAlpha =
							{
								order = 6,
								name = L["Arrow Alpha"],
								desc = L["How transparent is Player Arrow"],
								type = "range",
								disabled = function(info) return not cfg.HUD.ShowArrow end,
								min = 0,
								max = 1,
								step = 0.01,
								isPercent = true,
								get = function(info) return cfg.HUD.ArrowAlpha end,
								set =
									function(info,val)
										cfg.HUD.ArrowAlpha = val
										addon:HUD_config_update()
									end,
							},
							ShowSuccessCircle =
							{
								order = 7,
								name = L["Show Success Circle"],
								desc = L["Survey will succeed if fragment lies within this circle"],
								type = "toggle",
								get = function(info) return cfg.HUD.ShowSuccessCircle end,
								set =
									function(info,val)
										cfg.HUD.ShowSuccessCircle = val
										addon:HUD_config_update()
									end,
							},
							SuccessCircleColor =
							{
								order = 8,
								name = L["Success Circle Color"],
								desc = L["Color of the Success Circle (you can also set alpha here)"],
								type = "color",
								hasAlpha  = true,
								disabled = function(info) return not cfg.HUD.ShowSuccessCircle end,
								get =
										function(info)
											local c = cfg.HUD.SuccessCircleColor
											return c.r, c.g, c.b, c.a
										end,
								set =
										function(info, r, g, b, a)
											local c = cfg.HUD.SuccessCircleColor
											c.r, c.g, c.b, c.a = r, g, b, a
											addon:HUD_config_update()
										end,
							},

						},
					},
					Compass =
					{
						order = 2,
						type = "group",
						name = L["Compass Settings"],
						inline = true,
						args = 
						{
							ShowCompass =
							{
								order = 1,
								name = L["Show compass"],
								desc = L["Draw compass-like circle on the HUD"],
								type = "toggle",
								get = function(info) return cfg.HUD.ShowCompass end,
								set =
									function(info,val)
										cfg.HUD.ShowCompass = val
										addon:HUD_config_update()
									end,
							},
							CompassRadius =
							{
								order = 2,
								name = L["Radius (yards)"],
								desc = L["Radius of the compass circle"],
								type = "range",
								disabled = function(info) return not cfg.HUD.ShowCompass end,
								min = 1,
								max = 1000,
								softMin = 10,
								softMax = 300,
								step = 1,
								get = function(info) return cfg.HUD.CompassRadius end,
								set =
									function(info,val)
										cfg.HUD.CompassRadius = val
										Arh_UpdateHudFrameSizes(true)
									end,
							},
							CompassColor =
							{
								order = 3,
								name = L["Compass Circle Color"],
								desc = L["Color of the Compass Circle (you can also set alpha here)"],
								type = "color",
								hasAlpha  = true,
								disabled = function(info) return not cfg.HUD.ShowCompass end,
								get =
										function(info)
											local c = cfg.HUD.CompassColor
											return c.r, c.g, c.b, c.a
										end,
								set =
										function(info, r, g, b, a)
											local c = cfg.HUD.CompassColor
											c.r, c.g, c.b, c.a = r, g, b, a
											addon:HUD_config_update()
										end,
							},
							CompassTextColor =
							{
								order = 4,
								name = L["Direction Marks Color"],
								desc = L["Color of Compass Direction Marks (you can also set alpha here)"],
								type = "color",
								hasAlpha  = true,
								disabled = function(info) return not cfg.HUD.ShowCompass end,
								get =
										function(info)
											local c = cfg.HUD.CompassTextColor
											return c.r, c.g, c.b, c.a
										end,
								set =
										function(info, r, g, b, a)
											local c = cfg.HUD.CompassTextColor
											c.r, c.g, c.b, c.a = r, g, b, a
											addon:HUD_config_update()
										end,
							},

						},
					},
					AnnulusSectors =
					{
						order = 3,
						type = "group",
						name = L["Annulus Sectors Settings"],
						inline = true,
						args = 
						{
							RedSectAlpha =
							{
								order = 1,
								name = L["%s Sector Alpha"]:format(L["Red"]),
								desc = L["How transparent is %s Annulus Sector"]:format(L["Red"]),
								type = "range",
								min = 0,
								max = 1,
								step = 0.01,
								isPercent = true,
								get = function(info) return cfg.HUD.RedSectAlpha end,
								set =
									function(info,val)
										cfg.HUD.RedSectAlpha = val
										addon:UpdateAlphaEverything()
									end,
							},
							RedLineAlpha =
							{
								order = 2,
								name = L["%s Line Alpha"]:format(L["Red"]),
								desc = L["How transparent is %s Direction Line"]:format(L["Red"]),
								type = "range",
								min = 0,
								max = 1,
								step = 0.01,
								isPercent = true,
								get = function(info) return cfg.HUD.RedLineAlpha end,
								set =
									function(info,val)
										cfg.HUD.RedLineAlpha = val
										addon:UpdateAlphaEverything()
									end,
							},
							YellowSectAlpha =
							{
								order = 3,
								name = L["%s Sector Alpha"]:format(L["Yellow"]),
								desc = L["How transparent is %s Annulus Sector"]:format(L["Yellow"]),
								type = "range",
								min = 0,
								max = 1,
								step = 0.01,
								isPercent = true,
								get = function(info) return cfg.HUD.YellowSectAlpha end,
								set =
									function(info,val)
										cfg.HUD.YellowSectAlpha = val
										addon:UpdateAlphaEverything()
									end,
							},
							YellowLineAlpha =
							{
								order = 4,
								name = L["%s Line Alpha"]:format(L["Yellow"]),
								desc = L["How transparent is %s Direction Line"]:format(L["Yellow"]),
								type = "range",
								min = 0,
								max = 1,
								step = 0.01,
								isPercent = true,
								get = function(info) return cfg.HUD.YellowLineAlpha end,
								set =
									function(info,val)
										cfg.HUD.YellowLineAlpha = val
										addon:UpdateAlphaEverything()
									end,
							},
							GreenSectAlpha =
							{
								order = 5,
								name = L["%s Sector Alpha"]:format(L["Green"]),
								desc = L["How transparent is %s Annulus Sector"]:format(L["Green"]),
								type = "range",
								min = 0,
								max = 1,
								step = 0.01,
								isPercent = true,
								get = function(info) return cfg.HUD.GreenSectAlpha end,
								set =
									function(info,val)
										cfg.HUD.GreenSectAlpha = val
										addon:UpdateAlphaEverything()
									end,
							},
							GreenLineAlpha =
							{
								order = 6,
								name = L["%s Line Alpha"]:format(L["Green"]),
								desc = L["How transparent is %s Direction Line"]:format(L["Green"]),
								type = "range",
								min = 0,
								max = 1,
								step = 0.01,
								isPercent = true,
								get = function(info) return cfg.HUD.GreenLineAlpha end,
								set =
									function(info,val)
										cfg.HUD.GreenLineAlpha = val
										addon:UpdateAlphaEverything()
									end,
							},
						},
					},
				},
			},
			DigSites =
			{
				order = 4,
				name = L["Dig Sites"],
				desc = L["Dig Sites"],
				type = "group",
				args =
				{
					ShowOnBattlefieldMinimap =
					{
						order = 1,
						name = L["Show digsites on the Battlefield Minimap"],
						desc = L["Use |cff69ccf0Shift-M|r to open or hide Battlefield Minimap"],
						type = "toggle",
						width = "full",
						get = function(info) return cfg.DigSites.ShowOnBattlefieldMinimap end,
						set =
							function(info,val)
								cfg.DigSites.ShowOnBattlefieldMinimap = val
								SetVisible(Arh_ArchaeologyDigSites_BattlefieldMinimap, val)
							end,
					},
					ShowOnMinimap =
					{
						order = 2,
						name = L["Show digsites on the Minimap"],
						desc = string.format(L["You can also use %s command for this action"],"|cff69ccf0/arh mm|r"),
						type = "toggle",
						width = "full",
						get = function(info) return addon:GetDigsiteTracking() end,
						set = function(info,val) addon:SetDigsiteTracking(val) end,
					},
				},
			},

		}
}

function Arh_ShowTooltip(self)
	if not cfg.MainFrame.ShowTooltips then return end
	if not self.TooltipText then return end

	local text
	if type(self.TooltipText)=="string" then
		text = self.TooltipText
	elseif type(self.TooltipText)=="function" then
		text = self.TooltipText(self)
		if not text then return end
	end
	Arh_Tooltip:SetScale(cfg.MainFrame.TooltipsScale)
	Arh_Tooltip:SetOwner(self, "ANCHOR_CURSOR")
	Arh_Tooltip:AddLine(text, 1, 1, 1)
	Arh_Tooltip:Show()
end
function Arh_HideTooltip(self)
	Arh_Tooltip:Hide()
end

local function SetTooltips()
	Arh_MainFrame.TooltipText =
		function(self)
			if cfg.MainFrame.Locked then
				return cs(L["Right Click"])..": "..L["Show/Hide Config"]
			else
				return cs(L["Left Click"])..": "..L["move window"].."\n"..cs(L["Right Click"])..": "..L["Show/Hide Config"]
			end
		end
	Arh_MainFrame_ButtonRed.TooltipText = cs(L["Left Click"])..": "..L["add new %s zone to the HUD"]:format(L["red"]).."\n"..
                                              cs(L["Right Click"])..": "..L["show/hide all %s areas on the HUD"]:format(L["red"])
	Arh_MainFrame_ButtonYellow.TooltipText = cs(L["Left Click"])..": "..L["add new %s zone to the HUD"]:format(L["yellow"]).."\n"..
                                                 cs(L["Right Click"])..": "..L["show/hide all %s areas on the HUD"]:format(L["yellow"])
	Arh_MainFrame_ButtonGreen.TooltipText = cs(L["Left Click"])..": "..L["add new %s zone to the HUD"]:format(L["green"]).."\n"..
                                                cs(L["Right Click"])..": "..L["show/hide all %s areas on the HUD"]:format(L["green"])
	Arh_MainFrame_ButtonDig.TooltipText = cs(L["Left Click"])..": "..L["cast Survey"].."\n"..
                                              cs(L["Right Click"])..": "..L["Show/Hide the HUD"].."\n"..
                                              cs(L["Middle Click"])..": "..L["Open archaeology window"]
	Arh_MainFrame_ButtonBack.TooltipText = cs(L["Left Click"])..": "..L["remove one previously added area"]
end

local function RotateTexture(item, angle)
	--item.texture:SetRotation(angle)
	--item.texture_line:SetRotation(angle)
	local cos, sin = math.cos(angle), math.sin(angle)
	local p, m = (sin+cos)/2, (sin-cos)/2
	local pp, pm, mp, mm = 0.5+p, 0.5+m, 0.5-p, 0.5-m
	item.texture:SetTexCoord(pm, mp, mp, mm, pp, pm, mm, pp)
	item.texture_line:SetTexCoord(pm, mp, mp, mm, pp, pm, mm, pp)
end

local function CreateConTexture(parent, color)
	local t = parent:CreateTexture()
	t:SetBlendMode("ADD")
	t:SetPoint("CENTER", parent, "CENTER", 0, 0)
	t:SetTexture("Interface\\AddOns\\Arh\\img\\con1024_"..color)
	t:Show()

	return t
end

local function CreateLineTexture(parent, contexture, color)
	local t = parent:CreateTexture()
	t:SetBlendMode("ADD")
	t:SetPoint("CENTER", contexture, "CENTER", 0, 0)
	t:SetTexture("Interface\\AddOns\\Arh\\img\\line1024_"..color)
	t:Show()

	return t
end

local function SetTextureColor(texture, color, isline)
	local r,g,b,a
	if isline then
		if color == ARH_RED then
			r,g,b,a = 1,0,0,cfg.HUD.RedLineAlpha
		elseif color == ARH_YELLOW then
			r,g,b,a = 0.5,0.5,0,cfg.HUD.YellowLineAlpha
		elseif color == ARH_GREEN then
			r,g,b,a = 0,1,0,cfg.HUD.GreenLineAlpha
		end
	else
		if color == ARH_RED then
			r,g,b,a = 1,0,0,cfg.HUD.RedSectAlpha
		elseif color == ARH_YELLOW then
			r,g,b,a = 0.5,0.5,0,cfg.HUD.YellowSectAlpha
		elseif color == ARH_GREEN then
			r,g,b,a = 0,1,0,cfg.HUD.GreenSectAlpha
		end
	end
		
	texture:SetVertexColor(r,g,b,a)
end

local function PixelsInYardOnHud_Calc()
	local mapSizePix = Arh_HudFrame:GetHeight()

	local zoom = Minimap:GetZoom()
	--local indoors = GetCVar("minimapZoom")+0 == Minimap:GetZoom() and "outdoor" or "indoor"
	local indoors = IsIndoors() and "indoor" or "outdoor"

	local mapSizeYards = minimap_size[indoors][zoom]

	return mapSizePix/mapSizeYards
end
local PixelsInYardOnHud = -1


local function UpdateTextureSize(texture, color)
	texture:SetSize(PixelsInYardOnHud * CONYARDS[color]*2, PixelsInYardOnHud * CONYARDS[color]*2)
end

local function CreateCon(parent, color)
	local t = CreateConTexture(parent, color)
	SetTextureColor(t, color, false)
	UpdateTextureSize(t, color)

	return t
end
local function CreateLine(parent, color, contexture)
	local t = CreateLineTexture(parent, contexture, color)
	SetTextureColor(t, color, true)
	UpdateTextureSize(t, color)

	return t
end


local function UpdateConAndLine(texture_con, texture_line, color)
	UpdateTextureSize(texture_con, color)
	texture_con:Show()

	UpdateTextureSize(texture_line, color)
	texture_line:Show()
end

addon.ConsCache = {[ARH_GREEN] = {}, [ARH_YELLOW] = {}, [ARH_RED] = {} }
addon.ConsArray = {}
local function GetCached(color)
	local cnt = #addon.ConsCache[color]
	if cnt > 0 then
		local ret = addon.ConsCache[color][cnt]
		addon.ConsCache[color][cnt] = nil
		return ret
	else
		return nil
	end
end
function addon:ReturnAllToCache()
	for i=1,#addon.ConsArray do
	  addon:ReturnLastToCache()
	end
end
function addon:ReturnLastToCache()
	local cnt = #addon.ConsArray
	if cnt==0 then return end

	local item = addon.ConsArray[cnt]
	addon.ConsArray[cnt] = nil

	table.insert(addon.ConsCache[item.color], item)
	item.texture:Hide()
	item.texture_line:Hide()
	item.x = nil
	item.y = nil
	item.a = nil
	item.color = nil
end


local function AddCon(color, x, y, a)
	local item = GetCached(color)
	if not item then
	  item = {}
	  item.texture = CreateCon(Arh_HudFrame, color)
	  item.texture_line = CreateLine(Arh_HudFrame, color, item.texture)
	end
	item.color = color
	item.x = x
	item.y = y
	item.a = a
	table.insert(addon.ConsArray,item)
	UpdateConAndLine(item.texture, item.texture_line, color)

	local visible
	if color==ARH_RED then
		visible = not Arh_MainFrame_ButtonRed.Canceled
	elseif color==ARH_YELLOW then
		visible = not Arh_MainFrame_ButtonYellow.Canceled
	elseif color==ARH_GREEN then
		visible = not Arh_MainFrame_ButtonGreen.Canceled
	end
	SetVisible(item.texture, visible)
	SetVisible(item.texture_line, visible)

	addon:UpdateCons(x,y,a)
end

function addon:UpdateConsSizes()
	local piy = PixelsInYardOnHud_Calc()
	if piy == PixelsInYardOnHud then return end
	PixelsInYardOnHud = piy
	--print("UpdateConsSizes")
	for _,item in ipairs(addon.ConsArray) do
		UpdateTextureSize(item.texture, item.color)
		UpdateTextureSize(item.texture_line, item.color)
	end
end

function addon:UpdateConsPositions(player_x, player_y, player_a)
	local cos, sin = math.cos(player_a), math.sin(player_a)
	for _,item in ipairs(addon.ConsArray) do
		local dx, dy = item.x-player_x, item.y-player_y
		local x = dx*cos - dy*sin
		local y = dx*sin + dy*cos
		local rot = item.a-player_a

		--item.texture:ClearAllPoints()
		item.texture:SetPoint("CENTER", Arh_HudFrame, "CENTER", x*PixelsInYardOnHud, -y*PixelsInYardOnHud)
		RotateTexture(item, rot)
	end
end

function addon:UpdateAlpha(texture, color, isline)
	local a
	if isline then
		if color == ARH_RED then
			a = cfg.HUD.RedLineAlpha
		elseif color == ARH_YELLOW then
			a = cfg.HUD.YellowLineAlpha
		elseif color == ARH_GREEN then
			a = cfg.HUD.GreenLineAlpha
		end
	else
		if color == ARH_RED then
			a = cfg.HUD.RedSectAlpha
		elseif color == ARH_YELLOW then
			a = cfg.HUD.YellowSectAlpha
		elseif color == ARH_GREEN then
			a = cfg.HUD.GreenSectAlpha
		end
	end

	texture:SetAlpha(a)
end

function addon:UpdateAlphaEverything()
	for _,item in ipairs(addon.ConsArray) do
		addon:UpdateAlpha(item.texture_line, item.color, true)
		addon:UpdateAlpha(item.texture, item.color, false)
	end
	for color=ARH_GREEN,ARH_RED do
	  for _,item in ipairs(addon.ConsCache[color]) do
		addon:UpdateAlpha(item.texture_line, color, true)
		addon:UpdateAlpha(item.texture, color, false)
	  end
	end
end

function addon:UpdateCons(player_x, player_y, player_a)
	addon:UpdateConsSizes() -- if minimap zoomed
	addon:UpdateConsPositions(player_x, player_y, player_a)
end

local _lastmapid, _lastmaptext
function addon:GetPos()
  local oldcont = GetCurrentMapContinent()
  local oldmap = GetCurrentMapAreaID()
  local oldlvl = GetCurrentMapDungeonLevel()
  local map = oldmap
  local level = oldlvl
  local text = GetRealZoneText()
  local flicker
  if map ~= _lastmapid or text ~= _lastmaptext then -- try to avoid unnecessary map sets
    if WorldMapFrame and WorldMapFrame:IsVisible() then -- prevent map flicker
      if WorldMapFrame:IsMouseOver() then
        return 0,0,map,0
      end
      WorldMapFrame:Hide()
      flicker = true
    end
    SetMapToCurrentZone()
    map = GetCurrentMapAreaID()
    level = GetCurrentMapDungeonLevel();
    --print("SetMapToCurrentZone: "..oldmap.."->"..map)
    _lastmapid = map
    _lastmaptext = text
  end
  local x, y = GetPlayerMapPosition("player")
  if flicker then
    WorldMapFrame:Show()
    if oldmap ~= map then
      SetMapZoom(oldcont)
      SetMapByID(oldmap)
      _lastmapid = nil
    end
    if oldlvl and oldlvl > 0 then
      SetDungeonMapLevel(oldlvl)
    end
  end
  return x,y,map,level
end

function addon:GetPosYards()
  local x,y,map,level = addon:GetPos()
  return MapData:PointToYards(map, level, x, y)
end

local function Distance(xa, ya, xb, yb)
	return math.sqrt(math.pow(xa-xb,2)+math.pow(ya-yb,2))
end

local function CalcAngle(xa, ya, xb, yb)
	if ya == yb then
		if xa == xb then
			return 0;
		elseif xa > xb then
			return math.pi/2;
		else
			return 3*math.pi/2;
		end
	end
	local t = (xb-xa)/(yb-ya);
	local a = math.atan(t);
	if ya > yb then
		if xa == xb then
			return 0;
		elseif xa > xb then
			return a;
		else
			return a+2*math.pi;
		end
	else
		if xa == xb then
			return math.pi;
		elseif xa > xb then
			return a+math.pi;
		else
			return a+math.pi;
		end
	end
end

local function AddPoint(color)
        local jax, jay = addon:GetPosYards()
	a = GetPlayerFacing()

	AddCon(color, jax, jay, a)
	PlaySound(SOUND_ADDCON)
end

function Arh_MainFrame_ButtonRed_OnLClick()
	AddPoint(ARH_RED)
end

function Arh_MainFrame_ButtonYellow_OnLClick()
	AddPoint(ARH_YELLOW)
end

function Arh_MainFrame_ButtonGreen_OnLClick()
	AddPoint(ARH_GREEN)
end

local function ToggleColor(color, visible)
	for _,item in ipairs(addon.ConsArray) do
		if item.color == color then
			SetVisible(item.texture, visible)
			SetVisible(item.texture_line, visible)
		end
	end
end

local function ToggleColorButton(self, color, enable)
	if enable ~= nil then
		self.Canceled = not enable
	else
		self.Canceled = not self.Canceled
	end
	ToggleColor(color, not self.Canceled)
	SetVisible(self.CanceledTexture, self.Canceled)
	if enable then
		PlaySound(SOUND_SHOWCOLOR)
	else
		PlaySound(SOUND_HIDECOLOR)
	end
end

function Arh_MainFrame_ButtonRed_OnRClick()
	ToggleColorButton(Arh_MainFrame_ButtonRed, ARH_RED)
end

function Arh_MainFrame_ButtonYellow_OnRClick()
	ToggleColorButton(Arh_MainFrame_ButtonYellow, ARH_YELLOW)
end

function Arh_MainFrame_ButtonGreen_OnRClick()
	ToggleColorButton(Arh_MainFrame_ButtonGreen, ARH_GREEN)
end

function Arh_MainFrame_ButtonRed_OnMouseDown(self, button)
	if button == "LeftButton" then
		Arh_MainFrame_ButtonRed_OnLClick()
	elseif button == "RightButton" then
		Arh_MainFrame_ButtonRed_OnRClick()
	end
end

function Arh_MainFrame_ButtonYellow_OnMouseDown(self, button)
	if button == "LeftButton" then
		Arh_MainFrame_ButtonYellow_OnLClick()
	elseif button == "RightButton" then
		Arh_MainFrame_ButtonYellow_OnRClick()
	end
end

function Arh_MainFrame_ButtonGreen_OnMouseDown(self, button)
	if button == "LeftButton" then
		Arh_MainFrame_ButtonGreen_OnLClick()
	elseif button == "RightButton" then
		Arh_MainFrame_ButtonGreen_OnRClick()
	end
end

function Arh_MainFrame_ButtonBack_OnLClick()
	addon:ReturnLastToCache()
	PlaySound(SOUND_BACK)
end

function Arh_MainFrame_ButtonBack_OnMouseDown(self, button)
	if button == "LeftButton" then
		Arh_MainFrame_ButtonBack_OnLClick()
	elseif button == "RightButton" then
	end
end

function addon:SaveDifs()
	local japx, japy = addon:GetPosYards()

	for _,item in ipairs(addon.ConsArray) do
		local jad = Distance(item.x, item.y, japx, japy)

		local ra = CalcAngle(item.x, item.y, japx, japy)
		local ad = ra-a
		while ad > 2*math.pi do ad = ad - 2*math.pi end
		while ad < 0 do ad = ad + 2*math.pi end
		if ad > math.pi then ad = ad - 2*math.pi end

		if Arh_Data == nil then
			Arh_Data = {["next"]=1, ["items"]={}}
		end
		Arh_Data.items[Arh_Data.next] = {[1]=item.color, [2]=jad, [3]=ad}
		Arh_Data.next = Arh_Data.next + 1
	end
end

function addon:OnGathering()
--	addon:SaveDifs()
	addon:ReturnAllToCache()
	ToggleColorButton(Arh_MainFrame_ButtonRed, ARH_RED, true)
	ToggleColorButton(Arh_MainFrame_ButtonYellow, ARH_YELLOW, true)
	ToggleColorButton(Arh_MainFrame_ButtonGreen, ARH_GREEN, true)
--	PlaySound(SOUND_GATHERING)
end


function Arh_MainFrame_ButtonDig_OnMouseDown(self, button)
	if button == "LeftButton" then
	elseif button == "RightButton" then
		addon:ToggleHUD()
	elseif button == "MiddleButton" then
		addon:ToggleArch()
	end
end

local function OnHelp()
	local function os(str1, str2)
		return cs(str1)..", "..cs(str2)
	end
	print("Arguments to "..cs("/arh")..":")
	print("  "..os("toggle","t").." - "..L["Show/Hide the Main Window"])
	print("  "..os("hud","h").." - "..L["Show/Hide the HUD"])
	print("  "..os("addred","ar").." - "..	 	L["add new %s zone to the HUD"]:format(L["red"]))
	print("  "..os("addyellow","ay").." - "..	L["add new %s zone to the HUD"]:format(L["yellow"]))
	print("  "..os("addgreen","ag").." - ".. 	L["add new %s zone to the HUD"]:format(L["green"]))
	print("  "..os("togglered","tr").." - "..	L["show/hide all %s areas on the HUD"]:format(L["red"]))
	print("  "..os("toggleyellow","ty").." - "..	L["show/hide all %s areas on the HUD"]:format(L["yellow"]))
	print("  "..os("togglegreen","tg").." - "..	L["show/hide all %s areas on the HUD"]:format(L["green"]))
	print("  "..os("back","b").." - "..L["remove one previously added area"])
	print("  "..os("clear","c").." - "..L["clear HUD"])
	print("  "..os("minimap","mm").." - "..L["show/hide digsites on minimap"])
	print("  "..os("config","co").." - "..L["Show/Hide Config"])
end

local function handler(msg, editbox)
	if msg=='' then
		OnHelp()
	elseif msg=='toggle' or msg=='t' then
		addon:ToggleMainFrame()
	elseif msg=='hud' or msg=='h' then
		addon:ToggleHUD()

	elseif msg=='addred' or msg=='ar' then
		Arh_MainFrame_ButtonRed_OnLClick()
	elseif msg=='addyellow' or msg=='ay' then
		Arh_MainFrame_ButtonYellow_OnLClick()
	elseif msg=='addgreen' or msg=='ag' then
		Arh_MainFrame_ButtonGreen_OnLClick()


	elseif msg=='togglered' or msg=='tr' then
		Arh_MainFrame_ButtonRed_OnRClick()
	elseif msg=='toggleyellow' or msg=='ty' then
		Arh_MainFrame_ButtonYellow_OnRClick()
	elseif msg=='togglegreen' or msg=='tg' then
		Arh_MainFrame_ButtonGreen_OnRClick()

	elseif msg=='back' or msg=='b' then
		Arh_MainFrame_ButtonBack_OnLClick()
	elseif msg=='clear' or msg=='c' then
		addon:ReturnAllToCache()


	elseif msg=='minimap' or msg=='mm' then
		addon:SetDigsiteTracking(not addon:GetDigsiteTracking())
	elseif msg=='config' or msg=='co' then
		addon:Config()
	else
		print("unknown command: "..msg)
		print("use |cffffff78/arh|r for help on commands")
	end
end
SlashCmdList["ARH"] = handler;
SLASH_ARH1 = "/arh"

local function OnSpellSent(unit,spellcast,rank,target)
	if unit ~= "player" then return end
	if spellcast==GetSpellInfo(73979) then -- "Searching for Artifacts"
		addon:OnGathering()
	end
end

local function OnAddonLoaded(name)
	if name=="Arh" and not addon.init then
		if not Arh_Config then
			Arh_Config = CopyByValue(Arh_DefaultConfig)
		else
			Arh_Config = GetNewestStructure(Arh_Config, Arh_DefaultConfig)
		end
		cfg = Arh_Config
		Arh_HudFrame_Init()
		Arh_MainFrame_Init()
		addon.init = true
	end
	addon:HookArchy()
end

function Arh_MainFrame_OnEvent(self, event, ...)
	if event == "ADDON_LOADED" then
		OnAddonLoaded(...)
	elseif event == "UNIT_SPELLCAST_SENT" then
		OnSpellSent(...)
	else
		addon:CheckSuppress()
	end
end

function Arh_MainFrame_OnLoad()
	Arh_MainFrame:RegisterEvent("ADDON_LOADED")
end

local function InitCancelableButton(self)
	local t = self:CreateTexture()
	t:SetPoint("CENTER", self, "CENTER", 0, 0)
	t:SetTexture("Interface\\BUTTONS\\UI-GroupLoot-Pass-Up")
	t:SetSize(20, 20)
	t:SetDrawLayer("ARTWORK", 1)
	t:Hide()
	self.CanceledTexture = t
	self.Canceled = false
end

function Arh_MainFrame_Init()
	MapData = LibStub("LibMapData-1.0")

	Config = LibStub("AceConfig-3.0")
	ConfigDialog = LibStub("AceConfigDialog-3.0")
	Config:RegisterOptionsTable("Archaeology Helper", OptionsTable, "arhcfg")
	ConfigDialog:AddToBlizOptions("Archaeology Helper", "Arh")

	LDB = LibStub:GetLibrary("LibDataBroker-1.1",true)
   	LDBo = LDB:NewDataObject(addonName, {
        	type = "launcher",
        	label = addonName,
        	icon = "Interface\\Icons\\inv_misc_shovel_01",
        	OnClick = function(self, button)
		  if button == "LeftButton" then
			addon:ToggleMainFrame()
                  elseif button == "RightButton" then
                        addon:Config()
                  else
		  	addon:ToggleArch()
                  end
         	end,
        	OnTooltipShow = function(tooltip)
                  if tooltip and tooltip.AddLine then
                        tooltip:SetText(addonName)
                        tooltip:AddLine(cs(L["Left Click"])..": "..L["Show/Hide the Main Window"])
                        tooltip:AddLine(cs(L["Right Click"])..": "..L["Show/Hide Config"])
                        tooltip:AddLine(cs(L["Middle Click"])..": "..L["Open archaeology window"])
                        tooltip:Show()
                  end
        	end,
     	})

    	minimapIcon:Register(addonName, LDBo, cfg.Minimap)
	minimapIcon:Refresh(addonName)

	SetVisible(Arh_MainFrame, cfg.MainFrame.Visible)
	Arh_MainFrame:SetScale(cfg.MainFrame.Scale)
	Arh_MainFrame:SetAlpha(cfg.MainFrame.Alpha)
	Arh_MainFrame:SetClampedToScreen(true)
	Arh_MainFrame:ClearAllPoints()
	if cfg.MainFrame.point then
		Arh_MainFrame:SetPoint(cfg.MainFrame.point, cfg.MainFrame.posX, cfg.MainFrame.posY)
	else
		Arh_MainFrame:SetPoint("CENTER")
	end

	Arh_MainFrame:RegisterEvent("UNIT_SPELLCAST_SENT")
	for _,evt in pairs({ "ZONE_CHANGED", "ZONE_CHANGED_INDOORS", "ZONE_CHANGED_NEW_AREA",
	                     "PLAYER_UPDATE_RESTING", "PLAYER_ALIVE", "PLAYER_DEAD",
			     "PET_BATTLE_OPENING_START", "PET_BATTLE_CLOSE", "PET_BATTLE_OVER",
			     "UNIT_ENTERED_VEHICLE", "UNIT_EXITED_VEHICLE",
			     "PLAYER_REGEN_DISABLED", "PLAYER_REGEN_ENABLED" }) do
		Arh_MainFrame:RegisterEvent(evt)
	end
	SetTooltips()

	if BattlefieldMinimap then
		Arh_ArchaeologyDigSites_BattlefieldMinimap:SetParent(BattlefieldMinimap)
		Arh_ArchaeologyDigSites_BattlefieldMinimap:ClearAllPoints()
		Arh_ArchaeologyDigSites_BattlefieldMinimap:SetPoint("TOPLEFT", BattlefieldMinimap)
		Arh_ArchaeologyDigSites_BattlefieldMinimap:SetPoint("BOTTOMRIGHT", BattlefieldMinimap)
		SetVisible(Arh_ArchaeologyDigSites_BattlefieldMinimap, cfg.DigSites.ShowOnBattlefieldMinimap)
	end

	InitCancelableButton(Arh_MainFrame_ButtonRed)
	InitCancelableButton(Arh_MainFrame_ButtonYellow)
	InitCancelableButton(Arh_MainFrame_ButtonGreen)
	InitCancelableButton(Arh_MainFrame_ButtonDig)

	Arh_MainFrame_ButtonDig.CanceledTexture:SetSize(30, 30)
	Arh_MainFrame_ButtonDig:SetAttribute("spell", GetSpellInfo(80451))
	addon:ToggleHUD(cfg.HUD.Visible)
	addon:CheckSuppress()

	Arh_MainFrame_ButtonRed:SetHitRectInsets(6,6,6,6)
	Arh_MainFrame_ButtonYellow:SetHitRectInsets(6,6,6,6)
	Arh_MainFrame_ButtonGreen:SetHitRectInsets(6,6,6,6)

	Arh_MainFrame_ButtonBack:SetHitRectInsets(0,0,6,6)
end

local MainFrameIsMoving = false
function Arh_MainFrame_OnMouseDown(self, button)
	if button == "LeftButton" then
		if Arh_MainFrame:IsMovable() and not cfg.MainFrame.Locked then
			Arh_MainFrame:StartMoving()
			MainFrameIsMoving = true
		end
	elseif button == "RightButton" then
		addon:Config()
	end
end

function Arh_MainFrame_OnMouseUp(self, button)
	if button == "LeftButton" then
		if MainFrameIsMoving then
			MainFrameIsMoving = false
			Arh_MainFrame:StopMovingOrSizing()
			cfg.MainFrame.point, cfg.MainFrame.posX, cfg.MainFrame.posY = select(3,Arh_MainFrame:GetPoint(1))
		end
	elseif button == "RightButton" then
	end
end

function Arh_MainFrame_OnHide()
	if MainFrameIsMoving then
		Arh_MainFrame_OnMouseUp(Arh_MainFrame, "LeftButton")
	end
end

local old_pw, old_ph = -1, -1

function Arh_ArchaeologyDigSites_OnLoad(self)
	self:SetFillAlpha(128);
	self:SetFillTexture("Interface\\WorldMap\\UI-ArchaeologyBlob-Inside");
	self:SetBorderTexture("Interface\\WorldMap\\UI-ArchaeologyBlob-Outside");
	self:EnableSmoothing(true);
	--self:SetNumSplinePoints(30);
	self:SetBorderScalar(0.1);
end

function Arh_ArchaeologyDigSites_BattlefieldMinimap_OnUpdate(self, elapsed)
	self:DrawNone()
	local numEntries = ArchaeologyMapUpdateAll()
	for i = 1, numEntries do
		local blobID = ArcheologyGetVisibleBlobID(i)
		self:DrawBlob(blobID, true)
	end
end

local UIParent_Height_old = -1
local MinimapScale_old = -1
function Arh_UpdateHudFrameSizes(force)
	local UIParent_Height = UIParent:GetHeight()

	local zoom = Minimap:GetZoom()
	--local indoors = GetCVar("minimapZoom")+0 == Minimap:GetZoom() and "outdoor" or "indoor"
	local indoors = IsIndoors() and "indoor" or "outdoor"
	local MinimapScale = minimap_scale[indoors][zoom]

	if not force then
		if UIParent_Height==UIParent_Height_old and MinimapScale==MinimapScale_old then return end
	end
	MinimapScale_old = MinimapScale
	UIParent_Height_old = UIParent_Height
	--print("Arh_UpdateHudFrameSizes")

-- HUD Frame
	Arh_HudFrame:SetScale(cfg.HUD.Scale)
	local size = UIParent_Height
	Arh_HudFrame:SetSize(size, size)

	local HudPixelsInYard = size / minimap_size[indoors][zoom]

-- Success Circle
	local success_diameter = 16 * HudPixelsInYard
	Arh_HudFrame.SuccessCircle:SetSize(success_diameter, success_diameter)

-- Compass
	local compass_radius = cfg.HUD.CompassRadius * HudPixelsInYard
	local compass_diameter = 2 * compass_radius
	Arh_HudFrame.CompassCircle:SetSize(compass_diameter, compass_diameter)
	local radius = size * (0.45/2) * MinimapScale
	for k, v in ipairs(Arh_HudFrame.CompasDirections) do
		v.radius = compass_radius
	end
end

function Arh_HudFrame_OnLoad()
end

function addon:HUD_config_update()
	Arh_HudFrame:SetParent("UIParent")
	Arh_HudFrame:ClearAllPoints()
	Arh_HudFrame:SetPoint("CENTER", (cfg.HUD.PosX or 0)*GetScreenWidth()/(cfg.HUD.Scale or 1), 
	                                (cfg.HUD.PosY or 0)*GetScreenHeight()/(cfg.HUD.Scale or 1))
	Arh_HudFrame:EnableMouse(false)
	Arh_HudFrame:SetFrameStrata("BACKGROUND")

	Arh_HudFrame:SetScale(cfg.HUD.Scale)
	Arh_HudFrame:SetAlpha(cfg.HUD.Alpha)

	-- Arrow
	SetVisible(Arh_HudFrame_ArrowFrame, cfg.HUD.ShowArrow)
	Arh_HudFrame_ArrowFrame:SetScale(cfg.HUD.ArrowScale)
	Arh_HudFrame_ArrowFrame:SetAlpha(cfg.HUD.ArrowAlpha)

	-- Success Circle
	Arh_HudFrame.SuccessCircle:SetPoint("CENTER")
	local c = cfg.HUD.SuccessCircleColor
	Arh_HudFrame.SuccessCircle:SetVertexColor(c.r,c.g,c.b,c.a)
	SetVisible(Arh_HudFrame.SuccessCircle, cfg.HUD.ShowSuccessCircle)
	
	-- Compass Circle
	Arh_HudFrame.CompassCircle:SetPoint("CENTER")
	c = cfg.HUD.CompassColor
	Arh_HudFrame.CompassCircle:SetVertexColor(c.r,c.g,c.b,c.a)
	SetVisible(Arh_HudFrame.CompassCircle, cfg.HUD.ShowCompass)
	c = cfg.HUD.CompassTextColor
	for _, ind in ipairs(Arh_HudFrame.CompasDirections) do
		SetVisible(ind, cfg.HUD.ShowCompass)
		ind:SetTextColor(c.r,c.g,c.b,c.a)
	end
end

function Arh_HudFrame_Init()
	Arh_HudFrame.GetZoom = function(...) return Minimap:GetZoom(...) end
	Arh_HudFrame.SetZoom = function(...) end

	Arh_HudFrame.SuccessCircle = Arh_HudFrame:CreateTexture()
	Arh_HudFrame.SuccessCircle:SetTexture([[SPELLS\CIRCLE.BLP]])
	Arh_HudFrame.SuccessCircle:SetBlendMode("ADD")

	Arh_HudFrame.CompassCircle = Arh_HudFrame:CreateTexture()
	Arh_HudFrame.CompassCircle:SetTexture([[SPELLS\CIRCLE.BLP]])
	Arh_HudFrame.CompassCircle:SetBlendMode("ADD")

-- Compass Text
	local directions = {}
	local indicators = {"N", "NE", "E", "SE", "S", "SW", "W", "NW"}
	for k, v in ipairs(indicators) do
		local a = ((math.pi/4) * (k-1))
		local ind = Arh_HudFrame:CreateFontString(nil, nil, "GameFontNormalSmall")
		ind:SetText(v)
		ind:SetShadowOffset(0.2,-0.2)
		ind:SetTextHeight(20)
		ind.angle = a
		tinsert(directions, ind)
	end
	Arh_HudFrame.CompasDirections = directions

	addon:HUD_config_update()
end

local arh_waiting_for_move = false
local last_player_x = 0
local last_player_y = 0
local function IsPlayerMoved(x, y, a)
	ret = false
	if arh_waiting_for_move then
		if last_player_x ~= x or last_player_y ~= y then
			print("arh: player moved")
			ret = true
		end
	end
	last_player_x = x
	last_player_y = y
	return ret
end

local last_update_hud = 0
function Arh_HudFrame_OnUpdate(frame, elapsed)
	last_update_hud = last_update_hud + elapsed
	if last_update_hud > 0.05 then

		local pa = GetPlayerFacing()
		local japx, japy = addon:GetPosYards()
		addon:UpdateCons(japx, japy, pa)

		-- if IsPlayerMoved(japx, japy, pa) then
		-- end

		Arh_UpdateHudFrameSizes()
		
		if cfg.HUD.ShowCompass then
			for k, v in ipairs(Arh_HudFrame.CompasDirections) do
				local x, y = math.sin(v.angle + pa), math.cos(v.angle + pa)
				v:ClearAllPoints()
				v:SetPoint("CENTER", Arh_HudFrame, "CENTER", x * v.radius, y * v.radius)
			end
		end

		last_update_hud = 0
	end
end

local vishooked, enablehooked
local GMonHud
local function DisableNonArchPins()
  if not GatherMate2 then return end
  local gmsettings = GatherMate2.db and GatherMate2.db.profile
  if GMonHud then
    local v = GatherMate2.Visible
    if not v then return end
    if cfg.HUD.ArchOnly then
      for i,_ in pairs(v) do
        v[i] = false
      end
    end
    v["Archaeology"] = true
    if gmsettings and not gmsettings.showMinimap then
      gmsettings.showMinimap = true -- Gm2 minimap pins must be enabled for us to use them
      gmsettings.showMinimapSuppressed = true
    end
  elseif gmsettings and gmsettings.showMinimapSuppressed then
    gmsettings.showMinimap = false -- restore the minimap setting for hud disabled
    gmsettings.showMinimapSuppressed = nil
  end
end

local OriginalRotationFlag
local function UseGatherMate2(use)
	if not GatherMate2 then return end
	local Display = GatherMate2:GetModule("Display")
	if not Display then return end
	if use and not Display:IsEnabled() or not Display.updateFrame then -- ticket 36: before Display:OnEnable()
	  if not enablehooked and Display.OnEnable then
		hooksecurefunc(Display, "OnEnable", function() UseGatherMate2(use) end)
		enablehooked = true
	  end
	  return
	end
	if not vishooked and Display.UpdateVisibility then
		hooksecurefunc(Display, "UpdateVisibility", DisableNonArchPins)
		vishooked = true
	end
	if use then
		OriginalRotationFlag = GetCVar("rotateMinimap")
		Display:ReparentMinimapPins(Arh_HudFrame)
		Display:ChangedVars(nil, "ROTATE_MINIMAP", "1")
		GMonHud = true
	else
		Display:ReparentMinimapPins(Minimap)
		Display:ChangedVars(nil, "ROTATE_MINIMAP", OriginalRotationFlag)
		GMonHud = false
	end
	if Display.UpdateMaps then
	  Display:UpdateMaps()
	end
end

function Arh_SetUseGatherMate2(use)
	if Arh_HudFrame:IsVisible() then
		if cfg.HUD.UseGatherMate2 and not use then
			UseGatherMate2(false)
		end
		if use and not cfg.HUD.UseGatherMate2 then
			UseGatherMate2(true)
		end
	end
	cfg.HUD.UseGatherMate2 = use
end


function Arh_HudFrame_OnShow(self)
	if cfg.HUD.UseGatherMate2 then
		UseGatherMate2(true)
	end
	Arh_HudFrame_OnUpdate(nil, 100) -- force an update to prevent a flicker
end
function Arh_HudFrame_OnHide(self)
	if cfg.HUD.UseGatherMate2 then
		UseGatherMate2(false)
	end
end
