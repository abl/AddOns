
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/love_air_we_horde
-- Date: 2014-11-07 20:37
-- Who: Emmaleah
-- Log: Delete 2 dup QID's per Ludo's list o' errors

-- URL: http://wow-pro.com/node/3467/revisions/26492/view
-- Date: 2014-06-10 21:24
-- Who: Ludovicus
-- Log: Changed  guide format

-- URL: http://wow-pro.com/node/3467/revisions/25903/view
-- Date: 2014-02-21 19:21
-- Who: Ludovicus
-- Log: Missing A in [T A Gift]

-- URL: http://wow-pro.com/node/3467/revisions/25880/view
-- Date: 2014-02-13 16:56
-- Who: Ludovicus
-- Log: Added Leaders dailies and shuffled flow.

-- URL: http://wow-pro.com/node/3467/revisions/25704/view
-- Date: 2013-06-18 00:31
-- Who: Ludovicus
-- Log: Guide errors

-- URL: http://wow-pro.com/node/3467/revisions/25674/view
-- Date: 2013-05-17 20:45
-- Who: Ludovicus
-- Log: Corrections

-- URL: http://wow-pro.com/node/3467/revisions/25530/view
-- Date: 2013-02-11 11:48
-- Who: Ludovicus
-- Log: Better coords for Uldum and Crystalsong

-- URL: http://wow-pro.com/node/3467/revisions/25529/view
-- Date: 2013-02-11 11:23
-- Who: Ludovicus
-- Log: Added Crushing the Crown and a random daily

-- URL: http://wow-pro.com/node/3467/revisions/24937/view
-- Date: 2012-02-05 13:35
-- Who: Ludovicus
-- Log: Corrections after runthrough.

-- URL: http://wow-pro.com/node/3467/revisions/24935/view
-- Date: 2012-02-04 23:23
-- Who: Ludovicus

local guide = WoWPro:RegisterGuide("LudoLoveH",'WorldEvents',"Love is in the Air", "Ludovicus", "Horde")
WoWPro:GuideLevels(guide,1,90,45.000000)
WoWPro.WorldEvents:GuideHoliday(guide,"LoveInTheAir")
WoWPro:GuideSteps(guide, function()
return [[

N Start at any capital city EXCEPT Orgrimmar|QID|24805|LEAD|24536|N|The starter quests are at Silvermoon, Undercity, Thunder Bluff.  Skip the ones for where you are not!|

A Uncommon Scents|QID|24805|LEAD|24536|M|64.42,70.31|Z|Silvermoon City|N|From Junior Detective, Silvermoon City|
A Uncommon Scents|QID|24805|LEAD|24536|M|64.30,37.55|Z|Undercity|N|From Junior Detective, Undercity|
A Uncommon Scents|QID|24805|LEAD|24536|M|44.22,55.86|Z|Thunder Bluff|N|From Junior Detective, Thunder Bluff|
T Uncommon Scents|QID|24805|LEAD|24536|M|50.79,75.29|Z|Orgrimmar|N|To Detective Snap Snagglebolt|

A Something Stinks|QID|24536||M|50.79,75.29|Z|Orgrimmar|N|From Detective Snap Snagglebolt, Orgrimmar|
C Heavily Perfumed Guards|QID|24536|Z|Orgrimmar|U|50131|N|Find the guards with the clouds and use the analyzer|
T Something Stinks|QID|24536|M|50.79,75.29|Z|Orgrimmar|N|To Detective Snap Snagglebolt|

A Pilfering Perfume|QID|24541|M|50.79,75.29|Z|Orgrimmar|N|From Detective Snap Snagglebolt|
C Pilfering Perfume|QID|24541|M|47.73,11.80|Z|Durotar|N|Run outside of Orgrimmar Gates|
T Pilfering Perfume|QID|24541|M|50.79,75.29|Z|Orgrimmar|N|To Detective Snap Snagglebolt|

A Snivel's Sweetheart|QID|24850|M|50.79,75.29|Z|Orgrimmar|N|From Detective Snap Snagglebolt|
T Snivel's Sweetheart|QID|24850|M|57.6,60.78|Z|Orgrimmar|N|To Roka, at the Bag Shop, in The Drag|

A Hot On The Trail|QID|24851|M|57.6,60.78|Z|Orgrimmar|N|From Roka|
C Hot On The Trail|QID|24851|M|48.8,83.0|Z|Orgrimmar|N|Look for him at the Bank|QO|Orgrimmar Bank searched: 1/1|
C Hot On The Trail|QID|24851|M|53.7,73.7|Z|Orgrimmar|N|Look for him at the Auction House|QO|Orgrimmar Auction House searched: 1/1|
C Hot On The Trail|QID|24851|M|40.1,60.5|Z|Orgrimmar|N|Look for him at the Barber Shop|QO|Orgrimmar Barber Shop searched: 1/1|
T Hot On The Trail|QID|24851|M|57.6,60.78|Z|Orgrimmar|N|To Roka|

A A Friendly Chat...|QID|24576|M|57.6,60.78|Z|Orgrimmar|N|From Roka|
C A Friendly Chat...|QID|24576|M|51.65,56.79|Z|Orgrimmar|N|Find Snivel Rustrocket at the Zepplin Tower|L|49915|
T A Friendly Chat...|QID|24576|M|50.79,75.29|Z|Orgrimmar|N|To Detective Snap Snagglebolt|

L Lovely Charm Collector's Kit|L|49661|M|52.99,76.81|Z|Orgrimmar|N|Ask Kwee Q. Peddlefeet for a Kit.|

A Public Relations Daily|QID|24635;24629;24636|M|53.05,77.15|Z|Orgrimmar|N|From Public Relations Agent|
C A Cloudlet of Classy Cologne|QID|24635|Z|Orgrimmar|N|Spray everyone and any NPC in sight.|U|49669|
C A Perfect Puff of Perfume|QID|24629|Z|Orgrimmar|N|Spray everyone and any NPC in sight.|U|49668|
C Bonbon Blitz|QID|24636|Z|Orgrimmar|N|Force feed candy to everyone and any NPC in sight.|U|49670|
T A Cloudlet of Classy Cologne|QID|24635|Z|Orgrimmar|M|53.05,77.15|N|To Public Relations Agent|
T A Perfect Puff of Perfume|QID|24629|Z|Orgrimmar|M|53.05,77.15|N|To Public Relations Agent|
T Bonbon Blitz|QID|24636|M|53.05,77.15|Z|Orgrimmar|N|To Public Relations Agent|

A Crushing the Crown|QID|24638;24645;24647;24648;24649;24650;24651;24652;28935|M|50.79,75.29|Z|Orgrimmar|N|From Detective Snap Snagglebolt|

C Crushing the Crown|QID|24638|M|40.30,13.45|Z|Durotar|N|Kill Crown Lackeys near Orgrimmar's gates and blow up a a wagon.|U|50130|
C Crushing the Crown|QID|24645|M|55.28,61.60|Z|Silverpine Forest|N|Kill Crown Thugs near The Forsaken Front and blow up a a wagon.|U|50130|
C Crushing the Crown|QID|24647|M|34.69,58.22|Z|Hillsbrad Foothills|N|Kill Crown Dusters near Southpoint Gate and blow up a a wagon.|U|50130|
C Crushing the Crown|QID|24648|M|60.84,38.12 |Z|Dustwallow Marsh|N|Kill Crown Hoodlum near Theramore and blow up a a wagon.|U|50130|
C Crushing the Crown|QID|24649|M|23.45,53.67|Z|The Hinterlands|N|Kill Crown Agents near Hiiri'Watha Research Station and blow up a a wagon.|U|50130|
C Crushing the Crown|QID|24650|M|63.53,49.29|Z|Winterspring|N|Kill Crown Sprinklers near Everlook and blow up a a wagon.|U|50130|
C Crushing the Crown|QID|24651|M|41.48,22.46|Z|Terokkar Forest|N|Kill Crown Underlings near Shattrath City and blow up a a wagon.|U|50130|
C Crushing the Crown|QID|24652|M|46,40|Z|Crystalsong Forest|N|Kill Crown Sprayers near Dalaran and blow up a a wagon.|U|50130|
C Crushing the Crown|QID|28935|M|66.58,19.65|Z|Uldum|N|Kill Crown Technician near the Tomb of Khartut and blow up a a wagon.|U|50130|
l Gifts for the Horde|QID|24638;24645;24647;24648;24649;24650;24651;24652;24638;28935|L|49655 40|N|If you are going to present gifts to all the leaders of the Horde, you need 40 lovely charms.  Mobs that are closer in level to you drop more frequently.  If people get annoyed at you farming the Crown NPCs, just kill anything that spawns fast and is close to your level.|
T Crushing the Crown|QID|24638;24645;24647;24648;24649;24650;24651;24652;24638;28935|M|50.79,75.29|Z|Orgrimmar|N|To Detective Snap Snagglebolt|

A A Gift for the Warchief|QID|24612|M|52.99,76.81|Z|Orgrimmar|N|From Kwee Q. Peddlefeet, between the AH and Inn.|
l Lovely Charm Bracelet|QID|24612|L|49916|U|49655|N|Make a Lovely Charm Bracelet for the Warchief.|
T A Gift for the Warchief|QID|24612|M|48.11,70.48|Z|Orgrimmar|N|To Garrosh Hellscream.|
A A Gift for the High Chieftain|QID|24614|M|44.01,52.59|Z|Thunder Bluff|N|From Kwee Q. Peddlefeet, near the flight tower.|
l Lovely Charm Bracelet|QID|24614|L|49916|U|49655|N|Make a Lovely Charm Bracelet for the High Chieftain.|
T A Gift for the High Chieftain|QID|24614|M|60.33,51.68|Z|Thunder Bluff|N|To Baine Bloodhoof.|
A A Gift for the Banshee Queen|QID|24613|M|66.55,38.58|Z|Undercity|N|From Kwee Q. Peddlefeet, near the old throne.||
l Lovely Charm Bracelet|QID|24613|L|49916|U|49655|N|Make a Lovely Charm Bracelet for the Banshee Queen.|
T A Gift for the Banshee Queen|QID|24613|M|58.05,91.81|Z|Undercity|N|To Lady Sylvanas Windrunner.|
A A Gift for the Regent Lord of Quel'Thalas|QID|24615|M|64.43, 66.55|Z|Silvermoon City|N|From Kwee Q. Peddlefeet, near the Bazzar.|
l Lovely Charm Bracelet|QID|24615|L|49916|U|49655|N|Make a Lovely Charm Bracelet for the Regent Lord.|
T A Gift for the Regent Lord of Quel'Thalas|QID|24615|M|53.78,20.24|Z|Silvermoon City|N|To Lor'themar Theron.|

A Man on the Inside|QID|24793|M|50.79,75.29|Z|Orgrimmar|N|From Detective Snap Snagglebolt|LVL|78|
N Shadowfang Keep and Hummel|ACTIVE|24793|N|In order for you to queue for this, you may need to be level 85.  However, a group can get the quests at 78.|LVL|78|
T Man on the Inside|QID|24793|M|50.79,75.29|Z|ShadowfangKeep|N|To Investigator Fezzen Brasstacks|LVL|78|
A You've Been Served|QID|14488|Z|ShadowfangKeep|N|To Investigator Fezzen Brasstacks|LVL|78|

N All done for the day|
]]
end)
