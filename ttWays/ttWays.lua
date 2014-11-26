SLASH_TTWAYS1 = '/tt';

local function ttWays(msg, editbox)
  if TomTom then
    TomTom:AddZWaypoint(4, 8, 48.2, 87.0) -- Icecrown
    TomTom:AddZWaypoint(4, 8, 73.6, 64.8)
    TomTom:AddZWaypoint(4, 8, 44.2, 33.6)
    TomTom:AddZWaypoint(4, 2, 17.6, 57.0) -- Crystalsong Forest
    TomTom:AddZWaypoint(4, 2, 43.6, 44.4)
    TomTom:AddZWaypoint(4, 2, 68.2, 49.6)
    TomTom:AddZWaypoint(4, 10, 65.0, 41.8) -- Storm Peaks
    TomTom:AddZWaypoint(4, 10, 41.8, 78.8)
    TomTom:AddZWaypoint(4, 10, 29.0, 51.4)
    TomTom:AddZWaypoint(4, 12, 24.6, 64.0) -- Zul'Drak
    TomTom:AddZWaypoint(4, 12, 57.6, 39.6)
    TomTom:AddZWaypoint(4, 12, 75.2, 23.0)
    TomTom:AddZWaypoint(4, 4, 82.0, 66.0) -- Dragonblight
    TomTom:AddZWaypoint(4, 4, 65.4, 35.6)
    TomTom:AddZWaypoint(4, 4, 26.8, 54.0)
    TomTom:AddZWaypoint(4, 5, 79.6, 51.8) -- Grizzly Hills
    TomTom:AddZWaypoint(4, 5, 61.6, 18.2)
    TomTom:AddZWaypoint(4, 5, 25.8, 56.8)
    TomTom:AddZWaypoint(4, 6, 68.2, 67.6) -- Howling Fjord
    TomTom:AddZWaypoint(4, 6, 71.8, 43.0)
    TomTom:AddZWaypoint(4, 6, 45.8, 43.0)
    TomTom:AddZWaypoint(4, 1, 80.8, 48.2) -- Borean Tundra
    TomTom:AddZWaypoint(4, 1, 32.8, 60.0)
    TomTom:AddZWaypoint(4, 1, 47.6, 7.8)
    TomTom:AddZWaypoint(4, 9, 44.6, 69.8) -- Scholazar Basin
    TomTom:AddZWaypoint(4, 9, 58.6, 22.0)
    TomTom:AddZWaypoint(4, 9, 37.0, 19.6)
  end
end

SlashCmdList["TTWAYS"] = ttWays;