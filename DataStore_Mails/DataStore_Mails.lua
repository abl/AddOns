﻿--[[	*** DataStore_Mails ***
Written by : Thaoky, EU-Marécages de Zangar
July 16th, 2009
--]]
if not DataStore then return end

local addonName = "DataStore_Mails"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0", "AceSerializer-3.0", "AceTimer-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"
local commPrefix = "DS_Mails"		-- let's keep it a bit shorter than the addon name, this goes on a comm channel, a byte is a byte ffs :p
local MAIL_EXPIRY = 30		-- Mails expire after 30 days

-- Message types
local MSG_SENDMAIL_INIT							= 1
local MSG_SENDMAIL_END							= 2
local MSG_SENDMAIL_ATTACHMENT					= 3
local MSG_SENDMAIL_BODY							= 4

local ICON_COIN = "Interface\\Icons\\INV_Misc_Coin_01"
local ICON_NOTE = "Interface\\Icons\\INV_Misc_Note_01"

local AddonDB_Defaults = {
	global = {
		Options = {
			ScanMailBody = 1,					-- by default, scan the body of a mail (this action marks it as read)
			CheckMailExpiry = 1,				-- check mail expiry or not
			MailWarningThreshold = 5,
			CheckMailExpiryAllAccounts = 1,
			CheckMailExpiryAllRealms = 1,
		},
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,		-- last time the mail was checked for this char
				lastVisitDate = nil,			-- in YYYY MM DD  hh:mm, for external apps
				Mails = {
					['*'] = {
						icon = nil,
						link = nil,
						count = nil,
						money = nil,
						lastCheck = 0,		-- last time "THIS" mail was checked (can be different than that of the mailbox)
						text = nil,
						subject = nil,
						sender = nil,
						daysLeft = 0,
						returned = nil,
					}
				},
				MailCache = {				-- same structure as "Mail", but serves as a cache for mails sent by a guildmate, until the mail actually arrives in the real mailbox (1h delay)
					['*'] = {
						icon = nil,
						link = nil,
						count = nil,
						money = nil,
						lastCheck = 0,		-- last time "THIS" mail was checked (can be different than that of the mailbox)
						text = nil,
						subject = nil,
						sender = nil,
						daysLeft = 0,
					}
				},
			}
		}
	}
}

-- *** Utility functions ***
local function GetIDFromLink(link)
	return tonumber(link:match("item:(%d+)"))
end

local function GetOption(option)
	return addon.db.global.Options[option]
end

local function GetMailTable(character, index)
	-- depending on the index passed, returns the right mail entry either from the "Mails" table or the "MailCache" table
	-- The assumption is that the MailCache entries come after the Mails entries
	-- This function is pure utility, and is not made public to client addons
	
	if index <= #character.Mails then
		return character.Mails[index]
	else
		index = index - #character.Mails
		return character.MailCache[index]
	end
end

local function GuildWhisper(player, messageType, ...)
	if DataStore:IsGuildMemberOnline(player) then
		local serializedData = addon:Serialize(messageType, ...)
		addon:SendCommMessage(commPrefix, serializedData, "WHISPER", player)
	end
end

local function HasHeirloomAttachment()
	local link, rarity, _

	for i = 1, ATTACHMENTS_MAX_SEND do	-- loop through all attachments
		link = GetSendMailItemLink(i)
		if link then
			_, _, rarity = GetItemInfo(link)
			
			if rarity == 7 then			-- is this an heirloom ?
				return true					-- .. yes, return true !
			end
		end
	end
end

local function SendGuildMail(recipient, subject, body, index)
	local player = DataStore:GetNameOfMain(recipient)
	if not player then return end
		
	-- this mail is sent to "player", but is for alt  "recipient"
	GuildWhisper(player, MSG_SENDMAIL_INIT, recipient)
	
	-- send attachments
	local isSentMail = (index == nil) and true or false
	local item, icon, count, link
	
	for attachmentIndex = 1, ATTACHMENTS_MAX_SEND do		-- mandatory, loop through all 12 slots, since attachments could be anywhere (ex: slot 4,5,8)
		if isSentMail then
			item, icon, count = GetSendMailItem(attachmentIndex)
			link = GetSendMailItemLink(attachmentIndex)
		else
			item, icon, count = GetInboxItem(index, attachmentIndex)
			link = GetInboxItemLink(index, attachmentIndex)
		end
		
		if item then
			GuildWhisper(player, MSG_SENDMAIL_ATTACHMENT, icon, link, count)
		end
	end
			
	-- .. then save the mail itself + gold if any
	local money = GetSendMailMoney()
	body = body or ""
	if (money > 0) or (strlen(body) > 0) then
		GuildWhisper(player, MSG_SENDMAIL_BODY, subject, body, money)
	end
	GuildWhisper(player, MSG_SENDMAIL_END)
end

-- *** Scanning functions ***
local function SaveAttachments(character, index, sender, days, wasReturned)
	-- saves attachments of a given mail index into a given character mailbox
	
	-- index nil = sent mail => different methods
	local isSentMail = (index == nil) and true or false
	
	local item, icon, count, link
	
	for attachmentIndex = 1, ATTACHMENTS_MAX_SEND do		-- mandatory, loop through all 12 slots, since attachments could be anywhere (ex: slot 4,5,8)
		if isSentMail then
			item, icon, count = GetSendMailItem(attachmentIndex)
			link = GetSendMailItemLink(attachmentIndex)
		else
			item, icon, count = GetInboxItem(index, attachmentIndex)
			link = GetInboxItemLink(index, attachmentIndex)
		end
		
		if item then
			table.insert(character.Mails, {
				["icon"] = icon,
				["count"] = count,
				["sender"] = sender,
				["link"] = link,
				lastCheck = time(),
				daysLeft = days,
				returned = wasReturned,
			} )
		end
	end
end

local function ScanMailbox()
	local character = addon.ThisCharacter
	wipe(character.Mails)
	
	local numItems = GetInboxNumItems();
	if numItems == 0 then
		return
	end
	
	local cache = character.MailCache
	-- check the cache, and clean entries that are about to be replaced in the scan
	for i = #cache, 1, -1 do
		if cache[i].lastCheck then
			local age = time() - cache[i].lastCheck
			
			if age > 3600 then		-- if older than 1 hour, delete this entry
				table.remove(cache, i)
			end
		end
	end
	
	for i = 1, numItems do
		local _, stationaryIcon, mailSender, mailSubject, mailMoney, _, days, numAttachments, _, wasReturned = GetInboxHeaderInfo(i);
		if numAttachments then	-- treat attachments as separate entries
			SaveAttachments(character, i, mailSender, days, wasReturned)
		end

		local inboxText
		if GetOption("ScanMailBody") == 1 then
			inboxText = GetInboxText(i)					-- this marks the mail as read
		end
		
		if (mailMoney > 0) or inboxText then			-- if there's money or text .. save the entry
			local mailIcon
			if mailMoney > 0 then
				mailIcon = ICON_COIN
			else
				mailIcon = stationaryIcon
			end
			table.insert(character.Mails, {
				icon = mailIcon,
				money = mailMoney,
				text = inboxText,
				subject = mailSubject,
				sender = mailSender,
				lastCheck = time(),
				daysLeft = days,
				returned = wasReturned,
			} )
		end
	end
	
	-- show mails with the lowest expiry first
	table.sort(character.Mails, function(a, b) return a.daysLeft < b.daysLeft end)
	
	addon:SendMessage("DATASTORE_MAILBOX_UPDATED")
end


-- *** Event Handlers ***
local function OnBagUpdate(event, bag)
	if addon.isOpen then	-- if a bag is updated while the mailbox is opened, this means an attachment has been taken.
		ScanMailbox()		-- I could not hook TakeInboxItem because mailbox content is not updated yet
	end
end

local function OnMailInboxUpdate(a, b, c)
	-- process only one occurence of the event, right after MAIL_SHOW
	addon:UnregisterEvent("MAIL_INBOX_UPDATE")
	ScanMailbox()
end

local function OnMailClosed()
	addon.isOpen = nil
	addon:UnregisterEvent("MAIL_CLOSED")
	ScanMailbox()
	
	local character = addon.ThisCharacter
	character.lastUpdate = time()
	character.lastVisitDate = date("%Y/%m/%d %H:%M")
	
	addon:UnregisterEvent("MAIL_SEND_INFO_UPDATE")
end

local function OnMailShow()
	-- the event may be triggered multiple times, exit if the mailbox is already open
	if addon.isOpen then return end	
	
	CheckInbox()
	addon:RegisterEvent("MAIL_CLOSED", OnMailClosed)
	addon:RegisterEvent("MAIL_INBOX_UPDATE", OnMailInboxUpdate)

	-- create a temporary table to hold the attachments that will be sent, keep it local since the event is rare
	addon.isOpen = true
end

-- ** Mixins **
local function _GetMailboxLastVisit(character)
	return character.lastUpdate or 0
end

local function _GetMailItemCount(character, searchedID)
	local count = 0
	for _, v in pairs (character.Mails) do
		local link = v.link
		if link and (GetIDFromLink(link) == searchedID) then
			count = count + (v.count or 1)
		end
	end
	
	for _, v in pairs (character.MailCache) do
		local link = v.link
		if link and (GetIDFromLink(link) == searchedID) then
			count = count + (v.count or 1)
		end
	end
	return count
end

local function _GetNumMails(character)
	return #character.Mails + #character.MailCache
end

local function _GetMailInfo(character, index)
	local data = GetMailTable(character, index)
	return data.icon, data.count, data.link, data.money, data.text, data.returned
end

local function _GetMailSender(character, index)
	local data = GetMailTable(character, index)
	return data.sender
end

local function _GetMailExpiry(character, index)
	local data = GetMailTable(character, index)

	-- return the mail expiry, expressed in days and in seconds
	local diff = time() - data.lastCheck
	local days = data.daysLeft - (diff / 86400)
	local seconds = (data.daysLeft * 86400) - diff
	
	return days, seconds
end

local function _GetMailSubject(character, index)
	local data = GetMailTable(character, index)
	
	if data.subject then			-- if there's a subject, use it
		return data.subject
	end
	-- otherwise, return the name of the item
	
	local name
	local link = data.link
	if link then
		local id = GetIDFromLink(link)
		name = GetItemInfo(id)
	end
	return name
end

local function _GetNumExpiredMails(character, threshold)
	local count = 0
	for i = 1, _GetNumMails(character) do
		if _GetMailExpiry(character, i) < threshold then
			count = count + 1
		end
	end
	return count
end

local function _SaveMailToCache(character, mailMoney, mailBody, mailSubject, mailSender)
	local mailIcon = (mailMoney > 0) and ICON_COIN or ICON_NOTE
	
	table.insert(character.MailCache, {
		money = mailMoney,
		icon = mailIcon,
		text = mailBody,
		subject = mailSubject,
		sender = mailSender,
		lastCheck = time(),
		daysLeft = MAIL_EXPIRY,
	} )
end

local function _SaveMailAttachmentToCache(character, mailIcon, mailLink, mailCount, mailSender)
	table.insert(character.MailCache, {
		icon = mailIcon,
		link = mailLink,
		count = mailCount,
		sender = mailSender,
		lastCheck = time(),
		daysLeft = MAIL_EXPIRY,
	} )
end

local function _IsMailBoxOpen()
	return addon.isOpen
end

local function _ClearMailboxEntries(character)
	wipe(character.Mails)
	wipe(character.MailCache)
end

local PublicMethods = {
	GetMailboxLastVisit = _GetMailboxLastVisit,
	GetMailItemCount = _GetMailItemCount,
	GetNumMails = _GetNumMails,
	GetMailInfo = _GetMailInfo,
	GetMailSender = _GetMailSender,
	GetMailExpiry = _GetMailExpiry,
	GetMailSubject = _GetMailSubject,
	GetNumExpiredMails = _GetNumExpiredMails,
	SaveMailToCache = _SaveMailToCache,
	SaveMailAttachmentToCache = _SaveMailAttachmentToCache,
	IsMailBoxOpen = _IsMailBoxOpen,
	ClearMailboxEntries = _ClearMailboxEntries,
}

-- *** Guild Comm ***
local guildMailRecipient			-- name of the alt who receives a mail from a guildmate
local guildMailRecipientKey		-- key of the alt who receives a mail from a guildmate

local GuildCommCallbacks = {
	[MSG_SENDMAIL_INIT] = function(sender, recipient)
			guildMailRecipient = recipient
			guildMailRecipientKey = format("%s.%s.%s", THIS_ACCOUNT, GetRealmName(), recipient)
		end,
	[MSG_SENDMAIL_END] = function(sender)
			if guildMailRecipient then
				addon:SendMessage("DATASTORE_GUILD_MAIL_RECEIVED", sender, guildMailRecipient)
			end
			guildMailRecipient = nil
			guildMailRecipientKey = nil
		end,
	[MSG_SENDMAIL_ATTACHMENT] = function(sender, icon, link, count)
			local recipientTable = addon.db.global.Characters[guildMailRecipientKey]
			if recipientTable then
				_SaveMailAttachmentToCache(recipientTable, icon, link, count, sender)
			end
		end,
	[MSG_SENDMAIL_BODY] = function(sender, subject, body, money)
			local recipientTable = addon.db.global.Characters[guildMailRecipientKey]
			if recipientTable then
				_SaveMailToCache(recipientTable, money, body, subject, sender)
			end
		end,
}

local function CheckExpiries()
	local allAccounts = GetOption("CheckMailExpiryAllAccounts")
	local allRealms = GetOption("CheckMailExpiryAllRealms")
	local threshold = GetOption("MailWarningThreshold")
	local expiryFound
	
	local account, realm
	for key, character in pairs(addon.db.global.Characters) do
		account, realm = strsplit(".", key)
		
		if allAccounts == 1 or ((allAccounts == 0) and (account == THIS_ACCOUNT)) then		-- all accounts, or only current and current was found
			if allRealms == 1 or ((allRealms == 0) and (realm == GetRealmName())) then			-- all realms, or only current and current was found
	
			-- detect return vs delete
				local numExpiredMails = _GetNumExpiredMails(character, threshold)
				if numExpiredMails > 0 then
					expiryFound = true
					addon:SendMessage("DATASTORE_MAIL_EXPIRY", character, key, threshold, numExpiredMails)
				end
			end
		end
	end
	
	if expiryFound then
		-- global expiry message, register this one if your addon just wants to know that at least one mail has expired, and you don't care which.
		addon:SendMessage("DATASTORE_GLOBAL_MAIL_EXPIRY", threshold)
	end
end

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetGuildCommCallbacks(commPrefix, GuildCommCallbacks)
	
	DataStore:SetCharacterBasedMethod("GetMailboxLastVisit")
	DataStore:SetCharacterBasedMethod("GetMailItemCount")
	DataStore:SetCharacterBasedMethod("GetNumMails")
	DataStore:SetCharacterBasedMethod("GetMailInfo")
	DataStore:SetCharacterBasedMethod("GetMailSender")
	DataStore:SetCharacterBasedMethod("GetMailExpiry")
	DataStore:SetCharacterBasedMethod("GetMailSubject")
	DataStore:SetCharacterBasedMethod("GetNumExpiredMails")
	DataStore:SetCharacterBasedMethod("SaveMailToCache")
	DataStore:SetCharacterBasedMethod("SaveMailAttachmentToCache")
	DataStore:SetCharacterBasedMethod("ClearMailboxEntries")
	
	addon:RegisterComm(commPrefix, DataStore:GetGuildCommHandler())
end

function addon:OnEnable()
	addon:RegisterEvent("MAIL_SHOW", OnMailShow)
	addon:RegisterEvent("BAG_UPDATE", OnBagUpdate)
	
	addon:SetupOptions()
	if GetOption("CheckMailExpiry") == 1 then
		addon:ScheduleTimer(CheckExpiries, 5)	-- check mail expiries 5 seconds later, to decrease the load at startup
	end
end

function addon:OnDisable()
	addon:UnregisterEvent("MAIL_SHOW")
	addon:UnregisterEvent("BAG_UPDATE")
end


-- *** Hooks ***

local Orig_SendMail = SendMail

local function SendOwnMail(characterKey, subject, body)
	local character = addon.db.global.Characters[characterKey]
	
	SaveAttachments(character, nil, UnitName("player"), MAIL_EXPIRY)
	
	-- .. then save the mail itself + gold if any
	local moneySent = GetSendMailMoney()
	if (moneySent > 0) or (strlen(body) > 0) then
		table.insert(character.Mails, {
			money = moneySent,
			icon = (moneySent > 0) and ICON_COIN or ICON_NOTE,
			text = body,
			subject = subject,
			sender = UnitName("player"),
			lastCheck = time(),
			daysLeft = MAIL_EXPIRY,
		} )
	end
	
	-- if the alt has never checked his mail before, this value won't be correct, so set it to make sure expiry returns proper results.
	character.lastUpdate = time()
	
	table.sort(character.Mails, function(a, b)		-- show mails with the lowest expiry first
		return a.daysLeft < b.daysLeft
	end)
end

hooksecurefunc("SendMail", function(recipient, subject, body, ...)
	-- this function takes care of saving mails sent to alts directly into their mailbox, so that client addons don't have to take care about it
	local isRecipientAnAlt

	local recipientName, recipientRealm = strsplit("-", recipient)
	
	recipientRealm = recipientRealm or GetRealmName()
	-- for the current realm, recipientRealm could be
	-- 	- empty (recipient = "Thaoky")
	--		- packed named (recipient = "Thaoky-MarécagedeZangar" => realm should be "Marécage de Zangar"
	
	-- recipientRealm is nil = current realm
	-- recipientRealm is not nil = any realm (current or other)
	
	-- do we have an alt on the target realm ?

	for realm in pairs(DataStore:GetRealms()) do
		-- "Marécage de Zangar" becomes "MarécagedeZangar"
		
		if strlower(gsub(realm, " ", "")) == strlower(gsub(recipientRealm, " ", "")) then		-- right realm found ? proceed
			for characterName, characterKey in pairs(DataStore:GetCharacters(realm)) do
				if strlower(characterName) == strlower(recipientName) then		-- right alt ? proceed
					SendOwnMail(characterKey, subject, body)
					if not HasHeirloomAttachment() then
						DataStore:SetConnectedRealms(realm, GetRealmName())
					end
					isRecipientAnAlt = true
					break
				end
			end
		end
	end
	
	if not isRecipientAnAlt then	-- if recipient is not an alt, maybe it's a guildmate
		SendGuildMail(recipientName, subject, body)
	end
end)

local function ReturnOwnMail(characterKey, index, mailSubject, mailMoney, stationaryIcon, numAttachments)
	local character = addon.db.global.Characters[characterKey]

	if numAttachments then	-- treat attachments as separate entries
		SaveAttachments(character, index, UnitName("player"), MAIL_EXPIRY, true)
	end

	local inboxText = GetInboxText(index)		-- this marks the mail as read, no problem here since the mail is returned anyway
	
	if (mailMoney > 0) or inboxText then			-- if there's money or text .. save the entry
		
		table.insert(character.Mails, {
			icon = (mailMoney > 0) and ICON_COIN or stationaryIcon,
			money = mailMoney,
			text = inboxText,
			subject = mailSubject,
			sender = UnitName("player"),
			lastCheck = time(),
			daysLeft = MAIL_EXPIRY,
			returned = true,				-- this is the mail we're returning, so true
		} )
	end
end

hooksecurefunc("ReturnInboxItem", function(index, ...)
	local _, stationaryIcon, mailSender, mailSubject, mailMoney, _, _, numAttachments = GetInboxHeaderInfo(index)
	local isRecipientAnAlt

	local recipientName, recipientRealm = strsplit("-", mailSender)

	recipientRealm = recipientRealm or GetRealmName()
	
	-- do we have an alt on the target realm ?
	for realm in pairs(DataStore:GetRealms()) do
		
		-- "Marécage de Zangar" becomes "MarécagedeZangar"
		if strlower(gsub(realm, " ", "")) == strlower(gsub(recipientRealm, " ", "")) then		-- right realm found ? proceed
			for characterName, characterKey in pairs(DataStore:GetCharacters(realm)) do
				if strlower(characterName) == strlower(recipientName) then		-- right alt ? proceed
					ReturnOwnMail(characterKey, index, mailSubject, mailMoney, stationaryIcon, numAttachments)
					isRecipientAnAlt = true
					break
				end
			end
		end
	end
		
	if not isRecipientAnAlt then	-- if recipient is not an alt, maybe it's a guildmate
		SendGuildMail(recipientName, mailSubject, GetInboxText(index), index)
	end
end)
