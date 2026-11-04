state("KINGDOM HEARTS 0.2 Birth by Sleep", "EG Global") // 1.0.0.10
{
	byte world : 0x4490604;
	byte hints : 0x449C439;
	byte start : 0x44F708D;
	byte fightend : 0x44F7165;
	byte loading : 0x4509394;
	byte gear_kill : 0x453178D;
	byte scene : 0x466C64C;
	byte title : 0x47CD35D;
	byte loading_2 : 0x4893D94;
}

// state("KINGDOM HEARTS 0.2 Birth by Sleep", "EG JP") // 1.0.0.10
// {
// 	byte world : 0x4490604;
//  byte hints : 0x449C439;
// 	byte start : 0x44F708D;
// 	byte fightend : 0x44F7165;
// 	byte loading : 0x4509394;
// 	byte gear_kill : 0x453178D;
// 	byte scene : 0x466C64C;
// 	byte title : 0x47CD35D;
// 	byte loading_2 : 0x4893D94;
// }

state("KINGDOM HEARTS 0.2 Birth by Sleep", "Steam Global") // 1.0.0.2
{
	byte world : 0x44BD854;
	byte start : 0x452452D;
	byte fightend : 0x4524605;
	byte loading : 0x4536724;
	byte scene : 0x46999CC;
	byte title : 0x47FA6DD;
	byte gear_kill : 0x480CDD0, 0x308, 0x28, 0x128, 0x10, 0x108, 0x448;
	byte hints : 0x4834A51;
	byte loading_2 : 0x48C1014;
}

state("KINGDOM HEARTS 0.2 Birth by Sleep", "Steam JP") // 1.0.0.2
{
	byte world : 0x44BD854;
	byte start : 0x452452D;
	byte fightend : 0x4524605;
	byte loading : 0x4536724;
	byte scene : 0x46999CC;
	byte title : 0x47FA6DD;
	byte gear_kill : 0x480CDD0, 0x308, 0x28, 0x128, 0x10, 0x108, 0x448;
	byte hints : 0x4834A51;
	byte loading_2 : 0x48C1014;
}

startup
{
	settings.Add("shadows_1", true, "Shadows I");
	settings.Add("shadows_2", true, "Shadows II");
	settings.Add("gears", true, "Gears");
	settings.Add("dt_1", true, "Demon Tower I");
	settings.Add("aqua_1", true, "Aqua I");
	settings.Add("aqua_2", true, "Aqua II");
	settings.Add("aqua_3", true, "Aqua III");
	settings.Add("ds_1", true, "Darkside I");
	settings.Add("fff", true, "Forest Forced Fight");
	settings.Add("ds_2", true, "Darkside II");
	settings.Add("dt_2", true, "Demon Tower II");
	settings.Add("dtide", true, "Demon Tide");
}

start
{
	if (current.title == 1) {
		// print(version);
		if ((current.start == 1 || current.start == 2) && old.start == 0) {
			// If soft reset is used just after a fight end it can mess with the game sound and splitter, this is to fix a hole in the soft reset.
			int loading = vars.loading;
			game.WriteBytes(modules.First().BaseAddress + loading, new byte[] {0x0});
			// Soft reset does not always get this value right, fixes load removal for first few scenes.
			int hints = vars.hints;
			game.WriteBytes(modules.First().BaseAddress + hints, new byte[] {0xC});					
			vars.playing = false;
			vars.cutscene_base = 100;
		 	vars.initial_load = 0;
			vars.split_count = 0;
			vars.completed_splits = new HashSet<string>();
			return true;
		}
	}
}

split
{
	if (current.fightend != 0 && current.loading == 16 && (old.loading != 16 || old.fightend == 0)) {
		vars.split_count += 1;
		if (vars.split_count == 3) {
			vars.split_count += 1;
		}
	}
	if (current.scene == vars.cutscene_base - 1 && old.scene == vars.cutscene_base && vars.cutscene_count < 2) {
		vars.cutscene_count += 1;
		if (vars.cutscene_count == 2) {
			vars.split_count = 1;
		}
	}
	if (current.gear_kill == 4 && old.gear_kill != 4) {
		vars.split_count += 1;
	}
	int split_count = vars.split_count;
	switch (split_count) {
		case 1: return vars.completed_splits.Add("shadows_1") && settings["shadows_1"];
		case 2: return vars.completed_splits.Add("shadows_2") && settings["shadows_2"];
		case 3: return vars.completed_splits.Add("gears") && settings["gears"];
		case 4: return vars.completed_splits.Add("dt_1") && settings["dt_1"];
		case 5: return vars.completed_splits.Add("aqua_1") && settings["aqua_1"];
		case 6: return vars.completed_splits.Add("aqua_2") && settings["aqua_2"];
		case 7: return vars.completed_splits.Add("aqua_3") && settings["aqua_3"];
		case 8: return vars.completed_splits.Add("ds_1") && settings["ds_1"];
		case 9: return vars.completed_splits.Add("fff") && settings["fff"];
		case 10: return vars.completed_splits.Add("ds_2") && settings["ds_2"];
		case 11: return vars.completed_splits.Add("dt_2") && settings["dt_2"];
		case 12: return vars.completed_splits.Add("dtide") && settings["dtide"];
	}
}

exit
{
	timer.IsGameTimePaused = true;
}

init
{
	vars.playing = false;
	vars.cutscene_base = 100;
	vars.initial_load = 0;
	vars.split_count = 0;
	vars.cutscene_count = 0;
	vars.completed_splits = new HashSet<string>();
    var gb = modules.First().BaseAddress;
	int epic_gl = memory.ReadValue<byte>(gb + 0x444DD30);
    // int epic_jp = memory.ReadValue<byte>(gb + 0x0);
    int steam_gl = memory.ReadValue<byte>(gb + 0x447B680);
    int steam_jp = memory.ReadValue<byte>(gb + 0x447B680);
	if (epic_gl == 84) { // epic global
		vars.loading = 0x4509394;
		vars.hints = 0x449C439;
		vars.hint_val = 11;
		vars.hint_start_val = 15;
		version = "EG Global";
	} else if (steam_gl == 84 || steam_jp == 84) {
		vars.loading = 0x4536724;
		vars.hints = 0x4834A51;
		if (steam_gl == 84) { // Global
			vars.hint_val = 13;
			vars.hint_start_val = 16;
			version = "Steam Global";
		} else { // JP
			vars.hint_val = 15;
			vars.hint_start_val = 17;
			version = "Steam JP";
		}
	}
}

reset
{
	if (current.loading == 0 || current.loading == 16) {
		if (vars.split_count < 11) {
			return current.title != old.title && current.world == 1;
		} else {
			return current.scene == old.scene - 5;
		}
	}
}

update
{
	if (vars.initial_load == 0 && old.hints == vars.hint_start_val && current.hints != vars.hint_start_val) {
		vars.initial_load = 1;
	}
	if (vars.playing && vars.cutscene_base == 100 && current.loading != 1) {
		if (current.scene == 0) {
			vars.cutscene_base = 1;
			vars.cutscene_count = 1;
		} else {
			vars.cutscene_base = current.scene;
			vars.cutscene_count = 0;
		}
	}
	if (!vars.playing && current.world == 4 && old.world != 4) {
		vars.playing = true;
		vars.initial_load = 2;
	}
}

isLoading
{
	return (vars.playing && current.loading == 1) || (!vars.playing && vars.initial_load == 1 && current.loading_2 == 1);
}
