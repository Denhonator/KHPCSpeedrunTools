state("KINGDOM HEARTS FINAL MIX")
{
	bool blackInv : "KINGDOM HEARTS FINAL MIX.exe", 0x4D93B8;
	byte white : "KINGDOM HEARTS FINAL MIX.exe", 0x233C49C;
	bool paused : "KINGDOM HEARTS FINAL MIX.exe", 0x232A63C;
	bool cutscene : "KINGDOM HEARTS FINAL MIX.exe", 0x233AE74;
	bool load : "KINGDOM HEARTS FINAL MIX.exe", 0x232A368;
	bool load2: "KINGDOM HEARTS FINAL MIX.exe", 0x233AEB0;
	bool saveload : "KINGDOM HEARTS FINAL MIX.exe", 0x2E1CBB8;
	bool summonload : "KINGDOM HEARTS FINAL MIX.exe", 0x2D50988;
	bool partyload : "KINGDOM HEARTS FINAL MIX.exe", 0x2E1BAFC;
	byte titlescreen : "KINGDOM HEARTS FINAL MIX.exe", 0x7FE990;
	byte hp : "KINGDOM HEARTS FINAL MIX.exe", 0x2D592CC;
	byte newgame : "KINGDOM HEARTS FINAL MIX.exe", 0x2E98824;
	byte fightend : "KINGDOM HEARTS FINAL MIX.exe", 0x2D500B8;
	ushort w1 : "KINGDOM HEARTS FINAL MIX.exe", 0x233CADC;
	ushort w2 : "KINGDOM HEARTS FINAL MIX.exe", 0x233CB4C;
	ushort w3 : "KINGDOM HEARTS FINAL MIX.exe", 0x2D5CAFA;
	ushort w4 : "KINGDOM HEARTS FINAL MIX.exe", 0x2DB41D0;
	ushort w5 : "KINGDOM HEARTS FINAL MIX.exe", 0x2DE75EC;
	ushort w6 : "KINGDOM HEARTS FINAL MIX.exe", 0x2DE7A10;
	ushort w7 : "KINGDOM HEARTS FINAL MIX.exe", 0x2DFE1EC;
	ushort w8 : "KINGDOM HEARTS FINAL MIX.exe", 0x2DFE610;
	ushort room : "KINGDOM HEARTS FINAL MIX.exe", 0x233CB44;
	ushort scene : "KINGDOM HEARTS FINAL MIX.exe", 0x233CB48;
	byte camp_gummi : "KINGDOM HEARTS FINAL MIX.exe", 0x2DF1853;
	byte climb_gummi : "KINGDOM HEARTS FINAL MIX.exe", 0x2DF186C;
	byte house_gummi : "KINGDOM HEARTS FINAL MIX.exe", 0x2DF1859;
	byte cliff_gummi : "KINGDOM HEARTS FINAL MIX.exe", 0x2DF186B;
	byte bamboo_gummi : "KINGDOM HEARTS FINAL MIX.exe", 0x2DF184C;
	byte power_boost : "KINGDOM HEARTS FINAL MIX.exe", 0x2DE5F01;
	byte fmn : "KINGDOM HEARTS FINAL MIX.exe", 0x2DE5F4C;
	byte jb : "KINGDOM HEARTS FINAL MIX.exe", 0x2DE5F4D;
	ushort gummi_start : "KINGDOM HEARTS FINAL MIX.exe", 0x503C00;
	ushort gummi_dest : "KINGDOM HEARTS FINAL MIX.exe", 0x5041F0;
	byte in_gummi : "KINGDOM HEARTS FINAL MIX.exe", 0x50421D;
	// these do not track the two healths exclusively but will get us the values at those times we need
	ushort behemoth_3_health : "KINGDOM HEARTS FINAL MIX.exe", 0x2D595CC;
	ushort colo_behemoth_health : "KINGDOM HEARTS FINAL MIX.exe", 0x284C4EC;

	ushort text_progress : "KINGDOM HEARTS FINAL MIX.exe", 0x232A5F4;
    byte sora_level : "KINGDOM HEARTS FINAL MIX.exe", 0x2DE59D4;
    byte nature_spark : "KINGDOM HEARTS FINAL MIX.exe", 0x2DE5F38;
    byte mythril_shard : "KINGDOM HEARTS FINAL MIX.exe", 0x2DE5F66;
    byte mythril : "KINGDOM HEARTS FINAL MIX.exe", 0x2DE5F67;
    byte gravity_level : "KINGDOM HEARTS FINAL MIX.exe", 0x2DE5E66;
    byte stop_level : "KINGDOM HEARTS FINAL MIX.exe", 0x2DE5E67;
    byte exp_ring : "KINGDOM HEARTS FINAL MIX.exe", 0x2DE5EA3;
    byte exp_necklace : "KINGDOM HEARTS FINAL MIX.exe", 0x2DE5EA5;
    byte party_slot_1 : "KINGDOM HEARTS FINAL MIX.exe", 0x2DE5E5F;
    byte party_slot_2 : "KINGDOM HEARTS FINAL MIX.exe", 0x2DE5E60;
    ushort non_player_unit_count : "KINGDOM HEARTS FINAL MIX.exe", 0x23A243C;
    byte torn_page_count : "KINGDOM HEARTS FINAL MIX.exe", 0x2DE6DD0;
}

startup
{
	vars.booting = false;
	vars.summontimer = 0;

	settings.Add("main_splits", true, "All end of section splits");
	settings.Add("ds1", true, "Split on Darkside 1", "main_splits");
	settings.Add("ds2", true, "Split on Darkside 2", "main_splits");
	settings.Add("guard", true, "Split on Guard Armor", "main_splits");
	settings.Add("tm", true, "Split on Trick Master", "main_splits");
	settings.Add("clayton_2", true, "Split on Clayton 2", "main_splits");
	settings.Add("gj", true, "Split on Genie Jafar", "main_splits");
	settings.Add("pc2", true, "Split on Parasite Cage 2", "main_splits");
	settings.Add("oogie_manor", true, "Split on Oogie Manor", "main_splits");
	settings.Add("hook", true, "Split on Captain Hook", "main_splits");
	settings.Add("oppo", true, "Split on Opposite Armor", "main_splits");
	settings.Add("riku2", true, "Split on Riku 2", "main_splits");
	settings.Add("behemoth", true, "Split on Behemoth", "main_splits");
	settings.Add("cher", true, "Split on Arch Chernabog", "main_splits");
	settings.Add("a2", true, "Split on Ansem 2", "main_splits");

	settings.Add("optional_splits", true, "All other Any % splits");
	settings.Add("shadows_1", false, "Split after clearing Shadows 1 (first full group)", "optional_splits");
	settings.Add("shadows_2", false, "Split after clearing Shadows 2 (post save point cutscene)", "optional_splits");
	settings.Add("day_1", false, "Split on Finish of Destiny Islands day one", "optional_splits");
	settings.Add("destiny", false, "Split on Finish of Destiny Islands day two", "optional_splits");
	settings.Add("leon", true, "Split on Leon", "optional_splits");
	settings.Add("crank", true, "Split on Crank Tower", "optional_splits");
	settings.Add("sabor_1", true, "Split on Sabor 1", "optional_splits");
	settings.Add("power_wilds", false, "Split after Power Wilds", "optional_splits");
	settings.Add("sabor_2", true, "Split on Sabor 2", "optional_splits");
	settings.Add("clayton_1", false, "Split on Clayton 1", "optional_splits");
	settings.Add("wfc", false, "Split on Finish of Waterfall Cavern", "optional_splits");
	settings.Add("tt_2", false, "Split on Exit from Traverse Town 2", "optional_splits");
	settings.Add("save_al", false, "Split on Save Aladdin", "optional_splits");
	settings.Add("pot", true, "Split on Pot Centipede", "optional_splits");
	settings.Add("tiger", true, "Split on Tiger Head", "optional_splits");
	settings.Add("jafar", true, "Split on Jafar", "optional_splits");
	settings.Add("carpet_escape", false, "Split after Carpet Escape", "optional_splits");
	settings.Add("pc", true, "Split on Parasite Cage 1", "optional_splits");
	settings.Add("fmn", false, "Split on Forget Me Not turn in", "optional_splits");
	settings.Add("jb", false, "Split on Jack in the Box turn in", "optional_splits");
	settings.Add("lsb", true, "Split on LSB", "optional_splits");
	settings.Add("oogie", true, "Split on Oogie Boogie", "optional_splits");
	settings.Add("ship", false, "Split on Hooks ship", "optional_splits");
	settings.Add("anti", true, "Split on Anti Sora", "optional_splits");
	settings.Add("fake_guard", false, "Split on fake Guard Armor", "optional_splits");
	settings.Add("riku", true, "Split on Riku 1", "optional_splits");
	settings.Add("emblem", false, "Split on Emblem Door", "optional_splits");
	settings.Add("dumbo_1", false, "Split on Summon of Dumbo for skip 1", "optional_splits");
	settings.Add("mal", true, "Split on Maleficent", "optional_splits");
	settings.Add("dragon", true, "Split on Dragon Maleficent", "optional_splits");
	settings.Add("tt_4", false, "Split on Exit from Traverse Town 4th visit", "optional_splits");
	settings.Add("dumbo_2", false, "Split on Summon of Dumbo for skip 2", "optional_splits");
	settings.Add("dumbo_3", false, "Split on Summon of Dumbo for skip 3", "optional_splits");
	settings.Add("arch", false, "Split on Arch Behemoth", "optional_splits");
	settings.Add("oc", false, "Split on Olympus Coliseum portal", "optional_splits");
	settings.Add("atl", false, "Split on Atlantica portal", "optional_splits");
	settings.Add("hbp", false, "Split on Hollow Bastion portal", "optional_splits");
	settings.Add("behemoth_3", false, "Split on Behemoth 3 (final rest)", "optional_splits");
	settings.Add("finalrest", true, "Split on entering Final Rest", "optional_splits");
	settings.Add("a1", true, "Split on Ansem 1", "optional_splits");
	settings.Add("ds3", true, "Split on Dark Side 3", "optional_splits");
	settings.Add("a3", true, "Split on Ansem 3", "optional_splits");
	settings.Add("sc", true, "Split on Shadow Core", "optional_splits");
	settings.Add("artillery", false, "Split on Artillery", "optional_splits");
	settings.Add("dbc", true, "Split on Dark Ball Core", "optional_splits");
	settings.Add("face", true, "Split on Face", "optional_splits");
	settings.Add("inc", true, "Split on Invisible Core", "optional_splits");
	settings.Add("mc", true, "Split on Main Core", "optional_splits");

	settings.Add("all_worlds_splits", false, "Splits for All Worlds categories");
	settings.Add("thunder", false, "Split on Exit from Olympus Coliseum after getting Thunder", "all_worlds_splits");
	settings.Add("power_boost", false, "Split on Exit from 100 Acre Wood after getting Power Boost", "all_worlds_splits");
	settings.Add("torn_page_1", false, "Split on Completing first Torn Page of 100 Acre Wood", "all_worlds_splits");
	settings.Add("torn_page_2", false, "Split on Completing second Torn Page of 100 Acre Wood", "all_worlds_splits");
	settings.Add("torn_page_3", false, "Split on Completing third Torn Page of 100 Acre Wood", "all_worlds_splits");
	settings.Add("torn_page_4", false, "Split on Completing fourth Torn Page of 100 Acre Wood", "all_worlds_splits");
	settings.Add("torn_page_5", false, "Split on Completing fifth Torn Page of 100 Acre Wood", "all_worlds_splits");
	settings.Add("seal_100_aw", false, "Split on Sealing the 100 Acre Wood Keyhole", "all_worlds_splits");
	settings.Add("cloud_1", false, "Split on First Cloud Fight", "all_worlds_splits");
	settings.Add("cerb_1", false, "Split on First Cerberus Fight", "all_worlds_splits");
	settings.Add("cloud_2", false, "Split on Second Cloud Fight", "all_worlds_splits");
	settings.Add("herc_cup", false, "Split on Finishing Hercules Cup", "all_worlds_splits");
	settings.Add("urs_1", false, "Split on Ursula 1", "all_worlds_splits");
	settings.Add("urs_2", false, "Split on Ursula 2", "all_worlds_splits");

	settings.Add("jj_splits", false, "Splits for Jimminy's Journal categories");
	settings.Add("atlantica_1", false, "Split on Leaving Atlantica after getting the torn page", "jj_splits");
	settings.Add("phil_cup", false, "Split on Finishing Phil Cup", "jj_splits");
	settings.Add("phil_cup_solo", false, "Split on Finishing Phil Cup solo (split triggers on red armor death)", "jj_splits");
	settings.Add("pg_cup", false, "Split on Finishing Pegasus Cup", "jj_splits");
	settings.Add("hades_seed_49", false, "Split on Finishing first 10 seeds of Hades Cup", "jj_splits");
	settings.Add("hades_seed_39", false, "Split on Finishing second 10 seeds of Hades Cup", "jj_splits");
	settings.Add("hades_seed_29", false, "Split on Finishing thrid 10 seeds of Hades Cup", "jj_splits");
	settings.Add("hades_seed_19", false, "Split on Finishing fourth 10 seeds of Hades Cup", "jj_splits");
	settings.Add("hades_seed_9", false, "Split on Finishing fifth 10 seeds of Hades Cup", "jj_splits");
	settings.Add("ice_titan", false, "Split on Ice Titan", "jj_splits");
	settings.Add("seph", false, "Split on Sephiroth", "jj_splits");
	settings.Add("kurt", false, "Split on Kurt Zisa", "jj_splits");
	settings.Add("nap_time", false, "Split on Phantom", "jj_splits");
	settings.Add("xemnas", false, "Split on Unknown", "jj_splits");

	settings.Add("plat_splits", false, "Splits for Plat trophy RTA");

	settings.Add("settings", true, "Settings");
	settings.Add("manual_back_step", false, "Setting to control if you want to re split when forced more than 1 split back", "settings");

}

start
{
	return current.newgame == 7 && old.newgame == 6;
}

split
{
	vars.summontimer = current.summonload ? vars.summontimer + (current.paused ? 0 : 1) : 0;
	// station of awakening splits
	if(vars.checkWorldValue(current.w1, current.w2, current.w3, current.w4, current.w5, current.w6, current.w7, current.w8, 0)){
		if(settings["shadows_1"] && current.room == 2 && old.room == 1 && vars.shadows_1 == 0){
			vars.shadows_1 = 1;
				return true;
		}
		if(settings["shadows_2"] && current.sora_level == 2 && current.room == 4 && (current.text_progress == 0 && old.text_progress > 0) && vars.shadows_2 == 0){
			vars.shadows_2 = 1;
				return true;
		}
		if(settings["ds1"] && ((current.fightend == 2 && old.fightend == 0) || (current.hp == 0 && old.hp > 0)) && current.room == 4 && vars.ds1 == 0){
			vars.shadows_1 = 1;
				return true;
		}
	}
	// destiny islands splits
	if(vars.checkWorldValue(current.w1, current.w2, current.w3, current.w4, current.w5, current.w6, current.w7, current.w8, 1)){
		if(settings["day_1"] && current.room == 3 && old.room == 0 && vars.day_1 == 0) {
			vars.day_1 = 1;
			return true;
		}
		if(settings["destiny"] && old.room == 2 && current.room == 3 && current.scene == 2 && vars.destiny == 0) {
			vars.destiny = 1;
			return true;
		}
		if(settings["ds2"] && (current.fightend == 2 && old.fightend == 0) && vars.ds2 == 0) {
			vars.ds2 = 1;
			return true;
		}
	}
	// traverse town splits
	if(vars.checkWorldValue(current.w1, current.w2, current.w3, current.w4, current.w5, current.w6, current.w7, current.w8, 3)){
		if(current.fightend == 2 && old.fightend == 0){
			if(settings["guard"] && current.room == 2 && vars.guard == 0){
				vars.guard = 1;
				return true;
			}
			if(current.room == 1 && vars.oppo == 0){
				if(settings["fake_guard"] && settings["oppo"]) {
					if(vars.fake_guard == 0) {
						vars.fake_guard = 1;
						vars.back_split = "fake";
					} else {
						vars.oppo = 1;
						vars.back_split = "";
					}
					return true;
				} else if(settings["fake_guard"] && !settings["oppo"]) {
					vars.back_split = "fake";
					vars.oppo = 1;
					return true;
				} else if(!settings["fake_guard"] && settings["oppo"]) {
					if(vars.fake_guard == 0) {
						vars.fake_guard = 1;
						vars.back_split = "fake";
						return false;
					}
					vars.back_split = "";
					vars.oppo = 1;
					return true;
				}
			}
		}
		if(settings["leon"] && current.room == 0 && current.scene == 3 && vars.leon == 0 && (
				(current.hp == 0 && old.hp > 0) || (current.white > 0 && old.white == 0)
			)
		){
			vars.leon = 1;
			return true;
		}
		if(settings["tt_2"] && vars.tt_2 == 0 && current.room == 10 && current.scene == 11 && current.in_gummi > 0){
			vars.tt_2 = 1;
			return true;
		}
		if(settings["tt_4"] && vars.tt_4 == 0){
			if(old.room == 32 && current.room == 22 && !vars.got_oath){
				vars.got_oath = true;
				return false;
			}
			if(current.scene == 0 && current.room == 10 && current.in_gummi > 0 && vars.got_oath){
				vars.tt_4 = 1;
				return true;
			}
		}
		if(settings["power_boost"] && vars.torn_page_power_split == 0){
			if(vars.checkWorldValue(old.w1, old.w2, old.w3, old.w4, old.w5, old.w6, old.w7, old.w8, 6) && vars.torn_page_power == 1){
				vars.torn_page_power_split = 1;
				return true;
			}
		}
		if(settings["seal_100_aw"] && vars.muddy_finish == 1 && vars.seal_100_aw == 0){
			vars.seal_100_aw = 1;
			return true;
		}
	}
	// wonderland splits
	if(vars.checkWorldValue(current.w1, current.w2, current.w3, current.w4, current.w5, current.w6, current.w7, current.w8, 4)){
		if(current.fightend == 2 && old.fightend == 0){
			if(settings["crank"] && current.room == 3 && vars.crank == 0){
				vars.crank = 1;
				return true;
			}
			if(settings["tm"] && current.room == 1 && vars.tm == 0){
				vars.tm = 1;
				return true;
			}
		}
	}
	// deep jungle splits
	if(vars.checkWorldValue(current.w1, current.w2, current.w3, current.w4, current.w5, current.w6, current.w7, current.w8, 5)){
		if(current.fightend == 2 && old.fightend == 0){
			if(settings["sabor_2"] && current.room == 2 && vars.sabor_2 == 0){
				vars.sabor_2 = 1;
				return true;
			}
			if(current.room == 11 && vars.clayton_2 == 0){
				if(settings["clayton_1"] && settings["clayton_2"]) {
					if(vars.clayton_1 == 0) {
						vars.clayton_1 = 1;
						vars.back_split = "clay1";
					} else {
						vars.clayton_2 = 1;
						vars.back_split = "";
					}
					return true;
				} else if(settings["clayton_1"] && !settings["clayton_2"]) {
					vars.back_split = "clay1";
					vars.clayton_2 = 1;
					return true;
				} else if(!settings["clayton_1"] && settings["clayton_2"]) {
					if(vars.clayton_1 == 0) {
						vars.clayton_1 = 1;
						vars.back_split = "clay1";
						return false;
					}
					vars.back_split = "";
					vars.clayton_2 = 1;
					return true;
				}
			}
		}
		if(settings["sabor_1"] && current.room == 0 && current.scene == 0 && vars.sabor_1 == 0 && (
				(current.hp == 0 && old.hp > 0) || (current.white > 0 && old.white == 0)
			) 
		){
			vars.sabor_1 = 1;
			return true;
		}
		if(settings["power_wilds"] && vars.pw == 0){
			if(current.room == 0 && current.scene == 3 && current.house_gummi != old.house_gummi && !vars.house_gummi) {
				vars.house_gummi = true;
			}
			if(current.room == 2 && current.scene == 2 && current.bamboo_gummi != old.bamboo_gummi && !vars.bamboo_gummi) {
				vars.bamboo_gummi = true;
			}
			if(current.room == 6 && current.scene == 2 && current.climb_gummi != old.climb_gummi && !vars.climb_gummi) {
				vars.climb_gummi = true;
			}
			if(current.room == 11 && current.scene == 2 && current.cliff_gummi != old.cliff_gummi && !vars.cliff_gummi) {
				vars.cliff_gummi = true;
			}
			if(current.room == 12 && current.scene == 1 && current.camp_gummi != old.camp_gummi && !vars.camp_gummi) {
				vars.camp_gummi = true;
			}
			if(vars.house_gummi && vars.bamboo_gummi && vars.climb_gummi && vars.cliff_gummi && vars.camp_gummi){
				vars.house_gummi = false;
				vars.bamboo_gummi = false;
				vars.climb_gummi = false;
				vars.cliff_gummi = false;
				vars.camp_gummi = false;
				vars.pw = 1;
				return true;
			}
		}
		if(settings["wfc"] && vars.wfc == 0 && current.room == 10 && current.scene == 0){
			vars.wfc = 1;
			return true;
		}
	}
	// 100 acre wood
	if(vars.checkWorldValue(current.w1, current.w2, current.w3, current.w4, current.w5, current.w6, current.w7, current.w8, 6)){
		if(settings["power_boost"] && current.power_boost > old.power_boost && vars.torn_page_power == 0){
			vars.torn_page_power = 1;
		}
		if(settings["torn_page_1"] && current.nature_spark == 1 && old.nature_spark == 0 && vars.nature_spark == 0){
			vars.nature_spark = 1;
			return true;
		}
		if(settings["torn_page_2"] && current.mythril_shard > old.mythril_shard && vars.torn_page_mythril_shard == 0){
			vars.torn_page_mythril_shard = 1;
			return true;
		}
		if(settings["torn_page_3"] && current.stop_level > old.stop_level && vars.stopra == 0){
			vars.stopra = 1;
			return true;
		}
		if(settings["torn_page_4"] && current.mythril > old.mythril && vars.torn_page_mythril == 0){
			vars.torn_page_mythril = 1;
			return true;
		}
		if(settings["torn_page_5"] && current.exp_ring > old.exp_ring && vars.exp_ring == 0){
			vars.exp_ring = 1;
			return true;
		}
		if(settings["seal_100_aw"] && old.room == 9 && current.room == 9 && vars.muddy_finish == 0){
			vars.muddy_finish = 1;
		}
	}
	// agrabah splits
	if(vars.checkWorldValue(current.w1, current.w2, current.w3, current.w4, current.w5, current.w6, current.w7, current.w8, 8)){
		if(current.fightend == 2 && old.fightend == 0){
			if(settings["pot"] && current.room == 19 && vars.pot == 0){
				vars.pot = 1;
				return true;
			}
			if(settings["tiger"] && current.room == 1 && vars.tiger == 0){
				vars.tiger = 1;
				return true;
			}
			if(settings["jafar"] && current.room == 16 && vars.jafar == 0){
				vars.jafar = 1;
				return true;
			}
			if(settings["gj"] && current.room == 17 && vars.gj == 0){
				vars.gj = 1;
				return true;
			}
			if(settings["kurt"] && current.room == 0 && current.scene == 13 && vars.kurt == 0){
				vars.kurt = 1;
				return true;
			}
		}
		if(settings["save_al"] && current.room == 0 && current.scene == 4 && vars.save_al == 0){
			vars.save_al = 1;
			return true;
		}
		if(settings["carpet_escape"] && current.room == 1 && current.scene == 4 && vars.carpet_escape == 0){
			vars.carpet_escape = 1;
			return true;
		}
	}
	// atlantica splits
	if(vars.checkWorldValue(current.w1, current.w2, current.w3, current.w4, current.w5, current.w6, current.w7, current.w8, 9)){
		if(settings["atlantica_1"] && vars.atlantica_1 == 0){
			if(current.torn_page_count > old.torn_page_count && current.room == 13 && vars.atl_torn_page == 0){
				vars.atl_torn_page = 1;
			}
			if(current.room == 15 && vars.atl_torn_page == 1 && current.in_gummi > 0){
				vars.atlantica_1 = 1;
				return true;
			}
		}
		if(current.fightend == 2 && old.fightend == 0){
			if(settings["urs_1"] && current.room == 12 && current.scene == 2 && vars.ursula_1 == 0){
				vars.ursula_1 = 1;
				return true;
			}
			if(settings["urs_2"] && current.room == 16 && vars.ursula_2 == 0){
				vars.ursula_2 = 1;
				return true;
			}
		}
	}
	// halloween town splits
	if(vars.checkWorldValue(current.w1, current.w2, current.w3, current.w4, current.w5, current.w6, current.w7, current.w8, 10)){
		if(current.fightend == 2 && old.fightend == 0){
			if(settings["lsb"] && current.room == 9 && vars.lsb == 0){
				vars.lsb = 1;
				return true;
			}
			if(settings["oogie"] && current.room == 7 && vars.oogie == 0){
				vars.oogie = 1;
				return true;
			}
			if(settings["oogie_manor"] && current.room == 8 && vars.oogie_manor == 0){
				vars.oogie_manor = 1;
				return true;
			}
		}
		if(settings["fmn"] && current.room == 10 && current.fmn == 0 && old.fmn == 1 && vars.fmn == 0){
			vars.fmn = 1;
			return true;
		}
		if(settings["jb"] && current.room == 10 && current.jb == 0 && old.jb == 1 && vars.jb == 0){
			vars.jb = 1;
			return true;
		}
	}
	// olympus coliseum splits
	if(vars.checkWorldValue(current.w1, current.w2, current.w3, current.w4, current.w5, current.w6, current.w7, current.w8, 11)){
		if(current.fightend == 2 && old.fightend == 0){
			if(settings["cloud_1"] && current.room == 2 && current.scene == 0 && vars.cloud_1 == 0){
				vars.cloud_1 = 1;
				return true;
			}
			if(settings["cerb_1"] && current.room == 2 && current.scene == 1 && vars.cerb_1 == 0){
				vars.cerb_1 = 1;
				return true;
			}
			if(settings["pg_cup"] && current.room == 5 && current.scene == 0 && vars.pg_cup == 0){
				vars.pg_cup = 1;
				return true;
			}
			if(current.room == 2 && current.scene == 9 && vars.herc == 0){
				if(settings["cloud_2"] && settings["herc_cup"]) {
					if(vars.cloud_2 == 0) {
						vars.cloud_2 = 1;
						vars.back_split = "cloud2";
					} else {
						vars.herc = 1;
						vars.back_split = "";
					}
					return true;
				} else if(settings["cloud_2"] && !settings["herc_cup"]) {
					vars.back_split = "cloud2";
					vars.herc = 1;
					return true;
				} else if(!settings["cloud_2"] && settings["herc_cup"]) {
					if(vars.cloud_2 == 0) {
						vars.cloud_2 = 1;
						vars.back_split = "cloud2";
						return false;
					}
					vars.back_split = "";
					vars.herc = 1;
					return true;
				}
			}
			if(settings["hades_seed_39"] && current.room == 2 && current.scene == 11 && vars.hades_seed_39 == 0){
				vars.hades_seed_39 = 1;
				return true;
			}
			if(settings["hades_seed_19"] && current.room == 6 && current.scene == 4 && vars.hades_seed_19 == 0){
				vars.hades_seed_19 = 1;
				return true;
			}
			if(settings["hades_seed_9"] && current.room == 5 && current.scene == 13 && vars.hades_seed_9 == 0){
				vars.hades_seed_9 = 1;
				return true;
			}
			if(settings["ice_titan"] && current.room == 6 && current.scene == 5 && vars.ice_titan == 0){
				vars.ice_titan = 1;
				return true;
			}
			if(settings["seph"] && current.room == 6 && current.scene == 6 && vars.seph == 0){
				vars.seph = 1;
				return true;
			}
			return true;
		}
		if(settings["thunder"] && vars.thunder == 0){
			if(current.room == 1 && current.scene == 2 && old.room == 2 && vars.barrel_game == 0){
				vars.barrel_game = 1;
				return false;
			}
			if(current.room == 0 && current.scene == 1 && vars.barrel_game == 1 && current.in_gummi > 0){
				vars.thunder = 1;
				return true;
			}
		}
		if(settings["phil_cup"] && current.gravity_level > old.gravity_level && vars.phil_cup == 0){
			vars.phil_cup = 1;
			return true;
		}
		if(settings["phil_cup_solo"] && current.party_slot_1 == 255 && current.party_slot_2 == 255 && current.room == 2 && current.scene == 7 && vars.phil_cup_solo == 0){
			if(current.non_player_unit_count == 1 && old.non_player_unit_count == 0){
				vars.phil_cup_solo = 1;
				return true;
			}
		}
		if(settings["hades_seed_49"] && current.room == 5 && current.scene == 11 && current.colo_behemoth_health == 0 && old.colo_behemoth_health > 0 && vars.hades_seed_49 == 0){
			vars.hades_seed_49 = 1;
			return true;
		}
		if(settings["hades_seed_29"] && current.room == 5 && current.scene == 4 && vars.hades_seed_29 == 0){
			if(current.non_player_unit_count == 2 && old.non_player_unit_count == 0 && vars.in_cloud_leon_fight == 0){
				vars.in_cloud_leon_fight = 1;
			}
			if(vars.in_cloud_leon_fight == 1 && current.non_player_unit_count == 0 && old.non_player_unit_count == 1){
				vars.hades_seed_29 = 1;
				return true;
			}
		}
	}
	// monstro splits
	if(vars.checkWorldValue(current.w1, current.w2, current.w3, current.w4, current.w5, current.w6, current.w7, current.w8, 12)){
		if(current.fightend == 2 && old.fightend == 0){
			if(settings["pc"] && current.room == 4 && vars.pc == 0){
				vars.pc = 1;
				return true;
			}
			if(settings["pc2"] && current.room == 2 && vars.pc2 == 0){
				vars.pc2 = 1;
				return true;
			}
		}
	}

	// neverland splits
	if(vars.checkWorldValue(current.w1, current.w2, current.w3, current.w4, current.w5, current.w6, current.w7, current.w8, 13)){
		if(current.fightend == 2 && old.fightend == 0){
			if(settings["anti"] && current.room == 6 && vars.anti == 0){
				vars.anti = 1;
				return true;
			}
			if(settings["hook"] && current.room == 8 && vars.hook == 0){
				vars.hook = 1;
				return true;
			}
			if(settings["nap_time"] && current.room == 9 && current.scene == 1 && vars.nap == 0){
				vars.nap = 1;
				return true;
			}
		}
		if(settings["ship"] && (current.gummi_start == 10 || current.gummi_start == 9) && current.gummi_dest == 13 && current.cutscene && vars.ship == 0){
			vars.ship = 1;
			return true;
		}
	}
	// hollow bastion splits
	if(vars.checkWorldValue(current.w1, current.w2, current.w3, current.w4, current.w5, current.w6, current.w7, current.w8, 15)){
		if(current.fightend == 2 && old.fightend == 0){
			if(settings["riku"] && current.room == 4 && vars.riku == 0){
				vars.riku = 1;
				return true;
			}
			if(settings["mal"] && current.room == 11 && vars.mal == 0){
				vars.mal = 1;
				return true;
			}
			if(settings["dragon"] && current.room == 12 && current.scene == 0 && vars.dragon == 0){
				vars.dragon = 1;
				return true;
			}
			if(settings["riku2"] && current.room == 14 && vars.riku2 == 0){
				vars.riku2 = 1;
				return true;
			}
			if(settings["behemoth"] && current.room == 15 && vars.behemoth == 0){
				vars.behemoth = 1;
				return true;
			}
		}
		if(settings["emblem"] && old.room == 11 && current.room == 4 && current.scene == 13 && vars.emblem == 0){
			vars.emblem = 1;
			return true;
		}
		if(settings["dumbo_1"] && current.room == 3 && current.scene == 13 && vars.dumbo_1 == 0 && current.summonload && vars.summontimer > 30){
			vars.dumbo_1 = 1;
			return true;
		}
		if(settings["dumbo_2"] && current.room == 1 && current.scene == 14 && vars.dumbo_2 == 0 && current.summonload && vars.summontimer > 30){
			vars.dumbo_2 = 1;
			return true;
		}
		if(settings["dumbo_3"] && current.room == 3 && current.scene == 14 && vars.dumbo_3 == 0 && current.summonload && vars.summontimer > 30){
			vars.dumbo_3 = 1;
			return true;
		}
		if(settings["xemnas"] && current.room == 12 && current.scene == 2 && current.exp_necklace > old.exp_necklace && vars.xemnas == 0){
			vars.xemnas = 1;
			return true;
		}
	}
	// end of world splits
	if(vars.checkWorldValue(current.w1, current.w2, current.w3, current.w4, current.w5, current.w6, current.w7, current.w8, 16)){
		if(current.fightend == 2 && old.fightend == 0){
			if(settings["cher"] && current.room == 26 && vars.cher == 0){
				vars.cher = 1;
				return true;
			}
			if(settings["a1"] && current.room == 30 && vars.a1 == 0){
				vars.a1 = 1;
				return true;
			}
			if(settings["ds3"] && current.room == 30 && vars.ds3 == 0){
				if(!settings["a1"] && vars.a1 == 0){
					vars.a1 = 1;
					return false;
				}
				vars.ds3 = 1;
				vars.back_split = "ds3";
				return true;
			}
			if(settings["a2"] && current.room == 30 && vars.a2 == 0){
				if(!settings["ds3"] && vars.ds3 == 0){
					vars.ds3 = 1;
					return false;
				}
				vars.a2 = 1;
				vars.back_split = "";
				return true;
			}
			if(settings["a3"] && current.room == 33 && vars.a3 == 0){
				vars.a3 = 1;
				return true;
			}
			if(settings["sc"] && current.room == 36 && vars.sc == 0){
				vars.sc = 1;
				return true;
			}
			if(settings["dbc"] && current.room == 37 && vars.dbc == 0){
				vars.dbc = 1;
				return true;
			}
			if(settings["face"] && current.room == 33 && vars.face == 0){
				vars.face = 1;
				return true;
			}
			if(settings["inc"] && current.room == 38 && vars.inc == 0){
				vars.inc = 1;
				return true;
			}
			if(settings["mc"] && current.room == 33 && vars.mc == 0){
				vars.mc = 1;
				return true;
			}
			if(current.room == 33 && vars.final_fight == 0){
				vars.final_fight = 1;
				return true;
			}
		}
		if(settings["arch"] && current.room == 14 && vars.arch == 0){
			vars.arch = 1;
			return true;
		}
		if(settings["oc"] && old.room == 18 && current.room == 15 && vars.oc == 0){
			vars.oc = 1;
			return true;
		}
		if(settings["atl"] && old.room == 21 && current.room == 15 && vars.atl == 0){
			vars.atl = 1;
			return true;
		}
		if(settings["hbp"] && old.room == 25 && current.room == 15 && vars.hbp == 0){
			vars.hbp = 1;
			return true;
		}
		if(settings["behemoth_3"] && current.room == 28 && vars.behemoth_3 == 0 && (current.behemoth_3_health == 0 && old.behemoth_3_health > 0)){
			vars.behemoth_3 = 1;
		 	vars.back_split = "be3";
			return true;
		}
		if(settings["finalrest"] && current.room == 29 && vars.finalrest == 0){
			vars.finalrest = 1;
			vars.back_split = "";
			return true;
		}
		if(settings["artillery"] && old.room == 33 && current.room == 37 && vars.artillery == 0){
			vars.artillery = 1;
			return true;
		}
	}
	// settings
	if(settings["manual_back_step"] && current.hp == 0 && old.hp > 0 && (vars.back_split == "clay1" || vars.back_split == "fake" || vars.back_split == "be3" || vars.back_split == "ds3")){
		if(vars.back_split == "clay1") {
			if(!settings["clayton_2"]){
				vars.clayton_2 = 0;
			} else {
				vars.clayton_1 = 0;
			}
		}
		if(vars.back_split == "fake") {
			if(!settings["oppo"]){
				vars.oppo = 0;
			} else {
				vars.fake_guard = 0;
			}
		}
		if(vars.back_split == "cloud2") {
			if(!settings["herc_cup"]){
				vars.herc = 0;
			} else {
				vars.cloud_2 = 0;
			}
		}
		if(vars.back_split == "be3") {
			vars.behemoth_3 = 0;
		}
		if(vars.back_split == "ds3") {
			vars.ds3 = 0;
		}
	}
	// WIP general fight end splits
	if(current.fightend == 2 && old.fightend == 0){
		if(vars.checkWorldValue(current.w1, current.w2, current.w3, current.w4, current.w5, current.w6, current.w7, current.w8, 9)){
			return true;
		}
		else if(vars.checkWorldValue(current.w1, current.w2, current.w3, current.w4, current.w5, current.w6, current.w7, current.w8, 11)){
			return true;
		}
	}
	return false;
}

exit
{
	vars.booting = true;
	timer.IsGameTimePaused = true;
}

init
{
	vars.camp_gummi = false;
	vars.climb_gummi = false;
	vars.house_gummi = false;
	vars.cliff_gummi = false;
	vars.bamboo_gummi = false;
	vars.got_oath = false;
	vars.shadows_1 = 0;
	vars.shadows_2 = 0;
	vars.ds1 = 0;
	vars.day_1 = 0;
	vars.destiny = 0;
	vars.ds2 = 0;
	vars.leon = 0;
	vars.guard = 0;
	vars.barrel_game = 0;
	vars.thunder = 0;
	vars.cloud_1 = 0;
	vars.cerb_1 = 0;
	vars.phil_cup = 0;
	vars.phil_cup_solo = 0;
	vars.pg_cup = 0;
	vars.cloud_2 = 0;
	vars.herc = 0;
	vars.hades_seed_49 = 0;
	vars.hades_seed_39 = 0;
	vars.in_cloud_leon_fight = 0;
	vars.hades_seed_29 = 0;
	vars.hades_seed_19 = 0;
	vars.hades_seed_9 = 0;
	vars.ice_titan = 0;
	vars.seph = 0;	
	vars.crank = 0;
	vars.tm = 0;
	vars.sabor_1 = 0;
	vars.pw = 0;
	vars.sabor_2 = 0;
	vars.clayton_1 = 0;
	vars.clayton_2 = 0;
	vars.wfc = 0;
	vars.tt_2 = 0;
	vars.torn_page_power = 0;
	vars.torn_page_power_split = 0;
	vars.nature_spark = 0;
	vars.torn_page_mythril_shard = 0;
	vars.stopra = 0;
	vars.torn_page_mythril = 0;
	vars.exp_ring = 0;
	vars.muddy_finish = 0;
	vars.seal_100_aw = 0;
	vars.save_al = 0;
	vars.pot = 0;
	vars.tiger = 0;
	vars.jafar = 0;
	vars.gj = 0;
	vars.kurt = 0;
	vars.carpet_escape = 0;
	vars.atl_torn_page = 0;
	vars.atlantica_1 = 0;
	vars.ursula_1 = 0;
	vars.ursula_2 = 0;
	vars.pc = 0;
	vars.pc2 = 0;
	vars.fmn = 0;
	vars.jb = 0;
	vars.lsb = 0;
	vars.oogie = 0;
	vars.oogie_manor = 0;
	vars.ship = 0;
	vars.anti = 0;
	vars.hook = 0;
	vars.nap = 0;
	vars.fake_guard = 0;
	vars.oppo = 0;
	vars.riku = 0;
	vars.emblem = 0;
	vars.dumbo_1 = 0;
	vars.mal = 0;
	vars.dragon = 0;
	vars.riku2 = 0;
	vars.tt_4 = 0;
	vars.dumbo_2 = 0;
	vars.dumbo_3 = 0;
	vars.behemoth = 0;
	vars.arch = 0;
	vars.oc = 0;
	vars.atl = 0;
	vars.hbp = 0;
	vars.cher = 0;
	vars.behemoth_3 = 0;
	vars.finalrest = 0;
	vars.a1 = 0;
	vars.ds3 = 0;
	vars.a2 = 0;
	vars.a3 = 0;
	vars.sc = 0;
	vars.artillery = 0;
	vars.dbc = 0;
	vars.face = 0;
	vars.inc = 0;
	vars.mc = 0;
	vars.final_fight = 0;
	vars.back_split = "";
	timer.IsGameTimePaused = false;
	Func <ushort, ushort, ushort, ushort, ushort, ushort, ushort, ushort, int, bool> checkWorldValue = (ushort a, ushort b, ushort c, ushort d, ushort e, ushort f, ushort g, ushort h, int actual) => {
		return a == actual || b == actual || c == actual || d == actual || e == actual || f == actual || f == actual || g == actual || h == actual;
	};
	vars.checkWorldValue = checkWorldValue;
}

update
{
	if(vars.booting && current.titlescreen == 1){
		vars.booting = false;
	}
}

isLoading
{
	vars.summontimer = current.summonload ? vars.summontimer + (current.paused ? 0 : 1) : 0;
	
	return ((current.load 
	|| !current.blackInv
	|| (current.white == 128 && !current.cutscene)
	|| vars.summontimer > 30) && !current.paused)
	|| current.saveload
	|| current.partyload
	|| (current.load2 && current.hp == 0) 
	|| vars.booting;
}
