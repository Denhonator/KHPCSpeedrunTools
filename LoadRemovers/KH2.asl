state("KINGDOM HEARTS II FINAL MIX", "GLOBAL")
{
	bool load : "KINGDOM HEARTS II FINAL MIX.exe", 0x8E9DA3;
	byte black: "KINGDOM HEARTS II FINAL MIX.exe", 0xAB8BC7;
	bool saveload: "KINGDOM HEARTS II FINAL MIX.exe", 0xBEBD34;
	bool fightend: "KINGDOM HEARTS II FINAL MIX.exe", 0xAD6BC0;
	byte titlescreen: "KINGDOM HEARTS II FINAL MIX.exe", 0x711438;
	byte soraHP: "KINGDOM HEARTS II FINAL MIX.exe", 0x2A20C98;
	byte worldID: "KINGDOM HEARTS II FINAL MIX.exe", 0x714DB8;
	byte roomID: "KINGDOM HEARTS II FINAL MIX.exe", 0x714DB9;
	byte eventID1: "KINGDOM HEARTS II FINAL MIX.exe", 0x714DBC;
	byte eventID2: "KINGDOM HEARTS II FINAL MIX.exe", 0x714DBE;
	byte eventID3: "KINGDOM HEARTS II FINAL MIX.exe", 0x714DC0;
}

state("KINGDOM HEARTS II FINAL MIX", "JP")
{
	bool load : "KINGDOM HEARTS II FINAL MIX.exe", 0x8E8DA3;
	byte black: "KINGDOM HEARTS II FINAL MIX.exe", 0xAB7BC7;
	bool saveload: "KINGDOM HEARTS II FINAL MIX.exe", 0xBEAD34;
	bool fightend: "KINGDOM HEARTS II FINAL MIX.exe", 0xAD5BC0;
	byte titlescreen: "KINGDOM HEARTS II FINAL MIX.exe", 0x710438;
	byte soraHP: "KINGDOM HEARTS II FINAL MIX.exe", 0x2A1FC98;
}

init
{
	timer.IsGameTimePaused = false;
	vars.splitTimer = 0;

	if(modules.First().ModuleMemorySize == 46301184){
		version = "JP";
	}
	else{
		version = "GLOBAL";
		//46305280
	}
	print(modules.First().ModuleMemorySize.ToString());
}

startup
{
	vars.booting = false;
	settings.Add("any%", true, "Any%");
	settings.Add("twilightthorn", true, "Twilight Thorn", "any%");
	settings.Add("setzer", true, "Setzer");
	settings.Add("axel2", true, "Axel II");
	settings.Add("bailey", true, "Bailey");
	settings.Add("shanyu", true, "Shan-Yu");
	settings.Add("hydra", true, "Hydra");
	settings.Add("darkthorn", true, "Dark Thorn");
	settings.Add("minnieescort", true, "Minnie Escort");
	settings.Add("barbossa", true, "Barbossa");
	settings.Add("twinlords", true, "Twin Lords");
	settings.Add("oogieboogie", true, "Oogie Boogie");
	settings.Add("berserkers", true, "Berserker's fight");
	settings.Add("hostileprogram", true, "Hostile Program");
	settings.Add("1k", true, "1K Heartless");
	settings.Add("rumblingrose", true, "Rumbling Rose");
	settings.Add("grimreaper2", true, "Grim Reaper II");
	settings.Add("experiment", true, "The Experiment");
	settings.Add("geniejafar", true, "Genie Jafar");
	settings.Add("stormrider", true, "Storm Rider");
	settings.Add("roxas1", true, "Roxas");
	settings.Add("xigbar", true, "Xigbar");
	settings.Add("luxord", true, "Luxord");
	settings.Add("saix", true, "Saix");
	settings.Add("xenmas13", true, "Xenmas I");
	settings.Add("core", true, "Core");
	settings.Add("armorxenmas1", true, "Armored Xenmas I");
	settings.Add("dragonxenmas", true, "Dragon Xenmas");
	settings.Add("armorxenmas2", true, "Armored Xenmas II");
	settings.Add("finalxenmas", true, "Final Xenmas");
	
}

start
{

}

split
{
	//Twilight Thorn
	if(settings["twilightthorn"] && current.worldID == 0x02 && current.roomID == 0x22 && current.eventID1 == 0x9D){
		if(vars.splitTimer <= 0){
			if(current.fightend && !old.fightend && current.soraHP > 0){
				vars.splitTimer = 300;
				return true;
			}
		}
		else if(!current.fightend){
			vars.splitTimer = vars.splitTimer-1;
		}
		return false;
	}
}

exit
{
	vars.booting = true;
	timer.IsGameTimePaused = true;
}

update
{
	if(vars.booting && current.titlescreen == 1){
		vars.booting = false;
	}
}

isLoading
{
	return current.load || current.saveload || current.black==128;
}