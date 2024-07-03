state("KINGDOM HEARTS II FINAL MIX", "EPIC-GLOBAL")
{
	bool load : "KINGDOM HEARTS II FINAL MIX.exe", 0x8EBFF3;
	byte black: "KINGDOM HEARTS II FINAL MIX.exe", 0xABAE07;
	bool saveload: "KINGDOM HEARTS II FINAL MIX.exe", 0xBEE094;
	bool fightend: "KINGDOM HEARTS II FINAL MIX.exe", 0xAD8E00;
	byte titlescreen: "KINGDOM HEARTS II FINAL MIX.exe", 0x713438;
	byte soraHP: "KINGDOM HEARTS II FINAL MIX.exe", 0x2A22FD8;
	short storyHP: "KINGDOM HEARTS II FINAL MIX.exe", 0x2A22D60;
	byte cloneCount: "KINGDOM HEARTS II FINAL MIX.exe", 0x2A0F488;
	short soraGauge: "KINGDOM HEARTS II FINAL MIX.exe", 0x2A0F57A;
	short medalTimer: "KINGDOM HEARTS II FINAL MIX.exe", 0x25B9554;
	byte marluxiaHitCount: "KINGDOM HEARTS II FINAL MIX.exe", 0x2590194;
	byte worldID: "KINGDOM HEARTS II FINAL MIX.exe", 0x716DF8;
	byte roomID: "KINGDOM HEARTS II FINAL MIX.exe", 0x716DF9;
	byte eventID1: "KINGDOM HEARTS II FINAL MIX.exe", 0x716DFC;
	byte eventID2: "KINGDOM HEARTS II FINAL MIX.exe", 0x716DFE;
	byte eventID3: "KINGDOM HEARTS II FINAL MIX.exe", 0x716E00;
	byte newgame: "KINGDOM HEARTS II FINAL MIX.exe", 0xBEE168;
	int tempMemBank: "KINGDOM HEARTS II FINAL MIX.exe", 0xBEE0F0;
}

state("KINGDOM HEARTS II FINAL MIX", "STEAM-GLOBAL")
{
	bool load : "KINGDOM HEARTS II FINAL MIX.exe", 0x8EC543;
	byte black: "KINGDOM HEARTS II FINAL MIX.exe", 0xABB347;
	bool saveload: "KINGDOM HEARTS II FINAL MIX.exe", 0xBEE5D4;
	bool fightend: "KINGDOM HEARTS II FINAL MIX.exe", 0xAD9340;
	byte titlescreen: "KINGDOM HEARTS II FINAL MIX.exe", 0x7169B4;
	byte soraHP: "KINGDOM HEARTS II FINAL MIX.exe", 0x2A23518;
	short storyHP: "KINGDOM HEARTS II FINAL MIX.exe", 0x2A232A0;
	byte cloneCount: "KINGDOM HEARTS II FINAL MIX.exe", 0x2A0F9C8;
	short soraGauge: "KINGDOM HEARTS II FINAL MIX.exe", 0x2A0FABA;
	short medalTimer: "KINGDOM HEARTS II FINAL MIX.exe", 0x25B9BF4;
	byte marluxiaHitCount: "KINGDOM HEARTS II FINAL MIX.exe", 0x2590894;
	byte worldID: "KINGDOM HEARTS II FINAL MIX.exe", 0x717008;
	byte roomID: "KINGDOM HEARTS II FINAL MIX.exe", 0x717009;
	byte eventID1: "KINGDOM HEARTS II FINAL MIX.exe", 0x71700C;
	byte eventID2: "KINGDOM HEARTS II FINAL MIX.exe", 0x71700E;
	byte eventID3: "KINGDOM HEARTS II FINAL MIX.exe", 0x717010;
	byte newgame: "KINGDOM HEARTS II FINAL MIX.exe", 0xBEE6A8;
	int tempMemBank: "KINGDOM HEARTS II FINAL MIX.exe", 0xBEE6B0;
}

state("KINGDOM HEARTS II FINAL MIX", "STEAM-JP")
{
	bool load : "KINGDOM HEARTS II FINAL MIX.exe", 0x8EB543;
	byte black: "KINGDOM HEARTS II FINAL MIX.exe", 0xABA347;
	bool saveload: "KINGDOM HEARTS II FINAL MIX.exe", 0xBED5D4;
	bool fightend: "KINGDOM HEARTS II FINAL MIX.exe", 0xAD8340;
	byte titlescreen: "KINGDOM HEARTS II FINAL MIX.exe", 0x7159B4;
	byte soraHP: "KINGDOM HEARTS II FINAL MIX.exe", 0x2A22518;
	short storyHP: "KINGDOM HEARTS II FINAL MIX.exe", 0x2A222A0;
	byte cloneCount: "KINGDOM HEARTS II FINAL MIX.exe", 0x2A0E9C8;
	short soraGauge: "KINGDOM HEARTS II FINAL MIX.exe", 0x2A0EABA;
	short medalTimer: "KINGDOM HEARTS II FINAL MIX.exe", 0x25B8BF4;
	byte marluxiaHitCount: "KINGDOM HEARTS II FINAL MIX.exe", 0x258F894;
	byte worldID: "KINGDOM HEARTS II FINAL MIX.exe", 0x716008;
	byte roomID: "KINGDOM HEARTS II FINAL MIX.exe", 0x716009;
	byte eventID1: "KINGDOM HEARTS II FINAL MIX.exe", 0x71600C;
	byte eventID2: "KINGDOM HEARTS II FINAL MIX.exe", 0x71600E;
	byte eventID3: "KINGDOM HEARTS II FINAL MIX.exe", 0x716010;
	byte newgame: "KINGDOM HEARTS II FINAL MIX.exe", 0xBED6A8;
	int tempMemBank: "KINGDOM HEARTS II FINAL MIX.exe", 0xBED6B0;
}

init
{
	timer.IsGameTimePaused = false;
	vars.splitTimer = 0;
	vars.startCounter = 0;
	Thread.Sleep(2000);
	var gb = modules.First().BaseAddress;
    if (modules.First().ModuleMemorySize == 46313472) { 
        if (memory.ReadValue<int>(gb + 0x9A92F0) == 0x4A32484B) {
            version = "EPIC-GLOBAL";
		} else if (memory.ReadValue<int>(gb + 0x9A9830) == 0x4A32484B){
            version = "STEAM-GLOBAL";
        }
	} else if (modules.First().ModuleMemorySize == 46309376) {
		if (memory.ReadValue<int>(gb + 0x9A8830) == 0x4A32484B){
			version = "STEAM-JP";
		}
	}
	//print("The Game's base address is:"+modules.First().BaseAddress.ToString()+" and "+ modules.First().ModuleMemorySize.ToString());
	print(version);
}

startup
{
	vars.booting = false;
		settings.Add("startREADME", false, "README: Auto-Start (Hover Over)");
		settings.SetToolTip("startREADME", "To Enable: Click the button ABOVE called 'Start'."+
						"\nOnly works when starting from the main menu."+
						"\nMake sure to reset before selecting New Game."+
						"\nSet timer to start at 0.31 for Any% (From Edit Splits).");
		settings.Add("splitREADME", false, "README: Auto-Split (Hover Over)");
		settings.SetToolTip("splitREADME", "To Enable: Click the button ABOVE called 'Split'."+
						"\nSelect the category you wish to run, the desired worlds, "+
						"as well as the world's ending split.");
		settings.Add("Instructions 4", false, "--------------------------------");
		settings.Add("any", false, "Any%");
			settings.Add("STT", true, "Roxas Section", "any");
				settings.Add("02-04-4E", false, "Seifer 2", "STT");
				settings.Add("02-0E-80", false, "Mansion Dusk", "STT");
				settings.Add("02-06-5B", false, "Mail Delivery", "STT");
				settings.Add("02-20-9A", false, "Triple Dusk", "STT");
				settings.Add("02-22-9D", false, "Twilight Thorn", "STT");
				settings.Add("02-05-54", false, "Hayner Struggle", "STT");
				settings.Add("02-05-55", false, "Vivi Struggle", "STT");
				settings.Add("02-05-57", false, "Axel 1", "STT");
				settings.Add("02-0C-7D", false, "7 Wonders: Bag", "STT");
				settings.Add("02-14-89", true , "Axel 2", "STT");

			settings.Add("TT1", true, "Twilight Town 1", "any");
				settings.Add("02-08-6C", false, "Station Plaza fight","TT1");
				settings.Add("02-19-95", false, "Tower: Entryway Heartless","TT1");
				settings.Add("02-1D-98", false, "Tower: Star Chamber Heartless","TT1");
				settings.Add("02-1E-99", false, "Tower: Moon Chamber Heartless","TT1");
				settings.Add("02-1C-04", true , "Leaving Tower (on the Door)","TT1");
				settings.Add("02-1B-04", true , "Leaving Tower (Cutscene leaving Tower)","TT1");
	

			settings.Add("HB1", true, "Hollow Bastion 1", "any");	
				settings.Add("04-09-33", false, "Nobody Battle", "HB1");
				settings.Add("04-08-34", true , "Bailey","HB1");

			settings.Add("LoD1", true, "Land of Dragons 1", "any");
				settings.Add("Missions", false, "Missions", "LoD1");
					settings.Add("08-01-44", false, "Pre-mission Fight", "Missions");
					settings.Add("08-02-45", false, "Mission 1: The Surprise Attack", "Missions");
					settings.Add("08-02-50", false, "Mission 2: The Ambush", "Missions");
					settings.Add("08-01-46", false, "Mission 3: The Search", "Missions");
				settings.Add("08-03-47", false, "Mountain Climb", "LoD1");
				settings.Add("08-05-48", false, "Cave Fight", "LoD1");
				settings.Add("08-07-49", false, "Summit Timed Fight", "LoD1");
				settings.Add("08-08-4A", false, "Imperial Square Fight", "LoD1");
				settings.Add("08-09-4B", true , "Shan-Yu","LoD1");

			settings.Add("OC1", true,  "Olympus Coliseum","any");
				settings.Add("06-05-6F", false, "Hades Escape","OC1");
				settings.Add("06-07-72", false, "Cerberus","OC1");
				settings.Add("06-00-8C", false, "Urns 1","OC1");
				settings.Add("06-00-8D", false, "Urns 2","OC1");
				settings.Add("06-11-7B", false, "Water clones","OC1");
				settings.Add("06-08-74", false, "Pete","OC1");			
				settings.Add("06-12-AB", true , "Hydra","OC1");

			settings.Add("04-0D-08", false, "Acquire Chicken Little (HB2)","any");
			settings.Add("04-09-3A", false, "HB2 Heartless Fight","any");

			settings.Add("BC1", true, "Beast Castle 1","any");
				settings.Add("05-0B-48", false, "Thresholder","BC1");
				settings.Add("05-03-45", false, "Wake up, Beast !", "BC1");
				settings.Add("05-05-4E", false, "Shadow Stalker","BC1");
				settings.Add("05-05-4F", true , "Dark Thorn","BC1");

			settings.Add("0C-00-33", false, "Minnie Escort","any");
			settings.Add("TR", true, "Timeless River", "any");
				settings.Add("0D-05-37", false, "Construction Site Window","TR");
				settings.Add("0D-04-36", false, "Tiny Town (Lilliput) Window","TR");
				settings.Add("0D-06-38", false, "Scene of the Fire Window","TR");
				settings.Add("0D-07-39", false, "Mickey's House window","TR");
				settings.Add("0D-03-35", true , "Timeless River Pete","TR");

			settings.Add("PR1", true, "Port Royal 1", "any");
				settings.Add("10-02-37", false, "Town Heartless battle", "PR1");
				settings.Add("10-09-3B", false, "Minute Pirate Fight", "PR1");
				settings.Add("10-07-3A", false, "Boat Fight", "PR1");
				settings.Add("10-0A-3C", true , "Barbossa","PR1");

			settings.Add("AG1", true, "Agrabah 1", "any");
				settings.Add("07-09-02", false, "Abu's crystal", "AG1");
				settings.Add("07-0D-4F", false, "Chasm of Challenges", "AG1");
				settings.Add("07-0A-3A", false, "Treasure room fight", "AG1");
				settings.Add("07-03-3B", true , "Twin Lords","AG1");

			settings.Add("HT1", true, "Halloween Town 1","any");
				settings.Add("0E-06-35", false, "Candy Cane Lane Battle","HT1");
				settings.Add("0E-03-34", false, "Prison Keeper","HT1");
				settings.Add("0E-09-37", true , "Oogie Boogie","HT1");

			settings.Add("TT2", true, "Twilight Town 2", "any");
				settings.Add("02-04-50", false, "Berserker Fight","TT2");
				settings.Add("02-02-48", false, "Acquire Limit Form","TT2");

			settings.Add("SP1", true,  "Space Paranoids 1","any");
				settings.Add("11-02-3E", false, "Light Cycle","SP1");
				settings.Add("11-03-36", false, "Screen Minigame","SP1");
				settings.Add("11-04-37", true , "Hostile Program","SP1");

			settings.Add("HB3", true, "Hollow Bastion 3","any");
				settings.Add("04-14-56", false, "Corridor fight", "HB3");
				settings.Add("04-12-49", false, "Dancers fight", "HB3");
				settings.Add("04-04-37", false, "Demyx","HB3");
				settings.Add("04-10-41", false, "Final Fantasy Fights","HB3");
				settings.Add("04-11-42", true , "1K Heartless","HB3");

			settings.Add("BC2", true, "Beast's castle 2", "any");
				settings.Add("05-03-0B", false, "Rumbling Rose", "BC2");
				settings.Add("05-03-14-W", false, "Leaving BC after Rumbling Rose", "BC2");
				settings.Add("05-00-4B", false, "Entrance hall Nobody fight","BC2");
				settings.Add("05-0F-52", true , "Xaldin","BC2");

			settings.Add("PR2", true, "Port Royal 2","any");
				settings.Add("10-12-55", false, "Grim Reaper 1","PR2");
				settings.Add("10-01-36", true , "Grim Reaper 2","PR2");

			settings.Add("HT2", true, "Halloween Town 2", "any");
				settings.Add("0E-0A-3E", false, "Trap Lock, Shock & barrel", "HT2");
				settings.Add("0E-00-3C", false, "Collect the 4 presents", "HT2");
				settings.Add("0E-0A-3F", false, "Gift Wrapping", "HT2");
				settings.Add("0E-07-40", true , "The Experiment","HT2");

			settings.Add("AG2", true, "Agrabah 2", "any");
				settings.Add("07-0E-56", false, "Carpet Battle 1", "AG2");
				settings.Add("07-0E-57", false, "Carpet Battle 2", "AG2");
				settings.Add("07-0E-11", false, "Magic Switches", "AG2");
				settings.Add("07-0E-3D", false, "Escape from the Ruins (Carpet autoscroller)", "AG2");
				settings.Add("07-05-3E", true , "Genie Jafar","AG2");

			settings.Add("LoD2", true, "Land of Dragons 2", "any");
				settings.Add("08-07-4C", false, "Riku", "LoD2");
				settings.Add("08-08-51", false, "Imperial Square Heartless", "LoD2");
				settings.Add("08-0A-4E", false, "Antechamber Battle", "LoD2");
				settings.Add("08-08-4F", true , "Storm Rider","LoD2");

			settings.Add("TT3", true , "Twilight Town 3","any");
				settings.Add("02-29-BA", false, "Mansion Nobody Waves", "TT3");
				settings.Add("02-28-A0", false, "Betwixt and Between (without Axel)","TT3");
				settings.Add("02-28-A1", true , "Betwixt and Between","TT3");	

			settings.Add("TWTNW",true, "The World that Never Was", "any");
				settings.Add("12-15-41", false, "Roxas","TWTNW");
				settings.Add("12-0A-39", false, "Xigbar","TWTNW");
				settings.Add("12-0E-3A", false, "Luxord","TWTNW");
				settings.Add("12-0F-38", false, "Saix","TWTNW");
				settings.Add("12-13-3B", true , "Xemnas 1","TWTNW");

			settings.Add("KH", true, "Final Fights","any");
				settings.Add("12-19-46", false, "Core","KH");
				settings.Add("12-18-47", false, "Armored Xemnas 1","KH");
				settings.Add("12-16-48", false, "Dragon Xemnas","KH");
				settings.Add("12-17-49", false, "Armored Xemnas 2","KH");
				settings.Add("12-14-4A", true , "Final Xemnas","KH");
				
		settings.Add("AW", false, "All Remainder Optional Worlds");
			settings.Add("PL", true, "Pride Lands","AW");
				settings.Add("0A-02-33", false, "Hyena Battle (Protect Timon/Pumbaa)","PL");
				settings.Add("0A-0E-37", true , "Scar","PL");
				settings.Add("0A-05-39", false, "Graveyard: Three Hyena Fight","PL");
				settings.Add("0A-0F-3B", true , "Ground Shaker","PL");
			settings.Add("SP2", true, "Space Paranoids 2","AW");
				settings.Add("11-02-35", false, "Light Cycle Battle","SP2");
				settings.Add("11-04-38", false, "I/O Tower: Hallway battle","SP2");
				settings.Add("11-07-39", false, "Solar Sailor Simulation","SP2");
				settings.Add("11-09-3A", false, "Sark","SP2");
				settings.Add("11-09-3B", true , "MCP (with Sark)","SP2");
			settings.Add("100AW", true, "100 Acre Woods","AW");
				settings.Add("09-04-04", false, "Piglet's House","100AW");
				settings.Add("09-03-04", false, "Rabbit's House","100AW");
				settings.Add("09-05-04", false, "Tigger's House","100AW");
				settings.Add("09-09-03", false, "Spooky Cave","100AW");
				settings.Add("09-01-03", true, "Starry Hill","100AW");
			settings.Add("OC2", true , "Olympus Coliseum 2","AW");
				settings.Add("06-06-7E", false, "Nobodies Fight","OC2");
				settings.Add("06-13-CA", true, "Hades","OC2");
			settings.Add("ATL", true, "Atlantica","AW");
				settings.Add("0B-02-3F", false, "Tutorial","ATL");
				settings.Add("0B-04-40", false, "Swim This Way","ATL");
				settings.Add("0B-01-33", false, "Part of Your World","ATL");
				settings.Add("0B-03-35", false, "Under the Sea","ATL");
				settings.Add("0B-09-41", false, "Ursula's Revenge","ATL");
				settings.Add("0B-04-37", false, "A New Day is Dawning","ATL");
				settings.Add("0B-04-67", true , "Basic Atlantica Split","ATL");
				
		settings.Add("Super", false, "All Super Bosses, and Absent Silhouettes");
			settings.Add("Silh", false, "Absent Silhouettes", "Super");
				settings.Add("04-20-73", false, "AS Vexen","Silh");
				settings.Add("04-21-8E", false, "AS Lexaeus","Silh");
				settings.Add("04-21-8F", false, "AS Larxene","Silh");
				settings.Add("04-22-97", false, "AS Zexion","Silh");
				settings.Add("04-26-91", false, "AS Marluxia","Silh");
			settings.Add("0C-07-44", true, "Terra","Super");
			settings.Add("04-01-4B", true, "Sephiroth","Super");
		settings.Add("Data", false, "Data Org");
			settings.Add("02-14-D5", true, "Data Axel","Data");
			settings.Add("04-04-72", true, "Data Demyx","Data");
			settings.Add("04-20-92", true, "Data Vexen","Data");
			settings.Add("04-21-93", true, "Data Lexaeus","Data");
			settings.Add("04-21-94", true, "Data Larxene","Data");
			settings.Add("04-22-98", true, "Data Zexion","Data");
			settings.Add("04-26-96", true, "Data Marluxia","Data");
			settings.Add("05-0F-61", true, "Data Xaldin","Data");
			settings.Add("12-0A-64", true, "Data Xigbar","Data");
			settings.Add("12-0E-65", true, "Data Luxord","Data");
			settings.Add("12-0F-66", true, "Data Saix","Data");
			settings.Add("12-13-61", true, "Data Xemnas","Data");
			settings.Add("12-14-62", true, "Data Final Xemnas","Data");
			settings.Add("12-15-63", true, "Data Roxas","Data");
			
		settings.Add("GC", false, "(Experimental) Gold Crown / Jimminy's Journal 100%");
			settings.Add("GCNote", false, "There's a lot that goes into a GC/JJ run. "+
						"Bear with us as we find ways to create them.","GC");
}

reset
{
	if (current.titlescreen != 1)return;
	
	if(vars.startCounter==0 && current.newgame==4){
		vars.startCounter = 1;
	}
	if(vars.startCounter==1){	
		if(current.tempMemBank == 0){
			vars.startCounter = 0;
		}
		else if(current.newgame == 2){
			vars.startCounter = 2;
			return true;
		}
	}
}

start
{
	if (current.titlescreen != 1)return;
	
	if(vars.startCounter==0 && current.newgame==4)vars.startCounter = 1;
	
	if(vars.startCounter==1){	
		if(current.tempMemBank == 0)vars.startCounter = 0;
		else if(current.newgame == 2)vars.startCounter = 2;
	}
	
	if(vars.startCounter==2){
		if(current.newgame == 4)vars.startCounter = 1;
		else if(current.tempMemBank == 0){
			vars.startCounter = 0;
			return true;
		}
	}
}

split
{	
	if(vars.startCounter != 0 && current.titlescreen == 0)vars.startCounter = 0;
	
	string currentLocation = string.Format("{0:X2}-{1:X2}-{2:X2}", current.worldID, current.roomID, current.eventID3);
	string oldLocation     = string.Format("{0:X2}-{1:X2}-{2:X2}", old.worldID, old.roomID, old.eventID3);
	
	//Conditional cases if Sora or specific things need to survive
	switch (currentLocation) {
		//Party Member Dying
		case "12-14-4A": 
		case "12-14-69":
		case "10-0A-3C":
			if(current.storyHP == 0 || current.soraHP == 0)vars.splitTimer = 10;
			break;
		//Demyx
		case "04-04-37":
		case "04-04-72":
			if(current.cloneCount > 0 || current.soraHP == 0)vars.splitTimer = 10;
			break;
		//Riku?
		case "08-07-4C":
			if(current.storyHP == 228 && old.storyHP > 228)return settings[currentLocation];
			break;
		//Top Left Gauge Runs Out
		case "04-08-34":
		case "08-01-44":
		case "08-01-46":
		case "08-02-45":
		case "08-02-50":
		case "08-03-47":
		case "08-09-4B":
		case "12-0E-3A":
		case "12-0E-65":
			if (current.soraGauge == 0 || current.soraHP == 0)vars.splitTimer = 10;
			break;
		//Top Left Gauge Fills to MAX
		case "0A-02-33":
		case "0C-02-01":
		case "0C-00-33":
		case "0D-04-36":
		case "0D-06-38":
		case "0D-05-37":
		case "0D-07-39":
		case "11-07-39":
			if (current.soraGauge == 17096 || current.soraHP == 0)vars.splitTimer = 20;
			break;
		//Boat Fight
		case "10-07-3A":
			if ((current.medalTimer!=old.medalTimer && current.medalTimer == 0) || current.soraHP == 0)vars.splitTimer = 20;
			break;
			
		//Marluxia
		case "04-26-91":
		case "04-26-96":
			if (current.marluxiaHitCount == 0 || current.soraHP == 0)vars.splitTimer = 10;
			break;
		default:
			if(current.soraHP == 0)vars.splitTimer = 10;
			break;
	}
	if(vars.splitTimer > 0){
		if (current.fightend != true)--vars.splitTimer;
		//print(vars.splitTimer.ToString());
		return;
	}
	
	// Write all and any split logic under here. 
	// The splitTimer if statement above will stop it from double splitting.
	if(current.fightend == true){
		//print("Fight ended! Loc: "+currentLocation);
		vars.splitTimer = 10;
		return settings[currentLocation];
	} else if (currentLocation!=oldLocation){
		//print("C:"+currentLocation+" O:"+oldLocation);
		switch(oldLocation) {
			case "02-02-48":
			case "02-08-6C":
			case "02-1B-04":
			case "02-1C-04":
			case "04-0D-08":
			case "06-05-6F":
			case "08-03-47":
			case "09-01-03":
			case "09-03-04":
			case "09-04-04":
			case "09-05-04":
			case "09-09-03":
			case "12-19-46":
			case "0B-02-3F":
			case "0B-04-40":
			case "0B-01-33":
			case "0B-03-35":
			case "0B-09-41":
			case "0B-04-37":
			case "0B-04-67":
				return settings[oldLocation];
				break;
			case "02-0E-05":
				vars.splitTimer = 100;
			break;
			case "05-03-14":
				if (current.worldID == 0x0F){
					vars.splitTimer = 1800;
					return settings[oldLocation+"-W"];
				}
				break;	
			default:
				break;
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
	if(vars.booting && current.titlescreen == 1)vars.booting = false;
}

isLoading
{
	return current.load || current.saveload || current.black==128;
}
