local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local TEAL		= "|cFF00FF9A"
local YELLOW	= "|cFFFFFF00"
local ORANGE	= "|cFFFF7F00"
local GRAY		= "|cFF909090"
local CYAN		= "|cFF1CFAFE"

local ICON_READY = "\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t"
local ICON_WAITING = "\124TInterface\\RaidFrame\\ReadyCheck-Waiting:14\124t"
local ICON_NOTREADY = "\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t"

-- TODO:
-- dungeons : lk raid + cata dungeon (cata raid is ok) + feats

-- category ids
local CAT_GENERAL										= 92
local CAT_QUESTS										= 96
local CAT_QUESTS_WOW									= 14861
local CAT_QUESTS_KALIMDOR							= 15081
local CAT_QUESTS_BC									= 14862
local CAT_QUESTS_WOTLK								= 14863
local CAT_QUESTS_CATACLYSM							= 15070
local CAT_QUESTS_PANDA								= 15110
local CAT_QUESTS_DRAENOR							= 15220
local CAT_EXPLORATION_OUTLAND						= 14779
local CAT_EXPLORATION_NORTHREND					= 14780
local CAT_EXPLORATION_CATA							= 15069
local CAT_EXPLORATION_PANDA						= 15113
local CAT_PVP											= 95
local CAT_PVP_ARENA									= 165
local CAT_PVP_ALTERAC								= 14801
local CAT_PVP_ARATHI									= 14802
local CAT_PVP_EOTS									= 14803
local CAT_PVP_WARSONG								= 14804
local CAT_PVP_SOTA									= 14881
local CAT_PVP_WINTERGRASP							= 14901
local CAT_PVP_CONQUEST								= 15003
local CAT_PVP_GILNEAS								= 15073
local CAT_PVP_TWINPEAKS								= 15074
local CAT_PVP_TOLBARAD								= 15075
local CAT_PVP_RATEDBG								= 15092
local CAT_PVP_SILVERSHARD							= 15162
local CAT_PVP_KOTMOGU								= 15163
local CAT_PVP_GORGE									= 15218
local CAT_DUNGEONS									= 168
local CAT_DUNGEONS_CLASSIC							= 14808
local CAT_DUNGEONS_BC								= 14805
local CAT_DUNGEONS_WOTLK							= 14806
local CAT_DUNGEONS_RAID_WOTLK						= 14922
local CAT_DUNGEONS_CATA								= 15067
local CAT_DUNGEONS_RAID_CATA						= 15068
local CAT_DUNGEONS_PANDA							= 15106
local CAT_DUNGEONS_RAID_PANDA						= 15107
local CAT_DUNGEONS_DRAENOR							= 15228
local CAT_DUNGEONS_RAID_DRAENOR					= 15231
local CAT_DUNGEONS_CHALLENGES						= 15115
local CAT_PROFESSIONS								= 169
local CAT_PROFESSIONS_COOKING						= 170
local CAT_PROFESSIONS_FISHING						= 171
local CAT_PROFESSIONS_FIRSTAID					= 172
local CAT_PROFESSIONS_ARCHA						= 15071
local CAT_SCENARIOS									= 15165
local CAT_SCENARIOS_PROVINGGROUNDS				= 15222
local CAT_REPUTATIONS								= 201
local CAT_REPUTATIONS_BC							= 14865
local CAT_REPUTATIONS_WOTLK						= 14866
local CAT_REPUTATIONS_CATA							= 15072
local CAT_REPUTATIONS_MOP							= 15114
local CAT_REPUTATIONS_WOD							= 15232
local CAT_EVENTS										= 155
local CAT_EVENTS_LUNARFESTIVAL					= 160
local CAT_EVENTS_LOVEISINTHEAIR					= 187
local CAT_EVENTS_NOBLEGARDEN						= 159
local CAT_EVENTS_MIDSUMMER							= 161
local CAT_EVENTS_BREWFEST							= 162
local CAT_EVENTS_HALLOWSEND						= 158
local CAT_EVENTS_PILGRIMSBOUNTY					= 14981
local CAT_EVENTS_WINTERVEIL						= 156
local CAT_EVENTS_ARGENTTOURNAMENT				= 14941
local CAT_EVENTS_DARKMOON							= 15101
local CAT_EVENTS_BRAWLER							= 15202
local CAT_PET_BATTLES								= 15117
local CAT_PET_BATTLES_COLLECT						= 15118
local CAT_PET_BATTLES_BATTLE						= 15119
local CAT_PET_BATTLES_LEVEL						= 15120
local CAT_COLLECTIONS								= 15246
local CAT_COLLECTIONS_TOYBOX						= 15247
local CAT_COLLECTIONS_MOUNTS						= 15248
local CAT_LEGACY										= 15234
local CAT_FEATS										= 81

-- list of achievements, per category. The list is obviously comma-separated, and faction specific achievements are under the form "alliance:horde"
-- note: if the achievement name is different (eg: "for the alliance!" & "for the horde") do NOT treat them as combined achievements: they should appear on different lines in the UI.
local SortedAchievements = {
	-- To improve readability, these categories will be pre-sorted, even partially, in order to list achievements
	-- in a meaningful order (regardless of localization), as a pure alphabetical order is not always relevant, ex: 10, 100, 1000, 25, 250..etc 
	-- these arrays will thus be used as the first lines in the view, and the complement will be sorted alphabetically.
	
	-- levels, got my mind on my money, riding skill, mounts, pets, tabards, superior items
	[CAT_GENERAL] = "6,7,8,9,10,11,12,13,4826,6193,9060,7382,7383,7384,7380,1176,1177,1178,1180,1181,5455,5456,6753,9487,891,889,890,892,5180,557,556,5373,5372,6348,6349,9707,9708,5753,7329,7330,9502",
	[CAT_QUESTS] = "503,504,505,506,507,508,32,978,973,974,975,976,977,5751,7410,7411,4956,4957,1576,4958,1182,5752",		-- quests completed,  daily quests completed, dungeon, fight club
	[CAT_QUESTS_WOW] = "4896,4900,4909,4901,4905,4892,4908,4895,4897,4899,4906,4902,4910,4894,4904,4893,4903,1676:1677",
	[CAT_QUESTS_KALIMDOR] = "4925:4976,4927,4926,4928,4930,4929:4978,4931,4932:4979,4933,4934,4937:4981,4936:4980,4935,4938,4939,4940,1678:1680",
	[CAT_QUESTS_BC] = "1189:1271,1190,1191:1272,1192:1273,1193,1194,1195,1262:1274,1275,939,1276",
	[CAT_QUESTS_WOTLK] = "33:1358,34:1356,35:1359,37:1357,36,39,38,40,41:1360",
	[CAT_QUESTS_CATACLYSM] = "4870,4869:4982,4871,4872,4873:5501,4875:4983,4874",
	[CAT_QUESTS_PANDA] = "6300:6534,6301,6535:6536,6537:6538,6539,6540,7928,7929,8099,6541,8121",
	[CAT_EXPLORATION_OUTLAND] = "862,863,867,866,865,843,864,1311,1312",
	[CAT_EXPLORATION_NORTHREND] = "1263,1264,1265,1266,1267,1457,1268,1269,1270,2256,2257",
	[CAT_EXPLORATION_CATA] = "4863,4825,4864,4865,4866,4975,5518,4827",
	[CAT_EXPLORATION_PANDA] = "6351,6969,6975,6976,6977,6978,6979,7437,7438,7439,8103,7932,7994,7995,7996,7997,7281,7282,7283,7284",
	[CAT_PVP] = "238,513,515,516,512,509,239,869,870,5363,5542,5541,5540,5539,8218:8093,230:1175,8052:8055,714,907,615,616,617,618,619,610,612,613,611,614",
	[CAT_PVP_ARENA] = "397,398,875,876,1174,2090,2093,2092,2091",
	[CAT_PVP_ALTERAC] = "218,219,1167",
	[CAT_PVP_ARATHI] = "154,155,1169",
	[CAT_PVP_EOTS] = "208,209,1171",
	[CAT_PVP_WARSONG] = "166,167,1172",
	[CAT_PVP_SOTA] = "1308,1309,2194",
	[CAT_PVP_WINTERGRASP] = "1717,1718,1752,1722,1721,3136,3137,3836,3837,4585,4586",
	[CAT_PVP_CONQUEST] = "3776,3777,3857:3957",
	[CAT_PVP_GILNEAS] = "5245,5246,5258",
	[CAT_PVP_TWINPEAKS] = "5208,5209,5223",
	[CAT_PVP_TOLBARAD] = "5412,5417:5418,5489:5490,5416,6045,6108",
	[CAT_PVP_RATEDBG] = "5269,5323,5324,5325,5824,5326,5345,5346,5347,5348,5349,5350,5351,5352,5338,5353,5354,5355,5342,5356,6941,5268,5322,5327,5328,5823,5329,5330,5331,5332,5333,5334,5335,5336,5337,5359,5339,5340,5341,5357,5343,6942",
	[CAT_PVP_SILVERSHARD] = "6739,6883,7106",
	[CAT_PVP_KOTMOGU] = "6740,6882,6981",
	[CAT_PVP_GORGE] = "8331,8332,8360",
	[CAT_DUNGEONS] = "1283,1285,1284,1287,1286,1288,1289,2136,2137,2138,1658,2957,2958,4016,4017,4602,4603,4844,4845,4853,5506,5828,6169,6925,6927,6932,8124,6926,8454,9391,9396,8985,9619,4476,4477,4478",
	[CAT_DUNGEONS_CLASSIC] = "629,628,630,631,632,633,635,634,636,637,7413,638,639,640,641,642,643,1307,644,645,646,689,686,685,687,2188",
	[CAT_DUNGEONS_BC] = "647,667,648,668,649,669,650,670,651,671,666,672,652,673,653,674,654,675,655,676,656,677,657,678,658,679,659,680,660,681,661,682,690,692,693,694,696,695,697,698",
	[CAT_DUNGEONS_WOTLK] = "477,489,478,490,480,491,481,492,482,493,483,494,484,495,485,496,486,497,487,498,488,499,479,500,4296:3778,4298:4297,4516,4519,4517,4520,4518,4521",
	[CAT_DUNGEONS_RAID_WOTLK] = "562,563,564,565,566,567,568,569,572,573,574,575,576,577,1876,625,622,623,2886,2887,2888,2889,2890,2891,2892,2893,2894,2895,3036,3037,3917,3916,3918,3812,4396,4397,4531,4604,4528,4605,4529,4606,4527,4607,4530,4597,4532,4608,4628,4632,4629,4633,4630,4634,4631,4635,4583,4584,4636,4637,4817,4815,4818,4816",
	[CAT_DUNGEONS_CATA] = "4833,5060,4839,5061,4846,5063,4847,5064,4840,5062,4841,5065,4848,5066,5083,5093,5769,5768,6117,6118,6119",
	[CAT_DUNGEONS_RAID_CATA] = "4842,5094,5107,5108,5109,5115,5116,4850,5118,5117,5119,5120,5121,4851,5122,5123,5802,5807,5808,5809,5806,5805,5804,5803,6106,6107,6177,6109,6110,6111,6112,6113,6114,6115,6116",
	[CAT_DUNGEONS_PANDA] = "6757,6758,6457,6456,6469,6470,6755,6756,6759,6760,6761,6762,6763",
	[CAT_DUNGEONS_RAID_PANDA] = "6480,6517,8028,8123,6458,6844,6719,6720,6721,6722,6723,6724,6718,6845,6725,6726,6727,6728,6729,6730,6689,6731,6732,6733,6734,8069,8056,8057,8058,8070,8059,8060,8061,8071,8062,8063,8064,8072,8065,8066,8067,8068",
	[CAT_DUNGEONS_CHALLENGES] = "8879,8880,8881,8882,8875,8876,8877,8878,8887,8888,8889,8890,8997,8998,8999,9000,8883,8884,8885,8886,8871,8872,8873,8874,9001,9002,9003,9004,8891,8892,8893,8894,8895,8897,8898,8899",
	[CAT_PROFESSIONS] = "116,731,732,733,734,4924,6830,730,4915,6836,735,4914,6835,9071,9454,9453,7378,7379,9506,9464,9507,9087",							-- professional journeyman, etc..
	[CAT_PROFESSIONS_COOKING] = "121,122,123,124,125,4916,6365,7300,7301,7302,7303,7304,7305,7306,9500,1999,2000,2001,2002,1795,1796,1797,1798,1799,5471,7328,1800,1777,1778,1779,5472,5473,7326,7327,9501",			-- level, dalaran awards, num recipes, gourmet
	[CAT_PROFESSIONS_FISHING] = "126,127,128,129,130,4917,9503,1556,1557,1558,1559,1560,1561,2094,2095,1957,2096,9456,9457,9458,9459,9455,9460,9461,9462",						-- level, num fishes, dalaran coins
	[CAT_PROFESSIONS_FIRSTAID] = "131,132,133,134,135,4918,6838,9505",					-- journeyman, expert, artisan, master, grand master
	[CAT_PROFESSIONS_ARCHA] = "4857,4919,4920,4921,4922,4923,6837,9409,5315,5469,5470,4854,4855,4856,9422,8222,8223,7345,7365,8220,8221,7343,7363,7349,7369,7353,7373,7342,7362,7344,7364,8226,8227,7354,7374,8234,8235,7348,7368,8230,8231,7356,7376,7339,7359,7338,7358,7346,7366,7351,7371,8232,8233,8224,8225,8228,8229,7347,7367,7350,7370,7352,7372,7340,7360,7341,7361,7355,7375,7357,7377,",
	[CAT_SCENARIOS] = "6943,7252,8310,7271,6923,7522,8311,7265,7523:7524,7249,6874:7509,8016,8009,8013,7988,8010,8314:8315,8364:8366,8316,8312,8317,8318,8294,8327",
	[CAT_SCENARIOS_PROVINGGROUNDS] = "9572,9573,9574,9575,9576,9577,9578,9579,9580,9581,9582,9583,9584,9585,9586,9587,9588,9589,9590",
	[CAT_REPUTATIONS] = "522,523,524,521,520,519,518,1014,1015,5374,5723,6826,6742",		-- exalted reputations
	[CAT_REPUTATIONS_WOD] = "9469,9470,9471,9472,9476,9474,9475,9473,9478:9477,9072",
	[CAT_EVENTS] = "9426,9427,9428",
	[CAT_EVENTS_LOVEISINTHEAIR] = "9389,9392,9393,9394",
	[CAT_EVENTS_LUNARFESTIVAL] = "605,606,607,608,609",				-- coins of ancestry
	[CAT_EVENTS_ARGENTTOURNAMENT] = "2756,2758,2777,2760,2779,2762,2780,2763,2781,2764,2778,2761,2782,2770,2817,2783,2765,2784,2766,2785,2767,2786,2768,2787,2769,2788,2771,2816",
	[CAT_EVENTS_DARKMOON] = "9250,9251,9252",
	[CAT_EVENTS_BRAWLER] = "9168:9172,9169:9173,9170:9174,9171:9175,9176:9177,7949:7950,7943,7945,7944",
	[CAT_PET_BATTLES] = "7482,7483,6600,7521,6601,7498,7499,6603,6602,6604,6605,7525,6606,6607,9724,7908,7936,8080,9712",
	[CAT_PET_BATTLES_COLLECT] = "1017,15,1248,1250,2516,5876,5877,5875,7500,7501,9643,6554,6555,6556,6557,7436,6585,6586,6587,6588,6589,6590,9685,6612,6613,6614,6615,6616,6611,7465,7462,7463,7464,6608,6571,7934,8519,8397",
	[CAT_PET_BATTLES_BATTLE] = "6594,6593,6462,6591,6592,9463,6595,6596,6597,6598,6599,8297,8298,8300,8301,6618,6619,6558,6559,6560,6584,6621,6622",
	[CAT_PET_BATTLES_LEVEL] = "7433,6566,6567,6568,6569,6570,6579,6580,6583,6578,6581,6582,6609,6610,9070",
	[CAT_COLLECTIONS] = "621,1020,1021,5755",
	[CAT_COLLECTIONS_TOYBOX] = "9670,9671,9672,9673",
	[CAT_COLLECTIONS_MOUNTS] = "2141,2142,2143,2536:2537,7860:7862,8302:8304,9598:9599",
}

local UnsortedAchievements = {
	[CAT_GENERAL] = "545,546,558,559,964,1206,1244,1254,1832,1833,1956,2556,2557,2716,5548,5754,6350,5779,9547",
	[CAT_QUESTS] = "31,941,7520",
	[CAT_QUESTS_WOW] = "5442,5444,940",
	[CAT_QUESTS_KALIMDOR] = "5443,5453,5448,5546,5547,5454",
	[CAT_QUESTS_WOTLK] = "547,561,938,961,962,1277,1428,1596",
	[CAT_QUESTS_CATACLYSM] = "4874,5318:5319,4959,5483,5451,5482,5450,5445,5317,4961,5447,5449,4960,5446,5452,5481,5320:5321,5859,5860,5861,5862,5864,5865,5866,5867,5868,5869,5870,5871,5872,5873,5874,5879",
	[CAT_QUESTS_PANDA] = "7318,7294,7296,7312,7287,7323,7310,7320,7285,7286,7309,7298,7292,7290,7291,7308,7295,7299,7317,7324,7316,7297,7319,7322,7502,7289,7307,7321,7313,7314,7293,7288,8112,8118,8120,8117,8101,8119,8100,8114,8107,8115,8105,8109,8110,8111,8104,8108,8116,8212",
	[CAT_QUESTS_DRAENOR] = "8671,8845,8919,8920,8921,8922,8923,8924,8925,8926,8927,8928,9432,9433,9434,9435,9436,9437,9479,9481,9483,9486,9491,9492,9528,9529,9530,9531,9533,9534,9535,9536,9537,9541,9548,9562,9564,9571,9602,9605,9606,9607,9610,9612,9613,9615,9617,9632,9633,9634,9635,9636,9637,9638,9640,9641,9642,9654,9655,9656,9658,9659,9663,9667,9674,9678,9710,9711",
	
--	[CAT_EXPLORATION_OUTLAND] = fully sorted
--	[CAT_EXPLORATION_NORTHREND] = fully sorted
--	[CAT_EXPLORATION_CATA] = fully sorted
	[CAT_EXPLORATION_PANDA] = "6856,6716,6846,6857,6850,7230,7381,6754,6855,6847,7518,6858,8051,8050,8049,8726,8725,8712,8723,8724,8730",
	[CAT_PVP] = "727,909:909,388:1006,227,1157,701,700,2016:2017,396,389,246:1005,247,245,229,604,603,231",
	[CAT_PVP_ARENA] = "406,407,404,1161,408,1162,399,400,401,1159,409,402,403,405,1160,5266,5267,699",
	[CAT_PVP_ALTERAC] = "221,582,225:1164,706,873,708,709,1151:224,707,220,226,223,1166,222",
	[CAT_PVP_ARATHI] = "583,584,165,73,711,159,158,1153,161,156,710,157,162",
	[CAT_PVP_EOTS] = "233,216,784,214,212,211,213,587,1258,783",
	[CAT_PVP_WARSONG] = "199,872,204,203:1251,1259,200,202:1502,207,713,206:1252,201,168,712",
	[CAT_PVP_SOTA] = "2191,1766,2189,1763,1757:2200,2190,1764,2193,1762:2192,1765,1310,1761",
	[CAT_PVP_WINTERGRASP] = "2080,1737:2476,1751,1727,1723,2199,1755",
	[CAT_PVP_CONQUEST] = "3848,3849,3853,3854,3852,3856:4256,3847,3855,3845,3851:4177,3850,3846:4176",
	[CAT_PVP_GILNEAS] = "5256,5257,5247,5248,5252,5262,5253,5255,5254,5251,5249,5250",
	[CAT_PVP_TWINPEAKS] = "5226:5227,5231:5552,5229,5221:5222,5220:5219,5216,5213:5214,5211,5230,5215,5210,5228",
	[CAT_PVP_TOLBARAD] = "5718:5719,5486,5487,5415,5488",
--	[CAT_PVP_RATEDBG] = fully sorted
	[CAT_PVP_SILVERSHARD] = "7057,7102,7099,7103,7049,7062,7100,7039",
	[CAT_PVP_KOTMOGU] = "6970,6973,6947,6971,6950,6980,6972",
	[CAT_PVP_GORGE] = "8359,8358,8333,8350,8351,8354,8355",
	[CAT_DUNGEONS_WOTLK] = "1296,1297,1816,1817,1834,1860,1862,1864,1865,1866,1867,1868,1871,1872,1873,1919,2036,2037,2038,2039,2040,2041,2042,2043,2044,2045,2046,2056,2057,2058,2150,2151,2152,2153,2154,2155,2156,2157,3802,3803,3804,4522,4523,4524,4525,4526",
	[CAT_DUNGEONS_RAID_WOTLK] = "1869,1870,2919,2921,4580,4620,3159,3164,2176,2177,1858,1859,4601,4621,4534,4610,2945,2946,2947,2948,2961,2962,2980,2981,3006,3007,4538,4614,2985,2984,2148,2149,2953,2954,2971,2972,3008,3010,3097,3098,4016,4017,3180,3189,4577,4615,4535,4611,2982,2983,2967,2968,2047,2048,3058,3059,3012,3013,2927,2928,2939,2942,2941,2944,2940,2943,3182,3184,2963,2965,3181,3188,2955,2956,2973,2974,4536,4612,3015,3016,2923,2924,4537,4613,2184,2185,3009,3011,3177,3185,3178,3186,3179,3187,624,1877,3176,3183,2979,3118,1856,1857,4403,4406,1997,2140,4402,4405,2937,2938,4578,4616,4581,4622,2931,2932,2934,2936,2933,2935,3076,3077,3936,3937,3138,2995,2915,2917,4539,4618,3158,3163,2913,2918,2914,2916,3056,3057,4579,4619,3798,2959,2960,3799,3815,2989,3237,2996,2997,2925,2926,4404,4407,2178,2179,2911,2912,2977,2978,2182,2183,2969,2970,2930,2929,2180,2181,3003,3002,2909,2910,578,579,2146,2147,4582,4617,1996,2139,3800,3816,2051,2054,3014,3017,2907,2908,3157,3161,3996,3997,2049,2052,2050,2053,3141,3162,2905,2906,3797,3813,2975,2976,2951,2952,1874,1875",
	[CAT_DUNGEONS_CATA] = "5858,5291,5282,5284,5505,5281,5298,5289,5296,5292,5293,5370,5369,5290,5288,5285,5503,5286,5368,5367,5366,5287,5294,5295,5504,5283,5297,5371,5744,5765,5761,5743,5762,5760,5759,5750,6132,6127,5995,6130,6070",
	[CAT_DUNGEONS_RAID_CATA] = "5310,5307,5829,6180,5821,6105,5813,6174,4852,5311,5305,5309,6175,4849,6133,6084,5810,5799,5306,6128,5855,5830,5308,5304,6129,5312,5300",
	[CAT_DUNGEONS_PANDA] = "6929,6531,6479,6928,6475,6476,6946,6478,6471,6420,6400,6684,6460,6089,6402,6945,6427,6715,6713,6394,6477,6485,6822,6396,6821,6671,6472,6736,6688",
	[CAT_DUNGEONS_RAID_PANDA] = "7933,6674,6936,6824,6687,6518,6683,6553,6823,6937,6717,6455,7056,6686,6825,6922,6933,8090,8073,8087,8038,8086,8037,8082,8094,8077,8081,8097,8098,8535,8679,8529,8462,8520,8448,8459,8527,8528,8465,8468,8482,8511,8471,8463,8469,8470,8472,8466,8481,8467,8480,8478,8479,8543,8680,8536,8532,8531,8533,8453,",
--	[CAT_PROFESSIONS] = fully sorted
	[CAT_PROFESSIONS_COOKING] = "877,906,1563:1784,1780,1781,1782:1783,1785,1801,1998,3296,5474,5475,5845:5846,5842,5841,5843,5844,7325",
	[CAT_PROFESSIONS_FISHING] = "144,150,153,306,726,878,905,1225,1243,1257,1516,1517,1836,1837,1958,3217,3218,5476,5477,5478,5479,5848,5847,5849,5850,5851:5852,7611,7274,7614",
	[CAT_PROFESSIONS_FIRSTAID] = "137,141,5480",
	[CAT_PROFESSIONS_ARCHA] = "5193,5511,4859,4858,5301,5192,5191,7331,7332,7333,7334,7335,7336,7337,7612,8219,9412,9419,9411,9414,9415,9413,9410",
	[CAT_SCENARIOS] = "8017,7992,7987,8011:8014,7989,8012:8015,7984,7993,7991,7986,7990,6930,6931,7231,7232,7239,7248,7257,7258,7261,7266,7267,7272,7273,7275,7276,7385,7526:7529,7527:7530,8295,8319,8329,8330,8368,8347",
	[CAT_REPUTATIONS] = "762,942:943,945,948,953,5794",
	[CAT_REPUTATIONS_BC] = "896,893,902,894,901,899,898,903,1638,958,764:763,900,959,960,897",
	[CAT_REPUTATIONS_WOTLK] = "950,2083,2082,1009,952,1010,947,4598,1008,951,1012:1011,1007,949",
	[CAT_REPUTATIONS_CATA] = "5375,4886,5376,4884,4881,4882,4883,4885,5827",	
	[CAT_REPUTATIONS_MOP] = "6366,6543,6544,6545,6546,6547,6548,6550,6551,6552,6828:6827,7479,8208:8206,8205:8209,8210,8715",	
	[CAT_EVENTS] = "1683,3456,1693,1793,1656,1691,2798,3478,3457,1039,1038,913,2144",
	[CAT_EVENTS_LUNARFESTIVAL] = "626,910,911,912,914,915,937,1281,1396,1552,6006",
	[CAT_EVENTS_LOVEISINTHEAIR] = "1701,260,1695,1699,1279:1280,1704,1291,1694,1703,1697:1698,1700,1188,1702,1696,4624",
	[CAT_EVENTS_NOBLEGARDEN] = "2576,2418,2417,2436,249,2416,2676,2421:2420,2422,2419:2497,248",
	[CAT_EVENTS_MIDSUMMER] = "271,1037,1035,1028:1031,1029:1032,1030:1033,1025,1026,1027,1022,1023,1024,263,1145,1034:1036,272,6007:6010,6013:6014,6011:6012,6008:6009,8042:8043,8045:8044",
	[CAT_EVENTS_BREWFEST] = "2796,1183,295,293,1936,1186,1260,303,1184:1203,1185",
	[CAT_EVENTS_HALLOWSEND] = "284,255,291,1261,288,1040:1041,292,981,979,283,289,972,971,966:967,963:965,969:968,5836:5835,5837:5838,7601:7602",
	[CAT_EVENTS_PILGRIMSBOUNTY] = "3579,3576:3577,3556:3557,3580:3581,3596:3597,3558,3582,3578,3559",
	[CAT_EVENTS_WINTERVEIL] = "277,1690,4436:4437,1686:1685,1295,1282,1689,1687,273,1255:259,279,1688,252,5853:5854",
	[CAT_EVENTS_ARGENTTOURNAMENT] = "3676,2773,2836,3736,3677,4596,2772",
	[CAT_EVENTS_DARKMOON] = "6019,6020,6021,6022,6023,6024,6025,6026,6027,6028,6029,6030:6031,6032,6332",
--	[CAT_PET_BATTLES_COLLECT] = fully sorted
	[CAT_PET_BATTLES_BATTLE] = "6581,6620,8348,8518,9069",
	
	[CAT_COLLECTIONS] = "8728,1165,2084",
--	[CAT_COLLECTIONS_TOYBOX] = fully sorted
	[CAT_COLLECTIONS_MOUNTS] = "2076,2077,2078,2097,4888,5749,7386,9713",
--	[CAT_LEGACY] = can't be listed, GetAchievementInfo only returns a value for achievements earned by at least one alt..
	[CAT_FEATS] = "411,412,414,415,416,418,419,420,424,425,426,428,429,430,456,457,458,459,460,461,462,463,464,465,466,467,662,663,664,665,683,725,729,871,879,880,881,882,883,884,885,886,887,888,980,1205,1292,1293,1400,1402,1404,1405,1406,1407,1408,1409,1410,1411,1412,1413,1414,1415,1416,1417,1418,1419,1420,1421,1422,1423,1424,1425,1426,1427,1436,1463,1636,1637,1705,1706,2079,2081,2116,2316,2336,2357,2359,2398,2456,2496,3004,3005,3096,3117,3142,3259,3316,3336,3356,3357,3436,3536,3618,3636,3756,3757,3758,3896,4078,4079,4156,4400,4496,4576,4599,4600,4623,4625,4626,4627,4782,4786,4790,4824,4832,4887,4998,4999,5000,5001,5002,5003,5004,5005,5006,5007,5008,5313,5344,5358,5377,5378,5381,5382,5383,5384,5385,5386,5387,5388,5389,5390,5391,5392,5393,5394,5395,5396,5512,5533,5767,5788,5839,5863,6002,6003,6059,6060,6061,6124,6131,6181,6185,6316,6317,6322,6433,6523,6524,6741,6743,6744,6745,6746,6747,6748,6749,6750,6751,6752,6829,6848,6849,6859,6860,6861,6862,6863,6864,6865,6866,6867,6868,6869,6870,6871,6872,6873,6938,6939,6940,6954,7412,7467,7468,7485,7486,7487,7842,7852,7853,8089,8092,8093,8213,8214,8216,8218,8238,8243,8244,8246,8248,8249,8260,8345,8381,8382,8391,8392,8398,8399,8400,8401,8430,8431,8432,8433,8434,8436,8437,8438,8439,8450,8451,8484,8485,8641,8642,8643,8644,8645,8646,8649,8652,8653,8654,8657,8658,8659,8666,8667,8668,8669,8670,8678,8698,8705,8707,8791,8793,8794,8795,8820,8903,8916,8917,9016,9229,9230,9231,9232,9239,9240,9241,9242,9441,9442,9443,9444,9496,9550,9566,9597,9618,9620,9621,9622,9623,9624,9625,9626,9627,9680,9725,9729",
}

local AchievementsList = {}

local function SortByName(a, b)
	if type(a) == "string" then
		a = strsplit(":", a)
		a = tonumber(a)
	end
	if type(b) == "string" then
		b = strsplit(":", b)
		b = tonumber(b)
	end

	local nameA = select(2, GetAchievementInfo(a)) or ""
	local nameB = select(2, GetAchievementInfo(b)) or ""
	return nameA < nameB
end

local function AddAchievementToCategory(categoryID, achievement)
	-- if the achievement is a number or a string that can be converted to a number, add it as a number
	-- else add it as a string . This will be the case for faction specific achievements. 
	--	ex: "122:123" would mean that 122 is the alliance version of the achievement, and 123 the horde version
	table.insert(AchievementsList[categoryID], tonumber(achievement) or achievement)
end

local function BuildCategoryList(categoryID)
	-- each category is a sub-table of the reference table.
	AchievementsList[categoryID] = {}

	--	if this category does not contain series or faction specific achievements : use the game's list
	if not SortedAchievements[categoryID] and not UnsortedAchievements[categoryID] then
		local id
		for i = 1, GetCategoryNumAchievements(categoryID) do
			id = GetAchievementInfo(categoryID, i)
			AddAchievementToCategory(categoryID, id)
		end
		table.sort(AchievementsList[categoryID], SortByName)
		return
	end
	
	--	otherwise : use the list of sorted achievements .. 
	if SortedAchievements[categoryID] then
		for achievement in SortedAchievements[categoryID]:gmatch("([^,]+)") do
			AddAchievementToCategory(categoryID, achievement)
		end
	end
	
	-- .. then add the unsorted ones after they've been sorted alphabetically.
	if UnsortedAchievements[categoryID] then
		local remaining = {}
		for achievement in UnsortedAchievements[categoryID]:gmatch("([^,]+)") do
			table.insert(remaining, tonumber(achievement) or achievement)
		end
		table.sort(remaining, SortByName)	-- sort remaining achievements by name ..
		
		for _, achievement in pairs(remaining) do		
			AddAchievementToCategory(categoryID, achievement)
		end
	end
end

local function BuildReferenceTable()
	-- based on the list of achievements that should be sorted in a predefined order, and the remaining achievements (ordered alphabetically, with the influence of localized named), create a reference table
	-- that will allow easy use of categories/lists which support both factions.
	
	local cats = GetCategoryList()
	for _, categoryID in ipairs(cats) do
		local _, parentID = GetCategoryInfo(categoryID)
		
		if parentID == -1 then		-- add categories, followed by their respective sub-categories
			BuildCategoryList(categoryID)
			
			for _, subCatID in ipairs(cats) do
				local _, subCatParentID = GetCategoryInfo(subCatID)
				if subCatParentID == categoryID then
					BuildCategoryList(subCatID)
				end
			end
		end
	end
end

-- now that this part of the UI is LoD, this can be called here
BuildReferenceTable()

SortedAchievements = nil
UnsortedAchievements = nil
BuildReferenceTable = nil
BuildCategoryList = nil
AddAchievementToCategory = nil
SortByName = nil


local function GetCategorySize(categoryID)
	if type(AchievementsList[categoryID]) == "table" then
		return #AchievementsList[categoryID]
	end
	return 0
end

local function GetAchievementFactionInfo(categoryID, index)
	if type(AchievementsList[categoryID]) == "table" then
		local achievement = AchievementsList[categoryID][index]
		
		if type(achievement) == "number" then
			return achievement								-- return achievement ID
		elseif type(achievement) == "string" then
			local ally, horde = strsplit(":", achievement)
			return tonumber(ally), tonumber(horde)		-- return alliance ach id, horde ach id
		end
	end
end

local CRITERIA_COMPLETE_ICON = "\124TInterface\\AchievementFrame\\UI-Achievement-Criteria-Check:14\124t"

local function ButtonOnEnter(frame)
	local character = frame.key
	if not character then return end
	
	local achievementID = frame.id
	local _, achName, points, _, _, _, _, description, flags, image, rewardText = GetAchievementInfo(achievementID);

-- debug
	-- DEFAULT_CHAT_FRAME:AddMessage("id: " .. achievementID .. " name: " .. achName .. " icon: " .. image)
	
	local isAccountBound = ( bit.band(flags, ACHIEVEMENT_FLAGS_ACCOUNT) == ACHIEVEMENT_FLAGS_ACCOUNT ) 
	
	AltoTooltip:SetOwner(frame, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();
	AltoTooltip:AddDoubleLine(DataStore:GetColoredCharacterName(character), achName)
	AltoTooltip:AddLine(WHITE .. description, 1, 1, 1, 1, 1);
	AltoTooltip:AddLine(WHITE .. ACHIEVEMENT_TITLE .. ": " .. YELLOW .. points);
	AltoTooltip:AddLine(" ");

	local isStarted, isComplete = DataStore:GetAchievementInfo(character, achievementID, isAccountBound)
	
	if isComplete then
		AltoTooltip:AddLine(format("%s: %s", WHITE .. STATUS, GREEN .. COMPLETE ));
	elseif isStarted then
		local numCompletedCriteria = 0
		local numCriteria = GetAchievementNumCriteria(achievementID)
		
		for criteriaIndex = 1, numCriteria do	-- browse all criterias
			local criteriaString, criteriaType, _, _, reqQuantity, _, _, assetID = GetAchievementCriteriaInfo(achievementID, criteriaIndex);
			if criteriaType == CRITERIA_TYPE_ACHIEVEMENT and assetID then		-- if criteria is another achievement
				_, criteriaString = GetAchievementInfo(assetID);
			end
			
			local isCriteriaStarted, isCriteriaComplete, quantity = DataStore:GetCriteriaInfo(character, achievementID, criteriaIndex, isAccountBound)

			local icon = ""
			local color = GRAY

			if isCriteriaComplete then
				icon = CRITERIA_COMPLETE_ICON
				numCompletedCriteria = numCompletedCriteria + 1
				color = GREEN
			elseif isCriteriaStarted then
				if tonumber(quantity) > 0 then
					criteriaString = criteriaString .. WHITE
				end
				
				if criteriaType == 62 or criteriaType == 67 then		-- this type is an amount of gold, format it as such, make something more generic later on if necessary
					quantity = addon:GetMoneyString(tonumber(quantity))
					reqQuantity = addon:GetMoneyString(tonumber(reqQuantity))
					criteriaString = format(" - %s (%s/%s)", criteriaString, quantity..WHITE, reqQuantity..WHITE)
				else
					criteriaString = format(" - %s (%s/%s)", criteriaString, quantity, reqQuantity)
				end
			else
				criteriaString = format(" - %s", criteriaString)
			end
			
			AltoTooltip:AddLine(format("%s%s%s", icon, color, criteriaString))
		end
		
		if numCriteria > 1 then
			AltoTooltip:AddLine(" ");
			AltoTooltip:AddLine(format("%s: %s%d/%d", WHITE..STATUS, GREEN, numCompletedCriteria, numCriteria));
		end
	else
		for i = 1, GetAchievementNumCriteria(achievementID) do	-- write all criterias in gray
			local criteriaString, criteriaType, _, _, _, _, _, assetID = GetAchievementCriteriaInfo(achievementID, i);
			if criteriaType == CRITERIA_TYPE_ACHIEVEMENT and assetID then		-- if criteria is another achievement
				_, criteriaString = GetAchievementInfo(assetID);
			end
		
			AltoTooltip:AddLine(GRAY .. " - " .. criteriaString);
		end
	end
	
	if strlen(rewardText) > 0 then		-- not nil if empty, so test the length of the string
		AltoTooltip:AddLine(" ");
		AltoTooltip:AddLine(GREEN .. rewardText);
	end

	if isStarted or isComplete then
		AltoTooltip:AddLine(" ");
		AltoTooltip:AddLine(GREEN .. L["Shift+Left click to link"]);
	end
	-- AltoTooltip:AddLine(GREEN .. "id : " .. achievementID);			-- debug
	
	AltoTooltip:Show();
end

local function ButtonOnClick(frame, button)
	local character = frame.key
	if not character then return end
	
	if ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
		local chat = ChatEdit_GetLastActiveWindow()
	
		if chat:IsShown() then
			local achievementID = frame.id

			local link = DataStore:GetAchievementLink(character, achievementID)
			if link then 
				chat:Insert(link)
			end		
		end
	end
end

addon.Achievements = {}

local ns = addon.Achievements		-- ns = namespace

local currentCategoryID

function ns:SetCategory(categoryID)
	currentCategoryID = categoryID
end

function ns:Update()
	local VisibleLines = 8
	local frame = "AltoholicFrameAchievements"
	local entry = frame.."Entry"
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local categorySize = GetCategorySize(currentCategoryID)
	
	local realm, account = addon.Tabs.Achievements:GetRealm()
	local character
		
	local achStatus
	local isAccountBound
	
	AltoholicTabAchievementsStatus:SetText(format("%s: %s", ACHIEVEMENTS, GREEN..categorySize ))
	
	for i=1, VisibleLines do
		local line = i + offset
		if line <= categorySize then	-- if the line is visible
			local achievementID
			local allianceID, hordeID = GetAchievementFactionInfo(currentCategoryID, line)
			
			local _, achName, _, isComplete, _, _, _, _, flags = GetAchievementInfo(allianceID)		-- use the alliance name if a

			-- if not achName then 
				-- DEFAULT_CHAT_FRAME:AddMessage(allianceID)
				-- achName = allianceID
			-- end
			
			isAccountBound = ( bit.band(flags, ACHIEVEMENT_FLAGS_ACCOUNT) == ACHIEVEMENT_FLAGS_ACCOUNT ) 
			
			_G[entry..i.."Name"]:SetText((isAccountBound and CYAN or WHITE) .. achName)
			_G[entry..i.."Name"]:SetJustifyH("LEFT")
			_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
			
			for j = 1, 11 do
				local itemName = entry.. i .. "Item" .. j;
				local itemButton = _G[itemName]
				local itemTexture = _G[itemName .. "_Background"]
				
				character = addon:GetOption(format("Tabs.Achievements.%s.%s.Column%d", account, realm, j))
				if character then
					itemButton:SetScript("OnEnter", ButtonOnEnter)
					itemButton:SetScript("OnClick", ButtonOnClick)
					
					if hordeID and DataStore:GetCharacterFaction(character) ~= "Alliance" then
						achievementID = hordeID
					else
						achievementID = allianceID
					end
					
					local isStarted, isComplete = DataStore:GetAchievementInfo(character, achievementID, isAccountBound)

					if isComplete then
						itemTexture:SetVertexColor(1.0, 1.0, 1.0);
						achStatus = ICON_READY
					elseif isStarted then
						achStatus = ICON_WAITING
						itemTexture:SetVertexColor(0.9, 0.6, 0.2);
					else
						achStatus = ICON_NOTREADY
						itemTexture:SetVertexColor(0.4, 0.4, 0.4);
					end
				
					local _, _, _, _, _, _, _, _, _, achImage = GetAchievementInfo(achievementID)
					itemTexture:SetTexture(achImage)
					_G[itemName .. "Name"]:SetText(achStatus)
					
					itemButton.id = achievementID
					itemButton.key = character
					itemButton:Show()
				else
					itemButton.id = nil
					itemButton.key = nil
					itemButton:Hide()
				end
			end

			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end

	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], categorySize, VisibleLines, 41);
end
