-- Handle all the option settings

local FL = LibStub("LibFishing-1.0");

-- 5.0.4 has a problem with a global "_" (see some for loops below)
local _

local FBOptionsTable = {};

local function FindOptionInfo (setting)
	for _,info in pairs(FBOptionsTable) do
		if ( info.options[setting] ) then
			return info;
		end
	end
	-- return nil;
end

local function GetDefault(setting)
	local info = FindOptionInfo(setting);
	if ( info ) then
		local opt = info.options[setting];
		if ( opt ) then
			if ( opt.check and opt.checkfail ) then
				if ( not opt.check() ) then
					return opt.checkfail;
				end
			end
			return opt.default;
		end
	end
	-- return nil;
end
FishingBuddy.GetDefault = GetDefault;

local function GetSetting(setting)
	local val = nil;
	if ( setting ) then
		local info = FindOptionInfo(setting);
		if ( info ) then
			if ( info.getter) then
				val = info.getter(setting);
				if ( val == nil ) then
					val = GetDefault(setting);
				end
			elseif ( info.global ) then
				val = FishingBuddy.GlobalGetSetting(setting);
			else
				val = FishingBuddy.BaseGetSetting(setting);
			end
		end
	end
	return val;
end
FishingBuddy.GetSetting = GetSetting;

local function GetSettingBool(setting)
	local val = GetSetting(setting);
	return val ~= nil and (val == true or val == 1);
end
FishingBuddy.GetSettingBool = GetSettingBool;

local function SetSetting(setting, value)
	if ( setting ) then
		local info = FindOptionInfo(setting);
		if ( info) then
			if ( info.setter ) then
				local val = GetDefault(setting);
				if ( val == value ) then
					info.setter(setting, nil);
				else
					info.setter(setting, value);
				end
			elseif ( info.global ) then
				FishingBuddy.GlobalSetSetting(setting, value);
			else
				FishingBuddy.BaseSetSetting(setting, value);
			end
		end
	end
end
FishingBuddy.SetSetting = SetSetting;

local function GetSettingOption(setting)
	local val = nil;
	if ( setting ) then
		local info = FindOptionInfo(setting);
		if (info) then
			return info.options[setting];
		end
	end
	-- return nil;
end
FishingBuddy.GetSettingOption = GetSettingOption;

-- tooltip support for disabled buttons
local function Handle_OnEnter(self)
	if(self.tooltipText ~= nil) then
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 48, 0);
		FL:AddTooltip(self.tooltipText);
		GameTooltip:Show();
	end
end

local function Handle_OnLeave(self)
	if(self.tooltipText ~= nil) then
		GameTooltip:Hide();
	end
end

-- display all the option settings
FishingBuddy.OptionsFrame = {};

local function ParentValue(button)
	local value = true;
	if ( button.parents ) then
		for _,b in pairs(button.parents) do
			if ( b.checkbox and not b:GetChecked() ) then
				value = false;
			end
		end
	end
	return value;
end

local function ParentEnabled(button)
	if ( button.parents ) then
		for _,b in pairs(button.parents) do
			if ( not b:IsEnabled() ) then
				return false;
			end
		end
	end
	return true;
end

-- we only set value if we need to force a behavior
local function CheckBox_Able(button, value)
	if ( not button ) then
		return;
	end
	if ( value == nil ) then
		value = ParentValue(button);
	end
	local color;
	if ( value ) then
		if (button.checkbox) then
			button:Enable();
		end
		color = NORMAL_FONT_COLOR;
		if (button.overlay) then
			button.overlay:Hide();
		end
	else
		if ( button.checkbox ) then
			button:Disable();
		end
		if (button.overlay) then
			button.overlay:ClearAllPoints();
			button.overlay:SetPoint("TOPLEFT", button.label, "TOPLEFT");
			button.overlay:SetSize(button:GetWidth(), button:GetHeight());
			button.overlay:SetFrameLevel(button:GetFrameLevel()+2);
			button.overlay:Show();
		end
		color = GRAY_FONT_COLOR;
	end
	local text = _G[button:GetName().."Text"];
	if ( text ) then
		text:SetTextColor(color.r, color.g, color.b);
	end
end

local function hideOrDisable(button, what)
	local enabled = ParentEnabled(button);
	local value = false;
	
	if ( enabled ) then
		if ( type(what) == "function" ) then
			what, value = what();
		else
			value =	ParentValue(button);
		end
	else
		what = "d";
	end
	-- "i" means ignore, but since we check explicitly...
	if ( what == "d" ) then
		CheckBox_Able(button, value);
	elseif ( what == "h" ) then
		 button:Hide();
		 if ( value  ) then
			if ( not button.visible or button.visible(button) ) then
				button:Show();
			end
		end
	end
end

local function CheckButton_HandleDeps(parent)
	if ( parent.deps ) then
		local value = (not parent.checkbox or parent:GetChecked());
		for dep,what in pairs(parent.deps) do
			hideOrDisable(dep, what);
			CheckButton_HandleDeps(dep);
		end
	end
end

local function CheckButton_OnShow(button)
	button:SetChecked(GetSettingBool(button.name));
end

local function CheckButton_OnClick(button, quiet)
	if ( not button ) then
		return;
	end
	local value = true;
	if ( button.checkbox) then
		if ( not button:GetChecked() ) then
			value = false;
		end
		if ( not quiet ) then
			if ( value ) then
				PlaySound("igMainMenuOptionCheckBoxOn");
			else
				PlaySound("igMainMenuOptionCheckBoxOff");
			end
		end
	end
	SetSetting(button.name, value);
	FishingBuddy.OptionsUpdate();
	if ( button.update ) then
		button.update(button);
	end
	CheckButton_HandleDeps(button);
end

local function Slider_OnLoad(self, info, height, width)
	self.info = info;
	self.textfield = _G[info.name.."Text"];
	_G[info.name.."High"]:SetText();
	_G[info.name.."Low"]:SetText();
	self:SetMinMaxValues(info.min, info.max);
	self:SetValueStep(info.step or 1);
	self:SetHeight(height or 17);
	self:SetWidth(width or 130);
end

local function Slider_OnShow(self)
	local where = FishingBuddy.GetSetting(self.info.setting);
	if (where) then
		self:SetValue(where);
		self.textfield:SetText(string.format(self.info.format, where));
	end
end

local function Slider_OnValueChanged(self)
	local where = self:GetValue();
	self.textfield:SetText(string.format(self.info.format, where));
	FishingBuddy.SetSetting(self.info.setting, where);
	if (self.info.action) then
		self.info.action(self);
	end
end

-- info contains
-- name
-- format -- how to print the value
-- min
-- max
-- step -- default to 1
-- rightextra -- extra room needed, if any
-- setting -- what this slider changes
local function Slider_Create(info)
	local s = _G[info.name];
	if (not s) then
		s = CreateFrame("Slider", info.name, nil, "OptionsSliderTemplate");
	end
	Slider_OnLoad(s, info);
	s:SetScript("OnShow", Slider_OnShow);
	s:SetScript("OnValueChanged", Slider_OnValueChanged);
	return s;
end
FishingBuddy.Slider_Create = Slider_Create;

local overlaybuttons = {};
local optionbuttons = {};
local optionmap = {};

local function processdeps(button, deps)
	for n,what in pairs(deps) do
		local b = optionmap[n];
		if ( b ) then
			if ( not b.deps ) then
				b.deps = {};
			end
			b.deps[button] = what;
			if ( not button.parents ) then
				button.parents = {};
			end
			tinsert(button.parents, b);
		end
	end
end

local function orderbuttons(btnlist)
	if not btnlist then
		return {};
	end
	
	table.sort(btnlist, function(a,b)
		if ( a.custom ) then
			return false;
		else
			return a.width and b.width and a.width < b.width;
		end
	end);
	
	local order = {};
	local used = {};
	for idx=1,#btnlist do
		local b = btnlist[idx];
		if ( b.alone ) then
			tinsert(order, idx);
			used[b.name] = true;
		end
	end
	
	for idx=1,#btnlist do
		local b = btnlist[idx];
		if (b.deps and not used[b.name] ) then
			local group = {};
			local last = {};
			used[b.name] = true;
			tinsert(order, idx);
			for d,_ in pairs(b.deps) do
				for jdx=1,#btnlist do
					if ( not used[d.name] and btnlist[jdx].name == d.name) then
						used[d.name] = true;
						if (d.custom) then
							tinsert(last, jdx);
						else
							tinsert(group, jdx);
						end
					end
				end
			end
			-- here we should arrange order so that as many pairs as possible are
			-- an appropriate width. For now make all the odd ones the shortest ones.
			for jdx=1,#group do
				local kdx = #group-jdx+1;
				if (kdx > jdx) then
					tinsert(order, group[jdx]);
					tinsert(order, group[kdx]);
				elseif (kdx == jdx) then
					tinsert(order, group[jdx]);
				end
			end
			for jdx=1,#last do
				tinsert(order, last[jdx]);
			end
		end
	end
	local last = {};
	local group = {};
	for idx=1,#btnlist do
		local b = btnlist[idx];
		if ( not used[b.name] ) then
			if (b.custom) then
				tinsert(last, idx);
			else
				tinsert(group, idx);
			end
		end
	end

	for jdx=1,#group do
		local kdx = #group-jdx+1;
		if (kdx > jdx) then
			tinsert(order, group[jdx]);
			tinsert(order, group[kdx]);
		elseif (kdx == jdx) then
			tinsert(order, group[jdx]);
		end
	end
	for jdx=1,#last do
		tinsert(order, last[jdx]);
	end

	return order;
end

local RIGHT_OFFSET = 16;
local BUTTON_SEP = 8;
local function layoutorder(btnlist, maxwidth)
	if not btnlist then
		return {};
	end

	local order = orderbuttons(btnlist);
	local layout = {};
	local used = {};

	local idx = 1;
	while (idx <= #order ) do
		if ( not used[idx] ) then
			local left = order[idx];
			local leftbut = btnlist[left];
			local rightbut = nil;
			if ( not leftbut.alone ) then
				local tw = RIGHT_OFFSET + BUTTON_SEP + leftbut.width;
				for jdx=#order,idx+1,-1 do
					if ( not rightbut and not used[jdx] ) then
						local tr = order[jdx];
						local tb = btnlist[tr];
						if ((tb.width + tw) <= maxwidth) then
							used[jdx] = true;
							rightbut = tb;
						end
					end
				end
			end
			
			tinsert(layout, { leftbut, rightbut } );
		end
		idx = idx + 1;
	end
	
	return layout;
end

local function FirstPosition(button, xoffset, yoffset)
	xoffset = xoffset or 4;
	yoffset = yoffset or -4;
	button:SetPoint("TOPLEFT", FishingBuddyFrameInset, "TOPLEFT", xoffset, yoffset);
end

local SQUISH_OFF = 6;
local function dolayout(layout, lastbutton, firstoff)
	for idx,line in ipairs(layout) do
		local lb, rb = line[1], line[2];
		local yoff = nil;
		if ( lb.margin ) then
			firstoff = firstoff or 0;
			yoff = -(lb.margin[2] or SQUISH_OFF);
			firstoff = firstoff + lb.margin[1] or 0;
		end
		if ( not lastbutton ) then
			FirstPosition(lb, firstoff, yoff);
		else
			yoff = SQUISH_OFF;
			lb:SetPoint("TOPLEFT", lastbutton, "BOTTOMLEFT", firstoff, yoff);
			firstoff = 0;
		end
		lastbutton = lb;
		if ( rb ) then
			rb.right = 1;
			rb.adjacent = lastbutton;
			if ( rb.margin ) then
				yoff = yoff + (rb.margin[2] or 0);
			end
			rb:SetPoint("TOP", lb, "TOP");
			if ( rb.checkbox ) then
				rb:SetPoint("RIGHT", FishingBuddyFrameInset, "RIGHT", -rb.width, 0);
				rb:SetHitRectInsets(0, -rb.width, 0, 0);
			else
				rb:SetPoint("RIGHT", FishingBuddyFrameInset, "RIGHT", -rb.slider, 0);
			end
		end
	end
	
	return lastbutton;
end

local function CleanupButton(button)
	button.name = nil;
	button.alone = nil;
	button.width = 0;
	button.slider = 0;
	button.update = nil;
	button.enabled = nil;
	button.text = "";
	button.tooltipText = nil;
	button.disabledTooltipText = nil;
	button.primary = nil;
	button.deps = nil;
	button.right = nil;
	button.layoutright = nil;
	button.margin = nil;
	button.visible = nil;
	button.adjacent = nil;
	button.parents = nil;
	if (button.overlay) then
		button.overlay:Hide();
		button.overlay = nil;
	end
	CheckBox_Able(button, 0);
	button:ClearAllPoints();
	if (button.checkbox) then
		button:SetHitRectInsets(0, -100, 0, 0);
		button:SetScript("OnShow", nil);
		button:SetScript("OnClick", nil);
		button.checkbox = nil;
	end
	button.custom = nil;
	button.option = nil;
	button:Hide();
	button:SetParent(nil);
end

local insidewidth = 0;
local function Setup(options, nomap)
	insidewidth = FishingBuddyFrameInset:GetWidth();

-- Clear out all the stuff we put on the old buttons
	for name,button in pairs(optionmap) do
		CleanupButton(button);
	end
	optionmap = {};
	
	local overlayidx = 1;
	local index = 1;
	for name,option in pairs(options) do
		local button = nil;
		if ( option.button ) then
			if ( type(option.button) == "string" ) then
				button = _G[option.button];
			else
				button = option.button;
			end
			if ( button ) then
				button.custom = true;
				button.checkbox = (button:GetObjectType() == "CheckButton");
			end
		elseif ( option.v ) then
			button = optionbuttons[index];
			if ( not button ) then
				button = CreateFrame(
					"CheckButton", "FishingBuddyOption"..index,
					FishingOptionsFrame, "OptionsSmallCheckButtonTemplate");
				optionbuttons[index] = button;
			end
			button.checkbox = true;
			index = index + 1;
		end
		if ( button and (not option.visible or option.visible(button)) ) then
			if ( not nomap ) then
				optionmap[name] = button;
				button:ClearAllPoints();
				button:SetParent(FishingOptionsFrame);
				button:SetFrameLevel(FishingOptionsFrame:GetFrameLevel() + 2);
			end

			if ( button.checkbox and option.v ) then
				-- override OnShow and OnClick
				button:SetScript("OnShow", CheckButton_OnShow);
				button:SetScript("OnClick", CheckButton_OnClick);
			end

			if (option.init) then
				option.init(option, button);
			end
			
			button.option = option;
			button.name = name;
			button.alone = option.alone;
			button.layoutright = option.layoutright;
			button.margin = option.margin;
			button.name = name;
			button.update = option.update;
			button.visible = option.visible;
			button.enabled = option.enabled;
			button.width = button:GetWidth();
			if ( option.text ) then
				button.text = option.text;
				local text = _G[button:GetName().."Text"];
				if (text) then
					text:SetText(option.text);
					button.width = button.width + text:GetWidth();
				end
			else
				button.text = "";
			end

			button.tooltipText = option.tooltip;
			
			if ( button.checkbox ) then
				button:SetChecked(GetSettingBool(name));
				button:SetHitRectInsets(0, -button.width, 0, 0);
			end
			-- hack for sliders (why?)
			if (button:GetObjectType() == "Slider") then
				button.slider = 16;
			else
				button.slider = 0;
			end

			if ( option.tooltipd ) then
				local tooltip = option.tooltipd;
				if ( type(tooltip) == "function" ) then
					tooltip = tooltip(option);
				end
				
				if ( tooltip ) then
					local overlay = overlaybuttons[overlayidx];
					if ( not overlay ) then
						overlay = CreateFrame("Button");
						overlay:Hide();
						overlaybuttons[overlayidx] = overlay;
						overlay:SetParent(FishingOptionsFrame);
						overlay:SetScript("OnEnter", Handle_OnEnter);
						overlay:SetScript("OnLeave", Handle_OnLeave);
					end
					overlay:SetSize(button.width or button:GetWidth(), button:GetHeight());
					overlay:SetPoint("LEFT", button, "LEFT");
					overlay.tooltipText = tooltip;
					button.overlay = overlay;
					overlayidx = overlayidx + 1;
				end
			end

			if ( option.setup ) then
				option.setup(button);
			end
		end
	end
	
	local toplevel = {};
	for name,option in pairs(options) do
		local button = optionmap[name];
		if ( button ) then
			if ( option.deps ) then
				button.primary = option.primary;
				processdeps(button, option.deps);
			else
				tinsert(toplevel, name);
			end
		end
	end

	-- move the primaries with no dependents to the top, and stack them next to other
	-- then put everything else underneath. need to make the dep button layout code
	-- useful for the toplevel non-dep buttons then
	local pb = {};
	local maxwidth = 0;
	for _,name in pairs(toplevel) do
		local button = optionmap[name];
		if ( button and not button.deps and not button.custom ) then
			tinsert(pb, button);
		end
	end

	local layout = layoutorder(pb, insidewidth);	
	local lastbutton = dolayout(layout);
	
	local primaries = {};
	for _,name in pairs(toplevel) do
		local button = optionmap[name];
		if ( button and button.deps ) then
			tinsert(primaries, name);
		end
	end
	for _,name in pairs(toplevel) do
		local button = optionmap[name];
		if ( button and button.custom ) then
			tinsert(primaries, name);
		end
	end

	local lastoff = 0;
	for _,name in pairs(primaries) do
		local button = optionmap[name];
		if ( not lastbutton ) then
			local yoff, firstoff;
			if ( button.margin ) then
				yoff = -(button.margin[2] or SQUISH_OFF);
				firstoff = button.margin[1] or 0;
			end
			FirstPosition(button, firstoff, yoff);
		else
			local yoff = SQUISH_OFF;
			if ( button.margin ) then
				yoff = yoff - button.margin[2];
			end
			if ( lastbutton.margin ) then
				yoff = yoff - lastbutton.margin[2];
			end
			button:SetPoint("TOPLEFT", lastbutton, "BOTTOMLEFT", lastoff, yoff);
		end
		lastbutton = button;
		lastoff = 0;
		if ( button.deps ) then
			local deps = {};
			for b,n in pairs(button.deps) do
				if ( optionmap[b.name] and (not b.primary or b.primary == name) and b.name ~= button.layoutright) then
					tinsert(deps, b);
				end
			end
			layout = layoutorder(deps, insidewidth - RIGHT_OFFSET);
			lastbutton = dolayout(layout, lastbutton, RIGHT_OFFSET);
			lastoff = -RIGHT_OFFSET;
		end
		if ( button.layoutright ) then
			 local toright = optionmap[button.layoutright];
			 if (toright) then
				 toright:ClearAllPoints();
				 toright:SetPoint("CENTER", button, "CENTER", 0, 0);
				 toright:SetPoint("RIGHT", FishingBuddyFrameInset, "RIGHT", -32, 0);
			 end
		end
	end
end

-- handle option panel tabs
local tabbuttons = {};
local tabmap = {};

local function showallbuttons()
	-- now that we've collected all of the dependencies, handle them
	for name,button in pairs(optionmap) do
		local button = optionmap[name];
		if ( button ) then
			local showit = true;
			if ( button.visible ) then
				showit = button.visible(button);
			end
			if ( showit ) then
				button:Show();
			else
				button:Hide();
			end
		end
	end
	for name,button in pairs(optionmap) do
		if ( not button.parents ) then
			local value = true;
			if (button.enabled) then
				value = button.enabled(button);
			end
			CheckBox_Able(button, value);
			CheckButton_HandleDeps(button);
		end
	end
end

local function OptionTab_OnClick(self, button)
	local name = self.name;
	if ( FishingOptionsFrame.selected ~= name ) then
		local lasttab = tabmap[FishingOptionsFrame.selected];
		if ( lasttab ) then
			lasttab:SetChecked(false);
			FishingBuddy.OptionsUpdate();
		end
		FishingOptionsFrame.selected = name;
		Setup(FBOptionsTable[name].options);
		showallbuttons();
	end
	tabmap[name]:SetChecked(true);
end

local function PositionTab(tab, prevtab)
	tab:ClearAllPoints();
	if ( prevtab ) then
		tab:SetPoint("TOPLEFT", prevtab, "BOTTOMLEFT", 0, -17);
	else
		tab:SetPoint("TOPLEFT", FishingBuddyFrameInset, "TOPRIGHT", 6, -3);
	end
	tab:Show();
end

local function UpdateTabs()
	local prevtab = nil;
	local lasttab = nil;
	for index,tab in ipairs(tabbuttons) do
		local name = tab.name;
		local handler = FBOptionsTable[name];
		if ( handler.first and handler.visible ) then
			PositionTab(tab);
			prevtab = tab;
		end
		if ( handler.last and handler.visible ) then
			lasttab = tab;
		end
	end
	for index,tab in ipairs(tabbuttons) do
		local name = tab.name;
		local handler = FBOptionsTable[name];
		if ( handler.visible ) then
			if ( not handler.first and not handler.last ) then
				PositionTab(tab, prevtab);
				prevtab = tab;
			 end
		else
			tab:Hide();
		end
	end
	if ( lasttab ) then
		PositionTab(lasttab, prevtab);
	end
end

local INV_MISC_QUESTIONMARK = "Interface\\Icons\\INV_Misc_QuestionMark";
local GENERAL_ICON = "Interface\\Icons\\INV_Misc_QuestionMark";
local function HandleOptions(name, icon, options, setter, getter, last)
	local index = #tabbuttons + 1;
	local handler = {};
	local maketab = (name ~= nil);
	if ( not name ) then
		name = "FBHIDDEN";
		handler.index = 0;
		-- handle option buttons that show up outside of option frames
		Setup(options, 1);
	end
	if ( name == GENERAL ) then
		handler.first = true;
		handler.icon = "Interface\\Icons\\inv_gauntlets_18";
	else
		handler.icon = icon or INV_MISC_QUESTIONMARK;
	end
	handler.last = last;
	handler.name = name;
	handler.options = FL:copytable(options);
	handler.setter = setter;
	handler.getter = getter;
	handler.visible = maketab;
	if ( FBOptionsTable[name] ) then
		for name,info in pairs(FBOptionsTable[name].options) do
			handler.options[name] = FL:copytable(info);
		end
		handler.icon = FBOptionsTable[name].icon;
		handler.index = FBOptionsTable[name].index;
		handler.getter = handler.getter or FBOptionsTable[name].getter;
		handler.setter = handler.setter or FBOptionsTable[name].setter;
	end
	FBOptionsTable[name] = handler;

	-- just handle the setting and getting if no name supplied
	if ( maketab ) then
		local optiontab = tabmap[name];
		if ( not optiontab ) then
			optiontab = CreateFrame(
						"CheckButton", "FishingBuddyOptionTab"..index,
						FishingOptionsFrame, "SpellBookSkillLineTabTemplate");
			optiontab:SetScript("OnClick", OptionTab_OnClick);
			optiontab.name = name;
			optiontab.tooltip = name;
			tinsert(tabbuttons, optiontab);
			tabmap[name] = optiontab;
			handler.index = index;
		end
		optiontab:SetNormalTexture(handler.icon);

		-- if we show this one, then check to see if it has
		-- any options for the drop down menu
		for name,option in pairs(handler.options) do
			if ( option.m ) then
				handler.hasdd = true;
			end
		end	
	end
end
FishingBuddy.OptionsFrame.HandleOptions = HandleOptions;

local function HideOptionsTab(name)
	if ( FBOptionsTable[name] and FBOptionsTable[name].visible ) then
		FBOptionsTable[name].visible = nil;
		UpdateTabs();
	end
end
FishingBuddy.HideOptionsTab = HideOptionsTab;

local function ShowOptionsTab(name)
	if ( FBOptionsTable[name] and not FBOptionsTable[name].visible ) then
		FBOptionsTable[name].visible = true;
		UpdateTabs();
	end
end
FishingBuddy.ShowOptionsTab = ShowOptionsTab;

local function OptionsFrame_OnShow(self)
	UpdateTabs();
	showallbuttons();
	local selected = FishingOptionsFrame.selected;
	local first = nil;
	for name,handler in pairs(FBOptionsTable) do
		if ( handler.visible ) then
			if ( not first or handler.first ) then
				first = name;
			end
		else
			if ( selected == name ) then
				selected = nil;
			end
		end
	end
	if ( not selected and first ) then
		selected = first;
	end
	for name,tab in pairs(tabmap) do
		if ( selected == name ) then
			if ( not tab:GetChecked() ) then
				OptionTab_OnClick(tab);
			end
		else
			tab:SetChecked(false);
		end
	end
	FishingOptionsFrame.selected = selected;
end

local function OptionsFrame_OnHide(self)
	for _,tab in pairs(tabmap) do
		tab:Hide();
	end
	FishingBuddy.OptionsUpdate(nil, true);
end

-- Drop-down menu support
local function ToggleSetting(setting)
	local value = GetSetting(setting);
	if ( not value ) then
		value = false;
	end
	SetSetting(setting, not value);
	FishingBuddy.OptionsUpdate(true);
end
FishingBuddy.ToggleSetting = ToggleSetting;

-- save some memory by keeping one copy of each one
local ToggleFunctions = {};
-- let's use closures
local function MakeToggle(name, callme)
	if ( not ToggleFunctions[name] ) then
		local n = name;
		local c = callme;
		ToggleFunctions[name] = function() ToggleSetting(n); if (c) then c() end; end;
	end
	return ToggleFunctions[name];
end
FishingBuddy.MakeToggle = MakeToggle;

local function MakeClickToSwitchEntry(switchText, switchSetting, level, keepShowing, callMe)
	local entry = {};
	entry.text = switchText;
	entry.func = MakeToggle(switchSetting, callMe);
	entry.checked = FishingBuddy.GetSettingBool(switchSetting);
	entry.keepShownOnClick = keepShowing;
	UIDropDownMenu_AddButton(entry, level);
end

local function MakeDropDownSep(level)
	local entry = {};
	entry.disabled = true;
	UIDropDownMenu_AddButton(entry, level);
end

local function MakeDropDownEntry(name, option, level)
	local addthis = true;
	if ( option.check ) then
		addthis = option.check();
	end
	if ( addthis ) then
		local entry = {};
		entry.text = option.text;
		entry.func = MakeToggle(name);
		entry.checked = FishingBuddy.GetSettingBool(name);
		entry.keepShownOnClick = true;
		UIDropDownMenu_AddButton(entry, level);
	end
end

local function MakeDropDownInitialize(self, level)
	if ( level == 1) then
		local entry = {};
		if ( self.title ) then
			entry.isTitle = 1;
        	entry.text = self.title;
        	entry.notCheckable = 1;
        	UIDropDownMenu_AddButton(entry, level);
        end
		
		-- If no outfit frame, we can't switch outfits...
		if ( FishingBuddy.OutfitManager.HasManager() ) then
			MakeClickToSwitchEntry(self.switchText, self.switchSetting, level, 1);
			MakeDropDownSep(level);
		end

		wipe(entry);
		for tabname,handler in pairs(FBOptionsTable) do
			if (handler.hasdd) then
				entry.text = tabname;
				entry.func = self.UncheckHack;
				entry.hasArrow = 1
				entry.value = handler.options;
				UIDropDownMenu_AddButton(entry, level);
			end
		end
	elseif (level == 2 and type(UIDROPDOWNMENU_MENU_VALUE) == "table") then
		for name,option in pairs(UIDROPDOWNMENU_MENU_VALUE) do
			if ( option.m1 ) then
				MakeDropDownEntry(name, option, level);
			end
		end
		for name,option in pairs(UIDROPDOWNMENU_MENU_VALUE) do
			if ( option.m ) then
				MakeDropDownEntry(name, option, level);
			end
		end
	end
end
FishingBuddy.DropDownInitFunc = MakeDropDownInitialize;

local FB_DropDownMenu = CreateFrame("Frame", "FB_DropDownMenu");
local function UncheckHack(dropdownbutton)
    _G[dropdownbutton:GetName().."Check"]:Hide()
end

FishingBuddy.GetDropDown = function(switchText, switchSetting, title, frame)
	if (not frame) then
		frame = FB_DropDownMenu;
		frame.displayMode = "MENU"
	end
	
	frame.title = title or FBConstants.NAME;
	frame.switchText = switchText;
	frame.switchSetting = switchSetting;
	frame.initialize = MakeDropDownInitialize;
	frame.UncheckHack = UncheckHack;
	
	return frame;
end

-- Old style drop down handling, which will add taint
-- Everything happens at level 1
FishingBuddy.MakeDropDown = function(switchText, switchSetting)
	-- If no outfit frame, we can't switch outfits...
	if ( FishingBuddy.OutfitManager.HasManager() ) then
		MakeClickToSwitchEntry(switchText, switchSetting, 1, 1);
		MakeDropDownSep(1);
	end

	for _,info in pairs(FBOptionsTable) do
		for name,option in pairs(info.options) do
			if ( option.p ) then
				MakeDropDownEntry(name, option);
			end
		end
	end
end

-- menuname has to be set regardless, or UI drop down doesn't work
FishingBuddy.CreateFBDropDownMenu = function(holdername, menuname)
	local holder = CreateFrame("Frame", holdername);
	if (not menuname) then
		menuname = holdername.."Menu"
	end
	holder.menu = CreateFrame("Frame", menuname, holder, "FishingBuddyDropDownMenuTemplate");
	holder.menu:ClearAllPoints();
	holder.menu:SetPoint("TOPRIGHT", holder, "TOPRIGHT", 0, 0);
	holder.html = CreateFrame("SimpleHTML", nil, holder);
	holder.html:ClearAllPoints();
	holder.html:SetPoint("TOPLEFT", holder, "TOPLEFT", 0, -4);
	holder.html:SetSize(210, 16);
	holder.fontstring = holder.html:CreateFontString(nil, nil, "GameFontNormalSmall");
	holder.fontstring:SetAllPoints(holder.html);
	holder.fontstring:SetSize(183, 0);
	
	function holder:FixSizes()
		self:SetWidth(self.menu:GetWidth() + self.menu.label:GetWidth() + 4);
		self:SetHeight(self.menu:GetHeight());
	end
	
	function holder:SetLabel(text)
		if (text) then
			self.menu.label:Show();
			self.menu.label:SetText(text);
		else
			self.menu.label:SetText("");
			self.menu.label:Hide();
		end
		self:FixSizes();
	end
	
	return holder;
end

-- handle menu with a mapping table for settings to displayed values
local function SetMappedValue(self, what, value)
	local show = self.Mapping[value];
	FishingBuddy.SetSetting(what, value);
	UIDropDownMenu_SetSelectedValue(self, show);
	UIDropDownMenu_SetText(self, show);
end

local function LoadMappedMenu(keymenu)
	local menu = keymenu.menu;
	local menuwidth = 0;
	local setting = FishingBuddy.GetSetting(keymenu.Setting);
	for value,label in pairs(menu.Mapping) do
		local info = {};
		local v = value;
		local w = keymenu.Setting;
		local m = menu;
		info.text = label;
		info.func = function() SetMappedValue(m, w, v); end;
		if ( setting == value ) then
			info.checked = true;
		else
			info.checked = false;
		end
		UIDropDownMenu_AddButton(info);
		menu.label:SetText(label);
		local width = menu.label:GetWidth();
		if (width > menuwidth) then
			menuwidth = width;
		end
	end
	UIDropDownMenu_SetWidth(menu, menuwidth + 32);
	keymenu:SetLabel(keymenu.Label);
end

local function InitMappedMenu(option, button)
	UIDropDownMenu_Initialize(button.menu, function()
									  LoadMappedMenu(button);
								  end);
end

FishingBuddy.CreateFBMappedDropDown = function(holdername, setting, label, mapping, menuname)
	local keymenu = FishingBuddy.CreateFBDropDownMenu(holdername, menuname);
	keymenu.html:Hide();	
	keymenu.menu.label:SetText(label);
	keymenu.Label = label;
	keymenu.Setting = setting;
	keymenu.Build = BuildMappedMenu
	keymenu.menu.Mapping = mapping;
	keymenu.menu.SetMappedValue = SetMappedValue;
	keymenu.InitMappedMenu = InitMappedMenu;
	return keymenu;
end

FishingBuddy.GetOptionList = function()
	local options = {};
	for _,info in pairs(FBOptionsTable) do
		for name,option in pairs(info.options) do
			options[name] = option;
		end
	end
	return options;
end

-- Helper function
FishingBuddy.FitInOptionFrame = function(width)
	local check = insidewidth;
	-- Default to something that should be close in case we haven't
	-- seen the window yet
	if (check == 0) then
		check = 327;
	end
	return width < (check - RIGHT_OFFSET - BUTTON_SEP);
end

-- Create the options frame, unmanaged -- we get managed specially later
local f = FishingBuddyFrame:CreateManagedFrame("FishingOptionsFrame");
f:SetScript("OnShow", OptionsFrame_OnShow);
f:SetScript("OnHide", OptionsFrame_OnHide);

if ( FishingBuddy.Debugging ) then
	FishingBuddy.FBOptionsTable = FBOptionsTable;
end
