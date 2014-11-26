
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/argent_crusade_and_argent_dawn_reputation_dalies
-- Date: 2014-07-25 21:38
-- Who: Ludovicus
-- Log: adj mean

-- URL: http://wow-pro.com/node/3479/revisions/26586/view
-- Date: 2014-07-20 19:27
-- Who: Ludovicus
-- Log: Added faction for Argent Dawn

-- URL: http://wow-pro.com/node/3479/revisions/26554/view
-- Date: 2014-07-06 15:36
-- Who: Ludovicus
-- Log: Added level and faction

-- URL: http://wow-pro.com/node/3479/revisions/26521/view
-- Date: 2014-06-11 19:00
-- Who: Ludovicus
-- Log: Changed level guide.

-- URL: http://wow-pro.com/node/3479/revisions/25741/view
-- Date: 2013-08-15 23:12
-- Who: Ludovicus
-- Log: Improved ordering.

-- URL: http://wow-pro.com/node/3479/revisions/25645/view
-- Date: 2013-05-14 19:16
-- Who: Ludovicus
-- Log: Extra M tag

-- URL: http://wow-pro.com/node/3479/revisions/25396/view
-- Date: 2013-01-12 22:43
-- Who: Ludovicus
-- Log: Added CN tags

-- URL: http://wow-pro.com/node/3479/revisions/25085/view
-- Date: 2012-09-25 00:23
-- Who: Ludovicus
-- Log: Wrong separators in [Captain Grondel's Task]

-- URL: http://wow-pro.com/node/3479/revisions/24998/view
-- Date: 2012-05-27 22:30
-- Who: Ludovicus
-- Log: INitial Versions

local guide = WoWPro:RegisterGuide("LudoArgDawn",'Dailies', "Eastern Plaguelands", "Ludovicus", "Neutral")
WoWPro:GuideLevels(guide,1,90,45.000000)
WoWPro.Dailies:GuideFaction(guide,529) --  "Argent Dawn"
WoWPro:GuideSteps(guide, function()
return [[

N Argent Dawn|N|The Argent Dawn Reputation Dungeon quests.  Can be soloed repeatedly for a fast grind!|
F Light's Hope Chapel|N|Fly to the chapel.|
h Light's Hope Chapel|M|75.64,52.40|N|Set your hearth here to get out of the dungeons fast.|

N Annals of the Silver Hand|N|This quest can be accepted more than once a day!  So if you reset the instance and just go back, you can get another turnin until you get sick of Stratholme.|
A Annals of the Silver Hand|QID|28755|M|76,51|N|From Lord Raymond George. 1000 rep. Level 42 Dungeon.|
N Aberrations of Bone|N|This quest can also be repeated, you need to reset the instance.|
A Aberrations of Bone|QID|28756|M|76,51|N|From Lord Raymond George. 1000 rep. Level 40 Dungeon.|

F Stratholme|QID|28755|M|26.9,11.8|Z|Eastern Plaguelands|N|Fly to Stratholme|
C Annals of the Silver Hand|QID|28755|M|37.37,74.87|Z|Stratholme|N|At second to last boss.|

F Scholomance|QID|28756|M|70.7,71.0|Z|Western Plaguelands|N|Fly to Scholomance|
N Aberrations of Bone|QID|28756|Z|Scholomance|N|Jump off the bridge to the right side to skip the first set of mobs.|
C Aberrations of Bone|QID|28756|M|30,65|Z|Scholomance|N|Kill Rattlegore.|

T Aberrations of Bone|QID|28756|M|76,51|N|From Lord Raymond George.|
T Annals of the Silver Hand|QID|28755|M|76,51|N|To Lord Raymond George.|

]]
end)
