state("KINGDOM HEARTS Birth by Sleep FINAL MIX")
{
    // location info
    ushort room : 0x8150A1;
    ushort scene : 0x8150A2;
    ushort world : 0x10F9AF60;
    byte game_start : 0x8A677F5;
    byte in_fight : 0x10FB1428;
}

startup
{
    vars.booting = false;

    settings.Add("shared_base", true, "Splits in all characters");
        settings.Add("orbs", true, "Orbs (mark of mastery)", "shared_base");
    settings.Add("aqua_base", true, "Aqua Base splits");
        settings.Add("cc", true, "Cursed Coach", "aqua_base");
    settings.Add("terra_base", true, "Terra Base splits");
        settings.Add("wm", true, "Wheel Master", "terra_base");
    settings.Add("ven_base", true, "Ventus Base splits");
        settings.Add("mt", true, "Mad Treant", "ven_base");
}

start
{
    return current.game_start == 2 && old.game_start == 0;
}

split
{
    var fight_complete = current.in_fight != 2 && old.in_fight == 2;
    if (fight_complete) {
        if (settings["shared_base"]) {
            if (current.world == 1 && current.room == 2) {
                return settings["orbs"];
            }
        }
        if (settings["aqua_base"]) {

        }
        if (settings["terra_base"]) {
            
        }
        if (settings["ven_base"]) {

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
    vars.watchers = new Dictionary<string, MemoryWatcher>{
        // { "black", new MemoryWatcher<bool>(gb + ) },
        // { "cutscene", new MemoryWatcher<bool>(gb + ) },
        // { "load", new MemoryWatcher<bool>(gb + ) },
        // { "load_2", new MemoryWatcher<bool>(gb + ) },
        // { "save_load", new MemoryWatcher<bool>(gb + ) },
        // { "newgame", new MemoryWatcher<byte>(gb + ) },
        // { "fightend", new MemoryWatcher<byte>(gb + ) },
        // { "text_progress", new MemoryWatcher<byte>(gb + ) },
        // { "difficulty", new MemoryWatcher<ushort>(gb + ) },
        // { "player_hp", new MemoryWatcher<byte>(gb + ) },
        { "character", new MemoryWatcher<byte>(gb + 0xCF7DAD) },
    };

    timer.IsGameTimePaused = false;
}

reset
{
    // -1 value of 4 byte for world
    var character = vars.watchers["character"];
    character.Update(game);
    if(character.Current == 0 && character.Old != 0){
        return true;
    }
}

update
{
    if(vars.booting && current.world == 0){
        vars.booting = false;
    }
}

isLoading
{
    // var load = vars.watchers["load"];
    // var load_2 = vars.watchers["load_2"];
    // var black = vars.watchers["black_inv"];
    // var cutscene = vars.watchers["cutscene"];
    // var paused = vars.watchers["paused"];
    // var summon_load = vars.watchers["summon_load"];
    // var save_load = vars.watchers["save_load"];
    // var party_load = vars.watchers["party_load"];
    // var sora_hp = vars.watchers["sora_hp"];
    // vars.summon_timer = summon_load.Current ? vars.summon_timer + (paused.Current ? 0 : 1) : 0;

    // return ((load.Current 
    // || !black.Current
    // || (current.white == 128 && !cutscene.Current)
    // || vars.summon_timer > 30) && !paused.Current)
    // || save_load.Current
    // || party_load.Current
    // || (load_2.Current && sora_hp.Current == 0)
    // || vars.booting;
}
