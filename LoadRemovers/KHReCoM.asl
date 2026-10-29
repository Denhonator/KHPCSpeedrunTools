state("KINGDOM HEARTS Re_Chain of Memories", "EG Global") // 1.0.0.10
{
    byte loading : 0x822034;
    byte map_card_count : 0x87A1E8, 0x2;
    byte fire_1 : 0x87A1E8, 0x211;
    byte dumbo_4 : 0x87A1E8, 0x28C;
    byte prem_fire_6 : 0x87A1E8, 0x2B6;
    byte tranquil_2 : 0x87A1E8, 0x398;
    byte teeming_0 : 0x87A1E8, 0x3A0;
    byte joker : 0x87A1E8, 0x486;
    byte red_noc : 0x87A1E8, 0x493;
    byte blue_rhap : 0x87A1E8, 0x494;
    byte current_room : 0x87AB50, 0x1;
    byte previous_room : 0x87AB50, 0x4;
    byte state : 0x87B200;
    byte character : 0x87B245;
    byte scene : 0x87B260;
    byte world : 0x87B262;
    byte title : 0x882FF1;
    byte beginnings : 0x87C598, 0x6A;
    byte guidance : 0x87C598, 0x6B;
    byte truth : 0x87C598, 0x6C;
    byte new_game : 0xAC3F20;
}

state("KINGDOM HEARTS Re_Chain of Memories", "EG JP") // 1.0.0.10
{
    byte loading : 0x822034;
    byte map_card_count : 0x87A1E8, 0x2;
    byte fire_1 : 0x87A1E8, 0x211;
    byte dumbo_4 : 0x87A1E8, 0x28C;
    byte prem_fire_6 : 0x87A1E8, 0x2B6;
    byte tranquil_2 : 0x87A1E8, 0x398;
    byte teeming_0 : 0x87A1E8, 0x3A0;
    byte joker : 0x87A1E8, 0x486;
    byte red_noc : 0x87A1E8, 0x493;
    byte blue_rhap : 0x87A1E8, 0x494;
    byte current_room : 0x87AB50, 0x1;
    byte previous_room : 0x87AB50, 0x4;
    byte state : 0x87B200;
    byte character : 0x87B245;
    byte scene : 0x87B260;
    byte world : 0x87B262;
    byte title : 0x882FF1;
    byte beginnings : 0x87C598, 0x6A;
    byte guidance : 0x87C598, 0x6B;
    byte truth : 0x87C598, 0x6C;
    byte new_game : 0xAC3F20;
}

state("KINGDOM HEARTS Re_Chain of Memories", "Steam Global") // 1.0.0.2
{
    byte loading : 0x8222C4;
    byte map_card_count : 0x87A7E8, 0x2;
    byte fire_1 : 0x87A7E8, 0x211;
    byte dumbo_4 : 0x87A7E8, 0x28C;
    byte prem_fire_6 : 0x87A7E8, 0x2B6;
    byte tranquil_2 : 0x87A7E8, 0x398;
    byte teeming_0 : 0x87A7E8, 0x3A0;
    byte joker : 0x87A7E8, 0x486;
    byte red_noc : 0x87A7E8, 0x493;
    byte blue_rhap : 0x87A7E8, 0x494;
    byte current_room : 0x87B110, 0x1;
    byte previous_room : 0x87B110, 0x4;
    byte state : 0x87B800;
    byte character : 0x87B845;
    byte scene : 0x87B860;
    byte world : 0x87B862;
    byte title : 0x8838B1;
    byte beginnings : 0x87CB98, 0x6A;
    byte guidance : 0x87CB98, 0x6B;
    byte truth : 0x87CB98, 0x6C;
    byte new_game : 0xAC4494;
}

state("KINGDOM HEARTS Re_Chain of Memories", "Steam JP") // 1.0.0.2
{
    byte loading : 0x8222C4;
    byte map_card_count : 0x87A7E8, 0x2;
    byte fire_1 : 0x87A7E8, 0x211;
    byte dumbo_4 : 0x87A7E8, 0x28C;
    byte prem_fire_6 : 0x87A7E8, 0x2B6;
    byte tranquil_2 : 0x87A7E8, 0x398;
    byte teeming_0 : 0x87A7E8, 0x3A0;
    byte joker : 0x87A7E8, 0x486;
    byte red_noc : 0x87A7E8, 0x493;
    byte blue_rhap : 0x87A7E8, 0x494;
    byte current_room : 0x87B110, 0x1;
    byte previous_room : 0x87B110, 0x4;
    byte state : 0x87B800;
    byte character : 0x87B845;
    byte scene : 0x87B860;
    byte world : 0x87B862;
    byte title : 0x8838B1;
    byte beginnings : 0x87CB98, 0x6A;
    byte guidance : 0x87CB98, 0x6B;
    byte truth : 0x87CB98, 0x6C;
    byte new_game : 0xAC4494;
}

startup
{
    settings.Add("reset", true, "Reset");
    settings.SetToolTip("reset", "Reset triggers on selecting difficulty if timer has already ben started for a previous run or manually before this point");
    settings.Add("sora_base", false, "Sora Base splits");
        settings.Add("sora_world_splits", false, "World Event Splits", "sora_base");
            settings.Add("sora_world_sub_splits", false, "Room Splits", "sora_world_splits");
                settings.Add("s_trt_beginnings", false, "Traverse Town: Key of Beginnings", "sora_world_sub_splits");
                settings.Add("s_trt_guidance", false, "Traverse Town: Key of Guidance", "sora_world_sub_splits");
                settings.Add("s_trt_truth", false, "Traverse Town: Key to Truth", "sora_world_sub_splits");
                settings.Add("s_ag_beginnings", false, "Agrabah: Key of Beginnings", "sora_world_sub_splits");
                settings.Add("s_ag_guidance", false, "Agrabah: Key of Guidance", "sora_world_sub_splits");
                settings.Add("s_ag_truth", false, "Agrabah: Key to Truth", "sora_world_sub_splits");
                settings.Add("s_oc_beginnings", false, "Olympus Coliseum: Key of Beginnings", "sora_world_sub_splits");
                settings.Add("s_oc_guidance", false, "Olympus Coliseum: Key of Guidance", "sora_world_sub_splits");
                settings.Add("s_oc_truth", false, "Olympus Coliseum: Key to Truth", "sora_world_sub_splits");
                settings.Add("s_wl_beginnings", false, "Wonderland: Key of Beginnings", "sora_world_sub_splits");
                settings.Add("s_wl_guidance", false, "Wonderland: Key of Guidance", "sora_world_sub_splits");
                settings.Add("s_wl_truth", false, "Wonderland: Key to Truth", "sora_world_sub_splits");
                settings.Add("s_mo_beginnings", false, "Monstro: Key of Beginnings", "sora_world_sub_splits");
                settings.Add("s_mo_guidance", false, "Monstro: Key of Guidance", "sora_world_sub_splits");
                settings.Add("s_mo_truth", false, "Monstro: Key to Truth", "sora_world_sub_splits");
                settings.Add("s_ht_beginnings", false, "Halloween Town: Key of Beginnings", "sora_world_sub_splits");
                settings.Add("s_ht_guidance", false, "Halloween Town: Key of Guidance", "sora_world_sub_splits");
                settings.Add("s_ht_truth", false, "Halloween Town: Key to Truth", "sora_world_sub_splits");
                settings.Add("s_at_beginnings", false, "Atlantica: Key of Beginnings", "sora_world_sub_splits");
                settings.Add("s_at_guidance", false, "Atlantica: Key of Guidance", "sora_world_sub_splits");
                settings.Add("s_at_truth", false, "Atlantica: Key to Truth", "sora_world_sub_splits");
                settings.Add("s_nl_beginnings", false, "Neverland: Key of Beginnings", "sora_world_sub_splits");
                settings.Add("s_nl_guidance", false, "Neverland: Key of Guidance", "sora_world_sub_splits");
                settings.Add("s_nl_truth", false, "Neverland: Key to Truth", "sora_world_sub_splits");
                settings.Add("s_hb_beginnings", false, "Hollow Bastion: Key of Beginnings", "sora_world_sub_splits");
                settings.Add("s_hb_guidance", false, "Hollow Bastion: Key of Guidance", "sora_world_sub_splits");
                settings.Add("s_hb_truth", false, "Hollow Bastion: Key to Truth", "sora_world_sub_splits");
                settings.Add("s_tt_beginnings", false, "Twilight Town: Key of Beginnings", "sora_world_sub_splits");
                settings.Add("s_di_beginnings", false, "Destiny Islands: Key of Beginnings", "sora_world_sub_splits");
                settings.Add("s_di_guidance", false, "Destiny Islands: Key of Guidance", "sora_world_sub_splits");
                settings.Add("s_co_beginnings", false, "Castle Oblivion: Key of Beginnings", "sora_world_sub_splits");
            settings.Add("s_trt_end", false, "Traverse Town", "sora_world_splits");
            settings.Add("s_ag_end", false, "Agrabah", "sora_world_splits");
            settings.Add("s_oc_end", false, "Olympus Coliseum", "sora_world_splits");
            settings.Add("s_wl_end", false, "Wonderland", "sora_world_splits");
            settings.Add("s_mo_end", false, "Monstro", "sora_world_splits");
            settings.Add("s_ht_end", false, "Halloween Town", "sora_world_splits");
            settings.Add("s_at_end", false, "Atlantica", "sora_world_splits");
            settings.Add("s_nl_end", false, "Neverland", "sora_world_splits");
            settings.Add("s_hb_end", false, "Hollow Bastion", "sora_world_splits");
            settings.Add("s_haw_end", false, "100 Acre Wood", "sora_world_splits");
            settings.Add("s_tt_end", false, "Twilight Town", "sora_world_splits");
            settings.Add("s_di_end", false, "Destiny Islands", "sora_world_splits");
        settings.Add("sora_boss_splits", false, "Boss Kill Splits", "sora_base");
            settings.Add("s_ga", false, "Guard Armor", "sora_boss_splits");
            settings.Add("axel_1", false, "Axel I", "sora_boss_splits");
            settings.Add("s_gj", false, "Genie Jafar", "sora_boss_splits");
            settings.Add("s_cloud", false, "Cloud", "sora_boss_splits");
            settings.Add("s_hades", false, "Hades", "sora_boss_splits");
            settings.Add("cards", false, "Cards", "sora_boss_splits");
            settings.Add("s_tm", false, "Trickmaster", "sora_boss_splits");
            settings.Add("s_pc", false, "Parasite Cage", "sora_boss_splits");
            settings.Add("s_ob", false, "Oogie Boogie", "sora_boss_splits");
            settings.Add("larx_1", false, "Larxene I", "sora_boss_splits");
            settings.Add("s_ur", false, "Ursula", "sora_boss_splits");
            settings.Add("s_riku_1", false, "Riku Replica I", "sora_boss_splits");
            settings.Add("s_dm", false, "Dragon Maleficent", "sora_boss_splits");
            settings.Add("s_riku_2", false, "Riku Replica II", "sora_boss_splits");
            settings.Add("s_hook", false, "Captain Hook", "sora_boss_splits");
            settings.Add("s_vex_1", false, "Vexen I", "sora_boss_splits");
            settings.Add("s_vex_2", false, "Vexen II", "sora_boss_splits");
            settings.Add("s_riku_3", false, "Riku Replica III", "sora_boss_splits");
            settings.Add("s_ds", false, "Darkside", "sora_boss_splits");
            settings.Add("s_riku_4", false, "Riku Replica IV", "sora_boss_splits");
            settings.Add("larx_2", false, "Larxene II", "sora_boss_splits");
            settings.Add("axel_2", false, "Axel II", "sora_boss_splits");
            settings.Add("mar_1", false, "Marluxia I", "sora_boss_splits");
            settings.Add("mar_2", false, "Marluxia II", "sora_boss_splits");
        settings.Add("sora_misc_splits", false, "Other Splits", "sora_base");
            settings.Add("tut_1", false, "First Tutorial (Marluxia)", "sora_misc_splits");
            settings.Add("tut_2", false, "Leon Tutorial", "sora_misc_splits");
            settings.Add("rm1_manip", false, "First Room Manip", "sora_misc_splits");
            settings.SetToolTip("rm1_manip", "Triggers on completing the forced shadow fight in the first room, intended to be used with moogle point manip in this room.");
            settings.Add("noc", false, "Red Nocturn Manip", "sora_misc_splits");
            settings.SetToolTip("noc", "Trigger after collecting the 0 teeming darkness when doing manip for red nocturn cards in TT.");
            settings.Add("grind_1", false, "Map Card Grind TT", "sora_misc_splits");
            settings.SetToolTip("grind_1", "Triggers on reaching 75 map cards for the first time, in Traverse Town.");
            settings.Add("grind_2", false, "Map Card Grind AG", "sora_misc_splits");
            settings.SetToolTip("grind_2", "Triggers on reaching 95 map cards for the first time, in Agrabah, after completing the Key to Guidance room.");
            settings.Add("joker", false, "Joker Mog Manip", "sora_misc_splits");
            settings.SetToolTip("joker", "Triggers on last card of moogle shop while having at least 5 Random Jokers and meeting minimums from having manipulated the first moogle shop for fires and blizzards.");
            settings.Add("mog", false, "Mog 2 + 3 Manip", "sora_misc_splits");
            settings.SetToolTip("mog", "Triggers on last card of moogle shop while meeting minimums from having manipulated the second and third moogle shops for fires and blizzards.");
            settings.Add("blue", false, "Blue Rhapsody Manip", "sora_misc_splits");
            settings.SetToolTip("blue", "Triggers on collecting a blue rhap enemy card in Olympus, optional if you did not get one or more before this and uses a very basic quick manip.");
            settings.Add("belly", false, "Monstro's Belly Brawl", "sora_misc_splits");
    settings.Add("riku_base", false, "Riku Base Splits");
        settings.Add("riku_world_splits", false, "World Event Splits", "riku_base");
            settings.Add("riku_world_sub_splits", false, "Room Splits", "riku_world_splits");
                settings.Add("r_hb_beginnings", false, "Hollow Bastion: Key of Beginnings", "riku_world_sub_splits");
                settings.Add("r_hb_guidance", false, "Hollow Bastion: Key of Guidance", "riku_world_sub_splits");
                settings.Add("r_hb_truth", false, "Hollow Bastion: Key to Truth", "riku_world_sub_splits");
                settings.Add("r_ag_beginnings", false, "Agrabah: Key of Beginnings", "riku_world_sub_splits");
                settings.Add("r_mo_beginnings", false, "Monstro: Key of Beginnings", "riku_world_sub_splits");
                settings.Add("r_nl_beginnings", false, "Neverland: Key of Beginnings", "riku_world_sub_splits");
                settings.Add("r_trt_beginnings", false, "Traverse Town: Key of Beginnings", "riku_world_sub_splits");
                settings.Add("r_at_beginnings", false, "Atlantica: Key of Beginnings", "riku_world_sub_splits");
                settings.Add("r_oc_beginnings", false, "Olympus Coliseum: Key of Beginnings", "riku_world_sub_splits");
                settings.Add("r_wl_beginnings", false, "Wonderland: Key of Beginnings", "riku_world_sub_splits");
                settings.Add("r_ht_beginnings", false, "Halloween Town: Key of Beginnings", "riku_world_sub_splits");
                settings.Add("r_di_beginnings", false, "Destiny Islands: Key of Beginnings", "riku_world_sub_splits");
                settings.Add("r_tt_beginnings", false, "Twilight Town: Key of Beginnings", "riku_world_sub_splits");
                settings.Add("r_tt_guidance", false, "Twilight Town: Key of Guidance", "riku_world_sub_splits");
                settings.Add("r_co_beginnings", false, "Castle Oblivion: Key of Beginnings", "riku_world_sub_splits");
            settings.Add("r_hb_end", false, "Hollow Bastion", "riku_world_splits");
            settings.Add("r_ag_end", false, "Agrabah", "riku_world_splits");
            settings.Add("r_mo_end", false, "Monstro", "riku_world_splits");
            settings.Add("r_nl_end", false, "Neverland", "riku_world_splits");
            settings.Add("r_trt_end", false, "Traverse Town", "riku_world_splits");
            settings.Add("r_at_end", false, "Atlantica", "riku_world_splits");
            settings.Add("r_oc_end", false, "Olympus Coliseum", "riku_world_splits");
            settings.Add("r_wl_end", false, "Wonderland", "riku_world_splits");
            settings.Add("r_ht_end", false, "Halloween Town", "riku_world_splits");
            settings.Add("r_di_end", false, "Destiny Islands", "riku_world_splits");
            settings.Add("r_tt_end", false, "Twilight Town", "riku_world_splits");
        settings.Add("riku_boss_splits", false, "Boss Kill Splits", "riku_base");
            settings.Add("r_dm", false, "Dragon Maleficent", "riku_boss_splits");
            settings.Add("r_gj", false, "Genie Jafar", "riku_boss_splits");
            settings.Add("r_pc", false, "Parasite Cage", "riku_boss_splits");
            settings.Add("r_vex", false, "Vexen", "riku_boss_splits");
            settings.Add("r_hook", false, "Captain Hook", "riku_boss_splits");
            settings.Add("r_ga", false, "Guard Armor", "riku_boss_splits");
            settings.Add("r_riku_1", false, "Riku Replica I", "riku_boss_splits");
            settings.Add("r_ur", false, "Ursula", "riku_boss_splits");
            settings.Add("r_hades", false, "Hades", "riku_boss_splits");
            settings.Add("r_tm", false, "Trickmaster", "riku_boss_splits");
            settings.Add("r_ob", false, "Oogie Boogie", "riku_boss_splits");
            settings.Add("lex", false, "Lexaeus", "riku_boss_splits");
            settings.Add("r_ds", false, "Darkside", "riku_boss_splits");
            settings.Add("zex", false, "Zexion", "riku_boss_splits");
            settings.Add("r_riku_2", false, "Riku Replica II", "riku_boss_splits");
        settings.Add("riku_misc_splits", false, "Other Splits", "riku_base");
            settings.Add("a_tut", false, "Ansem Tutorial", "riku_misc_splits");
}

start
{
    if (current.new_game == 7 && old.new_game == 18) {
        vars.completed_splits = new HashSet<string>();
        vars.in_brawl = false;
        return true;
    }
}

split
{
    string short_world = "";
    int old_world = old.world;
    vars.worlds.TryGetValue(current.world, out short_world);
    if (old.world != 0 && vars.old_short_world == "") {
        string output_catch = "";
        vars.worlds.TryGetValue(old_world, out output_catch);
        if (output_catch != "") {
            vars.old_short_world = output_catch;
        }
    }
    bool fight_complete = current.state == 2 && old.state != 2;
    bool rebirth = current.character == 255; // 0 = sora, 255 = riku
    int scene_offset = 0;
    if (rebirth) {
        scene_offset = current.world == 0 ? 50 : 100;
    }
    if (fight_complete) {
        // boss kill splits
        if (current.scene == (26 + scene_offset)) {
            if (current.world == 0) {
                return settings["axel_1"];
            }
            if (current.world == 1) {
                return (settings["s_ga"] && !rebirth) || (settings["r_ga"] && rebirth);
            }
            if (current.world == 2) {
                return (settings["s_gj"] && !rebirth) || (settings["r_gj"] && rebirth);
            }
            if (current.world == 3) {
                return settings["s_cloud"];
            }
            if (current.world == 4) {
                return (settings["s_tm"] && !rebirth) || (settings["r_tm"] && rebirth);
            }
            if (current.world == 5) {
                return (settings["s_pc"] && !rebirth) || (settings["r_pc"] && rebirth);
            }
            if (current.world == 6) {
                return (settings["s_ob"] && !rebirth) || (settings["r_ob"] && rebirth);
            }
            if (current.world == 7) {
                return (settings["s_ur"] && !rebirth) || (settings["r_ur"] && rebirth);
            }
            if (current.world == 8) {
                return (settings["s_hook"] && !rebirth) || (settings["r_hook"] && rebirth);
            }
            if (current.world == 9) {
                return (settings["s_dm"] && !rebirth) || (settings["r_dm"] && rebirth);
            }
            if (current.world == 11) {
                return (settings["s_vex_2"] && !rebirth) || (settings["r_riku_2"] && rebirth);
            }
            if (current.world == 12) {
                return (settings["s_ds"] && !rebirth) || (settings["r_ds"] && rebirth);
            }
            if (current.world == 13) {
                return (settings["axel_2"] && !rebirth) || (rebirth); // ansem final fight for riku
            }
        } else if (current.scene == (27 + scene_offset)) {
            if (current.world == 0) {
                return (settings["larx_1"] && !rebirth) || (settings["r_vex"] && rebirth);
            }
            if (current.world == 3) {
                return (settings["s_hades"] && !rebirth) || (settings["r_hades"] && rebirth);
            }
            if (current.world == 4) {
                return settings["cards"];
            }
            if (current.world == 12) {
                return settings["zex"];
            }
            if (current.world == 13) {
                return settings["mar_1"];
            }
        } else if (current.scene == (28 + scene_offset)) {
            if (current.world == 0) {
                return (settings["s_riku_1"] && !rebirth) || (settings["r_riku_1"] && rebirth);
            }
            if (current.world == 13) {
                return settings["mar_2"];
            }
        } else if (current.scene == (29 + scene_offset)) {
            if (current.world == 0) {
                return (settings["s_riku_2"] && !rebirth) || (settings["lex"] && rebirth);
            } else {
                return true; // marluxia 3
            }
        } else {
            if (current.world == 0) {
                if (current.scene == 30) {
                    return settings["s_vex_1"];
                }
                if (current.scene == 31) {
                    return settings["s_riku_3"];
                }
                if (current.scene == 32) {
                    return settings["s_riku_4"];
                }
                if (current.scene == 33) {
                    return settings["larx_2"];
                }
            }
        }
    } else {
        // World End Splits
        if (current.current_room == 99 && current.previous_room != 2 && current.previous_room != 99 && vars.old_short_world != "") {
            bool to_split = false;
            if (old_world == 10) {
                to_split = vars.completed_splits.Add(vars.old_short_world) && settings["s_haw_end"] && !rebirth;
            } else if ((settings[string.Format("s_{0}_end", vars.old_short_world)] && !rebirth) || (settings[string.Format("r_{0}_end", vars.old_short_world)] && rebirth)) {
                to_split = vars.completed_splits.Add(vars.old_short_world);
            }
            vars.old_short_world = "";
            return to_split;
        }
        // World Key Cards
        if (current.world != 0 && current.world != 10) {
            if (current.world < 10) {
                if (current.truth == 0 && old.truth == 1) {
                    return (settings[string.Format("s_{0}_truth", short_world)] && !rebirth);
                }
            }
            if (current.world < 13) {
                if (current.guidance == 0 && old.guidance == 1) {
                    return (settings[string.Format("s_{0}_guidance", short_world)] && !rebirth);
                }
            }
            if (current.world < 14) {
                if (current.beginnings == 0 && old.beginnings == 1) {
                    return (settings[string.Format("s_{0}_beginnings", short_world)] && !rebirth) || (settings[string.Format("r_{0}_beginnings", short_world)] && rebirth);
                }
            }
        }
        // special splits
        if (current.world == 1) {
            if (old.scene == 76 && current.scene != 76) {
                return (settings["tut_1"] && !rebirth) || (settings["a_tut"] && rebirth);
            }
            if (old.scene == 77 && current.scene != 77 && !rebirth) {
                return settings["tut_2"];
            }
            if (current.tranquil_2 == 1 && old.tranquil_2 == 0) {
                return vars.completed_splits.Add("First Room Manip") && settings["rm1_manip"];
            }
            if (current.teeming_0 > old.teeming_0 && current.red_noc > 1 && current.scene == 13) {
                return vars.completed_splits.Add("Red Nocturn Manip") && settings["noc"];
            }
            if (current.map_card_count == 75 && old.map_card_count < 75) {
                return vars.completed_splits.Add("Map Card Grind TT") && settings["grind_1"];                
            }
        }
        if (current.world == 2) {
            // check keys to beginnings and guidance to be sure this count is done
            // after those rooms are complete to avoid early splitting
            if (current.map_card_count >= 95 && current.beginnings == 0 && current.guidance == 0) {
                return vars.completed_splits.Add("Map Card Grind AG") && settings["grind_2"];
            }
            if (current.scene == 4) {
                var output_catch = "";
                if (current.joker >= 5 && current.fire_1 >= 2 && !vars.completed_splits.TryGetValue("Joker and Mog 1 Manip", out output_catch)) {
                    return vars.completed_splits.Add("Joker and Mog 1 Manip") && settings["joker"];
                }
                if (current.fire_1 >= 6 && current.prem_fire_6 >= 1) {
                    return vars.completed_splits.Add("Mog 2 & 3 Manip") && settings["mog"];
                }
            }
        }
        if (current.world == 3) {
            if (current.blue_rhap > old.blue_rhap) {
                return vars.completed_splits.Add("Blue Rhapsody Manip") && settings["blue"];
            }
        }
        if (current.world == 5 && current.dumbo_4 == 1 && old.dumbo_4 == 0) {
            return vars.completed_splits.Add("Monstro's Belly Brawl") && settings["belly"];
        }
    }
}

exit
{
    timer.IsGameTimePaused = true;  
}

init
{
    vars.old_short_world = "";
    vars.in_brawl = false;
    vars.completed_splits = new HashSet<string>();
    vars.worlds = new Dictionary<int, string>{
        {1, "trt"},
        {2, "ag"},
        {3, "oc"},
        {4, "wl"},
        {5, "mo"},
        {6, "ht"},
        {7, "at"},
        {8, "nl"},
        {9, "hb"},
        {10, "haw"},
        {11, "tt"},
        {12, "di"},
        {13, "co"}
    };
    timer.IsGameTimePaused = false;
    var gb = modules.First().BaseAddress;
    int epic_gl = memory.ReadValue<byte>(gb + 0x705148);
    int epic_jp = memory.ReadValue<byte>(gb + 0x705128);
    int steam_gl = memory.ReadValue<byte>(gb + 0x705248);
    int steam_jp = memory.ReadValue<byte>(gb + 0x7051E8);
    if (epic_gl == 106) {
        version = "EG Global";
    } else if (epic_jp == 106) {
        version = "EG JP";
    } else if (steam_gl == 106) {
        version = "Steam Global";
    } else if (steam_jp == 106) {
        version = "Steam JP";
    }
}

reset
{
    return old.new_game == 16 && current.new_game == 15;
}

update
{
}

isLoading
{
    return current.loading == 5 && current.new_game != 25;
}
