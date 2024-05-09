state("KINGDOM HEARTS 0.2 Birth by Sleep")
{
	byte hints : "KINGDOM HEARTS 0.2 Birth by Sleep.exe", 0x499B179;
	byte start : "KINGDOM HEARTS 0.2 Birth by Sleep.exe", 0x49F356D;
	byte fightend : "KINGDOM HEARTS 0.2 Birth by Sleep.exe", 0x49F3645;
	byte finisher : "KINGDOM HEARTS 0.2 Birth by Sleep.exe", 0x49F3C5A;
	byte world : "KINGDOM HEARTS 0.2 Birth by Sleep.exe", 0x49F9EFC;
	byte loading_2 : "KINGDOM HEARTS 0.2 Birth by Sleep.exe", 0x4B5A994;
	byte loading : "KINGDOM HEARTS 0.2 Birth by Sleep.exe", 0x4E24AA4;
	// This address checks more than gear kills as it tracks some amount of transitions
	// but for our purposes it ticks over to 0 on each gear, we combo this with the use of finishers
	// and location and we are good to go.
	byte gear_kill : "KINGDOM HEARTS 0.2 Birth by Sleep.exe", 0x4FA6813;
	byte scene : "KINGDOM HEARTS 0.2 Birth by Sleep.exe", 0x506A79C;
	byte title : "KINGDOM HEARTS 0.2 Birth by Sleep.exe", 0x5082C8D;
}

startup
{
	settings.Add("shadows_1", true, "Shadows I");
	settings.Add("shadows_2", true, "Shadows II");
	settings.Add("gears", true, "Gears");
	settings.SetToolTip(
        "gears",
        "Gears:\n!WARNING!\nThis split will trigger early if you use a finisher between the last and second to last gear that is not on the final gear.\n\nTurn off if you wish to avoid this and split manually\n!WARNING!"
    );
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
		if (current.start > 0 && old.start == 0) {
			// If soft reset is used just after a fight end it can mess with the game sound and splitter, this is to fix a hole in the soft reset.
			if (current.loading == 16) {
				game.WriteBytes(modules.First().BaseAddress + 0x4E24AA4, new byte[] {0x0});
			}
			// Soft reset does not always get this value right, fixes load removal for first few scenes.
			if (current.hints != 12) {
				game.WriteBytes(modules.First().BaseAddress + 0x499B179, new byte[] {0xB});
			}
		    vars.check_gear_kill = false;
		    vars.playing = false;
		    vars.check_hint = false;
			vars.cutscene_base = 100;
		 	vars.initial_load = 0;
	    	vars.split_count = 0;
		    vars.hint_count = 0;
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
		int split_count = vars.split_count;
		switch (split_count) {
			case 2: return settings["shadows_2"];
			case 4: return settings["dt_1"];
			case 5: return settings["aqua_1"];
			case 6: return settings["aqua_2"];
			case 7: return settings["aqua_3"];
			case 8: return settings["ds_1"];
			case 9: return settings["fff"];
			case 10: return settings["ds_2"];
			case 11: return settings["dt_2"];
			case 12: return settings["dtide"];
		}
	}
	if (current.scene == vars.cutscene_base - 1 && old.scene == vars.cutscene_base && vars.cutscene_count < 2) {
		vars.cutscene_count += 1;
		if (vars.cutscene_count == 2) {
			vars.split_count = 1;
			return settings["shadows_1"];
		}
	}
	if (vars.check_gear_kill && current.finisher != 0 && old.finisher == 0 && vars.hint_count == 3) {
		vars.split_count += 1;
		vars.hint_count += 1;
		return settings["gears"];
	}
}

exit
{
	timer.IsGameTimePaused = true;
}

init
{
	vars.check_gear_kill = false;
    vars.playing = false;
    vars.check_hint = false;
	vars.cutscene_base = 100;
 	vars.initial_load = 0;
    vars.split_count = 0;
    vars.cutscene_count = 0;
    vars.hint_count = 0;
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
	if (vars.initial_load == 0 && current.hints == 10) {
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
	if (!vars.check_gear_kill && current.finisher != 0 && old.finisher == 0 && current.world == 80) {
		vars.check_gear_kill = true;
	}
	if (!vars.check_hint && vars.check_gear_kill && current.gear_kill == 0 && old.gear_kill != 0) {
	    vars.check_hint = true;
	}
	if (vars.hint_count < 3 && vars.check_hint && current.hints == 11 && old.hints != 11) {
	    vars.hint_count += 1;
	    vars.check_gear_kill = false;
	    vars.check_hint = false;
	}
}

isLoading
{
	return (vars.playing && current.loading == 1) || (!vars.playing && vars.initial_load == 1 && current.loading_2 == 1);
}
