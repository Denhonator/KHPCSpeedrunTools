state("KINGDOM HEARTS FINAL MIX", "EG Global") // 1.0.0.10
{
    // location info
    ushort room : 0x2340EC4;
    ushort scene : 0x2340EC8;
    ushort world : 0x2340ECC;
    byte white : 0x234081C;
    byte in_gummi : 0x50832D;
    byte magic_unlock_val : 0x2DE9DD4;
    byte arch_behemoth_kills : 0x2DEA59A;

    byte8 collected_items_1 : 0x2DEA202;
    byte102 collected_items_2 : 0x2DEA291;  
    byte33 power_wild_gummis : 0x2DF5BDC;
    byte42 equips : 0x2DEA233;
    byte225 magic_levels : 0x2D235F0;
    byte96 enemies_defeated : 0x2DEA53A;
    byte torn_page_count : 0x2DEB160;
    byte6 trinity_counts : 0x2DEB9C6;
    ushort puppy_count : 0x2E9DB28;
    ushort mini_game_count : 0x2E9DD74;
}

state("KINGDOM HEARTS FINAL MIX", "EG JP") // 1.0.0.10
{
    // location info
    ushort room : 0x2340EC4;
    ushort scene : 0x2340EC8;
    ushort world : 0x2340ECC;
    byte white : 0x234081C;
    byte in_gummi : 0x50832D;
    byte magic_unlock_val : 0x2DE9DD4;
    byte arch_behemoth_kills : 0x2DEA59A;

    byte8 collected_items_1 : 0x2DEA202;
    byte102 collected_items_2 : 0x2DEA291;  
    byte33 power_wild_gummis : 0x2DF5BDC;
    byte42 equips : 0x2DEA233;
    byte225 magic_levels : 0x2D235F0;
    byte96 enemies_defeated : 0x2DEA53A;
    byte torn_page_count : 0x2DEB160;
    byte6 trinity_counts : 0x2DEB9C6;
    ushort puppy_count : 0x2E9DB28;
    ushort mini_game_count : 0x2E9DD74;
}

state("KINGDOM HEARTS FINAL MIX", "Steam Global") // 1.0.0.2
{
    // location info
    ushort room : 0x233FE8C;
    ushort scene : 0x233FE90;
    ushort world : 0x233FE94;
    byte white : 0x233FE1C;
    byte in_gummi : 0x5075A8; // differs to cover a change on linux systems
    byte magic_unlock_val : 0x2DE93D4;
    byte arch_behemoth_kills : 0x2DE9B9A;

    byte8 collected_items_1 : 0x2DE9802;
    byte102 collected_items_2 : 0x2DE9891;  
    byte33 power_wild_gummis : 0x2DF51DC;
    byte42 equips : 0x2DE9833;
    byte225 magic_levels : 0x2D22BF0;
    byte96 enemies_defeated : 0x2DE9B3A;
    byte torn_page_count : 0x2DEA760;
    byte6 trinity_counts : 0x2DEAFC6;
    ushort puppy_count : 0x2E9D148;
    ushort mini_game_count : 0x2E9D394;
}

state("KINGDOM HEARTS FINAL MIX", "Steam JP") // 1.0.0.2
{
    // location info
    ushort room : 0x233FE8C;
    ushort scene : 0x233FE90;
    ushort world : 0x233FE94;
    byte white : 0x233FE1C;
    byte in_gummi : 0x5075A8; // differs to cover a change on linux systems
    byte magic_unlock_val : 0x2DE93D4;
    byte arch_behemoth_kills : 0x2DE9B9A;

    byte8 collected_items_1 : 0x2DE9802;
    byte102 collected_items_2 : 0x2DE9891;  
    byte33 power_wild_gummis : 0x2DF51DC;
    byte42 equips : 0x2DE9833;
    byte225 magic_levels : 0x2D22BF0;
    byte96 enemies_defeated : 0x2DE9B3A;
    byte torn_page_count : 0x2DEA760;
    byte6 trinity_counts : 0x2DEAFC6;
    ushort puppy_count : 0x2E9D148;
    ushort mini_game_count : 0x2E9D394;
}

startup
{
    vars.booting = false;
    vars.summon_timer = 0;

    settings.Add("main", true, "End of section splits");
        settings.Add("ds1", true, "Darkside 1", "main");
        settings.Add("ds2", true, "Darkside 2", "main");
        settings.Add("guard", true, "Guard Armor", "main");
        settings.Add("tm", true, "Trick Master", "main");
        settings.Add("clayton_2", true, "Clayton 2", "main");
        settings.Add("gj", true, "Genie Jafar", "main");
        settings.Add("pc2", true, "Parasite Cage 2", "main");
        settings.Add("oogie_manor", true, "Oogie Manor", "main");
        settings.Add("hook", true, "Captain Hook", "main");
        settings.Add("oppo", true, "Opposite Armor", "main");
        settings.Add("riku2", true, "Riku 2", "main");
        settings.Add("behemoth", true, "Behemoth", "main");
        settings.Add("cher", true, "Chernabog", "main");
        settings.Add("a2", true, "Ansem 2", "main");

    settings.Add("optional_splits", true, "All other Any % splits");
        settings.Add("shadows_1", false, "Shadows 1 (first full group)", "optional_splits");
        settings.Add("shadows_2", false, "Shadows 2 (post save point cutscene)", "optional_splits");
        settings.Add("day_1", false, "Destiny Islands Day One", "optional_splits");
        settings.Add("destiny", false, "Destiny Islands Day Two (on raft supplies claimed)", "optional_splits");
        settings.Add("destiny_opt", false, "Destiny Islands Day Two (on transition)", "optional_splits");
        settings.Add("leon", true, "Leon", "optional_splits");
        settings.Add("crank", true, "Crank Tower - Fight End", "optional_splits");
        settings.Add("crank_alt", true, "Crank Tower - Post Fight Cutscene", "optional_splits");
        settings.Add("sabor_1", true, "Sabor 1", "optional_splits");
        settings.Add("power_wilds", false, "Split after Power Wilds", "optional_splits");
        settings.Add("sabor_2", true, "Sabor 2", "optional_splits");
        settings.Add("clayton_1", false, "Clayton 1", "optional_splits");
        settings.Add("wfc", false, "Waterfall Cavern", "optional_splits");
        settings.Add("tt_2", false, "Traverse Town 2", "optional_splits");
        settings.Add("save_al", false, "Save Aladdin", "optional_splits");
        settings.Add("pot", true, "Pot Centipede", "optional_splits");
        settings.Add("tiger", true, "Tiger Head", "optional_splits");
        settings.Add("jafar", true, "Jafar", "optional_splits");
        settings.Add("carpet_escape", false, "Carpet Escape", "optional_splits");
        settings.Add("pc", true, "Parasite Cage 1", "optional_splits");
        settings.Add("fmn", false, "Forget Me Not", "optional_splits");
        settings.Add("jb", false, "Jack in the Box", "optional_splits");
        settings.Add("lsb", true, "LSB", "optional_splits");
        settings.Add("oogie", true, "Oogie Boogie", "optional_splits");
        settings.Add("ship_early", false, "Hooks Ship (in gummi mission)", "optional_splits");
        settings.Add("ship", false, "Hooks Ship (at first cutscene in world)", "optional_splits");
        settings.Add("anti", true, "Anti Sora", "optional_splits");
        settings.Add("pre_hook", false, "Pre Hook", "optional_splits");
        settings.Add("fake_guard", false, "Fake Guard Armor", "optional_splits");
        settings.Add("riku", true, "Riku 1", "optional_splits");
        settings.Add("emblem", false, "Emblem Door", "optional_splits");
        settings.Add("dumbo_1", false, "Dumbo Skip 1", "optional_splits");
        settings.Add("mal", true, "Maleficent", "optional_splits");
        settings.Add("dragon", true, "Dragon Maleficent", "optional_splits");
        settings.Add("tt_4", false, "Traverse Town 4", "optional_splits");
        settings.Add("dumbo_2", false, "Dumbo Skip 2", "optional_splits");
        settings.Add("dumbo_3", false, "Dumbo Skip 3", "optional_splits");
        settings.Add("arch", false, "Arch Behemoth", "optional_splits");
        settings.Add("oc_portal", false, "Olympus Coliseum portal", "optional_splits");
        settings.Add("atl_portal", false, "Atlantica portal", "optional_splits");
        settings.Add("hbp", false, "Hollow Bastion portal", "optional_splits");
        settings.Add("behemoth_3", false, "Behemoth 3 (final rest)", "optional_splits");
        settings.Add("final_rest", true, "Enter Final Rest", "optional_splits");
        settings.Add("a1", true, "Ansem 1", "optional_splits");
        settings.Add("ds3", true, "Dark Side 3", "optional_splits");
        settings.Add("a3", true, "Ansem 3", "optional_splits");
        settings.Add("sc", true, "Shadow Core", "optional_splits");
        settings.Add("artillery", false, "Artillery", "optional_splits");
        settings.Add("dbc", true, "Dark Ball Core", "optional_splits");
        settings.Add("face", true, "Face", "optional_splits");
        settings.Add("invc", true, "Invisible Core", "optional_splits");
        settings.Add("mc", true, "Main Core", "optional_splits");

    settings.Add("all_worlds_splits", false, "All Worlds categories");
        settings.Add("thunder", false, "Thunder", "all_worlds_splits");
        settings.Add("power_boost", false, "100 Acre Wood Power Boost", "all_worlds_splits");
        settings.Add("torn_page_1", false, "Torn Page 1 Complete", "all_worlds_splits");
        settings.Add("torn_page_2", false, "Torn Page 2 Complete", "all_worlds_splits");
        settings.Add("torn_page_3", false, "Torn Page 3 Complete", "all_worlds_splits");
        settings.Add("torn_page_4", false, "Torn Page 4 Complete", "all_worlds_splits");
        settings.Add("torn_page_5", false, "Torn Page 5 Complete", "all_worlds_splits");
        settings.Add("seal_100_aw", false, "100 Acre Wood", "all_worlds_splits");
        settings.Add("cloud_1", false, "Cloud 1", "all_worlds_splits");
        settings.Add("cerb_1", false, "Cerberus 1", "all_worlds_splits");
        settings.Add("cloud_2", false, "Cloud 2", "all_worlds_splits");
        settings.Add("herc_cup", false, "Hercules Cup", "all_worlds_splits");
        settings.Add("atl_dock", false, "Atlantica Dock", "all_worlds_splits");
        settings.Add("urs_1", false, "Ursula 1", "all_worlds_splits");
        settings.Add("urs_2", false, "Ursula 2", "all_worlds_splits");

    settings.Add("jj_splits", false, "Jimminy's Journal categories");
        settings.Add("hb_2", false, "Behemoth + Library Clean Up", "jj_splits");
        settings.Add("atlantica_1", false, "Atlantica 1 (torn page)", "jj_splits");
        settings.Add("phil_cup", false, "Phil Cup", "jj_splits");
        settings.Add("phil_cup_solo", false, "Phil Cup (solo)", "jj_splits");
        settings.Add("pg_cup", false, "Pegasus Cup", "jj_splits");
        settings.Add("hades_seed_49", false, "Hades Cup Seed 49 -> 40", "jj_splits");
        settings.Add("hades_seed_39", false, "Hades Cup Seed 39 -> 30", "jj_splits");
        settings.Add("hades_seed_29", false, "Hades Cup Seed 29 -> 20", "jj_splits");
        settings.Add("hades_seed_19", false, "Hades Cup Seed 19 -> 10", "jj_splits");
        settings.Add("hades_seed_9", false, "Hades Cup Seed 9 -> End", "jj_splits");
        settings.Add("ice_titan", false, "Ice Titan", "jj_splits");
        settings.Add("seph", false, "Sephiroth", "jj_splits");
        settings.Add("kurt", false, "Kurt Zisa", "jj_splits");
        settings.Add("nap_time", false, "Phantom", "jj_splits");
        settings.Add("xemnas", false, "Unknown", "jj_splits");
        // If a split breaks/a reroute happens update the dictionary in the init for the sepcific world and difficulty
        settings.Add("revisit_jj_check", false, "Revists checking Journal collection (breakable by reroute)", "jj_splits");
            settings.Add("wl_2", false, "Wonderland Revisit", "revisit_jj_check");
            settings.Add("dj_2", false, "Deep Jungle Revisit", "revisit_jj_check");
            settings.Add("ag_2", false, "Agrabah Revisit", "revisit_jj_check");
            settings.Add("mo_2", false, "Monstro Revisit", "revisit_jj_check");
            settings.Add("ht_2", false, "Halloween Town Revisit", "revisit_jj_check");
            settings.Add("nl_2", false, "Neverland Revisit", "revisit_jj_check");
            settings.Add("eow", false, "End of the World 1", "revisit_jj_check");
            settings.Add("jj_complete", false, "Journal Complete - Enter Final Fights", "revisit_jj_check");
            settings.Add("jj_complete_early", false, "Journal Complete - Check", "revisit_jj_check");

    settings.Add("plat_splits", false, "Plat trophy RTA");
        settings.Add("gummi_kills", false, "2.5k Gummi Kills", "plat_splits");
        settings.Add("each_mat", false, "1 Each Rare Synth", "plat_splits");
        settings.SetToolTip(
            "each_mat",
            "Split after collecting one of each rare synthasis material."
        );
        settings.Add("tt_final", false, "Traverse Town Final", "plat_splits");
        settings.SetToolTip(
            "tt_final",
            "Split when exiting Traverse Town with Ultima Weapon and Aeroga."
        );
        settings.Add("more", false, "More to come!", "plat_splits");


    settings.Add("misc", false, "misc catagories");
        settings.Add("coco", false, "99 coconut", "misc");
            settings.Add("per_10", false, "Every 10 (and final 9)", "coco");
            settings.Add("per_1", false, "Every nut", "coco");
        settings.Add("boss_rush", false, "Boss Rush", "misc");
            settings.Add("custom_install", false, "Custom game install location", "boss_rush");
            settings.SetToolTip(
                "custom_install",
                "Check this and update the path in the asl file if you have the game installed in a non standard location for use with the boss rush!"
            );

    settings.Add("settings", false, "Settings");
        settings.Add("re-split", false, "Re split", "settings");
            settings.SetToolTip(
                "re-split",
                "When set, splits will trigger more than once if a death occurs." +
                "\nFor example if you die to Ansem 2, Darkside 3 will split again."
            );
}

start
{
    // resets all used variables on restart
    vars.completed_splits = new HashSet<string>();
    vars.completed_fights = new HashSet<string>();

    // traverse town vars
    vars.fake_guard = false;
    vars.oppo = false;
    vars.aero_level_up = false;

    // wonderland vars
    vars.wl_counts = false;
    vars.wl_2_complete = false;

    // deep jungle vars
    vars.pw_gummis = 0;
    vars.clayton_1 = false;
    vars.clayton_2 = false;
    vars.dj_counts = false;
    vars.dj_2_complete = false;

    // agrabah vars
    vars.ag_counts = false;
    vars.ag_2_complete = false;

    // atlantica vars
    vars.atl_torn_page = false;

    // halloween town vars
    vars.ht_counts = false;
    vars.ht_2_complete = false;

    // olympus coliseum vars
    vars.cloud_2 = false;
    vars.herc_cup = false;
    vars.next_ability_slot_idx = 0;

    // monstro vars
    vars.mo_counts = false;
    vars.mo_2_complete = false;

    // neverland vars
    vars.pre_hook = false;
    vars.nl_counts = false;
    vars.nl_2_complete = false;

    // end of world vars
    vars.journal_complete = false;
    vars.behemoth_3 = false;
    vars.ds3 = false;

    // outside world vars
    vars.world_puppies_complete = false;
    vars.world_enemies_complete = false;
    vars.world_trinities_complete = false;
    vars.world_mini_game_complete = false;
    vars.gummi_kills = 0;

    // misc category vars
    vars.finished_nut = false;

    // manual back step vars
    vars.back_split = "";

    var ng = vars.watchers["newgame"];
    ng.Update(game);
    if (settings["boss_rush"]) {
        var drives = "CDEFGHIJKLMNOPQRSTUVWXYZ";
        var base_path = @":\Program Files\Epic Games\KH_1.5_2.5";
        if (settings["custom_install"]) {
            base_path = @":\Users\chuds\Desktop\KH Current\KH_1.5_2.5";
        }
        foreach (char drive in drives) {
            if (Directory.Exists(drive + base_path)) {
                vars.autosavedst = drive + base_path + @"\autosave.dat";
                break;
            } 
        }
        File.Copy(@"Boss Rush\001_Darkside 1.dat", vars.autosavedst, true);
    } else {
        return ng.Current == 7 && ng.Old == 6;
    }
}

split
{
    int current_world = current.world;
    int old_world = old.world;
    var output_catch = "";
    var fightend = vars.watchers["fightend"];
    var cutscene = vars.watchers["cutscene"];
    var eow_scene = vars.watchers["eow_scene"];
    var text_progress = vars.watchers["text_progress"];
    var sora_hp = vars.watchers["sora_hp"];
    var summon_load = vars.watchers["summon_load"];
    var paused = vars.watchers["paused"];
    var gummi_start_world = vars.watchers["gummi_start_world"];
    var gummi_destination_world = vars.watchers["gummi_destination_world"];
    bool fight_complete = fightend.Current == 2 && fightend.Old == 0;
    bool death = sora_hp.Current == 0 && sora_hp.Old > 0;
    vars.summon_timer = summon_load.Current ? vars.summon_timer + (paused.Current ? 0 : 1) : 0;

    // Final fight split always goes
    if (fight_complete && current_world == 16 && current.room == 33 && current.scene == 4){
        if (settings["boss_rush"]) {
            File.Copy(@"Boss Rush\001_Darkside 1.dat", vars.autosavedst, true);
        }
        return true;
    }

    if (settings["main"]){
        if (death){
            // death abuse splits
            if (current_world == 0 && current.room == 4){
                if (settings["boss_rush"]) {
                    File.Copy(@"Boss Rush\002_Darkside 2.dat", vars.autosavedst, true);
                }
                return settings["ds1"];
            }
        }
        if (fight_complete){
            // fight win splits
            switch (current_world){
                // station of awakening
                case 0:
                    if (current.room == 4){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\002_Darkside 2.dat", vars.autosavedst, true);
                        }
                        return settings["ds1"];
                    }
                    break;
                // destiny islands
                case 1:
                    if (current.room == 8){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\003_Leon.dat", vars.autosavedst, true);
                        }
                        return settings["ds2"];
                    }
                    break;
                // traverse town
                case 3:
                    if (current.room == 2){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\005_Crank Tower.dat", vars.autosavedst, true);
                        }
                        return settings["guard"];
                    }
                    if (current.room == 1){
                        if (!settings["optional_splits"] && !vars.fake_guard){
                            vars.back_split = "fake";
                            vars.fake_guard = true;
                            return false;
                        }
                        if (vars.fake_guard){
                            vars.back_split = "";
                            if (settings["boss_rush"]) {
                                File.Copy(@"Boss Rush\021_Riku 1.dat", vars.autosavedst, true);
                            }
                            return settings["oppo"];
                        }
                    }
                    break;
                // wonderland
                case 4:
                    if (current.room == 1){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\007_Sabor 2.dat", vars.autosavedst, true);
                        }
                        return settings["tm"];
                    }
                    break;
                // deep jungle
                case 5:
                    if (current.room == 11){
                        if (!settings["optional_splits"] && !vars.clayton_1){
                            vars.back_split = "clay1";
                            vars.clayton_1 = true;
                            return false;
                        }
                        if (vars.clayton_1){
                            vars.back_split = "";
                            if (settings["boss_rush"]) {
                                File.Copy(@"Boss Rush\009_Pot Centipede.dat", vars.autosavedst, true);
                            }
                            return settings["clayton_2"];
                        }
                    }
                    break;
                // agrabah
                case 8:
                    if (current.room == 17){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\013_Parasite Cage 1.dat", vars.autosavedst, true);
                        }
                        return settings["gj"];
                    }
                    break;
                // halloween town
                case 10:
                    if (current.room == 8){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\018_Anti Sora.dat", vars.autosavedst, true);
                        }
                        return settings["oogie_manor"];
                    }
                    break;
                // monstro
                case 12:
                    if (current.room == 2){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\015_Lock Shock Barrel.dat", vars.autosavedst, true);
                        }
                        return settings["pc2"];
                    }
                    break;
                // neverland
                case 13:
                    if (current.room == 8){
                        vars.back_split = "";
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\020_Opposite Armor.dat", vars.autosavedst, true);
                        }
                        return settings["hook"];
                    }
                    break;
                // hollow bastion
                case 15:
                    if (current.room == 14){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\025_Behemoth.dat", vars.autosavedst, true);
                        }
                        return settings["riku2"];
                    }
                    if (current.room == 15){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\026_Arch Behemoth.dat", vars.autosavedst, true);
                        }
                        return settings["behemoth"];
                    }
                    break;
                // end of world
                case 16:
                    if (current.room == 26){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\028_Ansem 1.dat", vars.autosavedst, true);
                        }
                        return settings["cher"];
                    }
                    eow_scene.Update(game); 
                    if (current.room == 30 && eow_scene.Current == 257){
                        if (!settings["optional_splits"]){
                            if (!vars.ds3){
                                vars.back_split = "ds3";
                                vars.ds3 = true;
                                return false;
                            }
                        }
                        if (vars.ds3){
                            vars.back_split = "";
                            if (settings["boss_rush"]) {
                                File.Copy(@"Boss Rush\030_Ansem 3.dat", vars.autosavedst, true);
                            }
                            return settings["a2"];
                        }
                    }
                    break;
            }
        }
    }

    if (settings["optional_splits"]){
        // fight win splits
        if (fight_complete){
            switch (current_world){
                // traverse town
                case 3:
                    if (current.room == 1 && !vars.fake_guard){
                        vars.back_split = "fake";
                        vars.fake_guard = true;
                        return settings["fake_guard"];
                    }
                    break;
                // wonderland
                case 4:
                    if (current.room == 3){
                        vars.completed_fights.Add("crank");
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\006_Trickmaster.dat", vars.autosavedst, true);
                        }
                        return settings["crank"];
                    }
                    break;
                // deep jungle
                case 5:
                    if (current.room == 2){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\008_Clayton.dat", vars.autosavedst, true);
                        }
                        return settings["sabor_2"];
                    }
                    if (current.room == 11 && !vars.clayton_1){
                        vars.back_split = "clay1";
                        vars.clayton_1 = true;
                        return settings["clayton_1"];
                    }
                    break;
                // agrabah splits
                case 8:
                    if (current.room == 19){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\010_Tiger Head.dat", vars.autosavedst, true);
                        }
                        return settings["pot"];
                    }
                    if (current.room == 1){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\011_Jafar.dat", vars.autosavedst, true);
                        }
                        return settings["tiger"];
                    }
                    if (current.room == 16){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\012_Genie Jafar.dat", vars.autosavedst, true);
                        }
                        return settings["jafar"];
                    }
                    break;
                // halloween town
                case 10:
                    if (current.room == 9){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\016_Oogie Boogie.dat", vars.autosavedst, true);
                        }
                        return settings["lsb"];
                    }
                    if (current.room == 7){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\017_Oogie Manor.dat", vars.autosavedst, true);
                        }
                        return settings["oogie"];
                    }
                    break;
                // monstro
                case 12:
                    if (current.room == 4){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\014_Parasite Cage 2.dat", vars.autosavedst, true);
                        }
                        return settings["pc"];
                    }
                    break;
                // neverland
                case 13:
                    if (current.room == 6){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\019_Hook.dat", vars.autosavedst, true);
                        }
                        return settings["anti"];
                    }
                    if (vars.pre_hook && !vars.hook && !settings["hook"] && current.room == 8){
                        vars.back_split = "";
                        vars.hook = true;
                    }
                    break;
                // hollow bastion
                case 15:
                    if (current.room == 4){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\022_Maleficent.dat", vars.autosavedst, true);
                        }
                        return settings["riku"];
                    }
                    if (current.room == 11){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\023_Dragon Maleficent.dat", vars.autosavedst, true);
                        }
                        return settings["mal"];
                    }
                    if (current.room == 12 && current.scene == 0){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\024_Riku Ansem.dat", vars.autosavedst, true);
                        }
                        return settings["dragon"];
                    }
                    break;
                // end of world
                case 16:
                    eow_scene.Update(game); 
                    if (current.room == 30 && eow_scene.Current == 256){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\029_Ansem 2.dat", vars.autosavedst, true);
                        }
                        return settings["a1"];
                    }
                    if (!vars.ds3 && current.room == 30){
                        vars.ds3 = true;
                        vars.back_split = "ds3";
                        return settings["ds3"];
                    }
                    if (current.room == 33){
                        if (current.scene == 0){
                            if (settings["boss_rush"]) {
                                File.Copy(@"Boss Rush\031_World of Chaos Face.dat", vars.autosavedst, true);
                            }
                            return settings["a3"];
                        }
                        if (current.scene == 2){
                            if (settings["boss_rush"]) {
                                File.Copy(@"Boss Rush\032_Ansem 4.dat", vars.autosavedst, true);
                            }
                            return settings["face"];
                        }
                        if (current.scene == 3){
                            return settings["mc"];
                        }
                    }
                    if (current.room == 36){
                        return settings["sc"];
                    }
                    if (current.room == 37){
                        return settings["dbc"];
                    }
                    if (current.room == 38){
                        return settings["invc"];
                    }
                    break;
            }
        } else {
            // all other splits
            switch (current_world){
                // station of awakening
                case 0:
                    if (current.enemies_defeated[0] >= 5 && cutscene.Current){
                        return vars.completed_splits.Add("shadows_1") && settings["shadows_1"];
                    }
                    // shadows killed
                    if (current.enemies_defeated[0] >= 9 && text_progress.Current > 0 && text_progress.Old == 0){
                        return vars.completed_splits.Add("shadows_2") && settings["shadows_2"];
                    }
                    break;
                // destiny islands
                case 1:
                    // logs 
                    if (current.collected_items_2[40] < old.collected_items_2[40]){
                        return settings["day_1"];
                    }
                    // coconuts
                    if (current.collected_items_2[46] < old.collected_items_2[46]){
                        return settings["destiny"];
                    }
                    if (old.room == 2 && current.room == 3 && current.scene == 2){
                        return vars.completed_splits.Add("destiny_opt") && settings["destiny_opt"];                        
                    }
                    break;
                // traverse town
                case 3:
                    if (current.room == 0 && current.scene == 3 && ((death) || (current.white > 0 && old.white == 0))){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\004_Guard Armor.dat", vars.autosavedst, true);
                        }
                        return vars.completed_splits.Add("leon") && settings["leon"];
                    }
                    if (current.room == 10 && current.scene == 11 && current.in_gummi > 0){
                        return vars.completed_splits.Add("tt_2") && settings["tt_2"];
                    }
                    // oath keeper
                    if (current.scene == 0 && current.room == 10 && current.in_gummi > 0 && current.equips[38] == 1){
                        return vars.completed_splits.Add("tt_4") && settings["tt_4"];
                    }
                    break;
                // wonderland
                case 4:
                    if (current.room == 3 && vars.completed_fights.TryGetValue("crank", out output_catch) && cutscene.Current){
                        return vars.completed_splits.Add("crank_alt") && settings["crank_alt"];
                    }
                    break;
                // deep jungle
                case 5:
                    if (current.room == 0 && current.scene == 0 && ((death) || (current.white > 0 && old.white == 0))){
                        return vars.completed_splits.Add("sabor_1") && settings["sabor_1"];
                    }
                    if (
                        // house gummi
                        (current.room == 0 && current.scene == 3 && current.power_wild_gummis[13] != old.power_wild_gummis[13]) ||
                        // bamboo gummi
                        (current.room == 2 && current.scene == 2 && current.power_wild_gummis[0] != old.power_wild_gummis[0]) ||
                        // climbing trees gummi
                        (current.room == 6 && current.scene == 2 && current.power_wild_gummis[32] != old.power_wild_gummis[32]) ||
                        // cliff gummi
                        (current.room == 11 && current.scene == 2 && current.power_wild_gummis[31] != old.power_wild_gummis[31]) ||
                        // camp gummi
                        (current.room == 12 && current.scene == 1 && current.power_wild_gummis[7] != old.power_wild_gummis[7])
                    ){
                        vars.pw_gummis += 1;
                    }
                    if (vars.pw_gummis == 5){
                        vars.pw_gummis = 0;
                        return vars.completed_splits.Add("power_wilds") && settings["power_wilds"];
                    }
                    if (current.room == 10 && current.scene == 0){
                        return vars.completed_splits.Add("wfc") && settings["wfc"];
                    }
                    break;
                // agrabah
                case 8:
                    if (current.room == 0 && current.scene == 4){
                        return vars.completed_splits.Add("save_al") && settings["save_al"];
                    }
                    if (current.room == 1 && current.scene == 4){
                        return vars.completed_splits.Add("carpet_escape") && settings["carpet_escape"];
                    }
                    break;
                // halloween town
                case 10:
                    // forget me not
                    if (current.room == 10 && current.collected_items_2[75] == 0 && old.collected_items_2[75] == 1){
                        return settings["fmn"];
                    }
                    // jack in the box
                    if (current.room == 10 && current.collected_items_2[76] == 0 && old.collected_items_2[76] == 1){
                        return settings["jb"];
                    }
                    break;
                // neverland
                case 13:
                    var neverland_scene = vars.watchers["neverland_scene"];
                    neverland_scene.Update(game);
                    if (!vars.pre_hook && current.room == 8 && current.scene == 1 && neverland_scene.Current == 80){
                        vars.back_split = "pre_hook";
                        vars.pre_hook = true;
                        return settings["pre_hook"];
                    }
                    if (cutscene.Current && gummi_destination_world.Current == 13 && (gummi_start_world.Current == 10 || gummi_start_world.Current == 9)){
                        return vars.completed_splits.Add("ship") && settings["ship"];
                    }
                    break;
                // hollow bastion
                case 15:
                    if (old.room == 11 && current.room == 4 && current.scene == 13){
                        return settings["emblem"];
                    }
                    if (current.room == 3 && current.scene == 13 && summon_load.Current && vars.summon_timer > 30){
                        return vars.completed_splits.Add("dumbo_1") && settings["dumbo_1"];
                    }
                    if (current.room == 1 && current.scene == 14 && summon_load.Current && vars.summon_timer > 30){
                        return vars.completed_splits.Add("dumbo_2") && settings["dumbo_2"];
                    }
                    if (current.room == 3 && current.scene == 14 && summon_load.Current && vars.summon_timer > 30){
                        return vars.completed_splits.Add("dumbo_3") && settings["dumbo_3"];
                    }
                    break;
                // end of world
                case 16:

                    if (current.room == 12 && current.scene == 13 && current.arch_behemoth_kills > old.arch_behemoth_kills){
                        if (settings["boss_rush"]) {
                            File.Copy(@"Boss Rush\027_Chernabog.dat", vars.autosavedst, true);
                        }
                        return settings["arch"];
                    }
                    if (old.room == 18 && current.room == 15){
                        return vars.completed_splits.Add("oc_portal") && settings["oc_portal"];
                    }
                    if (old.room == 21 && current.room == 15){
                        return vars.completed_splits.Add("atl_portal") && settings["atl_portal"];
                    }
                    if (old.room == 25 && current.room == 15){
                        return settings["hbp"];
                    }
                    if (!vars.behemoth_3 && current.room == 28 && current.arch_behemoth_kills > old.arch_behemoth_kills){
                        vars.behemoth_3 = true;
                        vars.back_split = "be3";
                        return settings["behemoth_3"];
                    }
                    if (current.room == 29){
                        vars.back_split = "";
                        return vars.completed_splits.Add("final_rest") && settings["final_rest"];
                    }
                    if (old.room == 33 && current.room == 37){
                        return settings["artillery"];
                    }
                    break;
            }
        }
        
        var ship = vars.watchers["hook_ship_flag"];
        ship.Update(game);
        if (gummi_destination_world.Current == 13 && ship.Current == 37 && (gummi_start_world.Current == 10 || gummi_start_world.Current == 9)){
            return vars.completed_splits.Add("ship_early") && settings["ship_early"];
        }
    }

    if (settings["all_worlds_splits"]){
        if (fight_complete){
            // fight win splits
            switch (current_world){
                // atlantica
                case 9:
                    if (current.room == 12 && current.scene == 2){
                        return settings["urs_1"];
                    }
                    if (current.room == 16){
                        return settings["urs_2"];
                    }
                    break;
                // olympus coliseum
                case 11:
                    if (current.room == 2 && current.scene == 0){
                        return settings["cloud_1"];
                    }
                    if (current.room == 2 && current.scene == 1){
                        return settings["cerb_1"];
                    }
                    if (current.room == 2 && current.scene == 9){
                        if (!vars.cloud_2){
                            vars.back_split = "cloud2";
                            vars.cloud_2 = true;
                            return settings["cloud_2"];
                        } else if (!vars.herc_cup) {
                            vars.herc_cup = true;
                            vars.back_split = "";
                            return settings["herc_cup"];
                        }
                    }
                    break;
            }
        } else {
            // all other splits
            switch (current_world){
                // traverse town
                case 3:
                    if (old_world == 6 && vars.completed_splits.TryGetValue("torn_page_power", out output_catch)){
                        return vars.completed_splits.Add("power_boost") && settings["power_boost"];
                    }
                    if (vars.completed_splits.TryGetValue("torn_page_5", out output_catch) && old.room == 9 && current.room == 19){
                        return settings["seal_100_aw"];
                    }
                    break;
                // 100 acre wood
                case 6:
                    // power boost
                    if (current.collected_items_2[0] > old.collected_items_2[0]){
                        vars.completed_splits.Add("torn_page_power");
                    }
                    // nature spark
                    if (current.collected_items_2[55] == 1 && old.collected_items_2[55] == 0){
                        return settings["torn_page_1"];
                    }
                    // mythril shard
                    if (current.collected_items_2[100] > old.collected_items_2[100]){
                        return vars.completed_splits.Add("torn_page_2") && settings["torn_page_2"];
                    }
                    // stop level
                    if (current.magic_levels[168] > old.magic_levels[168]){
                        return settings["torn_page_3"];
                    }
                    // mythril
                    if (current.collected_items_2[101] > old.collected_items_2[101]){
                        return vars.completed_splits.Add("torn_page_4") && settings["torn_page_4"];
                    }
                    // exp ring
                    if (current.equips[0] > old.equips[0]){
                        return vars.completed_splits.Add("torn_page_5") && settings["torn_page_5"];
                    }
                    break;
                // atlantica
                case 9:
                    var docked_world = vars.watchers["docked_world"];
                    docked_world.Update(game);
                    if (docked_world.Current == 9){
                        return vars.completed_splits.Add("atl_dock") && settings["atl_dock"];
                    }
                    break;
                // olympus coliseum
                case 11:
                    // thunder unlocked
                    if (current.in_gummi > 0 && (
                        current.magic_unlock_val == 5 ||
                        current.magic_unlock_val == 7 ||
                        current.magic_unlock_val == 15
                    )){
                        return vars.completed_splits.Add("thunder") && settings["thunder"];
                    }
                    break;
            }
        }
    }

    if (settings["jj_splits"]){
        if (fight_complete){
            // fight win splits
            switch (current_world){
                // agrabah
                case 8:
                    if (current.room == 0 && current.scene == 13){
                        return settings["kurt"];
                    }
                    break;
                // olympus coliseum
                case 11:
                    if (current.room == 5 && current.scene == 0){
                        return settings["pg_cup"];
                    }
                    if (current.room == 2 && current.scene == 11){
                        return settings["hades_seed_39"];
                    }
                    if (current.room == 6 && current.scene == 4){
                        return settings["hades_seed_19"];
                    }
                    if (current.room == 5 && current.scene == 13){
                        return settings["hades_seed_9"];
                    }
                    if (current.room == 6 && current.scene == 5){
                        return vars.completed_splits.Add("ice_titan") && settings["ice_titan"];
                    }
                    if (current.room == 6 && current.scene == 6){
                        return vars.completed_splits.Add("seph") && settings["seph"];
                    }
                    break;
                // neverland
                case 13:
                    if (current.room == 9 && current.scene == 1){
                        return settings["nap_time"];
                    }
                    break;
            }
        } else {
            // all other splits
            switch (current_world){
                // wonderland
                case 4:
                    if (settings["wl_2"]){
                        if (vars.completed_splits.TryGetValue("wl_1", out output_catch)){
                            if (!vars.wl_counts){
                                vars.wl_counts = true;
                                vars.puppies = current.puppy_count;
                                vars.green = current.trinity_counts[3];
                                vars.blue = current.trinity_counts[0];
                                vars.white = current.trinity_counts[5];
                            }
                            return (
                                current.in_gummi > 0 &&
                                // gigas shadow
                                current.enemies_defeated[82] >= 1 &&
                                vars.check_jj_revisit(
                                    current_world,
                                    new int[] {vars.puppies, vars.blue, 0, vars.green, 0, vars.white, 0, 0}
                                )
                            ) && vars.completed_splits.Add("wl_2");
                        }
                    }
                    break;
                // deep jungle
                case 5:
                    if (settings["dj_2"]){
                        if (vars.completed_splits.TryGetValue("dj_1", out output_catch)){
                            if (!vars.dj_counts){
                                vars.dj_counts = true;
                                vars.mini = current.mini_game_count;
                                vars.green = current.trinity_counts[3];
                                vars.white = current.trinity_counts[5];
                            }
                            return (
                                current.in_gummi > 0 &&
                                // black ballad and bouncy wild
                                current.enemies_defeated[86] >= 1 &&
                                current.enemies_defeated[4] >= 1 &&
                                vars.check_jj_revisit(
                                    current_world,
                                    new int[] {0, 0, 0, vars.green, 0, vars.white, vars.mini, 0}
                                )
                            ) && vars.completed_splits.Add("dj_2");
                        }
                    }
                    break;
                // agrabah
                case 8:
                    if (settings["ag_2"]){
                        if (vars.completed_splits.TryGetValue("ag_1", out output_catch)){
                            if (!vars.ag_counts){
                                vars.ag_counts = true;
                                vars.puppies = current.puppy_count;
                                vars.green = current.trinity_counts[3];
                                vars.yellow = current.trinity_counts[4];                            
                                vars.white = current.trinity_counts[5];
                            }
                            return (
                                current.in_gummi > 0 &&
                                // pot scorpion
                                current.enemies_defeated[34] >= 1 &&
                                vars.check_jj_revisit(
                                    current_world,
                                    new int[] {vars.puppies, 0, 0, vars.green, vars.yellow, vars.white, 0, 0}
                                )
                            ) && vars.completed_splits.Add("ag_2");
                        }
                    }
                    break;
                // atlantica
                case 9:
                    if (current.torn_page_count > old.torn_page_count){
                        vars.atl_torn_page = true;
                    }
                    if (vars.atl_torn_page && current.in_gummi > 0){
                        return vars.completed_splits.Add("atlantica_1") && settings["atlantica_1"];
                    }
                    break;
                // halloween town
                case 10:
                    if (settings["ht_2"]){
                        if (vars.completed_splits.TryGetValue("ht_1", out output_catch)){
                            if (!vars.ht_counts){
                                vars.ht_counts = true;
                                vars.puppies = current.puppy_count;
                                vars.red = current.trinity_counts[2];
                                vars.white = current.trinity_counts[5];
                            }
                            return (
                                current.in_gummi > 0 &&
                                // chimera
                                current.enemies_defeated[48] >= 1 &&
                                vars.check_jj_revisit(
                                    current_world,
                                    new int[] {vars.puppies, 0, vars.red, 0, 0, vars.white, 0, 0}
                                )
                            ) && vars.completed_splits.Add("ht_2");
                        }
                    }
                    break;
                // olympus coliseum
                case 11:
                    // gravity level
                    if (current.magic_levels[112] > old.magic_levels[112]){
                        return settings["phil_cup"] && vars.completed_splits.Add("phil_cup");
                    }
                    if (current.room == 2 && current.scene == 7){
                        int party_address = vars.party_address;
                        if (memory.ReadValue<ushort>(modules.First().BaseAddress + party_address) == 65535){
                            // split when next available ability slot becomes combo plus in OC room 2 scene 7
                            int byte_count = 48 - vars.next_ability_slot_idx;
                            int ability_slot_address = 0x0;
                            int abilities_address = vars.abilities_address;
                            ability_slot_address = abilities_address + vars.next_ability_slot_idx - vars.offset;
                            var next_ability_slot = memory.ReadValue<byte>(modules.First().BaseAddress + ability_slot_address);
                            if (next_ability_slot == 134){
                                return vars.completed_splits.Add("phil_cup_solo") && settings["phil_cup_solo"];
                            }
                            byte[] ability_slots = memory.ReadBytes(modules.First().BaseAddress + abilities_address, byte_count);
                            var ability_slots_slice = new byte[byte_count]; 
                            Array.Copy(ability_slots, vars.next_ability_slot_idx, ability_slots_slice, 0, byte_count);
                            for (int i = 0; i < ability_slots_slice.Length; i++){
                                if (ability_slots[i] == 0){
                                    vars.next_ability_slot_idx = i;
                                    break;
                                }
                            }
                        }
                    }
                    // can be adapted for plat
                    if (old.room == 5 && old.scene == 11){
                        return vars.completed_splits.Add("hades_seed_49") && settings["hades_seed_49"];
                    }
                    // thunder level up
                    if (current.magic_levels[0] > old.magic_levels[0] && current.room == 5 && current.scene == 4){
                        return vars.completed_splits.Add("hades_seed_29") && settings["hades_seed_29"];
                    }
                    break;
                // monstro
                case 12:
                    if (settings["mo_2"]){
                        if (vars.completed_splits.TryGetValue("mo_1", out output_catch)){
                            if (!vars.mo_counts){
                                vars.mo_counts = true;
                                vars.puppies = current.puppy_count;
                                vars.green = current.trinity_counts[3];
                                vars.white = current.trinity_counts[5];
                                vars.pages = current.torn_page_count;
                            }
                            return (
                                current.in_gummi > 0 &&
                                // grand ghost
                                current.enemies_defeated[92] >= 1 &&
                                vars.check_jj_revisit(
                                    current_world,
                                    new int[] {vars.puppies, 0, 0, vars.green, 0, vars.white, 0, vars.pages}
                                )
                            ) && vars.completed_splits.Add("mo_2");
                        }
                    }
                    break;
                // neverland
                case 13:
                    if (settings["nl_2"]){
                        if (vars.completed_splits.TryGetValue("nl_1", out output_catch)){
                            if (!vars.nl_counts){
                                vars.nl_counts = true;
                                vars.puppies = current.puppy_count;
                                vars.white = current.trinity_counts[5];
                                vars.yellow = current.trinity_counts[4];
                            }
                            return (
                                current.in_gummi > 0 &&
                                // jet balloon
                                current.enemies_defeated[88] >= 1 &&
                                vars.check_jj_revisit(
                                    current_world,
                                    new int[] {vars.puppies, 0, 0, 0, vars.yellow, vars.white, 0, 0}
                                )
                            ) && vars.completed_splits.Add("nl_2");
                        }
                    }
                    break;
                // hollow bastion
                case 15:
                    // divine rose & cure level
                    if (current.equips[33] == 1 && current.magic_levels[56] == 3 && current.in_gummi > 0){
                        return vars.completed_splits.Add("hb_2") && settings["hb_2"];
                    }
                    // exp necklace
                    if (current.room == 12 && current.scene == 2 && current.equips[2] > old.equips[2]){
                        return settings["xemnas"];
                    }
                    break;
                // end of world
                case 16:
                    if (current.in_gummi > 0){
                        return vars.completed_splits.Add("eow") && settings["eow"];
                    }
                    if (current.room == 29){
                        vars.chronicles_complete = current.chronicles_count == 10;
                        vars.reports_complete = current.reports_count == 13;
                        vars.characters_complete = (
                            current.characters_one_count == 39 &&
                            current.characters_two_count == 64 &&
                            current.enemies_defeated[4] >= 1 && // bouncy wild
                            current.enemies_defeated[10] >= 1 && // sea neon
                            current.enemies_defeated[12] >= 1 && // sheltering zone
                            current.enemies_defeated[34] >= 1 && // pot scropion
                            current.enemies_defeated[44] >= 1 && // aquatank
                            current.enemies_defeated[46] >= 1 && // screw diver
                            current.enemies_defeated[48] >= 1 && // chimera
                            current.enemies_defeated[76] >= 1 && // pink agaricus
                            current.enemies_defeated[78] >= 1 && // neo shadow
                            current.enemies_defeated[80] >= 1 && // stealth soldier
                            current.enemies_defeated[82] >= 1 && // gigas shadow
                            current.enemies_defeated[84] >= 1 && // sniper wild
                            current.enemies_defeated[86] >= 1 && // black ballad
                            current.enemies_defeated[88] >= 1 && // jet balloon
                            current.enemies_defeated[92] >= 1 // grand ghost
                        );
                        vars.world_puppies_complete = current.puppy_count == 99;
                        vars.world_trinities_complete = (
                            current.trinity_counts[0] == 17 && // blue
                            current.trinity_counts[2] == 6 && // red
                            current.trinity_counts[3] == 9 && // green
                            current.trinity_counts[4] == 4 && // yellow
                            current.trinity_counts[5] == 10 // white
                        );
                        vars.world_mini_game_complete = current.mini_game_count == 8;
                        vars.journal_complete = (
                            vars.chronicles_complete &&
                            vars.reports_complete &&
                            vars.characters_complete &&
                            vars.world_puppies_complete &&
                            vars.world_trinities_complete &&
                            vars.chronicles_complete
                        );
                        if (vars.journal_complete){
                            return vars.completed_splits.Add("jj_complete_early") && settings["jj_complete_early"];
                        }
                    }
                    if (old.room == 29 && current.room == 30 && vars.journal_complete){
                        return vars.completed_splits.Add("jj_complete") && settings["jj_complete"];
                    }
                    break;
            }
        }
        // Register initial world visits complete for revisit checks
        if (current.in_gummi > 0){
            var docked_world = vars.watchers["docked_world"];
            docked_world.Update(game);
            // blizzard unlocked
            if (settings["wl_2"] && docked_world.Current != 4 && (
                current.magic_unlock_val == 3 ||
                current.magic_unlock_val == 7 ||
                current.magic_unlock_val == 11 ||
                current.magic_unlock_val == 15
            )){
                vars.completed_splits.Add("wl_1");
            }
            // jungle king
            if (settings["dj_2"] && current.equips[28] == 1 && docked_world.Current != 5){
                vars.completed_splits.Add("dj_1");
            }
            // three wishes
            if (settings["ag_2"] && current.equips[29] == 1 && docked_world.Current != 8){
                vars.completed_splits.Add("ag_1");
            }
            // pumpkin head
            if (settings["ht_2"] && current.equips[31] == 1 && docked_world.Current != 10){
                vars.completed_splits.Add("ht_1");
            }
            // stop unlocked
            if (settings["mo_2"] && docked_world.Current == 8 && (
                current.magic_unlock_val == 43 ||
                current.magic_unlock_val == 47
            )){
                vars.completed_splits.Add("mo_1");
            }
            // fairy harp
            if (settings["nl_2"] && current.equips[30] == 1 && docked_world.Current != 13){
                vars.completed_splits.Add("nl_1");
            }
        }
    }

    if (settings["plat_splits"]){
        switch (current_world){
            // traverse town splits
            case 3:
                // aero level
                if (!vars.aero_level_up && current.magic_levels[224] > old.magic_levels[224]){
                    vars.aero_level_up = true;
                }
                // ultima
                if (current.equips[41] >= 1 && vars.aero_level_up){
                    return vars.completed_splits.Add("tt_final") && settings["tt_final"];
                }
                break;
        }
        // synth splits
        vars.mats = (
            current.collected_items_1[0] >= 1 && // fury stone
            current.collected_items_1[1] >= 1 && // power stone
            current.collected_items_1[2] >= 1 && // energy stone
            current.collected_items_1[3] >= 1 && // blazing stone
            current.collected_items_1[4] >= 1 && // frost stone
            current.collected_items_1[5] >= 1 && // lightning stone
            current.collected_items_1[6] >= 1 && // dazzling stone
            current.collected_items_1[7] >= 1 && // stormy stone
            current.collected_items_2[3] >= 1 && // serenity power
            current.collected_items_2[5] >= 1 // mythril stone
        );
        if (vars.mats){
            return vars.completed_splits.Add("each_mat") && settings["each_mat"];
        }
        // gummi splits
        if (current.in_gummi){
            int gummi_kills_address = vars.gummi_kills_address;
            vars.gummi_kills = memory.ReadValue<uint>(modules.First().BaseAddress + gummi_kills_address);            
        }
        if (vars.gummi_kills >= 2500){
            return vars.completed_splits.Add("gummi_kills") && settings["gummi_kills"];
        }
    }

    if (settings["misc"]){
        if (settings["coco"] && !vars.finished_nut){
            if (settings["per_10"]){
                // coconuts
                if (current.collected_items_2[46] > old.collected_items_2[46] && current.collected_items_2[46] % 10 == 0){
                    return true;
                }
            }
            else if (settings["per_1"]){
                // coconuts
                if (current.collected_items_2[46] > old.collected_items_2[46]){
                    return true;
                }
            }
            // coconuts
            if (current.collected_items_2[46] == 99){
                vars.finished_nut = true;
                return true;
            }
        }
    }

    // logic for handling death if you want to repeat splits or not and have one off
    if (death){
        string back_split = vars.back_split;
        switch (back_split){
            case "clay1":
                if (settings["manual_back_step"] || (!settings["manual_back_step"] && !settings["clayton_1"])){
                    vars.clayton_1 = false;
                }
                break;
            case "pre_hook":
                if (settings["manual_back_step"] || (!settings["manual_back_step"] && !settings["pre_hook"])){
                    vars.pre_hook = false;
                }
                break;
            case "fake":
                if (settings["manual_back_step"] || (!settings["manual_back_step"] && !settings["fake_guard"])){
                    vars.fake_guard = false;
                }
                break;
            case "cloud2":
                if (settings["manual_back_step"] || (!settings["manual_back_step"] && !settings["cloud_2"])){
                    vars.cloud_2 = false;
                }
                break;
            case "be3":
                if (settings["manual_back_step"] || (!settings["manual_back_step"] && !settings["behemoth_3"])){
                    vars.behemoth_3 = false;
                }
                break;
            case "ds3":
                if (settings["manual_back_step"] || (!settings["manual_back_step"] && !settings["ds3"])){
                    vars.ds3 = false;
                }
                break;
        }
    }
}

exit
{
    vars.booting = true;
    timer.IsGameTimePaused = true;  
}

init
{
    // game base address
    var gb = modules.First().BaseAddress;
    vars.offset = 0x0;
    vars.watchers = new Dictionary<string, MemoryWatcher>{};
    int epic_gl = memory.ReadValue<byte>(gb + 0x46A822);
    int epic_jp = memory.ReadValue<byte>(gb + 0x46A802);
    int steam_gl = memory.ReadValue<byte>(gb + 0x4698D2);
    int steam_jp = memory.ReadValue<byte>(gb + 0x469872);
    if (epic_gl == 106 || epic_jp == 106) {
        version = "EG Global";
        if (epic_jp == 106) {
            version = "EG JP";
        }
        vars.watchers = new Dictionary<string, MemoryWatcher>{
            { "black_inv", new MemoryWatcher<bool>(gb + 0x4DD3F8) },
            { "cutscene", new MemoryWatcher<bool>(gb + 0x233F1F4) },
            { "difficulty", new MemoryWatcher<ushort>(gb + 0x2E0018C) },
            { "docked_world", new MemoryWatcher<ushort>(gb + 0x526AC0) },
            { "eow_scene", new MemoryWatcher<ushort>(gb + 0x2DEA96C) },
            { "fightend", new MemoryWatcher<byte>(gb + 0x2D54438) },
            { "gummi_destination_world", new MemoryWatcher<ushort>(gb + 0x508280) },
            { "gummi_start_world", new MemoryWatcher<ushort>(gb + 0x507C90) },
            { "hook_ship_flag", new MemoryWatcher<byte>(gb + 0xED751E) },
            { "load", new MemoryWatcher<bool>(gb + 0x232E6E8) },
            { "load_2", new MemoryWatcher<bool>(gb + 0x233F230) },
            { "neverland_scene", new MemoryWatcher<byte>(gb + 0x2DEB26D) },
            { "newgame", new MemoryWatcher<byte>(gb + 0x2E9CBA4) },
            { "party_load", new MemoryWatcher<bool>(gb + 0x2E1FE7C) },
            { "paused", new MemoryWatcher<bool>(gb + 0x232E9BC) },
            { "save_load", new MemoryWatcher<bool>(gb + 0x2E20F38) },
            { "sora_hp", new MemoryWatcher<byte>(gb + 0x2D5D64C) },
            { "summon_load", new MemoryWatcher<bool>(gb + 0x2D54D08) },
            { "text_progress", new MemoryWatcher<byte>(gb + 0x232E974) },
        };
    } else if (steam_gl == 106) || (steam_jp == 106) {
        vars.offset = 0xA00;
        version = "Steam Global";
        if (steam_jp == 106) {
            version = "Steam JP";
        }
        vars.watchers = new Dictionary<string, MemoryWatcher>{
            { "black_inv", new MemoryWatcher<bool>(gb + 0x4DC718) },
            { "cutscene", new MemoryWatcher<bool>(gb + 0x233E808) },
            { "difficulty", new MemoryWatcher<ushort>(gb + 0x2DFF78C) },
            { "docked_world", new MemoryWatcher<ushort>(gb + 0x525D60) }, 
            { "eow_scene", new MemoryWatcher<ushort>(gb + 0x2DE9F6C) },
            { "fightend", new MemoryWatcher<byte>(gb + 0x2D53A38) },
            { "gummi_destination_world", new MemoryWatcher<ushort>(gb + 0x507580) },
            { "gummi_start_world", new MemoryWatcher<ushort>(gb + 0x506F90) },
            { "hook_ship_flag", new MemoryWatcher<byte>(gb + 0xED6A1E) },
            { "load", new MemoryWatcher<bool>(gb + 0x232DCE8) },
            { "load_2", new MemoryWatcher<bool>(gb + 0x233E830) },
            { "neverland_scene", new MemoryWatcher<byte>(gb + 0x2DEA86D) },
            { "newgame", new MemoryWatcher<byte>(gb + 0x2E9C1C8) },
            { "party_load", new MemoryWatcher<bool>(gb + 0x2E1F4E8) },
            { "paused", new MemoryWatcher<bool>(gb + 0x232DFC0) },
            { "save_load", new MemoryWatcher<bool>(gb + 0x2E20564) },
            { "sora_hp", new MemoryWatcher<byte>(gb + 0x2D5CC4C) }, 
            { "summon_load", new MemoryWatcher<bool>(gb + 0x2D54308) },
            { "text_progress", new MemoryWatcher<byte>(gb + 0x232DF74) },
        };
    } else {
        print("No matching version found");
    }
    vars.party_address = 0x2DEA1EF - vars.offset;
    vars.abilities_address = 0x2DE9DA4 - vars.offset;
    vars.gummi_kills_address = 0x2DF5C98 - vars.offset;
    int level_address = 0x2DE9D64 - vars.offset;
    // values are equal to number of each element found on revisit (puppies, blue trin, red trin, green trin, yellow trin, white trin, mini games, torn pages)
    // puppies sets are multiples of 3 by sets found
    vars.revisit_info = new Dictionary<int, Dictionary<int, int[]>>{
        {
            // wonderland
            4,
            new Dictionary<int, int[]>
            {
                // beginner
                {0, new int[]{12, 1, 0, 2, 0, 1, 0, 0}},
                // standard
                {1, new int[]{6, 1, 0, 2, 0, 1, 0, 0}},
                // proud
                {2, new int[]{6, 1, 0, 2, 0, 1, 0, 0}},
                // level 1
                {3, new int[]{12, 1, 0, 2, 0, 1, 0, 0}}
            }
        },
        {
            // deep jungle
            5,
            new Dictionary<int, int[]>
            {
                // beginner
                {0, new int[]{0, 0, 0, 1, 0, 1, 1, 0}},
                // standard
                {1, new int[]{0, 0, 0, 1, 0, 1, 1, 0}},
                // proud
                {2, new int[]{0, 0, 0, 1, 0, 1, 1, 0}},
                // level 1
                {3, new int[]{0, 0, 0, 1, 0, 1, 1, 0}}
            }
        },
        {
            // agrabah
            8,
            new Dictionary<int, int[]>
            {
                // beginner
                {0, new int[]{6, 0, 0, 1, 1, 1, 0, 0}},
                // standard
                {1, new int[]{0, 0, 0, 0, 1, 0, 0, 0}},
                // proud
                {2, new int[]{0, 0, 0, 0, 1, 0, 0, 0}},
                // level 1
                {3, new int[]{6, 0, 0, 1, 1, 1, 0, 0}}
            }
        },
        {
            // halloween town
            10, 
            new Dictionary<int, int[]>
            {
                // beginner
                {0, new int[]{12, 0, 1, 0, 0, 1, 0, 0}},
                // standard
                {1, new int[]{9, 0, 1, 0, 0, 1, 0, 0}},
                // proud
                {2, new int[]{9, 0, 1, 0, 0, 1, 0, 0}},
                // level 1
                {3, new int[]{12, 0, 1, 0, 0, 1, 0, 0}}
            }
        },
        {
            // monstro
            12,
            new Dictionary<int, int[]>
            {
                // beginner
                {0, new int[]{3, 0, 0, 1, 0, 1, 0, 0}},
                // standard
                {1, new int[]{3, 0, 0, 1, 0, 1, 0, 0}},
                // proud
                {2, new int[]{3, 0, 0, 1, 0, 1, 0, 0}},
                // level 1
                {3, new int[]{3, 0, 0, 1, 0, 1, 0, 1}}
            }
        },
        {
            // neverland
            13,
            new Dictionary<int, int[]>
            {
                // beginner
                {0, new int[]{9, 0, 0, 0, 1, 1, 0, 0}},
                // standard
                {1, new int[]{9, 0, 0, 0, 1, 1, 0, 0}},
                // proud
                {2, new int[]{9, 0, 0, 0, 1, 1, 0, 0}},
                // level 1
                {3, new int[]{9, 0, 0, 0, 1, 1, 0, 0}}
            }
        }
    };

    vars.completed_splits = new HashSet<string>();
    vars.completed_fights = new HashSet<string>();

    vars.check_jj_revisit = (Func <int, int[], bool>)(
        (int world, int[] starting_vals) => {
            int difficulty = current.difficulty;
            int[] current_vals = {
                current.puppy_count,
                current.trinity_counts[0], // blue
                current.trinity_counts[2], // red
                current.trinity_counts[3], // green
                current.trinity_counts[4], // yellow
                current.trinity_counts[5], // white
                current.mini_game_count,
                current.torn_page_count
            };
            int level = memory.ReadValue<byte>(modules.First().BaseAddress + level_address);
            vars.cons_met = 0;
            if (level == 1){
                difficulty += 1;
            }
            foreach (int value in Enumerable.Range(0, 8)){
                if (current_vals[value] - starting_vals[value] >= vars.revisit_info[world][difficulty][value]){
                    vars.cons_met += 1;
                }
            }
            if (vars.cons_met == 8){
                vars.cons_met = 0;
                return true;
            } else {
                vars.cons_met = 0;
                return false;
            }
        }
    );
    timer.IsGameTimePaused = false;
}

reset
{
    // -1 value of 4 byte for world
    if (current.scene == 0 && current.room == 0 && current.world == 65535 && old.world != 65535){
        if (settings["boss_rush"]) {
            File.Copy(@"Boss Rush\001_Darkside 1.dat", vars.autosavedst, true);
        }
        return true;
    }
}

update
{
    var output_catch = "";
    vars.watchers["black_inv"].Update(game);
    vars.watchers["cutscene"].Update(game);
    vars.watchers["text_progress"].Update(game);
    vars.watchers["load"].Update(game);
    vars.watchers["load_2"].Update(game);
    vars.watchers["party_load"].Update(game);
    vars.watchers["paused"].Update(game);
    vars.watchers["save_load"].Update(game);
    vars.watchers["sora_hp"].Update(game);
    vars.watchers["summon_load"].Update(game);
    vars.watchers["fightend"].Update(game);
    if (
        (settings["ship"] && !vars.completed_splits.TryGetValue("ship", out output_catch)) || (settings["ship_early"] && !vars.completed_splits.TryGetValue("ship_early", out output_catch)) ||
        (settings["wl_2"] && !vars.completed_splits.TryGetValue("wl_2", out output_catch)) || (settings["dj_2"] && !vars.completed_splits.TryGetValue("dj_2", out output_catch)) ||
        (settings["ag_2"] && !vars.completed_splits.TryGetValue("ag_2", out output_catch)) || (settings["ht_2"] && !vars.completed_splits.TryGetValue("ht_2", out output_catch)) ||
        (settings["mo_2"] && !vars.completed_splits.TryGetValue("mo_2", out output_catch)) || (settings["nl_2"] && !vars.completed_splits.TryGetValue("nl_2", out output_catch))
    ){
        vars.watchers["gummi_start_world"].Update(game);
        vars.watchers["gummi_destination_world"].Update(game);
    }
    if (settings["atl_dock"] && !vars.completed_splits.TryGetValue("atl_dock", out output_catch)){
        vars.watchers["docked_world"].Update(game);
    }

    if (vars.booting && current.world == 65535){
        vars.booting = false;
    }
}

isLoading
{
    var load = vars.watchers["load"];
    var load_2 = vars.watchers["load_2"];
    var black = vars.watchers["black_inv"];
    var cutscene = vars.watchers["cutscene"];
    var paused = vars.watchers["paused"];
    var summon_load = vars.watchers["summon_load"];
    var save_load = vars.watchers["save_load"];
    var party_load = vars.watchers["party_load"];
    var sora_hp = vars.watchers["sora_hp"];
    vars.summon_timer = summon_load.Current ? vars.summon_timer + (paused.Current ? 0 : 1) : 0;

    return (
        (
            load.Current 
            || !black.Current
            || (current.white == 128 && !cutscene.Current)
            || vars.summon_timer > 30
        )
        && !paused.Current
    )
    || save_load.Current
    || party_load.Current
    || vars.booting;
}
