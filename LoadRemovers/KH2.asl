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
	//To-do: Get Memory Addresses for JP
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
		settings.Add("Instructions", false, "For Any%: Select the world and the subsplits that you want.");
		settings.Add("Instructions 2", false, "Selecting only the world won't be enough to get the autosplitter to work");
		settings.Add("Instructions 4", false, "");

		settings.Add("any", false, "Any% - Set timer to 0.31 if Auto Starting as well.");
			settings.Add("STT", true, "Roxas Section", "any");
				settings.Add("02-06-5B", false, "Mail Delivery", "STT");
				settings.Add("02-22-9D", false, "Twilight Thorn", "STT");
				settings.Add("02-05-54", false, "Hayner Struggle", "STT");
				settings.Add("02-05-55", false, "Vivi Struggle", "STT");
				settings.Add("02-05-57", false, "Axel 1", "STT");
				settings.Add("02-0C-7D", false, "7 Wonders: Bag", "STT");
				settings.Add("02-14-89", true , "Axel 2", "STT");

			settings.Add("TT1", true, "Twilight Town 1", "any");
				settings.Add("02-1E-99", false, "Yen Sid's Tower Last Fight","TT1");
				settings.Add("02-1B-04", true, "Leaving Yen Sid's Tower (TT1)","TT1");

			settings.Add("HB1", true, "Hollow Bastion 1", "any");	
				settings.Add("04-09-33", false, "Nobody battle", "HB1");
				settings.Add("04-08-34", true , "Bailey","HB1");

			settings.Add("LoD1", true, "Land of Dragons 1", "any");
				settings.Add("08-05-48", false, "Cave fight", "LoD1");
				settings.Add("08-07-49", false, "Summit timed fight", "LoD1");
				settings.Add("08-09-4B", true , "Shan-Yu","LoD1");

			settings.Add("OC1", true,  "Olympus Coliseum","any");
				settings.Add("06-07-72", false, "Cerberus","OC1");
				settings.Add("06-12-AB", true , "Hydra","OC1");

			settings.Add("04-0D-65", false, "Acquire Chicken Little (HB2)","any");

			settings.Add("BC1", true, "Beast Castle 1","any");
				settings.Add("05-0B-48", false, "Thresholder","BC1");
				settings.Add("05-05-4F", true , "Dark Thorn","BC1");

			settings.Add("0C-00-33", false, "Minnie Escort","any");
			settings.Add("TR", true, "Timeless River", "any");
				settings.Add("0D-04-36", false, "Lilliput window","TR");
				settings.Add("0D-06-38", false, "Scene of the fire window","TR");
				settings.Add("0D-05-37", false, "Building Site window","TR");
				settings.Add("0D-07-39", false, "Mickey's house window","TR");
				settings.Add("0D-03-35", true , "Timeless River Pete","TR");

			settings.Add("PR1", true, "Port Royal 1", "any");
				settings.Add("10-09-3B", false, "Infinite pirate fight", "PR1");
				settings.Add("10-07-3A", false, "Boat Fight", "PR1");
				settings.Add("10-0A-3C", true , "Barbossa","PR1");

			settings.Add("AG1", true, "Agrabah 1", "any");
				settings.Add("07-09-02", false, "Abu's crystal", "AG1");
				settings.Add("07-0A-3A", false, "Treasure room fight", "AG1");
				settings.Add("07-03-3B", true , "Twin Lords","AG1");

			settings.Add("HT1", true, "Halloween Town 1","any"); 
				settings.Add("0E-03-34", false, "Prison Keeper","HT1");
				settings.Add("0E-09-37", true , "Oogie Boogie","HT1");

			settings.Add("TT2", true, "Twilight Town 2", "any");
				settings.Add("02-04-50", false, "Berserker fight","TT2");
				settings.Add("02-08-74", false, "Acquire Limit Form","TT2");

			settings.Add("SP1", true,  "Space Paranoids 1","any");
				settings.Add("11-02-3E", false, "Light Cycle","SP1");
				settings.Add("11-03-36", false, "Screen Minigame","SP1");
				settings.Add("11-04-37", true , "Hostile Program","SP1");

			settings.Add("HB3", true, "Hollow Bastion 3","any");
				settings.Add("04-04-37", false, "Demyx","HB3");
				settings.Add("04-10-41", false, "Final Fantasy Fights","HB3");
				settings.Add("04-11-42", true , "1K Heartless","HB3");

			settings.Add("05-03-0B", false, "Rumbling Rose", "any");

			settings.Add("PR2", true, "Port Royal 2","any");
				settings.Add("10-12-55", false, "Grim Reaper 1","PR2");
				settings.Add("10-01-36", true , "Grim Reaper 2","PR2");

			settings.Add("HT2", true, "Halloween Town 2", "any");
				settings.Add("0E-0A-3E", false, "Trap Lock, Shock & barrel", "HT2");
				settings.Add("0E-07-40", true , "The Experiment","HT2");

			settings.Add("AG2", true, "Agrabah 2", "any");
				settings.Add("07-0E-3D", false, "Escape from the ruins (Carpet autoscroller)", "AG2");
				settings.Add("07-05-3E", true , "Genie Jafar","AG2");

			settings.Add("BC2", true, "Beast's castle 2", "any");
				settings.Add("05-00-4B", false, "Entrance hall Nobody fight","BC2");
				settings.Add("05-0F-52", true , "Xaldin","BC2");

			settings.Add("LoD2", true, "Land of Dragons 2", "any");
				settings.Add("08-08-51", false, "Imperial square heartless", "LoD2");
				settings.Add("08-08-4F", true , "Storm Rider","LoD2");

			settings.Add("TT3", true , "Twilight Town 3","any");
				//settings.Add("02-29-BA", false, "Mansion Nobody waves", "TT3");
				settings.Add("02-28-A1", true , "Betwix with Axel","TT3");	

			settings.Add("TWTNW",true, "The World that Never Was", "any");
				settings.Add("12-15-41", false, "Roxas","TWTNW");
				settings.Add("12-0A-39", false, "Xigbar","TWTNW");
				settings.Add("12-0E-3A", false, "Luxord","TWTNW");
				settings.Add("12-0F-38", false, "Saix","TWTNW");
				settings.Add("12-13-3B", true , "Xenmas 1","TWTNW");

			settings.Add("KH", true, "Final Fights","any");
				settings.Add("12-18-57", false, "Core","KH");
				settings.Add("12-18-47", false, "Armored Xenmas 1","KH");
				settings.Add("12-16-48", false, "Dragon Xenmas","KH");
				settings.Add("12-17-49", false, "Armored Xenmas 2","KH");
				settings.Add("12-14-4A", true , "Final Xenmas","KH");
	
	//dataorg
		settings.Add("Data Org instructions", false, "");
		settings.Add("Instructions 3", false, "Uncheck 'Any%' and select 'Data Org' at the bottom.");
		settings.Add("Data Org instructions 2", false, "Auto-Start is not currently supported for Data Org");
		settings.Add("dataorg", false, "Data Org");
}

start
{
	if(vars.startCounter==0 && current.newgame == 4){
		vars.startCounter = 1;
	}
	if(vars.startCounter==1){	
		if(current.tempMemBank == 0){
			vars.startCounter = 0;
		}
		if(current.newgame == 2){
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
}

split
{	
	//startCounter didn't reset. Happens if you start it manually while using 2fmSoftReset.lua
	if(vars.startCounter != 0) vars.startCounter = 0;
	
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
		// For Event based splits
		if (currentLocation!=oldLocation){
			switch(currentLocation) {
				case "02-1B-04": 
				case "04-0D-65":
				case "02-08-74":
				case "12-18-57":
					print("Found settings at "+currentLocation);
					return settings[currentLocation];
					break;
				default:
					break;
			}
		}
	}
	else if(current.fightend == false && vars.splitTimer > 0){
		vars.splitTimer = --vars.splitTimer;
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
