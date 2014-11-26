
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/source_code_western_plaguelands_alliance
-- Date: 2014-11-06 13:31
-- Who: Fluclo
-- Log: Fixed level tag at The Battle Resumes!

-- URL: http://wow-pro.com/node/3244/revisions/26635/view
-- Date: 2014-07-26 00:37
-- Who: Ludovicus

-- URL: http://wow-pro.com/node/3244/revisions/26355/view
-- Date: 2014-05-27 20:46
-- Who: Ludovicus
-- Log: GuideLevels corrected from "0,0" to "34,39".

-- URL: http://wow-pro.com/node/3244/revisions/26244/view
-- Date: 2014-05-25 22:58
-- Who: Ludovicus
-- Log: Added guide type.

-- URL: http://wow-pro.com/node/3244/revisions/26089/view
-- Date: 2014-05-18 22:05
-- Who: Ludovicus
-- Log: Icon

-- URL: http://wow-pro.com/node/3244/revisions/25972/view
-- Date: 2014-05-14 22:27
-- Who: Ludovicus
-- Log: New registration guide.

-- URL: http://wow-pro.com/node/3244/revisions/25905/view
-- Date: 2014-03-01 22:24
-- Who: Hendo72
-- Log: Added a 'Withdrawn Soul' target button. The Holy Thurible will work as long as you are within range. Even if you are not facing the target. The target button just makes the quest easier.

-- URL: http://wow-pro.com/node/3244/revisions/25862/view
-- Date: 2014-01-01 17:33
-- Who: Fluclo
-- Log: Added quest to accept before it takes you to the next quest guide.

-- URL: http://wow-pro.com/node/3244/revisions/25861/view
-- Date: 2014-01-01 16:48
-- Who: Fluclo
-- Log: Commented out the Setting of your Hearthstone since the guide doesn't get you to hearthstone at all.

-- URL: http://wow-pro.com/node/3244/revisions/25860/view
-- Date: 2013-12-31 01:55
-- Who: Fluclo
-- Log: Corrected info on how to get Zen'kiki back, and also added the instruction to the unsticky step; set each of the steps for I Ain't Sayin' You a Gourd-Digger since they are in different patches of the farm; clarified notes for A Different Approach; Corrected Too Close for Comfort's missing closing | and coords; Added NC to This Means War; clarified what you are jumping on to Hearthglen, added note that Tirion Fordring is upstairs in the keep; Added Chat steps for The Good People of Hearthglen; split Memories from a Lost Past into two steps to better facilitate finding the parts; corrected PRE on Supporting the Troops; guide behaves badly at The Depravity of the Forsaken so added comment for it.

-- URL: http://wow-pro.com/node/3244/revisions/25851/view
-- Date: 2013-12-25 21:18
-- Who: Fluclo
-- Log: Corrected |PRE| for This Is Our Army, added flight step for Andorhal

-- URL: http://wow-pro.com/node/3244/revisions/25590/view
-- Date: 2013-03-23 20:22
-- Who: Ludovicus
-- Log: name tweaks

-- URL: http://wow-pro.com/node/3244/revisions/25395/view
-- Date: 2013-01-12 22:42
-- Who: Ludovicus
-- Log: Added C* tags

-- URL: http://wow-pro.com/node/3244/revisions/24870/view
-- Date: 2011-12-16 20:07
-- Who: Fluclo

-- URL: http://wow-pro.com/node/3244/revisions/24826/view
-- Date: 2011-12-01 04:42
-- Who: Fluclo

-- URL: http://wow-pro.com/node/3244/revisions/24803/view
-- Date: 2011-11-10 23:10
-- Who: Fluclo
-- Log: Added |NC| to Redpine Thievery

-- URL: http://wow-pro.com/node/3244/revisions/24537/view
-- Date: 2011-06-09 14:57
-- Who: Crackerhead22
-- Log: Note tweaks.

-- URL: http://wow-pro.com/node/3244/revisions/23808/view
-- Date: 2010-12-21 01:29
-- Who: Bitsem

-- URL: http://wow-pro.com/node/3244/revisions/23807/view
-- Date: 2010-12-21 01:27
-- Who: Bitsem

-- URL: http://wow-pro.com/node/3244/revisions/23806/view
-- Date: 2010-12-21 00:14
-- Who: Crackerhead22

-- URL: http://wow-pro.com/node/3244/revisions/23805/view
-- Date: 2010-12-20 23:16
-- Who: Crackerhead22
-- Log: Added in QO steps for "The Good People of Hearthglen" to make it easier to find the NPCS.

-- URL: http://wow-pro.com/node/3244/revisions/23804/view
-- Date: 2010-12-20 22:56
-- Who: Crackerhead22
-- Log: Fixed |QO| error with "Drudges... ", it was 0/1 and not 1/1.

-- URL: http://wow-pro.com/node/3244/revisions/23803/view
-- Date: 2010-12-20 22:27
-- Who: Crackerhead22
-- Log: Removed "Threat to the Kingdom" quest.

-- URL: http://wow-pro.com/node/3244/revisions/23802/view
-- Date: 2010-12-20 22:23
-- Who: Crackerhead22
-- Log: Removed a |Z| tag that was causing "Zone not found" error.

-- URL: http://wow-pro.com/node/3244/revisions/23599/view
-- Date: 2010-12-05 07:50
-- Who: Bitsem
-- Log: Added Source Code. Untested.

-- URL: http://wow-pro.com/node/3244/revisions/23369/view
-- Date: 2010-12-03 11:23
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3244/revisions/23368/view
-- Date: 2010-12-03 11:22
-- Who: Jiyambi

local guide = WoWPro:RegisterGuide('BitWes3540', "Leveling", 'Western Plaguelands', 'Bitsem', 'Alliance')
WoWPro:GuideLevels(guide,34,39, 35)
WoWPro:GuideNextGuide(guide, 'CraEas4045')
WoWPro:GuideIcon(guide,"ACH",4893)
WoWPro:GuideSteps(guide, function()
return [[

L Level 34 |QID|27161|N|You need to be Level 34 to do this guide.|LVL|34|

R Andorhal |QID|27161|N|Western Plaguelands is located north of The Hinterlands.  You can take the quest The Battle for Andorhal from Booty Bay (War-Mage Erallier near the Flightmaster), Gryphon Master Talonaxe in Aerie Peak, or from Commander Ashlam Valorfist in Chillwind Camp.  Each will give you transportation to Andorhal. Alternatively, you can also take the Hero's Call from Ironforge or Stormwind City.|M|41.08,70.26|

T The Battle for Andorhal|QID|27158|M|40.97,70.38|N|To Thassarian.|O|
T The Battle for Andorhal|QID|28505|M|40.97,70.38|N|To Thassarian.|O|
T The Battle for Andorhal|QID|28749|M|40.97,70.38|N|To Thassarian.|O|
T Hero's Call: Western Plaguelands!|QID|28576|M|40.97,70.38|N|To Thassarian.|O|

A Scourge First... Horde Later|QID|27159|M|41.06,70.44|N|From Thassarian.|
A War Machines|QID|27160|M|40.97,70.38|N|From Lurid.|
A The Endless Flow|QID|27161|M|41.27,70.06|N|From Lang Loosegrip.|

C Scourge First... Horde Later|QID|27159|M|41.89,69.69|S|N|Kill the Desiccated Scourge.|
C War Machines|QID|27160|M|42.50,72.01|N|Kill Opengut Behemoths.|S|
C The Endless Flow|QID|27161|U|60849|M|42.44,65.55|N|Use Lang's Hand Grenades to kill skeletons and the Scourge Bone Animus inside the tower.|
C War Machines|QID|27160|M|42.50,72.01|N|Finish killing Opengut Behemoths.|US|
C Scourge First... Horde Later|QID|27159|M|41.89,69.69|US|N|Finish killing the Desiccated Scourge.|

T The Endless Flow|QID|27161|M|41.27,70.06|N|To Lang Loosegrip.|
A Araj the Summoner|QID|27164|PRE|27161|M|41.28,70.19|N|From Lang Loosegrip.|

T Scourge First... Horde Later|QID|27159|M|41.06,70.44|N|To Thassarian.|
T War Machines|QID|27160|M|41.10,70.46|N|To Lurid.|

A Brute Strength|QID|27163|PRE|27160|M|41.10,70.46|N|From Thassarian.|S|
A Scholomancer|QID|27162|PRE|27160|M|41.10,70.46|N|From Thassarian.|
A Brute Strength|QID|27163|PRE|27160|M|41.10,70.46|N|From Thassarian.|US|

C Brute Strength|QID|27163|M|43.57,69.61|N|Level 35 Elite, inside the building.|
C Araj the Summoner|QID|27164|U|60849|M|45.20,69.32|N|Loot Araj's Phylactery Shard. Araj guards the area, so you may need to attack him. If so, use Lang's Hand Grenades if he summons skeletons.|NC|
C Scholomancer|QID|27162|M|45.39,72.34|N|Attack Darkmaster Gandling, a boss skull boss (HP 7620).  You will be immobilised at 50% damage, when Thassarian and Koltira Deathweaver will appear to help you. You then need to finish the last 100 HP yourself.|

T Araj the Summoner|QID|27164|M|41.13,70.48|N|To Thassarian.|S|
T Brute Strength|QID|27163|M|41.13,70.48|N|To Thassarian.|S|
T Scholomancer|QID|27162|M|41.13,70.48|N|To Thassarian.|
T Brute Strength|QID|27163|M|41.13,70.48|N|To Thassarian.|US|
T Araj the Summoner|QID|27164|M|41.13,70.48|N|To Thassarian.|US|

A Victory, For Now|QID|27165|PRE|27162;27163;27164|M|41.13,70.48|N|From Thassarian.|
f Andorhal|QID|27165|M|39.44,69.55|N|Get flightpoint from Ginny Goodwin.|
F Chillwind Camp |QID|27165|M|39.44,69.55|N|Speak to Ginny Goodwin for a free-flight to Chillwind Camp.|
f Chillwind Camp|QID|27165|M|42.95,84.95|N|Get flightpoint from Bibilfaz Featherwhistle.|

;The guide doesn't one ask you to Hearthstone to Chillwind Camp, so commenting out this step.
;h Chillwind Camp|QID|27165|M|43.38,84.51|N|At Mother Matterly.|

r Repair and Sell Junk |QID|27165|M|43.08,84.28|N|Excellent opportunity to repair and sell your junk with Leonard Porter.\n\nClick this step to continue.|RANK|3|
T Victory, For Now|QID|27165|M|42.78,84.12|N|To Commander Ashlam Valorfist.|

A Go Fletch!|QID|27166|M|42.78,84.12|N|From Commander Ashlam Valorfist.|
A A Mighty Hunger|QID|27167|M|42.78,84.12|N|From Thurman Grant.|

C A Mighty Hunger|QID|27167|S|M|41.93,79.46;35.18,76.18|CN|N|From now on, kill and loot Shaggy Black Bears.|
C Go Fletch!|QID|27166|M|35.56,79.50|N|Collect the feathers sparkling on the ground.|NC|
C A Mighty Hunger|QID|27167|US|M|41.93,79.46;35.18,76.18|CN|N|Finish killing bears for Sides of Bear Meat.|

T Go Fletch!|QID|27166|M|42.73,83.98|N|To Commander Ashlam Valorfist.|
T A Mighty Hunger|QID|27167|M|42.73,83.98|N|To Thurman Grant.|
A Uther's Blessing|QID|27169|PRE|27167|M|42.73,83.98|N|From Commander Ashlam Valorfist.|
A Those That Couldn't Let Go|QID|27168|PRE|27167|M|43.32,83.81|N|From High Priestess MacDonnell.|

; ** Added target button to make quest easier. Direction is irrelevant for this quest as long as you are within range to use Holy Thurible
C Those That Couldn't Let Go|QID|27168|S|U|60861|T|Withdrawn Soul|M|49.84,80.79|N|From now on use the Holy Thurible on Withdrawn Souls.  Some may turn hostile.|
C Uther's Blessing|QID|27169|NC|U|61920|M|51.94,82.64|N|Use the Chillwind Tribute at Uther's Tomb.|

T Uther's Blessing|QID|27169|M|51.95,82.71|N|To High Priest Thel'danis.|
A The Abandoned Crypt|QID|27170|M|51.95,82.71|N|From High Priest Thel'danis.|
T The Abandoned Crypt|QID|27170|M|54.32,79.92;53.75,80.43|CS|N|Head into the Crypt, go all the way down. Then turn the quest into the Broken Weapons Crate.|
A Ambushed!|QID|27171|PRE|27170|M|53.77,80.47|N|From the Broken Weapons Crate.|

C Ambushed!|QID|27171|M|54.82,79.75|N|Kill and loot the Skeletal Sorcerers, as you head out of the crypt.|
; ** Added target button to make quest easier. Direction is irrelevant for this quest as long as you are within range to use Holy Thurible
C Those That Couldn't Let Go|QID|27168|US|U|60861|M|49.84,80.79|T|Withdrawn Soul|N|Finish off using the Holy Thurible on Withdrawn Souls as you head back to Chillwind Camp.  Remember, they can turn hostile.|

T Those That Couldn't Let Go|QID|27168|M|43.44,83.76|N|To High Priestess MacDonnell.|
A The Menders' Stead|QID|27175|M|43.02,83.61|N|From Argent Officer Pureheart.|
T Ambushed!|QID|27171|M|42.74,83.97|N|To Commander Ashlam Valorfist.|
A The Writhing Haunt|QID|27172|PRE|27171|M|42.74,83.97|N|From Commander Ashlam Valorfist.|

T The Writhing Haunt|QID|27172|M|53.78,64.67|N|To Thurman Grant.|
A This Is Our Army|QID|27173|PRE|27172|M|53.78,64.67|N|From Thurman Grant.|
C This Is Our Army|QID|27173|M|52.53,65.78|N|Go outside and kill 10 Forsaken Outriders.|
T This Is Our Army|QID|27173|M|53.78,64.67|N|To Thurman Grant.|

A Combat Training|QID|27174|M|53.78,64.67|N|From Thurman Grant.|
C Combat Training|QID|27174|M|53.91,65.70|N|Talk to Gory, then help the villagers defeat Gory.|
T Combat Training|QID|27174|M|53.84,64.66|N|To Thurman Grant.|
T The Menders' Stead|QID|27175|M|49.31,54.87|N|To Field Agent Kaartish.|

A A New Era for the Plaguelands|QID|26999|PRE|27175|M|49.31,54.87|N|From Field Agent Kaartish.|
A Zen'Kiki, the Druid|QID|26953|M|48.98,54.75|N|From Adrine Towhide.|
A I Ain't Sayin' You a Gourd-Digger...|QID|26956|M|48.60,54.88|N|From Selyria Groenveld.|

f The Menders' Stead|QID|27197|M|50.49,52.34|N|At Marge Heffman.|
r Repair and Sell Junk |QID|26999|M|50.69,53.12|N|Excellent opportunity to repair and sell your junk with Gurt.\n\nClick this step to continue.|RANK|3|

C I Ain't Sayin' You a Gourd-Digger...|QID|26956|M|47.41,52.91|CN|N|Click on the Unhealthy-Looking Pumpkins then kill the Thrashing Pumpkin that appears.|QO|Unhealthy-Looking Pumpkin Removed: 3/3|
C I Ain't Sayin' You a Gourd-Digger...|QID|26956|M|46.33,54.45|CN|N|Click on the Rotten Apples then kill the Pome Wrath that appears.|QO|Rotten Apple Removed: 4/4|
C I Ain't Sayin' You a Gourd-Digger...|QID|26956|M|45.19,53.40|CN|N|Click on the Bad Corn then kill the Corn Stalker that appears.|QO|Bad Corn Removed: 6/6|
C Zen'Kiki, the Druid|QID|26953|M|52.11,58.67|N|Kill with Zen'kiki with you. If Zen'kiki isn't with you, talk to Adrine Towhide at The Mender's Stead to get him back.|S|
l Diseased Wolf Samples|QID|26999|M|46.98,46.34|L|60763 4|N|Kill and loot Diseased Wolves for their samples.|S|
l Hulking Plaguebear Samples|QID|26999|M|46.98,46.34|L|60762 4|N|Kill and loot Hulking Plaguebears for their samples.|
l Diseased Wolf Samples|QID|26999|M|46.98,46.34|L|60763 4|N|Kill and loot Diseased Wolves for their samples.|US|
C A New Era for the Plaguelands|QID|26999|M|54.92,60.83|N|Kill and loot Plague Lurkers and Venom Mist Lurkers to get their samples.|
C Zen'Kiki, the Druid|QID|26953|M|52.11,58.67|N|Finish killing the wildlife with Zen'kiki. If Zen'kiki isn't with you, talk to Adrine Towhide at The Mender's Stead to get him back.|US|
T A New Era for the Plaguelands|QID|26999|M|49.33,54.92|N|To Field Agent Kaartish.|

A Northridge Lumber Mill|QID|26935|PRE|26999|M|49.33,54.92|N|From Field Agent Kaartish.|
T I Ain't Sayin' You a Gourd-Digger...|QID|26956|M|48.58,54.89|N|To Selyria Groenveld.|

T Zen'Kiki, the Druid|QID|26953|M|48.93,54.74|N|To Adrine Towhide.|

L Level 35 |QID|26954|N|You need to be Level 35 to continue with this guide.|LVL|35|

A A Different Approach|QID|26954|PRE|26953|M|48.93,54.74|N|From Adrine Towhide.|

N Hunters|QID|26954|C|Hunter|N|Just to make a note, you can take the Diseased Hawks. Just have Zen'kiki bring one down then take it. Close this step to continue.|
C A Different Approach|QID|26954|M|53.72,53.59|N|Head to the top of the hill (there's a path that runs clockwise from the west). At the top, right click on Zen'Kiki to have him pull a Diseased Hawk. Help him kill it. Repeat.|
T A Different Approach|QID|26954|M|49.00,54.72|N|To Adrine Towhide.|
T Northridge Lumber Mill|QID|26935|M|48.12,32.45|N|To Nathaniel Dumah.|

A Learning the Ropes|QID|27000|PRE|26935|M|48.12,32.45|N|From Nathaniel Dumah.|
A Too Close for Comfort|QID|27013|M|48.35,31.84|N|From Kelly Dumah.|

C Too Close for Comfort|QID|27013|M|51.00,27.75|N|Hunt down those Rabid Foxes.|
T Too Close for Comfort|QID|27013|M|48.49,32.00|N|To Kelly Dumah.|

A Redpine Thievery|QID|27011|PRE|27013|M|48.49,32.00|N|From Kelly Dumah.|S|
A A Gnoll's Resolve|QID|27012|PRE|27013|M|48.49,32.00|N|From Kelly Dumah.|
A Redpine Thievery|QID|27011|PRE|27013|M|48.49,32.00|N|From Kelly Dumah.|US|

C Learning the Ropes|QID|27000|M|47.67,31.80;45.33,35.73|CS|N|Hop on a charger, run into a group of spiders and use Ability 1 to scare them away.|NC|

C A Gnoll's Resolve|QID|27012|S|M|49.71,42.20|N|Kill and loot Redpine Gnolls and Shamwns until you have 6 Repine Clubs and Staves.|
C Redpine Thievery|QID|27011|M|49.76,42.09|N|They look like stacks of three sparkling logs.|NC|
C A Gnoll's Resolve|QID|27012|US|M|49.71,42.20|N|Finish killing Gnolls for the needed loot.|

T Redpine Thievery|QID|27011|M|48.41,32.11|N|To Kelly Dumah.|S|
T A Gnoll's Resolve|QID|27012|M|48.41,32.11|N|To Kelly Dumah.|
T Redpine Thievery|QID|27011|M|48.41,32.11|N|To Kelly Dumah.|US|

T Learning the Ropes|QID|27000|M|48.13,32.44|N|To Nathaniel Dumah.|

A This Means WAR (Wild Arachnid Roundup)|QID|27001|M|48.13,32.44|N|From Nathaniel Dumah.|
C This Means WAR (Wild Arachnid Roundup)|QID|27001|M|47.95,33.53|N|Use the whinny to herd spiders back to the mill.|NC|
T This Means WAR (Wild Arachnid Roundup)|QID|27001|M|48.11,32.47|N|To Nathaniel Dumah.|

A An Audience with the Highlord|QID|27002|PRE|27001|M|48.11,32.47|N|From Nathaniel Dumah.|

f Hearthglen|QID|27002|M|47.67,31.80;44.67,18.58|CS|N|Hop on a Hearthglen Mustang and follow the road to Hearthglen. At William Henderson.|

A It's About Time!|QID|27156|M|43.24,16.02|N|From Lieutenant Myner.|
T An Audience with the Highlord|QID|27002|M|42.04,14.64|N|To Highlord Tirion Fordring, upstairs in Mardenholde Keep.|

A Taelan Fordring's Legacy|QID|27151|M|42.19,14.98|N|From Daria L'Rayne.|

C It's About Time!|QID|27156|M|43.09,16.33|N|Head outside the keep, then talk to Trainees. Challenge and beat them.|
T It's About Time!|QID|27156|M|43.28,15.96|N|To Lieutenant Myner.|

A Drudges...|QID|27157|M|43.28,15.96|N|From Lieutenant Myner.|
C Drudges...|QID|27157|M|45.86,12.31;45.37,9.73|CS|N|Enter the mine. Kill the *ew* huge spider.|
T Drudges...|QID|27157|M|43.27,15.91|N|To Lieutenant Myner.|

C Taelan Fordring's Legacy|QID|27151|M|54.78,24.69|N|Kill the Redpine Looters.|
T Taelan Fordring's Legacy|QID|27151|M|54.99,24.73|N|(UI Alert)|

A Unusual Behavior... Even For Gnolls|QID|27152|PRE|27151|M|54.99,24.73|N|(UI Alert)|
R Unusual Behavior... Even For Gnolls|QID|27152|NC|M|54.78,34.10;56.16,34.70;57.07,35.56|CS|N|Follow the arrows up the path to investigate the Gnoll Camp.|QO|Gnoll camp investigated|
C Unusual Behavior... Even For Gnolls|QID|27152|M|54.78,34.10;56.16,34.70;57.07,35.56|CS|N|Kill Moldfang.|QO|Moldfang slain: 1/1|T|Moldfang|
T Unusual Behavior... Even For Gnolls|QID|27152|M|57.28,35.71|N|(UI Alert)|

A The Good People of Hearthglen|QID|27153|PRE|27152|M|57.28,35.71|N|(UI Alert)|
C Bree Ironstock|QID|27153|M|43.68,17.22|QO|Speak with Bree Ironstock: 1/1|N|Head back to Hearthglen, then talk to Bree Ironstock in the stables.|CHAT|
C High Cleric Alphus|QID|27153|M|42.15,18.24|QO|Speak with High Cleric Alphus: 1/1|N|Talk to High Cleric Alphus in the Town Hall.|CHAT|
C Morris Vant|QID|27153|M|44.38,13.55|QO|Speak with Morris Vant: 1/1|N|Talk to Morris Vant inside the blacksmith building.|CHAT|
r Repair and Sell Junk |QID|27153|M|44.38,13.55|N|Excellent opportunity to repair and sell your junk with Morris Vant.\n\nClick this step to continue.|RANK|3|
C Outfitter Mendelev|QID|27153|M|44.82,12.47|QO|Speak with Outfitter Mendelev: 1/1|N|Talk to Outfitter Mendelev in the hut to the west.|CHAT|
T The Good People of Hearthglen|QID|27153|M|44.82,12.47|N|(UI Alert)|

A Bagging Bisp|QID|27154|PRE|27153|M|42.16,18.33|N|(UI Alert)|
C Bagging Bisp|QID|27154|M|45.90,18.46|N|Head up to the top of the tower and confront Bisp. He will turn hostile when you speak to him. Kill him.|
T Bagging Bisp|QID|27154|M|45.90,18.46|N|(UI Alert)|

A Turning Yourself In|QID|27155|PRE|27154|M|45.90,18.46|N|(UI Alert)|
T Turning Yourself In|QID|27155|M|42.06,14.61|N|Head to the Highlord and face the music.|

L Level 36 |QID|26957|N|You need to be Level 36 to continue with this guide.|LVL|36|

A The Long Trip Home|QID|26957|M|42.11,14.85|N|From Del Gahrron.|
F The Menders' Stead|QID|26957|NC|M|44.62,18.37|N|Fly to The Menders' Stead.|
T The Long Trip Home|QID|26957|M|50.59,52.52|N|To Del Gahrron.|

A Memories from a Lost Past|QID|27017|PRE|26957|M|50.59,52.52|N|From Del Gahrron.|
A Gahrron's Withering Cauldron|QID|27053|M|49.30,54.84|N|From Field Agent Kaartish.|
C Gahrron's Withering Cauldron|QID|27053|M|62.71,59.17|N|Kill the Cauldron Lord and loot his key.|
T Gahrron's Withering Cauldron|QID|27053|M|62.58,58.62|N|At the Scourge Cauldron.|

A Return to the Stead|QID|27057|PRE|27053|M|62.58,58.62|N|From the Scourge Cauldron.|
C Memories from a Lost Past|QID|27017|NC|M|64.88,59.32|CS|N|Collect the Painting, which is hanging over the fireplace downstairs.|QO|Faded Finger Painting: 1/1|
C Memories from a Lost Past|QID|27017|NC|M|64.93,59.43|CS|N|Collect the Prayer Book, which can be found upstairs.|QO|Gahrron Prayer Book: 1/1|

T Return to the Stead|QID|27057|M|49.32,54.76|N|To Field Agent Kaartish.|
A Desperate Acts|QID|27054|PRE|27057|M|49.32,54.76|N|From Field Agent Kaartish.|
A Zen'Kiki and the Cultists|QID|26955|M|48.93,54.76|N|From Adrine Towhide.|
T Memories from a Lost Past|QID|27017|M|50.60,52.60|N|To Del Gahrron.|

L Level 38 |QID|27197|N|You need to be Level 38 to continue with this guide.|LVL|38|
A The Battle Resumes!|QID|27197|M|50.39,52.70|N|From Durnt Brightfalcon.|

C Zen'Kiki and the Cultists|QID|26955|NC|M|66.78,47.12|N|Take Zen'Kiki to the cages. Open them, let him heal.|S|
C Desperate Acts|QID|27054|M|66.04,47.75|N|Kill Instructor Malicia and loot the orders.|
T Desperate Acts|QID|27054|M|66.04,47.75|N|(UI Alert)|
A Students of Krastinov|QID|27055|PRE|27054|M|66.04,47.75|N|(UI Alert)|
C Zen'Kiki and the Cultists|QID|26955|NC|M|66.78,47.12|N|Take Zen'Kiki to the cages. Open them, let him heal.|US|
C Students of Krastinov|QID|27055|M|65.22,38.83;64.64,35.20|CS|N|Enter the cave and kill, kill, kill.|
T Students of Krastinov|QID|27055|M|49.31,54.81|N|To Field Agent Kaartish.|
T Zen'Kiki and the Cultists|QID|26955|M|48.93,54.77|N|To Adrine Towhide.|

F Andorhal|QID|27197|M|50.52,52.36|N|Fly to Andorhal.|

T The Battle Resumes!|QID|27197|M|39.84,69.47|N|To Thassarian.|
A Ashes to Ashes|QID|27199|PRE|27197|M|39.84,69.47|N|From Thassarian.|
A Supporting the Troops|QID|27198|PRE|27199|M|40.11,69.17|N|From Lang Loosegrip.|

C Supporting the Troops|QID|27198|S|M|44.45,65.66|N|Kill Andorhal Deathguards.|
C Ashes to Ashes|QID|27199|M|44.70,65.11|N|Kill three Deathguard War-Captains on their horses.|
C Supporting the Troops|QID|27198|US|M|44.45,65.66|N|Finish killing Deathguards.|

T Supporting the Troops|QID|27198|M|39.94,69.42|N|To Lang Loosegrip.|
T Ashes to Ashes|QID|27199|M|39.94,69.42|N|To Thassarian.|
A The Depravity of the Forsaken|QID|27205|PRE|27199|M|39.74,69.52|N|From Thassarian.|

T The Depravity of the Forsaken|QID|27205|M|39.84,69.51|N|To Thassarian.|
A Val'kyr Incursion|QID|27201|PRE|27205|M|39.84,69.51|N|From Thassarian.|
A Brother Against Brother|QID|27202|PRE|27205|M|39.82,69.69|N|From Thurman Grant.|

C Val'kyr Incursion|QID|27201|S|M|41.80,70.42|N|War! Kill Lesser Val'kyr.|
C Brother Against Brother|QID|27202|M|41.44,73.62|N|Kill 20 Forsaken Troopers, they will be in packs of 4, your companions will be there to help you.|
C Val'kyr Incursion|QID|27201|US|M|41.80,70.42|N|Finish killing those Lesser Val'kyr!|

T Brother Against Brother|QID|27202|M|39.90,69.65|N|To Thurman Grant.|
T Val'kyr Incursion|QID|27201|M|39.89,69.55|N|To Thassarian.|

A Aradne|QID|27204|PRE|27201|M|39.89,69.55|N|From Thassarian.|
C Aradne|QID|27204|M|40.37,72.24|N|Head up the tower and kill the elite Aradne.  Your companions will be there to help you.|
T Aradne|QID|27204|M|39.97,69.58|N|To Thassarian.|

A Alas, Andorhal|QID|27206|PRE|27204|M|39.97,69.58|N|From Thassarian.|
F Chillwind Camp|QID|27206|NC|N|Fly to Chillwind Camp.|M|39.43,69.55|
T Alas, Andorhal|QID|27206|M|42.73,84.12|N|To Commander Ashlam Valorfist.|

A Into the Woods|QID|27683|M|42.97,83.51|N|From Argent Officer Pureheart, if you intent to continue onto Eastern Plaguelands.|

]]
end)
