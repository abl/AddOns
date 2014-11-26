local Breeze, _ = ...
local addonName = "Breeze"

Breeze = CreateFrame("Frame")
Breeze:RegisterEvent("GARRISON_MISSION_COMPLETE_RESPONSE")
SetCVar("lastGarrisonMissionTutorial", 8) -- Setting tutorials as "seen" on all possible alts.

local function myDebug(text)
  --[===[@debug@
  print("|cff2476ffBreeze:|r " .. text)
  --@end-debug@]===]
end

-- setting garrison animation length to 0 
GARRISON_ANIMATION_LENGTH = 0

-- always enabling the "next" button, auto-roll the reward
GarrisonMissionFrame.MissionComplete.NextMissionButton.Disable = function() C_Garrison.MissionBonusRoll(GarrisonMissionFrame.MissionComplete.currentMission.missionID) end

local function BreezeTroughAnimation(...)

  local mc = GarrisonMissionFrame.MissionComplete
  
  if mc.currentMission then
    mc.NextMissionButton:SetText(NEXT)
    mc.Stage.EncountersFrame.FadeOut:Play()
    mc.animIndex = GarrisonMissionComplete_FindAnimIndexFor(GarrisonMissionComplete_AnimRewards) - 1
    mc.animTimeLeft = 0
    
    if ( C_Garrison.CanOpenMissionChest(mc.currentMission.missionID) ) then
      myDebug("Mission Success!")
      mc.BonusRewards.ChestModel:Hide()
      local bonusRewards = mc.BonusRewards
      bonusRewards.waitForEvent = true
      bonusRewards.waitForTimer = true
      bonusRewards.success = false
      bonusRewards:RegisterEvent("GARRISON_MISSION_BONUS_ROLL_COMPLETE")
      C_Timer.After(0.1, GarrisonMissionComplete_OnRewardTimer)
      C_Garrison.MissionBonusRoll(GarrisonMissionFrame.MissionComplete.currentMission.missionID)
      PlaySound("UI_Garrison_CommandTable_ChestUnlock_Gold_Success")
      mc.NextMissionButton:Disable()
    else
      mc.NextMissionButton:SetText("FAILED!")
      myDebug("Mission Failed")
    end
  end  
end



Breeze:SetScript("OnEvent", BreezeTroughAnimation)