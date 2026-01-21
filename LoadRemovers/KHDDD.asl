state("KINGDOM HEARTS Dream Drop Distance", "EG Global") // 1.0.0.10
{
    byte world : 0x9CF720;
    byte room : 0x9CF721;
    byte scene : 0x9CF722;
    byte fight_end : 0x9E6BD8;
    byte game_start : 0x9EB208;
    byte reset : 0xAC9098;
    byte loading : 0x14C89B68;
}

// This is not verified as I do not own the Epic Version for JP
// state("KINGDOM HEARTS Dream Drop Distance", "EG JP")
// {
//     byte world : 0x9CF720;
//     byte room : 0x9CF721;
//     byte scene : 0x9CF722;
//     byte fight_end : 0x9E6BD8;
//     byte game_start : 0x9EB208;
//     byte reset : 0xAC9058;
//     byte loading : 0x14C89B28;
// }

state("KINGDOM HEARTS Dream Drop Distance", "Steam Global") // 1.0.0.2
{
    byte world : 0x9CF730;
    byte room : 0x9CF731;
    byte scene : 0x9CF732;
    byte fight_end : 0x9E6BE8;
    byte game_start : 0x9EB218;
    byte reset : 0xAC9818;
    byte loading : 0x14C8A2E8;
}

state("KINGDOM HEARTS Dream Drop Distance", "Steam JP") // 1.0.0.2
{
    byte world : 0x9CF730;
    byte room : 0x9CF731;
    byte scene : 0x9CF732;
    byte fight_end : 0x9E6BE8;
    byte game_start : 0x9EB218;
    byte reset : 0xAC9818;
    byte loading : 0x14C8A2E8;
}

startup
{
    settings.Add("shared", false, "Shared and Standalone splits");
        settings.Add("urs", false, "Ursula Tutorial Boss", "shared");
    settings.Add("boss", false, "Boss Fight splits");
        settings.Add("sora_boss", false, "Sora Bosses", "boss");
            settings.Add("shm", false, "Hockomonkey", "sora_boss");
            settings.Add("swg", false, "Wargoyle", "sora_boss");
            settings.Add("scc", false, "Chill Clawbster", "sora_boss");
            settings.Add("rin", false, "Rinzler", "sora_boss");
            settings.Add("sbr", false, "Spellican Boss Rush", "sora_boss");
            settings.Add("sbb", false, "Beagle Boys", "sora_boss");
            settings.Add("pete", false, "Pete", "sora_boss");
            settings.Add("spl", false, "Spellican", "sora_boss");
            settings.Add("xemnas", false, "Xemnas", "sora_boss");
        settings.Add("riku_boss", false, "Riku Bosses", "boss");
            settings.Add("rhm", false, "Hockomonkey", "riku_boss");
            settings.Add("rwg", false, "Wargoyle", "riku_boss");
            settings.Add("com", false, "Commantis", "riku_boss");
            settings.Add("rcc", false, "Char Clawbster", "riku_boss");
            settings.Add("rbb", false, "Beagle Boys", "riku_boss");
            settings.Add("rmol", false, "Holey Moley", "riku_boss");
            settings.Add("chr", false, "Chernabog", "riku_boss");
            settings.Add("black", false, "Anti Black Coat", "riku_boss");
            settings.Add("ansem_1", false, "Ansem I", "riku_boss");
            settings.Add("ansem_2", false, "Ansem II", "riku_boss");
            settings.Add("yxeh", false, "Young Xehanort", "riku_boss");
    settings.Add("ff", false, "Forced Fight splits");
        settings.Add("sora_ff", false, "Sora Fights", "ff");
            settings.Add("square", false, "Square", "sora_ff");
            settings.Add("town", false, "Town", "sora_ff");
            settings.Add("ap", false, "Amusement Park", "sora_ff");
            settings.Add("circ", false, "Circus", "sora_ff");
            settings.Add("fount", false, "Fountain Square", "sora_ff");
            settings.Add("ty", false, "Training Yard", "sora_ff");
            settings.Add("dino", false, "Carriage Defense", "sora_ff");
            settings.Add("msm", false, "Dungeon", "sora_ff");
        settings.Add("riku_ff", false, "Riku Fights", "ff");
            settings.Add("rfd", false, "First District", "riku_ff");
            settings.Add("bike", false, "Light Cycle Commantis", "riku_ff");
            settings.Add("rcity", false, "City", "riku_ff");
            settings.Add("back", false, "Back Streets", "riku_ff");
    settings.Add("drop", false, "Drop Boss splits");
        settings.Add("sora_drop", false, "Sora Drops", "drop");
            settings.Add("sbrawl", false, "Brawlamari", "sora_drop");
            settings.Add("sqb", false, "Queen Buzzerfly", "sora_drop");
        settings.Add("riku_drop", false, "Riku Drops", "drop");
            settings.Add("rqb", false, "Queen Buzzerfly", "riku_drop");
            settings.Add("rbrawl", false, "Brawlamari", "riku_drop");
}

start
{
    vars.in_game = current.game_start == 2 && old.game_start == 1;
    return vars.in_game && current.reset == 0;
}

split
{    
    int world = current.world;
    // boss fight == 143, mob fight == 10
    bool fight_complete = (current.fight_end == 10 || current.fight_end == 143) && old.fight_end == 0;
    if (fight_complete) {
        switch (world) {
            // Initial/Atlantica/Merlins Tower
            case 1:
                return settings["urs"];
                break;
            // Station of Awakening
            case 2:
                return true; // final fight - Armored Ventus Nightmare 2-4-10 riku none
            // Traverse Town
            case 3:
                if (current.room == 1 && current.scene == 11) {
                    return settings["rfd"];
                }
                if (current.room == 3 && current.scene == 0) {
                    return settings["sbr"];
                }
                if (current.room == 8 && current.scene == 10) {
                    return settings["back"];
                }
                if (current.room == 9 && current.scene == 10) {
                    return settings["fount"];
                }
                if (current.room == 10 && current.scene == 0) {
                    return settings["shm"];
                }
                if (current.room == 11 && current.scene == 0) {
                    return settings["rhm"];
                }
                break;
            // Country of the Musketeers
            case 4:
                if (current.room == 3 && current.scene == 0) {
                    return settings["pete"];
                }
                if (current.room == 6 && current.scene == 10) {
                    return settings["sbb"];
                }
                if (current.room == 7 && current.scene == 10) {
                    return settings["msm"];
                }
                if (current.room == 8 && current.scene == 0) {
                    return settings["ty"];
                }
                if (current.room == 10 && current.scene == 1) {
                    return settings["rbb"];
                }
                if (current.room == 12 && current.scene == 10) {
                    return settings["rmol"];
                }
                if (current.room == 14 && current.scene == 0) {
                    return settings["dino"];
                }
                break;
            // Symphony of Sorcery
            case 5:
                if (current.room == 11 && current.scene == 0) {
                    return settings["spl"];
                }
                if (current.room == 62 && current.scene == 0) {
                    return settings["chr"];
                }
                break;
            // Prankster's Paradise
            case 6:
                if (current.room == 1 && current.scene == 10) {
                    return settings["ap"];
                }
                if (current.room == 10 && current.scene == 10) {
                    return settings["rcc"];
                }
                if (current.room == 12 && current.scene == 10) {
                    return settings["circ"];
                }
                if (current.room == 13 && current.scene == 0) {
                    return settings["scc"];
                }
                break;
            // Hollow Bastion/Radient Garden?
            case 7:
                break;
            // La Cite des Cloches
            case 8:
                if (current.room == 1 && current.scene == 10) {
                    return settings["square"];
                }
                if (current.room == 10 && current.scene == 11) {
                    return settings["town"];
                }
                if (current.room == 19 && current.scene == 10) {
                    return settings["swg"];
                }
                if (current.room == 14 && current.scene == 0) {
                    return settings["rwg"];
                }
                break;
            // The Grid
            case 9:
                if (current.room == 1 && current.scene == 10) {
                    return settings["com"];
                }
                if (current.room == 8 && current.scene == 11) {
                    return settings["rcity"];
                }
                if (current.room == 11 && current.scene == 0) {
                    return settings["bike"];
                }
                if (current.room == 12 && current.scene == 10) {
                    return settings["rin"];
                }
                break;
            // The World That Never Was
            case 10:
                if (current.room == 7 && current.scene == 10) {
                    return settings["black"];
                }
                if (current.room == 8 && current.scene == 10) {
                    return settings["yxeh"];
                }
                if (current.room == 9 && current.scene == 10) {
                    return settings["ansem_1"];
                }
                if (current.room == 10 && current.scene == 0) {
                    return settings["ansem_2"];
                }
                if (current.room == 12 && current.scene == 0) {
                    return settings["xemnas"];
                }
                break;
        }
    } else {
        if (current.world == 4 && old.room == 61 && old.scene == 1 && current.room != old.room && current.scene != old.scene) {
            return vars.completed_splits.Add("riku_brawlamari") && settings["rbrawl"];
        }
        if (current.world == 8 && old.room == 61 && old.scene == 1 && current.room != old.room && current.scene != old.scene) {
            return vars.completed_splits.Add("riku_queen_buzzerfly") && settings["rqb"];
        }
        if (current.world == 9 && old.room == 61 && old.scene == 1 && current.room != old.room && current.scene != old.scene) {
            return vars.completed_splits.Add("sora_brawlamari") && settings["sbrawl"];
        }
        if (current.world == 10 && old.room == 61 && old.scene == 1 && current.room != old.room && current.scene != old.scene) {
            return vars.completed_splits.Add("sora_queen_buzzerfly") && settings["sqb"];
        }
    }
}

exit
{
    timer.IsGameTimePaused = true;  
}

init
{
    var gb = modules.First().BaseAddress;
    int epic_gl = memory.ReadValue<byte>(gb + 0x8A90A6);
    // This is not verified as I do not own the Epic Version for JP
    // int epic_jp = memory.ReadValue<byte>(gb + 0x8A90A6);
    int steam_gl = memory.ReadValue<byte>(gb + 0x8A9103);
    int steam_jp = memory.ReadValue<byte>(gb + 0x8A90A3);
    // if (epic_gl == 106 || epic_jp == 106)
    if (epic_gl == 106) {
        if (epic_gl == 106) {
            version = "EG Global";
        // } else {
        //     version = "EG JP";
        //     character_address = 0xD1802D;
        }
    } else if (steam_gl == 106 || steam_jp == 106) {
        if (steam_gl == 106) {
            version = "Steam Global";
        } else {
            version = "Steam JP";
        }
    }
    vars.completed_splits = new HashSet<string>();
    vars.initial_load = false;
    timer.IsGameTimePaused = false;
}

reset
{
    if (current.reset > 0 && old.reset == 0) {
        vars.in_game = false;
        return true;
    }
    return false;
}

update
{
    
}

isLoading
{
    if (current.world == 255 && current.room == 255 && current.scene == 255) {
        vars.initial_load = true;
    }
    if (vars.initial_load && current.game_start == 1 && old.game_start == 0) {
        vars.initial_load = false;
    }
    return current.loading == 1 && vars.in_game || vars.initial_load;
}
