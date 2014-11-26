if GetLocale() ~= "deDE" then return end

local addonName = "Altoholic"
local addon = _G[addonName]

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"

addon.FactionLeveling = {

	-- Reputation levels
	-- -42000 = "Hasserfüllt"
	-- -6000 = "Feindselig"
	-- -3000 = "Unfreundlich"
	-- 0 = "Neutral"
	-- 3000 = "Freundlich"
	-- 9000 = "Wohlwollend"
	-- 21000 = "Respektvoll"
	-- 42000 = "Ehrfürchtig"
	
	-- Outland factions: source: http://www.mmo-champion.com/
	[932] = {		-- "The Aldor"
		[0] = WHITE .. "[Schreckensgiftbeutel]|r +250 Ruf\n\n"
				.. YELLOW .. "Schreckenslauerer,\nSchreckenswitwe\n"
				.. WHITE .. "(Wälder von Terokkar)",
		[9000] = WHITE .. "[Mal von Kil'jaeden]|r\n+25 Ruf",
		[42000] = WHITE .. "[Mal des Sargeras]|r +25 Ruf pro Mal\n" 
				.. GREEN .. "[Teuflische Waffen]|r +350 Ruf (+1 Heiliger Staub)"
	},
	[934] = {		-- "The Scryers"
		[0] = WHITE .. "[Auge eines Dunstschuppenbasilisken]|r +250 Ruf\n\n"
				.. YELLOW .. "Eisenrückenversteinerer,\nDunstschuppenbeißer,\nDunstschuppenbasilisk\n"
				.. WHITE .. "(Wälder von Terokkar)",
		[9000] = WHITE .. "[Siegel der Feuerschwingen]|r\n+25 Ruf",
		[42000] = WHITE .. "[Siegel des Sonnenzorns]|r +25 Ruf pro Siegel\n" 
				.. GREEN .. "[Arkaner Foliant]|r +350 Ruf (+1 Arkane Rune)"
	},
	[1015] = {	-- "Netherwing"
		[3000] = "wiederhole diese Quests:\n\n" 
				.. YELLOW .. "Ein langsamer Tod (Daily)|r 250 Ruf\n"
				.. YELLOW.. "Netherstaubpollen (Daily)|r 250 Ruf\n"
				.. YELLOW.. "Kristalle der Netherschwingen (Daily)|r 250 Ruf\n"
				.. YELLOW.. "Ein Schatten am Horizont (Daily)\n"
				.. YELLOW.. "Die große Eierjagd (Wiederholbar)|r 250 Ruf",
		[9000] = "wiederhole diese Quests:\n\n" 
				.. YELLOW .. "Aufsehen und Ihr: Die richtige Wahl treffen|r 350 Ruf\n"
				.. YELLOW .. "Der Schuhmerang: Das Mittel gegen den wertlosen Peon (Daily)|r 350 Ruf\n"
				.. YELLOW .. "Die Dinge in den Griff bekommen... (Daily)|r 350 Ruf\n"
				.. YELLOW .. "Drachen sind unsere geringste Sorge (Daily)|r 350 Ruf\n"
				.. YELLOW .. "Verrückt und verwirrt|r 350 Ruf\n",
		[21000] = "wiederhole diese Quests:\n\n" 
				.. YELLOW .. "Unterdrückt den Unterdrücker|r 500 Ruf\n" 
				.. YELLOW .. "Schwächt das Portal des Zwielichts (Daily)|r 500 Ruf\n"
				.. YELLOW .. "Rennen Quests: 500 für die ersten 5, 1000 für das 6.\n",
		[42000] = "wiederhole diese Quest:\n\n" 
				.. YELLOW .. "Die tödlichste Falle aller Zeiten (Daily) (3er Gruppenquest)|r 500 Ruf"
	},
	[946] = {		-- "Honor Hold"
		[9000] = "\n" 
				.. YELLOW .. "Quest in Höllenfeuerhalbinsel\n"
				.. GREEN .. "Höllenfeuerbollwerk |r(Normal)\n"
				.. GREEN .. "Der Blutkessel |r(Normal)",
		[42000] = "\n" 
				.. GREEN .. "Die zerschmetterten Hallen |r(Normal & Heroisch)\n"
				.. GREEN .. "Höllenfeuerbollwerk |r(Heroisch)\n"
				.. GREEN .. "Der Blutkessel |r(Heroisch)"
	},
	[947] = {		-- "Thrallmar"
		[9000] = "\n"
				.. YELLOW .. "Quest in Höllenfeuerhalbinsel\n"
				.. GREEN .. "Höllenfeuerbollwerk |r(Normal)\n"
				.. GREEN .. "Der Blutkessel |r(Normal)",
		[42000] = "\n"
				.. GREEN .. "Die zerschmetterten Hallen |r(Normal & Heroisch)\n"
				.. GREEN .. "Höllenfeuerbollwerk |r(Heroisch)\n"
				.. GREEN .. "Der Blutkessel |r(Heroisch)"
	},
	[942] = {		-- "Cenarion Expedition"
		[3000] = "\n" 
				.. WHITE .. "Dunkelkämme & Blutschuppen Nagas (+5 Ruf)\n"
				.. YELLOW .. "Quest in Zangarmarschen\n"
				.. "|rGehe in jede " .. GREEN .. "Echsenkessel|r Instanz\n\n"
				.. WHITE .. "Bewahre [Unbekannte Pflanzenteile] auf für später",	
		[9000] = "\n" 
				.. WHITE .. "Gebe [Unbekannte Pflanzenteile] 240x ab\n"
				.. YELLOW .. "Quest in Zangarmarschen\n"
				.. "|rGehe in jede " .. GREEN .. "Echsenkessel|r Instanz",
		[42000] = "\n" 
				.. WHITE .. "Gebe [Waffen des Echsenkessels] ab (+75 Ruf)\n\n"
				.. GREEN .. "Dampfkammer |r(Normal)\n"
				.. GREEN .. "Jede Echsenkessel Instanz |r(Heroisch)"
	},
	[989] = {		-- "Keepers of Time"
		[42000] = "\n" 
				.. "|rGehe in die Instanzen " .. GREEN .. "Durnholde|r & " .. GREEN .. "Der Schwarze Morast\n\n"
				.. YELLOW .. "Behalte die Quests für später:\nDurnholde Questreihe = 5000 Ruf\nSchwarzer Morast Questreihe = 8000 Ruf"
	},
	[935] = {		-- "The Sha'tar"
		[42000] = "\n" 
				.. GREEN .. "Die Botanica |r(Normal & Heroisch)\n"
				.. GREEN .. "Die Mechanar |r(Normal & Heroisch)\n"
				.. GREEN .. "Die Arcatraz |r(Normal & Heroisch)\n"
	},	
	[1011] = {		-- "Lower City"
		[9000] = "\n" 
				.. WHITE .. "Gebe [Arrakoa Feder] 30x ab (+250 Ruf)\n"
				.. GREEN .. "Schattenlabyrinth |r(Normal)\n"
				.. GREEN .. "Auchenaikrypta |r(Normal)\n"
				.. GREEN .. "Sethekkhallen |r(Normal)",
		[42000] = "\n" 
				.. GREEN .. "Schattenlabyrinth |r(Normal & Heroisch)\n"
				.. GREEN .. "Auchenaikrypta |r(Heroisch)\n"
				.. GREEN .. "Sethekkhallen |r(Heroisch)"
	},	
	[933] = {		-- "The Consortium"
		[3000] = "\n" 
				.. "|rGebe [Kristallfragment von Oshu'gun] ab (+250 Ruf)\n"
				.. "Gebe [Paar Elfenbeinstoßzähne] ab (+250 Ruf)\n\n"
				.. GREEN .. "Managruft |r(Normal)",
		[9000] = "\n" 
				.. "|rGebe [Obsidiankriegsperlen] ab (+250 Ruf)\n\n"
				.. GREEN .. "Managruft |r(Normal)",
		[42000] = "\n" 
				.. "|rGebe [Insigne der Zaxxis] ab (+250 Ruf)\n"
				.. "|rGebe [Obsidiankriegsperlen] ab (+250 Ruf)\n\n"
				.. GREEN .. "Managruft |r(Heroisch)"
	}
}

