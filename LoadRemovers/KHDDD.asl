state("KINGDOM HEARTS Dream Drop Distance")
{
    byte in_game : 0xA9648C;
    byte reset : 0xAC5EB8;
    byte world : 0x9CC720;
    byte room : 0x9CC721;
    byte scene : 0x9CC722;
    byte fightend : 0x9E66E1;
    byte loading : 0x14C86988;
    // sora dives
    // tt 3-60-0, bells 8-60-1, grid 9-61-1, prank 6-61-1, country 4-60-1, symphony 5-61-1, never 10-61-1, credit 1-60-1
    // riku dives
    // tt 3-61-99, bells 8-61-1, grid 9-60-1, prank 6-60-1, country 4-61-1, symphony 5-60-1, never 10-60-1, awake 2-60-1
}

startup
{
    settings.Add("shared", false, "Shared and Standalone splits");
        settings.Add("urs", false, "Ursula Tutorial Boss", "shared");
    settings.Add("boss", false, "Boss Fight splits");
        settings.Add("sora_boss", false, "Sora Bosses", "boss");
            settings.Add("shm", false, "Hockomonkey", "sora_boss");
            settings.Add("swg", false, "Wargoyle", "sora_boss");
            settings.Add("scc", false, "Chill Clawbster", "riku_boss");
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
            settings.Add("ssd", false, "Second District", "sora_ff");
            settings.Add("square", false, "Square", "sora_ff");
            settings.Add("town", false, "Town", "sora_ff");
            settings.Add("ap", false, "Amusement Park", "sora_ff");
            settings.Add("circ", false, "Circus", "sora_ff");
            settings.Add("fount", false, "Fountain Square", "sora_ff");
            settings.Add("ty", false, "Training Yard", "sora_ff");
            settings.Add("dino", false, "Carriage Defense", "sora_ff");
            settings.Add("msm", false, "Dungeon", "sora_ff");
        settings.Add("riku_ff", false, "Riku Fights", "ff");
            settings.Add("rsd", false, "Second District", "riku_ff");
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
   return current.in_game == 1 && old.in_game != 0 && current.reset == 0;
}

split
{    
    int world = current.world;
    bool fight_complete = current.fightend == 1 && old.fightend == 0;
    if (fight_complete) {
        switch (world) {
            // Initial/Atlantica/Merlins Tower
            case 1:
                return settings["urs"];
                break;
            // Station of Awakening
            case 2:
                return true; // final fight - Armored Ventus Nightmare 2-4-10
            // Traverse Town
            case 3:
                if (current.room == 1 && current.scene == 11) {
                    return settings["rfd"];
                }
                if (current.room == 2 && current.scene == 0) {
                    return settings["ssd"];
                }
                if (current.room == 2 && current.scene == 10) {
                    return settings["rsd"];
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
    vars.completed_splits = new HashSet<string>();
    timer.IsGameTimePaused = false;
}

reset
{
    return current.reset > 0 && old.reset == 0;
}

update
{
    
}

isLoading
{
    return current.loading == 1 && current.in_game == 1;
}
