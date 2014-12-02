-- Shaman.lua
-- August 2014


local AddAbility = Hekili.Utils.AddAbility
local ModifyAbility = Hekili.Utils.ModifyAbility

local AddHandler = Hekili.Utils.AddHandler

local AddAura = Hekili.Utils.AddAura
local ModifyAura = Hekili.Utils.ModifyAura

local AddGlyph	= Hekili.Utils.AddGlyph
local AddTalent = Hekili.Utils.AddTalent
local AddPerk = Hekili.Utils.AddPerk
local AddResource = Hekili.Utils.AddResource

local AddItemSet = Hekili.Utils.AddItemSet

local SetGCD = Hekili.Utils.SetGCD


-- This table gets loaded only if there's a supported class/specialization.
if (select(2, UnitClass('player')) == 'SHAMAN') then

	Hekili.Class = 'SHAMAN'

	AddResource( SPELL_POWER_MANA, true )

	AddTalent( 'natures_guardian', 30884 )
	AddTalent( 'stone_bulwark_totem', 108270 )
	AddTalent( 'astral_shift', 108271 )
	AddTalent( 'frozen_power', 63374 )
	AddTalent( 'earthgrab_totem', 51485 )
	AddTalent( 'windwalk_totem', 108273 )
	AddTalent( 'call_of_the_elements', 108285 )
	AddTalent( 'totemic_persistence', 108284 )
	AddTalent( 'totemic_projection', 108287 )
	AddTalent( 'elemental_mastery', 16166 )
	AddTalent( 'ancestral_swiftness', 16188 )
	AddTalent( 'echo_of_the_elements', 108283 )
	AddTalent( 'rushing_streams', 147074 )
	AddTalent( 'ancestral_guidance', 108281 )
	AddTalent( 'conductivity', 108282 )
	AddTalent( 'unleashed_fury', 117012 )
	AddTalent( 'primal_elementalist', 117013 )
	AddTalent( 'elemental_blast', 117014 )
	AddTalent( 'elemental_fusion', 152257 )
	AddTalent( 'storm_elemental_totem', 152256 )
	AddTalent( 'liquid_magma', 152255 )

	-- Major Glyphs.
	AddGlyph( 'capacitor_totem', 55442 )
	AddGlyph( 'chain_lightning', 55449 )
	AddGlyph( 'chaining', 55452 )
	AddGlyph( 'cleansing_waters', 55445 )
	AddGlyph( 'ephemeral_spirits', 159640 )
	AddGlyph( 'eternal_earth', 147781 )
	AddGlyph( 'feral_spirit', 63271 )
	AddGlyph( 'fire_elemental_totem', 55455 )
	AddGlyph( 'fire_nova', 55450 )
	AddGlyph( 'flame_shock', 55447 )
	AddGlyph( 'frost_shock', 55443 )
	AddGlyph( 'frostflame_weapon', 161654 )
	AddGlyph( 'ghost_wolf', 59289 )
	AddGlyph( 'grounding', 159643 )
	AddGlyph( 'grounding_totem', 55441 )
	AddGlyph( 'healing_storm', 89646 )
	AddGlyph( 'healing_stream_totem', 55456 )
	AddGlyph( 'healing_wave', 55440 )
	AddGlyph( 'hex', 63291 )
	AddGlyph( 'lava_spread', 159644 )
	AddGlyph( 'lightning_shield', 101052 )
	AddGlyph( 'purge', 55439 )
	AddGlyph( 'purging', 147762 )
	AddGlyph( 'reactive_shielding', 159647 )
	AddGlyph( 'riptide', 63273 )
	AddGlyph( 'shamanistic_rage', 63280 )
	AddGlyph( 'shamanistic_resolve', 159648 )
	AddGlyph( 'shocks', 159649 )
	AddGlyph( 'spirit_walk', 55454 )
	AddGlyph( 'spiritwalkers_aegis', 159651 )
	AddGlyph( 'spiritwalkers_focus', 159650 )
	AddGlyph( 'spiritwalkers_grace', 55446 )
	AddGlyph( 'telluric_currents', 55453 )
	AddGlyph( 'thunder', 63270 )
	AddGlyph( 'totemic_recall', 55438 )
	AddGlyph( 'totemic_vigor', 63298 )
	AddGlyph( 'unstable_earth', 55437 )
	AddGlyph( 'water_shield', 55436 )
	AddGlyph( 'wind_shear', 55451 )
	
	-- Minor Glyphs.
	AddGlyph( 'astral_fixation', 147787 )
	AddGlyph( 'astral_recall', 58058 )
	AddGlyph( 'deluge', 63279 )
	AddGlyph( 'elemental_familiars', 147788 )
	AddGlyph( 'far_sight', 58059 )
	AddGlyph( 'flaming_serpents', 147772 )
	AddGlyph( 'ghostly_speed', 159642 )
	AddGlyph( 'lava_lash', 55444 )
	AddGlyph( 'lingering_ancestors', 147784 )
	AddGlyph( 'rain_of_frogs', 147707 )
	AddGlyph( 'spirit_raptors', 147783 )
	AddGlyph( 'spirit_wolf', 147770 )
	AddGlyph( 'compy', 147785 )
	AddGlyph( 'lakestrider', 55448 )
	AddGlyph( 'spectral_wolf', 58135 )
	AddGlyph( 'thunderstorm', 62132 )
	AddGlyph( 'totemic_encirclement', 58057 )
	
	-- Player Buffs / Debuffs
	AddAura( 'ancestral_swiftness', 16188, 'duration', 3600 )
	AddAura( 'ascendance', 114051, 'duration', 15 )
	AddAura( 'echo_of_the_elements', 159103, 'duration', 20 )
	AddAura( 'elemental_blast', 117014, 'duration', 8 )
	AddAura( 'elemental_fusion', 157174, 'duration', 15, 'max_stacks', 2 )
	AddAura( 'elemental_mastery', 16166, 'duration', 20 )
	AddAura( 'improved_chain_lightning', 157766, 'duration', 10 )
	Hekili.Auras[ 'enhanced_chain_lightning' ] = Hekili.Auras[ 'improved_chain_lightning' ] -- alias bc SimC uses both.
	AddAura( 'flame_shock', 8050, 'duration', 30 )
	AddAura( 'frost_shock', 8056, 'duration', 8 )
	AddAura( 'healing_rain', 73920, 'duration', 10 )
	AddAura( 'lava_surge', 77762 , 'duration', 6 )
	AddAura( 'lightning_shield', 324, 'duration', 3600 )	
	AddAura( 'liquid_magma', 152255, 'duration', 10, 'affects', 'pet' )
	AddAura( 'maelstrom_weapon', 51530 , 'duration', 30, 'max_stacks', 5 )
	AddAura( 'spiritwalkers_grace', 79206, 'duration', 15 )
	AddAura( 'stormstrike'     , 17364 , 'duration', 15 )
	AddAura( 'thunderstorm', 51490, 'duration', 5 )
	AddAura( 'unleash_flame', 73683 , 'duration', 20 )
	AddAura( 'unleash_wind', 73681 , 'duration', 30, 'max_stacks', 6 )

	
	AddPerk( 'enhanced_chain_lightning', 157765 )
	AddPerk( 'enhanced_unleash', 157784 )
	AddPerk( 'improved_flame_shock', 157804 )
	AddPerk( 'improved_lightning_shield', 157774 )
	AddPerk( 'improved_maelstrom_weapon', 157807 )
	AddPerk( 'improved_reincarnation', 157764 )
	
	-- Pick an instant cast ability for checking the GCD.
	SetGCD( 'lightning_shield' )

	-- Gear Sets
	AddItemSet( 'tier17', 115579, 115576, 115577, 115578, 115575 )
	AddItemSet( 'tier16_caster', 99341, 99347, 99340, 99342, 99095 )
	AddItemSet( 'tier16_melee', 99347, 99340, 99341, 99342, 99343 )
	AddItemSet( 'tier15_melee', 96689, 96690, 96691, 96692, 96693 )
	AddItemSet( 'tier14_melee', 87138, 87137, 87136, 87135, 87134 )

	
	AddAbility(	'ancestral_swiftness', 16188,
				{
					spend = 0,
					cast = 0,
					gcdType	= 'off',
					cooldown = 90
				} )

	AddAbility(	'ascendance', 165341, 165339,
				{
					known = 114049,
					spend = 0.052,
					cast = 0,
					gcdType = 'off',
					cooldown = 120
				} )
	
	AddAbility( 'bloodlust', 2825,
				{
					spend = 0.215,
					cast = 0,
					gcdType = 'off',
					cooldown = 300
				} )
	
	AddAbility( 'chain_lightning', 421,
				{
					spend = 0.01,
					cast = 2.0,
					gcdType = 'spell',
					cooldown = 0,
					hostile = true
				} )

	AddAbility( 'earth_elemental_totem', 2062,
				{
					spend = 0.281,
					cast = 0,
					gcdType = 'totem',
					cooldown = 300
				} )

	AddAbility( 'earth_shock', 8042,
				{
					spend = 0.012,
					cast = 0,
					gcdType = 'spell',
					cooldown = 6,
					hostile = true
				} )

	AddAbility( 'earthquake', 61882, 
				{
					spend = 0.008,
					cast = 2.5,
					gcdType = 'spell',
					cooldown = 10,
					hostile = true
				} )

	AddAbility( 'elemental_blast', 117014,
				{
					spend = 0,
					cast = 2.0,
					gcdType = 'spell',
					cooldown = 12,
					hostile = true
				} )	

	AddAbility( 'elemental_mastery', 16166,
				{
					spend = 0,
					cast = 0,
					gcdType = 'off',
					cooldown = 120
				} )

	AddAbility( 'feral_spirit', 51533,
				{
					spend = 0.12,
					cast = 0,
					gcdType = 'spell',
					cooldown = 120
				} )	

	AddAbility( 'fire_elemental_totem', 2894,
				{
					spend = 0.269,
					cast = 0,
					gcdType = 'totem',
					cooldown = 300
				} )

	AddAbility( 'fire_nova', 1535,
				{
					spend = 0.137,
					cast = 0,
					gcdType = 'spell',
					cooldown = 4.5,
					hostile = true
				} )

	AddAbility( 'flame_shock', 8050,
				{
					spend = 0.012,
					cast = 0,
					gcdType = 'spell',
					cooldown = 6,
					hostile = true
				} )

	AddAbility( 'frost_shock', 8056,
				{
					spend = 0.012,
					cast = 0,
					gcdType = 'spell',
					cooldown = 6,
					hostile = true
				} )

	AddAbility( 'healing_rain', 73920,
				{
					spend = 0.216,
					cast = 2,
					gcdType = 'spell',
					cooldown = 10
				} )	

	AddAbility( 'healing_surge', 8004,
				{
					spend = 0.207,
					cast = 1.5,
					gcdType = 'spell',
					cooldown = 0
				} )	

	AddAbility( 'heroism', 32182,
				{
					spend = 0.215,
					cast = 0,
					gcdType = 'off',
					cooldown = 300
				} )	
	
	AddAbility( 'lava_beam', 114074,
				{
					known = function( s ) return s.spec.elemental and s.buff.ascendance.up end,
					spend = 0.01,
					cast = 2,
					gcdType = 'spell',
					cooldown = 0,
					hostile = true
				} )

	AddAbility( 'lava_burst', 51505,
				{
					known = function( s ) return s.spec.elemental and s.level >= 34 end,
					spend = 0.005,
					cast = 2,
					gcdType = 'spell',
					cooldown = 8,
					hostile = true
				} )

	AddAbility( 'lava_lash', 60103,
				{
					spend = 0.01,
					cast = 0,
					gcdType = 'melee',
					cooldown = 9,
					hostile = true
				} )

	AddAbility( 'lightning_bolt', 403,
				{
					spend = 0.018,
					cast = 2.5,
					gcdType = 'spell',
					cooldown = 0,
					hostile = true
				} )

	AddAbility( 'lightning_shield', 324,
				{
					spend = 0,
					cast = 0,
					gcdType = 'spell',
					cooldown = 0
				} )

	AddAbility( 'liquid_magma', 152255,
				{
					spend = 0,
					cast = 0,
					gcdType = 'spell',
					cooldown = 45,
					hostile = true
				} )

	AddAbility( 'magma_totem', 8190,
				{
					spend = 0.211,
					cast = 0,
					gcdType = 'totem',
					cooldown = 0,
					hostile = true
				} )

	AddAbility( 'searing_totem', 3599,
				{
					spend = 0.03,
					cast = 0,
					gcdType = 'totem',
					cooldown = 0,
					hostile = true
				} )

	AddAbility( 'spiritwalkers_grace', 79206,
				{
					spend = 0.141,
					cast = 0,
					gcdType = 'off',
					cooldown = 120
				} )

	AddAbility( 'storm_elemental_totem', 152256,
				{
					spend = 0.269,
					cast = 0,
					gcdType = 'totem',
					cooldown = 300
				} )

	AddAbility( 'stormstrike', 17364,
				{
					known = function( s ) return s.spec.enhancement and not s.buff.ascendance.up end,
					spend = 0.01,
					cast = 0,
					gcdType = 'melee',
					cooldown = 7.5,
					hostile = true
				} )
	
	AddAbility( 'strike', 73899,
				{
					spend = 0.094,
					cast = 0,
					gcdType = 'melee',
					cooldown = 8,
					hostile = true
				} )
	
	AddAbility( 'thunderstorm', 51490,
				{
					spend = 0,
					cast = 0,
					gcdType = 'spell',
					cooldown = 45,
					hostile = true
				} )

	AddAbility( 'unleash_elements', 73680,
				{
					spend = 0.075,
					cast = 0,
					gcdType = 'spell',
					cooldown = 15
				} )

	AddAbility( 'unleash_flame', 165462,
				{
					spend = 0.075,
					cast = 0,
					gcdType = 'spell',
					cooldown = 15
				} )

	AddAbility( 'wind_shear', 57994,
				{
					spend = 0.094,
					cast = 0,
					gcdType = 'off',
					cooldown = 12
				} )

	AddAbility( 'windstrike', 115356,
				{
					known = function( s ) return s.spec.enhancement and s.buff.ascendance.up end,
					spend = 0.01,
					cast = 0,
					gcdType = 'melee',
					cooldown = 7.5,
					hostile = true
				} )

				
	function Hekili:SetClassModifiers()
	
		for k,v in pairs( self.Abilities ) do
			for key,mod in pairs( v.mods ) do
				self.Abilities[ k ].mods[ key ] = nil
			end
		end
		
		-- Enhancement
		if self.Specialization == 263 then
			Hekili.minGCD = 1.0
			
			ModifyAbility( 'ascendance', 'id', 165341 )

			ModifyAbility( 'ascendance', 'spend', function( x )
				return x * 0.25
			end )
			
			ModifyAbility( 'bloodlust', 'spend', function( x )
				return x * 0.25
			end )

			ModifyAbility( 'chain_lightning', 'cast', function( x )
				if buff.ancestral_swiftness.up then return 0 end
				if buff.maelstrom_weapon.up then x = ( x - ( x * ( 0.2 * buff.maelstrom_weapon.stack ) ) ) end
				return x * haste
			end )
			
			ModifyAbility( 'chain_lightning', 'spend', function( x )
				if buff.maelstrom_weapon.up then x = ( x - ( x * ( 0.2 * buff.maelstrom_weapon.stack ) ) ) end
				return x
			end )

			ModifyAbility( 'earth_elemental_totem', 'spend', function( x )
				return x * 0.25
			end )
			
			ModifyAbility( 'elemental_blast', 'cast', function( x )
				if buff.ancestral_swiftness.up then return 0 end
				if buff.maelstrom_weapon.up then x = ( x - ( x * ( 0.2 * buff.maelstrom_weapon.stack ) ) ) end
				return x * haste
			end )

			ModifyAbility( 'feral_spirit', 'cooldown', function( x )
				if glyph.ephemeral_spirits.enabled then x = x / 2 end
				return x
			end )

			ModifyAbility( 'feral_spirit', 'spend', function( x )
				return x * 0.25
			end )
			
			ModifyAbility( 'fire_nova', 'cooldown', function( x )
				if buff.echo_of_the_elements.up then return 0 end
				return x * haste
			end )

			ModifyAbility( 'fire_nova', 'spend', function( x )
				if spec.enhancement then return x * 0.25 end
				return x
			end )
			
			ModifyAbility( 'flame_shock', 'cooldown', function( x )
				return x * haste
			end )
			
			ModifyAbility( 'flame_shock', 'spend', function( x )
				return x * 0.10
			end )

			ModifyAbility( 'frost_shock', 'cooldown', function( x )
				if glyph.frost_shock.enabled then x = x - 2 end
				return x * haste
			end )
			
			ModifyAbility( 'frost_shock', 'spend', function( x )
				return x * 0.10
			end )
			
			ModifyAbility( 'healing_rain', 'cast', function( x )
				if buff.ancestral_swiftness.up then return 0 end
				if buff.maelstrom_weapon.up then x = ( x - ( x * ( 0.2 * buff.maelstrom_weapon.stack ) ) ) end
				return x * haste
			end )
			
			ModifyAbility( 'healing_rain', 'spend', function( x )
				if buff.maelstrom_weapon.up then x = ( x - ( x * ( 0.2 * buff.maelstrom_weapon.stack ) ) ) end
				return x
			end )

			ModifyAbility( 'healing_surge', 'cast', function( x )
				if buff.ancestral_swiftness.up then return 0 end
				if buff.maelstrom_weapon.up then x = ( x - ( x * ( 0.2 * buff.maelstrom_weapon.stack ) ) ) end
				return x * haste
			end )
			
			ModifyAbility( 'healing_surge', 'spend', function( x )
				if buff.maelstrom_weapon.up then x = ( x - ( x * ( 0.2 * buff.maelstrom_weapon.stack ) ) ) end
				return x
			end )

			ModifyAbility( 'heroism', 'spend', function( x )
				return x * 0.25
			end )

			ModifyAbility( 'lava_lash', 'cooldown', function( x )
				if buff.echo_of_the_elements.up then return 0 end
				return x * haste
			end )

			ModifyAbility( 'lightning_bolt', 'cast', 2.5 )

			ModifyAbility( 'lightning_bolt', 'cast', function( x )
				if buff.ancestral_swiftness.up then return 0 end
				if buff.maelstrom_weapon.up then x = ( x - ( x * ( 0.2 * buff.maelstrom_weapon.stack ) ) ) end
				return x * haste
			end )
			
			ModifyAbility( 'lightning_bolt', 'spend', function( x )
				if buff.maelstrom_weapon.up then x = ( x - ( x * ( 0.2 * buff.maelstrom_weapon.stack ) ) ) end
				return x
			end )

			ModifyAbility( 'magma_totem', 'spend', function( x )
				return x * 0.25
			end )

			ModifyAbility( 'searing_totem', 'spend', function( x )
				return x * 0.25
			end )			
			
			ModifyAbility( 'stormstrike', 'cooldown', function( x )
				if buff.echo_of_the_elements.up then return 0 end
				return x * haste
			end )
			
			ModifyAbility( 'unleash_elements', 'cooldown', function( x )
				return x * haste
			end )

			ModifyAbility( 'unleash_elements', 'spend', function( x )
				return x * 0.25
			end )
			
			ModifyAbility( 'wind_shear', 'spend', function( x )
				return x * 0.25
			end )
			
			ModifyAbility( 'windstrike', 'cooldown', function( x )
				if buff.echo_of_the_elements.up then return 0 end
				return x * haste
			end )

			ModifyAura( 'ascendance', 'id', 114051 )
			
			ModifyAura( 'lightning_shield', 'max_stack', 1 )

		-- Elemental
		elseif self.Specialization == 262 then
			Hekili.minGCD = 1.5

			ModifyAbility( 'ascendance', 'id', function( x )
				return 165339
			end )

			ModifyAbility( 'chain_lightning', 'cast', function( x )
				if buff.ancestral_swiftness.up then return 0 end
				return x * haste
			end )
			
			ModifyAbility( 'earthquake', 'cast', function( x )
				if buff.ancestral_swiftness.up then return 0 end
				return x * haste
			end )
			
			ModifyAbility( 'earthquake', 'cooldown',  function( x )
				if buff.echo_of_the_elements.up then return 0 end
				return x
			end )
	
			ModifyAbility( 'elemental_blast', 'cast', function( x )
				if buff.ancestral_swiftness.up then return 0 end
				return x * haste
			end )
	
			ModifyAbility( 'frost_shock', 'cooldown',  function( x )
				if buff.echo_of_the_elements.up then return 0 end
				if glyph.frost_shock.enabled then x = x - 2 end
				return x
			end )

			ModifyAbility( 'healing_rain', 'cast', function( x )
				if buff.ancestral_swiftness.up then return 0 end
				return x * haste
			end )

			ModifyAbility( 'healing_surge', 'cast', function( x )
				if buff.ancestral_swiftness.up then return 0 end
				return x * haste
			end )

			ModifyAbility( 'lava_burst', 'cast', function( x )
				if buff.lava_surge.up then return 0
				elseif buff.ancestral_swiftness.up then return 0 end
				return x * haste
			end )
			
			ModifyAbility( 'lava_burst', 'cooldown', function( x )
				if buff.lava_surge.up and cast_start > 0 and buff.lava_surge.applied > cast_start then return 0 end
				if buff.ascendance.up then return 0 end
				if buff.echo_of_the_elements.up then return 0 end
				return x
			end )
			
			ModifyAbility( 'lightning_bolt', 'cast', 2.0 )

			ModifyAbility( 'lightning_bolt', 'cast', function( x )
				if buff.ancestral_swiftness.up then return 0 end
				return x * haste
			end )
			
			ModifyAbility( 'spiritwalkers_grace', 'cooldown', function( x )
				if glyph.spiritwalkers_focus.enabled then x = x - 60 end
				return x
			end )
			
			ModifyAbility( 'thunderstorm', 'cooldown', function( x )
				if glyph.thunder.enabled then x = x - 10 end
				return x
			end )

			ModifyAura( 'ascendance', 'id', 114050 )

			ModifyAura( 'lightning_shield', 'max_stack', 15 )
			
			ModifyAura( 'lightning_shield', 'max_stack', function( x )
				if perk.improved_lightning_shield.enabled then x = 20 end
				return x
			end )

		end
		
		-- Shared
		ModifyAbility( 'fire_elemental_totem', 'cooldown', function( x )
			if glyph.fire_elemental_totem.enabled then x = x / 2 end
			return x
		end )
		
		ModifyAbility( 'fire_elemental_totem', 'spend', function( x )
			if spec.enhancement then return x * 0.25 end
			return x
		end )

	end
	

	-- All actions that modify the game state are included here.
	AddHandler( 'ancestral_swiftness', function ()
		H:Buff( 'ancestral_swiftness', 60 ) 
	end )


	AddHandler( 'ascendance', function ()
		H:Buff( 'ascendance', 15 )
		H:SetCooldown( 'lava_burst', 0 )
		H:SetCooldown( 'stormstrike', 0 )
		H:SetCooldown( 'windstrike', 0 )
		H:SetCooldown( 'strike', 0 )
	end )


	AddHandler( 'berserking', function ()
		H:Buff( 'berserking', 10 )
	end )

	AddHandler( 'blood_fury', function ()
		H:Buff( 'blood_fury', 15 )
	end )

	AddHandler( 'bloodlust', function ()
		H:Buff( 'bloodlust', 40 )
		H:Debuff( 'player', 'sated', 600 )
	end )

	AddHandler( 'chain_lightning', function ()
		if buff.maelstrom_weapon.stack == 5 then H:RemoveBuff( 'maelstrom_weapon' )
		elseif buff.ancestral_swiftness.up then H:RemoveBuff( 'ancestral_swiftness' )
		elseif buff.maelstrom_weapon.up then H:RemoveBuff( 'maelstrom_weapon' ) end
		
		if perk.enhanced_chain_lightning.enabled then
			H:Buff( 'improved_chain_lightning', 15, min( glyph.chain_lightning.enabled and 5 or 3, active_enemies) )
		end
		
		if buff.lightning_shield.up and buff.lightning_shield.stack < buff.lightning_shield.max_stack then
			H:AddStack( 'lightning_shield', 3600, min( glyph.chain_lightning.enabled and 5 or 3, active_enemies) )
		end
	end )

	AddHandler( 'earth_elemental_totem', function ()
		H:AddTotem( 'earth_elemental_totem', 'earth', 60 )

		if talent.storm_elemental_totem.enabled then H:SetCooldown( 'storm_elemental_totem', max( cooldown.storm_elemental_totem.remains, 61 ) ) end
		H:SetCooldown( 'fire_elemental_totem', max( cooldown.fire_elemental_totem.remains, 61 ) )
		-- Remove Fire Elemental Pet?  Reset Fire Elemental Totem?
	end )

	AddHandler( 'earth_shock', function ()
		local cooldown = spec.elemental == 1 and 5 or 6 * haste
		H:SetCooldown( 'flame_shock', cooldown )
		H:SetCooldown( 'frost_shock', cooldown )
		if buff.lightning_shield.stack > 1 then
			buff.lightning_shield.count = 1
		end
	end )

	AddHandler( 'earthquake', function ()
		H:RemoveBuff( 'echo_of_the_elements' )
		H:RemoveBuff( 'improved_chain_lightning' )
	end )
	
	AddHandler( 'elemental_blast', function ()
		H:Buff( 'elemental_blast', 8 )
	end )

	AddHandler( 'elemental_mastery', function ()
		H:Buff( 'elemental_mastery', 20 )
	end )

	
	AddHandler( 'fire_elemental_totem', function ()
		if glyph.fire_elemental_totem.enabled then
			H:AddTotem( 'fire_elemental_totem', 'fire', 30 )
		else	
			H:AddTotem( 'fire_elemental_totem', 'fire', 60 )
		end
		
		if talent.storm_elemental_totem.enabled then H:SetCooldown( 'storm_elemental_totem', max( cooldown.storm_elemental_totem.remains, 61 ) ) end
		H:SetCooldown( 'earth_elemental_totem', max( cooldown.storm_elemental_totem.remains, 61 ) )
		-- Remove Earth Elemental Pet?  Reset Earth Elemental Totem?
	end )

	AddHandler( 'fire_nova', function ()
		H:RemoveBuff( 'unleash_flame' )
		H:RemoveBuff( 'echo_of_the_elements' )
	end )

	AddHandler( 'flame_shock', function ()
		local cooldown = spec.elemental == 1 and 5 or 6 * haste
		H:Debuff( 'target', 'flame_shock', 30 )
		H:RemoveBuff( 'unleash_flame' )
		H:RemoveBuff( 'elemental_fusion' )
		H:SetCooldown( 'earth_shock', cooldown )
		H:SetCooldown( 'frost_shock', cooldown )
	end )

	AddHandler( 'flametongue_weapon', function ()
		H:Buff( 'flametongue_weapon', 3600 )
	end )

	AddHandler( 'frost_shock', function()
		local cooldown = 6
		
		if glyph.frost_shock.enabled then cooldown = cooldown - 2 end
		if spec.enhancement then cooldown = cooldown * haste end
		
		H:RemoveBuff( 'elemental_fusion' )
		H:Debuff( 'target', 'frost_shock', 8 )
		H:SetCooldown( 'earth_shock', cooldown )
		H:SetCooldown( 'flame_shock', cooldown )
	end )

	AddHandler( 'healing_rain', function ()
		if buff.ancestral_swiftness.up then H:RemoveBuff( 'ancestral_swiftness' )
		elseif buff.maelstrom_weapon.up then H:RemoveBuff( 'maelstrom_weapon' ) end
		H:Buff( 'healing_rain', 10 )
	end )
	
	AddHandler( 'healing_surge', function ()
		if buff.ancestral_swiftness.up then H:RemoveBuff( 'ancestral_swiftness' )
		elseif buff.maelstrom_weapon.up then H:RemoveBuff( 'maelstrom_weapon' ) end
	end )

	AddHandler( 'heroism', Hekili.Abilities[ 'bloodlust' ].handler )

	AddHandler( 'lifeblood', function ()
		H:Buff( 'lifeblood', 20 )
	end )

	AddHandler( 'lava_beam', Hekili.Abilities[ 'chain_lightning' ].handler )
	
	AddHandler( 'lava_burst', function ()
		if buff.lava_surge.up and ( cast_start == 0 or buff.lava_surge.applied < cast_start ) then H:RemoveBuff( 'lava_surge' ) end
		if buff.echo_of_the_elements.up then H:RemoveBuff( 'echo_of_the_elements' ) end
		if spec.elemental and buff.lightning_shield.up then H:AddStack( 'lightning_shield', 3600, 1 ) end
	end )
	
	AddHandler( 'lava_lash', function ()
		H:RemoveBuff( 'echo_of_the_elements' )
		if talent.elemental_fusion.enabled then
			H:Buff( 'elemental_fusion', 20, max(2, buff.elemental_fusion.stack + 1) )
		end
	end )

	AddHandler( 'lightning_bolt', function ()
		if buff.maelstrom_weapon.stack == 5 then H:RemoveBuff( 'maelstrom_weapon' )
		elseif buff.ancestral_swiftness.up then H:RemoveBuff( 'ancestral_swiftness' )
		elseif buff.maelstrom_weapon.up then H:RemoveBuff( 'maelstrom_weapon' ) end
		
		if buff.lightning_shield.up and buff.lightning_shield.stack < buff.lightning_shield.max_stack then
			H:AddStack( 'lightning_shield', 3600, 1 )
		end
	end )

	AddHandler( 'lightning_shield', function ()
		H:Buff( 'lightning_shield', 3600 )
	end )

	AddHandler( 'magma_totem', function ()
		H:AddTotem( 'magma_totem', 'fire', 60 )
	end )

	AddHandler( 'searing_totem', function ()
		H:AddTotem( 'searing_totem', 'fire', 60 )
	end )

	AddHandler( 'spiritwalkers_grace', function ()
		if glyph.spiritwalkers_focus.enabled then H:Buff( 'spiritwalkers_grace', 1, 8 )
		elseif glyph.spiritwalkers_focus.enabled then H:Buff( 'spiritwalkers_grace', 1, 20 )
		else H:Buff( 'spiritwalkers_grace', 1, 15 ) end
	end )

	AddHandler( 'storm_elemental_totem', function ()
		H:AddTotem( 'storm_elemental_totem', 'air', 60 )
		H:SetCooldown( 'fire_elemental_totem', max( cooldown.fire_elemental_totem.remains, 61 ) )
		H:SetCooldown( 'earth_elemental_totem', max( cooldown.earth_elemental_totem.remains, 61 ) )
	end )

	AddHandler( 'stormstrike', function ()
		if buff.echo_of_the_elements.up then
			H:RemoveBuff( 'echo_of_the_elements' )
		else
			H:SetCooldown( 'strike', 7.5 * haste )
		end
		if set_bonus.tier17_2pc ~= 0 and cooldown.feral_spirit.remains > 0 then
			H:SetCooldown( 'feral_spirit', max(0, cooldown.feral_spirit.remains - 5) )
		end
		H:Debuff( 'target', 'stormstrike', 8 )
		if set_bonus.tier15_2pc_melee ~= 0 then H:AddStack( 'maelstrom_weapon', 30, 2 ) end
	end )

	AddHandler( 'synapse_springs', function ()
		H:Buff( 'synapse_springs', 10 )
	end )
	
	AddHandler( 'thunderstorm', function ()
		H:Debuff( 'target', 'thunderstorm', 5 )
	end )

	AddHandler( 'unleash_elements', function ()
		H:Buff( 'unleash_wind', 12, 6 )
		H:Buff( 'unleash_flame', 8 )
	end )
	
	AddHandler( 'unleash_flame', function ()
		H:Buff( 'unleash_flame', 20 )
	end )

	AddHandler( 'virmens_bite', function ()
		H:Buff( 'virmens_bite', 25 )
	end )

	AddHandler( 'wind_shear', function ()
		H:Interrupt( 'target' )
	end )

	AddHandler( 'windstrike', function ()
		if buff.echo_of_the_elements.up then
			H:RemoveBuff( 'echo_of_the_elements' )
		else
			H:SetCooldown( 'strike', 7.5 * haste )
			H:SetCooldown( 'stormstrike', 7.5 * haste )
		end
		H:Debuff( 'target', 'stormstrike', 8 )
		if set_bonus.tier15_2pc_melee ~= 0 then H:AddStack( 'maelstrom_weapon', 30, 2 ) end
	end )
	
	
	
	-- Import strings
	Hekili.Default( "@Enhancement, Single Target", "actionLists", 2.05, "^1^T^SEnabled^B^SActions^T^N1^T^SEnabled^B^SAbility^Sliquid_magma^SScript^Stotem.fire.remains>=15^SName^SLiquid~`Magma^t^N2^T^SEnabled^B^SAbility^Ssearing_totem^SScript^S!totem.fire.active^SName^SSearing~`Totem^t^N3^T^SEnabled^B^SAbility^Sancestral_swiftness^SScript^S^SName^SAncestral~`Swiftness^t^N4^T^SEnabled^B^SAbility^Sunleash_elements^SScript^S(talent.unleashed_fury.enabled|set_bonus.tier16_2pc_melee=1)^SName^SUnleash~`Elements^t^N5^T^SEnabled^B^SAbility^Selemental_blast^SScript^Sbuff.maelstrom_weapon.react>=1^SName^SElemental~`Blast^t^N6^T^SEnabled^B^SAbility^Slightning_bolt^SScript^Sbuff.maelstrom_weapon.react=5|(buff.maelstrom_weapon.react>=4&!buff.ascendance.up)|(buff.ancestral_swiftness.up&buff.maelstrom_weapon.react>=3)^SName^SLightning~`Bolt^t^N7^T^SEnabled^B^SName^SWindstrike^SAbility^Swindstrike^t^N8^T^SEnabled^B^SName^SStormstrike^SAbility^Sstormstrike^t^N9^T^SEnabled^B^SName^SLava~`Lash^SAbility^Slava_lash^t^N10^T^SEnabled^B^SAbility^Sflame_shock^SScript^S(talent.elemental_fusion.enabled&buff.elemental_fusion.stack=2&buff.unleash_flame.up&dot.flame_shock.remains<16)|(!talent.elemental_fusion.enabled&buff.unleash_flame.up&dot.flame_shock.remains<=9)|!ticking^SName^SFlame~`Shock^t^N11^T^SEnabled^B^SName^SUnleash~`Elements~`(1)^SAbility^Sunleash_elements^t^N12^T^SEnabled^B^SAbility^Sfrost_shock^SScript^S(talent.elemental_fusion.enabled&dot.flame_shock.remains>=16)|!talent.elemental_fusion.enabled^SName^SFrost~`Shock^t^N13^T^SEnabled^B^SAbility^Slightning_bolt^SScript^Sbuff.maelstrom_weapon.react>=1&!buff.ascendance.up^SName^SLightning~`Bolt~`(1)^t^N14^T^SEnabled^B^SAbility^Ssearing_totem^SScript^Stotem.fire.remains<=20&!pet.fire_elemental_totem.active&!buff.liquid_magma.up^SName^SSearing~`Totem~`(1)^t^t^SName^S@Enhancement,~`Single~`Target^SSpecialization^N263^t^^" )
	
	Hekili.Default( "@Enhancement, 2 Cleave", "actionLists", 2.06,"^1^T^SEnabled^B^SSpecialization^N263^SRelease^N2.05^SActions^T^N1^T^SAbility^Sliquid_magma^SName^SLiquid~`Magma^SScript^Stotem.fire.remains>=15^SEnabled^B^t^N2^T^SAbility^Smagma_totem^SName^SMagma~`Totem^SScript^S!totem.fire.active&(target.within5|talent.totemic_projection.enabled)^SEnabled^B^t^N3^T^SEnabled^B^SName^SSearing~`Totem^SRelease^N2.05^SScript^S!totem.fire.up&target.outside5^SAbility^Ssearing_totem^t^N4^T^SAbility^Sancestral_swiftness^SName^SAncestral~`Swiftness^SScript^S^SEnabled^B^t^N5^T^SAbility^Sunleash_elements^SName^SUnleash~`Elements^SScript^S(talent.unleashed_fury.enabled|set_bonus.tier16_2pc_melee=1)^SEnabled^B^t^N6^T^SAbility^Selemental_blast^SName^SElemental~`Blast^SScript^Sbuff.maelstrom_weapon.react>=1^SEnabled^B^t^N7^T^SEnabled^B^SName^SChain~`Lightning^SAbility^Schain_lightning^SScript^S!glyph.chain_lightning.enabled&(buff.maelstrom_weapon.react=5|(buff.maelstrom_weapon.react>=4&!buff.ascendance.up)|(buff.ancestral_swiftness.up&buff.maelstrom_weapon.react>=3))^SCaption^S!Glyph^t^N8^T^SAbility^Slightning_bolt^SName^SLightning~`Bolt^SScript^Sbuff.maelstrom_weapon.react=5|(buff.maelstrom_weapon.react>=4&!buff.ascendance.up)|(buff.ancestral_swiftness.up&buff.maelstrom_weapon.react>=3)^SEnabled^B^t^N9^T^SEnabled^B^SName^SWindstrike^SAbility^Swindstrike^t^N10^T^SEnabled^B^SName^SStormstrike^SAbility^Sstormstrike^t^N11^T^SEnabled^B^SName^SLava~`Lash^SAbility^Slava_lash^t^N12^T^SAbility^Sflame_shock^SName^SFlame~`Shock^SScript^S(talent.elemental_fusion.enabled&buff.elemental_fusion.stack=2&buff.unleash_flame.up&dot.flame_shock.remains<16)|(!talent.elemental_fusion.enabled&buff.unleash_flame.up&dot.flame_shock.remains<=9)|!ticking^SEnabled^B^t^N13^T^SEnabled^B^SName^SUnleash~`Elements~`(1)^SAbility^Sunleash_elements^t^N14^T^SEnabled^B^SName^SFire~`Nova^SScript^Sactive_dot.flame_shock>=2&!((talent.elemental_fusion.enabled&buff.elemental_fusion.stack=2&buff.unleash_flame.up&dot.flame_shock.remains<16)|(!talent.elemental_fusion.enabled&buff.unleash_flame.up&dot.flame_shock.remains<=9))^SAbility^Sfire_nova^t^N15^T^SAbility^Sfrost_shock^SName^SFrost~`Shock^SScript^S(talent.elemental_fusion.enabled&dot.flame_shock.remains>=16)|!talent.elemental_fusion.enabled^SEnabled^B^t^N16^T^SEnabled^B^SName^SChain~`Lightning~`(1)^SAbility^Schain_lightning^SScript^S!glyph.chain_lightning.enabled&(buff.maelstrom_weapon.react>=1&!buff.ascendance.up)^SCaption^S!Glyph^t^N17^T^SAbility^Slightning_bolt^SName^SLightning~`Bolt~`(1)^SScript^Sbuff.maelstrom_weapon.react>=1&!buff.ascendance.up^SEnabled^B^t^N18^T^SEnabled^B^SScript^S(target.within5|talent.totemic_projection.enabled)&totem.fire.remains<=20&!pet.fire_elemental_totem.active&!buff.liquid_magma.up^SRelease^N2.05^SAbility^Smagma_totem^SName^SMagma~`Totem~`(1)^t^N19^T^SAbility^Ssearing_totem^SName^SSearing~`Totem~`(1)^SScript^Stotem.fire.remains<=20&!pet.fire_elemental_totem.active&!buff.liquid_magma.up^SEnabled^B^t^t^SName^S@Enhancement,~`2~`Cleave^t^^" )
	
	Hekili.Default( "@Enhancement, 3 Cleave", "actionLists",  2.06,"^1^T^SEnabled^B^SSpecialization^N263^SRelease^N2.05^SActions^T^N1^T^SEnabled^B^SScript^Stotem.fire.remains>=15^SName^SLiquid~`Magma^SAbility^Sliquid_magma^t^N2^T^SEnabled^B^SScript^S!totem.fire.active&(target.within5|talent.totemic_projection.enabled)^SName^SMagma~`Totem^SAbility^Smagma_totem^t^N3^T^SEnabled^B^SScript^S!totem.fire.active^SRelease^N2.05^SName^SSearing~`Totem^SAbility^Ssearing_totem^t^N4^T^SEnabled^B^SScript^S^SName^SAncestral~`Swiftness^SAbility^Sancestral_swiftness^t^N5^T^SEnabled^B^SScript^S(talent.unleashed_fury.enabled|set_bonus.tier16_2pc_melee=1)^SName^SUnleash~`Elements^SAbility^Sunleash_elements^t^N6^T^SEnabled^B^SScript^Sbuff.maelstrom_weapon.react>=1^SName^SElemental~`Blast^SAbility^Selemental_blast^t^N7^T^SEnabled^B^SName^SChain~`Lightning^SAbility^Schain_lightning^SScript^Sbuff.maelstrom_weapon.react=5|(buff.maelstrom_weapon.react>=4&!buff.ascendance.up)|(buff.ancestral_swiftness.up&buff.maelstrom_weapon.react>=3)^SCaption^S^t^N8^T^SEnabled^B^SName^SWindstrike^SAbility^Swindstrike^t^N9^T^SEnabled^B^SName^SFire~`Nova^SScript^Sactive_dot.flame_shock>=3&!((talent.elemental_fusion.enabled&buff.elemental_fusion.stack=2&buff.unleash_flame.up&dot.flame_shock.remains<16)|(!talent.elemental_fusion.enabled&buff.unleash_flame.up&dot.flame_shock.remains<=9))^SAbility^Sfire_nova^t^N10^T^SEnabled^B^SName^SStormstrike^SAbility^Sstormstrike^t^N11^T^SEnabled^B^SName^SLava~`Lash^SAbility^Slava_lash^t^N12^T^SEnabled^B^SScript^S(talent.elemental_fusion.enabled&buff.elemental_fusion.stack=2&buff.unleash_flame.up&dot.flame_shock.remains<16)|(!talent.elemental_fusion.enabled&buff.unleash_flame.up&dot.flame_shock.remains<=9)|!ticking^SName^SFlame~`Shock^SAbility^Sflame_shock^t^N13^T^SEnabled^B^SName^SUnleash~`Elements~`(1)^SAbility^Sunleash_elements^t^N14^T^SEnabled^B^SScript^S(talent.elemental_fusion.enabled&dot.flame_shock.remains>=16)|!talent.elemental_fusion.enabled^SName^SFrost~`Shock^SAbility^Sfrost_shock^t^N15^T^SEnabled^B^SName^SChain~`Lightning~`(1)^SAbility^Schain_lightning^SScript^Sbuff.maelstrom_weapon.react>=1&!buff.ascendance.up^SCaption^S^t^N16^T^SEnabled^B^SScript^S(target.within5|talent.totemic_projection.enabled)&totem.fire.remains<=20&!pet.fire_elemental_totem.active&!buff.liquid_magma.up^SRelease^N2.05^SName^SMagma~`Totem~`(1)^SAbility^Smagma_totem^t^N17^T^SEnabled^B^SScript^Stotem.fire.remains<=20&!pet.fire_elemental_totem.active&!buff.liquid_magma.up^SName^SSearing~`Totem~`(1)^SAbility^Ssearing_totem^t^t^SName^S@Enhancement,~`3~`Cleave^t^^" )
	
	Hekili.Default( "@Enhancement, 4 Cleave", "actionLists",  2.06,"^1^T^SEnabled^B^SName^S@Enhancement,~`4~`Cleave^SRelease^N2.05^SActions^T^N1^T^SAbility^Sliquid_magma^SName^SLiquid~`Magma^SScript^Stotem.fire.remains>=15^SEnabled^B^t^N2^T^SAbility^Smagma_totem^SName^SMagma~`Totem^SScript^S!totem.fire.active&(target.within5|talent.totemic_projection.enabled)^SEnabled^B^t^N3^T^SEnabled^B^SScript^S!totem.fire.active^SRelease^N2.05^SName^SSearing~`Totem^SAbility^Ssearing_totem^t^N4^T^SAbility^Sancestral_swiftness^SName^SAncestral~`Swiftness^SScript^S^SEnabled^B^t^N5^T^SEnabled^B^SName^SFire~`Nova^SScript^Sactive_dot.flame_shock>=4&!((talent.elemental_fusion.enabled&buff.elemental_fusion.stack=2&buff.unleash_flame.up&dot.flame_shock.remains<16)|(!talent.elemental_fusion.enabled&buff.unleash_flame.up&dot.flame_shock.remains<=9))^SAbility^Sfire_nova^t^N6^T^SAbility^Sunleash_elements^SName^SUnleash~`Elements^SScript^S(talent.unleashed_fury.enabled|set_bonus.tier16_2pc_melee=1)^SEnabled^B^t^N7^T^SAbility^Selemental_blast^SName^SElemental~`Blast^SScript^Sbuff.maelstrom_weapon.react>=1^SEnabled^B^t^N8^T^SEnabled^B^SName^SChain~`Lightning^SAbility^Schain_lightning^SScript^Sbuff.maelstrom_weapon.react=5|(buff.maelstrom_weapon.react>=4&!buff.ascendance.up)|(buff.ancestral_swiftness.up&buff.maelstrom_weapon.react>=3)^SCaption^S^t^N9^T^SEnabled^B^SName^SWindstrike^SAbility^Swindstrike^t^N10^T^SEnabled^B^SName^SStormstrike^SAbility^Sstormstrike^t^N11^T^SEnabled^B^SName^SLava~`Lash^SAbility^Slava_lash^t^N12^T^SAbility^Sflame_shock^SName^SFlame~`Shock^SScript^S(talent.elemental_fusion.enabled&buff.elemental_fusion.stack=2&buff.unleash_flame.up&dot.flame_shock.remains<16)|(!talent.elemental_fusion.enabled&buff.unleash_flame.up&dot.flame_shock.remains<=9)|!ticking^SEnabled^B^t^N13^T^SEnabled^B^SName^SUnleash~`Elements~`(1)^SAbility^Sunleash_elements^t^N14^T^SAbility^Sfrost_shock^SName^SFrost~`Shock^SScript^S(talent.elemental_fusion.enabled&dot.flame_shock.remains>=16)|!talent.elemental_fusion.enabled^SEnabled^B^t^N15^T^SEnabled^B^SName^SChain~`Lightning~`(1)^SAbility^Schain_lightning^SScript^Sbuff.maelstrom_weapon.react>=1&!buff.ascendance.up^SCaption^S^t^N16^T^SEnabled^B^SName^SMagma~`Totem~`(1)^SRelease^N2.05^SAbility^Smagma_totem^SScript^S(target.within5|talent.totemic_projection.enabled)&totem.fire.remains<=20&!pet.fire_elemental_totem.active&!buff.liquid_magma.up^t^N17^T^SAbility^Ssearing_totem^SName^SSearing~`Totem~`(1)^SScript^Stotem.fire.remains<=20&!pet.fire_elemental_totem.active&!buff.liquid_magma.up^SEnabled^B^t^t^SSpecialization^N263^t^^" )
	
	Hekili.Default( "@Enhancement, AOE", 'actionLists',  2.07,"^1^T^SEnabled^B^SSpecialization^N263^SRelease^N2.06^SActions^T^N1^T^SEnabled^B^SAbility^Sliquid_magma^SScript^Spet.searing_totem.remains>=15|pet.magma_totem.remains>=15|pet.fire_elemental_totem.remains>=15^SName^SLiquid~`Magma^t^N2^T^SEnabled^B^SName^SAncestral~`Swiftness^SAbility^Sancestral_swiftness^t^N3^T^SEnabled^B^SAbility^Sunleash_elements^SScript^Sactive_enemies>=4&dot.flame_shock.ticking&(cooldown.shock.remains>cooldown.fire_nova.remains|cooldown.fire_nova.remains=0)^SName^SUnleash~`Elements^t^N4^T^SEnabled^B^SAbility^Sfire_nova^SScript^Sactive_dot.flame_shock>=3^SName^SFire~`Nova^t^N5^T^SEnabled^B^SName^SWait^SArgs^Ssec=cooldown.fire_nova.remains^SAbility^Swait^SScript^Sactive_dot.flame_shock>=4&cooldown.fire_nova.remains<=action.fire_nova.gcd^t^N6^T^SEnabled^B^SAbility^Smagma_totem^SScript^S!totem.fire.active^SName^SMagma~`Totem^t^N7^T^SEnabled^B^SAbility^Slava_lash^SScript^Sdot.flame_shock.ticking&(active_dot.flame_shock<active_enemies|!talent.echo_of_the_elements.enabled|!buff.echo_of_the_elements.up)^SName^SLava~`Lash^t^N8^T^SEnabled^B^SAbility^Selemental_blast^SScript^S!buff.unleash_flame.up&(buff.maelstrom_weapon.react>=4|buff.ancestral_swiftness.up)^SName^SElemental~`Blast^t^N9^T^SEnabled^B^SAbility^Schain_lightning^SScript^Sglyph.chain_lightning.enabled&active_enemies>=4&(buff.maelstrom_weapon.react=5|(buff.ancestral_swiftness.up&buff.maelstrom_weapon.react>=3))^SName^SChain~`Lightning^t^N10^T^SEnabled^B^SAbility^Sunleash_elements^SScript^Sactive_enemies<4^SName^SUnleash~`Elements~`(1)^t^N11^T^SEnabled^B^SName^SFlame~`Shock^SArgs^Scycle_targets=1^SAbility^Sflame_shock^SScript^S!ticking^t^N12^T^SEnabled^B^SScript^S(glyph.chain_lightning.enabled&active_enemies<3)&(buff.maelstrom_weapon.react=5|(buff.ancestral_swiftness.up&buff.maelstrom_weapon.react>=3))^SAbility^Slightning_bolt^SCaption^S2^SName^SLightning~`Bolt^t^N13^T^SEnabled^B^SName^SWindstrike^SAbility^Swindstrike^t^N14^T^SEnabled^B^SAbility^Selemental_blast^SScript^S!buff.unleash_flame.up&buff.maelstrom_weapon.react>=1^SName^SElemental~`Blast~`(1)^t^N15^T^SEnabled^B^SAbility^Schain_lightning^SScript^Sglyph.chain_lightning.enabled&active_enemies>=4&buff.maelstrom_weapon.react>=1^SName^SChain~`Lightning~`(1)^t^N16^T^SEnabled^B^SAbility^Sfire_nova^SScript^Sactive_dot.flame_shock>=2^SName^SFire~`Nova~`(1)^t^N17^T^SEnabled^B^SAbility^Smagma_totem^SScript^Stotem.fire.remains<=20&!pet.fire_elemental_totem.active&!buff.liquid_magma.up^SName^SMagma~`Totem~`(1)^t^N18^T^SEnabled^B^SName^SStormstrike^SAbility^Sstormstrike^t^N19^T^SEnabled^B^SAbility^Sfrost_shock^SScript^Sactive_enemies<4^SName^SFrost~`Shock^t^N20^T^SEnabled^B^SAbility^Selemental_blast^SScript^Sbuff.maelstrom_weapon.react>=1^SName^SElemental~`Blast~`(2)^t^N21^T^SEnabled^B^SAbility^Schain_lightning^SScript^Sactive_enemies>=3&buff.maelstrom_weapon.react>=1^SName^SChain~`Lightning~`(2)^t^N22^T^SEnabled^B^SAbility^Slightning_bolt^SScript^Sactive_enemies<3&buff.maelstrom_weapon.react>=1^SName^SLightning~`Bolt~`(1)^t^N23^T^SEnabled^B^SAbility^Sfire_nova^SScript^Sactive_dot.flame_shock>=1^SName^SFire~`Nova~`(2)^t^t^SName^S@Enhancement,~`AOE^t^^" )
	
	Hekili.Default( "@Enhancement, Cooldowns", 'actionLists',  2.06,"^1^T^SEnabled^B^SSpecialization^N263^SRelease^N2.06^SActions^T^N1^T^SAbility^Sbloodlust^SName^SBloodlust^SScript^Starget.health_pct<25|time>0.500^SEnabled^b^t^N2^T^SEnabled^b^SAbility^Sheroism^SName^SHeroism^SScript^Starget.health_pct<25|time>0.500^t^N3^T^SEnabled^B^SName^SBlood~`Fury^SAbility^Sblood_fury^t^N4^T^SEnabled^B^SName^SBerserking^SAbility^Sberserking^t^N5^T^SEnabled^B^SName^SElemental~`Mastery^SAbility^Selemental_mastery^t^N6^T^SEnabled^B^SName^SStorm~`Elemental~`Totem^SAbility^Sstorm_elemental_totem^t^N7^T^SEnabled^B^SName^SFire~`Elemental~`Totem^SAbility^Sfire_elemental_totem^t^N8^T^SAbility^Sascendance^SName^SAscendance^SScript^S^SEnabled^B^t^N9^T^SEnabled^B^SName^SFeral~`Spirit^SAbility^Sferal_spirit^t^t^SName^S@Enhancement,~`Cooldowns^t^^" )
	
	Hekili.Default( "@Shaman, Interrupt", 'actionLists', 2.06, "^1^T^SEnabled^B^SScript^S^SSpecialization^N0^SActions^T^N1^T^SEnabled^B^SName^SWind~`Shear^SAbility^Swind_shear^SCaption^SShear^SScript^Starget.casting^t^t^SName^S@Shaman,~`Interrupt^t^^" )
	
	Hekili.Default( "@Shaman, Buffs", 'actionLists', 2.05, "^1^T^SEnabled^B^SActions^T^N1^T^SEnabled^B^SAbility^Slightning_shield^SScript^S!buff.lightning_shield.up^SName^SLightning~`Shield^t^t^SName^S@Shaman,~`Buffs^SSpecialization^N0^t^^" )
	
	Hekili.Default( "@Elemental, Single Target", "actionLists", 2.06, "^1^T^SEnabled^B^SSpecialization^N262^SRelease^N2.05^SScript^S^SActions^T^N1^T^SEnabled^B^SScript^Stime=0&(!talent.liquid_magma.enabled&!totem.fire.active)|(talent.liquid_magma.enabled&pet.searing_totem.remains<=20&!pet.fire_elemental_totem.active&!buff.liquid_magma.up)^SRelease^N2.06^SName^SSearing~`Totem~`(0)^SAbility^Ssearing_totem^t^N2^T^SEnabled^B^SScript^S!buff.ascendance.up^SName^SAncestral~`Swiftness^SAbility^Sancestral_swiftness^t^N3^T^SEnabled^B^SScript^Spet.searing_totem.remains>=15|pet.fire_elemental_totem.remains>=15^SName^SLiquid~`Magma^SAbility^Sliquid_magma^t^N4^T^SEnabled^B^SScript^Stalent.unleashed_fury.enabled&!buff.ascendance.up^SName^SUnleash~`Flame^SAbility^Sunleash_flame^t^N5^T^SEnabled^B^SName^SSpiritwalker's~`Grace^SArgs^Smoving=1^SAbility^Sspiritwalkers_grace^SScript^Smoving&buff.ascendance.up^t^N6^T^SEnabled^B^SScript^Sbuff.lightning_shield.react=buff.lightning_shield.max_stack^SName^SEarth~`Shock^SAbility^Searth_shock^t^N7^T^SEnabled^B^SScript^Sdot.flame_shock.remains>cast_time&(buff.ascendance.up|cooldown_up)^SName^SLava~`Burst^SAbility^Slava_burst^t^N8^T^SEnabled^B^SScript^Sdot.flame_shock.remains<=9^SName^SFlame~`Shock^SAbility^Sflame_shock^t^N9^T^SEnabled^B^SScript^S(set_bonus.tier17_4pc&buff.lightning_shield.react>=15&!buff.lava_surge.up)|(!set_bonus.tier17_4pc&buff.lightning_shield.react>15)^SName^SEarth~`Shock~`(1)^SAbility^Searth_shock^t^N10^T^SEnabled^B^SScript^S!talent.unleashed_fury.enabled&((1+stat.spell_haste)*(1+(mastery_value*2%4.5))>=(1.875+(1.25*0.226305)+1.25*(2*0.226305*stat.multistrike_pct%100)))&target.time_to_die>10&buff.elemental_mastery.down&buff.bloodlust.down^SName^SEarthquake^SAbility^Searthquake^t^N11^T^SEnabled^B^SScript^S!talent.unleashed_fury.enabled&((1+stat.spell_haste)*(1+(mastery_value*2%4.5))>=1.3*(1.875+(1.25*0.226305)+1.25*(2*0.226305*stat.multistrike_pct%100)))&target.time_to_die>10&(buff.elemental_mastery.up|buff.bloodlust.up)^SName^SEarthquake~`(1)^SAbility^Searthquake^t^N12^T^SEnabled^B^SScript^S!talent.unleashed_fury.enabled&((1+stat.spell_haste)*(1+(mastery_value*2%4.5))>=(1.875+(1.25*0.226305)+1.25*(2*0.226305*stat.multistrike_pct%100)))&target.time_to_die>10&(buff.elemental_mastery.remains>=10|buff.bloodlust.remains>=10)^SName^SEarthquake~`(2)^SAbility^Searthquake^t^N13^T^SEnabled^B^SScript^Stalent.unleashed_fury.enabled&((1+stat.spell_haste)*(1+(mastery_value*2%4.5))>=((1.3*1.875)+(1.25*0.226305)+1.25*(2*0.226305*stat.multistrike_pct%100)))&target.time_to_die>10&buff.elemental_mastery.down&buff.bloodlust.down^SName^SEarthquake~`(3)^SAbility^Searthquake^t^N14^T^SEnabled^B^SScript^Stalent.unleashed_fury.enabled&((1+stat.spell_haste)*(1+(mastery_value*2%4.5))>=1.3*((1.3*1.875)+(1.25*0.226305)+1.25*(2*0.226305*stat.multistrike_pct%100)))&target.time_to_die>10&(buff.elemental_mastery.up|buff.bloodlust.up)^SName^SEarthquake~`(4)^SAbility^Searthquake^t^N15^T^SEnabled^B^SScript^Stalent.unleashed_fury.enabled&((1+stat.spell_haste)*(1+(mastery_value*2%4.5))>=((1.3*1.875)+(1.25*0.226305)+1.25*(2*0.226305*stat.multistrike_pct%100)))&target.time_to_die>10&(buff.elemental_mastery.remains>=10|buff.bloodlust.remains>=10)^SName^SEarthquake~`(5)^SAbility^Searthquake^t^N16^T^SEnabled^B^SName^SElemental~`Blast^SAbility^Selemental_blast^t^N17^T^SEnabled^B^SScript^Stime>60&remains<=buff.ascendance.duration&cooldown.ascendance.remains+buff.ascendance.duration<duration^SName^SFlame~`Shock~`(1)^SAbility^Sflame_shock^t^N18^T^SEnabled^B^SScript^S(!talent.liquid_magma.enabled&!totem.fire.active)|(talent.liquid_magma.enabled&pet.searing_totem.remains<=20&!pet.fire_elemental_totem.active&!buff.liquid_magma.up)^SName^SSearing~`Totem^SAbility^Ssearing_totem^t^N19^T^SEnabled^B^SName^SSpiritwalker's~`Grace~`(1)^SArgs^Smoving=1^SAbility^Sspiritwalkers_grace^SScript^Smoving&((talent.elemental_blast.enabled&cooldown.elemental_blast.remains=0)|(cooldown.lava_burst.remains=0&!buff.lava_surge.up))^t^N20^T^SEnabled^B^SName^SLightning~`Bolt^SAbility^Slightning_bolt^t^t^SName^S@Elemental,~`Single~`Target^t^^" )
	
	Hekili.Default( "@Elemental, 2-4 Cleave", "actionLists", 2.11, "^1^T^SEnabled^B^SSpecialization^N262^SRelease^N2.05^SName^S@Elemental,~`2-4~`Cleave^SActions^T^N1^T^SEnabled^B^SScript^Stime=0&(!talent.liquid_magma.enabled&!totem.fire.active)|(talent.liquid_magma.enabled&pet.searing_totem.remains<=20&!pet.fire_elemental_totem.active&!buff.liquid_magma.up)^SRelease^N2.06^SAbility^Ssearing_totem^SName^SSearing~`Totem~`(0)^t^N2^T^SEnabled^B^SAbility^Sancestral_swiftness^SName^SAncestral~`Swiftness^SScript^S!buff.ascendance.up^t^N3^T^SEnabled^B^SAbility^Sliquid_magma^SName^SLiquid~`Magma^SScript^Spet.searing_totem.remains>=15|pet.fire_elemental_totem.remains>=15^t^N4^T^SEnabled^B^SName^SEarthquake^SRelease^N2.06^SAbility^Searthquake^SScript^S(buff.improved_chain_lightning.up|!perk.enhanced_chain_lightning.enabled)&active_enemies>=2^t^N5^T^SEnabled^B^SAbility^Sunleash_flame^SName^SUnleash~`Flame^SScript^Stalent.unleashed_fury.enabled&!buff.ascendance.up^t^N6^T^SEnabled^B^SName^SSpiritwalker's~`Grace^SArgs^Smoving=1^SAbility^Sspiritwalkers_grace^SScript^Smoving&buff.ascendance.up^t^N7^T^SEnabled^B^SAbility^Searth_shock^SName^SEarth~`Shock^SScript^Sbuff.lightning_shield.react=buff.lightning_shield.max_stack^t^N8^T^SEnabled^B^SAbility^Slava_burst^SName^SLava~`Burst^SScript^Sdot.flame_shock.remains>cast_time&(buff.ascendance.up|cooldown_up)^t^N9^T^SEnabled^B^SAbility^Sflame_shock^SName^SFlame~`Shock^SScript^Sdot.flame_shock.remains<=9^t^N10^T^SEnabled^B^SAbility^Searth_shock^SName^SEarth~`Shock~`(1)^SScript^S(set_bonus.tier17_4pc&buff.lightning_shield.react>=15&!buff.lava_surge.up)|(!set_bonus.tier17_4pc&buff.lightning_shield.react>15)^t^N11^T^SEnabled^B^SName^SElemental~`Blast^SAbility^Selemental_blast^t^N12^T^SEnabled^B^SAbility^Sflame_shock^SName^SFlame~`Shock~`(1)^SScript^Stime>60&remains<=buff.ascendance.duration&cooldown.ascendance.remains+buff.ascendance.duration<duration^t^N13^T^SEnabled^B^SAbility^Ssearing_totem^SName^SSearing~`Totem^SScript^S(!talent.liquid_magma.enabled&!totem.fire.active)|(talent.liquid_magma.enabled&pet.searing_totem.remains<=20&!pet.fire_elemental_totem.active&!buff.liquid_magma.up)^t^N14^T^SEnabled^B^SName^SSpiritwalker's~`Grace~`(1)^SArgs^Smoving=1^SAbility^Sspiritwalkers_grace^SScript^Smoving&((talent.elemental_blast.enabled&cooldown.elemental_blast.remains=0)|(cooldown.lava_burst.remains=0&!buff.lava_surge.up))^t^N15^T^SEnabled^B^SScript^S!buff.improved_chain_lightning.up^SRelease^N2.06^SAbility^Schain_lightning^SName^SChain~`Lightning^t^N16^T^SEnabled^B^SName^SLightning~`Bolt^SAbility^Slightning_bolt^t^t^SScript^S^t^^" )
	
	Hekili.Default( "@Elemental, AOE", "actionLists", 2.11, "^1^T^SEnabled^B^SSpecialization^N262^SRelease^N2.05^SScript^S^SActions^T^N1^T^SEnabled^B^SName^SSearing~`Totem~`(0)^SRelease^N2.06^SScript^Stime=0&(!talent.liquid_magma.enabled&!totem.fire.active)|(talent.liquid_magma.enabled&pet.searing_totem.remains<=20&!pet.fire_elemental_totem.active&!buff.liquid_magma.up)^SAbility^Ssearing_totem^t^N2^T^SEnabled^B^SName^SAncestral~`Swiftness^SRelease^N2.06^SScript^S!buff.ascendance.up^SAbility^Sancestral_swiftness^t^N3^T^SEnabled^B^SName^SLiquid~`Magma^SRelease^N2.06^SScript^Spet.searing_totem.remains>=15|pet.fire_elemental_totem.remains>=15^SAbility^Sliquid_magma^t^N4^T^SEnabled^B^SName^SEarthquake^SArgs^Scycle_targets=1^SRelease^N2.06^SScript^S!ticking&(buff.improved_chain_lightning.up|level<=90)&active_enemies>=2^SAbility^Searthquake^t^N5^T^SAbility^Slava_beam^SRelease^N2.06^SName^SLava~`Beam^SEnabled^B^t^N6^T^SEnabled^B^SName^SEarth~`Shock^SRelease^N2.06^SScript^Sbuff.lightning_shield.react=buff.lightning_shield.max_stack^SAbility^Searth_shock^t^N7^T^SEnabled^B^SName^SThunderstorm^SRelease^N2.06^SScript^Sactive_enemies>=10&target.within10^SAbility^Sthunderstorm^t^N8^T^SEnabled^B^SName^SSearing~`Totem^SRelease^N2.06^SScript^S(!talent.liquid_magma.enabled&!totem.fire.active)|(talent.liquid_magma.enabled&pet.searing_totem.remains<=20&!pet.fire_elemental_totem.active&!buff.liquid_magma.up)^SAbility^Ssearing_totem^t^N9^T^SEnabled^B^SName^SChain~`Lightning^SRelease^N2.06^SScript^Sactive_enemies>=2^SAbility^Schain_lightning^t^N10^T^SAbility^Slightning_bolt^SRelease^N2.06^SName^SLightning~`Bolt^SEnabled^B^t^t^SName^S@Elemental,~`AOE^t^^" )
	
	Hekili.Default( "@Elemental, Cooldowns", "actionLists", 2.14, "^1^T^SEnabled^B^SSpecialization^N262^SRelease^N2.13^SScript^S^SActions^T^N1^T^SEnabled^b^SName^SBloodlust^SRelease^N2.06^SAbility^Sbloodlust^SScript^Starget.health.pct<25|time>0.500^t^N2^T^SEnabled^b^SName^SHeroism^SRelease^N2.06^SAbility^Sheroism^SScript^Starget.health.pct<25|time>0.500^t^N3^T^SEnabled^B^SName^SBerserking^SRelease^N2.06^SAbility^Sberserking^SScript^S!buff.bloodlust.up&!buff.elemental_mastery.up&(set_bonus.tier15_4pc_caster=1|(buff.ascendance.cooldown_remains=0&(dot.flame_shock.remains>buff.ascendance.duration|level<87)))^t^N4^T^SEnabled^B^SName^SBlood~`Fury^SRelease^N2.06^SAbility^Sblood_fury^SScript^Sbuff.bloodlust.up|buff.ascendance.up|((cooldown.ascendance.remains>10|level<87)&cooldown.fire_elemental_totem.remains>10)^t^N5^T^SEnabled^B^SName^SElemental~`Mastery^SRelease^N2.06^SAbility^Selemental_mastery^SScript^Saction.lava_burst.cast_time>=1.2^t^N6^T^SRelease^N2.06^SEnabled^B^SName^SStorm~`Elemental~`Totem^SAbility^Sstorm_elemental_totem^t^N7^T^SEnabled^B^SName^SFire~`Elemental~`Totem^SRelease^N2.06^SAbility^Sfire_elemental_totem^SScript^S!active^t^N8^T^SEnabled^B^SName^SAscendance^SRelease^N2.06^SAbility^Sascendance^SScript^Sactive_enemies>1|(dot.flame_shock.remains>buff.ascendance.duration&(target.time_to_die<20|buff.bloodlust.up|time>0)&cooldown.lava_burst.remains>0)^t^t^SName^S@Elemental,~`Cooldowns^t^^" )
	
	
	
	

	Hekili.Default( "@Enhancement, Primary", 'displays', 2.05, "^1^T^SPrimary~`Icon~`Size^N40^SQueued~`Font~`Size^N12^SPrimary~`Font~`Size^N12^SPrimary~`Caption~`Aura^SMaelstrom~`Weapon^Srel^SCENTER^SSpecialization^N263^SSpacing^N5^SQueue~`Direction^SRIGHT^SSpecialization~`Group^Sboth^SQueued~`Icon~`Size^N40^SEnabled^B^SQueues^T^N1^T^SEnabled^B^SAction~`List^S@Shaman,~`Buffs^SScript^S^SCleave^B^SSingle^B^SAOE^B^SName^SBuffs^t^N2^T^SEnabled^B^SAction~`List^S@Shaman,~`Interrupt^SScript^Stoggle.interrupts^SCleave^B^SSingle^B^SAOE^B^SName^SInterrupt^t^N3^T^SEnabled^B^SAction~`List^S@Enhancement,~`Cooldowns^SScript^Stoggle.cooldowns^SCleave^B^SSingle^B^SAOE^B^SName^SCooldowns^t^N4^T^SSingle^B^SAction~`List^S@Enhancement,~`Single~`Target^SScript^Ssingle|(cleave&active_enemies=1)^SEnabled^B^SName^SSingle~`Target^t^N5^T^SEnabled^B^SAction~`List^S@Enhancement,~`2~`Cleave^SName^S2~`Target~`Cleave^SScript^Scleave&active_enemies=2^t^N6^T^SEnabled^B^SAction~`List^S@Enhancement,~`3~`Cleave^SName^S3~`Target~`Cleave^SScript^Scleave&active_enemies=3^t^N7^T^SEnabled^B^SAction~`List^S@Enhancement,~`4~`Cleave^SName^S4~`Target~`Cleave^SScript^Scleave&active_enemies=4^t^N8^T^SEnabled^B^SAction~`List^S@Enhancement,~`AOE^SScript^Saoe|(cleave&active_enemies>4)^SAOE^B^SName^SAOE^t^t^SScript^S^SPvE~`Visibility^Salways^STalent~`Group^N0^SPrimary~`Caption^Sbuff^Sy^N-220^SIcons~`Shown^N5^SName^S@Enhancement,~`Primary^SPvP~`Visibility^Salways^SRelease^N2.05^SFont^SABF^SAction~`Captions^B^Sx^N-90^t^^" )
	
	Hekili.Default( "@Enhancement, AOE", 'displays', 2.05, "^1^T^SPrimary~`Icon~`Size^N30^SQueued~`Font~`Size^N12^SPrimary~`Font~`Size^N12^SPrimary~`Caption~`Aura^SFlame~`Shock^Srel^SCENTER^SSpecialization^N263^SSpacing^N15^SQueue~`Direction^SRIGHT^SPvE~`Visibility^Salways^SQueued~`Icon~`Size^N30^SEnabled^B^SQueues^T^N1^T^SEnabled^B^SAction~`List^S@Enhancement,~`Cooldowns^SName^SCooldowns^SScript^Stoggle.cooldowns^t^N2^T^SEnabled^B^SAction~`List^S@Enhancement,~`AOE^SName^SAOE^SScript^S^t^t^SScript^S^SSpecialization~`Group^Sboth^SIcons~`Shown^N3^Sy^N-180^SFont^SABF^SName^S@Enhancement,~`AOE^SPvP~`Visibility^Salways^SPrimary~`Caption^Sratio^Sx^N-45^SAction~`Captions^B^STalent~`Group^N0^t^^" )
	
	Hekili.Default( "@Elemental, Primary", 'displays', 2.11, 	"^1^T^SPrimary~`Icon~`Size^N40^SQueued~`Font~`Size^N12^SPrimary~`Font~`Size^N12^SPrimary~`Caption~`Aura^SLightning~`Shield^Srel^SCENTER^SSpecialization^N262^SSpacing^N5^SQueue~`Direction^SRIGHT^SPvE~`Visibility^Salways^SQueued~`Icon~`Size^N40^SEnabled^B^SQueues^T^N1^T^SEnabled^B^SAction~`List^S@Shaman,~`Buffs^SName^SBuffs^SScript^S^t^N2^T^SEnabled^B^SAction~`List^S@Shaman,~`Interrupt^SName^SInterrupt^SScript^Stoggle.interrupts^t^N3^T^SEnabled^B^SAction~`List^S@Elemental,~`Cooldowns^SName^SCooldowns^SScript^Stoggle.cooldowns^t^N4^T^SEnabled^B^SAction~`List^S@Elemental,~`Single~`Target^SName^SSingle~`Target^SScript^Ssingle|(cleave&active_enemies=1)^t^N5^T^SEnabled^B^SAction~`List^S@Elemental,~`2-4~`Cleave^SName^S2-4~`Target~`Cleave^SScript^Scleave&active_enemies>1&active_enemies<5^t^N6^T^SEnabled^B^SAction~`List^S@Elemental,~`AOE^SName^SAOE^SScript^Saoe|(cleave&active_enemies>=5)^t^t^SScript^S^SMaximum~`Time^N30^Sx^N-90^SPrimary~`Caption^Sbuff^Sy^N-220^SIcons~`Shown^N5^SName^S@Elemental,~`Primary^SPvP~`Visibility^Salways^SRelease^N2.05^SFont^SUbuntu~`Condensed^SAction~`Captions^B^STalent~`Group^N0^t^^" )
	
	Hekili.Default( "@Elemental, AOE", 'displays', 2.11, "^1^T^SPrimary~`Icon~`Size^N30^SQueued~`Font~`Size^N12^SPrimary~`Font~`Size^N12^SPrimary~`Caption~`Aura^S^Srel^SCENTER^SSpecialization^N262^SSpacing^N15^SQueue~`Direction^SRIGHT^SPvE~`Visibility^Salways^SQueued~`Icon~`Size^N30^SEnabled^B^SQueues^T^N1^T^SEnabled^B^SAction~`List^S@Elemental,~`Cooldowns^SName^SCooldowns^SScript^Stoggle.cooldowns^t^N2^T^SEnabled^B^SAction~`List^S@Elemental,~`AOE^SName^SAOE^SScript^S^t^t^SScript^S^SMaximum~`Time^N30^Sx^N-45^SPrimary~`Caption^Stargets^Sy^N-180^SIcons~`Shown^N3^SName^S@Elemental,~`AOE^SPvP~`Visibility^Salways^SRelease^N2.05^SFont^SArial~`Narrow^SAction~`Captions^B^STalent~`Group^N0^t^^" )
	
end