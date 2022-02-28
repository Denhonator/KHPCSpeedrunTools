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
	byte newgame: "KINGDOM HEARTS II FINAL MIX.exe", 0xBEBE08;
	byte eventID1: "KINGDOM HEARTS II FINAL MIX.exe", 0x714DBC;
	byte eventID2: "KINGDOM HEARTS II FINAL MIX.exe", 0x714DBE;
	byte eventID3: "KINGDOM HEARTS II FINAL MIX.exe", 0x714DC0;
	int newgameSettings: "KINGDOM HEARTS II FINAL MIX.exe", 0xBEBE10;
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
	vars.currentSplit = 0;
	vars.startCounter = 0;
	vars.doubleSplitCounter = 0;
	vars.endFight = false;
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
	//any%
		settings.Add("any", false, "Any%");
			settings.Add("STT", false, "Roxas Section", "any");
				settings.Add("seifer2", false, "Seifer 2", "STT");
				settings.Add("mansiondusk", false, "Mansion Dusk", "STT");
				settings.Add("maildelivery", false, "Mail Delivery", "STT");
				settings.Add("3dusksfight1", false, "Three Dusks", "STT");
				settings.Add("twilThorn", false, "Twilight Thorn", "STT");
				settings.Add("hayner", false, "Hayner Struggle", "STT");
				settings.Add("vivi", false, "Vivi Struggle", "STT");
				settings.Add("axel1", false, "Axel I", "STT");
				settings.Add("7Wall", false, "7 Wonders: Wall", "STT");
				settings.Add("7Vivi", false, "7 Wonders: Vivi", "STT");
				settings.Add("7Shadow", false, "7 Wonders: Shadow Roxas", "STT");
				settings.Add("7Bag", false, "7 Wonders: Bag", "STT");
				settings.Add("2d1a", false, "Two Dusk, One Assasain fight", "STT");
				settings.Add("basement", false, "Basement Fight", "STT");
				settings.Add("axel2", false, "Axel II", "STT");
			settings.Add("tower", false, "Yen Sid's Tower Last Fight","any");
			settings.Add("tt1", false, "Leaving Yen Sid's Tower","any");
			settings.Add("bailey", false, "Bailey","any");
			settings.Add("shanyu", false, "Shan-Yu","any");
			settings.Add("hydra", false, "Hydra","any");
			settings.Add("poohFight", false, "Fight for Pooh's Book","any");
			settings.Add("chicken", false, "Acquire Chicken Little","any");
			settings.Add("darkthorn", false, "Dark Thorn","any");
			settings.Add("minnie", false, "Minnie Escort","any");
			settings.Add("trpete", false, "Timeless River Pete","any");
			settings.Add("barbossa", false, "Barbossa","any");
			settings.Add("twinlords", false, "Twin Lords","any");
			settings.Add("oogie", false, "Oogie Boogie","any");
			settings.Add("berserkers", false, "Berserker fight","any");
			settings.Add("limit", false, "Acquire Limit Form (TT2)","any");
			settings.Add("hostile", false, "Hostile Program","any");
			settings.Add("1k", false, "1K Heartless","any");
			settings.Add("rumbling", false, "Rumbling Rose", "any");
			settings.Add("gr2", false, "Grim Reaper II","any");
			settings.Add("experiment", false, "The Experiment","any");
			settings.Add("jafar", false, "Genie Jafar","any");
			settings.Add("xaldin", false, "Xaldin","any");
			settings.Add("stormrider", false, "Storm Rider","any");
			settings.Add("TT3", false, "Twilight Town 3","any");
			settings.Add("roxas", false, "Roxas","any");
			settings.Add("xigbar", false, "Xigbar","any");
			settings.Add("luxord", false, "Luxord","any");
			settings.Add("saix", false, "Saix","any");
			settings.Add("xenmas1", false, "Xenmas I","any");
			settings.Add("core", false, "Core","any");
			settings.Add("armored1", false, "Armored Xenmas I","any");
			settings.Add("dragon", false, "Dragon Xenmas","any");
			settings.Add("armored2", false, "Armored Xenmas II","any");
			settings.Add("final", false, "Final Xenmas","any");
	
	//dataorg
		settings.Add("dataorg", false, "Data Org");
}

start
{
	if(vars.startCounter==0){	
		if(current.newgame == 4){
			vars.startCounter = 1;
		}
	}
	if(vars.startCounter==1){	
		if(current.newgameSettings == 0){
			vars.startCounter = 0;
		}
		if(current.newgame == 2 && old.newgame == 2){
			vars.startCounter = 2;
		}
	}
	if(vars.startCounter==2){
		if(current.newgame == 4){
			vars.startCounter = 1;
		}
		if(current.newgameSettings == 0){
			vars.startCounter = 0;
			return true;
		}
	}
	else return false;
}

split
{	
	// Timer to prevent double splits from occuring.
	if(vars.splitTimer == 0){
		// Logic to split when a fight is over. 
		if(current.fightend && !old.fightend && current.soraHP > 0){
			print("fightend!");
			vars.splitTimer = 10;
			vars.endFight = true;
		}
	}
	else if(current.fightend == false){
		vars.splitTimer = vars.splitTimer-1;
		vars.endFight = false;
	}
	else{
		vars.endFight = false;
	}
	
	// New Timer for Event based splits.
	if (vars.splitTimer == 0 && (old.eventID1 != current.eventID1 || old.eventID2 != current.eventID2 || old.eventID3 != current.eventID3)){
		//Check which splits to do
		if (
			settings["tt1"] && current.worldID == 0x02 && current.roomID == 0x1B && current.eventID3 == 0x04 ||
			settings["chicken"] && current.worldID == 0x04 && current.roomID == 0x0D && current.eventID1 == 0x65 ||
			settings["limit"] && current.worldID == 0x02 && current.roomID == 0x08 && current.eventID1 == 0x74
		   ){
			print("Valid Room Split");
			vars.splitTimer = 500;
			return true;
		}
	}
	
	// Checks if the fight is a currently toggled split.
	if(vars.endFight){
		if(settings["any"]){
			//If any of these configurations are true, return true.
			if(
				// STT
				settings["seifer2"] && current.worldID == 0x02 && current.roomID == 0x04 && current.eventID1 == 0x4E||
				settings["mansiondusk"] && current.worldID == 0x02 && current.roomID == 0x0E && current.eventID1 == 0x80||
				settings["maildelivery"] && current.worldID == 0x02 && current.roomID == 0x06 && current.eventID1 == 0x5B||
				settings["3dusksfight1"] && current.worldID == 0x02 && current.roomID == 0x20 && current.eventID1 == 0x9A||
				settings["twilThorn"] && current.worldID == 0x02 && current.roomID == 0x22 && current.eventID1 == 0x9D||
				settings["hayner"] && current.worldID == 0x02 && current.roomID == 0x05 && current.eventID1 == 0x54||
				settings["vivi"] && current.worldID == 0x02 && current.roomID == 0x05 && current.eventID1 == 0x55||
				settings["axel1"] && current.worldID == 0x02 && current.roomID == 0x05 && current.eventID1 == 0x57||
				settings["7Wall"] && current.worldID == 0x02 && current.roomID == 0x0A && current.eventID1 == 0x78||
				settings["7Vivi"] && current.worldID == 0x02 && current.roomID == 0x24 && current.eventID1 == 0x9F||
				settings["7Shadow"] && current.worldID == 0x02 && current.roomID == 0x0A && current.eventID1 == 0x79||
				settings["7Bag"] && current.worldID == 0x02 && current.roomID == 0x0C && current.eventID1 == 0x7D||
				settings["2d1a"] && current.worldID == 0x02 && current.roomID == 0x03 && current.eventID1 == 0x49||
				settings["basement"] && current.worldID == 0x02 && current.roomID == 0x13 && current.eventID1 == 0x86||
				settings["axel2"] && current.worldID == 0x02 && current.roomID == 0x14 && current.eventID1 == 0x89||
				// TT1
				settings["tower"] && current.worldID == 0x02 && current.roomID == 0x1E && current.eventID1 == 0x99||
				//HB1
				settings["bailey"] && current.worldID == 0x04 && current.roomID == 0x08 && current.eventID1 == 0x34||
				//LOD1
				settings["shanyu"] && current.worldID == 0x08 && current.roomID == 0x09 && current.eventID1 == 0x4B||
				//OC1
				settings["hydra"] && current.worldID == 0x06 && current.roomID == 0x12 && current.eventID1 == 0xAB||
				//HB1
				settings["poohFight"] && current.worldID == 0x04 && current.roomID == 0x09 && current.eventID1 == 0x3A||
				//BC1
				settings["darkthorn"] && current.worldID == 0x05 && current.roomID == 0x05 && current.eventID1 == 0x4F||
				//DC and TR
				settings["minnie"] && current.worldID == 0x0C && current.roomID == 0x00 && current.eventID1 == 0x33||
				settings["trpete"] && current.worldID == 0x0D && current.roomID == 0x03 && current.eventID1 == 0x35||
				//PR1
				settings["barbossa"] && current.worldID == 0x10 && current.roomID == 0x0A && current.eventID1 == 0x3C||
				//AG1
				settings["twinlords"] && current.worldID == 0x07 && current.roomID == 0x03 && current.eventID1 == 0x3B||
				//HT1
				settings["oogie"] && current.worldID == 0x0E && current.roomID == 0x09 && current.eventID1 == 0x37||
				//TT2
				settings["berserkers"] && current.worldID == 0x02 && current.roomID == 0x04 && current.eventID1 == 0x50||
				//SP
				settings["hostile"] && current.worldID == 0x11 && current.roomID == 0x04 && current.eventID1 == 0x37||
				//HB3
				settings["1k"] && current.worldID == 0x04 && current.roomID == 0x11 && current.eventID1 == 0x42||
				//BC2
				settings["rumbling"] && current.worldID == 0x05 && current.roomID == 03 && current.eventID3 == 0x0B||
				settings["xaldin"] && current.worldID == 0x05 && current.roomID == 0x0F && current.eventID1 == 0x52||
				//PR2
				settings["gr2"] && current.worldID == 0x10 && current.roomID == 0x01 && current.eventID1 == 0x36||
				//HT2
				settings["experiment"] && current.worldID == 0x0E && current.roomID == 0x07 && current.eventID1 == 0x40||
				//AG2
				settings["jafar"] && current.worldID == 0x07 && current.roomID == 0x05 && current.eventID1 == 0x3E||
				//LOD2
				settings["stormrider"] && current.worldID == 0x08 && current.roomID == 0x08 && current.eventID1 == 0x4F||
				//TT3
				settings["TT3"] && current.worldID == 0x02 && current.roomID == 0x28 && current.eventID1 == 0xA1||
				//TWTNW
				settings["roxas"] && current.worldID == 0x12 && current.roomID == 0x15 && current.eventID1 == 0x41||
				settings["xigbar"] && current.worldID == 0x12 && current.roomID == 0x0A && current.eventID1 == 0x39||
				settings["luxord"] && current.worldID == 0x12 && current.roomID == 0x0E && current.eventID1 == 0x3A||
				settings["saix"] && current.worldID == 0x12 && current.roomID == 0x0F && current.eventID1 == 0x38||
				settings["xenmas1"] && current.worldID == 0x12 && current.roomID == 0x13 && current.eventID1 == 0x3B||
				//Final Fights
				settings["core"] && current.worldID == 0x12 && current.roomID == 0x19 && current.eventID1 == 0x46||
				settings["armored1"] && current.worldID == 0x12 && current.roomID == 0x18 && current.eventID1 == 0x47||
				settings["dragon"] && current.worldID == 0x12 && current.roomID == 0x16 && current.eventID1 == 0x48||
				settings["armored2"] && current.worldID == 0x12 && current.roomID == 0x17 && current.eventID1 == 0x49||
				settings["final"] && current.worldID == 0x12 && current.roomID == 0x14 && current.eventID1 == 0x4A
				)
			{
				return true; 
			}
		}
		else if(settings["dataorg"]){
			return true;
		}
		else
		{
			return false;
		}
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