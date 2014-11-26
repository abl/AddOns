
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/node/3538
-- Date: 2014-06-03 22:15
-- Who: Ludovicus
-- Log: Moved Author to the right slot!

-- URL: http://wow-pro.com/node/3538/revisions/26313/view
-- Date: 2014-05-26 18:05
-- Who: Ludovicus
-- Log: Added guide type.

-- URL: http://wow-pro.com/node/3538/revisions/26199/view
-- Date: 2014-05-22 22:57
-- Who: Ludovicus
-- Log: Registration guide

-- URL: http://wow-pro.com/node/3538/revisions/25546/view
-- Date: 2013-03-23 16:35
-- Who: Ludovicus

local guide = WoWPro:RegisterGuide('EstAchHiLe',"Achievements",'Dalaran', 'Estelyen','Neutral')
WoWPro:GuideIcon(guide,"ACH",1956)
WoWPro:GuideSteps(guide, function()
return
[[
N Higher Learning|N|This guide will help you to get the Higher Learning achievement. It requires you to read a number of books in Dalaran. These books appear in fixed places, but often get replaced by a non-achievement-related book. Once you have read one of them (even the non-achievement-related ones), they disappear after a few minutes and you have to wait 3-4 hours before the next book appears in that location. So if you find a "wrong" book at one of the locations in this guide, you need to read it anyway and come back 3-4 hours later.|
N Note of caution|N|Despite these steps showing a yellow "!" in the guide, you do not actually need to accept a quest or see a "!" over the books.|
A Introduction|ACH|1956;1|N|On the ground next to the northern bookshelf.|Z|Dalaran City@Dalaran|M|56.68,45.60|
A Illusion|ACH|1956;6|N|On the crate in the corner behind Archmage Timear.|Z|Dalaran City@Dalaran|M|64.42,52.37|
A Abjuration|ACH|1956;2|N|On the ground next to Mirla Silverblaze.|Z|Dalaran City@Dalaran|M|52.38,54.76|
A Conjuration|ACH|1956;3|N|When you enter the citadel, turn right; it's in the left of the two bookshelves there (downstairs).|Z|Dalaran City@Dalaran|M|30.78,45.89|
A Divination|ACH|1956;4|N|Upstairs, on the ground between the bookshelves by the Caverns of Time portal.|Z|Dalaran City@Dalaran|M|26.49,52.21|
A Enchantment|ACH|1956;5|N|On the balcony, on one of the crates east of the doorway.|Z|Dalaran City@Dalaran|M|43.56,46.71|
A Necromancy|ACH|1956;7|N|In the upstairs room with 4 beds, in the empty bookshelf.|Z|Dalaran City@Dalaran|M|46.69,39.05|
A Transmutation|ACH|1956;8|N|In the empty bookshelf downstairs by the stove.|Z|Dalaran City@Dalaran|M|46.75,40.14|
N Keep resetting|QID|972810001|N|until you find them all (or give up).|
]]
end)
