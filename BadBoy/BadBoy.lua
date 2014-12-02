
-- GLOBALS: BADBOY_NOREPORT, BADBOY_POPUP, BADBOY_BLACKLIST, BadBoyLog, BNGetNumFriends, BNGetNumFriendToons, BNGetFriendToonInfo
-- GLOBALS: CanComplainChat, ChatFrame1, GetTime, print, REPORT_SPAM_CONFIRMATION, ReportPlayer, StaticPopup_Show, StaticPopup_Resize
-- GLOBALS: strsplit, tonumber, type, UnitInParty, UnitInRaid, ChatHistory_GetAccessID, CalendarGetDate, SetCVar
local myDebug = false

local reportMsg = "BadBoy: >>> |cfffe2ec8|Hbadboy:%s:%d:%d:%s|h[Spam blocked, click to report!]|h|r <<<"
local throttleMsg = "|cFF33FF99BadBoy|r: Please wait ~7 seconds between reports to prevent being disconnected (Blizzard bug)"
do
	local L = GetLocale()
	if L == "frFR" then
		reportMsg = "BadBoy: >>> |cfffe2ec8|Hbadboy:%s:%d:%d:%s|h[Spam bloqué, cliquez pour signaler !]|h|r <<<"
		throttleMsg = "|cFF33FF99BadBoy|r: Veuillez patienter ~7 secondes entre les signalements afin d'éviter d'être déconnecté (bug de Blizzard)"
	elseif L == "deDE" then
		reportMsg = "BadBoy: >>> |cfffe2ec8|Hbadboy:%s:%d:%d:%s|h[Spam geblockt, zum Melden klicken!]|h|r <<<"
		throttleMsg = "|cFF33FF99BadBoy|r: Bitte warte ca. 7 Sekunden zwischen Meldungen um einen Disconnect zu verhindern (Blizzard Bug)"
	elseif L == "zhTW" then
		reportMsg = "BadBoy: >>> |cfffe2ec8|Hbadboy:%s:%d:%d:%s|h[發出的垃圾訊息已被阻擋, 點擊以舉報 !]|h|r <<<"
		throttleMsg = "|cFF33FF99BadBoy|r: 請等候~7秒在回報時，為了防止斷線(暴雪的bug)"
	elseif L == "zhCN" then
		reportMsg = "BadBoy: >>> |cfffe2ec8|Hbadboy:%s:%d:%d:%s|h[垃圾信息已被阻挡，点击举报!]|h|r"
		throttleMsg = "|cFF33FF99BadBoy|r: 请在举报时等待~7 秒以防断线（暴雪的bug）"
	elseif L == "esES" then
		reportMsg = "BadBoy: >>> |cfffe2ec8|Hbadboy:%s:%d:%d:%s|h[Spam bloqueado. Clic para informar!]|h|r <<<"
		throttleMsg = "|cFF33FF99BadBoy|r: Por favor espere ~7 segundos entre los informes para evitar que se desconecte (error de Blizzard)"
	elseif L == "esMX" then
		reportMsg = "BadBoy: >>> |cfffe2ec8|Hbadboy:%s:%d:%d:%s|h[Spam bloqueado. Clic para informar!]|h|r <<<"
		throttleMsg = "|cFF33FF99BadBoy|r: Por favor espere ~7 segundos entre los informes para evitar que se desconecte (error de Blizzard)"
	elseif L == "ruRU" then
		reportMsg = "BadBoy: >>> |cfffe2ec8|Hbadboy:%s:%d:%d:%s|h[Спам заблокирован. Нажмите, чтобы сообщить!]|h|r <<<"
		throttleMsg = "|cFF33FF99BadBoy|r: Пожалуйста, подождите ~7 секунды между донесениями, чтобы избежать отключения (ошибка Blizzard)"
	elseif L == "koKR" then

	elseif L == "ptBR" then
		reportMsg = "BadBoy: >>> |cfffe2ec8|Hbadboy:%s:%d:%d:%s|h[Spam bloqueado, clique para denunciar!]|h|r <<<"
		throttleMsg = "|cFF33FF99BadBoy|r: Por favor aguarde ~7 segundos entre denúncias para evitar ser desconectado (erro de Blizzard)"
	elseif L == "itIT" then
		reportMsg = "BadBoy: >>> |cfffe2ec8|Hbadboy:%s:%d:%d:%s|h[Spam bloccata, clic qui per riportare!]|h|r <<<"
		throttleMsg = "|cFF33FF99BadBoy|r: Prego aspetta ~7 secondi tra una segnalazione e l'altra per far si che tu non venga disconnesso (bug della Blizzard)"
	end
end

--These entries add +1 point
local commonList = {
	--English
	"bonus",
	"buy",
	"cheap",
	"code",
	"coupon",
	"customer",
	"deliver",
	"discount",
	"express",
	"g[0o]ld",
	"lowest",
	"order",
	"powerle?ve?l",
	"price",
	"promoti[on][gn]",
	"reduced",
	"rocket",
	"sa[fl]e",
	"server",
	"service",
	"stock",
	"trusted",
	"well?come",

	--French
	"livraison", --delivery
	"moinscher", --least expensive
	"prix", --price
	"commande", --order

	--German
	"billigster", --cheapest
	"lieferung", --delivery
	"preis", --price
	"willkommen", --welcome

	--Spanish
	"barato", --cheap
	"gratuito", --free
	"rapid[oe]", --fast [[ esES:rapido / frFR:rapide ]]
	"seguro", --safe/secure
	"servicio", --service

	--Chinese
	"金币", --gold currency
	"大家好", --hello everyone

	--Russian
	"з[o0]л[o0]т[ao0]", --gold
	"гoлд", --gold
	"дocтaвкa", --delivery
	"cкидкa", --discount [russian]
	"oплaт", --payment [russian]
	"пpoдaжa", --sale [serbian]
	"нaличии", --stock/presence
	"цeнe", --price [serbian]
	"пoкупкe", --buy/buying/purchase [russian]
	"купи", --buy [serbian]
	"быcтpo", --fast/quickly
	"ищemпocтaвщикoв", --ищем поставщиков --looking for suppliers
}

--These entries add +2 points
local heavyList = {
	"[\226\130\172%$\194\163]+%d+.?%d*[fp][oe]r%d+[%.,]?%d*[kg]", --Add separate line if they start approx prices
	"[\226\130\172%$\194\163]+%d+[%.,]?%d*[/\\=]%d+[%.,]?%d*[kg]",
	"%d+[%.,]?%d*eur?o?s?[fp][oe]r%d+[%.,]?%d*[kg]",
	"%d+[%.,]?%d*[\226\130\172%$\194\163]+[/\\=>]+%d+[%.,]?%d*[kg]",
	"%d+[%.,]?%d*[kg][/\\=][\226\130\172%$\194\163]+%d+",
	"%d+[%.,]?%d*[kg][/\\=]%d+[%.,]?%d*[\226\130\172%$\194\163]+",
	"%d+[%.,]?%d*[kg][/\\=]%d+[%.,]?%d*e[uv]",
	"%d+[%.,]?%d*[kg][%.,]?only%d+[%.,]?%d*eu",
	"%d+[%.,]?%d*[kg]for%d+[%.,]?%d*eu",
	"%d+o?[kg][/\\=]%$?%d+[%.,]%d+", --1OK=9.59
	"%d+[%.,]?[%do]*[/\\=]%d+[%.,]?%d*[kge]",
	"%d+[%.,]?%d*eur?[o0]?s?[/\\=<>]+%d+[%.,]?[%do]*[kg]",
	"%d+[%.,]?%d*eur?[o0]?s?[/\\=<>]+l[0o]+[kg]",
	"%d+[%.,]?%d*usd[/\\=]%d+[%.,]?%d*[kg]",
	"%d+[%.,]?%d*usd[fp][oe]r%d+[%.,]?%d*[kg]",
	"%d+[%.,]?%d*[kg][/\\=]%d+[%.,]?%d*usd",
	"%d+[%.,]?[o%d]*[kg]%d+bonus[/\\=]%d+[%.,]?[o%d]+",
	"%d+[%.,]?%d*[кp]+зa%d+[%.,]?%d*[pк]+", --14к за 21р / 17р за 1к
}

--These entries add +2 points, but only 1 entry will count
local heavyRestrictedList = {
	"www[%.,]",
	"[%.,]c[%.,]*[o0@][%.,]*m",
	"[%.,]net",
	"dotc[o0@]m",
}

--These entries add +1 point, but only 1 entry will count
local restrictedIcons = {
	"{%l%l%d}",
	"{цp%d}",
	"{star}",
	"{circle}",
	"{diamond}",
	"{triangle}",
	"{moon}",
	"{square}",
	"{cross}",
	"{x}",
	"{skull}",
	"{diamant}",
}

--These entries add +1 point to the phishing count
local phishingList = {
	--English
	"account",
	"blizz",
	"claim",
	"congratulations",
	"free",
	"gamemaster",
	"gift",
	"investigat", --investigate/investigation
	"launch",
	"log[io]n",
	"luckyplayer",
	"mount",
	"pleasevisit",
	"receive",
	"service",
	"surprise",
	"suspe[cn][td]", --suspect/suspend
	"system",
	"validate",

	--German
	"berechtigt", --entitled
	"erhalten", --get/receive
	"deaktiviert", --deactivated
	"konto", --acount
	"kostenlos", --free
	"qualifiziert", --qualified
}

local boostingList = {
	"paypal",
	"skype",
	"boost",
	"arena",
	"rbg",
	"service",
	"cheap",
	"gold",
	"fast",
	"safe",
	"price",
	"account",
	"rating",
	"test",
	"legal",
	"guarantee",
	"m[o0]unt",
	"sale",
	"season",
	"professional",
}
local boostingWhiteList = {
	"members",
	"guild",
	"social",
	"%d+k", --10k/dungeon
	"onlyacceptinggold",
	"goldonly",
	"goldprices",
	"tonight",
	"gametime",
	"servertime",
}

--These entries remove -2 points
local whiteList = {
	"%.battle%.net/",
	"recrui?t",
	"dkp",
	"lookin?g", --guild
	"lf[gm]",
	"|cff",
	"raid",
	"roleplay",
	"appl[iy]", --apply/application
	"contender", --Contender's Silk
	"enjin%.com",
	"guildlaunch%.com",
	"corplaunch%.com",
	"wowlaunch%.com",
	"wowstead%.com",
	"guildwork.com",
	"guildportal%.com",
	"guildomatic%.com",
	"guildhosting.org",
	"%.wix%.com",
	"shivtr%.com",
	"own3d%.tv",
	"ustream%.tv",
	"twitch%.tv",
	"social",
	"fortunecard",
	"house",
	"progres",
	"transmor?g",
	"arena",
	"boost",
	"player",
	"portal",
	"town",
	"vialofthe",
	"synonym",
	"[235]v[235]",
	"sucht", --de
	"gilde", --de
	"rekryt", --se
	"soker", --se
	"kilta", --fi
	"etsii", --fi
	"sosyal", --tr
	"дкп", --ru, dkp
	"peкpут", --ru, recruit
	"нoвoбpaн", --ru, recruits
	"лфг", --ru, lfg
	"peйд", --ru, raid
}

--Any entry here will instantly report/block
local instantReportList = {
	--[[  Personal Whispers  ]]--
	"so?rr?y.*%d+[kg].*stock.*buy", --sry to bother, we have 60k g in stock today. do u wanna buy some?:)
	"server.*purchase.*gold.*deliv", --sorry to bother,currently we have 29200g on this server, wondering if you might purchase some gold today? 15mins delivery:)
	"free.*powerleveling.*level.*%d+.*interested", --Hello there! I am offering free powerleveling from level 70-80! Perhaps you are intrested? :)v
	"friend.*price.*%d+k.*gold", --dear friend.. may i tell you the price for 10k wow gold ?^^
	"we.*%d+k.*stock.*realm", --hi, we got 25k+++ in stock on this realm. r u interested?:P
	"we.*%d+k.*gold.*buy", --Sorry to bother. We got around 27.4k gold on this server, wondering if you might buy some quick gold with face to face trading ingame?
	"so?rr?y.*interest.*cheap.*gold", --sorry to trouble you , just wondering whether you have  any interest in getting some cheap gold at this moment ,dear dude ? ^^
	"we.*%d+k.*stock.*interest", --hi,we have 40k in stock today,interested ?:)
	"we.*%d%d%d+g.*stock.*price", --hi,we have the last 23600g in stock now ,ill give you the bottom price.do u need any?:D
	"hi.*%d%d+k.*stock.*interest", --hi ,30k++in stock any interest?:)
	"wondering.*you.*need.*buy.*g.*so?r?ry", --I am sunny, just wondering if you might need to buy some G. If not, sry to bother.:)
	"buy.*wow.*curr?ency.*deliver", --Would u like to buy WOW CURRENCY on our site?:)We deliver in 5min:-)
	"interest.*%d+kg.*price.*delive", --:P any interested in the last 30kg with the bottom price.. delivery within 5 to 10 mins:)
	"sorr?y.*bother.*another.*wow.*account.*use", --Hi,mate,sorry to bother,may i ask if u have another wow account that u dont use?:)
	"hello.*%d%d+k.*stock.*buy.*now", --hello mate :) 40k stock now,wanna buy some now?^^
	"price.*%d%d+g.*sale.*gold", --Excuse me. Bottom price!.  New and fresh 30000 G is for sale. Are you intrested in buying some gold today?
	"so?rr?y.*you.*tellyou.*%d+k.*wow.*gold", --sorry to bother you,may i tell you how much for 5k wow gold
	"excuse.*do.*need.*buy.*wow.*gold", --Excuse me,do u need to buy some wowgold?
	"bother.*%d%d%d+g.*server.*quick.*gold", --Sry to bother you, We have 57890 gold on this server do you want to purchase some quick gold today?
	"hey.*interest.*some.*fast.*%d+kg.*left", --hey,interested in some g fast?got 27kg left atm:)
	"know.*need.*buy.*gold.*delivery", --hi,its kitty here. may i know if you need to buy some quick gold today. 20-50 mins delivery speed,
	"may.*know.*have.*account.*don.*use", -- Hi ,May i know if you have an useless account that you dont use now ? :)
	"company.*le?ve?l.*char.*%d%d.*free", --our company  can lvl your char to lvl 80 for FREE.
	"so?r?ry.*need.*cheap.*gold.*%d+", --sorry to disurb you. do you need some cheap gold 20k just need 122eur(108GBP)
	"stock.*gold.*wonder.*buy.*so?rr?y", --Full stock gold! Wondering you might wanna buy some today ? sorry for bothering you.
	"hi.*you.*need.*gold.*we.*promotion", --[hi.do] you need some gold atm?we now have a promotion for it ^^

	--[[  Casino  ]]--
	"%d+.*d[ou][ub]ble.*%d+.*trip", --10 minimum 400 max\roll\61-97 double, 98-100 triple, come roll,
	"casino.*%d+x2.*%d+x3", --{star} CASINO {star} roll 64-99x2 your wager roll 100x3 your wager min bet 50g max 10k will show gold 100% legit (no inbetween rolls plz){diamond} good luck {diamond}
	"casino.*%d+.*double.*%d+.*tripp?le", --The Golden Casino is offering 60+ Doubles, and 80+ Tripples!
	"casino.*whisper.*info", --<RollReno's Casino> <Whisper for more information!>
	"d[ou][ub]ble.*%d+.*tripp?le", --come too the Free Roller  gaming house!  and have ur luck of winning gold! :) pst me for invite:)  double is  62-96 97-100 tripple we also play blackjack---- u win double if you beat the host in blackjack
	"casino.*bet.*%d+", --Casino time. You give me your bet, Than You roll from 1-11 unlimited times.Your rolls add up. If you go over 21 you lose.You can stop before 21.When you stop I do the same, and if your closer to 21 than me than you get back 2 times your bet
	"roll.*%d+.*roll.*%d+.*bet", --Roll 63+ x2 , Roll 100 x3, Roll 1 x4 NO MAX BETS
	"casino.*roll.*double", --CASINO IS BACK IN TOWN COME PAY ME ROLL +65 AND GET DOUBLE
	"casino.*roll.*%d+.*roll.*%d+", --Casino is back in town !! Roll over 65 + and get your gold back 2X !!  Roll 100 and get your gold back 3X !!
	"double.*tripp?le.*casino", --Hey there wanna double your money in casino? or triple or even quad it? give me a whisp if you want to join my casino :)
	"casino.*legit.*safe.*casino", --LEGIT CASINO IN TRADE DESTRICT! /w * for a legit and safe casino!
	"luck.*roll.*%d+k.*minutes.*pst", --test your luck. all you gotta do is roll. make 1-100k+ in minutes. pst for details.
	"roll.*win.*double.*min.*max", --Game 2 Roll Wars. Trade wager then roll. We both rol. Highest Roll wins. If you win ill double your wager 500g Minimum 5k Maximum

	--[[  Runescape Trading  ]]--
	--WTB RS gold paying WoW GOLD
	--WTT RS3 Gold to Wow Gold (i want wow gold) pm for info
	"wt[bst]rs3?gold.*wowgold", --WTB rs gold trading wow gold PST
	"wt[bs]wowgold.*rsgold", --WTS Wow gold for rs gold
	"wt[bs]wowgold.*rscoint?s", --WTS Wow gold for rs coints
	--WTS RUNESCAPE GOLD !~!~!~ PST
	--WTB RUNESCAPE GOLD WITH WOW GOLD PST
	"wt[bs]runescapegold", --WTB Runescape Gold, Trading WOW Gold, PST -- I will trade first.
	"exchangingrsgold", --Exchanging RS gold for WoW gold. I have 400m PST
	--WTS level 25 guild with 80k gold for runescape gold
	"goldforrunescapegold", --Exchanging WoW gold for Runescape gold pst me better price for higher amount.
	--Buying runescape account! :D Add me on skype "*"
	"buying?runescape[ag]", --buyin runescape g
	"wt[bs]runescapeaccount", --WTB runescape accounts ( pure only ) or money! i pay with wow gold. GOT 170k gold atm.
	"wt[bs]runescapepure", --WTB runescape pure ( STR PURE IS A $$ PAYING EXTRA FOR STR PURE )!
	--WTB big amount of runescape money. 2mil = 1k gold. ONLY LEGIT PEOPLE.
	"wt[bs].*runescapemoney.*%d+k", --WTB runescape money. 3mil = 1k in wow! easy money making.
	"^wt[bs]rsaccount", --wts rs acount 10k .... lvl 95 with items for over 15 mil with 6 year old holiday
	"^wt[bs]%d+rsaccount", --WTS 137 RS ACCOUNT /W ME
	--WTS awesome rs account with 99's /w me
	--WTS an awesome rs account /w me details
	"^wt[bs]a?n?awesomersaccount", --wts awesome rs account /w me
	"runescapegoldforwowgold", --Selling my runescape gold for wow gold

	--[[ CS:GO ]]--
	"^wt[bst]somecsgoskin", --WTB some CSGO skins and sell some /w for more info
	--WTS CS:GO Skins
	"^wt[bst]csgoskin", --WTB CS GO skins /w for more infomation
	"^wt[bst]csgokey", --{rt1} WTB CS:GO KEYS & SKINS FOR GOLD {rt1}
	"^wt[bst]csgoacc", --WTS CS GO ACC UNRANK
	"^wt[bst]csgoknife", --WTSCS GO knife M9 Bayonet Stained in (minimal wear) /w and give me offer
	"^wt[bst]csgoitem", --WTB CS:GO Items for Gold! /W me your items!!
	"^wt[bst]anycsgoskin", --{rt1} WTB ANY CS:GO SKINS FOR WOW GOLD {rt1}
	"^buyingcsgoskin", --{rt1}{rt3} Buying CS:GO Skins & Keys for WoW Gold | Paying good  {rt3}{rt1}
	"^sellingsomecsgocase", --Selling some CS:GO cases! PM ME!
	"^sellingcsgocase", --Selling CS:GO cases! PM ME!
	"^sellingcsgoitem", --{rt1} SELLING CS GO ITEMS FOR GOLD {rt1}

	--[[ Hearthstone ]]--
	"^sellinghearthstonebeta", --SELLING HEARTHSTONE BETA KEY FOR GOLD /w ME YOUR PRICE
	"^wtshearthstonebeta", --WTS Hearthstone beta, whisper offers people! :)

	--[[  SC 2 ]]--
	"^wtsstarcraft.*cdkey.*gold", --WTS Starcraft Heart of Swarm cd key for wow golds.

	--[[  Dota 2 ]]--
	"^sellingdota2", --Selling 2 Dota2 for wow gold! /W me
	--wtt dota 2 keys w
	--wts dota 2beta key 10k
	"^wt[bst]dota2", --WTB Dota 2 hero/store items,/W me what you have

	--[[  Steam  ]]--
	"^wtssteamaccount", --WTS Steam account with 31 games (full valve pack+more) /w me with offers
	"^sellingborderlands2", --Selling Borderlands 2 cd-key cheap for gold (I bought it twice by mistake. Can send pictures of both confirmations emails without the cd-keys, if you dont trust me)

	--[[  League of Legends  ]]--
	"^wt[bs]lolacc$", --WTB LoL acc
	"^wt[bs]%d?x?leagueoflegends?account", --WTS 2x League of Legend accounts for 1 price !
	--WTT My LoL Account for WoW gold, Its a platiunum almost diamond ranked account atm on EUW if u want more information /w me
	"^wt[bst]m?y?lolaccount", --WTS LOL ACCOUNT LEVEL 30 with 27 SKINS and 14k IP
	"^sellingloleuw?acc.*info", --Selling LOL EUW acc pm for more info
	"^wt[bs].*leagueoflegends.*points.*pay", --WTB 100 DOLLARS OF LEAGUE OF LEGENDS RIOT POINTS PST. YOU PAY WITH YOUR PHONE. PST PAYING A LOT.
	"wts.*leagueoflegends.*acc.*info", --{rt1}wts golden{rt1} League of Legends{rt1} acc /w me for more info{rt1}
	"sellingm?y?leagueoflegends", --Selling my league of legends account, 100 champs 40 skins 2-3 legendary 4 runepage, gold. /EUW /W
	"^wt[bs]lolacc.*cheap", --WTS LOL ACC PLAT 4 1600 NORMAL WINS, EUW 40 SKINS, 106 CHAMPS  CHEAP!!
	"^wt[bs]lolacc.*skins", --WTS LoL acc level 30 EUW name ** got about 50 skins /w me for info include 3200 RP!
	"^wt[bst]mygold%d*leagueoflegends", --WTT My Gold 3 League of Legends account for some sick CS:GO skins! 116 Champions, 158 Skins, 6 rune pages. /w me for more info/skype!

	--[[  Account Buy/Sell  ]]--
	"wtsnonemergeacc.*lvl?%d+char", --!WTS none-merge acc(can get a lv80 char)./W me for more info!
	--! WTS lvl 80 char.{all class}.Diablo3 g0ld /W me for more info !
	--^{diamond}lv80 char all class./w me for more info if you WTB^
	"lvl?%d+char%.?allclass.*info", --^{Square} WTS lvl 80 char all class ! /w me for more info{square}^
	"lvl?%d+char.*fast.*g[o0]ld", --# WTS lvl 80 char .TCG mount.cheap fast D3 g0ld/w me for more #
	"%d+lvloldaccounts?tosell", --80lvl old account to sell
	"wtswowaccount.*epic", --y WTS WOW ACCOUNT 401 ITEM LEVEL ROGUES WITH FIRST STAGE LEGENDARY FULL CATA!! WITH 1X VIAL OF SANDS/CRIMSON DEATHCHARGER FULL EPIC GEMED 1X ROGUE 1 X WARRIOR PVP AIMED ADD SKYPE * AND I ALSO HAVE FULL HIERLOOM FOR EVER SINGLE CHARACTER A
	"^wanttotradeaccount", --Want to trade account full cata rogue on * with full epic 50 agil gems(vial of the sands and crimson dk and warrior with 1 cata and mechanohog it is on * wt t for a class with full cata on * /w me!!!!!
	"^wttacc.*epic.*mount.*/w", --WTT ACC MINE HAS FULL CATA+FULL EPIC GEMS  ROGUE WITH NICE MOUNTS WTT FOR AND ACC WITH FULL CATA  RESTO SHAMAN!! /W ME!!
	"^wttacc?ount.*gear.*char", --WTT Acount Resto/Enha shaman / Resto / Balance druid / Prot warr / Mage / Paladin for just one full cata geared pvp character /w me with info
	--WTS wow account 85human Rogue with LEGENDARIES + JC BS.  u pay with gold./w me for more info
	"^wt[st]wowaccount", --WTT Wow account /w me for more info
	"^wt[bs]mopcode", --WTS MoP Code /w me for info
	"^wttaccountfor.*youget.*tier", --WTT Account for a 90 tier 1 ROGUE, you get 90mage(tier1)90druid (tier1) 85 priest, 85 rogue, 85 warrior /wme
	--WTS ACCOUNT with 90 rogue, and 90 priest for gold /wme
	--WTS Account with free lvl 80 And GAME  TIME!! /w me
	"^wt[st]accountwith", --WTT ACCOUNT with 90 mage(TIER1) 90 Feral (TIER1) 85 priest, 85 warrior, 85 rogue for 90 ROGUE with TIER 1/wme

	--[[  Brazzers, yes, really...  ]]--
	"sell.*brazzersaccount.*info", --Hey there! I'm here to sell you Brazzers account /w me for more info!
	"^wtsbrazzersaccount", --WTS BRAZZERS ACCOUNT UNLIMITED TIME /W OFFER

	--[[  Diablo 3  ]]--
	"^wttrade%d+kgold.*diablo", --WT trade 6k gol;d for 300k in diablo 3. /w me
	"^wttwowgold.*diablo", --WTT wow gold for diablo gold. /w if interested.
	"^wtbd3forgold", --WTB D3 for gold!
	--SELLING DIABLO 3 / 60 DAYS PREPAIDGAMECARD - PRICES IN DND!! CHEAP
	"^sellingdiablo3", --Selling Diablo 3 CD Key.Fast & Smooth Deal.
	"^sellingd3account", --Selling D3 account cheap /w for more !
	"^wtscheapfastd3g", --*WTS cheap fast D3 G,/W for skype*
	"^wt[bs]d3key", --WTs D3 key Wisp me for info and price!
	"^wts.*%d+day.*diablo.*account", --WTS [Winged Guardian] [Heart of the Aspects] [Celestial Steed]Each 22k gc90days=30Kdiablo III Account for=70k
	"tradediablo3?goldforwowgold", --anyone want to trade diablo gold for wow gold?
	--SELLING 60 DAYS GAMECARD - VERY CHEAP - ALSO SELL DIABLO ! -SAFE
	"^selling.*gamecard.*diablo", --SELLING 60 DAY GAMECARDS & DIABLO 3!!!!
	"^wt[bs]d3account", --WTS D3 account /w for more !
	"^wtsd3.*transfer.*item", --WTS D3/faction/race change server transfer and other items!
	--WTS Diablo 3 code 30 K !!
	--WTS Diablo 3 CD KEY
	--WTB Diablo 3 key cheap
	--WTB Diablo3 Gold for WoW Gold! /w me D3Gold per WoWGold!
	"^wt[bs]diablo3", --WTB Diablo 3 Gold!
	--WTB WOW GOLDS WITH D3 GOLDS ASAP
	"^wt[bst]wowgold.*d3gold", --WTT Wow Gold For D3 Gold! /w me with your price!
	--{rt1}{rt1}{rt1}WTT my WoW gold for your D3 gold. EU softcore. MSG.
	"wowgoldfory?o?u?r?d3gold", --T> My WoW gold for D3 gold
	--T> My WoW gold for Diablo 3 gold
	--Trading My WoW gold for Diablo 3 gold
	"wowgold.*fordiablo3?gold", --T> My WoW gold (15,000g) for Diablo 3 gold
	"tradediablo3?gold.*wowgold", --LF someone that wants to trade diablo 3 gold for my wow gold
	"^wt[bs]diablogold", --wtb diablo gold for wow gold!
	"trading.*fordiablo3?gold", --TRADING LVL 25 GUILD FOR DIABLO GOLD!!!!!!!!!!!!!
	"diablogoldforwowgold", --WTT my diablo gold for wow gold
	--WTT D3 gold to WoW gold! /w me!
	--WTT 270mil D3 gold to WoW gold! /w me!
	"^wt[bst].*d3gold.*wowgold", --WTB d3 golds for wow golds !
	"^wtt.*mygold.*diablo3gold", --WTT all my gold, 8783g for about 30m Diablo 3 gold, any takers?
	"wowgoldforyourdiablo3?gold", --{rt1}Looking to trade my 10k wow gold for your diablo 3 gold, we can do in trades as low as 0.5k wow gold at a time for safety reasons{rt1}
	"wts.*diablo3goldfor%d+", --wts 150 mill Diablo 3 gold for 50k

	--[[  Illegal Items ]]--
	"selling.*mount.*pet.*pvp.*purchase", --Selling all rare mounts, TGC pets, all PvP services, and much more! We offer great savings for combo purchases! Pst!
	"wts.*timelost.*mount.*char", --WTS [Reins of the Time-Lost Proto-Drake] [Reins of the Phosphorescent Stone Drake]{rt1}World MOUNTS{rt6}non-sharing acc{rt4}transfer characters
	"wts.*mounts.*sale.*skype", --{rt1}{rt3}WTS [Reins of the Spectral Tiger] [Reins of the Swift Spectral Tiger] {rt3}{rt2} cool mounts on sale!! {rt3}pst!!!~~~skype:ah4pgirl
	"%[.*%].*%[.*%].*facebook.com/buyboe", --Win Free[Volcano][Spire of Scarlet Pain][Obsidium Cleaver]from a simple contest, go www.facebook.com/buyboe now!
	--WTS 6PETS [Cenarion Hatchling],Lil'Rag,XT,KT,Moonkin,Panda 8K each;Prepaid gametimecard 10K;Flying Mounts[Winged Guardian],[Celestial Steed]20K each.
	"wts.*gamet?i?m?e?card.*mount", --WTS 90 Day Pre-Paid Game Card 35K Also selling mount from BLZ STORE,25k for golden dragon/lion
	--if you want buy pets/ mounts/gametimecard/ Spectral Tiger/whisper me!^^
	"pets.*mount.*gametimecard", --wts 6pets .mounts .rocket. gametimecard .Change camp. variable race. turn area. change a name. ^_^!
	"wts.*gametime.*mount.*pet", --WTS Prepaid gametime code 8k per month. the mount [Winged Guardian]'[Celestial Steed] 15K each and the pets 6k each, if u are interested,PST
	"wts.*monthgametime.*%d+k", --WTS 1 Month Gametime 10k. 3 Month Gameitme 25k. 6 Month Gametime 40k
	--[Winged Guardian] 25k  [Heart of the Aspects]25k  [Celestial Steed]20k and prepaid gametimecard
	"%[.*%].*%[.*%].*gamet?i?m?e?card", --wts [Heart of the Aspects]25k [Winged Guardian]25k and prepaid gametimecard
	--WTS [Heart of the Aspects]25K [Winged Guardian]25K [Celestial Steed]20K AND prepaid gametimecard
	--WTS [Celestial Steed]  [Winged Guardian]  [Heart of the Aspects] and prepaid gametimecard / 60k for half year
	"wts.*steed.*gamet?i?m?e?card", --{skull} WTS Winged Guardian 15K.Heart of the Aspects 15K Celestial Steed 15K 90 Day Pre-Paid Game Card 35K {skull}
	--VK [Phiole der Sande][Theresas Leselampe][Maldos Shwertstock],25 Minuten Lieferung auf <buyboe(dot)de>
	"%[.*%].*buyboe.*dot.*[fcd][ro0e]", --WTS [Theresa's Booklight] [Vial of the Sands] [Heaving Plates of Protection] 15mins delivery on<buyboe dot com>
	"code.*hatchling.*gamet?i?m?e?card", --WTS Codes redeem:6PETS [Cenarion Hatchling],Lil Rag,KT,XT,Moonkin,Pandaren 5k each;Prepaid gametimecard 6K;Flying mount[Celestial Steed] 15K.PST
	"gamet?i?m?e?card.*deliver", --{rt6}{rt1} 19=10k,90=51K+gamecard+rocket? deliver10mins
	--40$ for 10k gold or 45$ for  10k gold + 1 rocket  + one month  time card  .   25$ for  a  rocket .  we have  all boe items and 264 gears selled . if u r interested in .  plz whsiper me . :) ty
	--$45=10k + one X-53 Touring Rocket, $107=30K + X-53 Touring Rocket, the promotion will be done in 10 minutes, if you like it, plz whisper me :) ty
	"%$.*rocket.*%$.*rocket.*ple?a?[sz]", --$45 for 10k with a rocket {star} and 110$ for 30k with a Rocket{moon},if you like,plz pst
	--WTS X-53 Touring Rocket.( the only 2 seat flying mount you can aslo get a free month game time) .. pst
	--WTS [X-53 Touring Rocket], the only 2seats flying mount, PST
	"wts.*touringrocket.*mount", --!!!!!! WTS*X-53 TOURING ROCKET Mount(2seats)for 10000G (RAF things), you also can get a free month game time,PST me !!!
	"^wts.*x53touringrocket", --WTS[Celestial Steed],[X-53 Touring Rocket],Race,Xfer 15K,TimeCard 6K,[Cenarion Hatchling]*Rag*KT*XT*Moonk*Panda 5K
	--{rt1}WTS TCG mount and g01d {rt6}. {Reins of the Swift Spectral Tiger} {Reins of the Spectral Tiger} Tabard of the Lightbringer {Magic Rooster Egg} {rt6}lvl80 char . if you wanna get a lv80 char in 30mins /w me for more info{rt6}
	"wts.*g[o0][1l]d.*tabard.*rooster", --WTS gO1d and TCG mounts and Tabard of the Lightbringer and maig rooster egg^^/w me:)
	"sell.*rocket.*pet.*gametimecard", --sell  [X-53 Touring Rocket] &2mounts,6pets,gametimecard,CATA/WLK CD-key
	--WTS[Bladeshatter Treads][Splinterfoot Sandals][Rooftop Griptoes]&all 397 epic boot on <g2500 dot com>.
	"wts.*%[.*%].*g2500.*com", --WTS[Foundations of Courage][Leggings of Nature's Champion]Search for more wow items on <g2500 dot com>. With discount code G2500OKYO5097 to order now.
	"wts.*%[.*%].*good4game", --WTS[Blazing Hippogryph][Amani Dragonhawk][Big Battle Bear]buy TCG Mounts on good4game.c{circle}m
	"wts.*%[.*%].*%[.*%].*wealso.*cheapestg", --WTS [Reins of the Crimson Deathcharger] [Mechano-Hog] [Big Battle Bear]and we also have the cheapest G
	"wts.*%[.*%].*%d+usd.*%d+k", --WTS [Reins of the Crimson Deathcharger] [Vial of the Sands] [Reins of Poseidus],170usd=100k+a rocket for free
	"boe.*sale.*upitems", --wts [Krol Decapitator] we have all the Boe items,mats and 378 items for sale .<www.upitems.com>!!
	"wts.*%[.*%].*$%d+.*%[.*%].*$%d+", --wts[Blauvelt's Family Crest]$34.00[Gilnean Ring of Ruination]$34.99[Signet of High Arcanist Savor]$34.90pst
	"pet.*panda.*gametimecard", --Vends 6PETS [Bébé hippogriffe cénarien],Mini'Rag,XT,KT,Sélénien,Panda 12K each;payé d'avance gametimecard 15K;Bâtis volants[Gardien ailé],[Palefroi célest
	"wts.*deliver.*cheap.*price", --WTS [Reins of Poseidus],deliver fast,cheaper price ,pst,plz
	"wts.*%[.*%].*%[.*%].*cheap.*stock", --wts [Reins of the Swift Spectral Tiger] [Reins of the Spectral Tiger] [Vial of the Sands],cheapst ,in stock ,pst
	"wts.*%[.*%].*%[.*%].*cheap.*safe", --WTS [Reins of the Swift Spectral Tiger] [Tabard of the Lightbringer] [Magic Rooster Egg]Cheapest & Safest Online Trad
	"wts.*%[.*%].*order.*stock", --Wts [prestiges mount] order over 50k will get it free  250k in stock-------- (lots of random characters)
	"^wts.*spectraltiger.*alsootheritems$", --WTS [Magic Rooster Egg] [Reins of the Spectral Tiger] [Reins of the Swift Spectral Tiger] Also other items
	--WTS [Magic Rooster Egg] [Reins of the Spectral Tiger]  [Reins of the Swift Spectral Tiger]cheap mount and gold
	"^wts.*%[.*%].*%[.*%].*cheapmounta?n?d?gold", --WTS [Magic Rooster Egg] [Reins of the Spectral Tiger]  [Reins of the Swift Spectral Tiger]cheap mount&gold
	--WTS Blizzard Store Mounts (25k) and Blizzard Store Pets (10k)
	"wts.*mount.*pet.*%d+k", --WTS {star}flying mounts:[Celestial Steed] and [Winged Guardian]30k each {star}PETS:Lil'Ragnaros/Lil'XT/Lil'K.T./Moonkin/Pandaren/Cenarion Hatchling 12k each,{star}prepaid timecards 15k each.{star}
	"wts.*%[.*%].*powerle?ve?l.*chea", --wts [Reins of the Swift Spectral Tiger] [Reins of the Spectral Tiger] [Wooly White Rhino],and g ,powerlvling ,chea
	"selling.*%[.*%].*[36]0days?gametime", --Selling[Enchanted Fey Dragon][Heart of the Aspects][Iron Skyreaver]60daysgametime 20k [each,180days.WOD] boost
	"selling%d+.*prepaidtimecard", --selling 60 day prepaid time card /w me for the price
	"need.*gametime.*rocket.*info", --Does someone need WoW Gametime & X53 Rocket's Mount  /w me for more info
	"^wt[bs][36]0days?prepaidgametime", --WTS 60day Prepaid Gametime  Card and WOD
	"^wt[bs]wodor[36]0days?gc", --wts WOD or 60 Days GC for GOLD  /W ME FOR INFO
	--WTS 60days game time card very checp
	--wts  180days gametime card  {rt1} {rt2}\ cheaps\
	--wts  90days gametime code  {rt2}{rt2}{rt2}
	"^wts%d+days?gametime", --wts 60 days gametime cde. and more stuff from blizzstore
	--wts 60days gamecard for gold /w for more info.
	"^wts%d+days?gamecard", --wts 60 days game card /w me
	"wts.*steed.*prepaidgame", --WTS [Winged Guardian]25K [Heart of the Aspects]25K [Celestial Steed]20K prepaid game
	"gamecard.*gold.*money.*info", -- I am offer Game Card for gold or money, for more info /w me
	--WTB Game Time CODE Buy gold
	--WTS Game time/Diablo and Unmarged accounts for gold!
	"wt[bs].*gametime.*gold", --WTB 1 Month Game Time CODE Buy gold
	"steed.*gc%d+day.*sale", --WTS [Winged Guardian] [Heart of the Aspects] [Celestial Steed]Each 15k gc90days=25KPet sales
	--WTS BLIZZ MOUNTS PETS GAMERTIME OR ANY CODES FOR GOLD
	"wts.*mount.*gamer?time", --WTS Mounts[Heart of the Aspects] and Pets/ GameTimecard
	"mount.*account.*sell.*discount", --Get every single rare mount on your own account now! (including incredibly rare & unobtainables) Also selling all PvP achievies: Gladiator, Hero of Ally, 2200/2400 arenas/RBGs and more! Great discounts for MoP preorders! Message me! Skype: Baddieisboss
	"raiditems.*buy.*email.*price.*wowpve%.c", --{rt1}{rt1}T{rt1}{rt1}S raid items ，397/410/416 token ，achive dragon (ICC,ULD,CATA,FL),416 weapons and so on.If u want to buy,our team will carry u to the instance to get it. U can email me anytime,I will give u a price. [wowpve.com]
	--WTS cheap gold /w me for more info ( no chineese website etc...)
	"^wtscheapgold", --WTS cheap gold /w me for more info
	"^wtscheapandfastgold", --WTS cheap and fast gold ( no chineese website) /w me for more info
	"^wtbgold.*gametime", --WTB GOLD, OR TRADE GOLD FOR GAMETIME!!
	"honorbuddy.*bot.*gold.*skype", --WTS 1 sessions and 3 sessions of HONORBUDDY (WoW bot) For golds....It rly good way to earn golds,if you are interested contact me on skype : Stimar12
	"^wt[bs][36]0days?gc", --wtb 60 days gc.ive got a mindblowing offer which u cant skip.whisper me for extra information if u seriously want to do this!
	"^wt[bs]gamtime.*gold", --WTB gamtime for gold /w
	--WTS G A M E T I M E /W
	--WTS {rt1} GAMETIME {rt1}
	--WTS gametime card 60days Very cheap
	--WTS Gametime-Subscribtion /w me
	"^wt[bs]gametime", --WTS {rt1} GAMETIME {rt1} {rt8} MoP Upgrade{rt8}
	"^wts%d+days?gc$", --WTS 60days GC
	"^anyonesellinggametime", --anyone selling game time
	"^lookingforgametime", --LOOKING FOR GAME TIME
	"^wt[bs]prepaidcard", --WTS prepaid card (30,60,90 days), mounts
	--Wts gamecard 60days very cheap
	"^wt[bs]gamecard", --WTB GAME CARD
	"^wt[bs]gamecode", --wtb game codes
	"^wt[bs]prepaidgamecard", --WTS *Pre-Paid Game Card 60 Days* - Can prove I've got loads in stock /w me offers
	"^wt[bs]%d+day.*gamecard", --WTS 60 DAYS PREPAID GAMECARD
	"^wt[bs]%d+month.*gametime", --WTS 2 Month(60Days) Gametime-Cards w/ me ! {rt1}
	"month.*gametime.*cdkey", --WTS 1 MONTH RAF - 2 MONTHS GAME TIME - MOP CD KEY - CATA CD KEY. WISP ME FOR MORE INFO
	"sell.*gameca?rd.*month.*whisp", --Selling GameC*rd - 2 months! Whisper for skype and Price
	"sell.*gamecard.*day.*whisp", --Greetings! Currently im selling two different kinds of gamecards! {star} The one with 30 days! And the other one with 60 days! Don't be shy to /whisper me! {skull}
	"^wts.*blizzstoremount.*%d+k", --WTS Any of the Blizz Store mounts 20k
	"rafmount.*gametime.*char", --{rt1}{rt6}WTS RAF mount(Heart of the Nightwing) for 16k ^^ {rt1} Game time for 60k/60days {rt1}{rt6}WTS lvl80 char all class in 30mins!!{rt1} etc{rt1}{rt6}}Whisper skype :nan072487
	"rafmount.*mopkey.*g[o0]ld.*char", --{rt1}WTS RAF mount(Heart of the Nightwing) and MOP KEY{rt6}lvl80 char for g0ld,if you wanna get a  lv80 char in 30mins /w me for more info{rt6}
	"looking.*ebay.*sale.*skype", --Looking for someone that has LOADS of EBAY Experienced! )Come and earn 20% of your Sale Products! )Skype = Donz.Gold (dot between the donz.gold) ADD SKYPE
	--WTS: MoP cd keys (cheap) ! and faction change, tranfer, [GC.!] / skype : atmetheskill
	--{rt8} WTB MoP Cd key {rt8}
	"^wt[bs]mopc?d?key", --{rt1} WTS MoP Key 1x /w me {rt1}
	"wtsrafmount.*nightwing", --wts  raf mount   [Heart of the Nightwing] w/m
	"^selling%d+.*gamecard", --Selling 60time gamecard!
	"%d+day.*gametimecard.*cheap", --{diamond} {diamond} {diamond} {diamond} WTS TWO last 180 days game time card, cheaper! {diamond} {diamond} {diamond} {diamond}
	"^wts.*website.*paypal.*deliver", --WTS Custom Guild Website + 12 months of maintenance + hosting + seo ($100 paypal of 100kg in game) (1-3 days to deliver custom guild website)
	"^wts.*prepaid.*wowingamecurrency", --WTS Rchange/Transfer/Prepaid for WoW ingame currency! {rt4}
	"^wts.*tiger.*rooster.*timecard", --WTS  [Reins of the Swift Spectral Tiger]240k[Magic Rooster Egg]120k and Prepaid Timecard,Panda [MOP.Faction] change and Race change Pst.
	"mount.*code.*dving[%.,]net", --Achievements, Mounts, Loot-Codes, PVE / PVP - Dving.net
	"sale.*loot.*dving[%.,]net", --5.4 content on sale! Hardmodes and Loot Raids for Siege of Orgrimmar! - Dving.net
	"arena.*help.*dving[%.,]net", --Offering arena/RBG help. Season 14. 2200/2400/2650 - Dving.net
	"gold.*heroic.*dving[%.,]net", --Challenge Conqueror: Gold. Itemlevel of 560 or 570! Garrosh Heroic! Glory of the raider! - Dving.net {rt8}
	--{rt8} Challenge Conqueror - really cheap! Boosting to 560/570 ilvl! Garrosh HC! Glory of the raider! Discounts and guaranties! - Dving.net {rt8}
	"boost.*dving[%.,]net", --{skull} 5.4 content boosting! HC and loot-raids SOO HC! No accounts share - dving.net {skull}
	--Any achievements for you(skype: DvingHelp)
	--Help you with 2200/2400/2600(hero) skype: DvingHelp
	"you.*skype.*dvinghelp", --Help you with The Bloodthirsty(72 hours), Sun Horde/Ally(48hours) skype: DvingHelp
	"wts.*rbg.*challenge.*powerle?ve?l.*diablo", --{star}{star}{star}WTS Iphone game: Clash of Clans Gems ---- Cheap {star}{star}2200/2400/2700 RBG,finish within 12 hours {star}{star}Challenge Mode, finish in 1-2 days{star}{star}Achievement/Level Powerlvling{star}{star}Paragon lvling on Diablo3 {star}{star}
	--wtswow gold. tier 15 set,weapons and trinket tot,toes,hof and msv full clearpst now, skype:zl8579888
	"^wtswowgold.*%d+", --WTS wow gold...order 100k give u [Heart of the Nightwing] mount for free
	"^wtsmount.*blizzardstore.*safe.*info", --{rt1} WTS mounts from Blizzard Store, 10k each, safe trade! /w for more info. {rt1}
	--WTS GIFT-codes  [Swift Windsteed] [Winged Guardian] 10k /w me
	"^wtsgiftcode", --WTS GIFT-codes  [Heart of the Aspects] [Celestial Steed] 10k /w me
	"^wtscheape?r?gold.*boost", --{rt6}{rt1} wts cheaper gold and LFM RBG boost service  run!! ! {rt1}{rt6}
	"^wts.*gold.*day.*gametime", --WTS [Heart of the Nightwing]for gold!  And 30 days game time for 20K!pst!
	"cheap.*mounts.*rbg.*boost", --{rt6}{rt1} wts cheaper TCG mounts and LFM RBG boost service  run!! ! {rt1}{rt6}
	"rbg.*boost.*cheap.*mounts", --{rt6}{rt1} LFM RBG boost service run!! and wts cheaper TCG mounts {rt1}{rt6}
	"wts.*%[.*%].*xbox.*points", --WTS [Reins of the Swift Spectral Tiger] for XBOX Live Points Card
	"wts.*%[.*%].*[0o]rder.*gear.*cheap", --wts [obsidian nightwing],0rder 50k will get one for free,wts t15 set and t15.5 set,ilvl522 gears/weapons/trinkets,cheaptest price pst! q 1506040674
	"wts.*%[.*%].*boefans.*deliver", --wts[Magic Rooster Egg][Falling Blossom Cowl]{rt6}{rt6}on boefans.c{rt2}m,4 years Exp,fast and safe delivery{rt6}
	"wts.*nightwing.*gametime", --WTS [Heart of the Nightwing] for 14k.wts 30day gametime for 10k.60k for 16k
	"^wts%d+kgolds?.*euro.*paypal", --WTS 95K Golds for 25 euro! Transaction is done via paypal!
	"fast.*help.*koroboost", --Fast and easy help with Mythic/Heroic 100% drop of heirloom weapon. Be [Ready for Raiding] in WoD. Кorоbооst.соm
	"koroboost.*visit", --[Kor'kron Juggernaut] at Кorobооst.cоm. Get it while it's still 100% drop. Also any pve/pvp achievements. Just visit us.
	"koroboost.*skype", --Koroboost.com - best gaming service. Online support at page and thousand of reviewes. Skype Korsstart
	"feat.*mount.*koroboost", --Get feat of strength [Cutting Edge: Garrosh Hellscream (25 player)] - Heroic mount as GIFT at Koroboost.com
	--Any pve runs . normal 25 180 euro. flex from 65 euro, heroic 25 hc  LOOT runs With LOOT GUARANTEED , all tier pack in single run.  Cheapest mount from Garrosh Heroic 170 eu. Also have D3 boost. Koroboost.com {rt1}
	"wts.*account.*mount.*skype", --{rt1} {rt1}  WTS Old Unmerged WoW Accounts {rt1}  Get old achivements/mounts/pets/titles from Vanilla/TBC/WOTLK on your main {rt1} Already seen: Scarab Lord, Old Gladiators etc Skype: kubadoman11 (only skype name) Site:
	"wts.*drake.*skype.*discount", --WTS BOP[Reins of the Time-Lost Proto-Drake][Reins of the Phosphorescent Stone Drake]Pst Skype:tlpd.bop super discount{rt1}
	"wts.*%[.*%].*gametime.*days", --WTS [Armored Bloodwing] [Enchanted Fey Dragon] [Iron Skyreaver] and gametime30-60-90-180days{star}WOD{rt1}
	"boost.*mount.*euro.*skype", --BoostFull Heroic 14/14 SoO Clear (Siege of Orgrimmar Heroic) + Your Class Loot + Garrosh Mount + [Heroic: Garrosh Hellscream] 179.95 euro - MORE Info @ Skype: MRD BOOST
	"guarantee.*speed.*mount.*skype", --{rt4} {rt6} Invincible, Ashes of Al’ar, Mimiron’s Head in just a month, GUARANTEED! Speed farming of any mount! Skype: mmo-support3 {rt3}
	--
	"wowpvpcarry.*promotion", --Preorder any service from WoWPvPCarry now to save! Gear, titles, achievements, mounts, we do it all! Contact me to take advantage of promotions now!
	"bestgear.*messageus.*preorder.*promotion", --Do you want to get the best gear and achieves in the upcoming expansion before everyone else? Message us now to preorder and save! Order while the promotions are still on!
	"selling.*services.*preorder.*savings", --Selling Gladiator/Rank 1/Challenge modes/BiS gear and more - Almost all PvP and PvE services! Preorder for the expansion now for huge savings!
	--

	--[[  RBG/boosting  ]]--
	"prommote%.me.*payment", --dnd Website: Prommote.me ; Skype: mmo-support3 ; E-mail: prommote@gmail.com ; Support work hours: 13:00 - 01:00 CET. Ingame whispers are ignored. Gold is not accepted as payment.
	"prommote%.me.*mount.*loot", --{rt6} {rt8} www.prommote.me - Mythic Garrosh kills and Mount | Heroic and Mythic Loot | Over 90 feedbacks! {rt6}
	--prommote.me will help you gain any RBG rating (2200, 2400 an higher), fill the weekly cap, acquire T2 weapons and become the Gladiator and Hero of the Horde/Alliance Good pricing, no transfer/account sharing required
	--prommote.me will help you get any PVE/PVP and other achievements, mounts, titles and top raid gear, and help you gain 20300 achievement points. PM for details.
	"prommote%.me.*helpyou", --prommote.me will help you gear up in T15 HM raids and get 13/13 progress.
	--prommote.me now offers special summer prices for the [Glory of the Pandaria Raider]
	"prommote%.me.*prices?forthe", --prommote.me, fast service and modest prices for the [Challenge Conqueror: Gold]
	"prommote%.me.*boost", --{rt6} {rt3} www.prommote.me - Challenge mode boosting to Gold or Challenge Master. Tons of feedbacks, done in 3 hours! {rt3} {rt4}
	"prommote[%.,]me.*arena.*boost", --{rt3} {rt8} www.prommote.me - safe Arena boosting. Over 50 positive feedbacks! Ask on website for details! {rt4}
	"gladiator.*preorder.*free.*tinyurl", --{rt8}{rt5} How can you be sure that your Gladiator boost won’t be disqualified? We can tell you! Pre-order a Gladiator and get a FREE PvP set at the start of WoD! tinyurl.com/s16glad {rt5} || URL LINKS TO https://prommote.me/eu/arena
	"elite.*services.*glory.*tinyurl", --{rt7}{rt5} Elite Warlords of Draenor services are up! Everything from Glory of the Draenor Hero and Raider to full Highmaul and Blackrock Foundry Mythic gear! tinyurl.com/mythicwarlord {rt5} || URL LINKS TO https://prommote.me/eu/60-content
	"boosting[%.,]pro.*discount", --[H] <DND>[Jedrict]: {skull}{skull}{skull} www.Boosting.Pro - Premium Arena boosting - {circle} SUPER DISCOUNTS ON ALL RATINGS {circle} Over 50 successful Gladiator orders in season 14! {skull}{skull}{skull}
	--{rt6}{rt6}{rt6} www.Boosting.Pro - Elite PvE Services: {rt2} GET FREE GARROSH MOUNT {rt2} today! Only 25 man raids, warforged loot, weapons and trinkets are included! {rt6}{rt6}{rt6}
	"boosting[%.,]pro.*service", --[H] <DND>[Jedrict]: {square}{square}{square} www.Boosting.Pro - Elite PvE Services: {circle} HC LOOT RUN + GARROSH MOUNT {circle} on Sale now! Only 25 man raids, warforged loot, weapons and trinkets are included! {square}{square}{square}
	"boosting[%.,]pro.*sale", --{rt6}{rt6}{rt6} www.Boosting.Pro - Get all RAREST mounts from World of Warcraft: {rt2} MIMIRON'S HEAD and ASHES OF AL'AR {rt2} on Sale now! Any mount including Invincible in less than a month! {rt6}{rt6}{rt6}
	"boosting[%.,]pro.*cheap", --{rt6}{rt6}{rt6} www.Boosting.Pro - REAL RBG boosting without wintrades! {rt2} ULTRA-CHEAP RBG WIN FARM {rt2} Check it out ;) {rt6}{rt6}{rt6}
	"rbg.*epiccarry[%.,]com", --{rt2} Arena rating\Rbg wins\Arena wins on epiccarry.com {rt1}
	"realm.*epiccarry[%.,]com", --{rt2} SOO Flex\Normal\Heroic\Glory + T15+T14 contents selfplay, no realm transfer on epiccarry.com {rt1}
	"chiefboost[%.,]com.*service", --chiefboost.com - premium service from world top guilds without intermediaries! Siege of Orgrimmar 14/14 loot raids N/HM
	"skype.*chiefboost", --100% Heirloom weapons from SoO, Glory of Orgrimmar and WoD pre-orders for a reasonable price. skype: chiefboost
	"starboosting[%.,]com.*pro", --{rt1} www.starboosting.com {rt1} Professional game help {rt1}
	"arena.*2200.*skype", --arena ratings for (rdruid, mage, rogue,warlock,priest,warrior,shaman) 2200/2400/2600 add skype for more info - Dezleit
	"hurry.*season.*share.*acc.*pro", --Hurry up! The end of season is coming! Without share acc! Play with pro!
	"rbg.*2200.*compte.*skype", --{star} RBG CAP/2000/2200/2400/HEROS{star} || VOUS JOUEZ VOTRE COMPTE ||  ? Tous les Hauts Faits PVP, 15 Titres, MONTURES PvP?  || jeu d'essai || REDUCTIONS ET REMISES POSSIBLES || {star}Skype: Azpirox{star}
	"wowst[o0]re[%.,]com.*pvp.*rbg", --wow-st0re.com Le n°1 du pl français depuis 2013 - SoO 25 NM/HM - PvP Arène / RBG côte - Bastonneurs - Armes Légendaires - [Défi d'or 9/9 à seulement 70k po!] http://wow-st0re.com 100% FR
	"boost.*skype.*tridon", --WTS Big conquest cap Boost / Contact me Skype: Tridon.boosting
	"help.*gold.*week.*skype", --{rt6}We help you with [Challenge Conqueror: Gold], CM's shutting down in less than a week. Right now available. Skype: CMhotBOOT{rt6}
	"hurry.*draenor.*loot.*mount.*price.*info", --{rt1}{rt1} Hurry up! Draenor is coming {rt1}{rt1} Loot-Raids, Mount and Heirloom from Garrosh! Low price!!! {rt1}{rt1} /w for info {rt1}{rt1} 
	--
	"help.*2200.*fast.*pvp.*wisper.*info", --We will help you with  [Three's Company: 2200] . Fastest rating ever, up to 3 hours for geared pvp chars! Wisper for info.
	"help.*gold.*challenge.*mount.*skype", --help with [Challenge Conqueror: Gold] from Challenge masters! get achiment. title, mount and xmog set for 2 hours! skype CMGoldMasters
	"boost.*skype.*paypal", --WTS GLADIATOTR BOOST! PLAYING NOW! HAVE GEAR AND A BIT CR! HAVE SKYPE & PAYPAL!
	--
	"gift.*buy.*price.*play", --14/14 Hc/Normal SOO.Whole gear as a gift. Hurry to buy at the best price without intermediaries.It’s possible to self-play
	"gold.*hours.*acc.*chance", --Challenge Gold. From 2 to 4 hours,without accsharing.Do not miss your chance.There are on;y 1 week!
	"heroic.*price.*rbg.*arena", --T14,T15, Mv,HoF,ToeS,ToT Heroic.Self play,best price.All Pvp Achievement,RBG,Arena 2200 2vs2,3vs3
	"garrosh.*order.*mount.*gift", --Garrosh Hc.Pre order now you will get the mount as a gift!Be geared to Draenor

	--[[  Russian  ]]--
	--[skull]Ovoschevik.rf[skull] continues to harm the enemy, to please you with fresh [circle]vegetables! BC 450. Operators of girls waiting for you!
	"oвoщeвиk%.pф.*cвeжиmи", --[skull]Овощевик.рф[skull] продолжает, на зло врагaм, радовaть вас свежими [circle]oвoщaми! Бл 450. oператoры девyшки ждyт вaс!
	-- [[MMOSHOP.RU]] [circle] ot23r] real price [WM BL:270] [ICQ:192625006 Skype:MMOSHOP.RU, chat on the site] [Webmoney,Yandex,other]
	"mmoshop%.ru.*цeнa.*skype", -- [ [MMOSHOP.RU]] [circle] от23р] реальная цена [WM BL:270] [ICQ:192625006 Skype:MMOSHOP.RU, Чат на сайте] [Вебмани,Яндекс,другие]
	--[square] [RPGdealer.ru] [square] gives you quick access to wealth. Always on top!
	"rpgdealer%.ru.*бoгaтcтву", --[square] [RPGdealer.ru] [square] предоставит Вам быстрый доступ к богатству. Всегда на высоте!
	--GOLD WOW + SATELLITE PRESENT EACH! Lotteries 2 times a month of valuable prizes [circle] Site : [RPGdealer.ru] [circle] ICQ: 485552474. BL 360 Info on the site.
	"з[o0]л[o0]т[ao0].*rpgdealer%.ru", --ЗОЛОТО WOW + СПУТНИК В ПОДАРОК КАЖДОМУ! Розыгрыши 2 раза в мес ценных призов [circle] Сайт: [RPGdealer.ru] [circle] ICQ: 485552474. BL 360 Инфа на сайте.
	--Buy "funny coins" from [star]FUNY-MONY.RF[star]. Delivery 10 minutes. Always in stock. All the details on the FUNY-MONY.RF
		--Покупайте "Весёлые монетки" от [star]ФАНИ-МАНИ.РФ[star]. Доставка 10 минут. Всегда в наличии. Все подробности на ФАНИ-МАНИ.РФ
	--Buy MERRY COINS on the funny-money.rf Funny price:)
		--Купи ВЕСЕЛЫЕ МОНЕТКИ на фани-мани.рф Смешные цены:)
	--Buy GOLD at [circle]funny-money.rf[circle] Price Calculator on the site.
	"kуп.*фaни-maни%.pф", --Купи ЗОЛОТО на [circle]фани-мани.рф[circle] Калькулятор цен на сайте.
	--[COINS] of 23 per 1OOO | website | INGMONEY. RU | | SALE + Super Award - Spectral Tiger! ICQ 77-21-87 | | Skype INGMONEY. RU
	"ingmoney%.ru.*skype", --[МОНЕТЫ]  от 23 за 1OOO | сайт | INGMONEY. RU ||АКЦИЯ + Супер Приз - Спектральный Тигр! ICQ 77-21-87 || Skype INGMONEY. RU
	--Sell 55kg of potatoes at a low price quickly! Skype v_techno_delo [circle] 8 = 1kg
	"пpoдam.*kapтoшkи.*cpoчнo.*ckaйп", --Продам 55кг картошки по дешевке  срочно! скайп v_techno_delo  [circle] 8 = 1кг
	--Gold Exchange Invitation to participate suppliers and shops. With our more than 800 suppliers and 100 stores. GexDex.ru
	"з[o0]л[o0]т[ao0].*gexdex%.ru", --[skull][skull][skull] Биржа золота приглaшaет к учaстию постaвщиков и магазины. С нами болee 800 постaвщиков и 100 магaзинов. GеxDеx.ru
	--Cheapest price only here! Price 1000 gold-20R, from 40k-18r on, from-60k to 17p! Website [playwowtime.vipshop.ru]! ICQ 196-353-353, skype nickname playwowtime2011!
	"vipshop%.ru.*skype", --Самые дешевые цены только у нас! Цены 1000 золотых- 20р , от 40к -по 18р , от 60к-по 17р ! Сайт [playwowtime.vipshop.ru] ! ICQ 196-353-353 , skype ник playwowtime2011!
	--we are help with RAITING BATTLE GROUND -2200-2400-2650 /admission of cap/PVP set for honor points/mount/leveling 1-90/ skype - [RPGBOX.RU] icq  819-207 site [rpgbox.ru]
	"ckaйп.*rpgbox%.ru", --поможем РЕЙТИНГ ПОЛЕ БОЯ -2200-2400-2650 /набор капа/ПВП сет за очки чести/маунт/прокачка 1-90/ скайп - [RPGBOX.RU] ася  819-207 сайт [rpgbox.ru]
	--website [RPGBOX.RU] RBG 2200-2400-2650 / cap/PVP set for honor points/mount/UP 1-90 /farm kills 250K /any progress in raids and dungeons for players and guilds
	"rpgbox%.ru.*2200.*maунт", --сайт [RPGBOX.RU] РПБ 2200-2400-2650 / кап/ПВП сет за очки чести/маунт/UP  1-90 /фарм килов 250к /любые достижения в рейдах  и подземельях для игроков и гильдмй
	--Sell! [gold] 16r-1000g. Looking for suppliers. Quality levelling of character's, honor point's and profession's. ICQ: 406-887-855 Skуре: WoW-Crabbs  Webmoney BL [360]
		--Продаю! [золото] 16р-1000г. Ищу поставщиков. Качественно прокачаю персонажей, очки чести и профессии. ICQ: 406-887-855 Skуре: WoW-Crabbs  Webmoney BL [360]
	--Selling [GOLD]! 16r-1k Instant delivery any quantatys. Levelling characters, prof, honor. Attestat WM BL 350 ICQ 406-8878-55 Skype wow-crabbs
		--Продам [GOLD]! 16р-1к Моментальная доставка любых количеств. Прокачка персонажей, проф, хонора. Аттестат WM BL 350 ICQ 406-8878-55 Скайп wow-crabbs
	--Buying gold!looking for suppliers.Leveling characters, proffesions, honor TimeCards60days-80k gold Game payment 1month-45k gold. Attestat [BL 350] ICQ 406-8878-55 Skype wow-crabbs
	"icq.*wowcrabbs", --Скупаю голд!ищу поставщиков.Прокачка персонажей, профессий, хонора ТК60дн-80к Проплата 1мес-45к. Аттестат [BL 350] ICQ 406-8878-55 Скайп wow-crabbs
	--[MMOah.ru]  [circle] Gold at competitive prices [circle] BL85+ IСQ  49-48-48 , online chat on the site, we are accepted any kind of payments WM/YM/Visa/qiwi/Robokassa/SMS, we are produce recruitment of suppl
	"mmoah%.ru.*зoлoтo.*icq", --[MMOah.ru]  [circle] Золото по выгодным ценам [circle] BL85+ IСQ  49-48-48 , на сайте онлайн чат, принимаем все виды оплат WM/ЯД/Visa/qiwi/Robokassa/SMS, производим набор пост
	--Seling [G[circle]LD], Fast, reliably, any kind of payments. Attestat of seller's. Looking for supplier's details to pm.
	"g{.*}ld.*быcтpo.*oплaты.*пocтaвщиkoв", --Продам [G[circle]LD], Быстро, надежно, различные способы оплаты. Аттестат продовца. Ищем поставщиков подробности в пм.
	--selling [circle] 1k at 13 rub
	"^пpoдam.*{.*}.*%d+kзa%d+pуб", --продам [circle] 1к за 13 руб
	--Help with RPBБ. [blue square] 2200 - 2400 - 2600. CAP [blue square]. Fast and safe. Best service. Without share of your account. You are play yourself. Site, BL 320+. Skype: R
	"быcтpo.*бeзoпacнo.*cepвиc.*akkaунтa.*ckaйп", --Помощь с РПБ. [blue square] 2200 - 2400 - 2600. КАП [blue square]. Быстро и безопасно. Лучший сервис. Без передачи аккаунта. Вы играете сами. Сайт, БЛ 320+. Скайп: R
	--Help with RBG raiting  2200.2400.2600. Cap. Detail in skype Axelretreem
	"пomoжem.*pбгpeйтингom.*%d%d%d%d.*ckaйп", --Поможем с РБГ рейтингом  2200.2400.2600. Кап. Подробнее в скайп Axelretreem
	--[PLAY-START_RU] G[circle]l0d0 from 14,8r, any kind of payment, delivery 5-15min. Reiiably. Attestat of seller's. We are looking for suppliers details in pm.
	"playstart[%.,]?ru.*oплaты.*дocтaвka", --[PLAY-START_RU] З[circle]л0т0 от 14,8р, различные способы оплаты, доставка 5-15мин. Надежно. Аттестат продовца. Ищем поставщиков подробности в пм.
	--Sell shiny little coins guarantees [circle]
	--Продам блестяшки гарантии [circle]
	--sell shiny little coins [circle]
	"^пpoдamблecтяшkи", --продам блестяшки [circle]
	--We are help with Arena and RBG 2200\2400\2700. Hero of Alliance\Horde [Dving.ru]
		--Поможем с Ареной и РБГ 2200\2400\2700. Герой Альянс\Орды [Dving.ru]
	--Honor points , Conquest, Valor on site [Dving.ru]
		--Очки чести , Завоеваний, Доблести на [Dving.ru]
	--We are help with GCR, GDSR, GFR on site [Dving.ru].
		--Поможем с СРК , СРДД, СРОП на [Dving.ru].
	--We are sell Glory of the Hero of Pandaria [Dving.ru]
		--Продадим Славу Героя Пандарии [Dving.ru]
	--Personal service and individual orders for [Dving.ru]
	"д.*dving%.ru$", --Персональное обслуживание и индивидуальные заказы на [Dving.ru]
	--[square][skull][Gold] at 14r for 1000 on site [WHISPERS RU].Raids,BG,Arena,levelling,professions,mounts and pets.Windsteed and timecard for gold Skype [Whispers.ru] ICQ634-810-845[star]
	"whispers%.?ru.*гoлд.*ckaйп", --[square][skull][Золото] от l4p за l ООО на [WHISPERS RU].Рейды,БГ,Арена,прокачка,профессии,маунты и петы.Ветророг и тk за голд Скайп [Whispers.ru] ICQ634-810-845[star]
	--[circle]15 for 1000! Website [Gann-money.ru]! All kinds of payments! Gifts wholesalers! High BL! ICQ 9937937 skype Gann-money or operator on the site!
	"gannmoney%.ru.*skype", --[circle]по 15 за 1000! Сайт [Gann-money.ru] ! Все виды оплат! Подарки оптовикам! Высокий БЛ! ICQ 9937937 skype Gann-money или оператору на сайте!
	--{квадрат} Продаём баклажаны от 16р за 1к.  Bcе виды оплат. BL245+. Сайт WoWMoney.гu. Связь через icq З84829 или cкайп wowmoneyally .{квадрат}
	--{треугольник} Продаём {круг} от 16р за 1к.  Сайт WoWMoney.гu. BL245+. Bсe виды оплат. Связь чeрeз скайп wowmoneyally или icq З84829 {треугольник}
	"пpoдaem.*wowmoney%..*icq", --{звезда} Пpодaём голдец от 16p зa 1к.  BL245+. Bсe виды оплaт. Caйт WoWMoney.гu. Cвязь чepeз скaйп wowmoneyally или icq З8-48-29 .{звезда}
	"wowmart%.ru.*зoлoтo", ---= WOWMART.RU =- Адекватные цены на Золото и товары за Золото.

	--[[  Chinese  ]]--
	--嗨 大家好  团购金币送代练 炼金龙 还有各职业账号 详情请咨询 谢谢$18=10k;$90=50k+1000G free;$180=100k+2000g+月卡，也可用G 换月卡
	--{rt3}{rt1} 春花秋月何时了，买金知多少.小楼昨夜又东风，金价不堪回首月明中. 雕栏玉砌金犹在，只是价格改.问君能有几多愁，恰似我家金价在跳楼.QQ:1069665249
	--大家好，金币现价：19$=10k,90$=50k另外出售火箭月卡，还有70,80,85账号，全手工代练，技能代练，荣誉等，华人价格从优！！买金币还是老牌子可靠，sky牌金币，您最好的选择！
	"only%d+.*for%d+k.*rocket.*card", --only 20d for 10k,90d for 50k,X-53 rocket,recuit month card ,pst for more info{rt1}另外出售火箭月卡，买金送火箭月卡，账号，代练等，华人价格从优！！
	"金币.*%d+k.*惊喜大奖", --卖坐骑啦炽热角鹰兽白色毛犀牛大小幽灵虎红色DK马等拉风坐骑热销中，金币价格170$/105k,更有惊喜大奖等你拿=D
	--17=10k 160=100K 359BOE LVL85 Account For SaIe 疯狂甩卖 P0werleveling 1-85 only need 7days 还有大小幽灵虎
	"%d+=%d+k.*boe.*p[0o]we?rle?ve?ling.*虎", --17=10k 160=100K 359BOE疯狂甩卖 P0werleveling 1-85还有大小幽灵虎等你来拿PST
	"%d+=%d+k.*r0cket.*p[0o]we?rle?ve?ling", --$50=30k $80=50K+X-53T0uring R0cket+1 M0nth G@me Time , 378B0Es For SaIe 疯狂甩卖 P0werleveling 1-85 only 7 days, Help Do Bloodbathed Frostbrood Vanquisher Achivement!代打ICC成就龙,华人优惠哦
	"金.*%d+=%d+k.*boe.*虎", --暑假WOW大促销啦@，金币超低价 <200=100k+10kextra> , 国服/美服1-85效率代练5天完成，378BOE各种装备甩卖，各职业帐号，大小幽灵虎等稀有坐骑现货，金币换火箭，月卡牛
	"only.*%d+k.*deliver.*售", --only 17d for 10k,160d for 100k,deliver in 5mins, pst for more info另出售装备，账号，坐骑，85代练，华人价格从优！！!
	"专业代练.*安全快速发货", --17美元=10k  大量金币薄利多销，货比三家，专业代练1-85，练技能，账号，火箭月卡，还有各种378BOE装备，各种新材料，大小幽灵虎，专业团队代打ICC成就龙，刷荣誉等，安全快速发货
	"cheap.*sale.*囤货", --WTS [Blazing Hippogryph] [Amani Dragonhawk]cheapest for sale,pst,plz 龙鹰和角鹰兽囤货，需要速密，谢谢
	"金币.*卖.*买金币", --感恩大回馈金币大甩卖 ,买金币送坐骑，送代练，需要的请M,另外有378装备，代练，帐号，月卡出售。大、小幽灵虎，犀牛，角鹰兽， 魔法公鸡，赤红DK战马,战斗熊等
	"wts.*%[.*%].*gear.*%d+k.*gift", --WTS大卖 [Dragonbelly Bracers] [Boots of Fungoid Growth] lvl384 or 397 pattern gear Gem 150$=100k+a free gift,17$=10k, pst withi more offer
	"wts.*%[.*%].*cheap.*囤货甩卖", --WTS [Savage Raptor] [Blazing Hippogryph] [X-51 Nether-Rocket X-TREME] cheap pst,囤货甩卖，需要的
	"wts.*%[.*%].*cheapgold.*%d+k", --WTS大卖 [Pattern: Bladeshadow Wristguards] [Pattern: World Mender's Pants] and cheap gold 10k for 15,100k for 140 pst
	--WOW龙魂8H效率团低价出售橙匕+WOW各版本橙武。 397/403/410/416装备。带刷成就龙(ICC,ULD,CATA,FL)。帅气坐骑.死翼坐骑/火鹰/等。带刷RBG荣誉.1-85手工代练美金消费欢迎咨询QQ: 1416781477
	"出售.*成就.*欢迎.*qq", --WOW龙魂8H美金消费团出售橙匕+WOW各版本橙武。 397/403/410/416装备。带刷成就龙(ICC,ULD,CATA,FL)。低价出售帅气坐骑.死翼坐骑/火鹰/等。带刷RBG荣誉.1-85手工代练欢迎咨询QQ: 1416781477
	"wts.*nightwing.*order.*gametime", --WTS[Heart of the Nightwing]order 50k will get a free one plus 30days game time{star}买金送招募坐骑,炼金龙和DK马,大小幽灵虎特价出售,另有各种代练和账号{diamond}QQ：1933089703
	"freemount.*[0o]rder.*stock.*skype", --get free mount with 50k 0rder,300k in stock, skype: sue861029,24/7 online。金币14刀一W，纯手工做任务专业代练，85-90仅需一天，价格优惠。更有稀有坐骑10只打包特卖，大小幽灵虎，白犀牛，大战熊，魔法公鸡쾰
	"^wts.*challenge.*transmog.*mount.*qq%d+", --wts challenge mode:transmog set and mount qq:498890740
	"金币.*服包团.*便宜卖.*QQ", --{rt3}金币100刀10w,15w送幽灵坐骑哦{rt3}金牌挑战特价，当天完成{rt3}TOT 全通，lvl522武器饰品，t15套装特价，无需转服{rt3}MSV/HOF/TOES跨服包团，各等级，专业代练便宜卖{rt3}{rt3}QQ：1933089703
	"gold.*powerlvl?ing.*fast.*best.*skype", --WTS{rt3}{rt3}Gold Challenge Conqueror{rt3}{rt3}Powerlving1-90/85-90/1-85{rt3}{rt5}{rt3}Fast & Best services{rt1}{rt1}Pst for details--Skype:tessg4p--{rt1}{rt1}金牌挑战模式，等级代练，请Q：2584052418--
	"坐骑.*rbg.*2200.*skype", --{diamond}代打金牌挑战模式***各类职业。奖励。奖励一套拉风幻化装，凤凰坐骑一枚+等级代练，RBG2200/2400/2600/2700/...+每周混分-skype:tessg4p--幽灵虎团队 778587316

	--[[  Advanced URL's/Misc  ]]--
	"happygolds.*stock.*receive", --[Enchanted Elementium Bar]{RT3}{RT3}{RT2}Feldrake{RT3}hàppygôlds,Cô.m{RT4}{RT3}{RT2}WE HAVE 800K in stock and you can receive within 5-10minutes {RT3}{RT3}hàppygôlds,Cô.m{RT4}{RT3}E
	"happygolds.*e[%.,]?u[%.,]?r[%.,]?o", --[Enchanted Elementium Bar]{diamond}{diamond}Happygôlds,C_M{diamond}10.K=4.99E.U.R.O{diamond}{diamond}{diamond}Happygôlds,C_M{diamond}10.K=4.99E.U.R.O{diamond}{diamond}{diamond}Happygôlds,C_M{diamond}10.K=4.99E.U.R.O{diamond} Lvl 510
	"%d+eu.*deliver.*credible.*kcq[%.,]", --12.66EUR/10000G 10 minutes delivery.absolutely credible. K C Q .< 0 M
	"pkpkg.*boe.*deliver", --[PKPKG.COM] sells all kinds of 346,359lvl BOE gears. fast delivery. your confidence is all garanteed
	"service.*pst.*info.*%d+k.*usd", --24 hrs on line servicer PST for more infor. Thanks ^_^  10k =32 u s d  -happy friday :)
	"okgolds.*only.*%d+.*euro", --WWW.okgolds.COM,10000G+2000G.only.15.99EURO}/2
	"mmo4store.*%d+[kg].*good.*choice", --{square}MMO4STORE.C0M{square}14/10000G{square}Good Choice{square}
	"promotion.*serve.*%d+k", --Special promotion in this serve now, 21$ for 10k
	"pkpkg.*gear.*pet", --WWW.PkPkg.C{circle}M more gears,mount,pet and items on
	"euro.*gold.*safer.*trade", --Only 1.66 Euros per 1000 gold, More safer trade model.
	--WWW.PVPBank.C{circle}MCODE=itempvp(20% price off)
	"www[%.,]pvpbank[%.,]c.*%d+", --Wir haben mehr Ausr?stungen, Mounts und Items, die Sie mochten. Professionelles Team fuer 300 Personen sind 24 Stunde fuer Sie da.Wenn Sie Fragen haben,wenden Sie an uns bitteWWW.PVPBank.C{circle}M7 Tage 24 Uhr Service.
	"wts.*boeitems.*sale.*ignah", --wts [Lightning-Infused Leggings] [Carapace of Forgotten Kings] we have all the Boe items,mats and t10/t10.5 for sale .<www.ignah.com>!!
	"meingd[%.,]de.*eur.*gold", --[MeinGD.de] - 0,7 Euro - 1000 Gold - [MeinGD.de]
	"%$.*boe.*deliver.*interest", --{rt3}{rt1} WTS WOW G for $$. 10k for 20$, 52k for 100$. 105k for 199$. all item level 359 BOE gear. instant delivery! PST if ya have insterest in it. ^_^
	"^wtscheapergold/whisper$", --{square} WTS CHeaper gold /whisper {square}
	"wowhelp%.1click%.hu", --{square}Have a nice day, enjoy the game!{square} - {star} [http://wowhelp.1-click.hu/] - One click for all WoW help! {star}
	"%d+k.*deliver.*item", --$20=10K, $100=57k,$200=115k with instant delivery,all lvl378 items,pst
	"money.*gold.*gold2sell", --Ingame gold for real money! Real gold for Ingame gold! Ingame gold for a account key! If you're intrested, then check out: "gold2sell.org" now!
	"wtsgold.*mount.*tar?bard.*acc", --WTS gold and some TCG mounts and Tarbard of the lightbringer and 80lvl acc
	"%d+[/\\=]%d+.*gold4power", --?90=5oK Google:Gold4Power, Introducer ID:saray
	"k%.?4g[o0]ldcom.*code", --{star}.W{star}.W{star}W {square} k{triangle}.4{triangle}g{triangle}o{triangle}l{triangle}d {square} c{star}o{star}m -------{square}- c{star}o{star}d{star}e : CF \ CO \ CK
	--www K4power c@m.Lowest Price + 10% Free G.{Code:4Power}--
	--~~K.4.p.0.W.e.r,C,o,m~~ 4.€.~1O0O0
	"k[%.,]*4[%.,]*p[%.,]*[o0][%.,]*w[%.,]*e[%.,]*r.*%d[%do]+", --WWW K4POWER C0M {Code:Xmas}->>Xmas Promotions{18th Dec-26th Dec}->35% Free,0rder 50k More->X-53 Rocket Mount For Free!
	"%d[%do]+.*k[%.,]*4[%.,]*p[%.,]*[o0][%.,]*w[%.,]*e[%.,]*r", --4e<> 10O0O @ k4põwér C'Q'M @
	"k[%.,]*4[%.,]*p[%.,]*[o0][%.,]*w[%.,]*e[%.,]*r.*d[%.,]*e[%.,]*[l1][%.,]*i[%.,]*v[%.,]*e", --3.w,K.4.P.0.W.E.R,c.@.m 4 èü // 1Ok,Délìvèry 6 M.i.n.s
	--Vend RBG 2400{star} 3.88“euro”=10k{moon}rapide et sûre.{star}D'autres types de BOE est également en vente.
	"vend.*prix.*livraison.*wow%.po", --Vend Po à prix interessant Livraison instantanée. Paiement par SMS/Tel ou Paypal, me contacter Skype: wow.po
	"verkauf.*hotgolds.*%d+g", --Gréat Vérkauf! .Hôtgôlds.côrn10000G.only.2.éUR.Hôtgôlds.côrnWWWé habén 783k spéichért und k?nnén Sié érhaltén innérhalb von 5-10 Minutén.wénn Sié kaufén ,  4403
	"%d[%do]+=%d+%.?%d*e.*bonus.*skype", --@1òòòO=5.52ё.5% BòNuS.5-15mins can Gёt./w me for skype@
	"hotg01ds.*%d[%do]+k", --Hôtg01ds. côrn 1Ok=2.99 8081
	"order.*nightwing.*%d+k.*stock", --WTS{star}50K Order can get <heart of the nightwing> for free,100k Order can get it for free,500k in stock,pst{square}
	"mmomarket.*gold.*boost", --{rt1}{rt1} We are MMO-market.com!!! WE are all you ever going to NEED: GOLD / CHARACTERS(from 150$ char to 5000$ char)/ BOOSTs in PvE or ARENA BOOSTs in PvP! FULLY PROFESSIONAL. Come and check us! [MMO-MARKET.COM]{rt1}{rt1}
	"complete.*gold.*challenge.*$%d+.*hurry", --complete all the Gold dungeon challenge (\n?) achievements now only $200 (\n?) paladin(tank) (\n?) shaman), Hurry contact me, you will complete all the Gold dungeon challenge quickly.
	"cheap.*fast.*gold.*item.*skype", --{rt3}{rt3}To get cheap,fast gold and hot items in a great deal, please add my skype {rt3} linda871230 {rt3}for more information!{rt3}{rt3}
	"rbg.*challenge.*mount.*boost", --WTS Iphone game: Clash of Clans  Gems----much cheaper than APP store2200/2400/2700 RGB,get your cool titles todayChallenge Mode, fast get ur Xmogs and mountT14.5 set boosted by 16/16H raid group
	"goldpreise.*server.*skype", --Bieten Top Goldpreise auf allen deutschen Servern! an /w me bei Interesse oder add hambulaa/Skype!!! 55k
	"gold.*challenge.*achiev.*%$%d+.*sk[py][yp]e", --{rt5}{rt5}spots open for Complete all the Gold dungeon challenge achievements， only $79, lvl522 item $100 each piece ,  raid progress TOT12/12,offer t15set, lvl522 lvl535 weapons,trinket etc,  PST to get more info or add skpye jolinvipservice
	"fast4gold.*%d+k.*stock", --[Blazefury, Reborn]Feldrakefast4gold,Cô.mWE HAVE 800K in stock and you can receive within 5-10minutes fast4gold,Cô.mE--------------7286
	"skype.*chefboosting[%.,]com", --{rt6}| WTS RBG Boost|{rt6}, Challenge Mode boost, Power leveling & SoR accounts // Must trusted boosting website in the world, supported by top Twitch Streamers!  contact skype :  chef-xtrem or [www.chefboosting.com]
	"sellgold.*only%d+euro", --{rt1}Sell GOLD! 10.000 GOLD Only 5 Euro!{rt1}
	"mia911[%.,]c.*skype", --{rt6}{rt6}{rt6}{rt6}{rt6}{rt6}{rt6}{rt6}{rt6}[www.mia911.cQm]{rt4}{rt4}{rt4}{rt4}{rt4}{rt4}800K G in sotck{rt5}{rt5}10000=8USD{rt5}{rt5}pl add skype;mia9116{rt5}{rt5}mia911.cQm{rt5}{rt5}{RT
	"game4ok[%.,]c.*livechat", --{rt6}{rt6}{rt6}{rt6}{rt6}{rt6}{rt6}[www.game4ok.cQm]{rt4}{rt4}{rt4}[game4ok.cQm]{rt4}{rt4}800K G in sotck{rt5}{rt5}{rt5}traden in 10minutes{rt5}{[RT5game4ok.cQm]{rt5}{rt5}{rt5} [game4ok.cQm]{rt6}{rt6}{rt6}{rt6}[game4ok.cQm] contact by;Live Chat {rt4}{rt4}{rt4}{rt4}
	"raidbroker[%.,]com.*skype", --Both Horde/Alliance teams! http://raidbroker.com ~ Jarvis.Dresden on Skype!!
	"g@ld.*livraison.*exclusiv", --Envie de G@LD pour bien commencer WoD, livraison en moins de 5 min en exclusivité sur ysondre
	--{rt1}VERKAUFE GOLD Sehr Billig. Skypename : betz-500{rt1}
	"verkaufen?gold.*skype", --{rt7}Wir Verkaufen Gold sehr Günstig. Skypename : betz-210{rt7}
	"titaniumbay.*extra", ---= TitaniumBay =- Get 10 % extra {rt2}! Fast and safe delivery!
}

--This is the replacement table. It serves to deobfuscate words by replacing letters with their English "equivalents".
local repTbl = {
	["а"]="a", ["à"]="a", ["á"]="a", ["ä"]="a", ["â"]="a", ["ã"]="a", ["å"]="a", --First letter is Russian "\208\176". Convert > \97
	["с"]="c", ["ç"]="c", --First letter is Russian "\209\129". Convert > \99
	["е"]="e", ["è"]="e", ["é"]="e", ["ë"]="e", ["ё"]="e",["ê"]="e", --First letter is Russian "\208\181". Convert > \101
	["ì"]="i", ["í"]="i", ["ï"]="i", ["î"]="i", --Convert > \105
	["к"]="k", -- First letter is Russian "\208\186". Convert > \107
	["Μ"]="m", ["м"]="m",--First letter is capital Greek μ "\206\156". Convert > \109
	["о"]="o", ["ò"]="o", ["ó"]="o", ["ö"]="o", ["ō"]="o", ["ô"]="o", ["õ"]="o", --First letter is Russian "\208\190". Convert > \111
	["р"]="p", --First letter is Russian "\209\128". Convert > \112
	["ù"]="u", ["ú"]="u", ["ü"]="u", ["û"]="u", --Convert > \117
}

local strfind = string.find
local IsSpam = function(msg, num)
	for i=1, #instantReportList do
		if strfind(msg, instantReportList[i]) then
			if myDebug then print("Instant", instantReportList[i]) end
			return true
		end
	end

	local points, phishPoints, boostingPoints = num, num, num
	for i=1, #whiteList do
		if strfind(msg, whiteList[i]) then
			points = points - 2
			phishPoints = phishPoints - 2 --Remove points for safe words
			if myDebug then print("whiteList", whiteList[i], points, phishPoints, boostingPoints) end
		end
	end
	for i=1, #commonList do
		if strfind(msg, commonList[i]) then
			points = points + 1
			if myDebug then print("commonList", commonList[i], points, phishPoints, boostingPoints) end
		end
	end
	for i=1, #heavyList do
		if strfind(msg, heavyList[i]) then
			points = points + 2 --Heavy section gets 2 points
			if myDebug then print("heavyList", heavyList[i], points, phishPoints, boostingPoints) end
		end
	end
	for i=1, #heavyRestrictedList do
		if strfind(msg, heavyRestrictedList[i]) then
			points = points + 2
			phishPoints = phishPoints + 1
			if myDebug then print("heavyRestrictedList", heavyRestrictedList[i], points, phishPoints, boostingPoints) end
			break --Only 1 trigger can get points in the strict section
		end
	end
	for i=1, #phishingList do
		if strfind(msg, phishingList[i]) then
			phishPoints = phishPoints + 1
			if myDebug then print("phishingList", phishingList[i], points, phishPoints, boostingPoints) end
		end
	end

	for i=1, #boostingWhiteList do
		if strfind(msg, boostingWhiteList[i]) then
			boostingPoints = boostingPoints - 1
			if myDebug then print("boostingWhiteList", boostingWhiteList[i], points, phishPoints, boostingPoints) end
		end
	end
	for i=1, #boostingList do
		if strfind(msg, boostingList[i]) then
			boostingPoints = boostingPoints + 1
			if myDebug then print("boostingList", boostingList[i], points, phishPoints, boostingPoints) end
		end
	end

	if points > 3 or phishPoints > 3 or boostingPoints > 3 then
		return true
	end
end

--[[ Chat Scanning ]]--
local Ambiguate, gsub, next, tremove, prevLineId, result, chatLines, chatPlayers, prevWarn = Ambiguate, gsub, next, tremove, 0, nil, {}, {}, 0
local filter = function(_, event, msg, player, _, _, _, flag, channelId, channelNum, _, _, lineId, guid, arg13)
	local trimmedPlayer
	if lineId == prevLineId then
		return result --Incase a message is sent more than once (registered to more than 1 chatframe)
	else
		if not lineId then --Still some addons floating around breaking stuff :-/
			local t = GetTime()
			if t-prevWarn > 30 then --Throttle this warning as I imagine it could get quite spammy
				prevWarn = t
				print("|cFF33FF99BadBoy|r: One of your addons is breaking critical chat data I need to work properly :(")
			end
			return
		end
		prevLineId, result = lineId, nil
		trimmedPlayer = Ambiguate(player, "none")
		if event == "CHAT_MSG_CHANNEL" and (channelId == 0 or type(channelId) ~= "number") then return end --Only scan official custom channels (gen/trade)
		if not myDebug and (not CanComplainChat(lineId) or UnitInRaid(trimmedPlayer) or UnitInParty(trimmedPlayer)) then return end --Don't scan ourself/friends/GMs/guildies or raid/party members
		if event == "CHAT_MSG_WHISPER" then --These scan prevention checks only apply to whispers, it would be too heavy to apply to all chat
			if flag == "GM" or flag == "DEV" then return end --GM's can't get past the CanComplainChat call but "apparently" someone had a GM reported by the phishing filter which I don't believe, no harm in having this check I guess
			--RealID support, don't scan people that whisper us via their character instead of RealID
			--that aren't on our friends list, but are on our RealID list. CanComplainChat should really support this...
			local _, num = BNGetNumFriends()
			for i=1, num do
				local toon = BNGetNumFriendToons(i)
				for j=1, toon do
					local _, rName, rGame = BNGetFriendToonInfo(i, j)
					--don't bother checking server anymore as bnet has been bugging up a lot lately
					--returning "" as server/location (probably other things too) making the check useless
					if rName == trimmedPlayer and rGame == "WoW" then
						return
					end
				end
			end
		end
	end
	local debug = msg --Save original message format
	msg = msg:lower() --Lower all text, remove capitals

	--|cffff8000|Hgarrfollower:178:5:100:690:130:131:127:0:78:186:201:79|h[|TInterface\PVPFrame\PVP-Banner-Emblem-1.png:70:70|t]|h|r
	--\124cffff8000\124Hgarrfollower:439:5:100:690:138:158:131:0:78:186:201:79\124h[Mila Kunis Leaked Photos CLICK!]\124h\124r
	-- Trade chat image abuse filtering. Since we only filter public channels and followers aren't tradeable, just flat out filter it until Blizz fixes it.
	-- Alternative would be an ever growing database and they keep changing the text for links that are just custom text with no image.
	if msg:find("hgarrfollower:", nil, true) then
		if BadBoyLog and not myDebug then
			BadBoyLog("BadBoy", event, trimmedPlayer, debug)
		end
		result = true
		return true
	end

	--They like to use raid icons to avoid detection
	local icon = 0
	if strfind(msg, "{", nil, true) then --Only run the icon removal code if the chat line has raid icons that need removed
		local found = 0
		for i=1, #restrictedIcons do
			msg, found = gsub(msg, restrictedIcons[i], "")
			if found > 0 then
				icon = 1
			end
		end
		if myDebug and icon == 1 then print("Removing icons, adding 1 point.") end
	end
	--End icon removal

	--Symbol & space removal
	msg = gsub(msg, "[%*%-%(%)\"`'_%+#%%%^&;:~{} ]", "")
	msg = gsub(msg, "¨", "")
	msg = gsub(msg, "”", "")
	msg = gsub(msg, "“", "")
	--End symbol & space removal

	--They like to replace English letters with UTF-8 "equivalents" to avoid detection
	if strfind(msg, "[аàáäâãåсçеèéëёêìíïîкΜмоòóöōôõрùúüû]+") then --Only run the string replacement if the chat line has letters that need replaced
		--This is no where near as resource intensive as I originally thought, it barely uses any CPU
		for k,v in next, repTbl do --Parse over the 'repTbl' table and replace strings
			msg = gsub(msg, k, v)
		end
		if myDebug then print("Running replacements for chat") end
	end
	--End string replacements

	--20 line text buffer, this checks the current line, and blocks it if it's the same as one of the previous 20
	for i=1, #chatLines do
		if chatLines[i] == msg and chatPlayers[i] == trimmedPlayer then --If message same as one in previous 20 and from the same person...
			result = true return true --...filter!
		end
		if i == 20 then tremove(chatLines, 1) tremove(chatPlayers, 1) end --Don't let the DB grow larger than 20
	end
	chatLines[#chatLines+1] = msg
	chatPlayers[#chatPlayers+1] = trimmedPlayer
	--End text buffer

	if IsSpam(msg, icon) then
		if BadBoyLog and not myDebug then
			BadBoyLog("BadBoy", event, trimmedPlayer, debug)
		end
		if myDebug then
			print("|cFF33FF99BadBoy_REPORT|r: ", debug, "-", event, "-", trimmedPlayer)
		else
			if BADBOY_POPUP then --Manual reporting via popup
				local dialog = StaticPopup_Show("CONFIRM_REPORT_SPAM_CHAT", trimmedPlayer, nil, lineId)
				dialog.text:SetFormattedText("BadBoy: %s \n\n %s", REPORT_SPAM_CONFIRMATION:format(trimmedPlayer), debug) --Add original spam line to Blizzard popup message
				StaticPopup_Resize(dialog, "CONFIRM_REPORT_SPAM_CHAT")
			else
				--Show block message
				if not BADBOY_NOREPORT and (not BADBOY_BLACKLIST or not BADBOY_BLACKLIST[guid]) then
					-- This code is replicated from Blizzard's ChatFrame.lua code.
					-- The intention here is to add the "extraData" flag to our AddMessage,
					-- the same way Blizz adds that data to normal messages. Then we can use the
					-- RemoveMessagesByExtraData functionality later.
					local eventType = event:sub(10) -- Trim down to CHANNEL, WHISPER, etc.
					local chatTarget
					if eventType == "CHANNEL" then
						eventType = eventType .. channelNum -- Set to CHANNEL1, CHANNEL2, etc, to separate General from Trade, etc.
						chatTarget = channelNum
					elseif eventType == "WHISPER" or eventType == "AFK" or eventType == "DND" then
						chatTarget = player:upper() -- Set to PLAYERNAME
					end
					local extraData = ChatHistory_GetAccessID(eventType, chatTarget, guid or arg13)
					-- Finally, add the message
					ChatFrame1:AddMessage(reportMsg:format(player, lineId, extraData, guid), 0.2, 1, 0.6, nil, nil, nil, extraData)
				end
			end
		end
		result = true
		return true
	end
end

--[[ Configure report links ]]--
do
	local SetHyperlink, prevReport = ItemRefTooltip.SetHyperlink, 0
	function ItemRefTooltip:SetHyperlink(link, ...)
		local badboy, player, lineId, extraData, guid = strsplit(":", link)
		if badboy and badboy == "badboy" then
			lineId = tonumber(lineId)
			extraData = tonumber(extraData)
			if CanComplainChat(lineId) then
				local t = GetTime()
				if (t-prevReport) > 8 then --Throttle reports to try and prevent disconnects, please fix it Blizz.
					prevReport = t
					ReportPlayer("spam", lineId)
					BADBOY_BLACKLIST[guid] = true
					--ChatFrame1:RemoveMessagesByExtraData(extraData) -- ReportPlayer already runs this
				else
					ChatFrame1:AddMessage(throttleMsg, 1, 1, 1, nil, nil, nil, extraData)
				end
			end
		else
			SetHyperlink(self, link, ...)
		end
	end
end

--[[ Add Filters ]]--
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK", filter)

--[[ Blacklist ]]--
do
	local f = CreateFrame("Frame")
	f:RegisterEvent("PLAYER_LOGIN")
	f:SetScript("OnEvent", function(frame)
		SetCVar("spamFilter", 1)

		-- Blacklist DB setup, needed since Blizz nerfed ReportPlayer so hard the block sometimes only lasts a few minutes.
		local _, _, day = CalendarGetDate()
		if type(BADBOY_BLACKLIST) ~= "table" or BADBOY_BLACKLIST.dayFromCal ~= day then
			BADBOY_BLACKLIST = {dayFromCal = day}
		end

		frame:UnregisterEvent("PLAYER_LOGIN")
	end)
end

