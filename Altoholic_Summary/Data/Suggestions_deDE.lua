local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()

if GetLocale() ~= "deDE" then return end

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"

local continents = { GetMapContinents() };		-- this gets localized names, also avoids hardcoding them.

-- This table contains a list of suggestions to get to the next level of reputation, craft or skill
addon.Suggestions = {
	
	-- source : http://forums.worldofwarcraft.com/thread.html?topicId=102789457&sid=1
	-- ** Primary professions **
	[BI["Tailoring"]] = {
		{ 50, "bis zu 50: Leinenstoffballen" },
		{ 70, "bis zu 70: Leinentasche" },
		{ 75, "bis zu 75: Verstärktes Leinencape" },
		{ 105, "bis zu 105: Wollstoffballen" },
		{ 110, "bis zu 110: Graues Wollhemd"},
		{ 125, "bis zu 125: Doppeltgenähte Wollschultern" },
		{ 145, "bis zu 145: Seidenstoffballen" },
		{ 160, "bis zu 160: Azurblaue Seidenkapuze" },
		{ 170, "bis zu 170: Seidenes Stirnband" },
		{ 175, "bis zu 175: Formelles weißes Hemd" },
		{ 185, "bis zu 185: Magiestoffballen" },
		{ 205, "bis zu 205: Purpurrote Seidenweste" },
		{ 215, "bis zu 215: Purpurrote Seidenpantalons" },
		{ 220, "bis zu 220: Schwarze Magiestoffgamaschen\noder Schwarze Magiestoffweste" },
		{ 230, "bis zu 230: Schwarze Magiestoffhandschuhe" },
		{ 250, "bis zu 250: Schwarzes Magiestoffstirnband\noder Schwarze Magiestoffschultern" },
		{ 260, "bis zu 260: Runenstoffballen" },
		{ 275, "bis zu 275: Runenstoffgürtel" },
		{ 280, "bis zu 280: Runenstofftasche" },
		{ 300, "bis zu 300: Runenstoffhandschuhe" },
		{ 325, "bis zu 325: Netherstoffballen\n|cFFFFD700Nicht verkaufen! Du brauchst sie später noch!" },
		{ 340, "bis zu 340: Magieerfüllter Netherstoffballen\n|cFFFFD700Nicht verkaufen! Du brauchst sie später noch!" },
		{ 350, "bis zu 350: Netherstoffstiefel\n|cFFFFD700Entzaubern um Arkanen Staub zu bekommen" },
		{ 360, "bis zu 360: Netherstofftunika\n|cFFFFD700Entzaubern um Arkanen Staub zu bekommen" },
		{ 375, "bis zu 375: Magieerfüllte Netherstofftunika\nStelle das Set her, auf das du dich spezialisiert hast" }
	},
	[BI["Leatherworking"]] = {
		{ 35, "bis zu 35: Leichtes Rüstungsset" },
		{ 55, "bis zu 55: Geschmeidiger leichter Balg" },
		{ 85, "bis zu 85: Geprägte Lederhandschuhe" },
		{ 100, "bis zu 100: Feiner Ledergürtel" },
		{ 120, "bis zu 120: Geschmeidiger mittlerer Balg" },
		{ 125, "bis zu 125: Feiner Ledergürtel" },
		{ 150, "bis zu 150: Dunkler Ledergürtel" },
		{ 160, "bis zu 160: Geschmeidiger schwerer Balg" },
		{ 170, "bis zu 170: Schweres Rüstungsset" },
		{ 180, "bis zu 180: Schwärzliche Ledergamaschen\noder Wächterhose" },
		{ 195, "bis zu 195: Barbarische Schultern" },
		{ 205, "bis zu 205: Schwärzliche Armschienen" },
		{ 220, "bis zu 220: Dickes Rüstungsset" },
		{ 225, "bis zu 225: Stirnband des Nachtschleichers" },
		{ 250, "bis zu 250: Kommt auf deine Spezialisierung an\nStirnband des Nachtschleichers/Tunika des Nachtschleichers/Hose des Nachtschleichers (Elementar)\nFeste Skorpidbrustplatte/Feste Skorpidhandschuhe (Drachenleder)\nSchildkrötenschuppenset (Stammesleder)" },
		{ 260, "bis zu 260: Stiefel des Nachtschleichers" },
		{ 270, "bis zu 270: Tückische Lederstulpen" },
		{ 285, "bis zu 285: Tückische Lederarmschienen" },
		{ 300, "bis zu 300: Tückisches Lederstirnband" },
		{ 310, "bis zu 310: Knotenhautleder" },
		{ 320, "bis zu 320: Wilde draenische Handschuhe" },
		{ 325, "bis zu 325: Dicke draenische Stiefel" },
		{ 335, "bis zu 335: Schweres Knotenhautleder\n|cFFFFD700Nicht verkaufen! Du brauchst es später noch!" },
		{ 340, "bis zu 340: Dicke draenische Weste" },
		{ 355, "bis zu 355: Teufelsschuppenbrustplatte" },
		{ 365, "bis zu 365: Schwere Grollhufstiefel\n|cFFFFD700Farme Grollhufleder in Nagrand" },
		{ 375, "bis zu 375: Trommeln der Schlacht\n|cFFFFD700Benötigt Die Sha'tar - Wohlwollend" }
	},
	[BI["Engineering"]] = {
		{ 40, "bis zu 40: Raues Sprengpulver" },
		{ 50, "bis zu 50: Eine Hand voll Kupferbolzen" },
		{ 51, "Stelle einen Bogenlichtschraubenschlüssel her" },
		{ 65, "bis zu 65: Kupferrohr" },
		{ 75, "bis zu 75: Raues Schießeisen" },
		{ 95, "bis zu 95: Grobes Sprengpulver" },
		{ 105, "bis zu 105: Silberkontakt" },
		{ 120, "bis zu 120: Bronzeröhre" },
		{ 125, "bis zu 125: Kleine Bronzebombe" },
		{ 145, "bis zu 145: Schweres Sprengpulver" },
		{ 150, "bis zu 150: Große Bronzebombe" },
		{ 175, "bis zu 175: Blaue, grüne oder rote Feuerwerksrakete" },
		{ 176, "Stelle einen Gyromatischer Mikroregler her" },
		{ 190, "bis zu 190: Robustes Sprengpulver" },
		{ 195, "bis zu 195: Große Eisenbombe" },
		{ 205, "bis zu 205: Mithrilrohr" },
		{ 210, "bis zu 210: Instabiler Auslöser" },
		{ 225, "bis zu 225: Stark einschlagende Mithrilpatronen" },
		{ 235, "bis zu 235: Mithrilgehäuse" },
		{ 245, "bis zu 245: Hochexplosive Bombe" },
		{ 250, "bis zu 250: Gyromithrilgeschoss" },
		{ 260, "bis zu 260: Dichtes Sprengpulver" },
		{ 290, "bis zu 290: Thoriumapparat" },
		{ 300, "bis zu 300: Thoriumröhre\noder Thoriumpatronen (günstiger)" },
		{ 310, "bis zu 310: Teufelseisengehäuse,\nEine Hand voll Teufelseisenbolzen,\n und Elementarsprengpulver\nWird später noch benötigt" },
		{ 320, "bis zu 320: Teufelseisenbombe" },
		{ 335, "bis zu 335: Teufelseisenmuskete" },
		{ 350, "bis zu 350: Weißes Rauchsignal" },
		{ 360, "bis zu 360: Khoriumkraftkern\nUm 375 zu erreichen brauchst du 20 Stück davon" },
		{ 375, "bis zu 375: Feldreparaturbot 110G" }
	},
	[BI["Jewelcrafting"]] = {
		{ 20, "bis zu 20: Feiner Kupferdraht" },
		{ 30, "bis zu 30: Raue Steinstatue" },
		{ 50, "bis zu 50: Tigeraugenband" },
		{ 75, "bis zu 75: Bronzefassung" },
		{ 80, "bis zu 80: Robuster Bronzering" },
		{ 90, "bis zu 90: Eleganter Silberring" },
		{ 110, "bis zu 110: Ring der Silbermacht" },
		{ 120, "bis zu 120: Schwere Steinstatue" },
		{ 150, "bis zu 150: Anhänger des Achatschilds\noder Goldener Drachenring" },
		{ 180, "bis zu 180: Filigranarbeit aus Mithril" },
		{ 200, "bis zu 200: Gravierter Echtsilberring" },
		{ 210, "bis zu 210: Citrinring der rapiden Heilung" },
		{ 225, "bis zu 225: Aquamarinsiegel" },
		{ 250, "bis zu 250: Thoriumfassung" },
		{ 255, "bis zu 255: Roter Ring der Zerstörung" },
		{ 265, "bis zu 265: Echtsilberring der Heilung" },
		{ 275, "bis zu 275: Einfacher Opalring" },
		{ 285, "bis zu 285: Saphirsiegel" },
		{ 290, "bis zu 290: Diamantener Fokusring" },
		{ 300, "bis zu 300: Smaragdring des Löwen" },
		{ 310, "bis zu 310: Seltene (grüne) Gems" },
		{ 315, "bis zu 315: Teufelseisenblutring\noder Seltene (grüne) Gems" },
		{ 320, "bis zu 320: Seltene (grüne) Gems" },
		{ 325, "bis zu 325: Azurmondsteinring" },
		{ 335, "bis zu 335: Quecksilberadamantit (später benötigt)\noder Seltene (grüne) Gems" },
		{ 350, "bis zu 350: Schwerer Adamantitring" },
		{ 355, "bis zu 355: Rare (blaue) Gems" },
		{ 360, "bis zu 360: World drop Rezepte wie z.B.:\nLebendiger Rubinanhänger\noder Dicke Teufelsstahlhalskette" },
		{ 365, "bis zu 365: Ring des Arkanschutzes\nBenötigt Die Sha'tar - Wohlwollend" },
		{ 375, "bis zu 375: Wandeln Sie Diamanten um\nWorld drops (blau)\nRespektvoll: Die Sha'tar, Ehrenfeste, Thrallmar" }
	},
	[BI["Enchanting"]] = {
		{ 2, "bis zu 2: Runenverzierte Kupferrute" },
		{ 75, "bis zu 75: Armschiene - Schwache Gesundheit" },
		{ 85, "bis zu 85: Armschiene - Schwache Abwehr" },
		{ 100, "bis zu 100: Armschiene - Schwache Ausdauer" },
		{ 101, "Stelle eine Runenverzierte Silberrute her" },
		{ 105, "bis zu 105: Armschiene - Schwache Ausdauer" },
		{ 120, "bis zu 120: Großer Magiezauberstab" },
		{ 130, "bis zu 130: Schild - Schwache Ausdauer" },
		{ 150, "bis zu 150: Armschiene - Geringe Ausdauer" },
		{ 151, "Stelle eine Runenverzierte Goldrute her" },
		{ 160, "bis zu 160: Armschiene - Geringe Ausdauer" },
		{ 165, "bis zu 165: Schild - Geringe Ausdauer" },
		{ 180, "bis zu 180: Armschiene - Geringe Willenskraft" },
		{ 200, "bis zu 200: Armschiene - Geringe Stärke" },
		{ 201, "Stelle eine Runenverzierte Echtsilberrute her" },
		{ 205, "bis zu 205: Armschiene - Geringe Stärke" },
		{ 225, "bis zu 225: Umhang - Große Verteidigung" },
		{ 235, "bis zu 235: Handschuhe - Beweglichkeit" },
		{ 245, "bis zu 245: Brust - Überragende Gesundheit" },
		{ 250, "bis zu 250: Armschiene - Große Stärke" },
		{ 270, "bis zu 270: Geringes Manaöl\nRezept wird verkauft in Silithus" },
		{ 290, "bis zu 290: Schild - Große Ausdauer\noder Stiefel - Große Ausdauer" },
		{ 291, "Stelle eine Runenverzierte Arkanitrute her" },
		{ 300, "bis zu 300: Umhang - Überragende Verteidigung" },
		{ 301, "Stelle eine Runenverzierte Teufelseisenrute her" },
		{ 305, "bis zu 305: Umhang - Überragende Verteidigung" },
		{ 315, "bis zu 315: Armschiene - Sturmangriff" },
		{ 325, "bis zu 325: Umhang - Erhebliche Rüstung\noder Handschuhe - Sturmangriff" },
		{ 335, "bis zu 335: Brust - Erhebliche Willenskraft" },
		{ 340, "bis zu 340: Schild - Erhebliche Ausdauer" },
		{ 345, "bis zu 345: Überragendes Zauberöl\nBis 350 herstellen wenn die Mats vorhanden sind" },
		{ 350, "bis zu 350: Handschuhe - Erhebliche Stärke" },
		{ 351, "Stelle eine Runenverzierte Adamantitrute her" },
		{ 360, "bis zu 360: Handschuhe - Erhebliche Stärke" },
		{ 370, "bis zu 370: Handschuhe - Zauberschlag\nBenötigt Respektvoll bei Expedition des Cenarius" },
		{ 375, "bis zu 375: Ring - Heilkraft\nBenötigt Respektvoll bei Die Sha'tar" }
	},
	[BI["Blacksmithing"]] = {	
		{ 25, "bis zu 25: Rauer Wetzstein" },
		{ 45, "bis zu 45: Rauer Schleifstein" },
		{ 75, "bis zu 75: Kupferner Kettengürtel" },
		{ 80, "bis zu 80: Grober Schleifstein" },
		{ 100, "bis zu 100: Runenverzierter Kupfergürtel" },
		{ 105, "bis zu 105: Silberrute" },
		{ 125, "bis zu 125: Raue bronzene Gamaschen" },
		{ 150, "bis zu 150: Schwerer Schleifstein" },
		{ 155, "bis zu 155: Goldrute" },
		{ 165, "bis zu 165: Grüne Eisengamaschen" },
		{ 185, "bis zu 185: Grüne Eisenarmschienen" },
		{ 200, "bis zu 200: Goldene Schuppenarmschienen" },
		{ 210, "bis zu 210: Robuster Schleifstein" },
		{ 215, "bis zu 215: Goldene Schuppenarmschienen" },
		{ 235, "bis zu 235: Stahlplattenhelm\noder Mithrilschuppenarmschienen (günstiger)\nRezept zu kaufen in Der Nistgipfel (A) oder Steinard (H)" },
		{ 250, "bis zu 250: Mithrilhelmkappe\noder Mithrilsporen (günstiger)" },
		{ 260, "bis zu 260: Verdichteter Wetzstein" },
		{ 270, "bis zu 270: Thoriumgürtel oder Thoriumarmschienen (günstiger)\nErdgeschmiedete Gamaschen (Rüstungsschmied)\nLeichte erdgeschmiedete Klinge (Schwertschmiedemeister)\nLeichter glutgeschmiedeter Hammer (Hammerschmiedemeister)\nLeichte himmelsgeschmiedete Axt (Axtschmiedemeister)" },
		{ 295, "bis zu 295: Imperiale Plattenarmschienen" },
		{ 300, "bis zu 300: Imperiale Plattenstiefel" },
		{ 305, "bis zu 305: Teufelsgewichtsstein" },
		{ 320, "bis zu 320: Teufelseisenplattengürtel" },
		{ 325, "bis zu 325: Teufelseisenplattenstiefel" },
		{ 330, "bis zu 330: Geringe Rune des Schutzes" },
		{ 335, "bis zu 335: Teufelseisenbrustplatte" },
		{ 340, "bis zu 340: Adamantitbeil\nZu kaufen in Shattrah, Silbermond, Exodar" },
		{ 345, "bis zu 345: Geringer Zauberschutz der Abschirmung\nZu kaufen im Schattenmondtal und Thrallmar" },
		{ 350, "bis zu 350: Adamantitbeil" },
		{ 360, "bis zu 360: Adamantitgewichtsstein\nBenötigt Expedition des Cenarius - Wohlwollend" },
		{ 370, "bis zu 370: Teufelsstahlhandschuhe (Auchenaikrypta)\nFlammenbannhandschuhe (Aldor - Wohlwollend)\nVerzauberter Adamantitgürtel (Seher - Freundlich)" },
		{ 375, "bis zu 375: Teufelsstahlhandschuhe (Auchenaikrypta)\nFlammenbannbrustplatte (Aldor - Respektvoll)\nVerzauberter Adamantitgürtel (Seher - Freundlich)" }
	},
	[BI["Alchemy"]] = {	
		{ 60, "bis zu 60: Schwacher Heiltrank" },
		{ 110, "bis zu 110: Geringer Heiltrank" },
		{ 140, "bis zu 140: Heiltrank" },
		{ 155, "bis zu 155: Geringer Manatrank" },
		{ 185, "bis zu 185: Großer Heiltrank" },
		{ 210, "bis zu 210: Elixier der Beweglichkeit" },
		{ 215, "bis zu 215: Elixier der großen Verteidigung" },
		{ 230, "bis zu 230: Überragender Heiltrank" },
		{ 250, "bis zu 250: Elixier der Untotenentdeckung" },
		{ 265, "bis zu 265: Elixier der großen Beweglichkeit" },
		{ 285, "bis zu 285: Überragender Manatrank" },
		{ 300, "bis zu 300: Erheblicher Heiltrank" },
		{ 315, "bis zu 315: Flüchtiger Heiltrank\noder Erheblicher Manatrank" },
		{ 350, "bis zu 350: Trank des verrückten Alchimisten\nWird ab 335 gelb, ist aber günstig herzustellen" },
		{ 375, "bis zu 375: Erheblicher Trank des traumlosen Schlafs\nZu kaufen in Allerias Feste (A)\noder Donnerfeste (H)" }
	},
	[L["Mining"]] = {
		{ 65, "bis zu 65: Baue Kupfer ab\nVerfügbar in allen Startgebieten" },
		{ 125, "bis zu 125: Baue Zinn, Silber, Pyrophor and geringes Blutsteinerz ab\n\nBaue Phyrophorerz in Thelgen Rock (Sumpfland)\nEinfach zu skillen bis 125" },
		{ 175, "bis zu 175: \nDesolace,Eschental, Ödland, Arathihochland,\nAlteracgebirge, Schlingendorntal, Sümpfe des Elends" },
		{ 250, "bis zu 250: Baue Mithril und Echtsilber ab\nVerwüstete Lande, Sengende Schlucht, Ödland, Hinterland,\nWestliche Pestländer, Azshara, Winterquell, Teufelswald, Steinkrallengebirge, Tanaris" },
		{ 275, "bis zu 275: Baue Thorium ab \nKrater von Un'goro, Azshara, Winterquell, Verwüstete Lande\nSengende Schlucht, Brennende Steppe, Östliche Pestländer, Westliche Pestländer" },
		{ 330, "bis zu 330: Baue Teufelseisen ab\nHöllenfeuerhalbinsel, Zangarmarschen" },
		{ 375, "bis zu 375: Baue Teufelseisen und Adamantit ab\nWälder von Terokkar, Nagrand\nEigentlich überall in der Scherbenwelt" }
	},
	[L["Herbalism"]] = {
		{ 50, "bis zu 50: Sammel Silberblatt und Friedensblume\nVerfügbar in allen Startgebieten" },
		{ 70, "bis zu 70: Sammel Maguskönigskraut and Erdwurzel\nBrachland, Westfall, Silberwald, Loch Modan" },
		{ 100, "bis zu 100: Sammel Wilddornrose\nSilberwald, Dämmerwald, Dunkelküste,\nLoch Modan, Rotkammgebirge" },
		{ 115, "bis zu 115: Sammel Beulengras\nEschental, Steinkrallengebirge, Südliches Brachland\nLoch Modan, Rotkammgebirge" },
		{ 125, "bis zu 125: Sammel Wildstahlblume\nSteinkrallengebirge, Arathihochland, Schlingendorntal\nSüdliches Brachland, Tausend Nadeln" },
		{ 160, "bis zu 160: Sammel Königsblut\nEschental, Steinkrallengebirge, Sumpfland,\nVorgebirge des Hügellands, Sümpfe des Elends" },
		{ 185, "bis zu 185: Sammel Blassblatt\nSümpfe des Elends" },
		{ 205, "bis zu 205: Sammel Khadgars Schnurrbart\nHinterland, Arathihochland, Sümpfe des Elends" },
		{ 230, "bis zu 230: Sammel Feuerblüte\nSengende Schlucht, Verwüstete Lande, Tanaris" },
		{ 250, "bis zu 250: Sammel Sonnengras\nTeufelswald, Feralas, Azshara\nHinterland" },
		{ 270, "bis zu 270: Sammel Gromsblut\nTeufelswald, Verwüstete Lande,\nMannoroc Coven in Desolace" },
		{ 285, "bis zu 285: Sammel Traumblatt\nKrater von Un'Goro, Azshara" },
		{ 300, "bis zu 300: Sammel Pestblüte\nÖstliche & Westliche Pestländer, Teufelswald\noder Eiskappen in Winterquell" },
		{ 330, "bis zu 330: Sammel Teufelsgras\nHöllenfeuerhalbinsel, Zangarmarschen" },
		{ 375, "bis zu 375: Alles was in der Scherenwelt verfügbar ist aufsammeln\nBesonders in Zangarmarschen & Wälder von Terokkar" }
	},
	[L["Skinning"]] = {
		{ 375, "bis zu 375: Teilen Sie Ihr gegenwärtiges Fähigkeitsniveau durch 5\nund kürschnern sie Mobs mit diesem Level" }
	},
	-- source: http://www.almostgaming.com/wowguides/world-of-warcraft-lockpicking-guide
	[L["Lockpicking"]] = {
		{ 85, "bis zu 85: Thieves Training\nAtler Mill, Rotkammgebirge (A)\nSchiff in der Nähe von Ratchet (H)" },
		{ 150, "bis zu 150: Kasten in der Nähe vom Boss der Gift Quest\nWestfall (A) or Brachland (H)" },
		{ 185, "bis zu 185: Murloc Camps (Sumpfland)" },
		{ 225, "bis zu 225: Sar'Theris Strand (Desolace)\n" },
		{ 250, "bis zu 250: Angor Fortress (Ödland)" },
		{ 275, "bis zu 275: Slag Pit (Sengende Schlucht)" },
		{ 300, "bis zu 300: Lost Rigger Cove (Tanaris)\nBay of Storms (Azshara)" },
		{ 325, "bis zu 325: Feralfen Village (Zangarmarschen)" },
		{ 350, "bis zu 350: Kil'sorrow Fortress (Nagrand)\nWende Taschendiebstahl an den Felsfäuste in Nagrand an" }
	},
	
	-- ** Secondary professions **
	[BI["First Aid"]] = {
		{ 40, "bis zu 40: Leinenverbände" },
		{ 80, "bis zu 80: Schwerer Leinenverband\nWerde Geselle mit 50" },
		{ 115, "bis zu 115: Wollverband" },
		{ 150, "bis zu 150: Schwerer Wollverband\nHol dir das Erste Hilfe Buch mit 125\nKaufe die 2 Rezepte in Stromgarde (A) or Brackenwall (H)" },
		{ 180, "bis zu 180: Seidenverband" },
		{ 210, "bis zu 210: Schwerer Seidenverband" },
		{ 240, "bis zu 240: Magiestoffverband\nErste Hilfe Quest mit level 35 in\nTheramore (A) oder Hammerfall (H)" },
		{ 260, "bis zu 260: Schwerer Magiestoffverband" },
		{ 290, "bis zu 290: Runenstoffverband" },
		{ 330, "bis zu 330: Schwerer Runenstoffverband\nKaufe das Erste Hilfe Buch für Meister\nTempel von Telhamat (A) oder Falkenwacht (H)" },
		{ 360, "bis zu 360: Netherstoffverband\nKaufe das Buch im Tempel von Telhamat (A) oder in der Falkenwacht (H)" },
		{ 375, "bis zu 375: Schwerer Netherstoffverband\nKaufe das Buch im Tempel von Telhamat (A) oder in der Falkenwacht (H)" }
	},
	[BI["Cooking"]] = {
		{ 40, "bis zu 40: Gewürzbrot"	},
		{ 85, "bis zu 85: Geräuchertes Bärenfleisch, Krebsküchlein" },
		{ 100, "bis zu 100: Gekochte Krebsschere (A)\nGrubenratteneintopf (H)" },
		{ 125, "bis zu 125: Grubenratteneintopf (H)\nGewürzter Wolfskebab (A)" },
		{ 175, "bis zu 175: Seltsam schmeckendes Omelett (A)\nScharfe Löwenkoteletts (H)" },
		{ 200, "bis zu 200: Gerösteter Raptor" },
		{ 225, "bis zu 225: Spinnenwurst\n\n|cFFFFFFFFKoch Quest:\n|cFFFFD70012 Rieseneier,\n10 Scharfes Muschelfleisch,\n20 Alteraclochkäse " },
		{ 275, "bis zu 275: Monsteromelett\noder Zartes Wolfsteak" },
		{ 285, "bis zu 285: Runn Tum Knolle Surprise\nDüsterbruch (Pusillin)" },
		{ 300, "bis zu 300: Geräucherte Wüstenknödel\nQuest in Silithus" },
		{ 325, "bis zu 325: Heißer Hetzer, Bussardbissen" },
		{ 350, "bis zu 350: Gerösteter Grollhuf\nDoppelwarper, Talbuksteak" },
		{ 375, "bis zu 375: Knusperschlange\nLeckerbissen der Mok'Nathal" }
	},	
	-- source: http://www.wowguideonline.com/fishing.html
	[BI["Fishing"]] = {
		{ 50, "bis zu 50: Jedes Startgebiet" },
		{ 75, "bis zu 75:\nDie Kanäle in Sturmwind\nDer Teich in Orgrimmar" },
		{ 150, "bis zu 150: Vorgebirge des Hügellands' Fluss" },
		{ 225, "bis zu 225: Expertenangelbuch wird in Beutebuch verkauft\nAngel in Desolace oder Arathihochland" },
		{ 250, "bis zu 250: Hinterland, Tanaris\n\n|cFFFFFFFFAngelquest in Düstermarschen\n|cFFFFD700Blauwimpel von der ungezähmten Küste (Schlingendorntal)\nFeralas Ahi (Verdantis Fluss, Feralas)\nSar'therisbarsch (Nördlicher Sartheris Strand, Desolace)\nNebelschilf-Mahi-Mahi (Sümpfe des Elends Küste)" },
		{ 260, "bis zu 260: Teufelswald" },
		{ 300, "bis zu 300: Azshara" },
		{ 330, "bis zu 330: Angel in den östlichen Zangarmarschen\nDas Fachmann Anglerbuch gibt es in der Expedition des Cenarius " },
		{ 345, "bis zu 345: Westliche Zangarmarschen" },
		{ 360, "bis zu 360: Wälder von Terokkar" },
		{ 375, "bis zu 375: Wälder von Terokkar, in der Hochebene\nFlugmount benötigt" }
	},
	
	[BI["Archaeology"]] = {
		{ 300, "bis zu 300: " .. continents[1] .. "\n" .. continents[2]},
		{ 375, "bis zu 375: " .. continents[3]},
		{ 450, "bis zu 450: " .. continents[4]},
		{ 525, "bis zu 525: " .. GetMapNameByID(606) .. "\n" .. GetMapNameByID(720) .. "\n" .. GetMapNameByID(700)},
		{ 600, "bis zu 600: " .. continents[6]},
	},

	-- suggested leveling zones, as defined by recommended quest levels. map id's : http://wowpedia.org/MapID
	["Leveling"] = {
		{ 10, "bis Level 10: Jedes Startgebiet" },
		{ 15, "bis Level 15: " .. GetMapNameByID(39)},
		{ 16, "bis Level 16: " .. GetMapNameByID(684)},
		{ 20, "bis Level 20: " .. GetMapNameByID(181) .. "\n" .. GetMapNameByID(35) .. "\n" .. GetMapNameByID(476)
							.. "\n" .. GetMapNameByID(42) .. "\n" .. GetMapNameByID(21) .. "\n" .. GetMapNameByID(11)
							.. "\n" .. GetMapNameByID(463) .. "\n" .. GetMapNameByID(36)},
		{ 25, "bis Level 25: " .. GetMapNameByID(34) .. "\n" .. GetMapNameByID(40) .. "\n" .. GetMapNameByID(43) 
							.. "\n" .. GetMapNameByID(24)},
		{ 30, "bis Level 30: " .. GetMapNameByID(16) .. "\n" .. GetMapNameByID(37) .. "\n" .. GetMapNameByID(81)},
		{ 35, "bis Level 35: " .. GetMapNameByID(673) .. "\n" .. GetMapNameByID(101) .. "\n" .. GetMapNameByID(26)
							.. "\n" .. GetMapNameByID(607)},
		{ 40, "bis Level 40: " .. GetMapNameByID(141) .. "\n" .. GetMapNameByID(121) .. "\n" .. GetMapNameByID(22)},
		{ 45, "bis Level 45: " .. GetMapNameByID(23) .. "\n" .. GetMapNameByID(61)},
		{ 48, "bis Level 48: " .. GetMapNameByID(17)},
		{ 50, "bis Level 50: " .. GetMapNameByID(161) .. "\n" .. GetMapNameByID(182) .. "\n" .. GetMapNameByID(28)},
		{ 52, "bis Level 52: " .. GetMapNameByID(29)},
		{ 54, "bis Level 54: " .. GetMapNameByID(38)},
		{ 55, "bis Level 55: " .. GetMapNameByID(201) .. "\n" .. GetMapNameByID(281)},
		{ 58, "bis Level 58: " .. GetMapNameByID(19)},
		{ 60, "bis Level 60: " .. GetMapNameByID(32) .. "\n" .. GetMapNameByID(241) .. "\n" .. GetMapNameByID(261)},
		
		-- Outland
		-- 465 Hellfire Peninsula 
		-- 467 Zangarmarsh 
		-- 478 Terokkar Forest 
		-- 477 Nagrand 
		-- 475 Blade's Edge Mountains 
		-- 479 Netherstorm 
		-- 473 Shadowmoon Valley 
		
		{ 63, "bis Level 63: " .. GetMapNameByID(465)},
		{ 64, "bis Level 64: " .. GetMapNameByID(467)},
		{ 65, "bis Level 65: " .. GetMapNameByID(478)},
		{ 67, "bis Level 67: " .. GetMapNameByID(477)},
		{ 68, "bis Level 68: " .. GetMapNameByID(475)},
		{ 70, "bis Level 70: " .. GetMapNameByID(479) .. "\n" .. GetMapNameByID(473) .. "\n" .. GetMapNameByID(499) .. "\n" .. GetMapNameByID(32)},

		-- Northrend
		-- 491 Howling Fjord 
		-- 486 Borean Tundra 
		-- 488 Dragonblight 
		-- 490 Grizzly Hills 
		-- 496 Zul'Drak 
		-- 493 Sholazar Basin 
		-- 510 Crystalsong Forest 
		-- 495 The Storm Peaks 
		-- 492 Icecrown 
		
		{ 72, "bis Level 72: " .. GetMapNameByID(491) .. "\n" .. GetMapNameByID(486)},
		{ 75, "bis Level 75: " .. GetMapNameByID(488) .. "\n" .. GetMapNameByID(490)},
		{ 76, "bis Level 76: " .. GetMapNameByID(496)},
		{ 78, "bis Level 78: " .. GetMapNameByID(493)},
		{ 80, "bis Level 80: " .. GetMapNameByID(510) .. "\n" .. GetMapNameByID(495) .. "\n" .. GetMapNameByID(492)},
		
		-- Cataclysm
		-- 606 Mount Hyjal 
		-- 613 Vashj'ir 
		-- 640 Deepholm 
		-- 720 Uldum 
		-- 700 Twilight Highlands 
		
		{ 82, "bis Level 82: " .. GetMapNameByID(606) .. "\n" .. GetMapNameByID(613)},
		{ 83, "bis Level 83: " .. GetMapNameByID(640)},
		{ 84, "bis Level 84: " .. GetMapNameByID(720)},
		{ 85, "bis Level 85: " .. GetMapNameByID(700)},

		-- Pandaria
		-- 806 The Jade Forest 
		-- 807 Valley of the Four Winds 
		-- 857 Krasarang Wilds 
		-- 809 Kun-Lai Summit 
		-- 810 Townlong Steppes 
		-- 858 Dread Wastes 
		
		{ 86, "bis Level 86: " .. GetMapNameByID(806)},
		{ 87, "bis Level 87: " .. GetMapNameByID(807) .. "\n" .. GetMapNameByID(857)},
		{ 88, "bis Level 88: " .. GetMapNameByID(809)},
		{ 89, "bis Level 89: " .. GetMapNameByID(810)},
		{ 90, "bis Level 90: " .. GetMapNameByID(858)},
	},
}

