-- Paladin.lua
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
local AddStance = Hekili.Utils.AddStance

local AddItemSet = Hekili.Utils.AddItemSet

local SetGCD = Hekili.Utils.SetGCD


-- This table gets loaded only if there's a supported class/specialization.
if (select(2, UnitClass('player')) == 'PALADIN') then

	Hekili.Class = 'PALADIN'

	-- AddResource( SPELL_POWER_HEALTH )
	AddResource( SPELL_POWER_MANA, true )
	AddResource( SPELL_POWER_HOLY_POWER )

	AddTalent( 'speed_of_light', 85499 )
	AddTalent( 'long_arm_of_the_law', 87172 )
	AddTalent( 'pursuit_of_justice', 26023 )
	AddTalent( 'fist_of_justice', 105593 )
	AddTalent( 'repentance', 200066 )
	AddTalent( 'blinding_light', 115750 )
	AddTalent( 'selfless_healer', 85804 )
	AddTalent( 'eternal_flame', 114163 )
	AddTalent( 'sacred_shield', 20925 )
	AddTalent( 'hand_of_purity', 114039 )
	AddTalent( 'unbreakable_spirit', 114154 )
	AddTalent( 'clemency', 105622 )
	AddTalent( 'holy_avenger', 105809 )
	AddTalent( 'sanctified_wrath', 53376 )
	AddTalent( 'divine_purpose', 86172 )
	AddTalent( 'holy_prism', 114165 )
	AddTalent( 'lights_hammer', 114158 )
	AddTalent( 'execution_sentence', 114157 )
	AddTalent( 'empowered_seals', 152263 )
	AddTalent( 'seraphim', 152262 )
	AddTalent( 'final_verdict', 157048 )

	-- Glyphs.
	AddGlyph( 'ardent_defender', 159548 )
	AddGlyph( 'avenging_wrath', 54927 )
	AddGlyph( 'beacon_of_light', 63218 )
	AddGlyph( 'bladed_judgment', 115934 )
	AddGlyph( 'blessed_life', 54943 )
	AddGlyph( 'burden_of_guilt', 54931 )
	AddGlyph( 'consecration', 54928 )
	AddGlyph( 'contemplation', 125043 )
	AddGlyph( 'dazing_shield', 56414 )
	AddGlyph( 'denounce', 56420 )
	AddGlyph( 'devotion_aura', 146955 )
	AddGlyph( 'divine_protection', 54924 )
	AddGlyph( 'divine_shield', 146956 )
	AddGlyph( 'divine_storm', 63220 )
	AddGlyph( 'divine_wrath', 159572 )
	AddGlyph( 'divinity', 54939 )
	AddGlyph( 'double_jeopardy', 54992 )
	AddGlyph( 'final_wrath', 54935 )
	AddGlyph( 'fire_from_the_heavens', 57954 )
	AddGlyph( 'flash_of_light', 57955 )
	AddGlyph( 'focused_shield', 54930 )
	AddGlyph( 'focused_wrath', 115738 )
	AddGlyph( 'hammer_of_the_righteous', 63219 )
	AddGlyph( 'hand_of_freedom', 159579 )
	AddGlyph( 'hand_of_sacrifice', 146957 )
	AddGlyph( 'harsh_words', 54938 )
	AddGlyph( 'holy_shock', 63224 )
	AddGlyph( 'holy_wrath', 54923 )
	AddGlyph( 'illumination', 54937 )
	AddGlyph( 'immediate_truth', 56416 )
	AddGlyph( 'inquisition', 63225 )
	AddGlyph( 'judgment', 159592 )
	AddGlyph( 'light_of_dawn', 54940 )
	AddGlyph( 'mass_exorcism', 122028 )
	AddGlyph( 'merciful_wrath', 162604 )
	AddGlyph( 'pillar_of_light', 146959 )
	AddGlyph( 'protector_of_the_innocent', 93466 )
	AddGlyph( 'righteous_retreat', 115933 )
	AddGlyph( 'seal_of_blood', 57947 )
	AddGlyph( 'templars_verdict', 54926 )
	AddGlyph( 'alabaster_shield', 63222 )
	AddGlyph( 'battle_healer', 119477 )
	AddGlyph( 'consecrator', 159557 )
	AddGlyph( 'exorcist', 146958 )
	AddGlyph( 'falling_avenger', 115931 )
	AddGlyph( 'liberator', 159573 )
	AddGlyph( 'luminous_charger', 89401 )
	AddGlyph( 'mounted_king', 57958 )
	AddGlyph( 'winged_vengeance', 57979 )
	AddGlyph( 'word_of_glory', 54936 )
	
	-- Player Buffs.
	AddAura( 'avenging_wrath', 31884 )
	AddAura( 'blazing_contempt', 166831 )
	AddAura( 'blessing_of_kings', 20217 )
	AddAura( 'blessing_of_might', 19740 )
	AddAura( 'divine_crusader', 144595 )
	AddAura( 'divine_protection', 498 )
	AddAura( 'divine_purpose', 86172 )
	AddAura( 'divine_shield', 642 )
	AddAura( 'execution_sentence', 114157 )
	AddAura( 'final_verdict', 157048 )
	AddAura( 'hand_of_freedom', 1044 )
	AddAura( 'hand_of_protection', 1022 )
	AddAura( 'hand_of_sacrifice', 6940 )
	AddAura( 'holy_avenger', 105809 )
	AddAura( 'liadrins_righteousness', 156989, 'duration', 20  )
	AddAura( 'maraads_truth', 156990, 'duration', 20  )
	AddAura( 'righteous_fury', 25780 )
	AddAura( 'seal_of_command', 105361 )
	AddAura( 'seal_of_insight', 20165 )
	AddAura( 'selfless_healer', 114250 )
	AddAura( 'seraphim', 152262 )
	AddAura( 'turalyons_justice', 156987, 'duration', 20 )
	AddAura( 'uthers_insight', 156988, 'duration', 20 )

	-- Perks.
	AddPerk( 'empowered_divine_storm', 174718 )
	AddPerk( 'empowered_hammer_of_wrath', 157496 )
	AddPerk( 'enhanced_hand_of_sacrifice', 157493 )
	AddPerk( 'improved_forbearance', 157482 )
	
	-- Stances.
	AddStance( 'truth', 1 )
	AddStance( 'righteousness', 2 )
	AddStance( 'justice', 3 )
	AddStance( 'insight', 4 )
	
	-- Pick an instant cast ability for checking the GCD.
	SetGCD( 'blessing_of_kings' )

	-- Gear Sets
	AddItemSet( 'tier17', 115565, 115566, 115567, 115568, 115569 )

	AddAbility( 'avenging_wrath', 31884,
		{
			spend = 0,
			cast = 0,
			gcdType = 'off',
			cooldown = 120
		} )
	
	AddHandler( 'avenging_wrath', function ()
		H:Buff( 'avenging_wrath', 20 )
	end )

	
	AddAbility( 'blessing_of_kings', 20217,
		{
			spend = 0.05,
			cast = 0,
			gcdType = 'spell',
			cooldown = 0
		} )
	
	AddHandler( 'blessing_of_kings', function ()
		if buff.blessing_of_might.mine then
			H:RemoveBuff( 'blessing_of_might' )
			H:RemoveBuff( 'mastery' )
		end
		H:Buff( 'blessing_of_kings', 3600 )
		H:Buff( 'str_agi_int', 3600 )
	end )
		
		
	AddAbility( 'blessing_of_might', 19740,
		{
			spend = 0.05,
			cast = 0,
			gcdType = 'spell',
			cooldown = 0
		} )

	AddHandler( 'blessing_of_might', function ()
		if buff.blessing_of_kings.mine then
			H:RemoveBuff( 'blessing_of_kings' )
			H:RemoveBuff( 'str_agi_int' )
		end
		H:Buff( 'blessing_of_might', 3600 )
		H:Buff( 'mastery', 3600 )
	end )
		
	
	AddAbility( 'crusader_strike', 35395,
		{
			spend = 0.10,
			cast = 0,
			gcdType = 'melee',
			cooldown = 4.5
		} )
	
	ModifyAbility( 'crusader_strike', 'cooldown', function( x )
		return x * haste
	end )
		
	AddHandler( 'crusader_strike', function ()
		H:Gain( buff.holy_avenger.up and 3 or 1, 'holy_power' )
	end )
	
	AddAbility( 'divine_storm', 53385,
		{
			spend = function( s )
				if s.buff.divine_purpose.up then return 0, SPELL_POWER_HOLY_POWER end
				return 3, SPELL_POWER_HOLY_POWER
			end,
			cast = 0,
			gcdType = 'melee',
			cooldown = 0,
			hostile = true
		} )

	AddHandler( 'divine_storm', function ()
		H:RemoveBuff( 'divine_crusader' )
		H:RemoveBuff( 'divine_purpose' )
		H:Spend( 3, 'holy_power' )
	end )

	AddAbility( 'execution_sentence', 114157,
		{
			spend = 0.128,
			cast = 0,
			gcdType = 'spell', 
			cooldown = 60,
			known = function( s ) return s.talent.execution_sentence.enabled end,
			hostile = true
		} )
	
	AddHandler( 'execution_sentence', function ()
		H:Debuff( 'target', 'execution_sentence', 10 )
	end )

	AddAbility( 'exorcism', 879, 122032,
		{
			known = 879,
			spend = 0.04,
			cast = 0,
			gcdType = 'spell',
			cooldown = 15,
			hostile = true
		} )

	ModifyAbility( 'exorcism', 'cooldown', function( x )
		return x * haste
	end )
	
	ModifyAbility( 'exorcism', 'id', function ( x )
		if glyph.mass_exorcism.enabled then return 122032 end
		return x
	end )

	AddHandler( 'exorcism', function ()
		if buff.blazing_contempt.up then
			H:Gain( 3, 'holy_power' )
			H:RemoveBuff( 'blazing_contempt' )
		else
			H:Gain( buff.holy_avenger.up and 3 or 1, 'holy_power' )
		end
	end )	
	

	AddAbility( 'final_verdict', 157048,
		{
			spend = function( s )
				if s.buff.divine_purpose.up then return 0, SPELL_POWER_HOLY_POWER end
				return 3, SPELL_POWER_HOLY_POWER
			end,
			cast = 0,
			gcdType = 'spell',
			cooldown = 0,
			known = function( s ) return s.talent.final_verdict.enabled end,
			hostile = true
		} )

	AddHandler( 'final_verdict', function()
		H:Buff( 'final_verdict', 30 )
		H:RemoveBuff( 'divine_purpose' )
	end )	

	
	AddAbility( 'hammer_of_the_righteous', 53595,
		{
			spend = 0.03,
			cast = 0,
			gcdType = 'melee',
			cooldown = 4.5,
			hostile = true
		} )	
	
	ModifyAbility( 'hammer_of_the_righteous', 'cooldown', function( x )
		return x * haste
	end )
	
	AddHandler( 'hammer_of_the_righteous', function ()
		H:Gain( buff.holy_avenger.up and 3 or 1, 'holy_power' )
	end )
	
	
	AddAbility( 'hammer_of_wrath', 24275,
		{
			spend = 0.03,
			cast = 0,
			gcdType = 'melee',
			cooldown = 6,
			usable = function( s ) return ( s.target.health_pct <= ( s.perk.empowered_hammer_of_wrath.enabled and 35 or 20 ) ) or s.buff.avenging_wrath.up end,
			hostile = true
		} )

	ModifyAbility( 'hammer_of_wrath', 'cooldown', function( x )
		if buff.avenging_wrath.up then
			x = x / 2
		end
		return x * haste
	end )
	
	AddHandler( 'hammer_of_wrath', function ()
		if set_bonus.tier17_4pc==1 then H:Buff( "blazing_contempt", 20 ) end
		H:Gain( buff.holy_avenger.up and 3 or 1, 'holy_power' )
	end )
	
	
	AddAbility( 'holy_avenger', 105809,
		{
			spend = 0,
			cast = 0,
			gcdType = 'spell',
			cooldown = 120
		} )
		
	AddHandler( 'holy_avenger', function ()
		H:Buff( 'holy_avenger', 18 )
	end )
	
	
	AddAbility( 'holy_prism', 114165,
		{
      known = function( s ) return s.talent.holy_prism.enabled end,
			spend = 0.17,
			cast = 0,
			gcdType = 'spell',
			cooldown = 20,
			hostile = true
		} )	
	

	AddAbility( 'judgment', 20271,
		{
			spend = 0.12,
			cast = 0,
			gcdType = 'spell',
			cooldown = 6,
			hostile = true
		} )
	
	ModifyAbility( 'judgment', 'cooldown', function( x )
		return x * haste
	end )
	
	AddHandler( 'judgment', function ()
		H:Gain( buff.holy_avenger.up and 3 or 1, 'holy_power' )
		if talent.empowered_seals.enabled then
			if seal.justice then H:Buff( 'turalyons_justice', 20 )
			elseif seal.insight then H:Buff( 'uthers_insight', 20 )
			elseif seal.righteousness then H:Buff( 'liadrins_righteousness', 20 )
			elseif seal.truth then H:Buff( 'maraads_truth', 20 )
			end
		end
	end )
	
	
	AddAbility( 'lights_hammer', 114158,
		{
      known = function( s ) return s.talent.lights_hammer.enabled end,
			spend = 0.519,
			cast = 0,
			gcdType = 'spell',
			cooldown = 60,
			hostile = true
		} )

	
	AddAbility( 'rebuke', 96231,
		{
			spend =  0.117,
			cast = 0,
			gcdType = 'off',
			cooldown = 15,
			hostile = true
		} )
	
	AddHandler( 'rebuke', function ()
		H:Interrupt( 'target' )
	end )
	
	
	AddAbility( 'seal_of_righteousness', 20154,
		{
			spend = 0,
			cast = 0,
			gcdType = 'spell',
			cooldown = 0,
			usable = function( s ) return not s.seal.righteousness end
		} )
	
	AddHandler( 'seal_of_righteousness', function ()
		H:Stance( 'righteousness' )
	end )
	
	
	AddAbility( 'seal_of_truth', 31801,
		{
			spend = 0,
			cast = 0,
			gcdType = 'spell',
			cooldown = 0,
			known = 105361,
			usable = function( s ) return not s.seal.truth end
		} )

	AddHandler( 'seal_of_truth', function ()
		H:Stance( 'truth' )
	end )
		
	
	AddAbility( 'seraphim', 152262,
		{
			spend = 5,
			spend_type = SPELL_POWER_HOLY_POWER,
			cast = 0,
			gcdType = 'spell',
			cooldown = 30,
		} )
	
	AddHandler( 'seraphim', function ()
		H:Buff( 'seraphim', 15 )
	end )
	
	
	AddAbility( 'templars_verdict', 85256,
		{
			spend = function( s )
				if s.buff.divine_purpose.up then return 0, SPELL_POWER_HOLY_POWER end
				return 3, SPELL_POWER_HOLY_POWER
			end,
			cast = 0,
			gcdType = 'spell',
			cooldown = 0,
			known = function( s ) return not s.talent.final_verdict.enabled end,
			hostile = true
		} )
	
	AddHandler( 'templars_verdict', function ()
		H:RemoveBuff( 'divine_purpose' )
	end )
	
	
	Hekili.Default( '@Retribution, Single Target', 'actionLists', 2.07, "^1^T^SEnabled^B^SName^SRetribution,~`Single~`Target^SRelease^N2.06^SSpecialization^N70^SActions^T^N1^T^SEnabled^B^SName^SDivine~`Storm^SRelease^N2.06^SAbility^Sdivine_storm^SScript^Sbuff.divine_crusader.up&holy_power.current=5&buff.final_verdict.up^t^N2^T^SEnabled^B^SName^SDivine~`Storm~`(1)^SRelease^N2.06^SAbility^Sdivine_storm^SScript^Sbuff.divine_crusader.up&holy_power.current=5&active_enemies=2&!talent.final_verdict.enabled^t^N3^T^SEnabled^B^SName^SDivine~`Storm~`(2)^SRelease^N2.06^SAbility^Sdivine_storm^SScript^Sholy_power.current=5&active_enemies=2&buff.final_verdict.up^t^N4^T^SEnabled^B^SName^SDivine~`Storm~`(3)^SRelease^N2.06^SAbility^Sdivine_storm^SScript^Sbuff.divine_crusader.up&holy_power.current=5&(talent.seraphim.enabled&cooldown.seraphim.remains<=4)^t^N5^T^SEnabled^B^SName^STemplar's~`Verdict^SRelease^N2.06^SAbility^Stemplars_verdict^SScript^Sholy_power.current=5|buff.holy_avenger.up&holy_power.current>=3&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)^t^N6^T^SEnabled^B^SName^STemplar's~`Verdict~`(1)^SRelease^N2.06^SAbility^Stemplars_verdict^SScript^Sbuff.divine_purpose.up&buff.divine_purpose.remains<4^t^N7^T^SEnabled^B^SName^SDivine~`Storm~`(4)^SRelease^N2.06^SAbility^Sdivine_storm^SScript^Sbuff.divine_crusader.up&buff.divine_crusader.remains<4&!talent.final_verdict.enabled^t^N8^T^SEnabled^B^SName^SFinal~`Verdict^SRelease^N2.06^SAbility^Sfinal_verdict^SScript^Sholy_power.current=5|buff.holy_avenger.up&holy_power.current>=3^t^N9^T^SEnabled^B^SName^SFinal~`Verdict~`(1)^SRelease^N2.06^SAbility^Sfinal_verdict^SScript^Sbuff.divine_purpose.up&buff.divine_purpose.remains<4^t^N10^T^SRelease^N2.06^SAbility^Shammer_of_wrath^SName^SHammer~`of~`Wrath^SEnabled^B^t^N11^T^SEnabled^B^SName^SJudgment^SRelease^N2.06^SAbility^Sjudgment^SScript^Stalent.empowered_seals.enabled&((seal.truth&buff.maraads_truth.remains<cooldown.judgment.duration*2)|(seal.righteousness&buff.liadrins_righteousness.remains<cooldown.judgment.duration*2))^t^N12^T^SEnabled^B^SName^SExorcism^SRelease^N2.06^SAbility^Sexorcism^SScript^Sbuff.blazing_contempt.up&holy_power.current<=2&buff.holy_avenger.down^t^N13^T^SEnabled^B^SName^SSeal~`of~`Truth^SRelease^N2.06^SAbility^Sseal_of_truth^SScript^Stalent.empowered_seals.enabled&buff.maraads_truth.remains<(cooldown.judgment.duration)&buff.maraads_truth.remains<=3^t^N14^T^SEnabled^B^SName^SDivine~`Storm~`(5)^SRelease^N2.06^SAbility^Sdivine_storm^SScript^Sbuff.divine_crusader.up&buff.final_verdict.up&(buff.avenging_wrath.up|target.health.pct<35)^t^N15^T^SEnabled^B^SName^SFinal~`Verdict~`(2)^SRelease^N2.06^SAbility^Sfinal_verdict^SScript^Sbuff.divine_purpose.up|target.health.pct<35^t^N16^T^SEnabled^B^SName^STemplar's~`Verdict~`(2)^SRelease^N2.06^SAbility^Stemplars_verdict^SScript^Sbuff.avenging_wrath.up|target.health.pct<35&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)^t^N17^T^SRelease^N2.06^SAbility^Scrusader_strike^SName^SCrusader~`Strike^SEnabled^B^t^N18^T^SEnabled^B^SName^SDivine~`Storm~`(6)^SRelease^N2.06^SAbility^Sdivine_storm^SScript^Sbuff.divine_crusader.up&(buff.avenging_wrath.up|target.health.pct<35)&!talent.final_verdict.enabled^t^N19^T^SEnabled^B^SName^SDivine~`Storm~`(7)^SRelease^N2.06^SAbility^Sdivine_storm^SScript^Sbuff.divine_crusader.up&buff.final_verdict.up^t^N20^T^SRelease^N2.06^SAbility^Sfinal_verdict^SName^SFinal~`Verdict~`(3)^SEnabled^B^t^N21^T^SEnabled^B^SName^SSeal~`of~`Righteousness^SRelease^N2.06^SAbility^Sseal_of_righteousness^SScript^Stalent.empowered_seals.enabled&buff.liadrins_righteousness.remains<(cooldown.judgment.duration)&buff.liadrins_righteousness.remains<=3^t^N22^T^SRelease^N2.06^SAbility^Sjudgment^SName^SJudgment~`(1)^SEnabled^B^t^N23^T^SEnabled^B^SName^STemplar's~`Verdict~`(3)^SRelease^N2.06^SAbility^Stemplars_verdict^SScript^Sbuff.divine_purpose.up^t^N24^T^SEnabled^B^SName^SDivine~`Storm~`(8)^SRelease^N2.06^SAbility^Sdivine_storm^SScript^Sbuff.divine_crusader.up&!talent.final_verdict.enabled^t^N25^T^SEnabled^B^SName^STemplar's~`Verdict~`(4)^SRelease^N2.06^SAbility^Stemplars_verdict^SScript^Sholy_power.current>=4&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)^t^N26^T^SRelease^N2.06^SAbility^Sexorcism^SName^SExorcism~`(1)^SEnabled^B^t^N27^T^SEnabled^B^SName^STemplar's~`Verdict~`(5)^SRelease^N2.06^SAbility^Stemplars_verdict^SScript^Sholy_power.current>=3&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)^t^N28^T^SRelease^N2.06^SAbility^Sholy_prism^SName^SHoly~`Prism^SEnabled^B^t^t^SScript^S^t^^" )
	
	Hekili.Default( '@Retribution, 3-4 Cleave', 'actionLists', 2.07, "^1^T^SEnabled^B^SName^SRetribution,~`3-4~`Cleave^SRelease^N2.06^SSpecialization^N70^SActions^T^N1^T^SEnabled^B^SName^SFinal~`Verdict^SRelease^N2.06^SAbility^Sfinal_verdict^SScript^Sbuff.final_verdict.down&holy_power.current=5^t^N2^T^SEnabled^B^SName^SDivine~`Storm^SRelease^N2.06^SAbility^Sdivine_storm^SScript^Sholy_power.current=5&buff.final_verdict.up^t^N3^T^SEnabled^B^SName^SDivine~`Storm~`(1)^SRelease^N2.06^SAbility^Sdivine_storm^SScript^Sholy_power.current=5&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)&!talent.final_verdict.enabled^t^N4^T^SEnabled^B^SName^SExorcism^SRelease^N2.06^SAbility^Sexorcism^SScript^Sbuff.blazing_contempt.up&holy_power.current<=2&buff.holy_avenger.down^t^N5^T^SRelease^N2.06^SAbility^Shammer_of_wrath^SName^SHammer~`of~`Wrath^SEnabled^B^t^N6^T^SEnabled^B^SName^SJudgment^SRelease^N2.06^SAbility^Sjudgment^SScript^Stalent.empowered_seals.enabled&seal.righteousness&buff.liadrins_righteousness.remains<=5^t^N7^T^SEnabled^B^SName^SDivine~`Storm~`(2)^SRelease^N2.06^SAbility^Sdivine_storm^SScript^Slevel=100&((!talent.seraphim.enabled|cooldown.seraphim.remains>4)&!talent.final_verdict.enabled)^t^N8^T^SRelease^N2.06^SAbility^Scrusader_strike^SName^SCrusader~`Strike^SEnabled^B^t^N9^T^SEnabled^B^SName^SFinal~`Verdict~`(1)^SRelease^N2.06^SAbility^Sfinal_verdict^SScript^Sbuff.final_verdict.down^t^N10^T^SEnabled^B^SName^SDivine~`Storm~`(3)^SRelease^N2.06^SAbility^Sdivine_storm^SScript^Sbuff.final_verdict.up^t^N11^T^SRelease^N2.06^SAbility^Sjudgment^SName^SJudgment~`(1)^SEnabled^B^t^N12^T^SRelease^N2.06^SAbility^Sexorcism^SName^SExorcism~`(1)^SEnabled^B^t^N13^T^SRelease^N2.06^SAbility^Sholy_prism^SName^SHoly~`Prism^SEnabled^B^t^t^SScript^S^t^^" )
	
	Hekili.Default( '@Retribution, AOE', 'actionLists', 2.07, "^1^T^SEnabled^B^SName^SRetribution,~`AOE^SRelease^N2.06^SSpecialization^N70^SActions^T^N1^T^SEnabled^B^SName^SDivine~`Storm^SRelease^N2.06^SAbility^Sdivine_storm^SScript^Sholy_power.current=5&(!talent.seraphim.enabled|cooldown.seraphim.remains>4)^t^N2^T^SEnabled^B^SName^SExorcism^SRelease^N2.06^SAbility^Sexorcism^SScript^Sbuff.blazing_contempt.up&holy_power.current<=2&buff.holy_avenger.down^t^N3^T^SRelease^N2.06^SAbility^Shammer_of_the_righteous^SName^SHammer~`of~`the~`Righteous^SEnabled^B^t^N4^T^SEnabled^B^SName^SJudgment^SRelease^N2.06^SAbility^Sjudgment^SScript^Stalent.empowered_seals.enabled&seal.righteousness&buff.liadrins_righteousness.remains<=5^t^N5^T^SRelease^N2.06^SAbility^Shammer_of_wrath^SName^SHammer~`of~`Wrath^SEnabled^B^t^N6^T^SEnabled^B^SName^SDivine~`Storm~`(1)^SRelease^N2.06^SAbility^Sdivine_storm^SScript^S(!talent.seraphim.enabled|cooldown.seraphim.remains>4)^t^N7^T^SEnabled^B^SName^SExorcism~`(1)^SRelease^N2.06^SAbility^Sexorcism^SScript^Sglyph.mass_exorcism.enabled^t^N8^T^SRelease^N2.06^SAbility^Sjudgment^SName^SJudgment~`(1)^SEnabled^B^t^N9^T^SRelease^N2.06^SAbility^Sexorcism^SName^SExorcism~`(2)^SEnabled^B^t^N10^T^SRelease^N2.06^SAbility^Sholy_prism^SName^SHoly~`Prism^SEnabled^B^t^t^SScript^S^t^^" )
	
	Hekili.Default( '@Retribution, Cooldowns', 'actionLists', 2.07, "^1^T^SEnabled^B^SName^SRetribution,~`Cooldowns^SRelease^N2.06^SSpecialization^N70^SActions^T^N1^T^SRelease^N2.06^SAbility^Sexecution_sentence^SName^SExecution~`Sentence^SEnabled^B^t^N2^T^SRelease^N2.06^SAbility^Slights_hammer^SName^SLight's~`Hammer^SEnabled^B^t^N3^T^SEnabled^B^SName^SHoly~`Avenger^SArgs^Ssync=seraphim^SRelease^N2.06^SAbility^Sholy_avenger^SScript^Stalent.seraphim.enabled&cooldown.seraphim.remains=0^t^N4^T^SEnabled^B^SName^SHoly~`Avenger~`(1)^SRelease^N2.06^SAbility^Sholy_avenger^SScript^Sholy_power.current<=2&!talent.seraphim.enabled^t^N5^T^SEnabled^B^SName^SAvenging~`Wrath^SArgs^Ssync=seraphim^SRelease^N2.06^SAbility^Savenging_wrath^SScript^Stalent.seraphim.enabled&cooldown.seraphim.remains=0^t^N6^T^SEnabled^B^SName^SAvenging~`Wrath~`(1)^SRelease^N2.06^SAbility^Savenging_wrath^SScript^S!talent.seraphim.enabled^t^N7^T^SRelease^N2.06^SAbility^Sblood_fury^SName^SBlood~`Fury^SEnabled^B^t^N8^T^SRelease^N2.06^SAbility^Sberserking^SName^SBerserking^SEnabled^B^t^N9^T^SRelease^N2.06^SAbility^Sseraphim^SName^SSeraphim^SEnabled^B^t^t^SScript^S^t^^" )
	
	Hekili.Default( '@Retribution, Interrupts', 'actionLists', 2.07, "^1^T^SEnabled^B^SName^SRetribution,~`Interrupt^SRelease^N2.06^SSpecialization^N70^SActions^T^N1^T^SEnabled^B^SName^SRebuke^SRelease^N2.06^SAbility^Srebuke^SScript^Starget.casting^t^t^SScript^S^t^^" )
	
	Hekili.Default( '@Retribution, Buffs', 'actionLists', 2.08, "^1^T^SEnabled^B^SName^S@Retribution,~`Buffs^SRelease^N2.07^SScript^S^SActions^T^N1^T^SEnabled^B^SName^SBlessing~`of~`Kings^SRelease^N2.06^SScript^S!buff.str_agi_int.up^SAbility^Sblessing_of_kings^t^N2^T^SEnabled^B^SName^SBlessing~`of~`Might^SRelease^N2.06^SAbility^Sblessing_of_might^SScript^S!buff.mastery.up&!buff.str_agi_int.mine^t^N3^T^SEnabled^B^SName^SSeal~`of~`Truth^SAbility^Sseal_of_truth^SScript^S(time=0|!talent.empowered_seals.enabled)&active_enemies<2&!seal.truth^SRelease^N2.06^t^N4^T^SEnabled^b^SName^SSeal~`of~`Righteousness^SAbility^Sseal_of_righteousness^SScript^Sactive_enemies>=4&target.time_to_die>=30^SRelease^N2.06^t^t^SSpecialization^N70^t^^" )
	
	
	
	Hekili.Default( '@Retribution, Single Target', 'displays', 2.07, "^1^T^SPrimary~`Icon~`Size^N50^SQueued~`Font~`Size^N12^SPrimary~`Font~`Size^N12^SPrimary~`Caption~`Aura^S^Srel^SCENTER^SSpecialization^N70^SSpacing^N5^SQueue~`Direction^SRIGHT^SPvE~`Visibility^Salways^SQueued~`Icon~`Size^N40^SMaximum~`Time^N30^SQueues^T^N1^T^SEnabled^B^SAction~`List^S@Retribution,~`Buffs^SName^SBuffs^SRelease^N2.06^SScript^Stime=0^t^N2^T^SEnabled^B^SAction~`List^S@Retribution,~`Interrupts^SName^SInterrupts^SRelease^N2.06^SScript^Stoggle.interrupts^t^N3^T^SEnabled^B^SAction~`List^S@Retribution,~`Cooldowns^SName^SCooldowns^SRelease^N2.06^SScript^Stoggle.cooldowns^t^N4^T^SEnabled^B^SAction~`List^S@Retribution,~`Single~`Target^SName^SSingle~`Target^SRelease^N2.06^SScript^Ssingle~`or~`active_enemies~`<~`3^t^N5^T^SEnabled^B^SAction~`List^S@Retribution,~`3-4~`Cleave^SName^SCleave^SRelease^N2.06^SScript^Scleave~`and~`active_enemies~`>=~`3~`and~`active_enemies~`<~`5^t^N6^T^SEnabled^B^SAction~`List^S@Retribution,~`AOE^SName^SAOE^SRelease^N2.06^SScript^Saoe~`or~`(~`cleave~`and~`active_enemies~`>=~`5~`)^t^t^SScript^S^SEnabled^B^Sx^N-90^SRelease^N2.07^Sy^N-230^SIcons~`Shown^N5^SName^S@Retribution,~`Single~`Target^SPvP~`Visibility^Salways^SPrimary~`Caption^Stargets^STalent~`Group^N0^SAction~`Captions^B^SFont^SUbuntu~`Condensed^t^^" )
	
	Hekili.Default( '@Retribution, AOE', 'displays', 2.07, "^1^T^SPrimary~`Icon~`Size^N40^SQueued~`Font~`Size^N12^SPrimary~`Font~`Size^N12^SPrimary~`Caption~`Aura^S^SSpecialization^N70^SSpacing^N5^SQueue~`Direction^SRIGHT^SPvE~`Visibility^Salways^SQueued~`Icon~`Size^N40^SEnabled^B^SQueues^T^N1^T^SEnabled^B^SAction~`List^S@Retribution,~`Buffs^SName^SBuffs^SRelease^N2.06^SScript^Stime=0^t^N2^T^SEnabled^B^SAction~`List^S@Retribution,~`Cooldowns^SName^SCooldowns^SRelease^N2.06^SScript^Stoggle.cooldowns^t^N3^T^SEnabled^B^SAction~`List^S@Retribution,~`AOE^SName^SAOE^SRelease^N2.06^SScript^S^t^t^SScript^S^STalent~`Group^N0^SIcons~`Shown^N3^Sx^N-40^Sy^N-180^SFont^SUbuntu~`Condensed^SName^S@Retribution,~`AOE^SPvP~`Visibility^Salways^SRelease^N2.07^SPrimary~`Caption^Sdefault^SAction~`Captions^B^SMaximum~`Time^N30^t^^" )
	
end