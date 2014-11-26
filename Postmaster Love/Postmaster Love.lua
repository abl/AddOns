
local POSTMASTER_LOVE=CreateFrame("Frame")
local POSTMASTER_LOVE_eventHandlers={}
local mailbox_window=false

local function POSTMASTER_LOVE_mailbox_postmaster()
	local temp_value=false
	local loop_stop=false
	local bag_space=false
	for i=BACKPACK_CONTAINER,NUM_BAG_SLOTS do
		local numberOfFreeSlots,BagType=GetContainerNumFreeSlots(i)
		if BagType and BagType==0 and numberOfFreeSlots>0 then bag_space=true break end
	end
	for index=GetInboxNumItems(),1,-1 do
		if loop_stop or not mailbox_window then break end
		local _,_,sender,_,money,_,_,hasItem=GetInboxHeaderInfo(index)
		if sender=="The Postmaster" then
			if money and money>0 then temp_value=true TakeInboxMoney(index) C_Timer.After(1,POSTMASTER_LOVE_mailbox_postmaster) break end
			if hasItem and bag_space then
				for itemIndex=1,ATTACHMENTS_MAX_RECEIVE do
					local name=GetInboxItem(index,itemIndex)
					if name then TakeInboxItem(index,itemIndex) loop_stop=true C_Timer.After(1,POSTMASTER_LOVE_mailbox_postmaster) break end
				end
			end
			if money==0 and hasItem==nil then C_Timer.After(1,function() DeleteInboxItem(index) POSTMASTER_LOVE_mailbox_postmaster() end) break end
		end
	end
end

local function POSTMASTER_LOVE_event_Handler(self,event,...)
	return POSTMASTER_LOVE_eventHandlers[event](...)
end

function POSTMASTER_LOVE_eventHandlers.MAIL_CLOSED()
	mailbox_window=false
end

function POSTMASTER_LOVE_eventHandlers.MAIL_INBOX_UPDATE()
	POSTMASTER_LOVE_mailbox_postmaster()
end

function POSTMASTER_LOVE_eventHandlers.MAIL_SHOW()
	mailbox_window=true
end

POSTMASTER_LOVE:RegisterEvent("MAIL_CLOSED")
POSTMASTER_LOVE:RegisterEvent("MAIL_INBOX_UPDATE")
POSTMASTER_LOVE:RegisterEvent("MAIL_SHOW")
POSTMASTER_LOVE:SetScript("OnEvent",POSTMASTER_LOVE_event_Handler)

