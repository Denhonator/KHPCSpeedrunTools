state("KINGDOM HEARTS Birth by Sleep FINAL MIX", "EG Global") // 1.0.0.10
{
    // location info
    byte world : 0x819120;
    byte room : 0x819121;
    byte scene : 0x819122;

    // game state info
    byte text_box : 0x8F65180;
    byte char_select_confirm_1 : 0x8F7E000;
    byte char_select_confirm_2 : 0x10F8BAA8;
    byte state_1 : 0x10FB56A8;  
    byte state_2 : 0x10FB56E8;

    byte max_hp : 0x10FA6950;

    // mini games
    byte dwarf_count : 0x10FA4144;
    byte urns_score : 0x10FB0D18;
}

state("KINGDOM HEARTS Birth by Sleep FINAL MIX", "EG JP") // 1.0.0.10
{
    // location info
    byte world : 0x819120;
    byte room : 0x819121;
    byte scene : 0x819122;

    // game state info
    byte text_box : 0x8F65180;
    byte char_select_confirm_1 : 0x8F7E000;
    byte char_select_confirm_2 : 0x10F8BAA8;
    byte state_1 : 0x10FB56A8;  
    byte state_2 : 0x10FB56E8;

    byte max_hp : 0x10FA6950;

    // mini games
    byte dwarf_count : 0x10FA4144;
    byte urns_score : 0x10FB0D18;
}

state("KINGDOM HEARTS Birth by Sleep FINAL MIX", "Steam Global") // 1.0.0.2 - done
{
    // location info
    byte world : 0x818120;
    byte room : 0x818121;
    byte scene : 0x818122;

    // game state info
    byte text_box : 0x8F64A80;
    byte char_select_confirm_1 : 0x8F7D900;
    byte char_select_confirm_2 : 0x10F8B3A8;
    byte state_1 : 0x10FB4FA8;  
    byte state_2 : 0x10FB4FE8;

    byte max_hp : 0x10FA6250;

    // mini games
    byte dwarf_count : 0x10FA3A44;
    byte urns_score : 0x10FB0618;
}

state("KINGDOM HEARTS Birth by Sleep FINAL MIX", "Steam JP") // 1.0.0.2
{
    // location info
    byte world : 0x817120;
    byte room : 0x817121;
    byte scene : 0x817122;

    // game state info
    byte text_box : 0x8F63A80;
    byte char_select_confirm_1 : 0x8F7C900;
    byte char_select_confirm_2 : 0x10F8A3A8;
    byte state_1 : 0x10FB3FA8;  
    byte state_2 : 0x10FB3FE8;

    byte max_hp : 0x10FA5250;

    // mini games
    byte dwarf_count : 0x10FA2A44;
    byte urns_score : 0x10FAF618;
}

startup
{
    vars.character_select_load = false;

    settings.Add("all_stories", false, "All Stories");
    settings.SetToolTip("all_stories", "Set this on to not reset on return to menu");
    settings.Add("shared_base", true, "Splits in all characters");
        settings.Add("orbs", true, "Orbs (mark of mastery)", "shared_base");
        settings.Add("ta", true, "Trinity Armor", "shared_base");
    settings.Add("aqua_base", false, "Aqua Base splits");
        settings.Add("jaq", true, "Jaq Escort", "aqua_base");
        settings.Add("cc", true, "Cursed Coach", "aqua_base");
        settings.Add("aqua_mirror", true, "Magic Mirror", "aqua_base");
        settings.Add("aqua_goons", false, "Goons (inside)", "aqua_base");
        settings.Add("gates", true, "Gates (outside goons)", "aqua_base");
        settings.Add("dragon_mal", true, "Dragon Maleficent", "aqua_base");
        settings.Add("aqua_abound", false, "Abounding Crystal", "aqua_base");
        settings.Add("mickey_ff", true, "Forced Fight w/ Mickey", "aqua_base");
        settings.Add("aqua_cod_grind", false, "Castle of Dreams Grinding", "aqua_base");
        settings.Add("rg_vanitas", true, "Radiant Garden Vanitas", "aqua_base");
        settings.Add("fruitball", true, "Fruitball", "aqua_base");
        settings.Add("aoc_ff", true, "OC Forced Fight", "aqua_base");
        settings.Add("aqua_tournament", true, "OC Tournament", "aqua_base");
        settings.Add("ds_dt_ff", false, "Deep Space Transporter Forced Fight", "aqua_base");
        settings.Add("ttg", true, " Deep Space Glider Game (Take That, Gotchya)", "aqua_base");
        settings.Add("ds_pb_ff", true, "Deep Space Prison Block Forced Fight", "aqua_base");
        settings.Add("gantu", true, "Gantu", "aqua_base");
        settings.Add("aqua_zack", true, "Zack", "aqua_base");
        settings.Add("hades", true, "Hades", "aqua_base");
        settings.Add("nl_vanitas", true, "Neverland Vanitas", "aqua_base");
        settings.Add("kg_braig", true, "Braig", "aqua_base");
        settings.Add("final_vanitas", true, "Final Vanitas", "aqua_base");
    settings.Add("terra_base", false, "Terra Base splits");
        settings.Add("ed_ff", false, "Enchanted Dominion Forced Fight", "terra_base");
        settings.Add("wm", true, "Wheel Master", "terra_base");
        settings.Add("cod_ff", false, "Castle of Dreams Forced Fight", "terra_base");
        settings.Add("cinderella", true, "Cinderella Escort", "terra_base");
        settings.Add("sm", true, "Symphony Master", "terra_base");
        settings.Add("dw_ff", false, "Dwarf Woodlands Forced Fight", "terra_base");
        settings.Add("terra_mirror", true, "Magic Mirror", "terra_base");
        settings.Add("trg_ff", false, "Radiant Garden Forced Fight", "terra_base");
        settings.Add("get_to_trinity", false, "Radiant Garden Reach Trinity", "terra_base");
        settings.Add("trg_grind_meld", false, "Radiant Garden Grind", "terra_base");
        settings.Add("rg_braig", true, "Braig", "terra_base");
        settings.Add("rr", true, "Rumble Racing", "terra_base");
        settings.Add("toc_ff", false, "OC Forced Fight", "terra_base");
        settings.Add("terra_tournament", true, "OC Tournament", "terra_base");
        settings.Add("terra_zack1", true, "Zack 1", "terra_base");
        settings.Add("terra_zack2", true, "Zack 2", "terra_base");
        settings.Add("ds_ambush", true, "Deep Space Jellyshade Ambush", "terra_base");
        settings.Add("tds_ff", false, "Deep Space Forced Fight", "terra_base");
        settings.Add("ex221", true, "Experiment 221", "terra_base");
        settings.Add("tnl_ff", false, "Neverland Forced Fight", "terra_base");
        settings.Add("pan", true, "Peter Pan", "terra_base");
        settings.Add("tjs_swarm", true, "Jellyshade Swarm", "terra_base");
        settings.Add("eraqus", true, "Master Eraqus", "terra_base");
        settings.Add("terra_vanitas", false, "Vanitas", "terra_base");
        settings.Add("mx", true, "Master Xehanort", "terra_base");
        settings.Add("terranort", true, "Terranort", "terra_base");
    settings.Add("ven_base", false, "Ventus Base splits");
        settings.Add("dwarves", true, "Dwarf Hide N' Seek", "ven_base");
        settings.Add("sw_escort", true, "Snow White Escort", "ven_base");
        settings.Add("mt", true, "Mad Treant", "ven_base");
        settings.Add("dress", true, "Dress Pieces Collection", "ven_base");
        settings.Add("lucifer", true, "Lucifer", "ven_base");
        settings.Add("ven_goons", false, "Goons", "ven_base");
        settings.Add("ven_maleficent", true, "Maleficent", "ven_base");
        settings.Add("ven_van1", true, "Keyblade Graveyard Vanitas", "ven_base");
        settings.Add("ven_abound", false, "Abounding Crystal", "ven_base");
        settings.Add("cod_grind_2", false, "Castle of Dreams Return Grind", "ven_base");
        settings.Add("vrg_grind_meld", false, "Radiant Garden Grind", "ven_base");
        settings.Add("vrg_ff", false, "Radiant Garden Forced Fight", "ven_base");
        settings.Add("leave_rg", true, "Leave Radiant Garden", "ven_base");
        settings.Add("icb", true, "Ice Cream Beats", "ven_base");
        settings.Add("voc_ff", false, "OC Forced Fight", "ven_base");
        settings.Add("pots", true, "OC Pots", "ven_base");
        settings.Add("vjs_swarm", true, "Jellyshade Swarm", "ven_base");
        settings.Add("meta1", false, "Metamorphisis 1", "ven_base");
        settings.Add("vds_ff", false, "Deep Space Forced Fight", "ven_base");
        settings.Add("meta2", true, "Metamorphisis 2", "ven_base");
        settings.Add("vnl_ff", false, "Neverland Forced Fight", "ven_base");
        settings.Add("hook", true, "Hook", "ven_base");
        settings.Add("ven_van2", true, "Vanitas 2", "ven_base");
        settings.Add("ven_van3", true, "Final Vanitas", "ven_base");
}

start
{
    if (current.char_select_confirm_1 == 2 && old.char_select_confirm_1 == 1 && current.char_select_confirm_2 == 192) {
        vars.character_select_load = true;
        vars.completed_splits = new HashSet<string>();
        return true;
    }
}

split
{    
    var output_catch = "";

    var venConfirm = settings["ven_base"] && vars.watchers["character"].Current == 1;
    var terraConfirm = settings["terra_base"] && vars.watchers["character"].Current == 2;
    var aquaConfirm = settings["aqua_base"] && vars.watchers["character"].Current == 3;

    var fight_complete = current.state_1 != 2 && old.state_1 == 2 && current.state_2 != 128;
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
                return settings["aqua_goons"];
            }
            if (current.world == 4 && current.room == 2) {
                return settings["gates"];
            }
            if (current.world == 4 && current.room == 10) {
                return settings["dragon_mal"];
            }
            if (current.world == 6 && current.room == 10) {
                return settings["mickey_ff"];
            }
            if (current.world == 6 && current.room == 3) {
                return settings["rg_vanitas"];
            }
            if (current.world == 8 && current.room == 1) {
                return settings["aoc_ff"];
            }
            if (current.world == 9 && current.room == 3) {
                return settings["ds_dt_ff"];
            }
            if (current.world == 9 && current.room == 1) {
                return settings["ds_pb_ff"];
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
                if (vars.completed_splits.TryGetValue("kg_braig", out output_catch)) {
                    return settings["final_vanitas"];
                }
            }
        }
        if (terraConfirm) {
            if (current.world == 4 && current.room == 7) {
                return settings["ed_ff"];
            }
            if (current.world == 4 && current.room == 12) {
                return settings["wm"];
            }
            if (current.world == 3 && current.room == 6) {
                return settings["cod_ff"];
            }
            if (current.world == 3 && current.room == 10) {
               return settings["cinderella"];
            }
            if (current.world == 3 && current.room == 9) {
                return settings["sm"];
            }
            if (current.world == 2 && current.room == 7) {
                return settings["dw_ff"];
            }
            if (current.world == 2 && current.room == 9) {
                return settings["terra_mirror"];
            }
            if (current.world == 6 && current.room == 11) {
                return settings["rg_braig"];
            }
            if (current.world == 8 && current.room == 5) {
                return settings["toc_ff"];
            }
            if (current.world == 9 && current.room == 1) {
                return settings["tds_ff"];
            }
            if (current.world == 9 && current.room == 6) {
                return settings["ex221"];
            }
            if (current.world == 11) {
                if (current.room == 13) {
                    var bladecharge = vars.watchers["bladecharge"];
                    bladecharge.Update(game);
                    if (bladecharge.Current == 5 && bladecharge.Old == 0) {
                        return settings["pan"];
                    } else {
                        return settings["tjs_swarm"];
                    }
                } else {
                    return settings["tnl_ff"];
                }
            }
            if (current.world == 1 && current.room == 1) {
                return settings["eraqus"];
            }
            if (current.world == 13 && current.room == 10) {
                if (current.max_hp > old.max_hp) {
                    return settings["mx"];
                }
                return settings["terra_vanitas"];
            }
            if (current.world == 13 && current.room == 11) {
                return settings["terranort"];
            }
        }
        if (venConfirm) {
            if (current.world == 2 && current.room == 8) {
                if (current.state_2 == 192) {
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
                    return settings["voc_ff"];
                } else {
                    return settings["vjs_swarm"];
                }
            }
            if (current.world == 9) {
                if (current.room == 8) {
                    return settings["meta2"];
                } else {
                    if (vars.completed_splits.TryGetValue("vds_ff_room_1", out output_catch)) {
                        return vars.completed_splits.Add("vds_ff") && settings["vds_ff"];
                    } else {
                        vars.completed_splits.Add("vds_ff_room_1");
                    }
                }
            }
            if (current.world == 11 && current.room == 8) {
                return settings["vnl_ff"];
            }
            if (current.world == 11 && current.room == 1) {
                return settings["hook"];
            }
            if (current.world == 13 && current.room == 12) {
                return settings["ven_van2"];
            }
            if (current.world == 13 && current.room == 51) {
                return settings["ven_van3"];
            }
        }

        if (current.world == 8 && current.room == 4) {
            if (aquaConfirm){
                if (vars.completed_splits.TryGetValue("aqua_tournament", out output_catch)) {
                    return vars.completed_splits.Add("aqua_zack") && settings["aqua_zack"];
                } else {
                    vars.completed_splits.Add("aqua_tournament");
                }
            }
            if (terraConfirm) {
                if (vars.completed_splits.TryGetValue("terra_zack1", out output_catch)) {
                    return vars.completed_splits.Add("terra_zack2") && settings["terra_zack2"];
                } else if (vars.completed_splits.TryGetValue("terra_tournament", out output_catch)) {
                    return vars.completed_splits.Add("terra_zack1") && settings["terra_zack1"];
                } else {                    
                    vars.completed_splits.Add("terra_tournament");
                }
            }
        }

        if (current.world == 6 && current.room == 3) {
            if (venConfirm) {
                return settings["vrg_ff"];
            } else if (terraConfirm) {                
                return settings["trg_ff"];
            }
        }

    }

    if (current.world == 8 && current.room == 4) {
        if (current.max_hp > old.max_hp) {
            return (settings["aqua_tournament"] && aquaConfirm) || (settings["terra_tournament"] && terraConfirm);
        }
    }
    if (current.world == 6 && current.room == 6 && old.room == 6) {
        if (venConfirm){
            return vars.completed_splits.Add("vrg_grind_meld") && settings["vrg_grind_meld"];
        } else if (terraConfirm) {
            return vars.completed_splits.Add("get_to_trinity") && settings["get_to_trinity"];            
        }
    }
    if (aquaConfirm) {
        if (current.world == 6 && current.room == 10 && old.room == 9){
            return vars.completed_splits.Add("aqua_abound") && settings["aqua_abound"];
        }
        // breaks if you go out of CoD more than once before finishing grind but after getting to mickey in RG
        if (current.world == 17 && old.world == 3) {
            if (vars.completed_splits.TryGetValue("aqua_abound", out output_catch)) {
                if (vars.completed_splits.TryGetValue("aqua_cod_shop", out output_catch)) {
                    return vars.completed_splits.Add("aqua_cod_grind") && settings["aqua_cod_grind"];
                } else {
                    vars.completed_splits.Add("aqua_cod_shop");
                }
            }
        }
        if (current.world == 12) {
            var score = vars.watchers["fruit_ball_score"];
            score.Update(game);
            if (score.Current > 0 && score.Old == 0) {
                return settings["fruitball"];
            }
        }
        if (current.world == 9 && current.room == 10 && current.state_1 == 1 && old.state_1 == 7 && current.state_2 == 64) {
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
        if (current.world == 9 && current.room == 13 && current.state_1 == 1 && old.state_1 == 7 && current.state_2 == 64) {
            return settings["ds_ambush"];
        }
        if (current.world == 6 && current.room == 11) {
            return vars.completed_splits.Add("trg_grind_meld") && settings["trg_grind_meld"];
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
            return settings["ven_van1"];
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
            return vars.completed_splits.Add("cod_grind_2") && settings["cod_grind_2"];
        }
        if (current.world == 12) {
            var icb_score = vars.watchers["ice_cream_beat_score"];
            icb_score.Update(game);
            if (icb_score.Current > 999 && icb_score.Old < 1000) {
                return settings["icb"];
            }
        }
        if (current.world == 8 && current.room == 3 && current.urns_score > 0 && old.urns_score == 0) {
            return settings["pots"];
        }
        if (current.world == 9 && current.room == 13 && current.state_2 == 64 && old.state_2 == 0) {
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
    int character_address = 0x0;
    int offset = 0x0;
    int epic_gl = memory.ReadValue<byte>(gb + 0x726364);
    int epic_jp = memory.ReadValue<byte>(gb + 0x726344);
    int steam_gl = memory.ReadValue<byte>(gb + 0x726464);
    int steam_jp = memory.ReadValue<byte>(gb + 0x7253E4);
    if (epic_gl == 106 || epic_jp == 106) {
        if (epic_gl == 106) {
            version = "EG Global";
            character_address = 0xCFC02D;
        } else {
            version = "EG JP";
            character_address = 0xD1802D;
        }
    } else if (steam_gl == 106 || steam_jp == 106) {
        if (steam_gl == 106) {
            version = "Steam Global";
            offset = 0x1780;
            character_address = 0xCFB92D;
        } else {
            version = "Steam JP";
            offset = 0x1700;
            character_address = 0xD1692D;
        }
    }
    vars.watchers = new Dictionary<string, MemoryWatcher>{
        { "thunderbolt", new MemoryWatcher<byte>(gb + 0x10FA5D51 - offset) },
        { "bladecharge", new MemoryWatcher<byte>(gb + 0x10FA5D53 - offset) },
        { "fruit_ball_score", new MemoryWatcher<byte>(gb + 0x10FB07D4 - offset) },
        { "ice_cream_beat_score", new MemoryWatcher<ushort>(gb + 0x10FB081C - offset) },
        { "rumble_racing_complete", new MemoryWatcher<byte>(gb + 0x10FB2CBC - offset) },
    };
    vars.watchers["character"] = new MemoryWatcher<byte>(gb + character_address);
    vars.completed_splits = new HashSet<string>();

    timer.IsGameTimePaused = false;
}

reset
{
    return vars.watchers["character"].Current == 0 && vars.watchers["character"].Old != 0 && !settings["all_stories"];
}

update
{
    var character = vars.watchers["character"];
    character.Update(game);
    if (vars.character_select_load && current.text_box == 2 && old.text_box == 1) {
        vars.character_select_load = false;
    }
}

isLoading
{
    return current.state_2 > 1 && !vars.character_select_load && ((current.world == 17 && current.state_2 < 4) || (current.world != 17 && current.state_2 < 5));
}
