-- Utils.lua
-- June 2014

local H		= Hekili
H.Utils			= {}

local string = string


function H.Utils.FormatKey( s )
	return ( strlower(s):gsub("[^a-z0-9_ ]", ""):gsub("%s", "_") )
end


if not round then
	round = function( num, places )
		return tonumber( string.format( "%." .. ( places or 0 ) .. "f", num ) )
	end
end


-- Hrm.
H.Classes = {}
FillLocalizedClassList(H.Classes)


local ClassIDs = {
	['WARRIOR']		= 1,
	['PALADIN']		= 2,
	['HUNTER']		= 3,
	['ROGUE']		= 4,
	['PRIEST']		= 5,
	['DEATHKNIGHT']	= 6,
	['SHAMAN']		= 7,
	['MAGE']		= 8,
	['WARLOCK']		= 9,
	['MONK']		= 10,
	['DRUID']		= 11
}


function H.Utils.GetClassID( name )
	return ClassIDs[ name ]
end


function H.Utils.GetSpecializationID()
	if GetSpecialization() then
		return GetSpecializationInfo( GetSpecialization() )
	end
	
	return nil
end


-- Deep Copy from http://stackoverflow.com/questions/640642/how-do-you-copy-a-lua-table-by-value
function tblCopy(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[tblCopy(k, s)] = tblCopy(v, s) end
  return res
end
Hekili.Utils.tblCopy = tblCopy


function H.Utils.Unpacks( ... )
   local someValues = {}

   for anIndex = 1, select( '#', ... ) do
       for _, aValue in ipairs( select( anIndex, ... ) ) do
           someValues[ #someValues + 1] = aValue
       end
   end

   return unpack( someValues )
end


local BaseSpecializationInfo = _G.GetSpecializationInfo
function H.Utils.GetSpecializationInfo( spec )
	if spec then
		return BaseSpecializationInfo( spec )
	end
	
	return -1
end


local COLOR_NUMBERS	= '|cFFFFD100'
local COLOR_TRUE		= '|cFF00FF00'
local COLOR_FALSE		= '|cFFFF0000'
local COLOR_STRING		= '|cFF008888'
local COLOR_DEFAULT	= '|cFFFFFFFF'
local COLOR_NORMAL		= '|r'


function H.Utils.FormatValue( value )
	if type( value ) == 'number' then
		-- Check for decimal places.
		if select(2, math.modf( value )) ~= 0 then
			return COLOR_NUMBERS .. round( value, 2 ) .. COLOR_NORMAL
		else
			return COLOR_NUMBERS .. value .. COLOR_NORMAL
		end
	
	elseif type( value ) == 'boolean' then
		if value then
			return COLOR_TRUE .. tostring( value ) .. COLOR_NORMAL
		else
			return COLOR_FALSE .. tostring( value ) .. COLOR_NORMAL
		end
	
	elseif type( value ) == 'string' then
		return COLOR_STRING .. value .. COLOR_NORMAL
		
	end
	
	return COLOR_DEFAULT .. tostring( value ) .. COLOR_NORMAL

end