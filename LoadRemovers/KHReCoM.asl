state("KINGDOM HEARTS Re_Chain of Memories", "EG Global") // 1.0.0.10
{
    byte character : 0x87B245;
    byte state : 0x87B200;
    byte scene : 0x87B260;
    byte world : 0x87B262;
    byte title : 0x8832B1;
    byte new_game : 0xAC3F20;
    byte loading : 0xAF6ACA;
    byte brawl_scene_change : 0xC440E8;
}

state("KINGDOM HEARTS Re_Chain of Memories", "EG Global") // 1.0.0.10
{
    byte character : 0x87B245;
    byte state : 0x87B200;
    byte scene : 0x87B260;
    byte world : 0x87B262;
    byte title : 0x882FF1;
    byte new_game : 0xAC3F20;
    byte loading : 0xAF6ACA;
    byte brawl_scene_change : 0xC440E8;
}

state("KINGDOM HEARTS Re_Chain of Memories", "Steam Global") // 1.0.0.2
{
    byte character : 0x87B845;
    byte state : 0x87B800;
    byte scene : 0x87B860;
    byte world : 0x87B862;
    byte title : 0x8838B1;
    byte new_game : 0xAC4494;
    byte loading : 0xAF70CA;
    byte brawl_scene_change : 0xC44428;
}

state("KINGDOM HEARTS Re_Chain of Memories", "Steam JP") // 1.0.0.2
{
    byte character : 0x87B845;
    byte state : 0x87B800;
    byte scene : 0x87B860;
    byte world : 0x87B862;
    byte title : 0x8835F1;
    byte new_game : 0xAC4494;
    byte loading : 0xAF70CA;
    byte brawl_scene_change : 0xC44428;
}

startup
{
    settings.Add("all_stories", false, "All Stories");
    settings.SetToolTip("all_stories", "Set this on to not reset on return to menu");
    settings.Add("sora_base", false, "Sora Base splits");
        settings.Add("sora_world_splits", false, "World Completion Splits", "sora_base");
            settings.Add("s_trt", false, "Traverse Town", "sora_world_splits");
            settings.Add("s_ag", false, "Agrabah", "sora_world_splits");
            settings.Add("s_oc", false, "Olympus Coliseum", "sora_world_splits");
            settings.Add("s_wl", false, "Wonderland", "sora_world_splits");
            settings.Add("s_mo", false, "Monstro", "sora_world_splits");
            settings.Add("s_ht", false, "Halloween Town", "sora_world_splits");
            settings.Add("s_at", false, "Atlantica", "sora_world_splits");
            settings.Add("s_hb", false, "Hollow Bastion", "sora_world_splits");
            settings.Add("s_nl", false, "Neverland", "sora_world_splits");
            settings.Add("s_100_aw", false, "100 Acre Wood", "sora_world_splits");
            settings.Add("s_tt", false, "Twilight Town", "sora_world_splits");
            settings.Add("s_di", false, "Destiny Islands", "sora_world_splits");
        settings.Add("sora_boss_splits", false, "Boss Kill Splits", "sora_base");
            settings.Add("s_ga", false, "Guard Armor", "sora_boss_splits");
            settings.Add("axel_1", false, "Axel 1", "sora_boss_splits");
            settings.Add("s_gj", false, "Genie Jafar", "sora_boss_splits");
            settings.Add("s_cloud", false, "Cloud", "sora_boss_splits");
            settings.Add("s_hades", false, "Hades", "sora_boss_splits");
            settings.Add("cards", false, "Cards", "sora_boss_splits");
            settings.Add("s_tm", false, "Trick Master", "sora_boss_splits");
            settings.Add("s_pc", false, "Parasite Cage", "sora_boss_splits");
            settings.Add("s_ob", false, "Oogie Boogie", "sora_boss_splits");
            settings.Add("larx_1", false, "Larxene 1", "sora_boss_splits");
            settings.Add("s_ur", false, "Ursula", "sora_boss_splits");
            settings.Add("s_riku_1", false, "Riku Replica 1", "sora_boss_splits");
            settings.Add("s_dm", false, "Dragon Maleficent", "sora_boss_splits");
            settings.Add("s_riku_2", false, "Riku Replica 2", "sora_boss_splits");
            settings.Add("s_hook", false, "Captain Hook", "sora_boss_splits");
            settings.Add("s_vex_1", false, "Vexen 1", "sora_boss_splits");
            settings.Add("s_vex_2", false, "Vexen 2", "sora_boss_splits");
            settings.Add("s_riku_3", false, "Riku Replica 3", "sora_boss_splits");
            settings.Add("s_ds", false, "Darkside", "sora_boss_splits");
            settings.Add("s_riku_4", false, "Riku Replica 4", "sora_boss_splits");
            settings.Add("larx_2", false, "Larxene 2", "sora_boss_splits");
            settings.Add("axel_2", false, "Axel 2", "sora_boss_splits");
            settings.Add("mar_1", false, "Marluxia 1", "sora_boss_splits");
            settings.Add("mar_2", false, "Marluxia 2", "sora_boss_splits");
        settings.Add("sora_misc_splits", false, "Other Splits", "sora_base");
            settings.Add("tut_1", false, "First Tutorial (Marluxia)", "sora_misc_splits");
            settings.Add("tut_2", false, "Leon Tutorial", "sora_misc_splits");
            settings.Add("belly", false, "Belly Brawl", "sora_misc_splits");
    settings.Add("riku_base", false, "Riku Base splits");
        settings.Add("riku_world_splits", false, "World Completion Splits", "riku_base");
            settings.Add("r_hb", false, "Hollow Bastion", "riku_world_splits");
            settings.Add("r_ag", false, "Agrabah", "riku_world_splits");
            settings.Add("r_mo", false, "Monstro", "riku_world_splits");
            settings.Add("r_nl", false, "Neverland", "riku_world_splits");
            settings.Add("r_trt", false, "Traverse Town", "riku_world_splits");
            settings.Add("r_at", false, "Atlantica", "riku_world_splits");
            settings.Add("r_oc", false, "Olympus Coliseum", "riku_world_splits");
            settings.Add("r_wl", false, "Wonderland", "riku_world_splits");
            settings.Add("r_ht", false, "Halloween Town", "riku_world_splits");
            settings.Add("r_di", false, "Destiny Islands", "riku_world_splits");
            settings.Add("r_tt", false, "Twilight Town", "riku_world_splits");
        settings.Add("riku_boss_splits", false, "Boss Kill Splits", "riku_base");
            settings.Add("r_dm", false, "Dragon Maleficent", "riku_boss_splits");
            settings.Add("r_gj", false, "Genie Jafar", "riku_boss_splits");
            settings.Add("r_pc", false, "Parasite Cage", "riku_boss_splits");
            settings.Add("r_vex", false, "Vexen", "riku_boss_splits");
            settings.Add("r_hook", false, "Captain Hook", "riku_boss_splits");
            settings.Add("r_ga", false, "Guard Armor", "riku_boss_splits");
            settings.Add("r_riku_1", false, "Riku Replica 1", "riku_boss_splits");
            settings.Add("r_ur", false, "Ursula", "riku_boss_splits");
            settings.Add("r_hades", false, "Hades", "riku_boss_splits");
            settings.Add("r_tm", false, "Trick Master", "riku_boss_splits");
            settings.Add("r_ob", false, "Oogie Boogie", "riku_boss_splits");
            settings.Add("lex", false, "Lexaeus", "riku_boss_splits");
            settings.Add("r_ds", false, "Darkside", "riku_boss_splits");
            settings.Add("zex", false, "Zexion", "riku_boss_splits");
            settings.Add("r_riku_2", false, "Riku Replica 2", "riku_boss_splits");
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
        // world end splits
        if (current.world == 0 && old.world != 0) {
            if (old.world == 1) {
                return vars.completed_splits.Add("Traverse Town") && ((settings["s_trt"] && !rebirth) || (settings["r_trt"] && rebirth));
            }
            if (old.world == 2) {
                return vars.completed_splits.Add("Agrabah") && ((settings["s_ag"] && !rebirth) || (settings["r_ag"] && rebirth));
            }
            if (old.world == 3) {
                return vars.completed_splits.Add("Olympus Coliseum") && ((settings["s_oc"] && !rebirth) || (settings["r_oc"] && rebirth));
            }
            if (old.world == 4) {
                return vars.completed_splits.Add("Wonderland") && ((settings["s_wl"] && !rebirth) || (settings["r_wl"] && rebirth));
            }
            if (old.world == 5) {
                return vars.completed_splits.Add("Monstro") && ((settings["s_mo"] && !rebirth) || (settings["r_mo"] && rebirth));
            }
            if (old.world == 6) {
                return vars.completed_splits.Add("Halloween Town") && ((settings["s_ht"] && !rebirth) || (settings["r_ht"] && rebirth));
            }
            if (old.world == 7) {
                return vars.completed_splits.Add("Atlantica") && ((settings["s_at"] && !rebirth) || (settings["r_at"] && rebirth));
            }
            if (old.world == 8) {
                return vars.completed_splits.Add("Neverland") && ((settings["s_nl"] && !rebirth) || (settings["r_nl"] && rebirth));
            }
            if (old.world == 9) {
                return vars.completed_splits.Add("Hollow Bastion") && ((settings["s_hb"] && !rebirth) || (settings["r_hb"] && rebirth));
            }
            if (old.world == 10) {
                return settings["s_100_aw"] && !rebirth;
            }
            if (old.world == 11) {
                return vars.completed_splits.Add("Twilight Town") && ((settings["s_tt"] && !rebirth) || (settings["r_tt"] && rebirth));
            }
            if (old.world == 12) {
                return vars.completed_splits.Add("Destiny Islands") && ((settings["s_di"] && !rebirth) || (settings["r_di"] && rebirth));
            }
        }
        // special fight splits
        if (current.world == 5) {
            if (current.scene != old.scene && current.scene == 212) {
                vars.in_brawl = true;
            }
            if (vars.in_brawl && current.brawl_scene_change == 32 && old.brawl_scene_change != 32) {
                return vars.completed_splits.Add("Belly Brawl") && settings["belly"];
            }
        }
        if (old.scene == 76 && current.scene != 76) {
            return (settings["tut_1"] && !rebirth) || (settings["a_tut"] && rebirth);
        }
        if (old.scene == 77 && current.scene != 77 && !rebirth) {
            return settings["tut_2"];
        }
    }
}

exit
{
    timer.IsGameTimePaused = true;  
}

init
{    
    vars.in_brawl = false;
    vars.completed_splits = new HashSet<string>();
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
    return current.title == 3;
}

update
{
}

isLoading
{
    return current.loading == 255;
}
