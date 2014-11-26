-- Pawn by Vger-Azjol-Nerub
-- www.vgermods.com
-- © 2006-2014 Green Eclipse.  This mod is released under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 license.
-- See Readme.htm for more information.

-- 
-- Brazilian Portuguese resources
------------------------------------------------------------

local function PawnUseThisLocalization()
PawnLocal =
{
	AsteriskTooltipLine = "|TInterface\\AddOns\\Pawn\\Textures\\Question:0|t Efeitos especiais não incluído no valor.", -- Needs review
	AverageItemLevelIgnoringRarityTooltipLine = "Nível de item médio", -- Needs review
	BackupCommand = "backup", -- Needs review
	BaseValueWord = "base", -- Needs review
	CogwheelName = "Engrenagem", -- Needs review
	CopyScaleEnterName = "Digite o nome para sua nova esclaa, uma copia de %s:", -- Needs review
	CorrectGemsValueCalculationMessage = "   -- Gemas corretas valeriam: %g", -- Needs review
	CrystalOfFearName = "Cristal do Medo", -- Needs review
	DebugOffCommand = "debug off", -- Needs review
	DebugOnCommand = "debug on", -- Needs review
	DeleteScaleConfirmation = "Você quer mesmo deletar %s? Isso não pode ser desfeito. Digite \"%s\" para confirmar:", -- Needs review
	DidntUnderstandMessage = "   (?) Não entendi \"%s\".", -- Needs review
	EnchantedStatsHeader = "(Valor atual)", -- Needs review
	EngineeringName = "Engenharia", -- Needs review
	ExportAllScalesMessage = "Pressione Ctrl+C para copiar a tag da sua escala, crie um arquivo no seu computador para backup, então pressione Ctrl+V para colar nele.", -- Needs review
	ExportScaleMessage = "Pressione Ctrl+C para copiar as seguintes tag de escalas para |cffffffff%s|r, e então pressione Ctrl+V para colar depois.", -- Needs review
	FailedToGetItemLinkMessage = "   Erro ao pegar o link do tooltip.  Isso pode ser devido conflito de mods.", -- Needs review
	FailedToGetUnenchantedItemMessage = "   Erro ao pegar valores base de items.  Isso pode ser devido conflito de mods.", -- Needs review
	FoundStatMessage = "   %d %s", -- Needs review
	GemColorList1 = "%d %s", -- Needs review
	GemColorList2 = "%d %s ou %s", -- Needs review
	GemColorList3 = "%d de qualquer cor", -- Needs review
	GenericGemLink = "|Hitem:%d|h[Gema %d]|h", -- Needs review
	GenericGemName = "(Gema %d)", -- Needs review
	HiddenScalesHeader = "Outras escalas", -- Needs review
	ImportScaleMessage = "Pressione Ctrl+V para colar a tag de escala que você copiou de outra fonte aqui:", -- Needs review
	ImportScaleTagErrorMessage = "Pawn não entende essa tag de escala.  Você copiou a tag inteira?  Tente copiar e colar de novo:", -- Needs review
	ItemIDTooltipLine = "ID do Item", -- Needs review
	ItemLevelTooltipLine = "Nível do Item", -- Needs review
	LootUpgradeAdvisorHeader = "Clique para comparar com seus items.|n", -- Needs review
	LootUpgradeAdvisorHeaderMany = "|TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t Este item é um upgrade para %d escalas.  Clique para comparar com seus items.", -- Needs review
	MissocketWorthwhileMessage = "   -- Mas é melhor usar somente %s gemas:", -- Needs review
	NeedNewerVgerCoreMessage = "Pawn precisa de uma versão nova do VgerCore.  Por favor use a versão do VgerCore que veio com Pawn.", -- Needs review
	NewScaleDuplicateName = "Uma escala com esse nome já existe.  Digite o nome para sua escala:", -- Needs review
	NewScaleEnterName = "Digite o nome para sua escala:", -- Needs review
	NewScaleNoQuotes = "Uma escala não pode ter \" no nome.  Digite o nome para sua escala:", -- Needs review
	NormalizationMessage = "   -- Normalizado por dividir por %g", -- Needs review
	NoScale = "(nenhuma)", -- Needs review
	NoScalesDescription = "Para começar, importe uma escala ou comece uma nova.", -- Needs review
	NoStatDescription = "Escolha um atributo da lista na esquerda.", -- Needs review
	Or = "ou", -- Needs review
	RenameScaleEnterName = "Digite um nome para %s:", -- Needs review
	SocketBonusValueCalculationMessage = "   -- Bonus de engaste valeria: %g", -- Needs review
	StatNameText = "1 |cffffffff%s|r vale:", -- Needs review
	TooltipBestAnnotation = "%s  |cff8ec3e6(melhor)|r", -- Needs review
	TooltipBestAnnotationSimple = "%s  seu melhor", -- Needs review
	TooltipBigUpgradeAnnotation = "%s  |TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t|cff00ff00 upgrade%s|r", -- Needs review
	TooltipSecondBestAnnotation = "%s  |cff8ec3e6(segundo melhor)|r", -- Needs review
	TooltipSecondBestAnnotationSimple = "%s  seu segundo melhor", -- Needs review
	TooltipUpgradeAnnotation = "%s  |TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t|cff00ff00+%.0f%% upgrade%s|r", -- Needs review
	TooltipUpgradeFor1H = "para sets 1 Mão", -- Needs review
	TooltipUpgradeFor2H = "para 2 Mãos", -- Needs review
	TooltipVersusLine = "%s|n  vs. |c%s%s|r", -- Needs review
	TotalValueMessage = "   ---- Total: %g", -- Needs review
	UnenchantedStatsHeader = "(Valor base)", -- Needs review
	Unusable = "(não utilizável)", -- Needs review
	UnusableStatMessage = "   -- %s é inútil, então pare.", -- Needs review
	Usage = [=[
Pawn por Vger-Azjol-Nerub
www.vgermods.com

/pawn -- mostra ou esconde a janela do Pawn
/pawn debug [ on | off ] -- mostra mensagens de debug no console do chat
/pawn backup -- backup todas as suas tags de escala
 
Para mais informações em personalizar o Pawn, favor veja o arquivo de ajuda (Readme.htm) que vem com o mod.]=], -- Needs review
	ValueCalculationMessage = "   %g %s x %g cada = %g", -- Needs review
	VisibleScalesHeader = "%s's scales", -- Needs review
	Stats = {
		AgilityInfo = "O atributo primário, Agilidade.", -- Needs review
		Ap = "Poder de ataque", -- Needs review
		ApInfo = "Attack power.  Não está presente nos itens diretamente.  Não inclui poder de ataque que você recebe de Força ou Agilidade.", -- Needs review
		ArmorInfo = "Armadura, não importa que tipo de item.  Não distingue entre armadura base ou bonus de armadura desde que items com bonus de armadura são obsoletos.", -- Needs review
		ArmorTypes = "Tipos de armaduras", -- Needs review
		AvoidanceInfo = "Avoidance.  Reduces the damage you take from area-of-effect attacks.", -- Requires localization
		BonusArmorInfo = "Bonus armor.  Does not include the base armor value on all armor.  This number should always be at least as high as the value for Armor.",
		Cloth = "Tecido", -- Needs review
		ClothInfo = "Pontos para distribuir se o item é tecido.", -- Needs review
		Crit = "Crítico", -- Needs review
		CritInfo = "Ataque crítico.  Afeta ataques de perto, ataques de longe, e magias.", -- Needs review
		DpsInfo = "Danos por segundo da Arma.  (Se você quer valores de DPS diferentes para tipos de armas diferentes, veja a seção \"Atributos especiais de armas\".)", -- Needs review
		HasteInfo = "Aceleração.  Afeta ataques corpo-a-corpo, ataques de longo alcance, e magias.", -- Needs review
		IndestructibleInfo = "Indestructible.  Prevents your equipment from taking durability damage.", -- Requires localization
		IndestructibleIs = "Being |cffffffffindestructible|r is worth:", -- Requires localization
		IntellectInfo = "Atributo Primário, Intelecto", -- Needs review
		Leather = "Atributo - Variáveis usadas pela listra mestre de atributos na aba Valores.", -- Needs review
		LeatherInfo = "Pontos para distribuir se o item for couro.", -- Needs review
		LeechInfo = "Leech.  Causes your attacks and healing spells to restore your health.", -- Requires localization
		Mail = "Atributos - Variáveis utilizadas pelas listas de atributos mestres na aba de Valores.", -- Needs review
		MailInfo = "Pontos para distribuir se o item for malha.", -- Needs review
		MasteryInfo = "Maestria.  Melhora o bônus único da especialização da sua classe", -- Needs review
		MetaSocket = "Engase metagema", -- Needs review
		MetaSocketInfo = "Um engaste metagema, vazio ou preenchido. Coloque pontos extras para capacetes que que tem engaste metagema para compensar efeitos especiais nas gemas metagemas,", -- Needs review
		MinorStats = "Minor stats", -- Requires localization
		MovementSpeedInfo = "Movement speed.  Causes your character to run faster.", -- Requires localization
		MultistrikeInfo = "Multistrike.  Increases the chance that your attacks and healing spells will hit your target two extra times at reduced potency.", -- Requires localization
		Plate = "Placa", -- Needs review
		PlateInfo = "Pontos para distribuir se o item for placa.", -- Needs review
		PrimaryStats = "Status primários", -- Needs review
		PvPPower = "Poder JxJ", -- Needs review
		PvPPowerInfo = "Poder JxJ. Faz com que suas habilidades causem mais dano para outros jogadores (mas não para criaturas), e suas habilidades de cura curem outros jogadores para mais em algumas situações JxJ.", -- Needs review
		PvPResilience = "Resiliência JxJ", -- Needs review
		PvPResilienceInfo = "Resiliência JxJ.  Reduz o dano que você recebe de ataques de outros jogadores.  Somente efetivo em partidas contra outros jogadores.", -- Needs review
		PvPStats = "Status JxJ", -- Needs review
		SecondaryStats = "Secondary stats", -- Requires localization
		Shield = "Escudo", -- Needs review
		ShieldInfo = "Pontos para distribuir se o item for um escudo.", -- Needs review
		Sockets = "Engastes", -- Needs review
		SpecialWeaponStats = "Status especiais de armas", -- Needs review
		SpeedBaseline = "Velocidade base", -- Needs review
		SpeedBaselineInfo = "Não é atributo.  Este número é subtraído do Atributo Velocidade antes de multiplicar pelo valor da escala.", -- Needs review
		SpeedBaselineIs = "|cffffffffVelocidade base|r é:", -- Needs review
		SpeedInfo = "Velocidade da arma, em golpes por segundo.  (Se você prefere armas mais rápidas, este número deve ser negativo.  Veja também: \"velocidade base\" na seção \"Status especiais de armas\")", -- Needs review
		SpeedIs = "1 segundo |cffffffffvelocidade do golpe|r vale:", -- Needs review
		SpellPower = "Poder mágico", -- Needs review
		SpellPowerInfo = "Poder mágico.  Presente em armas de feitiço e em algumas armaduras.  Não inclui o poder mágico que você adquire com Intelecto.", -- Needs review
		SpiritInfo = "Atributo primário, Espírito.", -- Needs review
		StaminaInfo = "Atributo primário, Vigor.", -- Needs review
		StrengthInfo = "Atributo primário, Força.", -- Needs review
		VersatilityInfo = "Versatility.  Increases damage dealt for damage characters, increases healing done by healing characters, and reduces damage taken for tank characters.", -- Requires localization
		WeaponMainHandDps = "Mão Principal: DPS", -- Needs review
		WeaponMainHandDpsInfo = "Danos por segundo da arma, somente para armas de uma mão principal.", -- Needs review
		WeaponMainHandMaxDamage = "Mão Principal: dano maximo", -- Needs review
		WeaponMainHandMaxDamageInfo = "Dano máximo da arma, somente para armas de uma mão principal.", -- Needs review
		WeaponMainHandMinDamage = "Arma Principal: dano mínimo", -- Needs review
		WeaponMainHandMinDamageInfo = "Dano mínimo da arma, somente para armas de uma mão principal.", -- Needs review
		WeaponMainHandSpeed = "Arma Principal: velocidade", -- Needs review
		WeaponMainHandSpeedInfo = "Velocidade da arma, somente para armas de uma mão principal.", -- Needs review
		WeaponMaxDamage = "Dano máximo", -- Needs review
		WeaponMaxDamageInfo = "Dano máximo de arma", -- Needs review
		WeaponMeleeDps = "Corpo-a-corpo: DPS", -- Needs review
		WeaponMeleeDpsInfo = "Dano por segundo de arma, somente para armas corpo-a-corpo", -- Needs review
		WeaponMeleeMaxDamage = "Corpo-a-corpo: Dano máximo", -- Needs review
		WeaponMeleeMaxDamageInfo = "Dano máximo de arma, somente para armas de corpo-a-corpo.", -- Needs review
		WeaponMeleeMinDamage = "Corpo-a-corpo: dano mínimo", -- Needs review
		WeaponMeleeMinDamageInfo = "Dano mínimo de arma, somente para armas corpo-a-corpo.", -- Needs review
		WeaponMeleeSpeed = "Corpo-a-corpo: velocidade", -- Needs review
		WeaponMeleeSpeedInfo = "Velocidade da arma, somente para armas corpo-a-corpo.", -- Needs review
		WeaponMinDamage = "Dano mínimo", -- Needs review
		WeaponMinDamageInfo = "Dano mínimo de arma", -- Needs review
		WeaponOffHandDps = "Mão Secundária: DPS", -- Needs review
		WeaponOffHandDpsInfo = "Dano por segundo de arma, somente para armas de mão secundária.", -- Needs review
		WeaponOffHandMaxDamage = "Mão Secundária: dano máximo", -- Needs review
		WeaponOffHandMaxDamageInfo = "Damo máximo de arma, somente para armas de mão secundária.", -- Needs review
		WeaponOffHandMinDamage = "Mão Secundária: dano mínimo", -- Needs review
		WeaponOffHandMinDamageInfo = "dano mínimo de arma, somente para armas de mão secundária.", -- Needs review
		WeaponOffHandSpeed = "Mão Secundária: velocidade", -- Needs review
		WeaponOffHandSpeedInfo = "Velocidade de arma, somente para armas de mão secundária.", -- Needs review
		WeaponOneHandDps = "Uma mão: DPS", -- Needs review
		WeaponOneHandDpsInfo = "Dano por segundo de arma, somente para armas marcadas como uma mão, não sendo mão principal nem mão secundária.", -- Needs review
		WeaponOneHandMaxDamage = "Uma mão: dano máximo", -- Needs review
		WeaponOneHandMaxDamageInfo = "Dano máximo de arma, somente para armas marcadas como uma mão, não sendo mão principal nem mão secundária.", -- Needs review
		WeaponOneHandMinDamage = "Uma mão: dano mínimo", -- Needs review
		WeaponOneHandMinDamageInfo = "Dano mínimo de arma, somente para armas marcadas como uma mão, não sendo mão principal nem mão secundária.", -- Needs review
		WeaponOneHandSpeed = "Uma mão: velocidade", -- Needs review
		WeaponOneHandSpeedInfo = "Velocidade da arma, somente para armas marcadas como uma mão, não sendo mão principal nem mão secundária.", -- Needs review
		WeaponRangedDps = "Longo alcance: DPS", -- Needs review
		WeaponRangedDpsInfo = "Dano por segundo de arma, somente para armas de longo alcance.", -- Needs review
		WeaponRangedMaxDamage = "Longo alcance: dano máximo", -- Needs review
		WeaponRangedMaxDamageInfo = "Dano máximo de arma, somente para armas de longo alcance.", -- Needs review
		WeaponRangedMinDamage = "Longo alcance: dano mínimo", -- Needs review
		WeaponRangedMinDamageInfo = "Dano mínimo de arma, somente para armas de longo alcance.", -- Needs review
		WeaponRangedSpeed = "Longo alcance: velocidade", -- Needs review
		WeaponRangedSpeedInfo = "Velocidade da arma, somente para armas de longo alcance.", -- Needs review
		WeaponStats = "Atributos de arma", -- Needs review
		WeaponTwoHandDps = "Duas mãos: DPS", -- Needs review
		WeaponTwoHandDpsInfo = "Dano por segundo de arma, somente para armas de duas mãos.", -- Needs review
		WeaponTwoHandMaxDamage = "Duas mãos: dano máximo", -- Needs review
		WeaponTwoHandMaxDamageInfo = "Dano máximo de arma, somente para armas de duas mãos.", -- Needs review
		WeaponTwoHandMinDamage = "Duas mãos: dano mínimo", -- Needs review
		WeaponTwoHandMinDamageInfo = "Dano mínimo de arma, somente para armas de duas mãos.", -- Needs review
		WeaponTwoHandSpeed = "Duas mãos: velocidade", -- Needs review
		WeaponTwoHandSpeedInfo = "Velocidade da arma, somente para armas de duas mãos.", -- Needs review
		WeaponType1HAxe = "Machado: uma mão", -- Needs review
		WeaponType1HAxeInfo = "Pontos para distribuir se o item for um machado de uma mão.", -- Needs review
		WeaponType1HMace = "Maça: uma mão", -- Needs review
		WeaponType1HMaceInfo = "Pontos para distribuir se o item for uma maça de uma mão.", -- Needs review
		WeaponType1HSword = "Espada: uma mão", -- Needs review
		WeaponType1HSwordInfo = "Pontos para distribuir se o item for uma espada de uma mão.", -- Needs review
		WeaponType2HAxe = "Machado: duas mãos", -- Needs review
		WeaponType2HAxeInfo = "Pontos para distribuir se o item for um machado de duas mãos.", -- Needs review
		WeaponType2HMace = "Maça: duas mãos", -- Needs review
		WeaponType2HMaceInfo = "Pontos para distribuir se o item for uma ma;ca de duas mãos", -- Needs review
		WeaponType2HSword = "Espada: duas mãos", -- Needs review
		WeaponType2HSwordInfo = "Pontos para distribuir se o item for uma espada de duas mãos.", -- Needs review
		WeaponTypeBow = "Arco", -- Needs review
		WeaponTypeBowInfo = "Pontos para distribuir se o item for um arco.", -- Needs review
		WeaponTypeCrossbow = "Besta", -- Needs review
		WeaponTypeCrossbowInfo = "Pontos para distribuir se o item for uma besta.", -- Needs review
		WeaponTypeDagger = "Adaga", -- Needs review
		WeaponTypeDaggerInfo = "Pontos para distribuir se o item for uma adaga.", -- Needs review
		WeaponTypeFistWeapon = "Arma de punho", -- Needs review
		WeaponTypeFistWeaponInfo = "Pontos para distribuir se o item for uma arma de punho", -- Needs review
		WeaponTypeFrill = "Acessórios de mão secundária", -- Needs review
		WeaponTypeFrillInfo = "Pontos para distribuir se o item é um acessório do tipo \"Empunhado na mão secundária\".  Não aplica a escudo ou armas.", -- Needs review
		WeaponTypeGun = "Arma", -- Needs review
		WeaponTypeGunInfo = "Pontos para distribuir se o item for uma arma.", -- Needs review
		WeaponTypeOffHand = "Arma de mão secundária", -- Needs review
		WeaponTypeOffHandInfo = "Pontos para distribuir se o item for qualquer arma que pode ser empunhada na mão secundária. Não aplica a acessórios, escudos, ou armas que pode ser equipadas em ambas as mãos.", -- Needs review
		WeaponTypePolearm = "Armas de Haste", -- Needs review
		WeaponTypePolearmInfo = "Pontos para distribuir se o item for uma arma de haste.", -- Needs review
		WeaponTypes = "Tipos de armas", -- Needs review
		WeaponTypeStaff = "Cajado", -- Needs review
		WeaponTypeStaffInfo = "Pontos para distribuir se o item for um cajado.", -- Needs review
		WeaponTypeWand = "Varinha", -- Needs review
		WeaponTypeWandInfo = "Pontos para distribuir se o item for uma varinha.", -- Needs review
	},
	TooltipParsing = {
		Agility = "^%+?([-%d%.,]+) d?e? ?Agilidade$", -- Needs review
		AllStats = "^%+?([%d%.,]+) em Todos os [aA]tributos$", -- Needs review
		Ap = "^%+?([%d%.,]+) d?e? ?Poder de ataque$", -- Needs review
		Armor = "^%+?([%d%.,]+) Armadura$", -- Needs review
		Armor2 = "^%+?([%d%.,]+) de Armadura$", -- Needs review
		Avoidance = "^%+([%d%.,]+) Avoidance$", -- Requires localization
		Axe = "^Machado$", -- Needs review
		BagSlots = "^%d+ Compartimento .+$", -- Needs review
		BladesEdgeMountains = "^Montanhas da Lâmina Afiada$", -- Needs review
		BonusArmor = "^%+([%d%.,]+) Bonus Armor$", -- Requires localization
		Bow = "^Arco$", -- Needs review
		ChanceOnHit = "Chance ao acertar:", -- Needs review
		Charges = "^.+ Cargas?$", -- Needs review
		Cloth = "^Tecido$", -- Needs review
		CooldownRemaining = "^Tempo de recarga restante:", -- Needs review
		Crit = "^%+?([%d%.,]+) Acerto Crítico%.?$", -- Needs review
		Crit2 = "^%+?([%d%.,]+) de Acerto Crítico%.?$", -- Needs review
		Crossbow = "^Besta$", -- Needs review
		Dagger = "^Adaga$", -- Needs review
		Design = "Desenho:", -- Needs review
		DisenchantingRequires = "^Desencantamento necessita", -- Needs review
		Dodge = "^%+?([%d%.,]+) Esquiva$", -- Needs review
		Dodge2 = "^%+?([%d%.,]+) de Esquiva$", -- Needs review
		Dps = "^%(([%d%.,]+) d?e? ?dano por segundo%)$", -- Needs review
		DpsAdd = "^Adiciona ([%d%.,]+) dano por segundo$", -- Needs review
		Duration = "^Dura%ç%ão:", -- Needs review
		Elite = "^Elite$",
		EnchantmentArmorKit = "^Armadura %(%+([%d%.,]+) Refor%çada%)$", -- Needs review
		EnchantmentCounterweight = "^Contrapeso %(%+([%d%.,]+) Acelera&ç&ão%)", -- Needs review
		EnchantmentFieryWeapon = "^Arma Ígnea$", -- Needs review
		EnchantmentHealth = "^%+([%d%.,]+) Vida$", -- Needs review
		EnchantmentHealth2 = "^%+([%d%.,]+) de Vida$", -- Needs review
		EnchantmentLivingSteelWeaponChain = "^Corrente de Arma de Aço Viva$", -- Needs review
		EnchantmentPyriumWeaponChain = "^Corrente de Arma de Pírio$", -- Needs review
		EnchantmentTitaniumWeaponChain = "^Corrente de Arma de Titânico$", -- Needs review
		Equip = "Equipar:", -- Needs review
		FistWeapon = "^Arma de Punho$", -- Needs review
		Flexible = "^Flexible$", -- Requires localization
		Formula = "Fórmula:", -- Needs review
		Gun = "^Arma$", -- Needs review
		Haste = "^%+?([%d%.,]+) Aceleração$", -- Needs review
		Haste2 = "^%+?([%d%.,]+) de Aceleração$", -- Needs review
		HeirloomLevelRange = "^Requer nível %d+ to (%d+)", -- Needs review
		HeirloomXpBoost = "^Equipar: Experiência obtida", -- Needs review
		HeirloomXpBoost2 = "^UNUSED$", -- Needs review
		Heroic = "^Heroico$",
		HeroicElite = "^Heroico de Elite$",
		HeroicThunderforged = "^Forjado pelo Trovão Heroico$", -- Needs review
		HeroicWarforged = "^Forjado para a Guerra Heroico$", -- Needs review
		Hp5 = "^Equipar: Restaura ([%d%.,]+) pontos de vida a cada 5 s%.$", -- Needs review
		Hp52 = "^Equipar: Recupera ([%d%.,]+) pontos de vida a cada 5 s%.$", -- Needs review
		Hp53 = "^Recupera %+?([%d%.,]+) [pP]ontos [dD]e [vV]ida [aA] [cC]ada 5 [sS]%.?$", -- Needs review
		Hp54 = "^UNUSED$", -- Needs review
		Intellect = "^%+?([-%d%.,]+) d?e? ?Intelecto$", -- Needs review
		Leather = "^Couro$", -- Needs review
		Leech = "^%+([%d%.,]+) Leech$", -- Requires localization
		Mace = "^Ma%ça$", -- Needs review
		Mail = "^Correio$", -- Needs review
		Manual = "Manual:", -- Needs review
		Mastery = "^%+?([%d%.,]+) Maestria$", -- Needs review
		Mastery2 = "^%+?([%d%.,]+) de Maestria$", -- Needs review
		MetaGemRequirements = "|cff%x%x%x%x%x%xRequer", -- Needs review
		MovementSpeed = "^%+([%d%.,]+) Speed$", -- Requires localization
		MultiStatSeparator1 = "e", -- Needs review
		Multistrike = "^%+([%d%.,]+) Multistrike$", -- Requires localization
		NormalizationEnchant = "^Encantado: (.*)$", -- Needs review
		OnlyFitsInMetaGemSlot = "^\"Encaixa%-se apenas em um engaste metagema%.\"$", -- Needs review
		Parry = "^%+?([%d%.,]+) Aparo$", -- Needs review
		Parry2 = "^%+?([%d%.,]+) de Aparo$", -- Needs review
		Pattern = "Molde:", -- Needs review
		Plans = "Instruções:", -- Needs review
		Plate = "^Placas$", -- Needs review
		Polearm = "^Arma de Haste$", -- Needs review
		PvPPower = "^%+?([%d%.,]+) d?e? ?Poder JxJ$", -- Needs review
		RaidFinder = "^Localizador de Raides$",
		Recipe = "Receita:", -- Needs review
		Requires2 = "^UNUSED$", -- Needs review
		Resilience = "^%+?([%d%.,]+) Resiliência JxJ$", -- Needs review
		Resilience2 = "^%+?([%d%.,]+) de Resiliência JxJ$", -- Needs review
		Schematic = "Diagrama:", -- Needs review
		Scope = "^Mira %(%+([%d%.,]+) de Dano%)$", -- Needs review
		ScopeCrit = "^Mira %(%+([%d%.,]+) Acerto Crítico%)$", -- Needs review
		ScopeRangedCrit = "^%+?([%d%.,]+) Acerto Crítico de Longo Alcance$", -- Needs review
		Season = "^Série ", -- Needs review
		ShadowmoonValley = "^Vale da Lua Negra$", -- Needs review
		Shield = "^Escudo$", -- Needs review
		SocketBonusPrefix = "Bônus de engaste: ", -- Needs review
		Speed = "^Velocidade ([%d%.,]+)$", -- Needs review
		Speed2 = "^UNUSED$", -- Needs review
		SpellPower = "^%+?([%d%.,]+) d?e? ?Poder [mM]ágico$", -- Needs review
		Spirit = "^%+?([-%d%.,]+) d?e? ?Espírito$", -- Needs review
		Staff = "^Cajado$", -- Needs review
		Stamina = "^%+?([-%d%.,]+) d?e? ?Vigor$", -- Needs review
		Strength = "^%+?([-%d%.,]+) d?e? ?Força$", -- Needs review
		Sword = "^Espada$", -- Needs review
		TempestKeep = "^Bastilha da Tormenta$", -- Needs review
		TemporaryBuffMinutes = "^.+%(%d+ min%)$", -- Needs review
		TemporaryBuffSeconds = "^.+%(%d+ s%)$", -- Needs review
		Thunderforged = "^Forjado pelo Trovão$", -- Needs review
		Timeless = "^Timeless$", -- Requires localization
		UpgradeLevel = "^Nível de aprimoramento:", -- Needs review
		Use = "Usar:", -- Needs review
		Versatility = "^%+([%d%.,]+) Versatility$", -- Requires localization
		Wand = "^Varinha$", -- Needs review
		Warforged = "^Forjado para a Guerra$", -- Needs review
		WeaponDamage = "^([%d%.,]+) %- ([%d%.,]+) de Dano$", -- Needs review
		WeaponDamageArcane = "^%+?([%d%.,]+) %- ([%d%.,]+) de [dD]ano Arcano$", -- Needs review
		WeaponDamageEnchantment = "^%+?([%d%.,]+) [dD]ano de [aA]rma$", -- Needs review
		WeaponDamageEquip = "^%+?([%d%.,]+) [dD]ano de [aA]rma%.$", -- Needs review
		WeaponDamageExact = "^%+?([%d%.,]+) Dano$", -- Needs review
		WeaponDamageFire = "^%+?([%d%.,]+) %- ([%d%.,]+) [dD]ano de [dF]ogo$", -- Needs review
		WeaponDamageFrost = "^%+?([%d%.,]+) %- ([%d%.,]+) [dD]ano [dD]e [gG]elo.$", -- Needs review
		WeaponDamageHoly = "^%+?([%d%.,]+) %- ([%d%.,]+) [dD]ano [sS]agrado$", -- Needs review
		WeaponDamageNature = "^%+?([%d%.,]+) %- ([%d%.,]+) [dD]ano [dD]e [nN]atureza$", -- Needs review
		WeaponDamageShadow = "^%+?([%d%.,]+) %- ([%d%.,]+) [dD]ano [dD]e [sS]ombra$", -- Needs review
	},
	UI = {
		AboutHeader = "Sobre Pawn", -- Needs review
		AboutReadme = "Novato no Pawn?  Veja a aba começando para uma introdução básica.", -- Needs review
		AboutTab = "Sobre", -- Needs review
		AboutTranslation = "Português traduzido por Maxmag-Goldrinn magnodias.maxmag@gmail.com", -- Needs review
		AboutVersion = "Versão %s", -- Needs review
		AboutWebsite = [=[Para outros mods por Vger, visite vgermods.com.

Escalas/Ponderação do Wowhead usados com permissão—Favor direcionar feedback nos valores padrões do Wowhead.]=], -- Needs review
		CompareClearItems = "Limpar", -- Needs review
		CompareClearItemsTooltip = "Remover ambos itens da comparação.", -- Needs review
		CompareCogwheelSockets = "Engastes de engrenagem", -- Needs review
		CompareColoredSockets = "Engastes coloridos", -- Needs review
		CompareEquipped = "Equipado", -- Needs review
		CompareGemTotalValue = "Valor das gemas", -- Needs review
		CompareHeader = "Comparar itens usando %s", -- Needs review
		CompareMetaSockets = "Engastes metagema", -- Needs review
		CompareOtherHeader = "Outro", -- Needs review
		CompareShaTouchedSockets = "Tocado Pelo Sha", -- Needs review
		CompareSlotEmpty = "(sem item)", -- Needs review
		CompareSocketBonus = "Bonus de engaste", -- Needs review
		CompareSocketsHeader = "Engastes", -- Needs review
		CompareSpecialEffects = "Efeitos especiais", -- Needs review
		CompareSwap = "‹ Troca ›", -- Needs review
		CompareSwapTooltip = "Troca o item da esquerda pelo da direita.", -- Needs review
		CompareTab = "Comparar", -- Needs review
		CompareVersus = "—vs.—", -- Needs review
		CompareWelcomeLeft = "Primeiro, pegue uma escala da lista na esquerda.", -- Needs review
		CompareWelcomeRight = [=[Então, solte um item nessa caixa.

Você pode comparar ele versus seus itens atuais usando os ícones no canto inferior-esquerdo.]=], -- Needs review
		CompareYourBest = "Seu melhor", -- Needs review
		GemsColorHeader = "%s gemas", -- Needs review
		GemsHeader = "Gemas para %s", -- Needs review
		GemsNoneFound = "Nenhuma gema apropriada foi encontrada.", -- Needs review
		GemsQualityLevel = "Nível de qualidade da gema", -- Needs review
		GemsQualityLevelTooltip = [=[O nível do item que deve ser sugerido gemas.

Exemplo, se for "463", então o Pawn vai mostrar gemas que são apropriadas para uso de item nível 463: loot de masmorras heróicas do Mists of Pandaria.]=], -- Needs review
		GemsShowBest = "Motrar melhores gemas disponíveis", -- Needs review
		GemsShowBestTooltip = "Mostra as melhores gemas disponíveis para a escala atualmente selecionada.  Algumas dessas gemas vão ser muito poderosas para engastar em items de baixa qualidade.", -- Needs review
		GemsShowForItemLevel = "Mostrar gemas recomendadas pelo nível do item:", -- Needs review
		GemsShowForItemLevelTooltip = "Mostra as gemas que o Pawn recomenda para a escala atualmente selecionada e um item de nível específico.", -- Needs review
		GemsTab = "Gemas", -- Needs review
		GemsWelcome = "Selecione uma escala do lado direito para ver as gemas que Pawn recomenda.", -- Needs review
		HelpHeader = "Bem-vindo ao Pawn!", -- Needs review
		HelpTab = "Começando", -- Needs review
		HelpText = [=[Pawn calcula pontos em seus items baseados nos atributos que o item tem.  Ele usa esses pontos para determinar qual dos seus items são melhor, e pada identificar items que podem dar upgrade no seu equipamento.


Cada item vai ter um ponto para cada "escala" que é ativa no seu personagem.  Uma escala lista os atributos importantes para você, e mostra como cada ponto vale no atributo.  Você geralmente vai ter uma escala para cada especialização da sua classe.  Os pontos são geralmente ocultos, mas você pode ver como a pontuação do item é calculada na aba Comparar.

 • Você pode habilitar uma escala ou não fazendo Shift+Clique na lista que fica na aba de Escalas.


Pawn vem com escalas do Wowhead para cada Classe e Especialização.  Você também pode criar seu próprio distribuindo pontos em cada atributo, importar escalas da internet ou ferramentas de simulação, ou compartilhar escalas com seu grupo ou guilda.

|cff8ec3e6Tente esses recursos assim que você aprender o básico:|r
 • Comparar os status de dois items usando a aba Comparar do Pawn.
 • Clique-direito em um link de item para ver como ele faz a comparação do seu item atual.
 • Shift-Clique em um item com engastes para o Pawn sugerir gemas para ele.
 • Faça a cópia de uma escala na aba de Escalas, e personalize o valores de atributos na aba Valores.
 • Ache mais escalas para sua classe na internet.
 • Verifique o arquivo leia-me para aprender mais sobre as características avançadas do Pawn.]=], -- Needs review
		InterfaceOptionsBody = "Clique no botão do Pawn para abri-lo.  Você pode também abrir o Pawn da página do seu inventário, ou colocando uma tecla de atalho.", -- Needs review
		InterfaceOptionsWelcome = "Opções do Pawn são encontradas na janela do Pawn.", -- Needs review
		InventoryButtonTooltip = "Clique para abrir Pawn.", -- Needs review
		InventoryButtonTotalsHeader = "Total para todos items equipados:", -- Needs review
		KeyBindingCompareItemLeft = "Comparar item (esquerda)", -- Needs review
		KeyBindingCompareItemRight = "Comparar item (direita)", -- Needs review
		KeyBindingShowUI = "Alternar janela do Pawn", -- Needs review
		OptionsAdvisorHeader = "Opções do Assessor", -- Needs review
		OptionsAlignRight = "Alinhar valores para o canto direito do tooltip", -- Needs review
		OptionsAlignRightTooltip = "Habilite isso para alinhar os valores do Pawn e atualizar informação para o canto direito do tooltip ao invés da esquerda.", -- Needs review
		OptionsBlankLine = "Adicione uma linha em branco antes dos valores", -- Needs review
		OptionsBlankLineTooltip = "Mantem o tooltip dos items extra menor habilitanto essa opção, que adiciona uma linha em branco antes dos valores do Pawn.", -- Needs review
		OptionsButtonHidden = "Esconder", -- Needs review
		OptionsButtonHiddenTooltip = "Não mostrar o botão do Pawn na janela de Informações do personagem.", -- Needs review
		OptionsButtonPosition = "Mostrar o botão do Pawn:", -- Needs review
		OptionsButtonPositionLeft = "No lado esquerdo", -- Needs review
		OptionsButtonPositionLeftTooltip = "Mostrar o botão do Pawn no canto inferior-esquerdo na janela de Informações do Personagem.", -- Needs review
		OptionsButtonPositionRight = "No lado direito", -- Needs review
		OptionsButtonPositionRightTooltip = "Mostrar o botão do Pawn no canto inferior-direito na janela de Informações do Personagem.", -- Needs review
		OptionsColorBorder = "Colorir a borda do tooltip nos upgrades", -- Needs review
		OptionsColorBorderTooltip = "Habilite essa opção para mudar a cor da borda do tooltip dos items que tem upgrades para verde.  Desabilite se isso interfere com outros mods que mudam a borda dos tooltips.", -- Needs review
		OptionsCurrentValue = "Mostrar ambos valores atuais e valores base", -- Needs review
		OptionsCurrentValueTooltip = [=[Habilite essa opção para que o Pawn mostre dois valores para items: o valor atual, que reflete no estado atual de um item com valores atuais de gemas, encantamentos, e reforja que o item tem no momento, com engastes vazios que não fornecem benefício, adicionando os valores base, que é o que o Pawn normalmente mostra.  O valor atual vai ser mostrado antes do valor atual.  Esta opção não tem efeito a não ser que você habilite mostrar valores de items nos tooltips.

Você deve continuar usando os valores base para determinar entre dois items no fim-do-jogo, mas o valor atual pode ser útil quando subindo de nível e para facilitar em decidir qual que vale mais imediatamente equipando um novo item antes que tenha gemas ou encantamentos.]=], -- Needs review
		OptionsDebug = "Mostrar informação de debug", -- Needs review
		OptionsDebugTooltip = [=[Se você não está certo de como Pawn calcula os valores de um item particular, habilite esta opção para Pawn mostrar todos tipo de dados 'úteis' para o console do chat sempre que passar o mouse sobre um item.  Esta informação inclui que atributos o Pawn acha que o ítem tem, que partes de item Pawn não entende, e como cada um entrou no calculo para a sua escala.

Esta opção vai preencher o seu registro de chat rapidamente, então você deve desliga-lo assim que você terminar de investigar.

Atalhos:
/pawn debug on
/pawn debug off]=], -- Needs review
		OptionsHeader = "Ajustar opções do Pawn", -- Needs review
		OptionsIgnoreGemsWhileLevelingCheck = "Ignore sockets on low-level items", -- Requires localization
		OptionsIgnoreGemsWhileLevelingCheckTooltip = [=[Enable this option to have Pawn ignore sockets on low-level items when calculating item values, since most people do not go to the effort or expense of socketing items while still leveling.  A "low-level" item is one weaker than what can be obtained in a heroic dungeon at the level cap.

If checked, Pawn's socketing advisor will still suggest appropriate gems for low-level items, but sockets will be ignored in calculations and socketed items will not show up as upgrades as often.

If unchecked, Pawn will calculate values for items as if they were socketed in the way that maximizes the item's value, regardless of the item's level.]=], -- Requires localization
		OptionsInventoryIcon = "Mostrar ícones de inventário", -- Needs review
		OptionsInventoryIconTooltip = "Habilite esta opção para mostrar ícones de inventário próximo ao link de janela de item.", -- Needs review
		OptionsItemIDs = "Mostrar ID de items", -- Needs review
		OptionsItemIDsTooltip = [=[Habilite esta opção para o Pawn mostrar o ID de cada item que você ver, como também ID de todos encantamentos e gemas.

Cada item no World of Warcraft tem um número de ID associado a ele.  Esta informação é geralmente somente útil para criadores de mod.]=], -- Needs review
		OptionsLootAdvisor = "Mostrar Assessor de upgrade de Items", -- Needs review
		OptionsLootAdvisorTooltip = "Quando um item cai de uma masmorra e é um upgrade para seu personagem, Pawn vai mostrar uma popup anexada a janela de loot dizendo para você sobre o upgrade.", -- Needs review
		OptionsOtherHeader = "Outras opções", -- Needs review
		OptionsQuestUpgradeAdvisor = "Mostrar Assessor de upgrade de missão", -- Needs review
		OptionsQuestUpgradeAdvisorTooltip = "No histórico de missões enquanto você fala com um 'NPC', se alguma recompensa de quest é um upgrade para seu equipamente, Pawn vai mostrar uma seta verde no item.  Se nenhum item é upgrade, Pawn vai mostrar uma pilha de ouro mostrando que este item vale mais ser vendido para um vendedor.", -- Needs review
		OptionsResetUpgrades = "Re-escanear", -- Needs review
		OptionsResetUpgradesTooltip = [=[Pawn vai esquecer o que conhece sobre seus melhores items que você equipou e re-escanear seu equipamento para promover informações de upgrade no futuro.

Use esta característica se você achar que o Pawn está fazendo sugestões de upgrades incorretas como resultado de items que você vendeu, destruiu ou não usa mais.  Isto vai afetar todos os personagens que usam Pawn.]=], -- Needs review
		OptionsSocketingAdvisor = "Mostrar Assessor de engastes", -- Needs review
		OptionsSocketingAdvisorTooltip = "Quando adicionar gemas em um item, Pawn vai mostrar uma popup sugerindo gemas que você pode engastar em um item que irá melhora-lo.  (Para ser a lista completa de sugestões para cada cor, veja a aba Gemas, onde você também pode alterar a qualidade das gemas que ira utilizar.)", -- Needs review
		OptionsTab = "Opções", -- Needs review
		OptionsTooltipHeader = "Opções de tooltip", -- Needs review
		OptionsTooltipUpgradesOnly = "Somente mostrar upgrades", -- Needs review
		OptionsTooltipUpgradesOnlyTooltip = [=[Esta é a opção mais simples.  Somente mostra porcentagem de upgrade de um item para seu equipamento, e indica quais items são melhores para sua própria escala.  Não mostra nada sobre items fracos.

|cff8ec3e6Fire:|r  |TInterface\AddOns\Pawn\Textures\UpgradeArrow:0|t |cff00ff00+10% upgrade|r

...ou...

|cff8ec3e6Fogo:  seu melhor|r]=], -- Needs review
		OptionsTooltipValuesAndUpgrades = "Mostrar valores de escala e % de upgrade", -- Needs review
		OptionsTooltipValuesAndUpgradesTooltip = [=[Mostra valores do Pawn em todas as escalas visíveis em todos os items, exceto naqueles que tem um valor de zero.  Também indica quais items são upgrades para seu equipamento atual.

|cff8ec3e6Gelo:  123.4
Fogo:  156.7 |TInterface\AddOns\Pawn\Textures\UpgradeArrow:0|t |cff00ff00+10% upgrade|r]=], -- Needs review
		OptionsTooltipValuesOnly = "Mostrar somente valores de escala, sem % de upgrade", -- Needs review
		OptionsTooltipValuesOnlyTooltip = [=[Mostra valores do Pawn em todas as escalas visíveis em todos os items, exceto naqueles que tem um valor de zero.  Não indica quais items são upgrades para seu equipamento atual.

|cff8ec3e6Gelo:  123.4
Fire:  156.7|r]=], -- Needs review
		OptionsUpgradeHeader = "Mostrar |TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t upgrades nos tooltips:", -- Needs review
		OptionsUpgradesForBothWeaponTypes = "Mostrar upgrades para ambas armas de uma mão e duas mãos", -- Needs review
		OptionsUpgradesForBothWeaponTypesTooltip = [=[Pawn assessor de upgrade deve monitorar e sugerir upgrades para armas de duas mãos e dupla de arma (ou para magos, arma de mão principal e enfeites de mão secundária) sets de armas separados.

Se marcado, você pode estar usando uma arma de duas mãos e claramente ver armas de uma mão como upgrades se eles são melhores (ou segundo melhores) da sua arma de uma mão anterior, porque Pawn monitora upgrades separadamente para sets de duas armas.

Se desmarcado, equpar uma arma de duas mãos vai prevenir que Pawn mostra upgrades para armas de uma mão e vice-versa.]=], -- Needs review
		OptionsWelcome = "Configure Pawn do jeito que deseja.  Mudanças terão efeito imediatamente.", -- Needs review
		ScaleChangeColor = "Mudar cor", -- Needs review
		ScaleChangeColorTooltip = "Mudar a cor de nome e valores da escala que aparecem nos tooltips.", -- Needs review
		ScaleCopy = "Copiar", -- Needs review
		ScaleCopyTooltip = "Criar uma nova escala copiando esta.", -- Needs review
		ScaleDefaults = "Padrões", -- Needs review
		ScaleDefaultsTooltip = "Criar uma nova escala fazendo uma cópia dos padrões.", -- Needs review
		ScaleDeleteTooltip = [=[Deletar esta escala.

Este comando não pode ser desfeito]=], -- Needs review
		ScaleEmpty = "Vazia", -- Needs review
		ScaleEmptyTooltip = "Cria uma nova escala em branco.", -- Needs review
		ScaleExport = "Exportar", -- Needs review
		ScaleExportTooltip = "Compartilhe sua escala com outros na internet.", -- Needs review
		ScaleHeader = "Gerenciar suas escalas do Pawn", -- Needs review
		ScaleImport = "Importar", -- Needs review
		ScaleImportTooltip = "Adicionar uma nova escala colando outra tag de escala da internet.", -- Needs review
		ScaleNewHeader = "Criar uma nova escala", -- Needs review
		ScaleRename = "Renomear", -- Needs review
		ScaleRenameTooltip = "Renomeia esta escala.", -- Needs review
		ScaleSelectorHeader = "Selecione uma escala:", -- Needs review
		ScaleSelectorShowScale = "Mostrar escala nos tooltips", -- Needs review
		ScaleSelectorShowScaleTooltip = [=[Quando esta opção esta marcada, valores para cada escala vão ser mostrados no tooltips de items para este personagem.  Cada esclaa pode mostrar até uma para cada um do seu personagem, multiplos personagens, ou nenhum personagem,

Atalho: Shift+clique em uma escala]=], -- Needs review
		ScaleShareHeader = "Compartilhar suas escalas", -- Needs review
		ScaleTab = "Escala", -- Needs review
		ScaleTypeNormal = "Você pode mudar esta escala na aba Valores", -- Needs review
		ScaleTypeReadOnly = "Você deve fazer uma cópia desta escala se você quiser personaliza-la.", -- Needs review
		ScaleWelcome = "Escalas que são conjunto de atributos e valores usados para distribuir pontos em items.  Você pode personalizaor seu próprio ou usar valores de escala que outros criaram.", -- Needs review
		SocketingAdvisorButtonTooltip = "Clique para abrir a aba de Gemas do Pawn, onde você pode encontrar mais informação sobre gemas que o Pawn recomenda.", -- Needs review
		SocketingAdvisorHeader = "Pawn Assessor de engaste sugere:", -- Needs review
		SocketingAdvisorIgnoreThisItem = "Don't bother adding gems to this low-level item.  But if you do, use these:", -- Requires localization
		ValuesDoNotShowUpgradesFor1H = "Não mostrar upgrades para armas de uma mão", -- Needs review
		ValuesDoNotShowUpgradesFor2H = "Não mostrar upgrades para armas de duas mãos", -- Needs review
		ValuesDoNotShowUpgradesTooltip = "Habilite esta opção para esconder upgrades deste tipo de item.  Exemplo, mesmo se tankers paladinos podem usar armas de duas mãos, uma arma de duas mãos nunca é um upgrade para um set tanker de paladino, então Pawn não deve mostrar notificações de ugprade para ele.  Similarmente, paladinos retribuição podem usar armas de uma mão, mas nunca serão upgrades.", -- Needs review
		ValuesFollowSpecialization = "Somente mostrar upgrades para meu melhor tipo de armadura depois do nível 50", -- Needs review
		ValuesFollowSpecializationTooltip = "Habilite esta opção para esconder ugprades para armaduras que sua classe não tem especialização depois do nível 50.  Exemplo, um nível 50 paladino sagrado aprende especialização em placa, que aumenta seu intelecto em 5% usando somente armaduras de placa.  Quando esta opção é marcada Pawn nunca vai considerar tecido, couro ou malha para upgrades em paladinos sagrados acima de nível 50.", -- Needs review
		ValuesHeader = "Escalar valores para %s", -- Needs review
		ValuesIgnoreStat = "Items com isso não são usáveis", -- Needs review
		ValuesIgnoreStatTooltip = "Habilite esta opção para causar qualquer item com este atributo não pegar valores para esta escala.  Por exemplo, xamãs nao podem usar placas, então uma escala desenhada para xamã pode marcar placa com não usável e armaduras de placa não pegam valores para esta escala.", -- Needs review
		ValuesNormalize = "Normalizar valores (como Wowhead)", -- Needs review
		ValuesNormalizeTooltip = [=[Habilite esta opção para dividir o valor de calculo final para um item de mesma soma para todos valores de atribudos na escala, como Wowhead e Lootzor fazem.  Isto ajuda em situações em que atributos perto de 1 e outros valores perto de 5.  Também ajuda manter números pequenos.

Para mais informação nesta opção, veja o arquivo leia-me.]=], -- Needs review
		ValuesRemove = "Remover", -- Needs review
		ValuesRemoveTooltip = "Remover este atributo da escala.", -- Needs review
		ValuesTab = "Valores", -- Needs review
		ValuesWelcome = "Você pode personalizar os valores que são designados para cada atributo nesta escala.  Para genreciar esta escala e adicionar novos, use a aba Escalas.", -- Needs review
		ValuesWelcomeNoScales = "Você pode não ter uma escala selecionada.  Para começar, vá para a aba de Escala e comece uma nova escala ou cole uma da internet.", -- Needs review
		ValuesWelcomeReadOnly = "A escala que você selecionou não pode ser mudada.  Se você quer mudar os valores, vá para a aba Escala e crie uma cópia desta escala ou comece uma nova.", -- Needs review
	},
	Wowhead = {
		DeathKnightBloodTank = "Cavaleiro da Morte: sangue", -- Needs review
		DeathKnightFrostDps = "Cavaleiro da Morte: gelo", -- Needs review
		DeathKnightUnholyDps = "Cavaleiro da Morte: profano", -- Needs review
		DruidBalance = "Druida: equilíbrio", -- Needs review
		DruidFeralDps = "Druida: feral", -- Needs review
		DruidFeralTank = "Druida: guardião", -- Needs review
		DruidRestoration = "Druida: restauração", -- Needs review
		HunterBeastMastery = "Caçador: domínio das feras", -- Needs review
		HunterMarksman = "Caçador: precisão", -- Needs review
		HunterSurvival = "Caçador: sobrevivência", -- Needs review
		MageArcane = "Mago: arcano", -- Needs review
		MageFire = "Mago: fogo", -- Needs review
		MageFrost = "Mago: gelo", -- Needs review
		MonkBrewmaster = "Monge: mestre cervejeiro", -- Needs review
		MonkMistweaver = "Monge: tecelão da névoa", -- Needs review
		MonkWindwalker = "Monge: andarilho do vento", -- Needs review
		PaladinHoly = "Paladino: sagrado", -- Needs review
		PaladinRetribution = "Paladino: retribuição", -- Needs review
		PaladinTank = "Paladino: tanker", -- Needs review
		PriestDiscipline = "Sacerdote: disciplina", -- Needs review
		PriestHoly = "Sacerdote: sagrado", -- Needs review
		PriestShadow = "Sacerdote: sombra", -- Needs review
		Provider = "Escalas do Wowhead", -- Needs review
		ProviderStarter = "Starter scales", -- Requires localization
		RogueAssassination = "Ladino: assassinato", -- Needs review
		RogueCombat = "Ladino: combate", -- Needs review
		RogueSubtlety = "Ladino: subterfúgio", -- Needs review
		ShamanElemental = "Xamã: elemental", -- Needs review
		ShamanEnhancement = "Xamã: aperfeiçoamento", -- Needs review
		ShamanRestoration = "Xamã: restauração", -- Needs review
		WarlockAffliction = "Bruxo: suplício", -- Needs review
		WarlockDemonology = "Bruxo: demonologia", -- Needs review
		WarlockDestruction = "Bruxo: destruição", -- Needs review
		WarriorArms = "Guerreiro: armas", -- Needs review
		WarriorFury = "Guerreiro: fúria", -- Needs review
		WarriorTank = "Guerreiro: tanker", -- Needs review
	},
}
end

if GetLocale() == "ptBR" then
	PawnUseThisLocalization()
end

-- After using this localization or deciding that we don't need it, remove it from memory.
PawnUseThisLocalization = nil
