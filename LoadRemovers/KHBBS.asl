state("KINGDOM HEARTS Birth by Sleep FINAL MIX")
{
    // location info
    byte room : 0x8150A1;
    byte scene : 0x8150A2;
    ushort world : 0x10F9AF60;

    // game state info
    byte gs1 : 0x10FB1428; 
    // states for game state 1
    // 0: freeplay, 1: scene?, 2: in forced combat, 12: world map, 13: menu   
    byte gs2 : 0x10FB1468;
    // states for game state 2
    // 0: freeplay, 1: menu option?, 2: room transition/loading heart?
    // 3: black out?, 4: loaded screen without control, 64: white blur
    // 192: post forced fight non blur
    byte text_box : 0x8F60F00;
    byte char_select_confirm_1 : 0x10F87828;
    byte char_select_confirm_2 : 0x8F79D80;
    byte character : 0xCF7DAD;
    byte max_hp : 0x10FA26D0;

    // mini games
    byte urns_score : 0x10FACA98;
    byte dwarf_count : 0x10F9FEC4;
}

startup
{
    vars.character_select_load = false;

    settings.Add("shared_base", true, "Splits in all characters");
        settings.Add("orbs", true, "Orbs (mark of mastery)", "shared_base");
        settings.Add("ta", true, "Trinity Armor", "shared_base");
    settings.Add("aqua_base", false, "Aqua Base splits");
        settings.Add("jaq", true, "Jaq Escort", "aqua_base");
        settings.Add("cc", true, "Cursed Coach", "aqua_base");
        settings.Add("aqua_mirror", true, "Magic Mirror", "aqua_base");
        settings.Add("goons", true, "Goons", "aqua_base");
        settings.Add("gates", true, "Gates", "aqua_base");
        settings.Add("maleficent", true, "Maleficent", "aqua_base");
        settings.Add("mickey_ff", true, "Forced Fight w/ Mickey", "aqua_base");
        settings.Add("rg_vanitas", true, "Radiant Garden Vanitas", "aqua_base");
        settings.Add("ttg", true, "Take That, Gotchya", "aqua_base");
        settings.Add("ds_ff", true, "Prison Block Forced Fight", "aqua_base");
        settings.Add("aqua_tournament", true, "OC Tournament", "aqua_base");
        settings.Add("fruitball", true, "Fruitball", "aqua_base");
        settings.Add("gantu", true, "Gantu", "aqua_base");
        settings.Add("aqua_zack", true, "Zack", "aqua_base");
        settings.Add("hades", true, "Hades", "aqua_base");
        settings.Add("nl_vanitas", true, "Neverland Vanitas", "aqua_base");
        settings.Add("kg_braig", true, "Braig", "aqua_base");
        settings.Add("final_vanitas", true, "Final Vanitas", "aqua_base");
    settings.Add("terra_base", false, "Terra Base splits");
        settings.Add("wm", true, "Wheel Master", "terra_base");
        settings.Add("terra_mirror", true, "Magic Mirror", "terra_base");
        settings.Add("cinderella", true, "Cinderella Escort", "terra_base");
        settings.Add("sm", true, "Symphony Master", "terra_base");
        settings.Add("rg_braig", true, "Braig", "terra_base");
        settings.Add("rr", true, "Rumble Racing", "terra_base");
        settings.Add("terra_tournament", true, "OC Tournament", "terra_base");
        settings.Add("terra_zack1", true, "Zack 1", "terra_base");
        settings.Add("terra_zack2", true, "Zack 2", "terra_base");
        settings.Add("ds_ambush", true, "Deep Space Jellyshade Ambush", "terra_base");
        settings.Add("experiment221", true, "Experiment 221", "terra_base");
        settings.Add("pan", true, "Peter Pan", "terra_base");
        settings.Add("shade_swarm", true, "Jellyshade Swarm", "terra_base");
        settings.Add("eraqus", true, "Master Eraqus", "terra_base");
        settings.Add("terra_vanitas", true, "Vanitas", "terra_base");
        settings.Add("mx", true, "Master Xehanort", "terra_base");
        settings.Add("terranort", true, "Terranort", "terra_base");
    settings.Add("ven_base", false, "Ventus Base splits");
        settings.Add("dwarves", true, "Dwarf Hide N' Seek", "ven_base");
        settings.Add("sw_escort", true, "Snow White Escort", "ven_base");
        settings.Add("mt", true, "Mad Treant", "ven_base");
        settings.Add("dress", true, "Dress Pieces Collection", "ven_base");
        settings.Add("lucifer", true, "Lucifer", "ven_base");
        settings.Add("ven_goons", true, "Goons", "ven_base");
        settings.Add("ven_maleficent", true, "Maleficent", "ven_base");
        settings.Add("ven_vanitas1", true, "Keyblade Graveyard Vanitas", "ven_base");
        settings.Add("ven_abound", false, "Abounding Crystal", "ven_base");
        settings.Add("cd_grind_2", false, "Castle of Dreams Return Grind", "ven_base");
        settings.Add("rg_grind_meld", false, "Radiant Garden Grind", "ven_base");
        settings.Add("leave_rg", true, "Leave Radiant Garden", "ven_base");
        settings.Add("icb", true, "Ice Cream Beats", "ven_base");
        settings.Add("oc_ff", false, "OC Forced fight", "ven_base");
        settings.Add("pots", true, "OC Pots", "ven_base");
        settings.Add("js_swarm", true, "Jellyshade Swarm", "ven_base");
        settings.Add("meta1", true, "Metamorphisis 1", "ven_base");
        settings.Add("meta2", true, "Metamorphisis 2", "ven_base");
        settings.Add("nl_mobs", true, "Neverland Mob Fight", "ven_base");
        settings.Add("hook", true, "Hook", "ven_base");
        settings.Add("ven_vanitas2", true, "Vanitas 2", "ven_base");
        settings.Add("ven_vanitas3", true, "Final Vanitas", "ven_base");
}

start
{
    if (current.char_select_confirm_1 == 64 && current.char_select_confirm_2 == 2 && old.char_select_confirm_2 == 1) {
        vars.character_select_load = true;
        return true;
    }
}

split
{    
    var output_catch = "";

    var aquaConfirm = settings["aqua_base"] && current.character == 3;
    var terraConfirm = settings["terra_base"] && current.character == 2;
    var venConfirm = settings["ven_base"] && current.character == 1;

    var fight_complete = current.gs1 != 2 && old.gs1 == 2 && current.gs2 != 128;
    // placeholder for death logic if needed or wanted
    // var death = current.gs2 == 128;
    if (fight_complete) {
        if (settings["shared_base"]) {
            if (current.world == 1 && current.room == 2) {
                return settings["orbs"];
            }
            if (current.world == 6 && current.room == 6) {
                return settings["ta"];
            }
        }
        if (aquaConfirm) {
            if (current.world == 3 && current.room == 3) {
                return settings["jaq"];
            }
            if (current.world == 3 && current.room == 6) {
                return settings["cc"];
            }
            if (current.world == 2 && current.room == 9) {
                return settings["aqua_mirror"];
            }
            if (current.world == 4 && current.room == 17) {
                return settings["goons"];
            }
            if (current.world == 4 && current.room == 2) {
                return settings["gates"];
            }
            if (current.world == 4 && current.room == 10) {
                return settings["maleficent"];
            }
            if (current.world == 6 && current.room == 10) {
                return settings["mickey_ff"];
            }
            if (current.world == 6 && current.room == 3) {
                return settings["rg_vanitas"];
            }
            if (current.world == 9 && current.room == 1) {
                return settings["ds_ff"];
            }
            if (current.world == 9 && current.room == 9) {
                return settings["gantu"];
            }
            if (current.world == 8 && current.room == 6) {
                return settings["hades"];
            }
            if (current.world == 11 && current.room == 8) {
                return settings["nl_vanitas"];
            }
            if (current.world == 13 && current.room == 12) {
                // if you hit continue instead on death to van this will split again
                if (vars.completed_splits.TryGetValue("kg_braig", out output_catch)) {
                    return settings["final_vanitas"];
                }
            }
        }
        if (terraConfirm) {
            if (current.world == 4 && current.room == 12) {
                return settings["wm"];
            }
            if (current.world == 2 && current.room == 9) {
                return settings["terra_mirror"];
            }
            if (current.world == 3 && current.room == 9) {
                return settings["sm"];
            }
            if (current.world == 3 && current.room == 10) {
               return settings["cinderella"];
            }
            if (current.world == 6 && current.room == 11) {
                return settings["rg_braig"];
            }
            if (current.world == 9 && current.room == 6) {
                return settings["experiment221"];
            }
            if (current.world == 11 && current.room == 13) {
                var bladecharge = vars.watchers["bladecharge"];
                bladecharge.Update(game);
                if (bladecharge.Current == 5 && bladecharge.Old == 0) {
                    return settings["pan"];
                } else {
                    return settings["shade_swarm"];
                }
            }
            if (current.world == 1 && current.room == 1) {
                return settings["eraqus"];
            }
            if (current.world == 13 && current.room == 10) {
                return vars.completed_splits.Add("terra_vanitas") && settings["terra_vanitas"];
            }
            if (current.world == 13 && current.room == 11) {
                return settings["terranort"];
            }
        }
        if (venConfirm) {
            if (current.world == 2 && current.room == 8) {
                if (current.gs2 == 192) {
                    return settings["sw_escort"];
                } else {
                    return settings["mt"];
                }
            }
            if (current.world == 3 && current.room == 13) {
                return settings["lucifer"];
            }
            if (current.world == 4 && current.room == 3) {
                var thunderbolt = vars.watchers["thunderbolt"];
                thunderbolt.Update(game);
                if (thunderbolt.Current == 5 && thunderbolt.Old == 0) {
                    return settings["ven_maleficent"];
                } else {
                    return settings["ven_goons"];
                }
            }
            if (current.world == 8 && current.room == 5) {
                if (current.urns_score == 0) {
                    return settings["oc_ff"];
                } else {
                    return settings["js_swarm"];
                }
            }
            if (current.world == 9 && current.room == 8) {
                return settings["meta2"];
            }
            if (current.world == 11 && current.room == 8) {
                return settings["nl_mobs"];
            }
            if (current.world == 11 && current.room == 1) {
                return settings["hook"];
            }
            if (current.world == 13 && current.room == 12) {
                return settings["ven_vanitas2"];
            }
            if (current.world == 13 && current.room == 51) {
                return settings["ven_vanitas3"];
            }
        }

        if (current.world == 8 && current.room == 4) {
            if (aquaConfirm){
                if (vars.aqua_oc_progress == 1) {
                    return settings["aqua_zack"];
                } else {
                    vars.aqua_oc_progress = 1;
                }
            }
            if (terraConfirm) {
                if (vars.terra_oc_progress == 2) {
                    return settings["terra_zack2"];
                } else if (vars.terra_oc_progress == 1) {
                    vars.terra_oc_progress = 2;
                    return settings["terra_zack1"];
                } else {                    
                    vars.terra_oc_progress = 1;
                }
            }
        }
    }
    // placeholder for death logic if needed or wanted
    // if (death) {
    //     if (aquaConfirm) {

    //     }
    //     if (terraConfirm) {

    //     }
    //     if (venConfirm) {

    //     }
    // }

    if (current.world == 8 && current.room == 4) {
        if (current.max_hp > old.max_hp) {
            return (settings["aqua_tournament"] && aquaConfirm) || (settings["terra_tournament"] && terraConfirm);
        }
    }
    if (aquaConfirm) {
        if (current.world == 12) {
            var score = vars.watchers["fruit_ball_score"];
            score.Update(game);
            if (score.Current > 0 && score.Old == 0) {
                return settings["fruitball"];
            }
        }
        if (current.world == 9 && current.room == 10 && current.gs1 == 1 && old.gs1 == 7 && current.gs2 == 64) {
            return settings["ttg"];
        }
        if (current.world == 13 && current.room == 12 && current.max_hp > old.max_hp) {
            return vars.completed_splits.Add("kg_braig") && settings["kg_braig"];
        }
    }

    if (terraConfirm) {
        if (current.world == 12) {
            var rr_complete = vars.watchers["rumble_racing_complete"];
            rr_complete.Update(game);
            if (rr_complete.Current == 1 && rr_complete.Old == 0) {
                return settings["rr"];
            }
        }
        if (current.world == 13 && current.room == 10 && current.max_hp > old.max_hp) {
            return settings["mx"];
        }
        if (current.world == 9 && current.room == 13 && current.gs1 == 1 && old.gs1 == 7 && current.gs2 == 64) {
            return settings["ds_ambush"];
        }
    }

    if (venConfirm) {
        // only find 6 dwarves for values of 1/2/4/8/16/32
        if (current.dwarf_count == 63 && old.dwarf_count < 63) {
            return settings["dwarves"];
        } 
        if (current.world == 3 && current.room == 1 && old.room == 3) {
            return settings["dress"];
        }
        if (current.world == 13 && current.room == 1 && current.max_hp > old.max_hp) {
            return settings["ven_vanitas1"];
        }
        // will need updates if route changes
        if (current.world == 17 && old.world == 6) {
            if (!vars.completed_splits.TryGetValue("ven_abound", out output_catch)){
                return vars.completed_splits.Add("ven_abound") && settings["ven_abound"];
            } else {
                return vars.completed_splits.Add("leave_rg") && settings["leave_rg"];
            }
        }
        if (current.world == 17 && old.world == 3 && vars.completed_splits.TryGetValue("ven_abound", out output_catch)) {
            return vars.completed_splits.Add("cd_grind_2") && settings["cd_grind_2"];
        }
        if (current.world == 6 && current.room == 6 && old.room == 6) {
            return vars.completed_splits.Add("rg_grind_meld") && settings["rg_grind_meld"];
        }
        if (current.world == 12) {
            var icb_score = vars.watchers["ice_cream_beat_score"];
            icb_score.Update(game);
            if (icb_score.Current > 1129 && icb_score.Old < 1130) {
                return settings["icb"];
            }
        }
        if (current.world == 8 && current.room == 3 && current.urns_score > 0 && old.urns_score == 0) {
            return settings["pots"];
        }
        if (current.world == 9 && current.room == 13 && current.gs2 == 64 && old.gs2 == 0) {
            return settings["meta1"];
        }
    }
}

exit
{
    vars.character_select_load = false;
    timer.IsGameTimePaused = true;  
}

init
{    
    // game base address
    var gb = modules.First().BaseAddress;
    vars.watchers = new Dictionary<string, MemoryWatcher>{
        { "rumble_racing_complete", new MemoryWatcher<byte>(gb + 0x10FAEA3C) },
        { "ice_cream_beat_score", new MemoryWatcher<ushort>(gb + 0x10FAC59C) },
        { "fruit_ball_score", new MemoryWatcher<byte>(gb + 0x10FAC554) },
        { "thunderbolt", new MemoryWatcher<byte>(gb + 0x10FA1AD1) },
        { "bladecharge", new MemoryWatcher<byte>(gb + 0x10FA1AD3) },
    };
    vars.completed_splits = new HashSet<string>();
    vars.terra_oc_progress = 0;
    vars.aqua_oc_progress = 0;

    timer.IsGameTimePaused = false;
}

reset
{
    if (current.character == 0 && old.character != 0) {
        vars.completed_splits = new HashSet<string>();
        vars.terra_oc_progress = 0;
        vars.aqua_oc_progress = 0;
        return true;
    }
}

update
{
    if (vars.character_select_load && current.text_box == 2 && old.text_box == 1) {
        vars.character_select_load = false;
    }
}

isLoading
{
    var in_oc_tournament = current.world == 8 && current.room == 4;
    return (
        (current.gs2 > 1 && current.gs2 < 5 && current.world != 17 && !vars.character_select_load) ||
        (current.gs2 == 64 && current.text_box != 3 && !in_oc_tournament)
    );
}
