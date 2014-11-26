-- Pawn by Vger-Azjol-Nerub
-- www.vgermods.com
-- © 2006-2014 Green Eclipse.  This mod is released under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 license.
-- See Readme.htm for more information.

-- 
-- French resources
------------------------------------------------------------

local function PawnUseThisLocalization()
PawnLocal =
{
	AsteriskTooltipLine = "|TInterface\\AddOns\\Pawn\\Textures\\Question:0|t Effets sp\195\169ciaux non inclus dans la valeur.", -- Needs review
	AverageItemLevelIgnoringRarityTooltipLine = "Niveau moyen de l'item", -- Needs review
	BackupCommand = "Sauvegarde", -- Needs review
	BaseValueWord = "base",
	CogwheelName = "Roue dent\195\169e", -- Needs review
	CopyScaleEnterName = "entrez un nom pour votre nouvelles echelle, une copie de %s:", -- Needs review
	CorrectGemsValueCalculationMessage = "   -- Des gemmes correctes seraient mieux: %g", -- Needs review
	CrystalOfFearName = "Cristal de peur", -- Needs review
	DebugOffCommand = "debug off",
	DebugOnCommand = "debug on",
	DeleteScaleConfirmation = "Etes vous sure que vous voulez \195\169ffacer %s? Vous ne pourrez revenir en arriere. tapez \"%s\" pour confirmer:", -- Needs review
	DidntUnderstandMessage = "   (?) ne comprend pas \"%s\".", -- Needs review
	EnchantedStatsHeader = "(valeur courante)", -- Needs review
	EngineeringName = "Ing\195\169nierie", -- Needs review
	ExportAllScalesMessage = "appuyez sur Ctrl+C pour copier vos \195\137tiquettes d'\195\169chelle, cr\195\169ez un fichier sur votre ordianteur pour en faire une sauvegarde, puis appuyez sur Ctrl+V pour les coller", -- Needs review
	ExportScaleMessage = "appuyez sur Ctrl+C pour copier vos \195\137tiquettes d'\195\169chelle suivant pour |cffffffff%s|r, puis appuyez sur Ctrl+V pour les coller plus tard.", -- Needs review
	FailedToGetItemLinkMessage = "   Echec \195\160 la reception du lien de l item de la part de l'infobulle. Ceci peut etre dut a un conflit de mod.", -- Needs review
	FailedToGetUnenchantedItemMessage = "   Echec \195\160 la reception des valeurs de base de l item. Ceci peut etre dut a un conflit de mod.", -- Needs review
	FoundStatMessage = "   %d %s",
	GemColorList1 = "%d %s",
	GemColorList2 = "%d %s ou %s", -- Needs review
	GemColorList3 = "%d d une quelconque couleur", -- Needs review
	GenericGemLink = "|Hitem:%d|h[Gemme %d]|h", -- Needs review
	GenericGemName = "(Gemme %d)", -- Needs review
	HiddenScalesHeader = "Autre Echelles", -- Needs review
	ImportScaleMessage = "appuyez sur Ctrl+V to pour coller une \195\169tiquette d'\195\169chelle que vous avez copi\195\169 d une autre source ici:", -- Needs review
	ImportScaleTagErrorMessage = "Pawn ne comprend pas cette \195\169tiquette d'\195\169chelle - formule. avez vous copi\195\169 toute la formule ? essayez de la copier et de la coller encore une fois:", -- Needs review
	ItemIDTooltipLine = "Item ID",
	ItemLevelTooltipLine = "Niveau d'item", -- Needs review
	LootUpgradeAdvisorHeader = "Clic pour comparer avec vos items.|n", -- Needs review
	LootUpgradeAdvisorHeaderMany = "|TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t cet items est une am\195\169lioration de %d . clic pour comparer avec vos items", -- Needs review
	MissocketWorthwhileMessage = "   -- Mais c'est mieux de seulement utiliser les gemmes %s :", -- Needs review
	NeedNewerVgerCoreMessage = "Pawn a besoin d une version plus r\195\169cente de VgerCore. utilisez s il vous pla\195\174t la version de VgerCore inclue dans Pawn.", -- Needs review
	NewScaleDuplicateName = "une formule avec ce nom existe d\195\169j\195\160. Entrer un nom pour votre formule:", -- Needs review
	NewScaleEnterName = "Entrer un nom pour votre formule:", -- Needs review
	NewScaleNoQuotes = "une formule ne peut avoir \" dans son nom. Entrer un nom pour votre formule:", -- Needs review
	NormalizationMessage = "   ---- mis aux normes en divisant par %g", -- Needs review
	NoScale = "(aucun)", -- Needs review
	NoScalesDescription = "Pour commencer, importez une formule ou commencez une nouvelle.", -- Needs review
	NoStatDescription = "Choisissez une statistique \195\160 partir de la liste sur la gauche.", -- Needs review
	Or = "ou", -- Needs review
	RenameScaleEnterName = "Entrer un nouveau nom pour %s:", -- Needs review
	SocketBonusValueCalculationMessage = "   -- Le bonus de sertissage vaudrait: %g", -- Needs review
	StatNameText = "1 |cffffffff%s|r vaut:", -- Needs review
	TooltipBestAnnotation = "%s  |cff8ec3e6(meilleur)|r", -- Needs review
	TooltipBestAnnotationSimple = "%s  votre meilleur", -- Needs review
	TooltipBigUpgradeAnnotation = "%s  |TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t|cff00ff00 upgrade%s|r",
	TooltipSecondBestAnnotation = "%s  |cff8ec3e6(second meilleur)|r", -- Needs review
	TooltipSecondBestAnnotationSimple = "%s  votre second meilleur", -- Needs review
	TooltipUpgradeAnnotation = "%s  |TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t|cff00ff00+%.0f%% am\195\169lioration%s|r", -- Needs review
	TooltipUpgradeFor1H = "pour ensemble 1 main", -- Needs review
	TooltipUpgradeFor2H = "pour 2 mains", -- Needs review
	TooltipVersusLine = "%s|n  vs. |c%s%s|r",
	TotalValueMessage = "   ---- Total: %g",
	UnenchantedStatsHeader = "(valeur de base)", -- Needs review
	Unusable = "(inutilisable)", -- Needs review
	UnusableStatMessage = "   -- %s est inutilisable, ainsi arrete.", -- Needs review
	Usage = "\
Pawn cr\195\169er par Vger-Azjol-Nerub\
www.vgermods.com\
 \
/pawn -- affiche ou cache UI Pawn\
/pawn debug [ on | off ] -- affiche les messages de debug sur la console\
/pawn backup -- sauvergarde toutes vos echelles dans vos formules\
 \
Pour plus d'information sur la Personnalisation de Pawn, regarder le fichier d'aide (Readme.htm) inclu dans le mod.", -- Needs review
	ValueCalculationMessage = "   %g %s x %g chaque = %g", -- Needs review
	VisibleScalesHeader = "%s d \195\169chelles", -- Needs review
	Stats = {
		AgilityInfo = "La statistique principale, Agilit\195\169e", -- Needs review
		Ap = "Puissance d attaque", -- Needs review
		ApInfo = "Puissance d attaque. absent sur la pluspart des items directement. n'inclus pas la puissance d attaque que vous recevrez de la force ou de l'agilit\195\169", -- Needs review
		ArmorInfo = "Armure, quelle que soit le type d item. Ne distingue pas entre l armure de base et le bonus d'armure car les items avec bonus d'amure sont obsoletes.", -- Needs review
		ArmorTypes = "Types d'armure", -- Needs review
		AvoidanceInfo = "\195\137vitement. R\195\169duit vos d\195\169g\195\162ts pris lors d'une attaque de zone.", -- Needs review
		BonusArmorInfo = "Armure bonus. N'inclus pas la valeur d'armure de base sur toutes les armures. Ce nombre devrait toujours \195\170tre au moins aussi haut que la valeur d'Armure", -- Needs review
		Cloth = "Tissu", -- Needs review
		ClothInfo = "Points a etre assign\195\169 si l item est en tissu", -- Needs review
		Crit = "Crit", -- Needs review
		CritInfo = "Coup critique. affecte les attaques de m\195\169l\195\169e, les attaques a distance et les sorts", -- Needs review
		DpsInfo = "d\195\169gat par seconde d arme. (si vous voulez diff\195\169rentes estimation pour diff\195\169rents types d'arme, voir la section \"statistiques sp\195\169ciale arme\".)", -- Needs review
		HasteInfo = "Hate. affecte les attaques de m\195\169l\195\169e, les attaques a distance et les sorts", -- Needs review
		IndestructibleInfo = "Indestructible. \195\169vite que votre \195\169quipement prenne des d\195\169g\195\162ts.", -- Needs review
		IndestructibleIs = "Etre |cffffffffindestructible|r vaut mieux:", -- Needs review
		IntellectInfo = "La statistique principale, Intelligence", -- Needs review
		Leather = "Cuir", -- Needs review
		LeatherInfo = "points \195\160 etre assign\195\169s si l item est en cuir", -- Needs review
		LeechInfo = "Sangsue. Fait que vos attaques et soins restaurent votre vie", -- Needs review
		Mail = "maille", -- Needs review
		MailInfo = "points \195\160 etre assign\195\169 si l item est en maille", -- Needs review
		MasteryInfo = "Ma\195\174trise. am\195\169liore le bonus unique de la sp\195\169cialistation de votre classe", -- Needs review
		MetaSocket = "M\195\169ta ch\195\162sse", -- Needs review
		MetaSocketInfo = "Une m\195\169ta-ch\195\162sse, que ce sois vide ou plein. ajoute des points en plus aux casques qui ont une m\195\169ta-ch\195\162sse pour compenser l'effet sp\195\169cial de la m\195\169ta gemme.", -- Needs review
		MinorStats = "Stats mineur", -- Needs review
		MovementSpeedInfo = "Vitesse de d\195\169placement. Fait que le personnage cours plus vite", -- Needs review
		MultistrikeInfo = "Frappe Multiple. Augmente les chances que vos attaques et soins touche votre cible 2 fois de plus \195\160 puissance r\195\169duite.", -- Needs review
		Plate = "plaque", -- Needs review
		PlateInfo = "points a etre ajouter si l item est en plaque", -- Needs review
		PrimaryStats = "stats primaire", -- Needs review
		PvPPower = "Puissance JcJ", -- Needs review
		PvPPowerInfo = "Puissance JcJ. Fait que vos capacit\195\169s effectuent plus de d\195\169gats aux autres joueurs (mais pas aux cr\195\169atures), et que vos sorts de soins soient plus puissant dans certaines situations JcJ.", -- Needs review
		PvPResilience = "R\195\169silience JcJ", -- Needs review
		PvPResilienceInfo = "R\195\169silience JcJ. R\195\169duit les d\195\169gats que vous recevez des attaques des autres joueurs. Effectif seulement contre d'autres joueurs", -- Needs review
		PvPStats = "Stats JcJ", -- Needs review
		SecondaryStats = "Secondaire", -- Needs review
		Shield = "Bouclier", -- Needs review
		ShieldInfo = "points a ajouter si l item est un bouclier", -- Needs review
		Sockets = "ch\195\162sse", -- Needs review
		SpecialWeaponStats = "stats sp\195\169cifique aux armes", -- Needs review
		SpeedBaseline = "vitesse de r\195\169f\195\169rence", -- Needs review
		SpeedBaselineInfo = "N est pas une statisque actuelle. Ce nombre est d\195\169duit de la statistique de vitesse avant d'etre multipli\195\169 par votre valeur d'echelle", -- Needs review
		SpeedBaselineIs = "|cffffffffVitesse de r\195\169f\195\169rence|r est:", -- Needs review
		SpeedInfo = "Vitesse d'arme, en secondes par mouvement. (si vous pr\195\169f\195\169rez des armes rapide, ce nombre devrait etre negatif. Voir aussi: \"vitesse de r\195\169f\195\169rence\" dans la section \"stats sp\195\169cifiques aux armes\"", -- Needs review
		SpeedIs = "1 seconde |cffffffffde vitesse de mouvement|r vaut:", -- Needs review
		SpellPower = "puissance de sort", -- Needs review
		SpellPowerInfo = "puissance de sort: pr\195\169sent sur les armes des jeuteurs de sort mais pas sur la pluspart des armures. n'inclut pas la puissance de sort recue de l'intelligence", -- Needs review
		SpiritInfo = "La statistique principale, Esprit", -- Needs review
		StaminaInfo = "La statistique principale, Endurance", -- Needs review
		StrengthInfo = "La statistique principale, Force", -- Needs review
		VersatilityInfo = "Polyvalence. Augmente les d\195\169g\195\162ts occasionn\195\169s pour les personnages d\195\169g\195\162ts, augmente les soins pour les personnages soigneur, et r\195\169duit les d\195\169g\195\162ts subis pour les personnages tank.", -- Needs review
		WeaponMainHandDps = "MH: DPS", -- Needs review
		WeaponMainHandDpsInfo = "d\195\169g\195\162ts d arme par seconde, seulement pour les armes de main droite", -- Needs review
		WeaponMainHandMaxDamage = "MH: d\195\169g\195\162ts max", -- Needs review
		WeaponMainHandMaxDamageInfo = "d\195\169g\195\162ts d arme maximal, seulement pour les armes de main droite", -- Needs review
		WeaponMainHandMinDamage = "MH: d\195\169g\195\162ts min", -- Needs review
		WeaponMainHandMinDamageInfo = "d\195\169g\195\162ts d arme minimum, seulement pour les armes de main droite", -- Needs review
		WeaponMainHandSpeed = "MH: vitesse", -- Needs review
		WeaponMainHandSpeedInfo = "Vitesse d arme, seulement pour les armes de main droite", -- Needs review
		WeaponMaxDamage = "D\195\169g\195\162ts maximum", -- Needs review
		WeaponMaxDamageInfo = "D\195\169g\195\162ts maximum de l arme", -- Needs review
		WeaponMeleeDps = "Melee: DPS", -- Needs review
		WeaponMeleeDpsInfo = "D\195\169g\195\162ts d arme par seconde, seulement pour les armes de m\195\169l\195\169e.", -- Needs review
		WeaponMeleeMaxDamage = "M\195\169l\195\169e: d\195\169g\195\162ts maximum", -- Needs review
		WeaponMeleeMaxDamageInfo = "D\195\169g\195\162ts maximum d arme, seulement pour les armes de m\195\169l\195\169e.", -- Needs review
		WeaponMeleeMinDamage = "M\195\169l\195\169e: d\195\169g\195\162ts minimum", -- Needs review
		WeaponMeleeMinDamageInfo = "D\195\169g\195\162ts minimum d arme, seulement pour les armes de m\195\169l\195\169e.", -- Needs review
		WeaponMeleeSpeed = "M\195\169l\195\169e: vitesse", -- Needs review
		WeaponMeleeSpeedInfo = "Vitesse d arme, seulement pour les armes de m\195\169l\195\169e.", -- Needs review
		WeaponMinDamage = "D\195\169g\195\162ts minimum", -- Needs review
		WeaponMinDamageInfo = "D\195\169g\195\162ts minimum d arme", -- Needs review
		WeaponOffHandDps = "OH: DPS", -- Needs review
		WeaponOffHandDpsInfo = "D\195\169g\195\162ts d arme par seconde, seulement pour arme sur main gauche", -- Needs review
		WeaponOffHandMaxDamage = "OH: d\195\169g\195\162ts max", -- Needs review
		WeaponOffHandMaxDamageInfo = "D\195\169g\195\162ts d arme maximum, seulement pour arme sur main gauche", -- Needs review
		WeaponOffHandMinDamage = "OH: d\195\169g\195\162ts min", -- Needs review
		WeaponOffHandMinDamageInfo = "D\195\169g\195\162ts d arme minimum, seulement pour arme sur main gauche", -- Needs review
		WeaponOffHandSpeed = "OH: vitesse", -- Needs review
		WeaponOffHandSpeedInfo = "Vitesse d arme, seulement pour arme sur main gauche", -- Needs review
		WeaponOneHandDps = "1H: DPS", -- Needs review
		WeaponOneHandDpsInfo = "D\195\169g\195\162ts d arme par seconde, seulement pour arme marqu\195\169es une main, n'incluant pas les armes de main droite ou gauche", -- Needs review
		WeaponOneHandMaxDamage = "1H: d\195\169g\195\162ts max", -- Needs review
		WeaponOneHandMaxDamageInfo = "D\195\169g\195\162ts d arme maximum, seulement pour les armes marqu\195\169es une main, n'incluant pas les armes de main droite ou gauche.", -- Needs review
		WeaponOneHandMinDamage = "1H: d\195\169g\195\162ts min", -- Needs review
		WeaponOneHandMinDamageInfo = "D\195\169g\195\162ts d arme minimum, seulement pour les armes marqu\195\169es une main, n'incluant pas les armes de main droite ou gauche.", -- Needs review
		WeaponOneHandSpeed = "1H: vitesse", -- Needs review
		WeaponOneHandSpeedInfo = "Vitesse d arme, seulement pour les armes marqu\195\169es une main, n'incluant pas les armes de main droite ou gauche.", -- Needs review
		WeaponRangedDps = "Distant: DPS", -- Needs review
		WeaponRangedDpsInfo = "D\195\169g\195\162ts d arme par seconde, seulement pour les armes \195\160 distance", -- Needs review
		WeaponRangedMaxDamage = "Distant: d\195\169g\195\162ts max", -- Needs review
		WeaponRangedMaxDamageInfo = "D\195\169g\195\162ts d arme maximum, seulement pour les armes \195\160 distance", -- Needs review
		WeaponRangedMinDamage = "Distant: d\195\169g\195\162ts min", -- Needs review
		WeaponRangedMinDamageInfo = "D\195\169g\195\162ts d arme minimum, seulement pour les armes \195\160 distance", -- Needs review
		WeaponRangedSpeed = "Distant: vitesse", -- Needs review
		WeaponRangedSpeedInfo = "Vitesse d arme, seulement pour les armes \195\160 distance", -- Needs review
		WeaponStats = "Stats d arme", -- Needs review
		WeaponTwoHandDps = "2H: DPS", -- Needs review
		WeaponTwoHandDpsInfo = "D\195\169g\195\162t d arme par seconde, seulement pour les armes a deux mains", -- Needs review
		WeaponTwoHandMaxDamage = "2H: d\195\169g\195\162t max", -- Needs review
		WeaponTwoHandMaxDamageInfo = "D\195\169g\195\162t d arme maximum, seulement pour les armes a deux mains", -- Needs review
		WeaponTwoHandMinDamage = "2H: d\195\169g\195\162t min", -- Needs review
		WeaponTwoHandMinDamageInfo = "D\195\169g\195\162t d arme minimum, seulement pour les armes a deux mains", -- Needs review
		WeaponTwoHandSpeed = "2H: vitesse", -- Needs review
		WeaponTwoHandSpeedInfo = "Vitesse d arme, seulement pour les armes a deux mains", -- Needs review
		WeaponType1HAxe = "Hache: 1H", -- Needs review
		WeaponType1HAxeInfo = "Points \195\160 etre assign\195\169 si l item est une hache \195\160 une main", -- Needs review
		WeaponType1HMace = "masse: 1H", -- Needs review
		WeaponType1HMaceInfo = "Points \195\160 etre assign\195\169 si l item est une masse \195\160 une main", -- Needs review
		WeaponType1HSword = "Ep\195\169e: 1H", -- Needs review
		WeaponType1HSwordInfo = "Points \195\160 etre assign\195\169 si l item est une \195\169p\195\169e \195\160 une main", -- Needs review
		WeaponType2HAxe = "Hache: 2H", -- Needs review
		WeaponType2HAxeInfo = "Points \195\160 etre assign\195\169 si l item est une hache \195\160 deux mains", -- Needs review
		WeaponType2HMace = "masse: 2H", -- Needs review
		WeaponType2HMaceInfo = "Points \195\160 etre assign\195\169 si l item est une masse \195\160 deux mains", -- Needs review
		WeaponType2HSword = "Ep\195\169e: 2H", -- Needs review
		WeaponType2HSwordInfo = "Points \195\160 etre assign\195\169 si l item est une \195\169p\195\169e \195\160 deux mains", -- Needs review
		WeaponTypeBow = "Arc", -- Needs review
		WeaponTypeBowInfo = "Points \195\160 etre assign\195\169 si l item est un arc", -- Needs review
		WeaponTypeCrossbow = "Arbal\195\168te", -- Needs review
		WeaponTypeCrossbowInfo = "Points \195\160 etre assign\195\169 si l item est une Arbal\195\168te", -- Needs review
		WeaponTypeDagger = "Dague", -- Needs review
		WeaponTypeDaggerInfo = "Points \195\160 etre assign\195\169 si l item est une dague", -- Needs review
		WeaponTypeFistWeapon = "Arme de pugilat", -- Needs review
		WeaponTypeFistWeaponInfo = "Points \195\160 etre assign\195\169 si l item est une arme de pugilat", -- Needs review
		WeaponTypeFrill = "Tenu(e) en main gauche", -- Needs review
		WeaponTypeFrillInfo = "Points \195\160 etre assign\195\169 si l item est un \"Tenu(e) en main gauche\"  seconde main pour jeteur de sort. Ne s'applique pas aux boucliers ou aux armes", -- Needs review
		WeaponTypeGun = "Fusil", -- Needs review
		WeaponTypeGunInfo = "Points \195\160 etre assign\195\169 si l item est un fusil", -- Needs review
		WeaponTypeOffHand = "Arme main gauche", -- Needs review
		WeaponTypeOffHandInfo = "Points \195\160 etre assign\195\169 si l item est n'importe quelle arme qui peut seulement etre \195\169quip\195\169e en main gauche. Ne s'applique pas aux items 'Tenu(e) en main gauche\" des jeteurs de sort.", -- Needs review
		WeaponTypePolearm = "Armes d'hast", -- Needs review
		WeaponTypePolearmInfo = "Points \195\160 etre assign\195\169 si l item est une arme d'hast", -- Needs review
		WeaponTypes = "Types d arme", -- Needs review
		WeaponTypeStaff = "B\195\162ton", -- Needs review
		WeaponTypeStaffInfo = "Points \195\160 etre assign\195\169s si l item est un b\195\162ton", -- Needs review
		WeaponTypeWand = "Baguette", -- Needs review
		WeaponTypeWandInfo = "Points \195\160 etre assign\195\169s si l item est une baguette", -- Needs review
	},
	TooltipParsing = {
		Agility = "^%+?([-%d%.,]+) Agilit\195\169$",
		AllStats = "^%+?([%d%.,]+) \195\160 toutes les caract\195\169ristiques$",
		Ap = "^%+?([%d%.,]+) \195\160 la puissance d'attaque$",
		Armor = "^Armure\194\160: ([%d%.,]+)$", -- Needs review
		Armor2 = "^UNUSED$",
		Avoidance = "^%+([%d%.,]+) \195\137vitement$", -- Needs review
		Axe = "^Hache$",
		BagSlots = "^Sac %d+ .+$",
		BladesEdgeMountains = "^Les Tranchantes$",
		BonusArmor = "^%+([%d%.,]+) Armure bonus$", -- Needs review
		Bow = "^Arc$", -- Needs review
		ChanceOnHit = "Chances quand vous touchez",
		Charges = "^.+ Charges?$",
		Cloth = "^Tissu$",
		CooldownRemaining = "^Temps de recharge",
		Crit = "^%+?([%d%.,]+) Score de crit%.?$",
		Crit2 = "^%+?([%d%.,]+) au score de critique$",
		Crossbow = "^Arbal\195\168te$",
		Dagger = "^Dague$",
		Design = "Dessin\194\160:",
		DisenchantingRequires = "^L'enchantement requiert",
		Dodge = "^%+?([%d%.,]+) Esquive$",
		Dodge2 = "^%+?([%d%.,]+) \195\160 l'esquive$",
		Dps = "^%(([%d%.,]+) d\195\169g\195\162ts par seconde%)$",
		DpsAdd = "^Ajoute ([%d%.,]+) d\195\169g\195\162ts par seconde$",
		Duration = "^Dur\195\169e\194\160:", -- Needs review
		Elite = "^Elite$", -- Needs review
		EnchantmentArmorKit = "^Renforc\195\169 %(%+(%d+) Armure%)$",
		EnchantmentCounterweight = "^Contrepoids %(%+([%d%.,]+) \195\160 la h\195\162te%)",
		EnchantmentFieryWeapon = "^Arme flamboyante$",
		EnchantmentHealth = "^%+([%d%.,]+) aux points de vie$",
		EnchantmentHealth2 = "^UNUSED$", -- Needs review
		EnchantmentLivingSteelWeaponChain = "^Dragonne en acier vivant$",
		EnchantmentPyriumWeaponChain = "^Dragonne en pyrium$",
		EnchantmentTitaniumWeaponChain = "^Dragonne en titane$",
		Equip = "\195\137quip\195\169\194\160:", -- Needs review
		FistWeapon = "^Arme de pugilat$",
		Flexible = "^Flexible$", -- Needs review
		Formula = "Formule\194\160:", -- Needs review
		Gun = "^Arme \195\160 feu$",
		Haste = "^%+?(%-?%d+) H\195\162te$", -- Needs review
		Haste2 = "^%+?([%d%.,]+) \195\160 la h\195\162te",
		HeirloomLevelRange = "^Requier un niveau de %d+ \195\160 (%d+)", -- Needs review
		HeirloomXpBoost = "^\195\137quip\195\169\194\160: L?'?[Ee]xp\195\169rience gagn\195\169e", -- Needs review
		HeirloomXpBoost2 = "^UNUSED$",
		Heroic = "^H\195\169ro\195\175que$", -- Needs review
		HeroicElite = "^H\195\169ro\195\175que \195\169lite$", -- Needs review
		HeroicThunderforged = "^Foudroyant h\195\169ro\195\175que$", -- Needs review
		HeroicWarforged = "^De guerre h\195\169ro\195\175que$", -- Needs review
		Hp5 = " ^%+?([%d%.,]+) Points de [vV]ie [tT]outes les 5 [sS]%.?$", -- Needs review
		Hp52 = "^Equip\195\169: Reconstitue([%d%.,]+) de vie par 5 sec%.$", -- Needs review
		Hp53 = " ^%+?([%d%.,]+) Points de [vV]ie [tT]outes les 5 [sS]%.?$", -- Needs review
		Hp54 = " ^%+?([%d%.,]+) [vV]ie [pP]ar 5 [sS]ec%.?$", -- Needs review
		Intellect = "^%+?([-%d%.,]+) Intelligence$",
		Leather = "^Cuir$",
		Leech = "^%+([%d%.,]+) Vol de Vie$", -- Needs review
		Mace = "^Masse$",
		Mail = "^Mailles$",
		Manual = "Manuel\194\160:", -- Needs review
		Mastery = "^%+?([%d%.,]+) Ma\195\174trise$", -- Needs review
		Mastery2 = "^%+?([%d%.,]+) \195\160 la ma\195\174trise$",
		MetaGemRequirements = "|cff%x%x%x%x%x%xN\195\169cessite",
		MovementSpeed = "^%+([%d%.,]+) Rapidit\195\169$", -- Needs review
		MultiStatSeparator1 = "et",
		Multistrike = "^%+([%d%.,]+) Frappe multiple$", -- Needs review
		NormalizationEnchant = "^Enchant\195\169\194\160: (.*)$", -- Needs review
		OnlyFitsInMetaGemSlot = "^\"Ne peut \195\170tre serti que dans une ch\195\162sse de m\195\169ta-gemme.%.\"$",
		Parry = "^%+?([%d%.,]+) Parade$",
		Parry2 = "^%+?([%d%.,]+) \195\160 la parade$",
		Pattern = "Patron\194\160:",
		Plans = "Plans\194\160:",
		Plate = "^Plaques$",
		Polearm = "^Arme d'hast$",
		PvPPower = "^%+?([%d%.,]+) [Pp]uissance %(JcJ%)$",
		RaidFinder = "^Outil Raids$", -- Needs review
		Recipe = "Recette\194\160:",
		Requires2 = "^Niveau [%d%.,]+ requis$",
		Resilience = "^%+?([%d%.,]+) R\195\169silience %(JcJ%)$",
		Resilience2 = "^%+?([%d%.,]+) \195\160 la r\195\169silience %(JcJ%)$",
		Schematic = "Sch\195\169ma\194\160:",
		Scope = "^Lunette %(%+([%d%.,]+) points de d\195\169g\195\162ts%)$",
		ScopeCrit = "^Lunette %(%+([%d%.,]+) au score de critique%)$",
		ScopeRangedCrit = "^%+?([%d%.,]+) au score de critique \195\160 distance$",
		Season = "^Saison", -- Needs review
		ShadowmoonValley = "^Vall\195\169e d\226\128\153Ombrelune$", -- Needs review
		Shield = "^Bouclier$",
		SocketBonusPrefix = "Bonus de sertissage\194\160:",
		Speed = "^Vitesse ([%d%.,]+)$",
		Speed2 = "^UNUSED$",
		SpellPower = "^%+?([%d%.,]+) Puissance des sorts$", -- Needs review
		Spirit = "^%+?([-%d%.,]+) Esprit$",
		Staff = "^B\195\162ton$",
		Stamina = "^%+?([-%d%.,]+) Endurance$",
		Strength = "^%+?([-%d%.,]+) Force$",
		Sword = "^Ep\195\169e$",
		TempestKeep = "^Donjon de la Temp\195\170te$", -- Needs review
		TemporaryBuffMinutes = "^.+%(%d+ min%)$", -- Needs review
		TemporaryBuffSeconds = "^.+%(%d+ sec%)$", -- Needs review
		Thunderforged = "^Foudroyant$", -- Needs review
		Timeless = "^du Temps fig\195\169$\
", -- Needs review
		UpgradeLevel = "^Niveau d\226\128\153am\195\169lioration\194\160:",
		Use = "Utiliser\194\160:", -- Needs review
		Versatility = "^%+([%d%.,]+) Polyvalence$", -- Needs review
		Wand = "^Baguette$",
		Warforged = "^De guerre$", -- Needs review
		WeaponDamage = "^D\195\169g\195\162ts\194\160: ([%d%.,]+) %- ([%d%.,]+)$",
		WeaponDamageArcane = "^%+?([%d%.,]+) %- ([%d%.,]+) points de d\195\169g\195\162ts %(Arcanes%)$",
		WeaponDamageEnchantment = "^%+?([%d%.,]+) aux d\195\169g\195\162ts de l'arme$",
		WeaponDamageEquip = "^\195\137quip\195\169\194\160: %+?([%d%.,]+) aux d\195\169g\195\162ts de l'arme%.$",
		WeaponDamageExact = "^D\195\169g\195\162ts\194\160: ([%d%.,]+)$",
		WeaponDamageFire = "^%+?([%d%.,]+) %- ([%d%.,]+) points de d\195\169g\195\162ts %(Feu%)$",
		WeaponDamageFrost = "^%+?([%d%.,]+) %- ([%d%.,]+) points de d\195\169g\195\162ts %(Givre%)$",
		WeaponDamageHoly = "^%+?([%d%.,]+) %- ([%d%.,]+) points de d\195\169g\195\162ts %(Sacr\195\169%)$",
		WeaponDamageNature = "^%+?([%d%.,]+) %- ([%d%.,]+) points de d\195\169g\195\162ts %(Nature%)$",
		WeaponDamageShadow = "^%+?([%d%.,]+) %- ([%d%.,]+) points de d\195\169g\195\162ts %(Ombre%)$",
	},
	UI = {
		AboutHeader = "\195\160 propos de Pawn", -- Needs review
		AboutReadme = "Nouveau avec pawn ? Regardez la section D\195\169buter (getting started) pour une introduction basique", -- Needs review
		AboutTab = "\195\160 propos de", -- Needs review
		AboutTranslation = "Version francaise par Othor-eitrigg", -- Needs review
		AboutVersion = "Version %s", -- Needs review
		AboutWebsite = "Pour d'autres mods par Vger, visitez vgermods.com.\
\
Les poids de stat Wowhead sont utilis\195\169s avec permission\226\128\148S'il vous pla\195\174t dirigez les retours sur les valeurs d'echelle par d\195\169faut \195\160 Wowhead.", -- Needs review
		CompareClearItems = "Effacer", -- Needs review
		CompareClearItemsTooltip = "Retirer la comparaison des deux items", -- Needs review
		CompareCogwheelSockets = "Ch\195\162sse de Roue dent\195\169e", -- Needs review
		CompareColoredSockets = "Ch\195\162sse color\195\169e", -- Needs review
		CompareEquipped = "Equipp\195\169", -- Needs review
		CompareGemTotalValue = "Valeur de la gemme", -- Needs review
		CompareHeader = "Compare les items en utilisant %s", -- Needs review
		CompareMetaSockets = "M\195\169ta ch\195\162sse", -- Needs review
		CompareOtherHeader = "Autre", -- Needs review
		CompareShaTouchedSockets = "Touch\195\169 par les sha", -- Needs review
		CompareSlotEmpty = "(pas d item)", -- Needs review
		CompareSocketBonus = "Bonus de sertissage", -- Needs review
		CompareSocketsHeader = "Ch\195\162sse", -- Needs review
		CompareSpecialEffects = "Effets sp\195\169ciaux", -- Needs review
		CompareSwap = "\226\128\185 Interverti \226\128\186", -- Needs review
		CompareSwapTooltip = "Interverti l'item de gauche avec celui de droite", -- Needs review
		CompareTab = "Compare", -- Needs review
		CompareVersus = "\226\128\148contre.\226\128\148", -- Needs review
		CompareWelcomeLeft = "En premier, selectionnez une \195\169chelle de la liste sur la gauche", -- Needs review
		CompareWelcomeRight = "puis glisse un item dans cette boite.\
\
vous pouvez le comparer par rapport a vos items existant en utilsant l'icone du coin en bas \195\160 gauche.", -- Needs review
		CompareYourBest = "votre meilleur", -- Needs review
		GemsColorHeader = "gemme %s", -- Needs review
		GemsHeader = "gemme pour %s", -- Needs review
		GemsNoneFound = "aucune gemme ad\195\169quate n a \195\169t\195\169 trouv\195\169e", -- Needs review
		GemsQualityLevel = "Niveau de qualit\195\169 de la gemme", -- Needs review
		GemsQualityLevelTooltip = "Le niveau d'items pour lequel suggerer des gemmes.\
\
Par exemple, si \"463\", alors Pawn affichera des gemmes appropri\195\169es pour l'utilisation dans un item de niveau 463: butin de donjon h\195\169roique de Mists of Pandaria.", -- Needs review
		GemsShowBest = "Affiche la meilleur gemme disponible", -- Needs review
		GemsShowBestTooltip = "Affiche la meilleur gemme absolu pour l'echelle utilis\195\169e en ce moment. certaines de ces gemmes seront trops puissantes pour \195\170tre inserer dans des chasses d'items trops vieux et de moins bonnes qualit\195\169.", -- Needs review
		GemsShowForItemLevel = "Affiche la gemme recommand\195\169e pour un niveau:", -- Needs review
		GemsShowForItemLevelTooltip = "Affiche les gemmes que Pawn recommande pour l'echelle (formule) actuellement s\195\169lectionn\195\169e et d'un item d'un niveau sp\195\169cifique.", -- Needs review
		GemsTab = "Gemmes", -- Needs review
		GemsWelcome = "S\195\169lectionne une \195\169chelle (formule) sur la gauche pour voir les gemmes que Pawn recommende", -- Needs review
		HelpHeader = "Bienvenue sur Pawn!", -- Needs review
		HelpTab = "Debuter", -- Needs review
		HelpText = "Pawn calcul les scores pour vos items sur les stats qua votre item. il utilise ces scores pour d\195\169terminer lequel de vos items est le meilleur, et pour identifier les items qui am\195\169lioreraient vos tenues.\
\
\
Chaque item recevra un score pour chaque \"\195\137chelle\" active sur votre personnage. une \195\169chelle liste les staistiques qui sont important pour vous, et combien de points chaque statistiques vaut. Vous avez g\195\169n\195\169ralement une \195\169chelle pour chacune des sp\195\169cialisations ou roles de vos classes. ces scores sont normalement cach\195\169s, mais vous pouvez comment le score d'un item a \195\169t\195\169 calcul\195\169 sur la tabulation de Comparaison.\
\
 \226\128\162 vous pouvez mettre en marche ou arreter une \195\169chelle en faisant un Clic de changement dessus dans la liste de tabulation d'\195\169chelle\
\
\
Pawn vient avec les \195\169chelles de Wowhead pour chaque classe et sp\195\169. vous pouvez aussi cr\195\169er la votre en assignant des valeurs de point \195\160 chaque stat, importer des \195\169chelles (formules) d'internet ou d'outils de simulation, ou en partager en guilde.\
\
\
|cff8ec3e6Essayez ces fonctionnalit\195\169s une fois que vous aurez appris la base:|r\
 \226\128\162 comparez les stats de deux items en utilisant l'onglet de comparaison de Pawn\
 \226\128\162 Clic-droit sur un item lier dans une fenetre pour voir comment il compare avec votre item actuel.\
 \226\128\162 shift-Clic-droit un item avec emplacement de gemme pour que pawn suggere une gemme\
 \226\128\162 Faite une copie d'une de vos formules dans l'onglet d'echelle, et personnalisez l les valeurs de stat dans l'onglet valeur.\
 \226\128\162 Trouvez plus de formules pour votre classe sur internet\
 \226\128\162 lisez le fichier readme pour en apprendre plus sur les fonctionnalit\195\169s avanc\195\169es de Pawn", -- Needs review
		InterfaceOptionsBody = "Cliquez le bouton Pawn pour y aller. vous  pouvez aussi ouvrir Pawn \195\160 partir de votre page d'inventaire, ou en y associant une touche.", -- Needs review
		InterfaceOptionsWelcome = "Les options de Pawn se trouve dans la Pawn UI (interface utilisateur)", -- Needs review
		InventoryButtonTooltip = "clic pour ouvrir Pawn", -- Needs review
		InventoryButtonTotalsHeader = "Totaux de tous les \195\169quipements \195\169quip\195\169s:", -- Needs review
		KeyBindingCompareItemLeft = "compare item (gauche)", -- Needs review
		KeyBindingCompareItemRight = "compare item (droit)", -- Needs review
		KeyBindingShowUI = "bascule sur l iu de pawn", -- Needs review
		OptionsAdvisorHeader = "options conseill\195\169es", -- Needs review
		OptionsAlignRight = "aligne les valeurs sur le bord droit de l infobulle", -- Needs review
		OptionsAlignRightTooltip = "permet cette option pour aligner les valeurs de Pawn et vos informations d'information sur le bord droit de l infobulle au lieu de la gauche", -- Needs review
		OptionsBlankLine = "ajoute une ligne blanche avant les valeurs", -- Needs review
		OptionsBlankLineTooltip = "garde vos Infobulles tres rang\195\169 en permettant cette option, qui ajoute une ligne blanche avant les valeurs de Pawn", -- Needs review
		OptionsButtonHidden = "cache le", -- Needs review
		OptionsButtonHiddenTooltip = "ne pas afficher le bouton Pawn sur le panneau d'information du personnage", -- Needs review
		OptionsButtonPosition = "Affiche le bouton Pawn:", -- Needs review
		OptionsButtonPositionLeft = "Sur la gauche", -- Needs review
		OptionsButtonPositionLeftTooltip = "Affiche le bouton Pawn dans le coin en bas \195\160 gauche sur le panneau d'information du personnage", -- Needs review
		OptionsButtonPositionRight = "Sur la droite", -- Needs review
		OptionsButtonPositionRightTooltip = "Affiche le bouton Pawn dans le coin en bas \195\160 droite sur le panneau d'information du personnage", -- Needs review
		OptionsColorBorder = "Colorie le bord de l'infobulle des am\195\169liorations", -- Needs review
		OptionsColorBorderTooltip = "Permet cette option pour changer la couleur du bord de l infobulle des items qui sont am\195\169lior\195\169 en vert. Emp\195\170che cette option si \195\167a interf\195\168re avec d'autres mods qui changent le bord des infobulle.", -- Needs review
		OptionsCurrentValue = "Affiche les valeurs de r\195\169f\195\169rence et courantes", -- Needs review
		OptionsCurrentValueTooltip = "Permet cette option pour que Pawn affiche deux valeurs par items: la valeur courante, qui refl\195\168te l'\195\169tat courant de l'item avec les gemmes actuelles, enchantement, et retouche que l'item a en ce moment, avec les ch\195\162sse vides qui n'ajoutent aucuns b\195\169n\195\169fices, en addition \195\160 la valeur de r\195\169f\195\169rence, que Pawn normalement affiche. La valeur courante sera affich\195\169 avant la valeur de r\195\169f\195\169rence. cette option n a aucun effet \195\160 moins que vous permettiez l'affichage des valeurs d item dans l infobulle.\
\
Vous devriez toujours utiliser la valeur de r\195\169f\195\169rence pour d\195\169terminer entre deux items de fin de jeux, mais la valeur courante peut \195\170tre utile quand on monte et sera plus facile pour d\195\169cider s'il vaut mieux \195\169quiper imm\195\169diatement un nouvel item avant qu'il soit g\195\169mm\195\169 et enchant\195\169.", -- Needs review
		OptionsDebug = "Affiche les informations de debug", -- Needs review
		OptionsDebugTooltip = "Si vous n \195\170tes pas sure de la fa\195\167on dont Pawn calcule les valeurs pour un item sp\195\169cifique, permet cette option pour que Pawn affiche toutes sortes de donn\195\169es 'utile' sur la console de discussion quand vous survolez un item. Ces information incluent quel stats Pawn pense que l item a, quelles parties de l item Pawn ne comprend pas, et comment il prend chacun en compte pour chacune de vos echelles (formules)\
\
Cette option remplira rapidement votre canal de discussion, aussi vous voudrez l arr\195\170ter une fois fini l investigation.\
\
raccourcis:\
/pawn debug on\
/pawn debug off", -- Needs review
		OptionsHeader = "Ajuste les options de Pawn", -- Needs review
		OptionsIgnoreGemsWhileLevelingCheck = "Ignorer les douilles sur les \195\169l\195\169ments bas niveau", -- Needs review
		OptionsIgnoreGemsWhileLevelingCheckTooltip = "Activez cette option pour que le pion ignorer les douilles sur les \195\169l\195\169ments bas niveau lors du calcul des valeurs de l'\195\169l\195\169ment, \195\169tant donn\195\169 que la plupart des gens ne vont pas \195\160 l'effort ou les frais d'embo\195\174tement des articles tout en nivelant encore. Un \195\169l\195\169ment de \194\171 bas niveau \194\187 est l'un plus faible que ce qui peut \195\170tre obtenu dans un donjon h\195\169ro\195\175que \195\160 la limite de niveau.\
\
Si coch\195\169e, conseiller embo\195\174tement du pion propose toujours gemmes appropri\195\169s pour les \195\169l\195\169ments de bas niveau, mais prises seront ignor\195\169s dans les calculs et demi-pont \195\169l\195\169ments n'apparaissent pas comme des mises \195\160 jour aussi souvent.\
\
Si non coch\195\169, pion calculera les valeurs pour les \195\169l\195\169ments comme s'ils \195\169taient encastr\195\169s de la mani\195\168re qui maximise la valeur de l'\195\169l\195\169ment, quel que soit le niveau.", -- Needs review
		OptionsInventoryIcon = "Affiche les ic\195\180nes d'inventaire", -- Needs review
		OptionsInventoryIconTooltip = "Permet cette option pour afficher l'ic\195\180ne d'inventaire \195\160 cot\195\169 de la fen\195\170tre de lien de l item", -- Needs review
		OptionsItemIDs = "Affiche les ID des items", -- Needs review
		OptionsItemIDsTooltip = "Permet cette option pour que Pawn affiche l id de l'item que vous rencontrez, ainsi que les ids de tous les enchantements et gemmes.\
\
Chaque item dans World of Warcraft a un num\195\169ro d ID associ\195\169 \195\160 lui. Cette information est g\195\169n\195\169ralement seulement utile aux auteurs de mods", -- Needs review
		OptionsLootAdvisor = "Affiche les suggestions d'am\195\169lioration de butin", -- Needs review
		OptionsLootAdvisorTooltip = "Quand un butin tombe en donjon et que c est une am\195\169lioration pour votre personnage, Pawn affichera une fen\195\170tre attach\195\169 \195\160 la fen\195\170tre de loot vous parlant de l'am\195\169lioration.", -- Needs review
		OptionsOtherHeader = "Autres options", -- Needs review
		OptionsQuestUpgradeAdvisor = "Affiche les suggestions de qu\195\170te pouvant am\195\169lior\195\169", -- Needs review
		OptionsQuestUpgradeAdvisorTooltip = "Dans votre journal de qu\195\170tes et quand vous parlez \195\160 des NPCs, si un des choix de r\195\169compense de qu\195\170tes est une am\195\169lioration pour votre tenue actuelle, Pawn affichera en ic\195\180ne une fl\195\168che verte sur cet item. Si aucun des items n'est une am\195\169lioration, Pawn affichera une pile de monnaies sur l item qui vaut le plus quand vendu \195\160 un vendeur", -- Needs review
		OptionsResetUpgrades = "Re-scan la tenue", -- Needs review
		OptionsResetUpgradesTooltip = "Pawn oubliera ce qu il connait sur les meilleurs items que vous avez \195\169quip\195\169 et re-scannera votre tenue pour fournir des informations d am\195\169lioration plus \195\160 jour dans le futur.\
\
Utilisez cette fonctionnalit\195\169 si vous trouvez que Pawn effectue de mauvaises suggestions d am\195\169lioration comme r\195\169sultat d items que vous avez vendu, detruit, ou que vous n utilisez plus. Ceci affecte tous vos personnages qui utilisent Pawn.", -- Needs review
		OptionsSocketingAdvisor = "Affiche les suggestions de ch\195\162sses", -- Needs review
		OptionsSocketingAdvisorTooltip = "Quand vous ajoutez des gemmes \195\160 un item, Pawn affichera les gemmes que vous pouvez ajouter \195\160 l item qui maximiseront sa puissance. (Pour voir la liste compl\195\168te de suggestion de gemme de chaque couleur, voir l onglet gemmes, ou vous pouvez aussi personnaliser la qualit\195\169 des gemmes \195\160 utiliser.)", -- Needs review
		OptionsTab = "Options", -- Needs review
		OptionsTooltipHeader = "infobulle des options", -- Needs review
		OptionsTooltipUpgradesOnly = "Affiche seulement les am\195\169liorations", -- Needs review
		OptionsTooltipUpgradesOnlyTooltip = "Ceci est l option la plus simple. affiche seulement le pourcentages d am\195\169lioration pour les items qui sont une am\195\169lioration de votre tenue actuelle, et indique quels items sont les meilleurs items que vous aillez pour chaque \195\169chelle (formule). n'affiche rien du tout pour les items plus faible.\
\
|cff8ec3e6Fire:|r  |TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t |cff00ff00+10% am\195\169lioration|r\
\
...ou...\
\
|cff8ec3e6Fire:  votre meilleur|r", -- Needs review
		OptionsTooltipValuesAndUpgrades = "Affiche les valeurs d echelle le le % d am\195\169lioration", -- Needs review
		OptionsTooltipValuesAndUpgradesTooltip = "Affiche les valeurs de Pawn pour toutes vos echelles visible sur tous les items, except\195\169 ceux qui ont une valeur de z\195\169ro. En plus, indique quels items sont une am\195\169lioration de votre tenue actuelle.\
\
|cff8ec3e6Frost:  123.4\
Fire:  156.7 |TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t |cff00ff00+10% am\195\169lioration|r", -- Needs review
		OptionsTooltipValuesOnly = "Affiche seulement les valeurs d echelles, pas les % d'am\195\169lioration", -- Needs review
		OptionsTooltipValuesOnlyTooltip = "Affiche les valeurs de Pawn pour toutes les echelles visible de chaque items, except\195\169 ceux qui ont une valeur de z\195\169ro. N indique pas quels items sont une am\195\169lioration \195\160 votre tenue actuelle. Cette option refl\195\168te le fonctionnement par d\195\169faut de plus anciennes versions de Pawn.\
\
|cff8ec3e6Frost:  123.4\
Fire:  156.7|r", -- Needs review
		OptionsUpgradeHeader = "affiche |TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t am\195\169liorations dans infobulle:", -- Needs review
		OptionsUpgradesForBothWeaponTypes = "Affiche les am\195\169liorations pour 1H et 2H", -- Needs review
		OptionsUpgradesForBothWeaponTypesTooltip = "Les suggesteurs d am\195\169lioration de Pawn devraient surveiller et afficher les am\195\169liorations pour les armes \195\160 deux mains et vos ambidextrie (ou pour jeteur de sorts, main droite et tenu(e) en main gauche), ensembles d armes s\195\169par\195\169ment.\
\
si valid\195\169, vous pourriez \195\170tre en train d utiliser une arme \195\160 deux mains et voir clairement les armes les armes \195\160 une main inf\195\169rieurs comme une am\195\169lioration si elles sont meilleur que le meilleur pr\195\169c\195\169dent (ou second meilleur) arme \195\160 une main que vous aviez, parce que Pawn surveille les am\195\169liorations s\195\169par\195\169ment pour les ensembles \195\160 deux armes.\
\
si non valid\195\169, \195\169quip\195\169 une arme \195\160 deux mains empechera Pawn d afficher vos am\195\169liorations pour les items tenu \195\160 une main et vice-versa.", -- Needs review
		OptionsWelcome = "Configurez Pawn de la fa\195\167on vous aimez. Les changements prendront effets imm\195\169diatement.", -- Needs review
		ScaleChangeColor = "change la couleur", -- Needs review
		ScaleChangeColorTooltip = "Change la couleur avec laquelle apparait le nom et la valeur dans l infobulle d un item", -- Needs review
		ScaleCopy = "copie", -- Needs review
		ScaleCopyTooltip = "cr\195\169e une nouvelle echelle en faisant une copie de celle ci.", -- Needs review
		ScaleDefaults = "d\195\169fauts", -- Needs review
		ScaleDefaultsTooltip = "cr\195\169e une nouvelle echelle en faisant une copie de celle par d\195\169faut", -- Needs review
		ScaleDeleteTooltip = "Efface cette echelle (formule)\
\
cette commande ne peut etre d\195\169faite!", -- Needs review
		ScaleEmpty = "Vide", -- Needs review
		ScaleEmptyTooltip = "cr\195\169e une nouvelle echelle \195\160 partir de rien.", -- Needs review
		ScaleExport = "export", -- Needs review
		ScaleExportTooltip = "Partage vos formules avec d'autres sur internet", -- Needs review
		ScaleHeader = "Gere vos echelles Pawn", -- Needs review
		ScaleImport = "importe", -- Needs review
		ScaleImportTooltip = "Ajoute une nouvelle \195\169chelle (formule) en collant une \195\137tiquette d'\195\169chelle d internet", -- Needs review
		ScaleNewHeader = "cr\195\169e une nouvelle \195\169chelle", -- Needs review
		ScaleRename = "renomme", -- Needs review
		ScaleRenameTooltip = "renomme cette \195\169chelle", -- Needs review
		ScaleSelectorHeader = "s\195\169lectionne une \195\169chelle:", -- Needs review
		ScaleSelectorShowScale = "Affiche l'echelle dans l infobulle", -- Needs review
		ScaleSelectorShowScaleTooltip = "Quand cette option est valid\195\169e, les valeurs pour cette \195\169chelle apparaitront dans l infobulle de ce personnage. chaque \195\169chelles peut apparaitre sur votre personnage, plusieurs personnages, ou aucuns personnages.", -- Needs review
		ScaleShareHeader = "Partager votre \195\169chelle (formule)", -- Needs review
		ScaleTab = "Echelle", -- Needs review
		ScaleTypeNormal = "Vous pouvez changer cette \195\169chelle dans l onglet Valeur.", -- Needs review
		ScaleTypeReadOnly = "Vous devez faire une copie de cette \195\169chelle (formule) si vous voulez la personnaliser.", -- Needs review
		ScaleWelcome = "Les \195\169chelles sont des ensembles de stats et de valeurs qui sont utilis\195\169es pour assigner des valeurs en points aux items. Vous pouvez personnaliser la votre ou utiliser ceux qu'ont cr\195\169er d autres personnes.", -- Needs review
		SocketingAdvisorButtonTooltip = "Clic pour ouvrir l onglet Gemmes de Pawn, ou vous pouvez trouver plus d informations sur les gemmes que Pawn recommende.", -- Needs review
		SocketingAdvisorHeader = "suggestions de Pawn pour les ch\195\162sses:", -- Needs review
		SocketingAdvisorIgnoreThisItem = "Ne vous emb\195\170tez pas gemmes ajout \195\160 ce point de bas niveau. Mais si vous le faites, les utiliser :", -- Needs review
		ValuesDoNotShowUpgradesFor1H = "Ne pas afficher d'am\195\169lioration pour les items a 1 main", -- Needs review
		ValuesDoNotShowUpgradesFor2H = "Ne pas afficher d'am\195\169lioration pour les items a 2 mains", -- Needs review
		ValuesDoNotShowUpgradesTooltip = "Permet cette option pour cacher les am\195\169liorations de ce type d item. par exemple, m\195\170me si les tanks paladin peuvent utiliser des armes a deux mains, une arme \195\160 deux mains n est jamais une \"am\195\169lioration\" pour un ensemble de paladin tank, aussi Pawn ne devrait pas afficher informations d am\195\169lioration pour eux. De m\195\170me, les Paladin Vindicte peuvent utiliser des armes a une main, mais ce n'est jamais une am\195\169lioration.", -- Needs review
		ValuesFollowSpecialization = "Affiche seulement les am\195\169liorations pour mon meilleur type d'armure apr\195\168s le niveau 50", -- Needs review
		ValuesFollowSpecializationTooltip = "Permet cette option pour cacher les am\195\169liorations d armure dans laquelle votre classe n est pas sp\195\169cialis\195\169 apr\195\168s le niveau 50. par exemple, au niveau 50 les Paladin Sacr\195\169 apprennent la sp\195\169cialisation plaque, ce qui augmente leur intelligence de 5% quand ils portent seulement de la plaque. quand cette option est choisie, Pawn ne tiendra jamais compte du tissu, cuir, ou maille comme des am\195\169liorations pour des paladins sacr\195\169 au dessus du niveau 50", -- Needs review
		ValuesHeader = "valeur d echelle pour %s", -- Needs review
		ValuesIgnoreStat = "Les items avec ceci sont inutilisable", -- Needs review
		ValuesIgnoreStatTooltip = "permettre cette option fait que chaque items avec cette stat n aura pas de valeur pour cette \195\169chelle. Par exemple, les shamans ne peuvent pas porter de la plaque, donc une \195\169chelle (formule) con\195\167ue pour un shaman peut marquer la plaque comme inutilisable ainsi les armures de plaques ne recevront aucune valeur", -- Needs review
		ValuesNormalize = "normalise les valeurs (comme Wowhead)", -- Needs review
		ValuesNormalizeTooltip = "Permet cette Option afin de diviser la valeur finale calcul\195\169e d un item par la somme de tous les stats dans votre \195\169chelle, comme Wowhead et lootzor le font. Cela aide dans des situations comme quand une \195\169chelle (formule) ont des valeurs de stat autour de 1 et une autre autour de 5. Ca aide aussi a garder des nombres petit", -- Needs review
		ValuesRemove = "Retire", -- Needs review
		ValuesRemoveTooltip = "retire cette stat de l echelle (formule)", -- Needs review
		ValuesTab = "valeur", -- Needs review
		ValuesWelcome = "Vous pouvez personnaliser les valeurs qui sont assign\195\169s \195\160 chaque stats pour cette \195\169chelle. Pour gerer vos \195\169chelles et en ajouter de nouvelles, utilisez l onglet Echelle", -- Needs review
		ValuesWelcomeNoScales = "Vous n avez s\195\169lectionn\195\169 aucune \195\169chelle. Pour commencer, aller a l onglet Echelle et concez une nouvelle ou coller une d internet", -- Needs review
		ValuesWelcomeReadOnly = "L echelle que vous avez s\195\169lectionn\195\169 ne peut etre modifi\195\169e. Si vous voulez changer ces valeurs, allez a l onglet Echelle et faites une copie de cette \195\169chelle ou commencez une nouvelle.", -- Needs review
	},
	Wowhead = {
		DeathKnightBloodTank = "DK: sang",
		DeathKnightFrostDps = "DK: givre",
		DeathKnightUnholyDps = "DK: impie", -- Needs review
		DruidBalance = "Druide: equilibre",
		DruidFeralDps = "Druide: feral",
		DruidFeralTank = "Druide: ours",
		DruidRestoration = "Druide: restauration",
		HunterBeastMastery = "Chasseur: b\195\170te",
		HunterMarksman = "Chasseur: pr\195\169cision",
		HunterSurvival = "Chasseur: survie",
		MageArcane = "Mage: arcanes",
		MageFire = "Mage: feu",
		MageFrost = "Mage: givre",
		MonkBrewmaster = "Moine: Ma\195\174tre brasseur",
		MonkMistweaver = "Moine: Tisse-brume",
		MonkWindwalker = "Moine: Marche-vent",
		PaladinHoly = "Paladin: sacr\195\169",
		PaladinRetribution = "Paladin: vindicte",
		PaladinTank = "Paladin: tank",
		PriestDiscipline = "Pr\195\170tre: discipline",
		PriestHoly = "Pr\195\170tre: sacr\195\169",
		PriestShadow = "Pr\195\170tre: ombre",
		Provider = "echelles Wowhead ", -- Needs review
		ProviderStarter = "Echelle de d\195\169marrage", -- Needs review
		RogueAssassination = "Voleur: assassinat",
		RogueCombat = "Voleur: combat",
		RogueSubtlety = "Voleur: finesse",
		ShamanElemental = "Chaman: el\195\169mentaire",
		ShamanEnhancement = "Chaman: am\195\169lioration",
		ShamanRestoration = "Chaman: restauration",
		WarlockAffliction = "D\195\169moniste: affliction",
		WarlockDemonology = "D\195\169moniste: d\195\169monologie",
		WarlockDestruction = "D\195\169moniste: destruction",
		WarriorArms = "Guerrier: armes",
		WarriorFury = "Guerrier: fureur",
		WarriorTank = "Guerrier: tank",
	},
}
end

if GetLocale() == "frFR" then
	PawnUseThisLocalization()
end

-- After using this localization or deciding that we don't need it, remove it from memory.
PawnUseThisLocalization = nil
