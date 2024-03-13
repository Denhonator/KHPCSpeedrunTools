state("KINGDOM HEARTS Birth by Sleep FINAL MIX")
{
    // location info
    ushort room : 0x8150A1;
    byte scene : 0x8150A2;
    byte world : 0x10F9AF60;

    // game state info
    byte gs1 : 0x10FB1428; 
    // states for game state 1
    // 0: freeplay, 1: scene?, 2: in forced combat, 12: world map, 13: menu   
    byte gs2 : 0x10FB1468;
    // states for game state 2
    // 0: freeplay, 1: menu option?, 2: room transition/loading heart?
    // 3: black out?, 4: loaded screen without control, 64: white blur?
    byte char_select_confirm_1 : 0x10F87828;
    // used for reset if you back off confirmation
    byte char_select_confirm_2 : 0x8F60F00;

    // mini games
    byte rumble_racing_complete : 0x10FAEA3C;
    ushort ice_cream_beat_score : 0x10FAC59C;
    byte fruit_ball_score : 0x10FAC554;
}

startup
{
    vars.in_character_select = false;

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
        settings.Add("icb", true, "Ice Cream Beats", "ven_base");
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
    if (vars.in_character_select) {
        if (current.char_select_confirm_1 == 64 && old.char_select_confirm_1 != 64) {
            vars.in_character_select = false;
            return true;
        }
    } else {
        var character = vars.watchers["character"];
        character.Update(game);
        vars.in_character_select = character.Current == 1 && character.Old == 0;
    }
}

split
{    
    var character = vars.watchers["character"];
    character.Update(game);

    var aquaConfirm = settings["aqua_base"] && character.Current == 3;
    var terraConfirm = settings["terra_base"] && character.Current == 2;
    var venConfirm = settings["ven_base"] && character.Current == 1;

    var fight_complete = current.gs1 != 2 && old.gs1 == 2 && current.gs2 != 128;
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
            if (current.world == 8 && current.room == 4 && vars.preReq1Complete == true) {
                return settings["aqua_zack"];
            }
            if (current.world == 8 && current.room == 6) {
                return settings["hades"];
            }
            if (current.world == 11 && current.room == 8) {
                return settings["nl_vanitas"];
            }
            if (current.world == 13 && current.room == 12 && vars.preReq2Complete == false) {
                vars.preReq1Complete = true;
                return settings["kg_braig"];
            }
            if (current.world == 13 && current.room == 12 && vars.preReq2Complete == true) {
                return settings["final_vanitas"];
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
            if (current.world == 6 && current.room == 11) {
                return settings["rg_braig"];
            }
            if (current.world == 9 && current.room == 6) {
                return settings["experiment221"];
            }
            if (current.world == 11 && current.room == 13 && vars.preReq3Complete == false) {
                vars.preReq3Complete = true;
                return settings["pan"];
            }
            if (current.world == 11 && current.room == 13 && vars.preReq3Complete == true) {
                return settings["shade_swarm"];
            }
            if (current.world == 1 && current.room == 1) {
                return settings["eraqus"];
            }
            if (current.world == 13 && current.room == 10 && vars.preReq4Complete == false) {
                vars.preReq4Complete = true;
                return settings["terra_vanitas"];
            }
            if (current.world == 13 && current.room == 10 && vars.preReq4Complete == true) {
                return settings["mx"];
            }
            if (current.world == 13 && current.room == 11) {
                return settings["terranort"];
            }
        }
        if (venConfirm) {
            if (current.world == 2 && current.room == 8 && vars.preReq1Complete == false) {
                vars.preReq1Complete = true;
                return settings["sw_escort"];
            }
            if (current.world == 2 && current.room == 8 && vars.preReq1Complete == true) {
                return settings["mt"];
            }
            if (current.world == 3 && current.room == 13) {
                return settings["lucifer"];
            }
            if (current.world == 4 && current.room == 3 && vars.preReq2Complete == false) {
                vars.preReq2Complete = true;
                return settings["ven_goons"];
            }
            if (current.world == 4 && current.room == 3 && vars.preReq2Complete == true) {
                return settings["ven_maleficent"];
            }
            if (current.world == 13 && current.room == 1) {
                if (vars.preReq3Complete == false) {
                    vars.preReq3Complete = true;
                } else {
                    return settings["ven_vanitas1"];
                }
            }
            if (current.world == 8 && current.room == 5) {
                if (vars.preReq5Complete == false) {
                    vars.preReq5Complete = true;
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
    }

    if (aquaConfirm) {
        if (current.world == 8 && current.room == 1 && old.room == 4 && current.gs1 == 0 && vars.preReq1Complete == false) {
            vars.preReq1Complete = true;
            return settings["aqua_tournament"];
        }
        if (current.fruit_ball_score > 0 && old.fruit_ball_score == 0) {
            return settings["fruitball"];
        }
        if (current.world == 9 && current.room == 10 && current.gs1 == 1 && old.gs1 == 7 && current.gs2 == 64) {
            return settings["ttg"];
        }
    }

    if (terraConfirm) {
        if (current.world == 3 && current.room == 10 && current.gs1 == 1 && old.gs1 == 2) {
            return settings["cinderella"];
        }
        if (current.rumble_racing_complete == 1 && old.rumble_racing_complete == 0) {
            return settings["rr"];
        } 
        if (current.world == 8 && current.room == 4)  {
            if (vars.preReq1Complete == false) {
                if (current.gs2 == 65 && old.gs2 == 64) {
                    vars.preReq1Complete = true;
                    return settings["terra_tournament"];
                }
            } else {
                if (current.gs1 != 2 && old.gs1 == 2 && current.gs2 == 64) {
                    if (vars.preReq2Complete == false) {
                        vars.preReq2Complete = true;
                        return settings["terra_zack1"];
                    } else if (vars.preReq2Complete == true) {
                        return settings["terra_zack2"];
                    }
                }
            }
        }
        if (current.world == 9 && current.room == 13 && current.gs1 == 1 && old.gs1 == 7 && current.gs2 == 64) {
            return settings["ds_ambush"];
        }
    }

    if (venConfirm) {
        if (current.world == 2 && current.room == 1 && old.room == 2) {
            return settings["dwarves"];
        } 
        if (current.world == 3 && current.room == 1 && current.scene == 0 && (old.scene == 3 || old.scene == 5)) {
            return settings["dress"];
        }
        if (current.ice_cream_beat_score > 1129 && old.ice_cream_beat_score < 1130) {
            return settings["icb"];
        }
        if (current.world == 8 && current.room == 3 && current.gs1 == 7 && current.gs2 == 64 && old.gs2 == 0) {
            if(vars.preReq4Complete == false) {
                vars.preReq4Complete = true;
            } else {
                return settings["pots"];
            }
        }
        if (current.world == 9 && current.room == 13 && current.gs2 == 64 && old.gs2 == 0) {
            return settings["meta1"];
        }
    }
}

exit
{
    timer.IsGameTimePaused = true;  
}

init
{
    // General prerequisite variables that can be used when two splits take place in the same room (i.e. braig and vanitas in aqua's final fights)
    vars.preReq1Complete = false;
    vars.preReq2Complete = false;
    vars.preReq3Complete = false;
    vars.preReq4Complete = false;
    vars.preReq5Complete = false;
    
    // game base address
    var gb = modules.First().BaseAddress;
    vars.watchers = new Dictionary<string, MemoryWatcher>{
        { "character", new MemoryWatcher<byte>(gb + 0xCF7DAD) },
    };

    timer.IsGameTimePaused = false;
}

reset
{
    var character = vars.watchers["character"];
    character.Update(game);
    if(character.Current == 0 && character.Old != 0){
        return true;
    }
    // if(current.char_select_confirm_2 == 6 && old.char_select_confirm_2 == 8){
    //     vars.in_character_select = true;
    //     return true;
    // }
}

update
{

}

isLoading
{
    return (current.gs2 == 2 || current.gs2 == 3);
}
