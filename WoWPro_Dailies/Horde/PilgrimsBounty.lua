
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/pilgrimsbountydalies_alliance_and_horde
-- Date: 2014-11-08 00:25
-- Who: Ludovicus
-- Log: One more N tag

-- URL: http://wow-pro.com/node/3456/revisions/26849/view
-- Date: 2014-11-07 20:36
-- Who: Fluclo
-- Log: Missing N tags

-- URL: http://wow-pro.com/node/3456/revisions/26835/view
-- Date: 2014-11-06 18:20
-- Who: Fluclo
-- Log: Added five missing |N| tags

-- URL: http://wow-pro.com/node/3456/revisions/26587/view
-- Date: 2014-07-20 19:34
-- Who: Ludovicus
-- Log: Added catrgories and icon

-- URL: http://wow-pro.com/node/3456/revisions/26551/view
-- Date: 2014-07-06 15:33
-- Who: Ludovicus
-- Log: Added Name and category

-- URL: http://wow-pro.com/node/3456/revisions/26513/view
-- Date: 2014-06-10 23:21
-- Who: Ludovicus
-- Log: Changed level guide.

-- URL: http://wow-pro.com/node/3456/revisions/25706/view
-- Date: 2013-06-18 00:35
-- Who: Ludovicus
-- Log: Got rid of stuttered M tag

-- URL: http://wow-pro.com/node/3456/revisions/24897/view
-- Date: 2012-01-19 00:02
-- Who: Ludovicus
-- Log: Correct node numbers

-- URL: http://wow-pro.com/node/3456/revisions/24896/view
-- Date: 2012-01-19 00:00
-- Who: Ludovicus
-- Log: Sync to GIT

local guide = WoWPro:RegisterGuide("LudoPilgrimDailiesH",'Dailies',"Pilgrim's Bounty", "Ludovicus", "Horde")
WoWPro:GuideLevels(guide,1,90,45.000000)
WoWPro.Dailies:GuideNameAndCategory(guide,"Pilgrim's Bounty")
WoWPro:GuideIcon(guide,"ACH",3597)
WoWPro:GuideSteps(guide, function()
return [[

N Pilgrim's Bounty Start|N|Get thee to Orgrimmar city gates..|
A Can't Get Enough Turkey|QID|14061|M|46.37,13.85|Z|Durotar|N|From Ondani Greatmill, near Orgrimmar city gates.|
A Don't Forget The Stuffing!|QID|14062|M|46.37,13.85|Z|Durotar|N|From Ondani Greatmill, near Orgrimmar city gates.|
B Buy Autumnal Herbs|QID|14062|M|46.62,13.79|Z|Durotar|L|44835 20|N|You need 20 Autumnal Herbs from Dalni Tallgrass.|
B Buy Simple Flour|QID|14062|M|46.62,13.79|Z|Durotar|L|30817 20|N|You need 20 Flour.|
B Buy Mild Spices|QID|14062|M|46.62,13.79|Z|Durotar|L|2678 20|N|You need 20 Mild Spices.|
B Buy Tangy Southfury Cranberries|QID|14062|M|46.62,13.79|Z|Durotar|L|46793 20|N|Buy 20 Cranberries.|
B Buy Honey|QID|14062|M|46.62,13.79|Z|Durotar|L|44853 20|N|You will need 20 Honeys.|
l Spice Bread|QID|14062|M|46.44,13.87|Z|Durotar|L|30816 20|N|Cook up 20 Spice Bread.|
l Spice Bread Stuffing|QID|14062|M|46.44,13.87|Z|Durotar|L|44837 20|N|Cook up 20 Spice Bread Stuffing.|
T Don't Forget The Stuffing!|QID|14062|M|46.37,13.85|Z|Durotar|N|To Ondani Greatmill, near Orgrimmar city gates.|

b Tirisfal Glades|QID|14061|M|50.77,55.92|Z|Orgrimmar|N|Take the zepplin to Undercity|
K Wild Turkey|QID|14061|M|67.2,57.1|Z|Tirisfal Glades|L|44834 20|N|Get 20 raw turkeys, they are everywhere!|
A We're Out of Cranberry Chutney Again?|QID|14059|M|63.20,8.94|Z|Undercity|N|From Roberta Carter, outside of Undercity.|
l Cranberry Chutney|QID|14059|M|63.29,8.40|Z|Undercity|L|44840 20|N|Cook up 20 Chutneys|
T We're Out of Cranberry Chutney Again?|QID|14059|M|63.20,8.94|Z|Undercity|N|To Roberta Carter, outside of Undercity.|
B Buy Ripe Tirisfal Pumpkin|QID|14061|M|63.86,11.18|Z|Undercity|L|46796 20|N|You need 20 Pumpkins from Rose Standish, Undercity.|
B Buy Honey|QID|14061|M|63.86,11.18|Z|Undercity|L|44853 20|N|You will need 20 Honeys.|
A She Says Potato|QID|14058|M|65.24,14.22|Z|Undercity|N|To William Mullins, Undercity.|
b Orgrimmar|QID|14058|M|60.71,58.74|Z|Tirisfal Glades|N|Take the zepplin to Orgrimmar, then to Thunder Bluff.|

b Thunder Bluff|QID|14058|M|43.04,65.00|Z|Orgrimmar|N|Take the zepplin to Thunder Bluff or fly.|
A Easy As Pie|QID|14060|M|30.96,69.79|Z|Thunder Bluff|N|From Mahara Goldwheat, outside of Thunder Bluff elevator.|
l Pumpkin Pie|QID|14060|M|30.59,70.01|Z|Thunder Bluff|L|44836 20|N|Cook up 20 pies|
T Easy As Pie|QID|14060|M|30.96,69.79|Z|Thunder Bluff|N|To Mahara Goldwheat, outside of Thunder Bluff elevator.|
B Buy Mulgore Sweet Potato|QID|14058|M|31.02,63.33|Z|Thunder Bluff|L|46797 20|N|Buy 20 Sweet Potatoes from Laha Farplain.|
B Buy Honey|QID|14061|M|31.02,63.33|Z|Thunder Bluff|L|44853 40|N|You will need 40 Honeys.|
B Buy Autumnal Herbs|QID|14061|M|31.02,63.33|Z|Thunder Bluff|L|44835 20|N|You need 20 Autumnal Herbs.|

b Orgrimmar|QID|14061|M|15.35,25.65|Z|Thunder Bluff|N|Take the zepplin to Orgrimmar or fly.|
l Slow-Roasted Turkey|QID|14061|M|46.4,13.8|Z|Durotar|L|44838 20|N|Cook 20 turkeys.|
T Can't Get Enough Turkey|QID|14061|M|46.4,13.8|Z|Durotar|N|To Ondani Greatmill, near Orgrimmar city gates.|
B Buy Autumnal Herbs|QID|14058|M|46.62,13.79|Z|Durotar|L|44835 20|N|You need 20 Autumnal Herbs from Dalni Tallgrass.|
B Buy Honey|QID|14058|M|46.62,13.79|Z|Durotar|L|44853 20|N|You will need 20 Honeys.|

b Tirisfal Glades|QID|14058|M|50.77,55.92|Z|Orgrimmar|N|Take the zepplin to Undercity.|
l Candied Sweet Potatoes|QID|14058|M|65.24,14.22|Z|Undercity|L|44839 20|N|Cook up some Sweet Potatoes.|
T She Says Potato|QID|14058|M|65.24,14.22|Z|Undercity|N|To William Mullins, Undercity.|

N Pilgrim's Bounty|N|You are done for the day!|
]]
end)
