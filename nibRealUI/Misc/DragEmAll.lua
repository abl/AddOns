-- Original code from DragEmAll by Emelio
-- http://www.wowace.com/addons/drag-em-all/

local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local LSM = LibStub("LibSharedMedia-3.0")

local MODNAME = "DragEmAll"
local DragEmAll = nibRealUI:NewModule(MODNAME, "AceEvent-3.0")

-- Based on the frame list from NDragIt by Nemes.
-- These frames are hooked on login.
local frames = {
	-- ["FrameName"] = true/false (the parent / the frame itself) or another frame

	-- Blizzard Frames
	["AddonList"] = false,
	["AudioOptionsFrame"] = false,
	["BankFrame"] = false,
	["DressUpFrame"] = false,
	["EncounterJournal"] = false, -- only in 4.2
	["FriendsFrame"] = false,
	["GameMenuFrame"] = false,
	--["GhostFrame"] = false,
	["GossipFrame"] = false,
	["GuildInviteFrame"] = false,
	["GuildRegistrarFrame"] = false,
	["HelpFrame"] = false,
	["InterfaceOptionsFrame"] = false,
	["ItemTextFrame"] = false,
	["LootFrame"] = false,
	["MacOptionsFrame"] = false,
	["MailFrame"] = false,
	["MerchantFrame"] = false,
	["MissingLootFrame"] = false,
	["OpenMailFrame"] = false,
	["PaperDollFrame"] = true,
	["PetitionFrame"] = false,
	["PetPaperDollFrame"] = true,
	["PetStableFrame"] = false,
	["PVEFrame"] = false, -- dungeon finder + PvP + challenges
	["QuestFrame"] = false,
	["QuestLogPopupDetailFrame"] = false,
	["PetPaperDollFrameCompanionFrame"] = "CharacterFrame",
	["RaidParentFrame"] = false,
	--["ReputationFrame"] = true,
	["ScrollOfResurrectionSelectionFrame"] = false,
	["SendMailFrame"] = true,
	["SpellBookFrame"] = false,
	["StaticPopup1"] = false,
	["StackSplitFrame"] = false,
	["TabardFrame"] = false,
	["TaxiFrame"] = false,
	--["TicketStatusFrame"] = false,
	["TokenFrame"] = true,
	--["TokenFrameContainer"] = "TokenFrame",
	["TradeFrame"] = false,
	["TutorialFrame"] = false,
	["VideoOptionsFrame"] = false,
	["WorldMapFrame"] = false,
	["WorldMapFrame.BorderFrame"] = true,
	--["WorldMapPositioningGuide"] = true,
	["WorldStateScoreFrame"] = false,
}

-- Frames provided by load on demand addons, hooked when the addon is loaded.
local lodFrames = {
	-- AddonName = { list of frames, same syntax as above }
	Blizzard_AchievementUI = { ["AchievementFrame"] = false, ["AchievementFrameHeader"] = true, ["AchievementFrameCategoriesContainer"] = "AchievementFrame" },
	Blizzard_ArchaeologyUI = { ["ArchaeologyFrame"] = false },
	--Blizzard_ArenaUI
	Blizzard_AuctionUI = { ["AuctionFrame"] = false },
	Blizzard_BarbershopUI = { ["BarberShopFrame"] = false },
	Blizzard_BindingUI = { ["KeyBindingFrame"] = false },
	Blizzard_BlackMarketUI = { ["BlackMarketFrame"] = false },
	Blizzard_Calendar = { ["CalendarFrame"] = false, ["CalendarCreateEventFrame"] = true },
	Blizzard_ChallengesUI = { ["ChallengesLeaderboardFrame"] = false },
	Blizzard_CraftUI = { ["CraftFrame"] = false },
	Blizzard_EncounterJournal = { ["EncounterJournal"] = false },
	Blizzard_GarrisonUI = { ["GarrisonLandingPage"] = false, ["GarrisonBuildingFrame"] = false, ["GarrisonMissionFrame"] = false },
	--Blizzard_GlyphUI = { ["GlyphFrame"] = true },
	Blizzard_GMSurveyUI = { ["GMSurveyFrame"] = false },
	Blizzard_GuildBankUI = { ["GuildBankFrame"] = false, ["GuildBankEmblemFrame"] = true },
	--Blizzard_GuildControlUI
	Blizzard_GuildUI = { ["GuildFrame"] = false, ["GuildRosterFrame"] = true, ["GuildFrame.TitleMouseover"] = true },
	Blizzard_InspectUI = { ["InspectFrame"] = false, ["InspectPVPFrame"] = true, ["InspectTalentFrame"] = true },
	Blizzard_ItemAlterationUI = { ["TransmogrifyFrame"] = false },
	Blizzard_ItemSocketingUI = { ["ItemSocketingFrame"] = false },
	Blizzard_ItemUpgradeUI = { ["ItemUpgradeFrame"] = false, },
	Blizzard_LookingForGuildUI = { ["LookingForGuildFrame"] = false },
	Blizzard_MacroUI = { ["MacroFrame"] = false },
	--Blizzard_ObjectiveTracker
	Blizzard_PetJournal = { ["PetJournalParent"] = false },
	--Blizzard_PVPUI
	Blizzard_QuestChoice = { ["QuestChoiceFrame"] = false },
	Blizzard_TalentUI = { ["PlayerTalentFrame"] = false },
	Blizzard_TimeManager = { ["TimeManagerFrame"] = false },
	--Blizzard_TokenUI = { ["TokenFrame"] = true },
	Blizzard_TradeSkillUI = { ["TradeSkillFrame"] = false },
	Blizzard_TrainerUI = { ["ClassTrainerFrame"] = false },
	Blizzard_VoidStorageUI = { ["VoidStorageFrame"] = false, ["VoidStorageBorderFrameMouseBlockFrame"] = "VoidStorageFrame" },
}

local parentFrame = {}
local hooked = {}

local function MouseDownHandler(frame, button)
	frame = parentFrame[frame] or frame
	if frame and button == "LeftButton" then
		frame:StartMoving()
		frame:SetUserPlaced(false)
	end
end

local function MouseUpHandler(frame, button)
	frame = parentFrame[frame] or frame
	if frame and button == "LeftButton" then
		frame:StopMovingOrSizing()
	end
end

function DragEmAll:HookFrames(list)
	for name, child in pairs(list) do
		self:HookFrame(name, child)
	end
end

function DragEmAll:HookFrame(name, moveParent)
	local frame = _G
	local s
	for s in string.gmatch(name, "%w+") do
		if frame then
			frame = frame[s]
		end
	end
	-- check if frame was found
	if frame == _G then
		frame = nil
	end
	
	local parent
	if frame and not hooked[name] then
		if moveParent then
			if type(moveParent) == "string" then
				parent = _G[moveParent]
			else
				parent = frame:GetParent()
			end
			if not parent then
				return
			end
			parentFrame[frame] = parent
		end
		if parent then
			parent:SetMovable(true)
			parent:SetClampedToScreen(false)
		end
		frame:EnableMouse(true)
		frame:SetMovable(true)
		frame:SetClampedToScreen(false)
		nibRealUI:HookScript(frame, "OnMouseDown", MouseDownHandler)
		nibRealUI:HookScript(frame, "OnMouseUp", MouseUpHandler)
		hooked[name] = true
	end
end

function DragEmAll:ADDON_LOADED(event, name)
	local frameList = lodFrames[name]
	if frameList then
		self:HookFrames(frameList)
	end
end

function DragEmAll:PLAYER_LOGIN()
	self:HookFrames(frames)
end

--------------------
-- Initialization --
--------------------
function DragEmAll:OnInitialize()
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
end

function DragEmAll:OnEnable()
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("ADDON_LOADED")
end
