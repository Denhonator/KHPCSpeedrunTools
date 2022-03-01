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
	int tempMemBank: "KINGDOM HEARTS II FINAL MIX.exe", 0xBEBE10;
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
	vars.startCounter = 0;
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
		settings.Add("any", false, "Any% - Set timer to 0.31 if Auto Starting as well.");
			settings.Add("STT", true, "Roxas Section", "any");
				settings.Add("02-06-5B", false, "Mail Delivery", "STT");
				settings.Add("02-22-9D", false, "Twilight Thorn", "STT");
				settings.Add("02-05-54", false, "Hayner Struggle", "STT");
				settings.Add("02-05-55", false, "Vivi Struggle", "STT");
				settings.Add("02-05-57", false, "Axel 1", "STT");
				settings.Add("02-0C-7D", false, "7 Wonders: Bag", "STT");
				settings.Add("02-14-89", true, "Axel 2", "STT");
			settings.Add("TT1", true, "Twilight Town 1", "any");
				settings.Add("02-1E-99", false, "Yen Sid's Tower Last Fight","TT1");
				settings.Add("02-1B-04", true, "Leaving Yen Sid's Tower (TT1)","TT1");
			settings.Add("04-08-34", true, "Bailey","any");
			settings.Add("08-09-4B", true, "Shan-Yu","any");
			settings.Add("OC1", true,  "Olympus Colosseum","any");
				settings.Add("06-07-72", false, "Cerberus","OC1");
				settings.Add("06-12-AB", true, "Hydra","OC1");
			settings.Add("04-0D-65", false, "Acquire Chicken Little (HB2)","any");
			settings.Add("BC1", true, "Beast Castle 1","any");
				settings.Add("05-0B-48", false, "Thresholder","BC1");
				settings.Add("05-05-4F", true, "Dark Thorn","BC1");
			settings.Add("0C-00-33", false, "Minnie Escort","any");
			settings.Add("0D-03-35", true , "Timeless River Pete","any");
			settings.Add("10-0A-3C", true , "Barbossa","any");
			settings.Add("07-03-3B", true , "Twin Lords","any");
			settings.Add("HT1", true, "Halloween Town 1","any"); 
				settings.Add("0E-03-34", false, "Prison Keeper","HT1");
				settings.Add("0E-09-37", true, "Oogie Boogie","HT1");
			settings.Add("02-04-50", false, "Berserker fight (TT2)","any");
			settings.Add("02-08-74", false, "Acquire Limit Form (TT2)","any");
			settings.Add("SP1", true,  "Space Paranoids 1","any");
				settings.Add("11-02-EF", false, "Light Cycle","SP1");
				settings.Add("11-03-36", false, "Screen Minigame","SP1");
				settings.Add("11-04-37", true, "Hostile Program","SP1");
			settings.Add("HB3", true, "Hollow Bastion 3","any");
				settings.Add("04-04-37", false, "Demyx","HB3");
				settings.Add("04-10-41", false, "Final Fantasy Fights","HB3");
				settings.Add("04-11-42", true , "1K Heartless","HB3");
			settings.Add("05-03-0B", false, "Rumbling Rose", "any");
			settings.Add("PR2", true, "Port Royal 2","any");
				settings.Add("10-12-55", false, "Grim Reaper 1","PR2");
				settings.Add("10-01-36", true, "Grim Reaper 2","PR2");
			settings.Add("0E-07-40", true , "The Experiment","any");
			settings.Add("07-05-3E", true , "Genie Jafar","any");
			settings.Add("05-0F-52", true , "Xaldin","any");
			settings.Add("08-08-4F", true , "Storm Rider","any");
			settings.Add("02-28-A1", true , "Twilight Town 3","any");
			settings.Add("TWTNW",true, "The World that Never Was", "any");
				settings.Add("12-15-41", false, "Roxas","TWTNW");
				settings.Add("12-0A-39", false, "Xigbar","TWTNW");
				settings.Add("12-0E-3A", false, "Luxord","TWTNW");
				settings.Add("12-0F-38", false, "Saix","TWTNW");
				settings.Add("12-13-3B", true , "Xenmas 1","TWTNW");
			settings.Add("KH", true, "Final Fights","any");
				settings.Add("12-19-46", false, "Core","KH");
				settings.Add("12-18-47", false, "Armored Xenmas 1","KH");
				settings.Add("12-16-48", false, "Dragon Xenmas","KH");
				settings.Add("12-17-49", false, "Armored Xenmas 2","KH");
				settings.Add("12-14-4A", true , "Final Xenmas","KH");
	
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
		if(current.tempMemBank == 0){
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
		if(current.tempMemBank == 0){
			vars.startCounter = 0;
			return true;
		}
	}
	else return false;
}

split
{	
	// Converts location IDs to string to compare against toggled splits.
	string currentLocation = string.Format("{0:X2}-{1:X2}-{2:X2}", current.worldID, current.roomID, current.eventID3);
	string oldLocation     = string.Format("{0:X2}-{1:X2}-{2:X2}", old.worldID, old.roomID, old.eventID3);
	
	// Timer to prevent double splits from occuring.
	if(vars.splitTimer == 0){
		// Determines if a fight is over. 
		if(current.fightend && !old.fightend && current.soraHP > 0){
			print("fightend!");
			vars.splitTimer = 10;
			if(settings["any"]){
				return settings[currentLocation];
			}
			else if (settings["dataorg"]) return true;
		}
		// For Event based splits.
		// Note: Not using if(settings[currentLocation]) as it conflicts with boss fights.
		if (currentLocation!=oldLocation){
			switch(currentLocation) {
				case "02-1B-04": 
				case "04-0D-65":
				case "02-08-74":
					print("Found settings at "+currentLocation);
					return settings[currentLocation];
					break;
				default:
					return false;
					break;
			}
		}
	}
	else if(current.fightend == false && vars.splitTimer > 0){
		vars.splitTimer = --vars.splitTimer;
	}
	else return false;
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
