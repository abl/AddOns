---------------------------------------------
--      WoWPro_Achievements_GuideList.lua      --
---------------------------------------------
WoWPro.Achievements.GuideList = {}
WoWPro.Achievements.GuideList.Guides = {}

WoWProDB.global.Achievements = WoWProDB.global.Achievements or {}
-- Creating a Table of Guides for the Guide List and sorting based on level --
local guides

function WoWPro.Achievements.Scrape()
    WoWProDB.global.Achievements.Category = {}
    WoWProDB.global.Achievements.Achievement = {}

    local categories = GetCategoryList()
    for i, cid in ipairs(categories) do
        local name, parentID, flags = GetCategoryInfo(cid)
        WoWProDB.global.Achievements.Category[cid] = { ['name'] = name, ['parentID'] = parentID}
    end
    for cid, cinfo in pairs(WoWProDB.global.Achievements.Category) do
        local numItems, numCompleted = GetCategoryNumAchievements(cid)
        for index = 1,numItems do
            local id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuildAch, wasEarnedByMe, earnedBy = GetAchievementInfo(cid, index)
            WoWProDB.global.Achievements.Achievement[id] = {['cid'] = cid, ['name'] = name, ['icon'] = icon } 
        end
    end    
end

local function AddInfo(guide)
    if not guide.ach then
        WoWPro.Achievements:Error("Guide %s: missing ach",guide.GID)
        guide.name = "Unknown"
        guide.category = ""
        guide.sub = ""
        return
    end        
    WoWPro.Achievements:dbp("Guide %s: ach %s",guide.GID,tostring(guide.ach))
    if not WoWProDB.global.Achievements.Achievement[guide.ach] then
        -- Not categorized?  Just make it misc
        local id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuildAch, wasEarnedByMe, earnedBy = GetAchievementInfo(guide.ach)
        guide.name = name
        guide.category = name
        guide.sub = ""
        guide.icon = icon
        return
    end
    guide.name = WoWProDB.global.Achievements.Achievement[guide.ach].name
    guide.icon = WoWProDB.global.Achievements.Achievement[guide.ach].icon
    WoWPro.Achievements:dbp("Guide %s: cid %s",guide.GID,WoWProDB.global.Achievements.Achievement[guide.ach].cid)
    local cat = WoWProDB.global.Achievements.Category[WoWProDB.global.Achievements.Achievement[guide.ach].cid]
    guide.sub = cat.name
    if cat.parentID > 0 then
        guide.category = WoWProDB.global.Achievements.Category[cat.parentID].name
    else
        -- No parent category
        guide.category = cat.name
        guide.sub = ""
    end
    WoWPro.Achievements:dbp("%s: [%s] [%s/%s]",guide.GID, guide.name, guide.category, guide.sub)
end
    
    
-- Creating a Table of Guides for the Guide List and sorting based on level --
local function Init()
    guides = {}
    if not WoWProDB.global.Achievements.Category then
        WoWPro.Achievements.Scrape()
    end
    
    for guidID,guide in pairs(WoWPro.Guides) do
    	if guide.guidetype == "Achievements" then
    	    local function progress ()
    	        if WoWProCharDB.Guide[guidID] and WoWProCharDB.Guide[guidID].progress and WoWProCharDB.Guide[guidID].total then
    	            return WoWProCharDB.Guide[guidID].progress.."/"..WoWProCharDB.Guide[guidID].total
    	        end
    	        return ""
    	    end
    	    AddInfo(guide)
    		table.insert(guides, {
    			GID = guidID,
    			guide = guide,
    			Name = guide.name,
    			Author = guide.author,
    			Category = guide.category,
    			Sub = guide.sub,
    			Progress = progress, 
    		})
    	end
    end
    table.sort(guides, function(a,b) return a.Name < b.Name end)
    WoWPro.Achievements.GuideList.Guides = guides
end

-- Sorting Functions --
local sorttype = "Default"
local function authorSort()
	if sorttype == "AuthorAsc" then
		table.sort(guides, function(a,b) return a.Author > b.Author end)
		WoWPro.Achievements:UpdateGuideList()
		sorttype = "AuthorDesc"
	else
		table.sort(guides, function(a,b) return a.Author < b.Author end)
		WoWPro.Achievements:UpdateGuideList()
		sorttype = "AuthorAsc"
	end
end
local function nameSort()
	if sorttype == "NameAsc" then
		table.sort(guides, function(a,b) return a.Name > b.Name end)
		WoWPro.Achievements:UpdateGuideList()
		sorttype = "NameDesc"
	else
		table.sort(guides, function(a,b) return a.Name < b.Name end)
		WoWPro.Achievements:UpdateGuideList()
		sorttype = "NameAsc"
	end
end
local function categorySort()
	if sorttype == "CategoryAsc" then
		table.sort(guides, function(a,b) return a.Category > b.Category end)
		WoWPro.Achievements:UpdateGuideList()
		sorttype = "CategoryDesc"
	else
		table.sort(guides, function(a,b) return a.Category < b.Category end)
		WoWPro.Achievements:UpdateGuideList()
		sorttype = "CategoryAsc"
	end
end
local function subSort()
	if sorttype == "SubAsc" then
		table.sort(guides, function(a,b) return a.Sub > b.Sub end)
		WoWPro.Achievements:UpdateGuideList()
		sorttype = "SubDesc"
	else
		table.sort(guides, function(a,b) return a.Sub < b.Sub end)
		WoWPro.Achievements:UpdateGuideList()
		sorttype = "SubAsc"
	end
end

-- Fancy tooltip!
function WoWPro.Achievements.GuideTooltipInfo(row, tooltip, guide)
    GameTooltip:SetOwner(row, "ANCHOR_TOPLEFT")
    GameTooltip:AddLine(guide.name)
    if guide.icon then
        GameTooltip:AddTexture(guide.icon,1,1,1,1)
        GameTooltip:AddLine(guide.icon)
        GameTooltip:AddTexture("")
    else
        GameTooltip:AddTexture("Interface\\Icons\\Ability_DualWield")
        GameTooltip:AddLine("")
        GameTooltip:AddTexture("")
    end
    GameTooltip:AddDoubleLine("Category:",guide.category,1,1,1,unpack(WoWPro.LevelColor(guide)))
    GameTooltip:AddDoubleLine("SubCategory:",guide.sub,1,1,1,unpack(WoWPro.LevelColor(guide)))
end
    

-- Describe the table to the Core Module
WoWPro.Achievements.GuideList.Format={{"Name",0.30,nameSort},{"Category",0.15,categorySort},{"Sub",0.25,subSort},{"Author",0.15,authorSort},{"Progress",0.15,nil}}
WoWPro.Achievements.GuideList.Init = Init

WoWPro.Achievements:dbp("Guide Setup complete")
