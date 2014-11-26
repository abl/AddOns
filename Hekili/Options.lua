-- Options.lua
-- Everything related to building/configuring options.

local H = Hekili
local GetClassID = H.Utils.GetClassID
local GetSpecializationID = H.Utils.GetSpecializationID
local tblCopy = H.Utils.tblCopy

local strformat, strmatch = string.format, string.match

-- Default Table
function Hekili:GetDefaults()
	local defaults = {
		profile = {
			Version			= 2,
			Release			= 11,
			Enabled			= true,
			Locked			= false,
			Debug			= false,
			
			Hardcasts		= true,
			
			['Audit Targets']		= 5,
			['Updates Per Second']	= 10,

			displays		= {
			},
			actionLists = {
			}
		}
	}
	
	return defaults
end	


-- DISPLAYS
-- Add a display to the profile (to be stored in SavedVariables).
function Hekili:NewDisplay( name )

	if not name then
		return nil
	end
	
	for i,v in ipairs(self.DB.profile.displays) do
		if v.Name == name then
			self:Error('NewDisplay() - tried to use an existing display name.')
			return nil
		end
	end

	local index = #self.DB.profile.displays + 1
	
	if not Hekili[ 'ProcessDisplay'..index ] then
		Hekili[ 'ProcessDisplay'..index ] = function()
			Hekili:ProcessHooks( index )
		end
	end
	
	self.DB.profile.displays[ index ] = {
		Name				= name,
		Release				= self.DB.profile.Version + ( self.DB.profile.Release / 100 ),

		Enabled				= true,
		['PvE Visibility']	= 'always',
		['PvP Visibility']	= 'always',
		Script				= '',
		
		-- Talent Group: Primary, Secondary, Both
		['Talent Group']		= 0,
		['Specialization']		= GetSpecializationID(),
		['Icons Shown']			= 5,
		['Maximum Time']		= 30,
		['Queue Direction']		= 'RIGHT',
		
		-- Captions
		['Action Captions']			= true,
		-- Primary Caption: Default, # Targets, Buff ________ Stacks, Debuff ________ Count, Debuff ________ Count / # Targets
		['Primary Caption']			= 'default',
		['Primary Caption Aura']	= '',
		
		-- Visual Elements
		Font					= 'Arial Narrow',
		['Primary Icon Size']	= 50,
		['Primary Font Size']	= 12,
		['Queued Icon Size']	= 40,
		['Queued Font Size']	= 12,
		Spacing					= 5,
		
		Queues					= {}
	}

	return ( 'D' .. index ), index
	
end


-- Add a display to the options UI.
function Hekili:NewDisplayOption( key )

	if not key or not self.DB.profile.displays[ key ] then
		return nil
	end

	local dispOption = {
		type		= "group",
		name		= self.DB.profile.displays[key].Name,
		order		= key,
		args		= {
			Enabled = {
				type	= 'toggle',
				name	= 'Enabled',
				desc	= 'Enable this display (hides the display and ignores its hooked action list(s) if unchecked).',
				order	= 1,
			},
			['Name'] = {
				type	= 'input',
				name	= 'Name',
				desc	= 'Rename this display.  Names beginning with @ are reserved for default displays.',
				order	= 2,
				validate = function(info, val)
					local key = tonumber( info[2]:match("^D(%d+)") )
					for i, display in pairs( self.DB.profile.displays) do
						if i ~= key and display.Name == val then
							return "That display name is already in use."
						elseif i ~= key and val:sub(1, 1) == "@" then
							return "The @ character is reserved for Hekili default action lists."
						end
						return true
					end
				end,
				width	= 'full',
			},
			['Talent Group'] = {
				type	= 'select',
				name	= 'Talent Group',
				desc	= 'Choose the talent group(s) for this display.',
				order	= 3,
				values	= {
					[0] = 'Both',
					[1] = 'Primary',
					[2] = 'Secondary'
				},
				width	= "double"
			},		
			['PvE Visibility'] = {
				type	= 'select',
				name	= 'PvE Visibility',
				desc	= 'Set the visibility for this display in PvE zones.',
				order	= 4,
				values	= {
					always	= 'Show Always',
					combat	= 'Show in Combat',
					target	= 'Show with Target',
					zzz		= 'Never'
				},
			},
			['Specialization'] = {
				type	= 'select',
				name	= 'Specialization',
				desc	= 'Choose the talent specialization(s) for this display.',
				order	= 5,
				values	= function(info)
					local class = select(2, UnitClass("player"))
					if not class then return nil end
					
					local num = GetNumSpecializations()
					local list = {}
					
					for i = 1, num do
						local specID, name = GetSpecializationInfoForClassID( GetClassID(class), i )
						list[specID] = '|T' .. select( 4, GetSpecializationInfoByID( specID ) ) .. ':0|t ' .. name
					end
					
					list[ 0 ] = '|TInterface\\Addons\\Hekili\\Textures\\' .. class .. '.blp:0|t Any'
					return list
				end,
				width	= 'double',
			},
			['PvP Visibility'] = {
				type	= 'select',
				name	= 'PvP Visibility',
				desc	= 'Set the visibility for this display in PvP zones.',
				order	= 6,
				values	= {
					always	= 'Show Always',
					combat	= 'Show in Combat',
					target	= 'Show with Target',
					zzz		= 'Never'
				},
			},
			Script = {
				type	= 'input',
				name	= 'Conditions',
				desc	= 'Enter the conditions (Lua or SimC-like syntax) for this display to be visible.',
				dialogControl = "HekiliCustomEditor",
				arg	= function(info)
					local dispKey = info[2]
					local dispIdx = tonumber( dispKey:match("^D(%d+)" ) )
					local results = {}
					
					Hekili:ResetState()
					Hekili.State.this_action = 'wait'
					Hekili:StoreValues( results, self.Scripts.D[ dispIdx ] )
					return results
				end,
				multiline = 6,
				order	= 7,
				usage	= 'See http://www.curse.com/addons/wow/hekili for a reference list of game state options.',
				width	= 'full'
			},
			BLANK = {
				type	= "description",
				name	= " ",
				width	= "full",
				order	= 20
			},
			['Add Hook'] = {
				type	= "execute",
				name	= "Add Hook",
				desc	= "Adds a new hook for an action list.  You can specific which action list to use, and under which conditions to use the list.",
				order	= 21,
				func	= function (info)
					local dispKey, display = info[2], tonumber( info[2]:match("^D(%d+)") )
				
					local clear, suffix, name, result = 0, 1, "New Hook", "New Hook"
					while clear < #self.DB.profile.displays[ display ].Queues do
						for i, queue in ipairs( self.DB.profile.displays[ display ].Queues ) do
							if queue.Name == result then
								result = name .. ' (' .. suffix .. ')'
								suffix = suffix + 1
							else
								clear = clear + 1
							end
						end
					end
			
					local key, index = self:NewHook( display, result )
					if key then
						self.Options.args.displays.args[ dispKey ].args[ key ] = self:NewHookOption( display, index )
						self:RefreshOptions()
					end
					self:CacheDurableDisplayCriteria()
					self:LoadScripts()
				end
			},
			Reload = {
				type		= "execute",
				name		= "Reload Display",
				desc		= function( info, ... ) 
					local dispKey, dispID = info[2], tonumber( string.match( info[2], "^D(%d+)" ) )
					local display = self.DB.profile.displays[ dispID ]
					
					local _, defaultID = self:IsDefault( display.Name, 'displays' )

					local output = "Reloads this display from the default options available. Style settings are left untouched, but hooks and criteria are reset."
					
					if self.Defaults[ defaultID ].version > ( display.Release or 0 ) then
						output = output .. "\n|cFF00FF00The default display is newer (" .. self.Defaults[ defaultID ].version .. ") than your existing display (" .. ( display.Release or "2.00" ) .. ").|r"
					end
					
					return output
				end,
				confirm		= true,
				confirmText	= "Reload the default settings for this default display?",
				order		= 22,
				hidden		= function( info, ... )
					local dispKey, dispID = info[2], tonumber( strmatch( info[2], "^D(%d+)" ) )
					local display = self.DB.profile.displays[ dispID ]
					
					if self:IsDefault( display.Name, 'displays' ) then
						return false
					end
					
					return true
				end,
				func		= function( info, ... )
					local dispKey, dispID = info[2], tonumber( strmatch( info[2], "^D(%d+)" ) )
					local display = self.DB.profile.displays[ dispID ]
					
					local _, defaultID = self:IsDefault( display.Name, 'displays' )
					
					local import = self:DeserializeDisplay( self.Defaults[ defaultID ].import )
		
					if not import then
						Hekili:Print("Unable to import " .. self.Defaults[ defaultID ].name .. ".")
						return
					end
		
					local settings_to_keep = { "Primary Icon Size", "Queued Font Size", "Primary Font Size", "Primary Caption Aura", "rel", "Spacing", "Queue Direction", "Queued Icon Size", "Font", "x", "y", "Icons Shown", "Action Captions", "Primary Caption", "Primary Caption Aura" }
					
					for _, k in pairs( settings_to_keep ) do
						import[ k ] = display[ k ]
					end
					
					self.DB.profile.displays[ dispID ] = import
					self.DB.profile.displays[ dispID ].Release = self.Defaults[ defaultID ].version
					self:RefreshOptions()
					self:LoadScripts()
					self:BuildUI()
				end,
			},
			BLANK2 = {
				type	= "description",
				name	= " ",
				order	= 22,
				hidden	= function( info, ... )
					local dispKey, dispID = info[2], tonumber( strmatch( info[2], "^D(%d+)" ) )
					local display = self.DB.profile.displays[ dispID ]
					
					if self:IsDefault( display.Name, 'displays' ) then
						return true
					end
					
					return false
				end,
				width	= "single",
			},
			Delete = {
				type		= "execute",
				name		= "Delete Display",
				desc		= "Deletes this display and all associated action list hooks and criteria.  The action lists will remain untouched.",
				confirm		= true,
				confirmText	= "Permanently delete this display and all associated action list hooks?",
				order		= 23,
				func		=	function(info, ...)
					if not info[2] then return end
					
					-- Key to Current Display (string)
					local dispKey = info[2]
					local dispIdx = tonumber( strmatch( info[2], "^D(%d+)" ) )

					for i, queue in ipairs( self.DB.profile.displays[dispIdx].Queues ) do
						for k,v in pairs( queue ) do
							queue[k] = nil
						end
						table.remove( self.DB.profile.displays[dispIdx].Queues, i)
					end
					
					-- Will need to be more elaborate later.
					table.remove( self.DB.profile.displays, dispIdx )
					table.remove( self.Queue, dispIdx )
					Hekili:RefreshOptions()
					self:LoadScripts()
					self:BuildUI()
					self.ACD:SelectGroup("Hekili", 'displays' )
				end
			},
			['UI and Style'] = {
				type	= 'group',
				name	= 'UI and Style',
				order	= 9,
				args	= {
					x = {
						type	= 'input',
						name	= "Position (X)",
						desc	= "Enter the horizontal position of this display's primary icon relative to the center of your screen.  Negative numbers move the icon left, positive numbers move the icon right.",
						order	= 2,
					},
					y = {
						type	= 'input',
						name	= "Position (Y)",
						desc	= "Enter the vertical position of this display's primary icon relative to the center of your screen.  Negative numbers move the icon up, positive numbers move the icon down.",
						order	= 3,
					},
					iconHeader = {
						type	= 'header',
						name	= 'Icons and Layout',
						order	= 8,
					},
					['Icons Shown'] = {
						type	= 'range',
						name	= 'Icons Shown',
						desc	= "Select the number of icons to display.  This also determines the number of actions the addon will try to predict.",
						min	= 1,
						max	= 10,
						order	= 10,
						step	= 1,
					},
					Spacing = {
						type	= 'range',
						name	= 'Icon Spacing',
						desc	= "Select the number of pixels to skip between icons in this display.",
						min	= -10,
						max	= 50,
						order	= 11,
						step	= 1,
					},
					['Queue Direction'] = {
						type	= 'select',
						name	= 'Queue Direction',
						order	= 12,
						values	= {
							TOP		= 'Up',
							BOTTOM	= 'Down',
							LEFT	= 'Left',
							RIGHT	= 'Right'
						},
					},
					['Primary Icon Size'] = {
						type	= 'range',
						name	= 'Primary Icon Size',
						desc	= "Select the size of the primary icon.",
						min	= 10,
						max	= 100,
						order	= 21,
						step	= 1,
					},
					['Queued Icon Size'] = {
						type	= 'range',
						name	= 'Queued Icon Size',
						desc	= "Select the size of the queued icons.",
						min	= 10,
						max	= 100,
						order	= 22,
						step	= 1,
					},
					fontHeader = {
						type	= 'header',
						name	= 'Style',
						order	= 30,
					},
					Font = {
						type	= 'select',
						name	= 'Font',
						desc	= "Select the font to use on all icons in this display.",
						dialogControl = 'LSM30_Font',
						order	= 31,
						values	= Hekili.LSM:HashTable("font"), -- pull in your font list from LSM
					},
					['Primary Font Size'] = {
						type	= 'range',
						name	= 'Primary Font Size',
						desc	= "Enter the size of the font for primary icon captions.",
						min	= 6,
						max	= 30,
						order	= 32,
						step	= 1,
					},
					['Queued Font Size'] = {
						type	= 'range',
						name	= 'Queued Font Size',
						desc	= "Enter the size of the font for queued icon captions.",
						min	= 6,
						max	= 30,
						order	= 33,
						step	= 1,
					},
					captionHeader = {
						type	= 'header',
						name	= 'Captions',
						order	= 40,
					},
					-- Captions
					['Action Captions'] = {
						type	= 'toggle',
						name	= 'Action Captions',
						desc	= "Enable or disable action captions.  This allows you to display additional information about a particular action when shown.",
						order	= 51,
						width	= 'full'
					},
					['Primary Caption'] = {
						type	= 'select',
						name	= 'Primary Caption',
						desc	= "This allows you to override the caption on the primary icon under a variety of circumstances.",
						hidden	= function(info)
							local display = tonumber( strmatch( info[2], "^D(%d+)" ) )
							if not self.DB.profile.displays[ display ]['Action Captions'] then
								return true
							end
							return false
						end,
						order	= 52,
						values	= {
							default	= 'Use Default Captions',
							targets	= 'Show # of Targets',
							buff	= 'Buff Stacks',
							debuff	= 'Debuff Count',
							ratio	= 'Debuff Count / # Targets'
						}
					},
					-- Should probably use the autocomplete aura tool.
					['Primary Caption Aura'] = {
						type	= 'input',
						name	= 'Aura',
						desc	= "Enter the name of the aura to check for certain Primary Caption overrides.",
						hidden	= function(info)
							local display = tonumber( strmatch( info[2], "^D(%d+)" ) )
							if not self.DB.profile.displays[ display ]['Action Captions'] then
								return true
							end
							return false
						end,
						order	= 53,
					}
				}
			},
			['Import/Export'] = {
				type	= 'group',
				name	= 'Import/Export',
				order	= 10,
				args	= {	
					['Copy To'] = {
						type	= 'input',
						name	= 'Copy To',
						desc	= 'Enter a name for the new display.  All settings, including action list hooks, will be duplicated in the new display.',
						order	= 11,
						validate = function(info, val)
							if val == '' then return true end
							if strmatch(val, "@") then
								Hekili:Print("The @ character is reserved for default action lists.")
								return "The @ character is reserved for default action lists."
							else
								for k,v in ipairs(self.DB.profile.displays) do
									if val == v.Name then
										Hekili:Print("That name is already in use.")
										return "That name is already in use."
									end
								end
							end
							return true
						end,
						width	= 'full',
					},
					['Import'] = {
						type	= 'input',
						name	= 'Import Display',
						desc	= "Paste the export string from another display to copy its settings to this display.  All settings will be copied, except for the display name.",
						order	= 11,
						width	= 'full',
					},
					['Export'] = {
						type	= 'input',
						name	= 'Export Display',
						desc	= "Copy this export string and paste it into another display's Import field to copy all settings from this display to another existing display.",
						get		= function(info)
							local dispKey = info[2]
							local dispIdx = tonumber( dispKey:match("^D(%d+)") )
							
							return Hekili:SerializeDisplay( dispIdx )
						end,
						set		= function(...)
							return
						end,
						order	= 12,
						width	= 'full',
						multiline = 6,
						dialogControl = 'HekiliCustomEditor'
					},
				}
			},
		}
	}
	
	return dispOption
	
end


-- DISPLAYS > HOOKS
-- Add a hook to a display.
function Hekili:NewHook( display, name )

	if not name then
		return nil
	end
	
	if type(display) == string then
		display = tonumber( strmatch( display, "^D(%d+)") )
	end
	
	for i,v in ipairs( self.DB.profile.displays[display].Queues ) do
		if v.Name == name then
			self:Error('NewHook() - tried to use an existing display name.')
			return nil
		end
	end

	local index = #self.DB.profile.displays[display].Queues + 1
	
	self.DB.profile.displays[ display ].Queues[ index ] = {
		Name				= name,
		Release				= self.DB.profile.Version + ( self.DB.profile.Release / 100 ),
		Enabled				= false,
		['Action List']		= 0,
		Script				= '',
	}

	return ( 'P' .. index ), index
	
end


-- Add a hook to the options UI.
-- display	(number)	The index of the display to which this entry is attached.
-- key		(number)	The index for this particular hook.
function Hekili:NewHookOption( display, key )

	if not key or not self.DB.profile.displays[display].Queues[ key ] then
		return nil
	end

	local pqOption = {
		type		= "group",
		name		= '|cFFFFD100' .. key .. '.|r ' .. self.DB.profile.displays[ display ] .Queues[ key ].Name,
		order		= 50 + key,
		-- childGroups	= "tab",
		-- This number must be index + number of options in "Display Queues" section.
		-- order		= index + 2,
		args		= {

			Enabled = {
				type	= 'toggle',
				name	= 'Enabled',
				order	= 00,
				width	= 'double',
			},
			['Move'] = {
				type	= 'select',
				name	= 'Position',
				order	= 01,
				values	= function(info)
					local dispKey, hookKey = info[2], info[3]
					local dispIdx, hookID = tonumber( dispKey:match("^D(%d+)") ), tonumber( hookKey:match("^P(%d+)") )
					local list = {}
					for i = 1, #self.DB.profile.displays[ dispIdx ].Queues do
						list[i] = i
					end
					return list
				end
			},
			['Name'] = {
				type	= 'input',
				name	= 'Name',
				order	= 03,
				validate = function(info, val)
					local key = tonumber(info[2])
					for i, display in pairs( self.DB.profile.displays) do
						if i ~= key and display.Name == val then
							return "That display name is already in use."
						elseif i ~= key and val:match("@") then
							return "The @ character is reserved for Hekili default action lists."
						end
						return true
					end
				end,
				width	= 'double'
			},
			['Action List'] = {
				type	= 'select',
				name	= 'Action List',
				order	= 04,
				values	= function(info)
					local lists = {}
					
					lists[0] = 'None'
					for i, list in ipairs( self.DB.profile.actionLists ) do
						if list.Specialization > 0 then
							lists[i] = '|T' .. select(4, GetSpecializationInfoByID( list.Specialization ) ) .. ':0|t ' .. list.Name
						else
							lists[i] = '|TInterface\\Addons\\Hekili\\Textures\\' .. select(2, UnitClass('player')) .. '.blp:0|t ' .. list.Name
						end
					end

					return lists
				end,
			},
			Script = {
				type	= 'input',
				name	= 'Conditions',
				dialogControl = "HekiliCustomEditor",
				arg	= function(info)
					local dispKey, hookKey = info[2], info[3]
					local dispIdx, hookID = tonumber( dispKey:match("^D(%d+)" ) ), tonumber( hookKey:match("^P(%d+)") )
					local prio = self.DB.profile.displays[ dispIdx ].Queues[ hookID ]
					local results = {}
					
					self:ResetState()
					self.State.this_action = 'wait'
					self:StoreValues( results, self.Scripts.P[ dispIdx..':'..hookID ] )
					return results
				end,
				multiline = 6,
				order	= 12,
				width	= 'full'
			},
			Delete = {
				type		= "execute",
				name		= "Delete Hook",
				confirm		= true,
				-- confirmText	= '
				order		= 999,
				func		=	function(info, ...)
					-- Key to Current Display (string)
					local dispKey = info[2]
					local dispIdx = tonumber( strmatch( dispKey, "^D(%d+)" ) )
					local queueKey = info[3]
					local queueIdx = tonumber( strmatch( queueKey, "^P(%d+)" ) )

					-- Will need to be more elaborate later.
					table.remove( self.DB.profile.displays[dispIdx].Queues, queueIdx )
					self:RefreshOptions()
					self:LoadScripts()
				end
			},
		}
	}
	
	return pqOption
	
end


-- ACTION LISTS
-- Add an action list to the profile (to be stored in SavedVariables).
function Hekili:NewActionList( name )

	local index = #self.DB.profile.actionLists + 1
	
	if not name then
		name = "List #" .. index
	end

	self.DB.profile.actionLists[index] = {
		Enabled			= false,
		Name			= name,
		Release			= self.DB.profile.Version + ( self.DB.profile.Release / 100 ),
		Specialization	= GetSpecializationID() or 0,
		Script			= '',
		Actions			= {}
	}
	
	return ( 'L' .. index ), index
end


-- Add an action list to the options UI.
function Hekili:NewActionListOption( index )

	if not index or self.DB.profile.actionLists[ index ] == nil then
		return nil
	end

	local name	= self.DB.profile.actionLists[ index ].Name
	
	local listOption	= {
		type		= "group",
		name		= name,
		icon		= function(info)
			local list = tonumber( strmatch( info[#info], "^L(%d+)" ) )
			if self.DB.profile.actionLists[ list ].Specialization > 0 then
				return select( 4, GetSpecializationInfoByID( self.DB.profile.actionLists[ list ].Specialization ) )
			else return 'Interface\\Addons\\Hekili\\Textures\\' .. select(2, UnitClass('player')) .. '.blp' end
		end,
		order		= 10 + index,
		args		= {
			Enabled	= {
				type	= 'toggle',
				name	= 'Enabled',
				desc	= "Enable or disable this action list for processing in all displays.",
				order	= 1,
			},
			Name	= {
				type	= "input",
				name	= "Name",
				desc	= "Enter a unique name for this action list.  Names beginning with @ are reserved for default action lists.",
				validate = function(info, val)
					if val:sub(1, 1) == "@" then
						return "The @ character is reserved for default action lists."
					end
					return true
				end,
				order	= 2,
				width	= "full",
			},
			Specialization = {
				type	= 'select',
				name	= 'Specialization',
				desc	= "Select the class specialization for this action list.  If you select 'Any', the list will work in all specializations, though abilities unavailable to your specialization will not be recommended.",
				order	= 3,
				values	= function(info)
					local class = select(2, UnitClass("player"))
					if not class then return nil end
					
					local num = GetNumSpecializations()
					local list = {}
					
					list[0] = '|TInterface\\Addons\\Hekili\\Textures\\' .. select(2, UnitClass('player')) .. '.blp:0|t Any'
					for i = 1, num do
						local specID, name = GetSpecializationInfoForClassID( GetClassID(class), i )
						list[specID] = '|T' .. select( 4, GetSpecializationInfoByID( specID ) ) .. ':0|t ' .. name
					end
					return list
				end,
				width	= 'full'
			},
			['Import/Export'] = {
				type	= "group",
				name	= 'Import/Export',
				order	= 5,
				args	= {
					['Copy To'] = {
						type	= 'input',
						name	= 'Copy To',
						desc	= 'Enter a name for the new action list.  All settings, except for the list name, will be duplicated into the new list.',
						order	= 32,
						validate = function(info, val)
							if val == '' then return true end
							if val:sub(1, 1) == "@" then
								Hekili:Print("The @ character is reserved for default action lists.")
								return "The @ character is reserved for default action lists."
							else
								for k,v in ipairs(self.DB.profile.actionLists) do
									if val == v.Name then
										Hekili:Print("That name is already in use.")
										return "That name is already in use."
									end
								end
							end
							return true
						end,
						width	= 'full',
					},
					['Import Action List'] = {
						type	= 'input',
						name	= 'Import Action List',
						desc	= "Paste the export string from another action list to copy it here.  All settings, except for the list name, will be duplicated into this list.",
						order	= 33,
						width	= 'full',
					},
					['Export Action List'] = {
						type	= 'input',
						name	= 'Export Action List',
						desc	= "Copy this export string and paste it into another action list to overwrite the other action list.",
						get		= function(info)
							local listKey = info[2]
							local listIdx = tonumber( listKey:match("^L(%d+)") )
							
							return Hekili:SerializeActionList( listIdx )
						end,
						set		= function(...)
							return
						end,
						order	= 34,
						width	= 'full',
						multiline = 6,
						dialogControl = 'HekiliCustomEditor'
					},
					['SimulationCraft'] = {
						type	= 'input',
						name	= 'Import SimulationCraft List',
						desc	= "Copy a SimulationCraft action list and paste it here to import.  If any lines cannot be parsed, the action list will not be imported.",
						order	= 35,
						multiline = 6,
						dialogControl = 'HekiliCustomEditor',
						-- validate = 'ImportSimulationCraftActionList',
						width	= 'full',
						confirm = true,
					},
				}
			},
			spcHeader = {
				type	= 'description',
				name	= "\n",
				order	= 900,
				width	= 'full'
			},
			['Add Action'] = {
				type		= "execute",
				name		= "Add Action",
				desc		= "Adds a new action entry, where you can set the ability and conditions required for that ability to be shown.",
				order		= 901,
				func		= function( info )
					local listKey, listIdx = info[2], tonumber( info[2]:match("^L(%d+)") )

					local clear, suffix, name, result = 0, 1, "New Action", "New Action"
					while clear < #self.DB.profile.actionLists[ listIdx ].Actions do
						for i, action in ipairs( self.DB.profile.actionLists[ listIdx ].Actions ) do
							if action.Name == result then
								result = name .. ' (' .. suffix .. ')'
								suffix = suffix + 1
							else
								clear = clear + 1
							end
						end
					end
					
					local key, index = self:NewAction( listIdx, result )
					if key then
						self.Options.args.actionLists.args[ listKey ].args[ key ] = self:NewActionOption( listIdx, index )
						self:CacheDurableDisplayCriteria()
						self:LoadScripts()
					end
				end
			},
			Reload = {
				type		= "execute",
				name		= "Reload Action List",
				desc		= function( info, ... ) 
					local listKey, listID = info[2], tonumber( string.match( info[2], "^L(%d+)" ) )
					local list = self.DB.profile.actionLists[ listID ]
					
					local _, defaultID = self:IsDefault( list.Name, 'actionLists' )

					local output = "Reloads this action list from the default options available."
					
					if self.Defaults[ defaultID ].version > ( list.Release or 0 ) then
						output = output .. "\n|cFF00FF00The default action list is newer (" .. self.Defaults[ defaultID ].version .. ") than your existing action list (" .. ( list.Release or "2.00" ) .. ").|r"
					end
					
					return output
				end,
				confirm		= true,
				confirmText	= "Reload the default settings for this default action list?",
				order		= 902,
				hidden		= function( info, ... )
					local listKey, listID = info[2], tonumber( strmatch( info[2], "^L(%d+)" ) )
					local list = self.DB.profile.actionLists[ listID ]
					
					if self:IsDefault( list.Name, 'actionLists' ) then
						return false
					end
					
					return true
				end,
				func = function( info, ... )
					local listKey, listID = info[2], tonumber( strmatch( info[2], "^L(%d+)" ) )
					local list = self.DB.profile.actionLists[ listID ]
					
					local _, defaultID = self:IsDefault( list.Name, 'actionLists' )
					
					local import = self:DeserializeActionList( self.Defaults[ defaultID ].import )
					
					if not import then
						Hekili:Print("Unable to import " .. self.Defaults[ defaultID ].name .. ".")
						return
					end
					
					self.DB.profile.actionLists[ listID ] = import
					self.DB.profile.actionLists[ listID ].Release = self.Defaults[ defaultID ].version
					self:RefreshOptions()
					self:LoadScripts()
					-- self:BuildUI()
				end,
			},
			BLANK2 = {
				type	= "description",
				name	= " ",
				order	= 902,
				hidden	= function( info, ... )
					local listKey, listID = info[2], tonumber( strmatch( info[2], "^L(%d+)" ) )
					local list = self.DB.profile.actionLists[ listID ]
					
					if self:IsDefault( list.Name, 'actionLists' ) then
						return true
					end
					
					return false
				end,
				width	= "single",
			},
			Delete = {
				type		= "execute",
				name		= "Delete Action List",
				desc		= "Delete this action list, and all actions associated with this list.",
				confirm		= true,
				order		= 999,
				func		=	function(info, ...)
					local actKey = info[2]
					local actIdx = tonumber( strmatch( actKey, "^L(%d+)" ) )
					
					for d_key, display in ipairs( self.DB.profile.displays ) do
						for l_key, list in ipairs ( display.Queues ) do
							if list['Action List'] == actIdx then
								list['Action List'] = 0
								list.Enabled	= false
							elseif list['Action List'] > actIdx then
								list['Action List'] = list['Action List'] - 1
							end
						end
					end
					
					table.remove( self.DB.profile.actionLists, actIdx )
					self:LoadScripts()
					self:RefreshOptions()
					self.ACD:SelectGroup( "Hekili", "actionLists" )
					
				end
			}
		}
	}
	
	return listOption
	
end


-- ACTION LISTS > ACTIONS
-- Add an action to the action list.
function Hekili:NewAction( aList, name )

	if not name then
		return nil
	end
	
	if type(aList) == string then
		aList = tonumber( strmatch( aList, "^A(%d+)") )
	end
	
	local clear, suffix, name_arg = 0, 1, name
	while clear < #self.DB.profile.actionLists[aList].Actions do
		clear = 0
		for i, action in ipairs( self.DB.profile.actionLists[aList].Actions ) do
			if name == action.Name then
				name = name_arg .. ' (' .. suffix .. ')'
				suffix = suffix + 1
			else
				clear = clear + 1
			end
		end
	end

	local index = #self.DB.profile.actionLists[ aList ].Actions + 1
	
	self.DB.profile.actionLists[ aList ].Actions[ index ] = {
		Name				= name,
		Release				= self.DB.profile.Version + ( self.DB.profile.Release / 100 ),
		Enabled				= false,
		Ability				= nil,
		Caption				= nil,
		Arguments			= nil,
		Script				= '',
	}

	return ( 'A' .. index ), index
	
end


--- NewActionOption()
-- Add a new action to the action list options.
-- aList	(number)	index of the action list.
-- index	(number)	index of the action in the action list.
function Hekili:NewActionOption( aList, index )

	if not index or not self.DB.profile.actionLists[ aList ].Actions[ index ] then
		return nil
	end

	local actOption = {
		type		= "group",
		name		= '|cFFFFD100' .. index .. '.|r ' .. self.DB.profile.actionLists[ aList ].Actions[ index ].Name,
		order		= index * 10,
		-- childGroups	= "tab",
		-- This number must be index + number of options in "Display Queues" section.
		-- order		= index + 2,
		args		= {
			Enabled = {
				type	= 'toggle',
				name	= 'Enabled',
				desc	= "If disabled, this action will not be shown under any circumstances.",
				order	= 00,
				width	= 'double'
			},
			['Move'] = {
				type	= 'select',
				name	= 'Position',
				desc	= "Select another position in the action list and move this item to that location.",
				order	= 01,
				values	= function(info)
					local listKey, actKey = info[2], info[3]
					local listIdx, actIdx = tonumber( listKey:match("^L(%d+)") ), tonumber( actKey:match("^A(%d+)") )
					local list = {}
					for i = 1, #self.DB.profile.actionLists[ listIdx ].Actions do
						list[i] = i
					end
					return list
				end
			},
			['Name'] = {
				type	= 'input',
				name	= 'Name',
				desc	= "Enter a unique name for this action in the action list.  This is typically the ability name accompanied by a short description.",
				order	= 02,
				validate = function(info, val)
					local listIdx = tonumber( strmatch( info[2], "^L(%d+)" ) )
					
					for i, action in pairs( self.DB.profile.actionLists[ aList ].Actions) do
						if action.Name == val then
							return "That action name is already in use."
						elseif val:match("@") then
							return "The @ character is reserved for addon defaults."
						end
						return true
					end
				end,
			},
			Ability = {
				type	= 'select',
				name	= 'Ability',
				desc	= "Select the ability for this action entry.  Only abilities supported by the addon's prediction engine will be shown.",
				order	= 03,
				values	= function(info)
					local list = {}
					for k,v in pairs( H.Abilities ) do
						if type(k) == 'string' then
							list[ k ] = '|T' .. ( GetSpellTexture( v.id ) or 'Interface\\ICONS\\Spell_Nature_BloodLust' ) .. ':O|t ' .. v.name
						end
					end
					list[ 'wait' ] = '|TInterface\\Icons\\INV_Misc_Head_ClockworkGnome_01:0|t |cFFFFD100Wait|r'
					return list
				end
			},
			Caption = {
				type	= 'input',
				name	= 'Caption',
				desc	= "Enter a caption to be displayed on this action's icon when the action is shown.",
				order	= 04,
			},
			Script = {
				type	= 'input',
				name	= 'Conditions',
				dialogControl = "HekiliCustomEditor",
				arg	= function(info)
					local listKey, actKey = info[2], info[3]
					local listIdx, actIdx = tonumber( listKey:match("^L(%d+)" ) ), tonumber( actKey:match("^A(%d+)" ) )
					local results = {}
					
					Hekili:ResetState()
					Hekili.State.this_action = self.DB.profile.actionLists[ listIdx ].Actions[ actIdx ].Ability
					Hekili:StoreValues( results, self.Scripts.A[ listIdx..':'..actIdx ] )
					
					return results
				end,
				multiline = 6,
				order	= 10,
				width	= 'full'
			},
			Args = { -- should rename at some point.
				type	= 'input',
				name	= 'Modifiers',
				order	= 11,
				width	= 'full'
			},
			deleteHeader = {
				type		= 'header',
				name		= 'Delete',
				order		= 998,
			},
			Delete = {
				type		= "execute",
				name		= "Delete Action",
				confirm		= true,
				-- confirmText	= '
				order		= 999,
				func		=	function(info, ...)
					-- Key to Current Display (string)
					local listKey = info[2]
					local listIdx = tonumber( strmatch( listKey, "^L(%d+)" ) )
					local actKey = info[3]
					local actIdx = tonumber( strmatch( actKey, "^A(%d+)" ) )

					-- Will need to be more elaborate later.
					self.ACD:SelectGroup("Hekili", 'actionLists', listKey )
					table.remove( self.DB.profile.actionLists[ listIdx ].Actions, actIdx )
					self.Options.args.actionLists.args[listKey].args[ actKey ] = nil
					self:LoadScripts()
					self:RefreshOptions()
				end
			},
		}
	}
	
	return actOption
	
end



function Hekili:GetOptions()
	local Options = {
		name		= "Hekili",
		type		= "group",
		handler		= Hekili,
		get			= 'GetOption',
		set			= 'SetOption',
		childGroups	= "tree",
		args		= {
			general = {
				type		= "group",
				name		= "General Settings",
				order		= 1,
				args		= {
					headerWarn = {
						type	= 'description',
						name	=	"Welcome to Hekili v2 for Warlords of Draenor.  This addon's default settings will give you similar behavior to the original version. " ..
									"The major changes for v2 include in-game editing for more options: more displays, customize action lists in-game, and so forth. " .. 
									'Please report bugs to hekili.tcn@gmail.com / @Hekili808 on Twitter / Hekili on MMO-C.\n',
						order	= 0,
					},
					Enabled	= {
						type	= "toggle",
						name	= "Enabled",
						desc	= "Enables or disables the addon.",
						order	= 1
					},
					Locked	= {
						type	= "toggle",
						name	= "Locked",
						desc	= "Locks or unlocks all displays for movement, except when the options window is open.",
						order	= 2
					},
					Debug	= {
						type	= "toggle",
						name	= "Debug",
						desc	= "If checked, the addon will collect additional information that you can view by pausing the addon and placing your mouse over your displayed abilities.",
						order	= 3
					},
					['Counter'] = {
						type = "group",
						name = "Target Count",
						inline = true,
						order = 4,
						args = {
							['Delay Description'] = {
								type	= 'description',
								name	= "This addon includes a mechanism for counting targets with whom you are actively engaged.  Any target that you damage, or is damaged by your pets/totems/guardians, is included in this target count.  Targets are removed when they are killed or if you do not damage them within the following 'Grace Period'.",
								order	= 0
							},
							['Audit Targets'] = {
								type	= 'range',
								name	= "Grace Period",
								min	= 3,
								max	= 10,
								step	= 1,
								width	= 'full',
								order	= 1
							}						
						}
					},
					['Engine'] = {
						type = "group",
						name = "Engine Settings",
						inline = true,
						order = 5,
						args = {
							['Engine Description'] = {
								type	= 'description',
								name	= "Set the frequency with which you want the addon to update your priority displays.  More frequent updates require more processor time (and can impact your frame rate); less frequent updates use less CPU, but may cause the display to be sluggish or to respond slowly to game events.  The default setting is 10 updates per second.",
								order	= 0
							},
							['Updates Per Second'] = {
								type	= 'range',
								name	= "Updates Per Second",
								min	= 4,
								max	= 20,
								step	= 1,
								width	= 'full',
								order	= 1
							}						
						}
					}
				}
			},
			displays = {
				type		= "group",
				name		= "Displays",
				childGroups	= "tree",
				cmdHidden	= true,
				order		= 2,
				args		= {
					header	= {
						type		= "description",
						name		= "A display is a group of 1 to 10 icons.  Each display can multiple hooks for action lists, with customized criteria and actions for display.",
						order		= 0
					},
					['New Display'] = {
						type		= "input",
						name		= "New Display",
						desc		= 'Enter a new display name.  Default options will be used.',
						width		= 'full',
						validate	= function(info, val)
										if val == '' then return true end
										if strmatch(val, "@") then
											Hekili:Print("The @ character is reserved for default action lists.")
											return "The @ character is reserved for default action lists."
										else
											for k,v in pairs(self.DB.profile.displays) do
												if val == v.name then
													Hekili:Print("That name is already in use.")
													return "That name is already in use."
												end
											end
										end
										return true
									end,
						order		= 1
					},
					['Import Display'] = {
						type		= "input",
						name		= "Import Display",
						desc		= "Paste a display's export string to import it here.",
						width		= 'full',
						order		= 2,
						multiline	= 6,
					},
					footer = {
						type		= "description",
						name		= "   ",
						order		= 3
					},
					Reload = {
						type		= "execute",
						name		= "Reload Missing",
						desc		= "Reloads all missing default displays.",
						confirm		= true,
						confirmText	= "Restore any deleted default displays?",
						order		= 4,
						func		= function( info, ... )
							local exists = {}
							
							for i, display in ipairs( self.DB.profile.displays ) do
								exists[ display.Name ] = true
							end

							for i, default in ipairs( self.Defaults ) do
								if not exists[ default.name ] and default.type == 'displays' then
									local import = self:DeserializeDisplay( default.import )
									local index = #self.DB.profile.displays + 1
									
									if import then
										self.DB.profile.displays[ index ] = import
										self.DB.profile.displays[ index ].Release = default.version
										
										if not Hekili[ 'ProcessDisplay' .. index ] then
											Hekili[ 'ProcessDisplay' .. index ] = function()
												Hekili:ProcessHooks( index )
											end
											C_Timer.After( 2 / self.DB.profile['Updates Per Second'], Hekili[ 'ProcessDisplay' .. index ] )
										end
									else
										Hekili:Print("Unable to import " .. default.name .. ".")
									end
								end
							end
							
							self:RefreshOptions()
							self:LoadScripts()
							self:BuildUI()
						end,
					},
					ReloadAll = {
						type		= "execute",
						name		= "Reload All",
						desc		= "Reloads all default displays.",
						confirm		= true,
						confirmText	= "Restore all default displays?",
						order		= 5,
						func		= function( info, ... )
							local exists = {}
							
							for i, display in ipairs( self.DB.profile.displays ) do
								exists[ display.Name ] = i
							end

							for i, default in ipairs( self.Defaults ) do
								if default.type == 'displays' then
									local import = self:DeserializeDisplay( default.import )
									local index = exists[ default.name ] or #self.DB.profile.displays + 1
									
									if import then
										if exists[ default.name ] then
											local settings_to_keep = { "Primary Icon Size", "Queued Font Size", "Primary Font Size", "Primary Caption Aura", "rel", "Spacing", "Queue Direction", "Queued Icon Size", "Font", "x", "y", "Icons Shown", "Action Captions", "Primary Caption", "Primary Caption Aura" }
											
											for _, k in pairs( settings_to_keep ) do
												import[ k ] = self.DB.profile.displays[ index ][ k ]
											end
										end
									
										self.DB.profile.displays[ index ] = import
										self.DB.profile.displays[ index ].Release = default.version
										
										if not Hekili[ 'ProcessDisplay' .. index ] then
											Hekili[ 'ProcessDisplay' .. index ] = function()
												Hekili:ProcessHooks( index )
											end
											C_Timer.After( 2 / self.DB.profile['Updates Per Second'], Hekili[ 'ProcessDisplay' .. index ] )
										end
									else
										Hekili:Print("Unable to import " .. default.name .. ".")
									end
								end
							end
							
							self:RefreshOptions()
							self:LoadScripts()
							self:BuildUI()
						end,
					},
				}
			},
			actionLists = {
				type		= "group",
				name		= "Action Lists",
				childGroups	= "tree",
				cmdHidden	= true,
				order		= 3,
				args		= {
					header	= {
						type		= "description",
						name		= "Each action list is a selection of several abilities and the conditions for using them.",
						order		= 10
					},
					['New Action List'] = {
						type		= "input",
						name		= "New Action List",
						desc		= "Enter a name for this action list and press ENTER.",
						width		= "full",
						validate = function(info, val)
										if val == '' then return true
										elseif strmatch(val, "@") then
											Hekili:Print("The @ character is reserved for default action lists.")
											return "The @ character is reserved for default action lists."
										end
										
										for k,v in pairs(self.DB.profile.actionLists) do
											if val == v.Name then
												Hekili:Print("That name is already in use.")
												return "That name is already in use."
											end
										end
										
										return true
									end,
						order		= 20
					},
					['Import Action List'] = {
						type		= "input",
						name		= "Import Action List",
						desc		= "Paste an action list's export string to import it here.",
						width		= 'full',
						order		= 30,
						multiline	= 6,
					},
					footer = {
						type		= "description",
						name		= "   ",
						order		= 35
					},
					Reload = {
						type		= "execute",
						name		= "Reload Missing",
						desc		= "Reloads all missing default action lists.",
						confirm		= true,
						confirmText	= "Restore any deleted default action lists?",
						order		= 40,
						func		= function( info, ... )
							local exists = {}
							
							for i, list in ipairs( self.DB.profile.actionLists ) do
								exists[ list.Name ] = true
							end

							for i, default in ipairs( self.Defaults ) do
								if not exists[ default.name ] and default.type == 'actionLists' then
									local import = self:DeserializeActionList( default.import )
									local index = #self.DB.profile.actionLists + 1
									
									if import then
										self.DB.profile.actionLists[ index ] = import
										self.DB.profile.actionLists[ index ].Release = default.version
									else
										Hekili:Print("Unable to import " .. default.name .. ".")
										return
									end
								end
							end
							
							self:RefreshOptions()
							self:LoadScripts()
						end,
					},
					ReloadAll = {
						type		= "execute",
						name		= "Reload All",
						desc		= "Reloads all default action lists.",
						confirm		= true,
						confirmText	= "Restore all default action lists?",
						order		= 41,
						func		= function( info, ... )
							local exists = {}
							
							for i, list in ipairs( self.DB.profile.actionLists ) do
								exists[ list.Name ] = i
							end

							for i, default in ipairs( self.Defaults ) do
								if default.type == 'actionLists' then
									local index = exists[ default.name ] or #self.DB.profile.actionLists+1

									local import = self:DeserializeActionList( default.import )
									
									if import then
										self.DB.profile.actionLists[ index ] = import
										self.DB.profile.actionLists[ index ].Release = default.version
									else
										Hekili:Print("Unable to import " .. default.name .. ".")
										return
									end
								end
							end
							
							self:RefreshOptions()
							self:LoadScripts()
						end,
					},
				}
			},
			bindings = {
				type	= 'group',
				name	= 'Filters and Keybinds',
				order	= 4,
				childGroups = 'tab',
				args	= {
					default = {
						type	= 'group',
						name	= 'Default Filters',
						order	= 0,
						args	= {
							HEKILI_TOGGLE_PAUSE = {
								type	= 'keybinding',
								name	= 'Pause',
								desc	= "Set a key to pause processing of your action lists.  Your current display(s) will freeze, and you can mouseover each icon to see information about the displayed action.",
								order	= 10,
							},
							Pause = {
								type	= 'toggle',
								name	= 'Pause',
								order	= 11,
								width	= 'double',
							},
							HEKILI_TOGGLE_MODE = {
								type	= 'keybinding',
								name	= 'Mode Switch',
								desc	= "Using this key will cycle between single target, cleave, and AOE priorities if your displays and action lists are configured to take advantage of this feature.  " ..
											"If set to |cFFFFD100single|r, this indicates that you intend to ignore any secondary targets and focus exclusively on your primary target.  If set to |cFFFFD100cleave|r, " ..
											"this indicates you would like to weave in multi-target or AOE abilities when appropriate.  If set to |cFFFFD100aoe|r, this indicates that you are focusing on the most " ..
											"damage output against all detected targets.",
								order	= 20,
							},
							Mode = {
								type	= 'toggle',
								name	= function()
									local output = "Mode:  Single Target - Cleave - AOE"
									if self.DB.profile.Mode == nil then
										output = output:gsub("Single Target", "|cFF00FF00Single Target|r")
									elseif self.DB.profile.Mode == true then
										output = output:gsub("Cleave", "|cFF00FF00Cleave|r")
									elseif self.DB.profile.Mode == false then
										output = output:gsub("AOE", "|cFF00FF00AOE|r")
									end
									return output
								end,

								order	= 21,
								width	= 'double',
							},
							HEKILI_TOGGLE_COOLDOWNS = {
								type	= 'keybinding',
								name	= 'Cooldowns',
								desc	= 'Set a key for toggling cooldowns on and off.  This option is used by testing the criterion |cFFFFD100toggle.cooldowns|r in your condition scripts.',
								order	= 30
							},
							Cooldowns = {
								type	= 'toggle',
								name	= 'Show Cooldowns',
								order	= 31,
								width	= 'double'
							},
							HEKILI_TOGGLE_HARDCASTS = {
								type	= 'keybinding',
								name	= 'Hardcasts',
								desc	= 'Set a key for toggling hardcasts on and off.  Hardcast detection is handled by the addon and does not need to be included in your condition scripts.',
								order	= 40
							},
							Hardcasts = {
								type	= 'toggle',
								name	= 'Show Hardcasts',
								order	= 41,
								width	= 'double'
							},
							HEKILI_TOGGLE_INTERRUPTS = {
								type	= 'keybinding',
								name	= 'Interrupts',
								desc	= 'Set a key for toggling interrupts on and off.  This option is used by testing the criterion |cFFFFD100toggle.interrupts|r in your condition scripts.',
								order	= 50
							},
							Interrupts = {
								type	= 'toggle',
								name	= 'Show Interrupts',
								order	= 51,
								width	= 'double'
							},
						}
					},
					custom = {
						type	= 'group',
						name	= 'Custom Filters',
						order	= 10,
						args	= {
							HEKILI_TOGGLE_1 = {
								type	= 'keybinding',
								name	= 'Toggle 1',
								order	= 10
							},
							['Toggle 1 Name'] = {
								type	= 'input',
								name	= 'Alias',
								desc	= 'Set a unique alias for this custom toggle.  You can check to see if this toggle is active by testing the criterion |cFFFFD100toggle.one|r or |cFFFFD100toggle.<alias>|r.  Aliases must be all lowercase, with no spaces.',
								order	= 12,
								validate	= function(info, val)
									if val == '' then
										return true
									elseif val == 'cooldowns' or val == 'hardcasts' or val == 'mode' or val == 'interrupts' then
										Hekili:Print("'" .. val .. "' is a reserved toggle name.")
										return "'" .. val .. "' is a reserved toggle name."
									end

									if strmatch(val, "[^a-z]") then
										Hekili:Print("Toggle names must be all lowercase alphabet characters.")
										return "Toggle names must be all lowercase alphabet characters."

									else
										local this = tonumber( info[#info]:match('Toggle (%d) Name') )

										for i = 1, 5 do
											if i ~= this and val == self.DB.profile['Toggle ' .. i .. ' Name'] then
												Hekili:Print("That name is already in use.")
												return "That name is already in use."
											end
										end
										
									end

									return true
								end,
								width	= 'double'
							},
							HEKILI_TOGGLE_2 = {
								type	= 'keybinding',
								name	= 'Toggle 2',
								order	= 20
							},
							['Toggle 2 Name'] = {
								type	= 'input',
								name	= 'Alias',
								desc	= 'Set a unique alias for this custom toggle.  You can check to see if this toggle is active by testing the criterion |cFFFFD100toggle.two|r or |cFFFFD100toggle.<alias>|r.  Aliases must be all lowercase, with no spaces.',
								order	= 21,
								validate	= function(info, val)
									if val == '' then
										return true
									elseif val == 'cooldowns' or val == 'hardcasts' or val == 'mode' or val == 'interrupts' then
										Hekili:Print("'" .. val .. "' is a reserved toggle name.")
										return "'" .. val .. "' is a reserved toggle name."
									end

									if strmatch(val, "[^a-z]") then
										Hekili:Print("Toggle names must be all lowercase alphabet characters.")
										return "Toggle names must be all lowercase alphabet characters."

									else
										local this = tonumber( info[#info]:match('Toggle (%d) Name') )

										for i = 1, 5 do
											if i ~= this and val == self.DB.profile['Toggle ' .. i .. ' Name'] then
												Hekili:Print("That name is already in use.")
												return "That name is already in use."
											end
										end
										
									end

									return true
								end,
								width	= 'double'
							},
							HEKILI_TOGGLE_3 = {
								type	= 'keybinding',
								name	= 'Toggle 3',
								order	= 30
							},
							['Toggle 3 Name'] = {
								type	= 'input',
								name	= 'Alias',
								desc	= 'Set a unique alias for this custom toggle.  You can check to see if this toggle is active by testing the criterion |cFFFFD100toggle.three|r or |cFFFFD100toggle.<alias>|r.  Aliases must be all lowercase, with no spaces.',
								order	= 31,
								validate	= function(info, val)
									if val == '' then
										return true
									elseif val == 'cooldowns' or val == 'hardcasts' or val == 'mode' or val == 'interrupts' then
										Hekili:Print("'" .. val .. "' is a reserved toggle name.")
										return "'" .. val .. "' is a reserved toggle name."
									end

									if strmatch(val, "[^a-z]") then
										Hekili:Print("Toggle names must be all lowercase alphabet characters.")
										return "Toggle names must be all lowercase alphabet characters."

									else
										local this = tonumber( info[#info]:match('Toggle (%d) Name') )

										for i = 1, 5 do
											if i ~= this and val == self.DB.profile['Toggle ' .. i .. ' Name'] then
												Hekili:Print("That name is already in use.")
												return "That name is already in use."
											end
										end
										
									end

									return true
								end,
								width	= 'double'
							},
							HEKILI_TOGGLE_4 = {
								type	= 'keybinding',
								name	= 'Toggle 4',
								order	= 40
							},
							['Toggle 4 Name'] = {
								type	= 'input',
								name	= 'Alias',
								desc	= 'Set a unique alias for this custom toggle.  You can check to see if this toggle is active by testing the criterion |cFFFFD100toggle.four|r or |cFFFFD100toggle.<alias>|r.  Aliases must be all lowercase, with no spaces.',
								order	= 41,
								validate	= function(info, val)
									if val == '' then
										return true
									elseif val == 'cooldowns' or val == 'hardcasts' or val == 'mode' or val == 'interrupts' then
										Hekili:Print("'" .. val .. "' is a reserved toggle name.")
										return "'" .. val .. "' is a reserved toggle name."
									end

									if strmatch(val, "[^a-z]") then
										Hekili:Print("Toggle names must be all lowercase alphabet characters.")
										return "Toggle names must be all lowercase alphabet characters."

									else
										local this = tonumber( info[#info]:match('Toggle (%d) Name') )

										for i = 1, 5 do
											if i ~= this and val == self.DB.profile['Toggle ' .. i .. ' Name'] then
												Hekili:Print("That name is already in use.")
												return "That name is already in use."
											end
										end
										
									end

									return true
								end,
								width	= 'double'
							},
							HEKILI_TOGGLE_5 = {
								type	= 'keybinding',
								name	= 'Toggle 5',
								order	= 50
							},
							['Toggle 5 Name'] = {
								type	= 'input',
								name	= 'Alias',
								desc	= 'Set a unique alias for this custom toggle.  You can check to see if this toggle is active by testing the criterion |cFFFFD100toggle.five|r or |cFFFFD100toggle.<alias>|r.  Aliases must be all lowercase, with no spaces.',
								order	= 51,
								validate	= function(info, val)
									if val == '' then
										return true
									elseif val == 'cooldowns' or val == 'hardcasts' or val == 'mode' or val == 'interrupts' then
										Hekili:Print("'" .. val .. "' is a reserved toggle name.")
										return "'" .. val .. "' is a reserved toggle name."
									end

									if strmatch(val, "[^a-z]") then
										Hekili:Print("Toggle names must be all lowercase alphabet characters.")
										return "Toggle names must be all lowercase alphabet characters."

									else
										local this = tonumber( info[#info]:match('Toggle (%d) Name') )

										for i = 1, 5 do
											if i ~= this and val == self.DB.profile['Toggle ' .. i .. ' Name'] then
												Hekili:Print("That name is already in use.")
												return "That name is already in use."
											end
										end
										
									end

									return true
								end,
								width	= 'double'
							},
						}
					}
				}
			}
		}
	}

	for i, v in ipairs(self.DB.profile.displays) do
		local dispKey = 'D' .. i
		Options.args.displays.args[ dispKey ] = self:NewDisplayOption( i )
		
		if v.Queues then
			for key, value in ipairs( v.Queues ) do
				Options.args.displays.args[ dispKey ].args[ 'P' .. key ] = self:NewHookOption( i, key )
			end
		end
		
	end

	for i,v in ipairs(self.DB.profile.actionLists) do
		local listKey = 'L' .. i
		Options.args.actionLists.args[ listKey ] = self:NewActionListOption( i )

		if v.Actions then
			for key, value in ipairs( v.Actions ) do
--				Options.args.actionLists.args[ listKey ].args['Actions'].args[ 'A' .. key ] = self:NewActionOption( i, key )
				Options.args.actionLists.args[ listKey ].args[ 'A' .. key ] = self:NewActionOption( i, key )
			end
		end

	end
	
	return Options
end


function Hekili:TotalRefresh()

	if self.RestoreDefaults then self:RestoreDefaults() end

	for i, queue in ipairs( self.Queue ) do
		for j, _ in pairs( queue ) do
			self.Queue[i][j] = nil
		end
		self.Queue[i] = nil
	end

	self:RefreshOptions()
	self:BuildUI()
end


function Hekili:RefreshOptions()

	-- Remove existing displays from Options and rebuild the options table.
	for k,_ in pairs(self.Options.args.displays.args) do
		if strmatch(k, "^D(%d+)") then
			self.Options.args.displays.args[k] = nil
		end
	end
	
	for i,v in ipairs(self.DB.profile.displays) do
		local dispKey = 'D' .. i
		self.Options.args.displays.args[ dispKey ] = self:NewDisplayOption( i )
		
		if v.Queues then
			for p, value in ipairs( v.Queues ) do
				local hookKey = 'P' .. p
				self.Options.args.displays.args[ dispKey ].args[ hookKey ]  = self:NewHookOption( i, p )
			end
		end
	end
	
	for k,_ in pairs(self.Options.args.actionLists.args) do
		if strmatch(k, "^L(%d+)") then
			self.Options.args.actionLists.args[k] = nil
		end
	end
	
	for i,v in ipairs(self.DB.profile.actionLists) do
		local listKey = 'L' .. i
		self.Options.args.actionLists.args[ listKey ] = self:NewActionListOption( i )
		
		if v.Actions then
			for a,_ in ipairs( v.Actions ) do
				local actKey = 'A' .. a
				self.Options.args.actionLists.args[ listKey ].args[ actKey ] = self:NewActionOption( i, a )
			end
		end
	end
	
	-- Until I feel like making this better at managing memory.
	collectgarbage()
	
end


function Hekili:GetOption( info, input )
	local category, depth, option = info[1], #info, info[#info]
	local profile = self.DB.profile
	
	if category == 'general' then
		return profile[option]
	
	elseif category == 'bindings' then
	
		if option:match( "TOGGLE" ) then
			return select( 1, GetBindingKey( option ) )
		
		elseif option == 'Pause' then
			return self.Pause
			
		else
			return profile[ option ]

		end

	elseif category == 'displays' then

		-- This is a generic display option/function.
		if depth == 2 then
			return nil
			
		-- This is a display (or a hook).
		else
			local dispKey, dispID = info[2], tonumber( strmatch( info[2], "^D(%d+)" ) )
			local hookKey, hookID = info[3], tonumber( strmatch( info[3] or "", "^P(%d+)" ) )
			local display = profile.displays[ dispID ]

			-- This is a specific display's settings.
			if depth == 3 or not hookID then
				
				if option == 'x' or option == 'y' then
					return tostring( display[ option ] )
				
				elseif option == 'Copy To' or option == 'Import' then
					return nil
					
				else
					return display[ option ]
					
				end
			
			-- This is a priority hook.
			else
				local hook = display.Queues[ hookID ]
				
				if option == 'Move' then
					return hookID
				
				else
					return hook[ option ]
				
				end
			
			end
			
		end
	
	elseif category == 'actionLists' then
	
		-- This is a general action list option.
		if depth == 2 then
			return nil
			
		else
			local listKey, listID	= info[2], tonumber( strmatch( info[2], "^L(%d+)" ) )
			local actKey, actID	= info[3], tonumber( strmatch( info[3], "^A(%d+)" ) )
			local list = listID and profile.actionLists[ listID ]
		
			-- This is a specific action list.
			if depth == 3 or not actID then
				return list[ option ]
			
			-- This is a specific action.
			elseif listID and actID then
				local action = list.Actions[ actID ]
				
				if option == 'Move' then
					return actID
				
				else
					return action[ option ]
				
				end
			
			end
		
		end
		
	end

	Hekili:Error( "GetOption() - should never see." )

end



local function GetUniqueName( category, name )
	local numChecked, suffix, original = 0, 1, name
	
	while numChecked < #category do
		for i, instance in ipairs( category ) do
			if name == instance.Name then
				name = original .. ' (' .. suffix .. ')'
				suffix = suffix + 1
				numChecked = 0
			else
				numChecked = numChecked + 1
			end
		end
	end
	
	return name
end


function Hekili:SetOption( info, input )
	local category, depth, option, subcategory = info[1], #info, info[#info], nil
	local Rebuild, RebuildUI, RebuiltScripts, RebuildOptions, RebuildCache, Select
	local profile = self.DB.profile
	
	if category == 'general' then
		-- We'll preset the option here; works for most options.
		profile[ option ] = input
		
		if option == 'Enabled' then
			for i, buttons in ipairs( self.UI.Buttons ) do
				for j, _ in ipairs( buttons ) do
					if input == false then
						buttons[j]:Hide()
					else
						buttons[j]:Show()
					end
				end
			end
			
			if input == true then self:Enable()
			else self:Disable() end

			return
			
		elseif option == 'Locked' then
			if not self.Config and not self.Pause then
				for i, v in ipairs( self.UI.Buttons ) do
					self.UI.Buttons[i][1]:EnableMouse( not input )
				end
			end
		
		elseif option == 'Audit Targets' or option == 'Updates Per Second' then
			return
			
		end
		
		-- General options do not need add'l handling.
		return 
	
	elseif category == 'bindings' then

		local revert = profile[ option ]
		profile[ option ] = input
	
		if option:match( "TOGGLE" ) then
			if GetBindingKey( option ) then
				SetBinding( GetBindingKey( option ) )
			end
			SetBinding( input, option )
			SaveBindings( GetCurrentBindingSet() )

		elseif option == 'Pause' then
			profile[option] = revert
			self:TogglePause()
			return
			
		elseif option == 'Mode' then
			profile[option] = revert
			self:ToggleMode()
			return

		elseif option == 'Cooldowns' then
			profile[option] = revert
			self:ToggleCooldowns()
			return
		
		elseif option == 'Hardcasts' then
			profile[option] = revert
			self:ToggleHardcasts()
			return
			
		elseif option == 'Interrupts' then
			profile[option] = revert
			self:ToggleInterrupts()
			return
		
		else -- Toggle Names.
			if trim( input ) == "" then
				profile[ option ] = nil
			end
			
		end

		-- Bindings do not need add'l handling.
		return

	elseif category == 'displays' then

		-- This is a generic display option/function.
		if depth == 2 then
		
			if option == 'New Display' then
				local key, index = self:NewDisplay( input )
				
				if not key then return end
				
				C_Timer.After( 1 / profile['Updates Per Second'], Hekili[ 'ProcessDisplay'..index ] )
			
			elseif option == 'Import Display' then
				local import = self:DeserializeDisplay( input )
				
				if not import then
					Hekili:Print("Unable to import from given input string.")
					return
				end
				
				import.Name = GetUniqueName( profile.displays, import.Name )
				profile.displays[ #profile.displays + 1 ] = import
				
			end

			Rebuild = true
			
		-- This is a display (or a hook).
		else
			local dispKey, dispID = info[2], info[2] and tonumber( strmatch( info[2], "^D(%d+)" ) )
			local hookKey, hookID = info[3], info[3] and tonumber( strmatch( info[3], "^P(%d+)" ) )
			local display = dispID and profile.displays[ dispID ]

			-- This is a specific display's settings.
			if depth == 3 or not hookID then
				local revert = display[option]
				display[option] = input
				
				if option == 'x' or option == 'y' then
					display[option] = tonumber( input )
					RebuildUI = true
				
				elseif option == 'Name' then
					self.Options.args.displays.args[ dispKey ].name = input
				
				elseif option == 'Enabled' then
					-- Might want to replace this with RebuildUI = true
					for i, button in ipairs( self.UI.Buttons[ dispID ] ) do
						if not input then
							button:Hide()
						else
							button:Show()
						end
					end
					RebuildUI = true
				
				elseif option == 'Script' then
					display[option] = input:trim()
					RebuildScripts = true
				
				elseif option == 'Copy To' then
					local index = #profile.displays + 1
					
					profile.displays[ index ] = tblCopy( display )
					profile.displays[ index ].Name = input
					
					Rebuild = true
				
				elseif option == 'Import' then
					local import = self:DeserializeDisplay( input )
				
					if not import then
						Hekili:Print("Unable to import from given input string.")
						return
					end
					
					local name	= display.Name
					profile.displays[ dispID ] = import
					profile.displays[ dispID ].Name = name
					
					Rebuild = true
				
				elseif option == 'Icons Shown' then
					if Hekili.Queue[ dispID ] then
						for i = input + 1, #Hekili.Queue[ dispID ] do
							Hekili.Queue[ dispID ][ i ] = nil
						end
					end
				
				end
				
				RebuildUI = true
			
			-- This is a priority hook.
			else
				local hook = display.Queues[ hookID ]
				
				if option == 'Move' then
					local placeholder = table.remove( display.Queues, hookID )
					table.insert( display.Queues, input, placeholder )
					RebuildOptions, RebuildCache, RebuildScripts, Select = true, true, true, 'P'..input
				
				elseif option == 'Script' then
					hook[ option ] = input:trim()
					RebuildScripts = true
				
				elseif option == 'Name' then
					self.Options.args.displays.args[ dispKey ].args[ hookKey ].name = '|cFFFFD100' .. hookID .. '.|r ' .. input
					hook[ option ] = input
					
				else
					hook[ option ] = input
					RebuildCache = ( option == 'Enabled' )
				
				end
			
			end
		end
	
	elseif category == 'actionLists' then
	
		if depth == 2 then 
	
			if option == 'New Action List' then
				local key = self:NewActionList( input )
				if key then
					RebuildOptions, RebuildCache = true, true
				end
				
			elseif option == 'Import Action List' then
				local import = self:DeserializeActionList( input )
				
				if not import then
					Hekili:Print("Unable to import from given input string.")
					return
				end
				
				import.Name = GetUniqueName( profile.actionLists, import.Name )
				profile.actionLists[ #profile.actionLists + 1 ] = import
				Rebuild = true
				
			end
		
		else
			local listKey, listID	= info[2], info[2] and tonumber( strmatch( info[2], "^L(%d+)" ) )
			local actKey, actID	= info[3], info[3] and tonumber( strmatch( info[3], "^A(%d+)" ) )
			local list = profile.actionLists[ listID ]
			
			if depth == 3 or not actID then

				local revert = list[ option ]
				list[option] = input
				
				if option == 'Name' then
					self.Options.args.actionLists.args[ listKey ].name = input
				
				elseif option == 'Enabled' or option == 'Specialization' then
					RebuildCache = true
					
				elseif option == 'Script' then
					list[ option ] = input:trim()
					RebuildScripts = true
				
				-- Import/Exports
				elseif option == 'Copy To' then
					list[option] = nil

					local index = #profile.actionLists + 1
					
					profile.actionLists[ index ] = tblCopy( list )
					profile.actionLists[ index ].Name = input
					
					Rebuild = true
					
				elseif option == 'Import Action List' then
					list[option] = nil

					local import = self:DeserializeActionList( input )
					
					if not import then
						Hekili:Print("Unable to import from given import string.")
						return
					end
					
					import.Name = list.Name
					
					profile.actionLists[ listID ] = import
					Rebuild = true
				
				elseif option == 'SimulationCraft' then
					list[option] = nil

					local import, error = self:ImportSimulationCraftActionList( input )
					
					if error then
						Hekili:Print( "SimulationCraft import failed.  The following lines threw errors:" )
						for i = 1, #error do
							Hekili:Print( error[i] )
						end
						return
					end
					
					if not import then
						Hekili:Print( "No actions were successfully imported." )
						return
					end
					
					table.wipe( list.Actions )
				
					for i = 1, #import do
						local key = self:NewAction( listID, self.Abilities[ import[ i ].ability ].name )
						
						list.Actions[ i ].Ability	= import[ i ].ability
						list.Actions[ i ].Args		= import[ i ].modifiers
						list.Actions[ i ].Script	= import[ i ].conditions
						list.Actions[ i ].Enabled	= true
					end
					
					Rebuild = true
				
				end
		
			-- This is a specific action.
			else
				local list = profile.actionLists[ listID ]
				local action = list.Actions[ actID ]
				
				action[ option ] = input
				
				if option == 'Name' then
					self.Options.args.actionLists.args[ listKey ].args[ actKey ].name = '|cFFFFD100' .. actID .. '.|r ' .. input
				
				elseif option == 'Enabled' then
					RebuildCache = true
					
				elseif option == 'Move' then
					action[ option ] = nil
					local placeholder = table.remove( list.Actions, actID )
					table.insert( list.Actions, input, placeholder )
					RebuildScripts, RebuildOptions, Select = true, true, 'A'..input
				
				elseif option == 'Script' or option == 'Args' then
					input = input:trim()
					action[ option ] = input
					RebuildScripts = true
				
				end
			
			end
		end
	end
	
	if Rebuild then
		self:RefreshOptions()
		self:LoadScripts()
		self:BuildUI()
	else
		if RebuildOptions then self:RefreshOptions() end
		if RebuildScripts then self:LoadScripts() end
		if RebuildUI then self:BuildUI() end
		if RebuildCache and not RebuildUI then self:CacheDurableDisplayCriteria() end
	end
	
	if Select then
		self.ACD:SelectGroup( "Hekili", category, info[2], Select )
	end

end	


Hekili.TrackFunctions = {
	"ResetState",
	"ProcessHooks",
	"UpdateDisplays",
	"CheckScript",
	"COMBAT_LOG_EVENT_UNFILTERED"
}
	
	


function Hekili:CmdLine( input )
	if not input or input:trim() == "" then
		self.Config = true
		for i,v in ipairs(self.UI.Buttons) do
			self.UI.Buttons[i][1]:EnableMouse(true)
			self.UI.Buttons[i][1]:SetMovable(true)
		end
		self.ACD:SetDefaultSize( "Hekili", 765, 555 )
		self.ACD:Open("Hekili")
		self.OnHideFrame = self.OnHideFrame or CreateFrame("Frame", nil)
		self.OnHideFrame:SetParent( Hekili.ACD.OpenFrames["Hekili"].frame )
		Hekili.OnHideFrame:SetScript( "OnHide", function(self)
			Hekili.Config = false
			for i,v in ipairs(Hekili.UI.Buttons) do
				Hekili.UI.Buttons[i][1]:EnableMouse( not Hekili.DB.profile.Locked or Hekili.Pause )
				Hekili.UI.Buttons[i][1]:SetMovable( not Hekili.DB.profile.Locked )
			end
			self:SetScript("OnHide", nil)
			collectgarbage()
		end )
			
	elseif input:trim() == 'center' then
		for i, v in ipairs( self.DB.profile.displays ) do
			self.UI.Buttons[i][1]:ClearAllPoints()
			self.UI.Buttons[i][1]:SetPoint("CENTER", 0, (i-1) * 50 )
		end
		self:SaveCoordinates()
	
	elseif input:trim() == 'recover' then
		self.DB.profile.displays = {}
		self.DB.profile.actionLists = {}
		self:RestoreDefaults()
		self:BuildUI()
		Hekili:Print("Default displays and action lists restored.")
	
	elseif input:trim() == 'times' then
		ResetCPUUsage()
		C_Timer.After( 60, function ()
			UpdateAddOnCPUUsage()
			Hekili:Print("Hekili Function CPU Usage:  " .. GetAddOnCPUUsage("Hekili") )
			for i,v in ipairs( self.TrackFunctions ) do
				local usage, calls = GetFunctionCPUUsage( Hekili[v], false )
				local subs = select( 2, GetFunctionCPUUsage( Hekili[v], true) ) - usage
				Hekili:Print( strformat("%5s %10s %10s %10s : %s", strformat( "%5d", calls ), strformat( "%5.2f", usage), strformat( "%5.2f", subs), calls > 0 and strformat( "%5.2f", ( usage / calls ) )  or 0 , v ) )
			end
		end )

	else
		LibStub("AceConfigCmd-3.0"):HandleCommand("hekili", "Hekili", input)
	end
end


function Hekili:SerializeDisplay( num )

	if not self.DB.profile.displays[ num ] then return nil end
	
	local serial = tblCopy( self.DB.profile.displays[ num ] )
	
	-- Change actionlist IDs to actionlist names so we can validate later.
	for i,v in ipairs( serial.Queues ) do
		if serial.Queues[i]['Action List'] ~= 0 then
			serial.Queues[i]['Action List'] = self.DB.profile.actionLists[ v['Action List'] ].Name
		end
	end
	
	-- return self:Serialize(flat_display)
	return self:Serialize( serial )
end


function Hekili:DeserializeDisplay( str )
	local success, import = self:Deserialize( str )

	if not success then return nil end

	-- Check for duplicate names.
	for i, prio in ipairs( import.Queues ) do
		if prio['Action List'] ~= 0 then
			for j, list in ipairs( self.DB.profile.actionLists ) do
				if prio['Action List'] == list.Name then
					prio['Action List'] = j
				end
			end
			if type( prio['Action List'] ) == 'string' then
				prio['Action List'] = 0
			end
		end
	end
	
	return import
end	


function Hekili:SerializeActionList( num )

	if not self.DB.profile.actionLists[ num ] then return nil end
	
	local serial = tblCopy( self.DB.profile.actionLists[ num ] )
	
	-- return self:Serialize(flat_display)
	return self:Serialize( serial )
end


function Hekili:DeserializeActionList( str )
	local success, import = self:Deserialize( str )

	if not success then return nil end
	
	return import
end	


function Hekili:ImportSimulationCraftActionList( str )
	local import = str and str or Hekili.ImportString
	local output, errors = {}, {}
	local times = 0

	import = import:gsub("(|)([^|])", "%1|%2"):gsub("|||", "||")
	
	for _, v in ipairs( Hekili.Utils.Resources ) do
		import, times = import:gsub( '('..v..')([^.])', "%1.current%2" )
		if times > 0 then
			Hekili:Print("Converted '" .. v .. "' to '" .. v .. ".current' (" .. times .. "x)." )
		end
	end
	
	import, times = import:gsub( "(react)([^><=~])", "up%2" )
	if times > 0 then
		Hekili:Print("Converted unconditional 'buff.react' to 'buff.up' (" .. times .. "x)." )
	end
	
	for i in import:gmatch("action.-=/?([^\n^$]*)") do
		local _, commas = i:gsub(",", "")
		local _, condis = i:gsub(",if=", "")
		
		-- Action
		if commas == 0 then 
			local ability = i:trim()
			
			if ability and self.Abilities[ ability ] then
				output[#output + 1] = {
					ability = ability
				}
			else
				errors[#errors + 1] = i
			end
		
		-- Action and Conditions
		elseif commas == 1 and condis == 1 then 
			local ability, conditions = i:match("(.-),if=(.-)$")
			
			if ability and conditions and self.Abilities[ ability ] then
				output[#output + 1] = {
					ability		= ability,
					conditions	= conditions
				}
			else
				errors[#errors + 1] = i
			end
		
		-- Action and Modifiers
		elseif commas >= 1 and condis == 0 then
			local ability, modifier = i:match("(.-),(.-)$")
			
			if ability and modifier and self.Abilities[ ability ] then
				output[#output + 1] = {
					ability		= ability,
					modifiers	= modifiers
				}
			else
				errors[#errors + 1] = i
			end
			
		-- Action, Modifiers, Conditions
		elseif commas > 1 and condis == 1 then 
			local ability, modifiers, conditions = i:match("(.-),(.-),if=(.-)$")	
			
			if ability and modifiers and conditions and self.Abilities[ ability ] then
				output[#output + 1] = {
					ability		= ability,
					modifiers	= modifiers,
					conditions	= conditions
				}
			else
				errors[#errors + 1] = i
			end
		
		end
	end
	
	return #output > 0 and output or nil, #errors > 0 and errors or nil
	
end

-- Key Bindings
function Hekili:TogglePause()
	self.Pause = not self.Pause
	
	local MouseInteract = self.Pause or self.Config or not self.DB.profile.Locked
	
	for i = 1, #self.UI.Buttons do
		for j = 1, #self.UI.Buttons[i] do
			self.UI.Buttons[i][j]:EnableMouse( MouseInteract )
		end
	end
	
	Hekili:Print( (not self.Pause and "UN" or "") .. "PAUSED." )
	Hekili:Notify( (not self.Pause and "UN" or "") .. "PAUSED" )
end


function Hekili:Notify( str )
	if not self.UI.Buttons or not self.UI.Buttons[1] or not self.UI.Buttons[1][1] or not str then
		return
	end
	
	HekiliNotification:SetText( str )
	HekiliNotification:SetTextColor( 1, 0.8, 0, 1 )
	UIFrameFadeOut( HekiliNotification, 3, 1, 0 )
end


function Hekili:ToggleMode()

	self.DB.profile.Mode = self.DB.profile.Mode == nil and true or ( self.DB.profile.Mode == true and false or ( self.DB.profile.Mode == false and nil ) )

	if self.DB.profile.Mode == nil then
		Hekili:Print("Single-target mode activated.")
		Hekili:Notify("Mode:\nSingle")
	elseif self.DB.profile.Mode == true then
		Hekili:Print("Cleave mode activated.")
		Hekili:Notify("Mode:\nCleave")
	elseif self.DB.profile.Mode == false then
		Hekili:Print("AOE mode activated.")
		Hekili:Notify("Mode:\nAOE")
	else Hekili:Print("Unknown mode, reverting to single-target.")
		self.DB.profile.Mode = nil
	end
end

function Hekili:ToggleInterrupts()
	self.DB.profile.Interrupts = not self.DB.profile.Interrupts
	Hekili:Print( self.DB.profile.Interrupts and "Interrupts |cFF00FF00ENABLED|r." or "Interrupts |cFFFF0000DISABLED|r." )
	Hekili:Notify( "Interrupts " .. ( self.DB.profile.Interrupts and "ON" or "OFF" ) )
end
	

function Hekili:ToggleCooldowns()
	self.DB.profile.Cooldowns = not self.DB.profile.Cooldowns
	Hekili:Print( self.DB.profile.Cooldowns and "Cooldowns |cFF00FF00ENABLED|r." or "Cooldowns |cFFFF0000DISABLED|r." )
	Hekili:Notify( "Cooldowns " .. ( self.DB.profile.Cooldowns and "ON" or "OFF" ) )
end


function Hekili:ToggleHardcasts()
	self.DB.profile.Hardcasts = not self.DB.profile.Hardcasts
	Hekili:Print( self.DB.profile.Hardcasts and "Hardcasts |cFF00FF00ENABLED|r." or "Hardcasts |cFFFF0000DISABLED|r." )
	Hekili:Notify( "Hardcasts " .. ( self.DB.profile.Hardcasts and "ON" or "OFF" ) )
end


function Hekili:Toggle( num )
	self.DB.profile['Toggle_' .. num] = not self.DB.profile['Toggle_' .. num]
	
	if self.DB.profile['Toggle ' .. num .. ' Name'] then
		Hekili:Print( self.DB.profile['Toggle_' .. num] and ( 'Toggle \'' .. self.DB.profile['Toggle ' .. num .. ' Name'] .. "' |cFF00FF00ENABLED|r." ) or ( 'Toggle \'' .. self.DB.profile['Toggle ' .. num .. ' Name'] .. "' |cFFFF0000DISABLED|r." ) )
	else
		Hekili:Print( self.DB.profile['Toggle_' .. num] and ( "Custom Toggle #" .. num .. " |cFF00FF00ENABLED|r." ) or ( "Custom Toggle #" .. num .. " |cFFFF0000DISABLED|r." ) )
	end
end