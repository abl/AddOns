local addonName = ...

local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhTW", false)
if not L then return end

L["charframe_tab"] = "動作條"
L["confirm_delete"] = "你確定想要刪除此動作條設定檔 %s？"
L["confirm_overwrite"] = "你已經有一個動作條設定檔名為 %s。你確定要覆寫它？"
L["confirm_save"] = "你想要儲存此動作條設定檔 %s嗎？"
L["confirm_use"] = "從當前角色不能使用 %s 來自 %s 的設定檔操作。您想要使用此設定檔嗎？"
L["error_exists"] = "此名稱的動作條設定檔已經存在。"
L["new_profile"] = "新設定檔"
L["option_companions"] = "夥伴與坐騎"
L["option_empty_slots"] = "空格" -- Needs review
L["option_equip_sets"] = "裝備設置" -- Needs review
L["option_items"] = "物品"
L["option_macros"] = "巨集"
L["option_pet_spells"] = "寵物或惡魔法術" -- Needs review
L["option_spells"] = "法術與彈出按鈕"
L["profile_name"] = "輸入設定檔名稱(最大16個字元，中文8個字元):"
L["profile_options"] = "儲存到設定檔："

