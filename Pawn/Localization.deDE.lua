-- Pawn by Vger-Azjol-Nerub
-- www.vgermods.com
-- © 2006-2014 Green Eclipse.  This mod is released under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 license.
-- See Readme.htm for more information.

-- 
-- German resources
------------------------------------------------------------

local function PawnUseThisLocalization()
PawnLocal =
{
	AsteriskTooltipLine = "|TInterface\\AddOns\\Pawn\\Textures\\Question:0|t Pawn hat für einige Attribute keine Wertung vergeben.",
	AverageItemLevelIgnoringRarityTooltipLine = "Durchschnittliches Itemlevel",
	BackupCommand = "Backup",
	BaseValueWord = "Basis",
	CogwheelName = "Zahnrad",
	CopyScaleEnterName = "Gib einen Wertungsnamen für die Kopie von %s ein:",
	CorrectGemsValueCalculationMessage = "  -- Wert der passenden Edelsteine: %g",
	CrystalOfFearName = "Kristallisierter Horror",
	DebugOffCommand = "Debug-Modus aus",
	DebugOnCommand = "Debug-Modus an",
	DeleteScaleConfirmation = "Willst du die Wertung %s wirklich löschen? Dieser Vorgang kann nicht rückgängig gemacht werden. Gib \"%s\" zur Bestätigung ein:",
	DidntUnderstandMessage = "   (?) Habe \"%s\" nicht verstanden.",
	EnchantedStatsHeader = "(Verzaubert)",
	EngineeringName = "Ingenieurskunst",
	ExportAllScalesMessage = "Drücke Strg+C um Wertungs-Tags zu kopieren, erstelle eine Datei auf deinem PC und sichere diese Werte als Backup, drücke dann Strg+V um die Werte einzufügen.",
	ExportScaleMessage = "Drücke Strg+C um die Wertung |cffffffff%s|r, zu kopieren und später mit Strg+V an anderer Stelle einzufügen.",
	FailedToGetItemLinkMessage = "   Konnte keine Gegenstandsinformationen aus dem Tooltip beziehen.  Dies kann an einem Mod-Konflikt liegen.",
	FailedToGetUnenchantedItemMessage = "   Konnte keine Unverzaubert-Werte beziehen.  Dies kann an einem Mod-Konflikt liegen.",
	FoundStatMessage = "   %d %s",
	GemColorList1 = "%d %s",
	GemColorList2 = "%d %s oder %s",
	GemColorList3 = "%d in beliebiger Farbe",
	GenericGemLink = "|Hitem:%d|h[Edelstein %d]|h",
	GenericGemName = "(Edelstein %d)",
	HiddenScalesHeader = "Andere Wertungen",
	ImportScaleMessage = "Drücke Strg+V um eine Wertung von einer anderen Quelle einzufügen:",
	ImportScaleTagErrorMessage = "Pawn versteht dieses Wertungstag nicht.  Hast du das ganze Tag kopiert?  Versuche es erneut:",
	ItemIDTooltipLine = "Item-ID",
	ItemLevelTooltipLine = "Itemlevel",
	LootUpgradeAdvisorHeader = "Klicken um mit deinem aktuellen Gegenstand zu vergleichen.|n",
	LootUpgradeAdvisorHeaderMany = "|TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t Dieser Gegenstand verbessert deine Wertung um %d.  Klicken um mit deinem aktuellen Gegenstand zu vergleichen.",
	MissocketWorthwhileMessage = "   -- Aber es ist besser nur %s Edelsteine zu verwenden:",
	NeedNewerVgerCoreMessage = "Pawn benötigt eine neuere Version von VgerCore.  Bitte benutze die Version von VgerCore, die mit Pawn heruntergeladen wurde.",
	NewScaleDuplicateName = "Es existiert bereits eine Wertung mit diesem Namen.  Gib einen gültigen Wertungsnamen ein:",
	NewScaleEnterName = "Gib einen Namen für die Wertung ein:",
	NewScaleNoQuotes = "Ein Wertungsname darf keine Anführungszeichen (\") enthalten.  Gib einen gültigen Wertungsnamen ein:",
	NormalizationMessage = "   ---- Normalisiert durch Teilen durch %g",
	NoScale = "(keine)",
	NoScalesDescription = "Um zu beginnen erstelle oder importiere eine neue Wertung.",
	NoStatDescription = "Wähle ein Attribut aus der Liste um ihm einen Wert zu geben.",
	Or = "oder ",
	RenameScaleEnterName = "Gib einen neuen Namen für %s ein:",
	SocketBonusValueCalculationMessage = "   -- Wert des Sockelbonus: %g",
	StatNameText = "1 |cffffffff%s|r entspricht:",
	TooltipBestAnnotation = "%s  |cff8ec3e6(bester)|r",
	TooltipBestAnnotationSimple = "%s  (bester)",
	TooltipBigUpgradeAnnotation = "%s  |TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t|cff00ff00 Verbesserung%s|r",
	TooltipSecondBestAnnotation = "%s  |cff8ec3e6(zweitbester)|r",
	TooltipSecondBestAnnotationSimple = "%s  (zweitbester)",
	TooltipUpgradeAnnotation = "%s  |TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t|cff00ff00+%.0f%% Verbesserung%s|r",
	TooltipUpgradeFor1H = " für 1Hand",
	TooltipUpgradeFor2H = " für 2Hand",
	TooltipVersusLine = "%s|n  vs. |c%s%s|r",
	TotalValueMessage = "   ---- Gesamt: %g",
	UnenchantedStatsHeader = "(Unverzaubert)",
	Unusable = "(unbenutzbar)",
	UnusableStatMessage = "   -- %s ist unbenutzbar, keine Berechnung.",
	Usage = [=[Pawn by Vger-Azjol-Nerub
www.vgermods.com
 
/pawn -- Pawn anzeigen oder verstecken
/pawn debug [ on | off ] -- Debug Infos in der Konsole anzeigen
/pawn backup -- alle Bewertungsprofile sichern
 
Weitere Informationen zur Anpassung von Pawn findet ihr in der Hilfedatei (Readme.htm) die mit dieser Installation ausgeliefert wird.]=],
	ValueCalculationMessage = "   %g %s x %g pro = %g",
	VisibleScalesHeader = "%s's Wertungen",
	Stats = {
		AgilityInfo = "Primäre Wertung: Beweglichkeit.", -- Needs review
		Ap = "Angriffskraft",
		ApInfo = "Angriffskraft.  Auf den meisten Gegenständen nicht enthalten. Beinhaltet nicht die aus Stärke und Beweglichkeit erhaltene Angriffskraft.",
		ArmorInfo = "Rüstung unabhängig vom Gegenstandstyp.  Berücksichtigt keine Bonusrüstung, da Gegenstände mit Bonusrüstung obsolet sind.", -- Needs review
		ArmorTypes = "Waffenarten",
		AvoidanceInfo = "Zahigkelt.  Reduziert den Schaden nehmen Sie aus des Wirkungsbereichs Angriffe.", -- Needs review
		BonusArmorInfo = "Bonus armor.  Does not include the base armor value on all armor.  This number should always be at least as high as the value for Armor.", -- Requires localization
		Cloth = "Stoff",
		ClothInfo = "Für einen Stoffrüstungsgegenstand zugeteilte Punkte.",
		Crit = "Krit",
		CritInfo = "Kritische Trefferwertung.  Betrifft Nah-, Fernkampfangriffe und Zauber.", -- Needs review
		DpsInfo = "Waffenschaden pro Sekunde.  (Wenn du den DPS-Wert für Waffengattungen unterschiedlich definieren willst, scrolle runter zum Bereich \"Spezielle Waffenwertungen\"",
		HasteInfo = "Tempo.  Betrifft Nah-, Fernkampfangriffe und Zauber.", -- Needs review
		IndestructibleInfo = "Spalten.  Verhindert, dass Ihre Geräte von Haltbarkeit Schaden nehmen.", -- Needs review
		IndestructibleIs = "|cffffffffspalten|r sein lohnt sich:", -- Needs review
		IntellectInfo = "Primäre Wertung: Intelligenz.", -- Needs review
		Leather = "Leder",
		LeatherInfo = "Für einen Lederrüstungsgegenstand zugeteilte Punkte.",
		LeechInfo = "Vermeidung.  Bewirkt, dass Ihre Angriffe und Heilzauber um Ihre Gesundheit wiederherzustellen.", -- Needs review
		Mail = "Kette",
		MailInfo = "Für einen Kettenrüstungsgegenstand zugeteilte Punkte.",
		MasteryInfo = "Meisterschaftswertung.  Verbessert den Meisterschaftsbonus des primären Talentbaums.",
		MetaSocket = "Meta-Sockel",
		MetaSocketInfo = "Ein Metasockel, weder leer noch voll. Addiert Extrapunkte für Helme die einen Meta-Sockel besitzen um die speziellen Effekte von Meta-Edelsteinen zu kompensieren.",
		MinorStats = "Kleinere", -- Needs review
		MovementSpeedInfo = "Bewegungsgeschwindigkeit. Bewirkt, dass euer Charakter schneller ausgeführt.", -- Needs review
		MultistrikeInfo = "Bereitschaft. Erhöht die Chance, dass Ihre Angriffe und Heilzauber Ihr Ziel extra zweimal bei reduzierter Wirksamkeit getroffen werden.", -- Needs review
		Plate = "Platte",
		PlateInfo = "Für einen Plattenrüstungsgegenstand zugeteilte Punkte.",
		PrimaryStats = "Basiswerte",
		PvPPower = "PvP-Macht",
		PvPPowerInfo = "PvP Macht. Erhöht die Fähigkeit um bei anderen Spielern (keine NPCs) in bestimmten PvP Situationen mehr Schaden oder Heilung zu verursachen.",
		PvPResilience = "PvP-Abhärtung",
		PvPResilienceInfo = "Abhärtungswertung. Reduziert den Schaden durch andere Spieler. Nur wirksam gegen andere Spieler.",
		PvPStats = "PvP Wertungen",
		SecondaryStats = "Sekundäre", -- Needs review
		Shield = "Schild",
		ShieldInfo = "Für einen Schild zugeteilte Punkte.",
		Sockets = "Sockel",
		SpecialWeaponStats = "Spezielle Waffenwertungen",
		SpeedBaseline = "Tempogrundwert",
		SpeedBaselineInfo = "Keine wirkliche Wertung.  Dieser Wert wird vom Tempowert abgezogen, bevor er mit der Wertung multipliziert wird.", -- Needs review
		SpeedBaselineIs = "|cffffffffTempogrundwert|r is:",
		SpeedInfo = "Waffenschaden pro Sekunde.  (Wenn du schnelle Waffen bevorzugst, dann sollte diese Nummer negativ sein. Siehe auch \"Tempogrundwert\" im Bereich \"Spezielle Waffenwertungen\".)",
		SpeedIs = "1 Sekunde |cffffffffWaffentempo|r entspricht:",
		SpellPower = "Zaubermacht",
		SpellPowerInfo = "Zaubermacht. Auf Caster-Waffen enthalten, jedoch nicht auf den meisten Rüstungen. Beinhaltet nicht die aus Intelligenz erhaltene Zaubermacht.", -- Needs review
		SpiritInfo = "Primäre Wertung: Willenskraft.", -- Needs review
		StaminaInfo = "Primäre Wertung: Ausdauer.", -- Needs review
		StrengthInfo = "Primäre Wertung: Stärke.", -- Needs review
		VersatilityInfo = "Verstarkung. Erhöht den Schaden von Schaden-Zeichen behandelt, erhöht Heilung um Heilung Zeichen und verringert den erlittenen für Tank-Zeichen.", -- Needs review
		WeaponMainHandDps = "Waffenhand: DPS",
		WeaponMainHandDpsInfo = "Waffenschaden pro Sekunde, nur für Waffenhandwaffen.",
		WeaponMainHandMaxDamage = "Waffenhand: max. Schaden",
		WeaponMainHandMaxDamageInfo = "Maximaler Waffenschaden, nur für Waffenhandwaffen.",
		WeaponMainHandMinDamage = "Waffenhand: min. Schaden",
		WeaponMainHandMinDamageInfo = "Minimaler Waffenschaden, nur für Waffenhandwaffen.",
		WeaponMainHandSpeed = "Waffenhand: DPS",
		WeaponMainHandSpeedInfo = "Waffenschaden pro Sekunde, nur für Waffenhandwaffen.",
		WeaponMaxDamage = "Max. Schaden",
		WeaponMaxDamageInfo = "Maximaler Waffenschaden",
		WeaponMeleeDps = "Nahkampf: DPS",
		WeaponMeleeDpsInfo = "Waffenschaden pro Sekunde, nur für Nahkampfwaffen.",
		WeaponMeleeMaxDamage = "Nahkampf: max. Schaden",
		WeaponMeleeMaxDamageInfo = "Maximaler Waffenschaden, nur für Nahkampfwaffen.",
		WeaponMeleeMinDamage = "Nahkampf: min. Schaden",
		WeaponMeleeMinDamageInfo = "Minimaler Waffenschaden, nur für Nahkampfwaffen.",
		WeaponMeleeSpeed = "Nahkampf: Tempo",
		WeaponMeleeSpeedInfo = "Waffentempo, nur für Nahkampfwaffen.",
		WeaponMinDamage = "Min. Schaden",
		WeaponMinDamageInfo = "Minmaler Waffenschaden.",
		WeaponOffHandDps = "Nebenhand: DPS",
		WeaponOffHandDpsInfo = "Waffenschaden pro Sekunde, nur für Nebenhandwaffen.",
		WeaponOffHandMaxDamage = "Nebenhand: max. Schaden",
		WeaponOffHandMaxDamageInfo = "Maximaler Waffenschaden, nur für Nebenhandwaffen.",
		WeaponOffHandMinDamage = "Nebenhand: min. Schaden",
		WeaponOffHandMinDamageInfo = "Minimaler Waffenschaden, nur für Nebenhandwaffen.",
		WeaponOffHandSpeed = "Nebenhand: Tempo",
		WeaponOffHandSpeedInfo = "Waffentempo, nur für Nebenhandwaffen.",
		WeaponOneHandDps = "Einhand: DPS",
		WeaponOneHandDpsInfo = "Waffenschaden pro Sekunde, nur für Einhandwaffen (keine Waffenhand- und Nebenhandwaffen).",
		WeaponOneHandMaxDamage = "Einhand: max. Schaden",
		WeaponOneHandMaxDamageInfo = "Maximaler Waffenschaden, nur für Einhandwaffen (keine Waffenhand- und Nebenhandwaffen).",
		WeaponOneHandMinDamage = "Einhand: min. Schaden",
		WeaponOneHandMinDamageInfo = "Minimaler Waffenschaden, nur für Einhandwaffen (keine Waffenhand- und Nebenhandwaffen).",
		WeaponOneHandSpeed = "Einhand: Tempo",
		WeaponOneHandSpeedInfo = "Waffentempo, nur für Einhandwaffen (keine Waffenhand- und Nebenhandwaffen).",
		WeaponRangedDps = "Fernkampf: DPS",
		WeaponRangedDpsInfo = "Waffenschaden pro Sekunde, nur für Fernkampfwaffen.",
		WeaponRangedMaxDamage = "Fernkampf: max. Schaden",
		WeaponRangedMaxDamageInfo = "Maximaler Waffenschaden, nur für Fernkampfwaffen.",
		WeaponRangedMinDamage = "Fernkampf: min. Schaden",
		WeaponRangedMinDamageInfo = "Minimaler Waffenschaden, nur für Fernkampfwaffen.",
		WeaponRangedSpeed = "Fernkampf: Tempo",
		WeaponRangedSpeedInfo = "Waffentempo, nur für Fernkampfwaffen.",
		WeaponStats = "Waffenwertungen",
		WeaponTwoHandDps = "Zweihand: DPS",
		WeaponTwoHandDpsInfo = "Waffenschaden pro Sekunde, nur für Zweihandwaffen.",
		WeaponTwoHandMaxDamage = "Zweihand: max. Schaden",
		WeaponTwoHandMaxDamageInfo = "Maximaler Waffenschaden, nur für Zweihandwaffen.",
		WeaponTwoHandMinDamage = "Zweihand: min. Schaden",
		WeaponTwoHandMinDamageInfo = "Minimaler Waffenschaden, nur für Zweihandwaffen.",
		WeaponTwoHandSpeed = "Zweihand: Tempo",
		WeaponTwoHandSpeedInfo = "Waffentempo, nur für Zweihandwaffen.",
		WeaponType1HAxe = "Einhandaxt",
		WeaponType1HAxeInfo = "Für eine einhändige Axt zugeteilte Punkte.",
		WeaponType1HMace = "Einhandstreitkolben",
		WeaponType1HMaceInfo = "Für einen einhändigen Streitkolben zugeteilte Punkte.",
		WeaponType1HSword = "Einhandschwert",
		WeaponType1HSwordInfo = "Für ein einhändiges Schwert zugeteilte Punkte.",
		WeaponType2HAxe = "Zweihandaxt",
		WeaponType2HAxeInfo = "Für eine zweihändige Axt zugeteilte Punkte.",
		WeaponType2HMace = "Zweihandstreitkolben",
		WeaponType2HMaceInfo = "Für einen zweihändigen Streitkolben zugeteilte Punkte.",
		WeaponType2HSword = "Zweihandschwert",
		WeaponType2HSwordInfo = "Für ein zweihändiges Schwert zugeteilte Punkte.",
		WeaponTypeBow = "Bogen",
		WeaponTypeBowInfo = "Für einen Bogen zugeteilte Punkte.",
		WeaponTypeCrossbow = "Armbrust",
		WeaponTypeCrossbowInfo = "Für eine Armbrust zugeteilte Punkte.",
		WeaponTypeDagger = "Dolch",
		WeaponTypeDaggerInfo = "Für einen Dolch zugeteilte Punkte.",
		WeaponTypeFistWeapon = "Faustwaffe",
		WeaponTypeFistWeaponInfo = "Für eine Faustwaffe zugeteilte Punkte.",
		WeaponTypeFrill = "Schildhand Zauber",
		WeaponTypeFrillInfo = "Für Zaubergegenstände in der Schildhand zugeteilte Punkte.  Zählt nicht bei Schilden oder Waffen.",
		WeaponTypeGun = "Schusswaffe",
		WeaponTypeGunInfo = "Für eine Schusswaffe zugeteilte Punkte.",
		WeaponTypeOffHand = "Schildhand Waffe",
		WeaponTypeOffHandInfo = "Für eine reine Schildhandwaffe zugeteilte Punkte.  Zählt nicht bei Verzauberungen, Schilden oder Waffen, die in beiden Händen verwendet werden können oder Zaubergegenständen für die Schildhand.",
		WeaponTypePolearm = "Stangenwaffe",
		WeaponTypePolearmInfo = "Für eine Stangenwaffe zugeteilte Punkte.",
		WeaponTypes = "Waffenarten",
		WeaponTypeStaff = "Stab",
		WeaponTypeStaffInfo = "Für einen Stab zugeteilte Punkte.",
		WeaponTypeWand = "Zauberstab",
		WeaponTypeWandInfo = "Für einen Zauberstab zugeteilte Punkte.",
	},
	TooltipParsing = {
		Agility = "^%+?([-%d%.,]+) Beweglichkeit$",
		AllStats = "^%+?([%d%.,]+) [Aa]lle [Ww]erte$",
		Ap = "^%+?([%d%.,]+) Angriffskraft$",
		Armor = "^%+?([%d%.,]+) Rüstung$",
		Armor2 = "^UNUSED$",
		Avoidance = "^%+([%d%.,]+) Vermeidung$", -- Needs review
		Axe = "^Axt$",
		BagSlots = "^%d+ Platz .+$",
		BladesEdgeMountains = "^Schergrat$",
		BonusArmor = "^%+([%d%.,]+) Bonusrüstung$", -- Needs review
		Bow = "^Bogen$",
		ChanceOnHit = "Trefferchance:",
		Charges = "^.+ Ladungen?$",
		Cloth = "^Stoff$",
		CooldownRemaining = "^Verbleibende Abklingzeit:",
		Crit = "^%+?([%d%.,]+) [Kk]ritischer Trefferwert%.?$",
		Crit2 = "^UNUSED$",
		Crossbow = "^Armbrust$",
		Dagger = "^Dolch$",
		Design = "Design:",
		DisenchantingRequires = "^Entzaubern benötigt",
		Dodge = "^%+?([%d%.,]+) Ausweichen$",
		Dodge2 = "^UNUSED$",
		Dps = "^%(([%d%.,]+) Schaden pro Sekunde%)$",
		DpsAdd = "^Erhöht ([%d%.,]+) Schaden pro Sekunde$",
		Duration = "^Dauer:",
		Elite = "^Elite$",
		EnchantmentArmorKit = "^Verstärkt %(%+([%d%.,]+) Rüstung%)$",
		EnchantmentCounterweight = "^Gegengewicht %(%+([%d%.,]+) Tempowertung%)",
		EnchantmentFieryWeapon = "^Feurige Waffe$",
		EnchantmentHealth = "\"^%+([%d%.,]+) HP$",
		EnchantmentHealth2 = "\"^%+([%d%.,]+) Gesundheit$",
		EnchantmentLivingSteelWeaponChain = "^Waffenkette aus lebendigem Stahl$",
		EnchantmentPyriumWeaponChain = "^Pyriumwaffenkette$",
		EnchantmentTitaniumWeaponChain = "^Titanwaffenkette$",
		Equip = "Anlegen:",
		FistWeapon = "^Faustwaffe$",
		Flexible = "^Flexibel$",
		Formula = "Formel:",
		Gun = "^Schusswaffe$",
		Haste = "^%+?([%d%.,]+) Tempo$",
		Haste2 = "^UNUSED$",
		HeirloomLevelRange = "^Benötigt Stufe %d bis ([%d%.,]+)",
		HeirloomXpBoost = "^Anlegen: Erhaltene Erfahrung",
		HeirloomXpBoost2 = "^UNUSED$",
		Heroic = "^Heroisch$",
		HeroicElite = "^Heroisch, Elite$",
		HeroicThunderforged = "^Heroisch, Donnergeschmiedet$",
		HeroicWarforged = "^Heroisch, Kriegsgeschmiedet$",
		Hp5 = "^Anlegen: Stellt ([%d%.,]+) Gesundheit alle 5 Sek%. wieder her%.?$",
		Hp52 = "^Anlegen: Stellt alle 5 Sek%. ([%d%.,]+) Gesundheit wieder her%.?$",
		Hp53 = "^%+?([%d%.,]+) Gesundheit alle 5 [sS]ek%.?$",
		Hp54 = "^%+?([%d%.,]+) Gesundheit pro 5 [sS]ek%.?$",
		Intellect = "^%+?([-%d%.,]+) Intelligenz$",
		Leather = "^Leder$",
		Leech = "^%+([%d%.,]+) Lebensraub$", -- Needs review
		Mace = "^Streitkolben$",
		Mail = "^Kette$",
		Manual = "Anleitung:",
		Mastery = "^%+?([%d%.,]+) Meisterschaft$",
		Mastery2 = "^UNUSED$",
		MetaGemRequirements = "|cff%x%x%x%x%x%xBenötigt",
		MovementSpeed = "^%+([%d%.,]+) Bewegungsgeschwindigkeit$",
		MultiStatSeparator1 = "und",
		Multistrike = "^%+([%d%.,]+) Mehrfachschlag$", -- Needs review
		NormalizationEnchant = "^Verzaubert: (.*)$",
		OnlyFitsInMetaGemSlot = "\"Metaedelsteine können nur in Sockel der Kategorie Meta eingesetzt werden.%.\"$",
		Parry = "^%+?([%d%.,]+) Parieren$",
		Parry2 = "^UNUSED$",
		Pattern = "Muster:",
		Plans = "Pläne:",
		Plate = "^Platte$",
		Polearm = "^Stangenwaffe$",
		PvPPower = "^%+?([%d%.,]+) P[vV]P[- ]Macht$",
		RaidFinder = "^Schlachtzugsbrowser$",
		Recipe = "Rezept:",
		Requires2 = "^Benötigt",
		Resilience = "^%+?([%d%.,]+) P[vV]P[- ]Abhärtung$",
		Resilience2 = "^UNUSED$",
		Schematic = "Vorlage:",
		Scope = "^Zielfernrohr %(%+([%d%.,]+) Schaden%)$",
		ScopeCrit = "^Zielfernrohr %(%+([%d%.,]+) kritischer Trefferwert%)$",
		ScopeRangedCrit = "^%+?([%d%.,]+) kritische Ferntrefferwertung$",
		Season = "^Saison",
		ShadowmoonValley = "^Schattenmondtal$",
		Shield = "^Schild$",
		SocketBonusPrefix = "Sockelbonus:",
		Speed = "^Tempo ([%d%.,]+)$",
		Speed2 = "^UNUSED$",
		SpellPower = "^%+?([%d%.,]+) Zaubermacht$",
		Spirit = "^%+?([-%d%.,]+) Willenskraft$",
		Staff = "^Stab$",
		Stamina = "^%+?([-%d%.,]+) Ausdauer$",
		Strength = "^%+?([-%d%.,]+) Stärke$",
		Sword = "^Schwert$",
		TempestKeep = "^Festung der Stürme$",
		TemporaryBuffMinutes = "^.+%(%d+ Min%)$",
		TemporaryBuffSeconds = "^.+%(%d+ Sek%)$",
		Thunderforged = "^Donnergeschmiedet$",
		Timeless = "^Zeitlos$",
		UpgradeLevel = "^Upgrade Level:",
		Use = "Benutzen:",
		Versatility = "^%+([%d%.,]+) Vielseitigkeit$", -- Needs review
		Wand = "^Zauberstab$",
		Warforged = "^Kriegsgeschmiedet$",
		WeaponDamage = "^([%d%.,]+) %- ([%d%.,]+) Schaden$",
		WeaponDamageArcane = "^%+?([%d%.,]+) %- ([%d%.,]+) Arkanschaden$",
		WeaponDamageEnchantment = "^%+?([%d%.,]+) Waffenschaden$",
		WeaponDamageEquip = "^Anlegen: %+?([%d%.,]+) Waffenschaden%.$",
		WeaponDamageExact = "^%+?([%d%.,]+) Schaden$",
		WeaponDamageFire = "^%+?([%d%.,]+) %- ([%d%.,]+) Feuerschaden$",
		WeaponDamageFrost = "^%+?([%d%.,]+) %- ([%d%.,]+) Frostschaden$",
		WeaponDamageHoly = "^%+?([%d%.,]+) %- ([%d%.,]+) Heiligschaden$",
		WeaponDamageNature = "^%+?([%d%.,]+) %- ([%d%.,]+) Naturschaden$",
		WeaponDamageShadow = "^%+?([%d%.,]+) %- ([%d%.,]+) Schattenschaden$",
	},
	UI = {
		AboutHeader = "Über Pawn",
		AboutReadme = "Neu bei Pawn? Schau dir den \"Los geht's\" Reiter für eine erste Info an.  Mehr Informationen findest du in der mitgelieferten README Datei!",
		AboutTab = "Über",
		AboutTranslation = "Deutsche Übersetzung von Sandmahn",
		AboutVersion = "Version %s",
		AboutWebsite = [=[Für andere Addons von Vger, besuche vgermods.com.

Wowhead Bewertungsgewichtungen mit Erlaubnis benutzt.  Sende Feedback zu den Profilwerten bitte direkt an Wowhead.]=],
		CompareClearItems = "Zurücksetzen",
		CompareClearItemsTooltip = "Setzt beide Gegenstandsfelder zurück.",
		CompareCogwheelSockets = "Zahnradsockel",
		CompareColoredSockets = "Farbiger Sockel",
		CompareEquipped = "Angelegt",
		CompareGemTotalValue = "Wertung der Edelsteine",
		CompareHeader = "Vergleiche Gegenstände (Profil %s)",
		CompareMetaSockets = "Meta-Sockel",
		CompareOtherHeader = "Anderes",
		CompareShaTouchedSockets = "Sha-berührt",
		CompareSlotEmpty = "(kein Gegenstand)",
		CompareSocketBonus = "Sockelbonus",
		CompareSocketsHeader = "Sockel",
		CompareSpecialEffects = "Weitere Wertungen",
		CompareSwap = "< Tauschen >",
		CompareSwapTooltip = "Tauscht die Position der beiden zu vergleichenden Gegenstände.",
		CompareTab = "Vergleichen",
		CompareVersus = "—vs.—",
		CompareWelcomeLeft = "Wähle zuerst eine Skalierung aus der Liste auf der linken Seite.",
		CompareWelcomeRight = [=[Lass dann einen Gegenstand in diese Box fallen.

Du kannst ihn mit existierenden Gegenständen vergleichen, wenn du die Icons in der unteren linken Ecke benutzt.]=],
		CompareYourBest = "Bester im Fach",
		GemsColorHeader = "%s Edelsteine",
		GemsHeader = "Edelsteine für %s",
		GemsNoneFound = "Keine passende Edelsteine gefunden.",
		GemsQualityLevel = "Edelsteinqualität",
		GemsQualityLevelTooltip = [=[Gegenstandsstufe für die Edelsteine vorgeschlagen werden sollen.

Wenn z.B. "463" angegeben, dann wird Pawn Edelsteine für die Gegenstandsstufe 463 angezeigt: Mists of Pandaria Heroische Dungeons Loot.]=],
		GemsShowBest = "Zeige die besten verfügbaren Edelsteine an",
		GemsShowBestTooltip = "Zeigt die definitiv besten Edelsteine die verfügbar sind für das aktuell gewählte Profil. Einige der Edelsteine werden zu mächtig sein, um sie in alten oder niedrigstufigen Gegenständen zu sockeln.",
		GemsShowForItemLevel = "Empfohlenen Edelsteine für Gegenstandsstufe:",
		GemsShowForItemLevelTooltip = "Zeige die von Pawn empfohlenen Edelsteine für das aktuell gewählte Profil und eine bestimmte Gegenstandsstufe.",
		GemsTab = "Edelsteine",
		GemsWelcome = "Wähle ein Profil auf der linken Seite um die Edelsteine zu sehen, die Pawn empfiehlt.",
		HelpHeader = "Los geht's!",
		HelpTab = "Los geht's",
		HelpText = [=[Pawn berechnet Gegenstandswertungen, mit denen du schnell erkennen kannst, welches von zwei Items deinen selbstdefinierten Bedürfnissen mehr entspricht.  Diese Wertungen werden im Gegenstandstooltip angezeigt.


Jeder Gegenstand erhält eine Wertung für jedes Bewertungsprofil das für deinen Charakter aktiv ist.  Ein Bewertungsprofil enthält alle Skalierungen die wichtig für dich sind und die Anzahl Punkte, die sie wert sind. Üblicherweise hat man ein Profil pro Klasse oder Spezialisierung. Die Profile sind standardmässig verborgen, man kann jedoch im "Vergleichen" Reiter die Profile wählen und sehen. welche Werte diese für die zu vergleichenden Gegenstände berechnen würden.

• Du kannst Bewertungsprofile durch Shift-Klick in der Profil-Liste an und ausschalten.

Pawn enthält Bewertungsprofile von Wowhead für jede Klasse und Spezialisierung.  Du kannst eigene Bewertungsprofile erstellen in dem du Punktwertungen für Skalierungen definierst und diese Profile im Internet mit anderen teilen oder Profile aus dem Internet oder Simulationstools importieren.

|cff8ec3e6Probiere diese Features wenn du die Grundlagen verstanden hast:|r
• Vergleiche zwei Gegenstände, indem du den Pawn "Vergleichen" Reiter benutzt.
• Rechtsklicke auf das Gegenstandsfenster um zu sehen, wie er im Vergleich zum aktuellen Gegenstand abschneidet.
• Shift-Rechtsklicke auf einen gesockelten Gegenstand um von Pawn Vorschläge für geeignete Edelsteine zu bekommen.
• Erstelle eine Kopie deines Bewertungsprofils im Profil Tab und passe die Werte im Werte Tab an.
• Finde mehr Bewertungsprofile für deine Klasse im Internet oder erstelle dir ein persönliches Bewertungsprofil mit Pawn.
• Lies die readme Datei um Pawn's Möglichkeiten besser kennenzulernen.]=], -- Needs review
		InterfaceOptionsBody = "Klicke die Pawnschaltfläche, um dorthin zu gelangen.  Du kommst außerdem über die Charakterübersicht oder Tastenkürzel dorthin.",
		InterfaceOptionsWelcome = "Optionen für Pawn im Pawninterface.",
		InventoryButtonTooltip = "Klicken, um das Pawn-Interface anzuzeigen.",
		InventoryButtonTotalsHeader = "Gesamtwert aller angelegten Gegenstände:",
		KeyBindingCompareItemLeft = "Gegenstand vergleichen (links)",
		KeyBindingCompareItemRight = "Gegenstand vergleichen (rechts)",
		KeyBindingShowUI = "Pawninterface zeigen/verstecken",
		OptionsAdvisorHeader = "Ratgeber Optionen",
		OptionsAlignRight = "Wertungen im Tooltip rechts ausrichten",
		OptionsAlignRightTooltip = "Aktiviere diese Option um Pawn-Wertungen und Upgradeinformationen an der rechten anstatt der linken Seite des Tooltips auszurichten.",
		OptionsBlankLine = "Leerzeile vor Wertungen",
		OptionsBlankLineTooltip = "Halte die Tooltips übersichtlich, in dem du eine extra Leerzeile vor den Pawn-Wertungen einführst.",
		OptionsButtonHidden = "verstecken",
		OptionsButtonHiddenTooltip = "Den Pawn-Button im Charakterinfo Fenster NICHT anzeigen.",
		OptionsButtonPosition = "Pawn-Button anzeigen:",
		OptionsButtonPositionLeft = "links",
		OptionsButtonPositionLeftTooltip = "Zeige den Pawn-Button in der unteren linken Ecke des Charakterinfo Fensters.",
		OptionsButtonPositionRight = "rechts",
		OptionsButtonPositionRightTooltip = "Zeige den Pawn-Button in der unteren rechten Ecke des Charakterinfo Fensters.",
		OptionsColorBorder = "Tooltip-Rand bei Verbesserungen einfärben",
		OptionsColorBorderTooltip = "Aktiviere diese Option um den Tooltip-Rand in Grün anzuzeigen, wenn der Gegenstand eine Verbesserung darstellt. Deaktiviere diese Option wenn Probleme mit anderen Addons auftreten sollten. ",
		OptionsCurrentValue = "Zeige beide Werte (Aktuell und Basis)",
		OptionsCurrentValueTooltip = "Aktiviere diese Option um mit Pawn zwei Werte anzuzeigen: Der aktuelle Wert des Gegenstands mit allen aktuellen Edelsteinen, Verzauberungen und Umschmiedungen, die zur Zeit aktiv sind. Leere Sockel erhöhen die Wertung nicht. Zusätzlich wird der Basiswert angezeigt, den Pawn normalerweiser anzeigt. Der aktuelle Wert wird vor dem Basiswert angezeigt. Diese Option hat keinen Effekt solange nicht die Option \"Zeige Verbesserungen im Tooltip\" aktiviert ist.", -- Needs review
		OptionsDebug = "Zeige Debug-Info",
		OptionsDebugTooltip = [=[Wenn du nicht sicher bist, wie Pawn seine Werte ermittelt aktiviere diese Option, damit Pawn alle Arten von nützlichen Informationen in der Konsole ausgibt sobald du mit der Maus über einem Gegenstand bist. Diese Information enthält die Werte, die der Gegenstand hat, die Wertungen, die Pawn nicht versteht und wie alles bewertet wird.

Diese Option wird dein Chatlog überfluten, schalte sie nur zum Debuggen ein und dann wieder aus.

Shortcuts:
/pawn debug on
/pawn debug off]=],
		OptionsHeader = "Verändere Pawn Optionen",
		OptionsIgnoreGemsWhileLevelingCheck = "Sockets auf Low-Level-Elemente zu ignorieren", -- Needs review
		OptionsIgnoreGemsWhileLevelingCheckTooltip = [=[Enable this option to have Pawn ignore sockets on low-level items when calculating item values, since most people do not go to the effort or expense of socketing items while still leveling.  A "low-level" item is one weaker than what can be obtained in a heroic dungeon at the level cap.

If checked, Pawn's socketing advisor will still suggest appropriate gems for low-level items, but sockets will be ignored in calculations and socketed items will not show up as upgrades as often.

If unchecked, Pawn will calculate values for items as if they were socketed in the way that maximizes the item's value, regardless of the item's level.]=], -- Requires localization
		OptionsInventoryIcon = "Inventar-Icons anzeigen",
		OptionsInventoryIconTooltip = "Aktiviere diese Option um Inventar-Icons neben Gegenstandsfenstern anzuzeigen.",
		OptionsItemIDs = "Gegenstands-ID anzeigen",
		OptionsItemIDsTooltip = [=[Aktiviere diese Option um die Item-ID im Gegenstandstooltip anzuzeigen.

Jeder Gegenstand in World of Warcraft hat eine eindeutige ID. Diese Information ist üblicherweise nur für Addon Authoren nützlich.]=],
		OptionsLootAdvisor = "Zeige Upgrade-Ratgeber beim Plündern",
		OptionsLootAdvisorTooltip = "Wenn beim Plündern in Dungeons Gegenstände geplündert werden, die eine Verbesserung für deinen Charakter sind, wird Pawn in einem Popup neben dem Plündern-Dialog die Upgrade-Details anzeigen.",
		OptionsOtherHeader = "Weitere Optionen",
		OptionsQuestUpgradeAdvisor = "Zeige Upgrade-Ratgeber bei Quests",
		OptionsQuestUpgradeAdvisorTooltip = "Wenn in deinem Questlog oder beim Dialog mit NPCs, eine der Belohnungen eine Verbesserung für deinen Charakter ist, wird Pawn einen grünen Pfeil für diesen Gegenstand anzeigen.  Wenn keiner dieser Gegenstände eine Verbesserung ist, dann zeigt Pawn will für den Gegenstand Münzen an, der am wertvollsten beim Verkauf ist.",
		OptionsResetUpgrades = "Re-Scan",
		OptionsResetUpgradesTooltip = [=[Pawn wird alles vergessen, was es über die besten Gegenstände, die du je angelegt hattest, wusste und dein aktuelles Set erneut scannen um die bessere Upgradeinformationen in der Zukunft zu liefern.

Benutze dieses Feature wenn du denkst, dass Pawn schlechte Verbesserungsvorschläge aufgrund von Gegenständen macht, die du verkauft oder zerstört hast, bzw. nicht mehr benutzt.  Dies wird alle deine Charakter betreffen die Pawn benutzen.]=],
		OptionsSocketingAdvisor = "Zeige den Edelstein-Ratgeber",
		OptionsSocketingAdvisorTooltip = "Wenn du einem Gegenstand Edelsteine zufügst, dann wird Pawn ein Popup anzeigen, dass dir geeignete Edelsteine zur Verbesserung vorschlägt.  (Um eine komplette Liste der Edelsteinvorschläge zu sehen, benutze den Edelsteine Tab um die Qualität anzupassen.)",
		OptionsTab = "Optionen",
		OptionsTooltipHeader = "Tooltip Optionen",
		OptionsTooltipUpgradesOnly = "Zeige nur Verbesserung",
		OptionsTooltipUpgradesOnlyTooltip = [=[Das ist die einfachste Option.  Zeige nur Pawn Werte und prozentuale Upgrades für Gegenstände die eine Verbesserung für dein aktuelles Set wären. Zeige keine Pawn Werte für geringerwertige Gegenstände.

|cff8ec3e6Feuer:|r  |TInterface\AddOns\Pawn\Textures\UpgradeArrow:0|t |cff00ff00+10% Verbesserung|r

oder

|cff8ec3e6Feuer:  (Bester im Fach)|r]=],
		OptionsTooltipValuesAndUpgrades = "Zeige Wertungen und Verbesserung %",
		OptionsTooltipValuesAndUpgradesTooltip = [=[Zeigt Pawn Werte für alle sichtbaren Wertungen und alle Gegenstände, ausser denen mit Wert 0.  Zusätzlich alle Gegenstände anzeigen, die dein aktuelles Set verbessern würden.

|cff8ec3e6Frost:  123.4
Feuer:  156.7 |TInterface\AddOns\Pawn\Textures\UpgradeArrow:0|t |cff00ff00+10% Verbesserung|r
]=],
		OptionsTooltipValuesOnly = "Zeige nur Wertungen, keine Verbesserung %",
		OptionsTooltipValuesOnlyTooltip = [=[Zeige Pawn Werte für alle sichtbaren Wertungen aller Gegenstände, ausser denen mit Wert 0. Zeige keine Gegenstände die dein aktuelles Set verbessern würden.  Diese Option simuliert das Verhalten der alten Version von Pawn.

|cff8ec3e6Frost:  123.4
Feuer:  156.7|r]=],
		OptionsUpgradeHeader = "Zeige |TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t Verbesserung im Tooltip:",
		OptionsUpgradesForBothWeaponTypes = "Zeige Verbesserungen für 1Hand und 2Hand",
		OptionsUpgradesForBothWeaponTypesTooltip = [=[Pawn's Upgrade-Ratgeber zeigt Verbesserungen jeweils nur für die getragene Waffenart (Zweihand oder Einhand). Aktiviere diese Option um weiterhin beide Waffenarten in den Vergleich einzubeziehen. 

Wenn man eine Zweihand-Waffe trägt, wird weiterhin eine Verbesserung für Einhandwaffen gezeigt, wenn die Waffe besser als die vorherige Einhandwaffe ist. Verbesserungen werden in Pawn separat für Waffenarten verwaltet. Ein Vergleich zwischen Zweihand und Einhand Waffen findet nicht statt.

Deaktiviere die Option, wenn nur Verbesserungen für die aktuell getragene Waffenart gezeigt werden soll.]=],
		OptionsWelcome = "Konfiguriere Pawn wie du es möchtest. Änderungen werden unmittelbar übernommen.",
		ScaleChangeColor = "Farbe ändern",
		ScaleChangeColorTooltip = "Ändert die Schriftfarbe der Wertungsinformationen im Gegenstandstooltip.",
		ScaleCopy = "Kopieren",
		ScaleCopyTooltip = "Kopiert das momentane Bewertungsprofil.",
		ScaleDefaults = "Neu (Vorlage)",
		ScaleDefaultsTooltip = "Neues Bewertungsprofil durch Kopieren der Standardwerte erzeugen.",
		ScaleDeleteTooltip = [=[Aktuelles Bewertungsprofil löschen.

Dieser Vorgang kann nicht rückgängig gemacht werden!]=],
		ScaleEmpty = "Neu (leer)",
		ScaleEmptyTooltip = "Neues Bewertungsprofil erzeugen.",
		ScaleExport = "Exportieren",
		ScaleExportTooltip = "Teile deine Bewertungsprofile mit anderen im Internet.",
		ScaleHeader = "Verwalte Bewertungsprofile",
		ScaleImport = "Importieren",
		ScaleImportTooltip = "Füge ein neues Bewertungsprofil durch Kopieren und Einfügen eines Bewertungsprofil Tags aus dem Internet.",
		ScaleNewHeader = "Erstelle ein neues Bewertungsprofil",
		ScaleRename = "Umbenennen",
		ScaleRenameTooltip = "Bewertungsprofil umbenennen.",
		ScaleSelectorHeader = "Wähle ein Profil:",
		ScaleSelectorShowScale = "Dieses Bewertungsprofil im Gegenstandstooltip anzeigen.",
		ScaleSelectorShowScaleTooltip = [=[Aktiviere diese Option um dieses Profil im Gegenstandstooltip anzuzeigen. Jedes Bewertungsprofil kann für einen deiner Charakter, mehrere Charaktere oder gar keinen Charakter angezeigt werden. 

Shortcut: Shift+click auf ein Bewertungsprofil]=],
		ScaleShareHeader = "Teile deine Bewertungsprofile mit anderen",
		ScaleTab = "Bewertungsprofile",
		ScaleTypeNormal = "Du kannst dieses Profil im Werte Reiter ändern.",
		ScaleTypeReadOnly = "Du musst eine Kopie dieses Profils anfertigen um die Werte zu ändern.",
		ScaleWelcome = "Bewertungsprofile sind Wertegruppen die benutzt werden um Gegenständen Punkte zuzuweisen. Du kannst außerdem fremderstellte Bewertungsprofile importieren oder dein eigenes leeres oder auf Standardwerten basierendes Bewertungsprofil erstellen.",
		SocketingAdvisorButtonTooltip = "Klicken um Pawn's \"Edelsteine\" Reiter zu öffnen, wo du mehr Informationen über Edelsteine, die Pawn empfiehlt, bekommst.",
		SocketingAdvisorHeader = "Pawn's Edelstein-Ratgeber empfiehlt:",
		SocketingAdvisorIgnoreThisItem = "Kümmern Sie sich nicht Hinzufügen von Edelsteinen zu Low-Level. Aber wenn Sie dies tun, verwenden Sie diese:", -- Needs review
		ValuesDoNotShowUpgradesFor1H = "Verbesserungen für 1Hand ausblenden",
		ValuesDoNotShowUpgradesFor2H = "Verbesserungen für 2Hand ausblenden",
		ValuesDoNotShowUpgradesTooltip = "Aktiviere diese Option um Verbesserungen für die gewählten Gegenstände auszublenden. Obwohl Tank-Paladine Zweihandwaffen verwenden können sind diese niemals eine Verbesserung, also sollte keine Verbesserung angezeigt werden. Ähnlich ist es für Vergelter-Paladine, bei denen eine Einhandwaffe niemals eine Verbesserung darstellt.",
		ValuesFollowSpecialization = "Zeige nur Upgrades für meinen besten Rüstungstyp ab Level 50",
		ValuesFollowSpecializationTooltip = "Aktiviere diese Option um Rüstungsupgrades zu verstecken für die deine Klasse nicht spezialisiert ist (ab Level 50).  Zum Beispiel lernt ein Heilig-Paladin ab Level 50 Plattenspezialisierung, die seine Intelligenz um 5% erhöht wenn er nur Plattenrüstung trägt.  Wenn diese Option ausgewählt ist wird Pawn keine Stoff, Leder oder Kettenrüstung als Upgrades für Level 50+ Heilig-Paladine berücksichtigen.",
		ValuesHeader = "Werte für Profil %s",
		ValuesIgnoreStat = "Unbenutzbar-Markierung für Gegenstände",
		ValuesIgnoreStatTooltip = "Aktiviere diese Option um zu verhindern das unbenutzbare Gegenstände eine Wertung erhalten.  Schamanen können zum Beispiel keine Plattenrüstung tragen. Einen Schamanen-Profil kann Plattenrüstung als unbenutzbar markieren, so dass Plattenrüstung keine Wertung für dieses Profil erhält.",
		ValuesNormalize = "Werte normalisieren (ähnlich Wowhead)",
		ValuesNormalizeTooltip = [=[Aktiviere diese Option um alle Pawn-Wertungen durch die Summe aller Profilwerte zu teilen, wie es Wowhead und Lootzor tun. Dies hilft um eine bessere Bewertung in Situationen zu erzielen, wo eine Wertung Werte um 1 aufweist, während eine andere in der Nähe von 5 liegt. Weiterhin sind die ermittelten Zahlen kleiner.

Für weitere Informationen hierzu siehe readme.htm.]=],
		ValuesRemove = "Entfernen",
		ValuesRemoveTooltip = "Entferne diese Wertung aus dem Bewertungsprofil.",
		ValuesTab = "Werte",
		ValuesWelcome = "Du kannst die Wertungen in den Bewertungsprofilen anpassen. Um die Bewertungsprofile zu verwalten oder neue hinzuzufügen, benutze den \"Bewertungsprofile\" Reiter.",
		ValuesWelcomeNoScales = "Es wurde kein Bewertungsprofil ausgewählt. Wähle ein Bewertungsprofil im Reiter \"Bewertungsprofile\" aus oder kopiere Werte aus dem Internet.",
		ValuesWelcomeReadOnly = "Das ausgewählte Bewertungsprofil ist nicht editierbar. Erstelle im Reiter \"Bewertungsprofile\" ein neues Profil oder erstelle eine Kopie des gewählten Profils.",
	},
	Wowhead = {
		DeathKnightBloodTank = "Todesritter: Blut",
		DeathKnightFrostDps = "Todesritter: Frost",
		DeathKnightUnholyDps = "Todesritter: Unheilig",
		DruidBalance = "Druide: Gleichgewicht",
		DruidFeralDps = "Druide: Wildheit",
		DruidFeralTank = "Druide: Wächter",
		DruidRestoration = "Druide: Wiederherstellung",
		HunterBeastMastery = "Jäger: Tierherrschaft",
		HunterMarksman = "Jäger: Treffsicherheit",
		HunterSurvival = "Jäger: Überleben",
		MageArcane = "Magier: Arkan",
		MageFire = "Magier: Feuer",
		MageFrost = "Magier: Frost",
		MonkBrewmaster = "Mönch: Braumeister",
		MonkMistweaver = "Mönch: Nebelwirker",
		MonkWindwalker = "Mönch: Windläufer",
		PaladinHoly = "Paladin: Heilig",
		PaladinRetribution = "Paladin: Vergeltung",
		PaladinTank = "Paladin: Schutz",
		PriestDiscipline = "Priester: Disziplin",
		PriestHoly = "Priester: Heilig",
		PriestShadow = "Priester: Schatten",
		Provider = "Wowhead Wertungen",
		ProviderStarter = "Starter", -- Needs review
		RogueAssassination = "Schurke: Meucheln",
		RogueCombat = "Schurke: Kampf",
		RogueSubtlety = "Schurke: Täuschung",
		ShamanElemental = "Schamane: Elementar",
		ShamanEnhancement = "Schamane: Verstärkung",
		ShamanRestoration = "Schamane: Wiederherstellung",
		WarlockAffliction = "Hexenmeister: Gebrechen",
		WarlockDemonology = "Hexenmeister: Dämonologie",
		WarlockDestruction = "Hexenmeister: Zerstörung",
		WarriorArms = "Krieger: Waffen",
		WarriorFury = "Krieger: Furor",
		WarriorTank = "Krieger: Schutz",
	},
}
end

if GetLocale() == "deDE" then
	PawnUseThisLocalization()
end

-- After using this localization or deciding that we don't need it, remove it from memory.
PawnUseThisLocalization = nil
