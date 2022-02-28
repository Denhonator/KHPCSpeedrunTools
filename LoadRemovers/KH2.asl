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
				settings.Add("02-04-4E", false, "Seifer 2", "STT");
				settings.Add("02-0E-80", false, "Mansion Dusk", "STT");
				settings.Add("02-06-5B", false, "Mail Delivery", "STT");
				settings.Add("02-20-9A", false, "Three Dusks", "STT");
				settings.Add("02-22-9D", false, "Twilight Thorn", "STT");
				settings.Add("02-05-54", false, "Hayner Struggle", "STT");
				settings.Add("02-05-55", false, "Vivi Struggle", "STT");
				settings.Add("02-05-57", false, "Axel I", "STT");
				settings.Add("02-0A-78", false, "7 Wonders: Wall", "STT");
				settings.Add("02-24-9F", false, "7 Wonders: Vivi", "STT");
				settings.Add("02-0A-79", false, "7 Wonders: Shadow Roxas", "STT");
				settings.Add("02-0C-7D", false, "7 Wonders: Bag", "STT");
				settings.Add("02-03-49", false, "Two Dusk, One Assasain fight", "STT");
				settings.Add("02-13-86", false, "Basement Fight", "STT");
				settings.Add("02-14-89", false, "Axel II", "STT");
			settings.Add("02-1E-99", false, "Yen Sid's Tower Last Fight","any");
			settings.Add("02-1B-04", false, "Leaving Yen Sid's Tower (TT1)","any");
			settings.Add("04-08-34", false, "Bailey","any");
			settings.Add("08-09-4B", false, "Shan-Yu","any");
			settings.Add("06-12-AB", false, "Hydra","any");
			settings.Add("04-09-3A", false, "Fight for Pooh's Book","any");
			settings.Add("04-0D-65", false, "Acquire Chicken Little (HB2)","any");
			settings.Add("05-05-4F", false, "Dark Thorn","any");
			settings.Add("0C-00-33", false, "Minnie Escort","any");
			settings.Add("0D-03-35", false, "Timeless River Pete","any");
			settings.Add("10-0A-3C", false, "Barbossa","any");
			settings.Add("07-03-3B", false, "Twin Lords","any");
			settings.Add("0E-09-37", false, "Oogie Boogie","any");
			settings.Add("02-04-50", false, "Berserker fight","any");
			settings.Add("02-08-74", false, "Acquire Limit Form (TT2)","any");
			settings.Add("11-04-37", false, "Hostile Program","any");
			settings.Add("04-11-42", false, "1K Heartless","any");
			settings.Add("05-03-0B", false, "Rumbling Rose", "any");
			settings.Add("10-01-36", false, "Grim Reaper II","any");
			settings.Add("0E-07-40", false, "The Experiment","any");
			settings.Add("07-05-3E", false, "Genie Jafar","any");
			settings.Add("05-0F-52", false, "Xaldin","any");
			settings.Add("08-08-4F", false, "Storm Rider","any");
			settings.Add("02-28-A1", false, "Twilight Town 3","any");
			settings.Add("12-15-41", false, "Roxas","any");
			settings.Add("12-0A-39", false, "Xigbar","any");
			settings.Add("12-0E-3A", false, "Luxord","any");
			settings.Add("12-0F-38", false, "Saix","any");
			settings.Add("12-13-3B", false, "Xenmas I","any");
			settings.Add("12-19-46", false, "Core","any");
			settings.Add("12-18-47", false, "Armored Xenmas I","any");
			settings.Add("12-16-48", false, "Dragon Xenmas","any");
			settings.Add("12-17-49", false, "Armored Xenmas II","any");
			settings.Add("12-14-4A", false, "Final Xenmas","any");
	
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
	// Converts location IDs to string to compare against toggled splits.
	var currentLocationSetting = string.Format("{0:X2}-{1:X2}-{2:X2}", current.worldID, current.roomID, current.eventID3);
	
	// Timer to prevent double splits from occuring.
	if(vars.splitTimer == 0){
		// Determines if a fight is over. 
		if(current.fightend && !old.fightend && current.soraHP > 0){
			print("fightend!");
			vars.splitTimer = 10;
			if(settings["any"]){
				return settings[currentLocationSetting];
			}
			else if (settings["dataorg"]) return true;
		}
		// For Event based splits. Rumbling Rose is excluded in the if due to a bug.
		if (old.eventID3 != current.eventID3 && settings[currentLocationSetting] && !settings["05-03-0B"]){
			print("Found settings at "+currentLocationSetting);
			vars.splitTimer = 10;
			return settings[currentLocationSetting];
		}
	}
	else if(current.fightend == false){
		vars.splitTimer = vars.splitTimer-1;
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