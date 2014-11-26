-- UI.lua
-- Dynamic UI Elements


local util = Hekili.Utils


local invert_direction = {
	LEFT = 'RIGHT',
	RIGHT = 'LEFT',
	TOP = 'BOTTOM',
	BOTTOM = 'TOP'
}


-- Builds and maintains the visible UI elements.
-- Buttons (as frames) are never deleted, but should get reused effectively.
function Hekili:BuildUI()

	self:CacheDurableDisplayCriteria()
	
	if not self.UI.Engine then
		self.UI.Engine = CreateFrame( "Frame", "Hekili_Engine_Frame", UIParent)
		self.UI.Engine:SetFrameStrata("BACKGROUND")
		self.UI.Engine:SetClampedToScreen(true)
		self.UI.Engine:SetMovable(false)
		self.UI.Engine:EnableMouse(false)
	end
	
	self.UI.Buttons	= self.UI.Buttons or {}
	
	for dispID, display in ipairs( self.DB.profile.displays ) do
		self.UI.Buttons[dispID] = self.UI.Buttons[dispID] or {}
		
		if not self[ 'ProcessDisplay'..dispID ] then
			self[ 'ProcessDisplay'..dispID ] = function()
				self:ProcessHooks( dispID )
			end
		end

		for i = 1, max( #self.UI.Buttons[dispID], display['Icons Shown'] ) do
			self.UI.Buttons[dispID][i] = self:CreateButton( dispID, i )
			
			self.UI.Buttons[dispID][i]:Hide()

			if self.DisplayVisible[ dispID ] and i <= display[ 'Icons Shown' ] then
				self.UI.Buttons[dispID][i]:Show()
			end
			
			if self.MSQ then self.msqGroup:AddButton( self.UI.Buttons[dispID][i], { Icon = self.UI.Buttons[dispID][i].Texture, Cooldown = self.UI.Buttons[dispID][i].Cooldown } ) end	
		end
		
	end

	if self.MSQ then self.msqGroup:ReSkin() end
	
	-- Check for a display that has been removed.
	for display, buttons in ipairs( self.UI.Buttons ) do
		if not self.DB.profile.displays[display] then
			for i,_ in ipairs( buttons) do
				buttons[i]:Hide()
			end
		end
	end
	
	self.builtUI = true
end


local T
local SyntaxColors = {};


if Hekili.Format then
	T = Hekili.Format.Tokens;
	--- Assigns a color to multiple tokens at once.
	local function Color ( Code, ... )
		for Index = 1, select( "#", ... ) do
			SyntaxColors[ select( Index, ... ) ] = Code;
		end
	end
	Color( "|cffB266FF", T.KEYWORD ) -- Reserved words

	Color( "|cffffffff", T.LEFTCURLY, T.RIGHTCURLY,
		T.LEFTBRACKET, T.RIGHTBRACKET,
		T.LEFTPAREN, T.RIGHTPAREN )
		
	Color( "|cffFF66FF", T.UNKNOWN, T.ADD, T.SUBTRACT, T.MULTIPLY, T.DIVIDE, T.POWER, T.MODULUS,
		T.CONCAT, T.VARARG, T.ASSIGNMENT, T.PERIOD, T.COMMA, T.SEMICOLON, T.COLON, T.SIZE,
		T.EQUALITY, T.NOTEQUAL, T.LT, T.LTE, T.GT, T.GTE )

	Color( "|cFFB2FF66", util.Unpacks( Hekili.Tables, Hekili.Keys, Hekili.Values ) )
	
	Color( "|cffFFFF00", T.NUMBER )
	Color( "|cff888888", T.STRING, T.STRING_LONG )
	Color( "|cff55cc55", T.COMMENT_SHORT, T.COMMENT_LONG )
	Color( "|cff55ddcc", -- Minimal standard Lua functions
		"assert", "error", "ipairs", "next", "pairs", "pcall", "print", "select",
		"tonumber", "tostring", "type", "unpack",
		-- Libraries
		"bit", "coroutine", "math", "string", "table" )
	Color( "|cffddaaff", -- Some of WoW's aliases for standard Lua functions
		-- math
		"abs", "ceil", "floor", "max", "min",
		-- string
		"format", "gsub", "strbyte", "strchar", "strconcat", "strfind", "strjoin",
		"strlower", "strmatch", "strrep", "strrev", "strsplit", "strsub", "strtrim",
		"strupper", "tostringall",
		-- table
		"sort", "tinsert", "tremove", "wipe" )
end


local SpaceLeft = { "(%()" }
local SpaceRight = { "(%))" }
local DoubleSpace = { "(!=)", "(~=)", "(>=*)", "(<=*)", "(&)", "(||)" }


local function Format ( Code )
	for Index = 1, #SpaceLeft do
		Code = Code:gsub( "%s-"..SpaceLeft[Index].."%s-", " %1")
	end

	for Index = 1, #SpaceRight do
		Code = Code:gsub( "%s-"..SpaceRight[Index].."%s-", "%1 ")
	end

	for Index = 1, #DoubleSpace do
		Code = Code:gsub( "%s-"..DoubleSpace[Index].."%s-", " %1 ")
	end
	
	Code = Code:gsub( "([^<>~!])(=+)", "%1 %2 ")
	Code = Code:gsub( "%s+", " " ):trim()
	return Code
end


function Hekili:ShowDiagnosticTooltip( q )
	self.Tooltip:SetOwner( UIParent, "ANCHOR_CURSOR" )
	self.Tooltip:SetBackdropColor( 0, 0, 0, 1 )
	self.Tooltip:SetText( self.Abilities[ q.actName ].name )
	self.Tooltip:AddDoubleLine( q.alName.." #"..q.action, "+" .. round( q.time, 2 ) .."s", 1, 1, 1, 1, 1, 1 )

	if q.HookScript and q.HookScript ~= "" then
		self.Tooltip:AddLine( "\nHook Criteria" )
		
		local Text = Format ( q.HookScript )
		self.Tooltip:AddLine( self.Format:ColorString( Text, SyntaxColors ), 1, 1, 1, 1 )
		
		if q.HookElements then
			self.Tooltip:AddLine( "Values" )
			for k, v in pairs( q.HookElements ) do
				self.Tooltip:AddDoubleLine( k, self.Utils.FormatValue( v ) , 1, 1, 1, 1, 1, 1 )
			end
		end
	end
	
	if q.ActScript and q.ActScript ~= "" then
		self.Tooltip:AddLine( "\nAction Criteria" )
		
		local Text = Format ( q.ActScript )
		self.Tooltip:AddLine( self.Format:ColorString( Text, SyntaxColors ), 1, 1, 1, 1 )
		
		if q.ActElements then
			self.Tooltip:AddLine( "Values" )
			for k,v in pairs( q.ActElements ) do
				self.Tooltip:AddDoubleLine( k, self.Utils.FormatValue( v ) , 1, 1, 1, 1, 1, 1 )
			end
		end
	end
	self.Tooltip:Show()
end


function Hekili:CreateButton( display, ID )
	
	local name = "Hekili_D" .. display .. "_B" .. ID
	local disp = self.DB.profile.displays[display]
	
	local button = self.UI.Buttons[ display ][ ID ] or CreateFrame( "Button", name, self.UI.Engine )
	
	local btnSize
	if ID == 1 then
		btnSize = disp['Primary Icon Size']
	else
		btnSize = disp['Queued Icon Size']
	end
	local btnDirection	= disp['Queue Direction']
	local btnSpacing	= disp['Spacing']
	
	button:SetFrameStrata( "LOW" )
	button:SetFrameLevel( 100 - display )
	button:SetParent(UIParent)
	button:EnableMouse( not self.DB.profile.Locked )
	button:SetMovable( not self.DB.profile.Locked )
	button:SetClampedToScreen( true )
	
	button:SetSize( btnSize, btnSize )
	
	if not button.Texture then
		button.Texture = button:CreateTexture(nil, "LOW")
		button.Texture:SetAllPoints(button)
		button.Texture:SetTexture('Interface\\ICONS\\Spell_Nature_BloodLust')
		button.Texture:SetAlpha(1)
	end
	
	if display == 1 and ID == 1 then
		button.Notification = button.Notification or button:CreateFontString("HekiliNotification", "OVERLAY")
		button.Notification:SetSize( disp['Primary Icon Size'] * 2 + disp["Spacing"], disp['Primary Icon Size'] )
		button.Notification:ClearAllPoints()
		button.Notification:SetPoint( btnDirection, name, invert_direction[ btnDirection ], 0, 0 )
		button.Notification:SetJustifyV( "CENTER" )
		button.Notification:SetTextColor(1, 0, 0, 0)
		button.Notification:SetTextHeight( disp['Primary Icon Size'] / 3 )
        button.Notification:SetFont( Hekili.LSM:Fetch("font", disp.Font), disp['Primary Icon Size'] / 2.5, "OUTLINE" )		
	end
	
	button.Caption = button.Caption or button:CreateFontString(name.."Caption", "OVERLAY" )
	button.Caption:SetSize( button:GetWidth(), button:GetHeight() / 2)
	button.Caption:SetPoint( "BOTTOM", button, "BOTTOM" )
	button.Caption:SetJustifyV( "BOTTOM" )
	button.Caption:SetTextColor(1, 1, 1, 1)
	
	button.Cooldown = button.Cooldown or CreateFrame("Cooldown", name .. "_Cooldown", button, "CooldownFrameTemplate")
	button.Cooldown:SetAllPoints(button)
	
	button:ClearAllPoints()
	
	if ID == 1 then
		button.Overlay = button.Overlay or button:CreateTexture(nil, "LOW")
		button.Overlay:SetAllPoints(button)
		button.Overlay:Hide()
		
		button.Caption:SetFont( Hekili.LSM:Fetch("font", disp.Font), disp['Primary Font Size'], "OUTLINE" )

		button:SetPoint( self.DB.profile.displays[ display ].rel or "CENTER", self.DB.profile.displays[ display ].x, self.DB.profile.displays[ display ].y )
		
		button:SetScript( "OnMouseDown", function(self, btn)
			if ( Hekili.Config or not Hekili.DB.profile.Locked ) and btn == "LeftButton" and not self.Moving then
				self:StartMoving()
				self.Moving = true
			end
		end )
		
		button:SetScript( "OnMouseUp", function(self, btn)
			if ( btn == "LeftButton" and self.Moving ) then
				self:StopMovingOrSizing()
				Hekili:SaveCoordinates()
				self.Moving = false
			elseif ( btn == "RightButton" and not Hekili.Config and not Hekili.Pause ) then
				x_offset, y_offset = self:GetCenter()
				self:StopMovingOrSizing()
				self.Moving = false
				Hekili.DB.profile.Locked = true
				self:SetMovable( not Hekili.DB.profile.Locked )
				self:EnableMouse( not Hekili.DB.profile.Locked )
				-- Hekili:SetOption( { "locked" }, true )
				GameTooltip:Hide()
			end
			Hekili:SaveCoordinates()
		end )
	
	else
		button.Caption:SetFont( Hekili.LSM:Fetch("font", disp.Font), disp['Queued Font Size'], "OUTLINE" )

		if btnDirection == 'RIGHT' then
			button:SetPoint( invert_direction[ btnDirection ], 'Hekili_D' .. display.. "_B" .. ID - 1,  btnDirection, btnSpacing, 0 )
		elseif btnDirection == 'LEFT' then
			button:SetPoint( invert_direction[ btnDirection ], 'Hekili_D' .. display.. "_B" .. ID - 1,  btnDirection, -1 *  btnSpacing, 0 )
		elseif btnDirection == 'TOP' then
			button:SetPoint( invert_direction[ btnDirection ], 'Hekili_D' .. display.. "_B" .. ID - 1,  btnDirection, 0, btnSpacing )
		else -- BOTTOM
			button:SetPoint( invert_direction[ btnDirection ], 'Hekili_D' .. display.. "_B" .. ID - 1,  btnDirection, 0, -1 * btnSpacing )
		end

	end
	
	button:SetScript( "OnEnter", function(self)
		if ( ID == 1 and ( not Hekili.Pause ) and ( Hekili.Config or not Hekili.DB.profile.Locked ) ) then
			Hekili.Tooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
			Hekili.Tooltip:SetBackdropColor( 0, 0, 0, 1 )
			Hekili.Tooltip:SetText(Hekili.DB.profile.displays[ display ].Name .. " (" .. display .. ")")
			Hekili.Tooltip:AddLine("Left-click and hold to move.", 1, 1, 1)
			if not Hekili.Config or not Hekili.DB.profile.Locked then Hekili.Tooltip:AddLine("Right-click to lock all and close.",1 ,1 ,1)  end
			Hekili.Tooltip:Show()
			self:SetMovable(true)
		elseif ( Hekili.Pause and Hekili.Queue[ display ] and Hekili.Queue[ display ][ ID ] ) then
			Hekili:ShowDiagnosticTooltip( Hekili.Queue[ display ][ ID ] )
		else
			self:SetMovable(false)
			self:EnableMouse(false)
		end
	end )
	
	button:SetScript( "OnLeave", function(self)
		Hekili.Tooltip:Hide()
	end )
	
	return button

end


function Hekili:SaveCoordinates()
	for k,_ in pairs(Hekili.UI.Buttons) do
		local _, _, rel, x, y = Hekili.UI.Buttons[k][1]:GetPoint()
		
		self.DB.profile.displays[k].rel = rel
		self.DB.profile.displays[k].x = x
		self.DB.profile.displays[k].y = y
	end
end