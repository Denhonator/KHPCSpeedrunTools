state("KINGDOM HEARTS Birth by Sleep FINAL MIX")
{
    // location info
    ushort room : 0x8150A1;
    ushort scene : 0x8150A2;
    ushort world : 0x10F9AF60;
    ushort kills : 0x10FACA94;
    byte mt : 0x10FACDC0;
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
    var character = vars.watchers["character"];
    character.Update(game);
    return character.Current != 0 && character.Old == 0;
}

split
{
    if (settings["shared_base"]) {
        if (current.kills == 10 && old.kills != 10) {
            return settings["orbs"];
        }
    }
    if (settings["aqua_base"]) {

    }
    if (settings["terra_base"]) {
        
    }
    if (settings["ven_base"]) {
        if (current.mt == 1 && !old.mt == 1) {
            return settings["mt"];
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
        { "kills", new MemoryWatcher<byte>(gb + 0x10FACA94) },
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
    if(vars.booting && current.world == 65535){
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
