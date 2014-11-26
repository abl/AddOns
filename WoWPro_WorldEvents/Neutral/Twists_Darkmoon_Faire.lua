
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/darkmoon_faire
-- Date: 2014-08-29 19:59
-- Who: Ludovicus
-- Log: Change zone

-- URL: http://wow-pro.com/node/3459/revisions/26491/view
-- Date: 2014-06-09 23:14
-- Who: Ludovicus
-- Log: Add new guide syntax and RANK

-- URL: http://wow-pro.com/node/3459/revisions/25907/view
-- Date: 2014-03-06 23:39
-- Who: Ludovicus
-- Log: Add PET tags for the Jubling series and a missing Alchemy tag.

-- URL: http://wow-pro.com/node/3459/revisions/25611/view
-- Date: 2013-05-09 22:10
-- Who: Ludovicus
-- Log: Minor tweaks.

-- URL: http://wow-pro.com/node/3459/revisions/25552/view
-- Date: 2013-03-16 19:19
-- Who: Ludovicus
-- Log: zone updates and spelling correction for Jubjub.

-- URL: http://wow-pro.com/node/3459/revisions/25526/view
-- Date: 2013-02-08 22:31
-- Who: Emmaleah
-- Log: moved sayge's fortune to beside inscription quest, so if you happen to be an inscriptionist you dont have to run back a 2nd time.  Added comment about jubling not being tradeable. (so don't get multiples to sell on AH)

-- URL: http://wow-pro.com/node/3459/revisions/25525/view
-- Date: 2013-02-08 02:53
-- Who: Ludovicus
-- Log: Bearzerker's suggestions, according to me :-)

-- URL: http://wow-pro.com/node/3459/revisions/25522/view
-- Date: 2013-02-06 20:25
-- Who: Ludovicus
-- Log: Darkmoon tweaks

-- URL: http://wow-pro.com/node/3459/revisions/25429/view
-- Date: 2013-01-13 15:11
-- Who: Ludovicus
-- Log: Added CN tag

-- URL: http://wow-pro.com/node/3459/revisions/25347/view
-- Date: 2013-01-12 00:31
-- Who: Ludovicus
-- Log: Added CS tag, QID for the jubling and made the purchase of Fossil Archeology Fragments level 90.

-- URL: http://wow-pro.com/node/3459/revisions/25324/view
-- Date: 2013-01-10 16:37
-- Who: Ludovicus
-- Log: Rearrange eating and drinking as per  Bearzerker 

-- URL: http://wow-pro.com/node/3459/revisions/25323/view
-- Date: 2013-01-10 14:00
-- Who: Ludovicus

-- URL: http://wow-pro.com/node/3459/revisions/25303/view
-- Date: 2013-01-09 21:57
-- Who: Emmaleah
-- Log: Added Spawn of JubJub quest.
--	moved B step for archy quest to very top of guide, since it is a shame for them to be in thunder bluff then reallize they should go back to Vale of Eternal Blossoms
--	moved N and sticked C steps for tailering to immediatedly after A step
--	moved N and sticked C steps for enchanting quest to immediately after A step 
--	removed some extraneous |M|tags
--	added NC tags where I must have missed them yesterday.

-- URL: http://wow-pro.com/node/3459/revisions/25298/view
-- Date: 2013-01-09 16:35
-- Who: Ludovicus
-- Log: Added U|72110| to Talkin' Tonks as per  Bearzerker

-- URL: http://wow-pro.com/node/3459/revisions/25287/view
-- Date: 2013-01-09 01:18
-- Who: Ludovicus
-- Log: Attempt at a manual merger of my changes.

-- URL: http://wow-pro.com/node/3459/revisions/25282/view
-- Date: 2013-01-07 02:33
-- Who: Emmaleah
-- Log: changed the word flower to flour, changed all (I think) C steps to include NC, added statement about Fossil Fragments from Brann Brozebeard, added T Testing your strenth before A, since you never turn them in on the same trip to the fair, hopefully this helps)

-- URL: http://wow-pro.com/node/3459/revisions/25249/view
-- Date: 2012-12-16 00:37
-- Who: Ludovicus
-- Log: You need 5X Fizzy Faire Drink.

-- URL: http://wow-pro.com/node/3459/revisions/25235/view
-- Date: 2012-12-03 00:10
-- Who: Ludovicus
-- Log: Added some missing M tags.

-- URL: http://wow-pro.com/node/3459/revisions/25233/view
-- Date: 2012-12-02 21:55
-- Who: Ludovicus
-- Log: STamp

-- URL: http://wow-pro.com/node/3459/revisions/25232/view
-- Date: 2012-12-02 21:54
-- Who: Ludovicus

-- URL: http://wow-pro.com/node/3459/revisions/25209/view
-- Date: 2012-11-17 21:49
-- Who: Ludovicus
-- Log: Changed the name of the zone.

-- URL: http://wow-pro.com/node/3459/revisions/25202/view
-- Date: 2012-11-11 05:55
-- Who: Hendo72
-- Log: Corrected quantity of Moonberry Juice to be purchased from 1 to 5. It was missing from code.

-- URL: http://wow-pro.com/node/3459/revisions/25003/view
-- Date: 2012-06-08 14:15
-- Who: Ludovicus
-- Log: Add LVL tweaks so it wont bother you to try to eat food you can't!

-- URL: http://wow-pro.com/node/3459/revisions/24904/view
-- Date: 2012-01-19 00:11
-- Who: Ludovicus

-- URL: http://wow-pro.com/node/3459/revisions/24903/view
-- Date: 2012-01-19 00:11
-- Who: Ludovicus
-- Log: Correct node number

-- URL: http://wow-pro.com/node/3459/revisions/24902/view
-- Date: 2012-01-19 00:10
-- Who: Ludovicus
-- Log: Sync to git

local guide = WoWPro:RegisterGuide("TwiDarkmoon",'WorldEvents',"DarkmoonFaireIsland", "Twists", "Neutral")
WoWPro:GuideLevels(guide,1,90,45.000000)
WoWPro.WorldEvents:GuideHoliday(guide,"Darkmoon Faire")
WoWPro:GuideSteps(guide, function()
return [[

B Fossil Archeology Fragments|M|83.6,61|Z|Vale of Eternal Blossoms|L|393 15|P|Archaeology;794;75|N|If you have some spare crated artifacts, You can use them to buy crates of fossil archeology fragments from Brann Bronzebeard at Mogu'shan palace, otherwise, you have to dig them up yourself.|LVL|90|RANK|3|

B Dark Iron Ale|QID|7946|M|50.0,61.6|Z|Shadowforge City@BlackrockDepths|L|11325 10|U|37863|PET|14878;3|N|If you want the mini pet "Jubling" you need to have several Dark Iron Ale in order to lure and then get the quest, skip this step if you are uninterested. You can buy the ale from Plugger Spazzring in the Bar area of Blackrock Depths. Grab your Direbrew remote for a quick trip there. (Note: Jubling isn't tradeable)|
B Imbued Crystal|QID|29443|N|Consider buying an "Imbued Crystal" in the AH if you don't have one.|L|71635|LVL|15|RANK|3|
B Monstrous Egg|QID|29444|N|Consider buying a "Monstrous Egg" in the AH if you don't have one.|L|71636|LVL|15|RANK|3|
B Mysterious Grimoire|QID|29445|N|Consider buying a "Mysterious Grimoire" in the AH if you don't have one.|L|71637|LVL|15|RANK|3|
B Ornate Weapon|QID|29446|N|Consider buying an "Ornate Weapon" in the AH if you don't have one.|L|71638|LVL|15|RANK|3|
B A Treatise on Strategy|QID|29451|N|Consider buying an "A Treatise on Strategy" in the AH if you don't have one.|L|71715|LVL|85|RANK|3|
B Soothsayer's Runes|QID|29464|N|Consider buying an "Soothsayer's Runes" in the AH if you don't have one.|L|71716|LVL|85|RANK|3|

B Banner of the Fallen|QID|29456|N|Consider buying a "Banner of the Fallen" in the AH if you don't have one.|L|71951|LVL|15|RANK|3|
B Captured Insignia|QID|29457|N|Consider buying a "Fallen Adventurer's Journal" in the AH if you don't have one.|L|71952|LVL|15|RANK|3|
B Fallen Adventurer's Journal|QID|29458|N|Consider buying a "Fallen Adventurer's Journal" in the AH if you don't have one.|L|71953|LVL|15|RANK|3|

A The Darkmoon Faire|QID|7905|M|62.20,32.29;62.41,73.03|CN|N|From Darkmoon Faire Mystic Mage who's near Dwarven District or the Trade District in Stormwind.|Z|Stormwind City|FACTION|Alliance|
A The Darkmoon Faire|QID|7926|M|48.22,62.14|N|From Darkmoon Faire Mystic Mage who's near the flying trainer in Orgrimmar.|Z|Orgrimmar|FACTION|Horde|
R Transport to Entrance|QID|7905|M|41.87,68.17|N|Talk to her again to get ported to the entrance.You can use her for future trips as well.|Z|Elwynn Forest|FACTION|Alliance|CC|
R Transport to Entrance|QID|7926|M|36.49,35.11|N|Talk to her again to get ported to the entrance.You can use him for future trips as well.|Z|Thunder Bluff|FACTION|Horde|CC|

B Moonberry Juice|QID|29506|M|43.76,65.88|L|1645 5|N|From Innkeeper Farley in the Lion's Pride Inn.|P|Alchemy;171;75|Z|Elwynn Forest|FACTION|Alliance|
B Moonberry Juice|QID|29506|M|38.89,64.67|L|1645 5|N|From Kuruk of Kuruk's Goods in Thunder Bluff main elevator and to your right.|P|Alchemy;171;75|Z|Thunder Bluff|FACTION|Horde|

B Simple Flour|QID|29509|M|41.87,67.04|L|30817 5|N|Purchase 5 from Tharynn Borden.|P|Cooking;185;75|Z|Elwynn Forest|FACTION|Alliance|
B Simple Flour|QID|29509|M|40.6,63.6|L|30817 5|N|Purchase 5 from Shadi Mistrunner.|P|Cooking;185;75|Z|Thunder Bluff|FACTION|Horde|

B Light Parchment|QID|29515|M|41.87,67.04|L|39354 5|N|Purchase 5 from Tharynn Borden.|P|Inscription;773;75|Z|Elwynn Forest|FACTION|Alliance|
B Light Parchment|QID|29515|M|40.28,63.41|L|39354 5|N|Purchase 5 from Shadi Mistrunner.|P|Inscription;773;75|Z|Thunder Bluff|FACTION|Horde|

B Coarse Thread|QID|29517|M|41.87,67.04|L|2320 5|N|Purchase 5 from Tharynn Borden.  Warning:  If you also have tailoring, get 6.|P|Leatherworking;165;75|Z|Elwynn Forest|FACTION|Alliance|
B Coarse Thread|QID|29517|M|40.28,63.416|L|2320 5|N|Purchase 5 from Shadi Mistrunner. Warning:  If you also have tailoring, get 6.|P|Leatherworking;165;75|Z|Thunder Bluff|FACTION|Horde|

B Shiny Bauble|QID|29517|M|41.87,67.04|L|6529 10|N|Purchase 10 from Tharynn Borden.|P|Leatherworking;165;75|Z|Elwynn Forest|FACTION|Alliance|
B Shiny Bauble|QID|29517|M|40.28,63.41|L|6529 10|N|Purchase 10 from Shadi Mistrunner.|P|Leatherworking;165;75|Z|Thunder Bluff|FACTION|Horde|

B Blue Dye|QID|29517|M|41.87,67.04|L|6260 5|N|Purchase 5 from Tharynn Borden. Warning:  If you also have tailoring, get 6.|P|Leatherworking;165;75|Z|Elwynn Forest|FACTION|Alliance|
B Blue Dye|QID|29517|M|40.28,63.41|L|6260 5|N|Purchase 5 from Shadi Mistrunner. Warning:  If you also have tailoring, get 6.|P|Leatherworking;165;75|Z|Thunder Bluff|FACTION|Horde|

B Coarse Thread|QID|29520|M|41.87,67.04|L|2320 1|N|Purchase 1 from Tharynn Borden.|P|Tailoring;197;75|Z|Elwynn Forest|FACTION|Alliance|
B Coarse Thread|QID|29520|M|40.28,63.41|L|2320 1|N|Purchase 1 from Shadi Mistrunner.|P|Tailoring;197;75|Z|Thunder Bluff|FACTION|Horde|

B Red Dye|QID|29520|M|41.87,67.04|L|2604 1|N|Purchase 1 from Tharynn Borden.|P|Tailoring;197;75|Z|Elwynn Forest|FACTION|Alliance|
B Red Dye|QID|29520|M|40.28,63.41|L|2604 1|N|Purchase 1 from Shadi Mistrunner.|P|Tailoring;197;75|Z|Thunder Bluff|FACTION|Horde|

B Blue Dye|QID|29520|M|41.87,67.04|L|6260 1|N|Purchase 1 from Tharynn Borden.|P|Tailoring;197;75|Z|Elwynn Forest|FACTION|Alliance|
B Blue Dye|QID|29520|M|40.28,63.41|L|6260 1|N|Purchase 1 from Shadi Mistrunner.|P|Tailoring;197;75|Z|Thunder Bluff|FACTION|Horde|

B Sack o'Tokens|QID|29463|M|54.59,53.33|N|From Zina Sharpworth after you enter the portal. Open the bag in your inventory, we can't automate it yet!|L|71083|

A Banners, Banners Everywhere!|QID|29520|M|55.50,54.63|N|From Selina Dourman.|P|Tailoring;197;75|
N Create your Banner|QID|29520|N|Use your Darkmoon Banner Kit.|U|72048|L|72049|
C Banners, Banners Everywhere!|QID|29520|M|50.99,86.23|U|72049|NC|N|Look for a sparkling dirt pile "base" for the banner.|
T Banners, Banners Everywhere!|QID|29520|M|55.50,54.63|N|To Selina Dourman.|

A It's Hammer Time|QID|29463|M|53.35,54.73|N|From Mola.|RANK|2|
C It's Hammer Time|QID|29463|NC|N|Talk to Mola again picking Ready to whack! Go in and wack. Avoid dolls and hitting Hoggar (big brown) grants 3 points.|RANK|2|
T It's Hammer Time|QID|29463|N|To Mola.|RANK|2|

A The Humanoid Cannonball|QID|29436|M|52.67,56.09|N|From Maxima Blastenheimer.|RANK|2|
N Achievement|QID|29436|ACH|6021;0|N|Talk to Teleportologist Fozlebub for a return trip.|M|57.25,89.85|S|RANK|2|
C The Humanoid Cannonball|QID|29436|NC|N|Talk to Maxima again picking Launch me!. Change your view till you are looking down, then try to release (1) right when you are about to go past the dock.|RANK|2|
T The Humanoid Cannonball|QID|29436|N|To Maxima Blastenheimer.|RANK|2|

T The Enemy's Insignia|QID|29457|M|51.76,60.55|N|To Professor Thaddeus Paleo.|
T The Captured Journal|QID|29458|M|51.76,60.55|N|To Professor Thaddeus Paleo.|
T A Captured Banner|QID|29456|M|51.76,60.55|N|To Professor Thaddeus Paleo.|
T A Curious Crystal|QID|29443|M|51.76,60.55|N|To Professor Thaddeus Paleo.|
T A Wondrous Weapon|QID|29446|M|51.76,60.55|N|To Professor Thaddeus Paleo.|
T The Master Strategist|QID|29451|M|51.76,60.55|N|To Professor Thaddeus Paleo.|
T Tools of Divination|QID|29464|M|51.76,60.55|N|To Professor Thaddeus Paleo.|
A Fun for the Little Ones|QID|29507|M|51.76,60.55|N|From Professor Thaddeus Paleo.|P|Archaeology;794;75|
T Fun for the Little Ones|QID|29507|M|51.76,60.55|N|From Professor Thaddeus Paleo.|P|Archaeology;794;75|

A He Shoots, He Scores!|QID|29438|M|49.41,60.83|N|From Rinling.|RANK|2|
A Rearm, Reuse, Recycle|QID|29518|M|49.41,60.83|N|From Rinling.|P|Mining;186;75|
A Talkin' Tonks|QID|29511|M|49.41,60.83|N|From Rinling.|P|Engineering;202;75|

A Eyes on the Prizes|QID|29517|M|49.41,60.83|N|From Rinling.|P|Leatherworking;165;75|
C Eyes on the Prizes|QID|29517|NC|N|Use your Darkmoon Craftsman's Kit.|U|71977|
T Eyes on the Prizes|QID|29517|M|49.41,60.83|N|From Rinling.|

N Achievement|QID|29438|ACH|6022;1|N|Pick one target and fire when it lights up.|S|
C He Shoots, He Scores!|QID|29438|NC|N|Talk to Rinling again picking Let's shoot! Aim at a target and press 1 to fire. You can get 2 shots in per target.|RANK|2|
T He Shoots, He Scores!|QID|29438|N|To Rinling.|RANK|2|

A Darkmoon Pet Battle!|QID|32175|PRE|31951|SPELL|Battle Pet Training;119467;true|M|47.72,62.67|N|From Jeremy Feasel.\nHe has 3 epic level 25 pets on his team: Honky-Tonk (mechanical), Fezwick (beast), and Judgement (magical). Something with Arcane Storm is good against the monkey!|
C Darkmoon Pet Battle!|QID|32175|SPELL|Battle Pet Training;119467;true|QO|Defeat Jeremy Feasel: 1/1|
T Darkmoon Pet Battle!|QID|32175|SPELL|Battle Pet Training;119467;true|M|47.72,62.67|N|To Jeremy Feasel|

C Rearm, Reuse, Recycle|QID|29518|NC|N|Look for Tonk Scrap. Look between the tents.|S|
C Talkin' Tonks|QID|29511|NC|N|Repair tonks.|U|72110|S|

A Tonk Commander|QID|29434|M|50.51,64.77|N|From Finlay Coolshot.|RANK|2|
C Tonk Commander|QID|29434|NC|N|Talk to Finlay again and pick Ready to play! Drive through the targets and hit '1' when they're behind you. If you get targeted (ping sound) hit '2" for speed.|RANK|2|
T Tonk Commander|QID|29434|M|50.51,64.77|N|To Finlay Coolshot.|RANK|2|

T The Darkmoon Faire|QID|7905|M|48.10,64.88|N|To Gelvas Grimegate.|FACTION|Alliance|
T The Darkmoon Faire|QID|7926|M|48.10,64.88|N|To Gelvas Grimegate.|FACTION|Horde|

t Test Your Strength|QID|29433|M|48.06,67.05|N|To Kerri Hicks.|
A Test Your Strength|QID|29433|M|48.06,67.05|N|From Kerri Hicks.|

A Putting the Crunch in the Frog|QID|29509|M|52.88,67.92|N|From Stamp Thunderhorn.|P|Cooking;185;75|
A Spoilin' for Salty Sea Dogs|QID|29513|M|52.88,67.92|N|From Stamp Thunderhorn.|P|Fishing;356;75|

U Coat the Frogs in Flour|QID|29509|L|72057|U|72056|
C Putting the Crunch in the Frog|QID|29509|NC|N|Throw the breaded frogs into the green bubbling pot next to Stamp Thunderhorn.|U|72057|
T Putting the Crunch in the Frog|QID|29509|M|52.88,67.92|N|To Stamp Thunderhorn.|

B Darkmoon Dog|QID|99602603|ACH|6026;3|M|52.88,67.92|N|From Stamp Thunderhorn.|L|19223|LVL|5|RANK|3|
B Pickled Kodo Foot|QID|99602607|ACH|6026;7|M|52.88,67.92|N|From Stamp Thunderhorn.|L|19305|LVL|15|RANK|3|
B Crunchy Frog|QID|960260002|ACH|6026;2|M|52.88,67.92|N|From Stamp Thunderhorn.|L|19306|LVL|35|RANK|3|
B Funnel Cake|QID|99602606|ACH|6026;6|M|52.88,67.92|N|From Stamp Thunderhorn.|L|33246|LVL|55|RANK|3|
B Corn-Breaded Sausage|QID|99602601|ACH|6026;1|M|52.88,67.92|N|From Stamp Thunderhorn.|L|44940|LVL|75|RANK|3|
B Spiced Beef Jerky|QID|99602610|ACH|6026;10|M|52.88,67.92|N|From Stamp Thunderhorn.|L|19304|LVL|5|RANK|3|
B Red Hot Wings|QID|99602608|ACH|6026;8|M|52.88,67.92|N|From Stamp Thunderhorn.|L|19224|LVL|25|RANK|3|
B Deep Fried Candybar|QID|99602605|ACH|6026;4|M|52.88,67.92|N|From Stamp Thunderhorn.|L|19225|LVL|45|RANK|3|
B Forest Strider Drumstick|QID|99602605|ACH|6026;5|M|52.88,67.92|N|From Stamp Thunderhorn.|L|33254|LVL|65|RANK|3|
B Salty Sea Dog|QID|99602609|ACH|6026;9|M|52.88,67.92|N|From Stamp Thunderhorn.|L|73260|LVL|85|RANK|3|
N Eat Darkmoon Dog|QID|99602603|ACH|6026;3|U|19223|LVL|5|RANK|3|
N Eat Spiced Beef Jerky|QID|99602610|ACH|6026;10|U|19304|LVL|5|RANK|3|
N Eat Pickled Kodo Foot|QID|99602607|ACH|6026;7|U|19305|LVL|15|RANK|3|
N Eat Red Hot Wings|QID|99602608|ACH|6026;8|U|19224|LVL|25|RANK|3|
N Eat Crunchy Frog|QID|960260002|ACH|6026;2|U|19306|LVL|35|RANK|3|
N Eat Deep Fried Candybar|QID|99602605|ACH|6026;4|U|19225|LVL|45|RANK|3|
N Eat Funnel Cake|QID|99602606|ACH|6026;6|U|33246|LVL|55|RANK|3|
N Eat Forest Strider Drumstick|QID|99602605|ACH|6026;5|U|33254|LVL|65|RANK|3|
N Eat Corn Breaded Sausage|QID|99602601|ACH|6026;1|U|44940|LVL|75|RANK|3|
N Eat Salty Sea Dog|QID|99602609|ACH|6026;9|U|73260|LVL|85|RANK|3|

A Putting the Carnies Back Together Again|QID|29512|M|55.00,70.76|N|From Chronos.|P|First Aid;129;75|
A Keeping the Faire Sparkling|QID|29516|M|55.00,70.76|N|From Chronos.|P|Jewelcrafting;755;75|
A Herbs for Healing|QID|29514|M|55.00,70.76|N|From Chronos.|P|Herbalism;182;75|
A Tan My Hide|QID|29519|M|55.00,70.7|N|From Chronos.|P|Skinning;393;75|

N Collect 6 Darkblossom|QID|29514|L|72046 6|S|
C Tan My Hide|QID|29519|NC|N|Found throughout the Island.|S|
N Collect 5 Bits of Glass|QID|29516|N|Green sparkling Gems.|L|72052 5|S|

C Putting the Carnies Back Together Again|QID|29512|NC|M|54.87,70.75;47.44,74.85|CN|N|Use the bandage on Carnies.|U|71978|T|Injured Carnie|
C Herbs for Healing|QID|29514|US|NC|
T Putting the Carnies Back Together Again|QID|29512|M|55.00,70.76|N|To Chronos.|
T Herbs for Healing|QID|29514|M|55.00,70.76|N|To Chronos.|

N Jubling|QID|7946|M|55.8,70.6|U|11325|PET|14878;3|N|Somewhere in the forest resonably close to Morja is her lost frog Jubjub. He is hooked on Dark Iron Ale. If you make a trail of ale from him to her (about 15 ft or so apart - put the next one down before he finishes drinking the last one) you can lure him back to Morja. If someone else has lured Jubjub to Morja you will only need 1 ale. (or if you are just lucky). Check this off manually if you aren't interested. in a Jubling minipet (or don't have any ale).|
A Spawn of Jubjub|QID|7946|M|55.8,70.6|PET|14878;3|
T Spawn of Jubjub|QID|7946|M|55.8,70.6|PET|14878;3|N|You will recieved an egg, in 7 days it will hatch into a jubling, that you will be able to put into your pet journal.|

B Darkmoon Fireworks (6)|QID|99603001|M|48.50,71.76|N|Buy 6 from Boomie Sparks.|ACH|6030;1|L|74142 6|FACTION|Alliance|RANK|3|
B Darkmoon Fireworks (6)|QID|99603001|M|48.50,71.76|N|Buy 6 from Boomie Sparks.|ACH|6031;1|L|74142 6|FACTION|Horde|RANK|3|

T An Intriguing Grimoire|QID|29445|M|52.94,75.94|N|To Sayge.|
A Putting Trash to Good Use|QID|29510|M|52.94,75.94|N|From Sayge.|P|Enchanting;333;75|
A Writing the Future|QID|29515|M|52.94,75.94|N|From Sayge.|P|Inscription;773;75|

N Create 5 Prophetic Ink|QID|29515|N|Use the Bundle of Exotic Herbs.|L|71972|U|71971|
C Writing the Future|QID|29515|NC|N|Use the Prophetic Ink. Repeat until completed.|U|71972|
T Writing the Future|QID|29515|M|52.94,75.94|N|To Sayge.|

N Sayge's Dark Fortunes|M|52.94,75.94|BUFF|23735;23736;23737;23738;23766;23767;23768;23769|N|Sayge offers different 2 hour buffs.  Pick one and elect to get a written fortune for a chance at a quest item! We pre-select based on your class.|RANK|3|
N Sayge's Dark Fortune of Stamina|M|52.94,75.94|BUFF|23735;23736;23737;23738;23766;23767;23768;23769|N|Confiscate the corn, Speak against your brother openly|RANK|3|
N Sayge's Dark Fortune of Agility|M|52.94,75.94|BUFF|23735;23736;23737;23738;23766;23767;23768;23769|C|Hunter,Rogue,Druid,Shaman,Monk|N|Confiscate the corn, Keep your brother out without letting him know|RANK|3|
N Sayge's Dark Fortune of Intelligence|M|52.94,75.94|BUFF|23735;23736;23737;23738;23766;23767;23768;23769|C|Druid,Mage,Paladin,Priest,Monk,Shaman,Warlock|N|Turn him over to liege, Show not so quiet defiance|RANK|3|
N Sayge's Dark Fortune of Spirit|M|52.94,75.94|BUFF|23735;23736;23737;23738;23766;23767;23768;23769|C|Priest,Druid,Monk,Shaman,Paladin|N|Give corn to the man, Take credit and Share the gold|RANK|3|
N Sayge's Dark Fortune of Strength|M|52.94,75.94|BUFF|23735;23736;23737;23738;23766;23767;23768;23769|C|Warrior,Death Knight,Paladin|N|Confiscate the corn, Help your brother in|RANK|3|
N Sayge's Dark Fortune of Armor|M|52.94,75.94|BUFF|23735;23736;23737;23738;23766;23767;23768;23769|N|Slay the man, Let your friend go|RANK|3|
N Sayge's Dark Fortune of Damage|M|52.94,75.94|BUFF|23735;23736;23737;23738;23766;23767;23768;23769|N|Slay the man, Execute your friend painfully|RANK|3|
N Sayge's Dark Fortune of Resistance|M|52.94,75.94|BUFF|23735;23736;23737;23738;23766;23767;23768;23769|N|Turn him over to liege, Remain quiet|RANK|3|

N Collect 6 Discarded Weapon|QID|29510|N|Around the faire|L|72018 6|S|

A Target: Turtle|QID|29455|M|51.45,77.77|N|Jessica Rogers.|RANK|2|
C Target: Turtle|QID|29455|NC|N|Talk to Jessica Rogers and select Ready to play! Press 1, aim the middle ring of the big ring on the pole of the turtle. Once you're in position spam 1->click. If he moves wait a moment, aim and spam.|RANK|2|
T Target: Turtle|QID|29455|M|51.45,77.77|N|Jessica Rogers.|RANK|2|

T An Exotic Egg|QID|29444|M|50.87,81.80|N|To Yebb Neblegear.|
A Baby Needs Two Pair of Shoes|QID|29508|M|50.87,81.80|N|From Yebb Neblegear.|P|Blacksmithing;164;75|

N Achievement|QID|99602501|M|50.75,81.63;56.67,81.68|CS|N|Follow the maze and hop on a horse at the end.|ACH|6025|RANK|3|

C Spoilin' for Salty Sea Dogs|QID|29513|M|51.48,91.09|N|Fish off the dock.|

N Make 4 horseshoes at the Anvil|QID|29508|M|47.54,66.31|L|71967 4|U|71964|N|Don't forget to click 4 times.|

N Collect 6 Discarded Weapon|QID|29510|N|Around the faire|L|72018 6|US|
C Putting Trash to Good Use|QID|29510|NC|U|72018|

C Tan My Hide|QID|29519|NC|N|Found throughout the Island.|US|
N Collect 5 Bits of Glass|QID|29516|N|Green sparkling Gems.|L|72052 5|US|
C Keeping the Faire Sparkling|QID|29516|NC|N|Convert to Sparkling 'Gemstone'|U|72052|

C Rearm, Reuse, Recycle|QID|29518|NC|N|Look for Tonk Scrap.|US|
C Talkin' Tonks|QID|29511|U|72110|US|NC|

T Rearm, Reuse, Recycle|QID|29518|M|49.41,60.83|N|From Rinling.|
T Talkin' Tonks|QID|29511|M|49.41,60.83|N|From Rinling.|
T Keeping the Faire Sparkling|QID|29516|M|54.84,70.66|N|From Chronos.|
T Spoilin' for Salty Sea Dogs|QID|29513|M|52.88,67.92|N|To Stamp Thunderhorn.|
T Putting Trash to Good Use|QID|29510|M|52.94,75.94|N|To Sayge.|

C Baby Needs Two Pair of Shoes|QID|29508|NC|M|50.87,81.80|N|Shoe Baby.|U|71967|
T Baby Needs Two Pair of Shoes|QID|29508|M|50.87,81.80|N|From Yebb Neblegear.|

T Tan My Hide|QID|29519|M|54.84,70.66|N|From Chronos.|

A A Fizzy Fusion|QID|29506|M|50.31,69.39|N|From Sylannia.|P|Alchemy;171;75|
B Cheap Beer|QID|99602612|M|50.31,69.39|ACH|6026;12|N|From Sylannia. Drink up!|L|19222|LVL|1|RANK|3|
B Fizzy Faire Drink|QID|99602614|M|50.31,69.39|ACH|6026;14|N|From Sylannia. Drink up!|L|19299|LVL|15|RANK|3|
B Iced Berry Slush|QID|99602617|M|50.31,69.39|ACH|6026;17|N|From Sylannia. Drink up!|L|33234|LVL|45|RANK|3|
B Fresh-Squeezed Limeade|QID|99602616|M|50.31,69.39|ACH|6026;16|N|From Sylannia. Drink up!|L|44941|LVL|70|RANK|3|
B Darkmoon Special Reserve|QID|99602613|M|50.31,69.39|ACH|6026;13|N|From Sylannia. Drink up!|L|19221|LVL|1|RANK|3|
B Bottled Winterspring Water|QID|99602611|M|50.31,69.39|ACH|6026;11|N|From Sylannia. Drink up!|L|19300|LVL|35|RANK|3|
B Fizzy Faire Drink 'Classic'|QID|99602615|M|50.31,69.39|ACH|6026;15|N|From Sylannia. Drink up!|L|33236|LVL|60|RANK|3|
B Sasparilla Sinker|QID|99602618|M|50.31,69.39|ACH|6026;18|N|From Sylannia. Drink up!|L|74822|LVL|85|RANK|3|

N Drink Cheap Beer|QID|99602612|ACH|6026;12|U|19222|LVL|1|RANK|3|
N Drink Darkmoon Special Reserve|QID|99602613|ACH|6026;13|U|19221|LVL|1|RANK|3|
N Drink Fizzy Faire Drink|QID|99602614|ACH|6026;14|U|19299|LVL|15|RANK|3|
N Drink Bottled Winterspring Water|QID|99602611|ACH|6026;11|U|19300|LVL|35|RANK|3|
N Drink Iced Berry Slush|QID|99602617|ACH|6026;17|U|33234|LVL|45|RANK|3|
N Drink Fizzy Faire Drink 'Classic'|QID|99602615|ACH|6026;15|U|33236|LVL|60|RANK|3|
N Drink Fresh-Squeezed Limeade|QID|99602616|ACH|6026;16|U|44941|LVL|70|RANK|3|
N Drink Sasparilla Sinker|QID|99602618|ACH|6026;18|U|74822|LVL|85|RANK|3|

B Fizzy Faire Drink|QID|29506|M|50.31,69.39|N|From Sylannia.|L|19299 5|P|Alchemy;171;75|
C A Fizzy Fusion|QID|29506|NC|N|Use the Cocktail Shaker.|U|72043|
T A Fizzy Fusion|QID|29506|M|50.31,69.39|N|To Sylannia.|

N Achievement|QID|960300004|N|Take the portal at the end of the dock.  Fly to Ironforge.|ACH|6030;4|U|74142|FACTION|Alliance|RANK|3|
N Achievement|QID|960300005|N|In the Mystic Quarter, take the portal to the Blasted Lands, then fly to Shattrath City.|ACH|6030;5|U|74142|FACTION|Alliance|RANK|3|
N Achievement|QID|960300006|N|Take the portal back to Stormwind.|ACH|6030;6|U|74142|FACTION|Alliance|RANK|3|
N Achievement|QID|960300001|N|Take the boat to Honor Hold and fly to Dalaran.|ACH|6030;1|U|74142|FACTION|Alliance|RANK|3|
N Achievement|QID|960300002|N|Take the portal to Stormwind, then take the boat to Darnassus.|ACH|6030;2|U|74142|FACTION|Alliance|RANK|3|
N Achievement|QID|960300003|N|Enter the Temple of the Moon and take the portal to The Exodar.|ACH|6030;3|U|74142|FACTION|Alliance|RANK|3|

N Achievement|QID|960310005|N|Take the portal back to Thunder Bluff, go into the city proper to set up your fireworks.|ACH|6031;5|U|74142|FACTION|Horde|RANK|3|
N Achievement|QID|960310003|N|Take the portal to the Blasted Lands, go through the Dark Portal and fly to Shattrath City.|ACH|6031;3|U|74142|FACTION|Horde|RANK|3|
N Achievement|QID|960310001|N|Take the portal back to Orgrimmar and take a zepplin/fly to Dalaran.|ACH|6031;1|U|74142|FACTION|Horde|RANK|3|
N Achievement|QID|960310002|N|Take the portal back to Orgrimmar|ACH|6031;2|U|74142|FACTION|Horde|RANK|3|
N Achievement|QID|960310006|N|Take a zepplin to Tirisfal Glade, fly to Undercity. Make sure your mini-map says Undercity, not Ruins of Lordaeron|ACH|6031;6|U|74142|FACTION|Horde|RANK|3|
N Achievement|QID|960310004|N|Take the globe thingie from the courtyard to Silvermoon City.|ACH|6031;4|U|74142|FACTION|Horde|RANK|3|

N End of Guide|N|You've reached the end of the guide! This guide will automatically reset when the dailies reset, or you can reset it manually by right-clicking this window's titlebar or frame.|
]]

end)
