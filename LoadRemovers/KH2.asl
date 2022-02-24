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
		//Roxas Section
			settings.Add("roxassection", false, "Roxas Section", "any");
				settings.Add("twilightthorn", false, "Twilight Thorn", "roxassection");
				settings.Add("axel1", false, "Axel I", "roxassection");
				settings.Add("axel2", false, "Axel II", "roxassection");
			settings.Add("tower", false, "Yen Sid's Tower second floor","any");
			settings.Add("bailey", false, "Bailey","any");
			settings.Add("shanyu", false, "Shan-Yu","any");
			settings.Add("hydra", false, "Hydra","any");
			settings.Add("heartlesspages", false, "Heartless steal Winnie's Pages","any");
			settings.Add("darkthorn", false, "Dark Thorn","any");
			settings.Add("minnieescort", false, "Minnie Escort","any");
			settings.Add("trpete", false, "Timeless River Pete","any");
			settings.Add("barbossa", false, "Barbossa","any");
			settings.Add("twinlords", false, "Twin Lords","any");
			settings.Add("oogieboogie", false, "Oogie Boogie","any");
			settings.Add("berserkers", false, "Berserker fight","any");
			settings.Add("hostileprogram", false, "Hostile Program","any");
			settings.Add("1k", false, "1K Heartless","any");
			settings.Add("grimreaper2", false, "Grim Reaper II","any");
			settings.Add("experiment", false, "The Experiment","any");
			settings.Add("geniejafar", false, "Genie Jafar","any");
			settings.Add("xaldin", false, "Xaldin","any");
			settings.Add("stormrider", false, "Storm Rider","any");
			settings.Add("roxas", false, "Roxas","any");
			settings.Add("xigbar", false, "Xigbar","any");
			settings.Add("luxord", false, "Luxord","any");
			settings.Add("saix", false, "Saix","any");
			settings.Add("xenmas1", false, "Xenmas I","any");
			settings.Add("core", false, "Core","any");
			settings.Add("armorxenmas1", false, "Armored Xenmas I","any");
			settings.Add("dragonxenmas", false, "Dragon Xenmas","any");
			settings.Add("armorxenmas2", false, "Armored Xenmas II","any");
			settings.Add("finalxenmas", false, "Final Xenmas","any");
	
	//dataorg
		settings.Add("dataorg", false, "Data Org");
}

start
{
	if(vars.startCounter==0){	
		if(current.newgame == 0 && old.newgame == 2){
			vars.startCounter += 1;
			return false;
		}
	}
	if(vars.startCounter==1){	
		if(current.newgame == 0 && old.newgame == 2){
			vars.startCounter = 0;
			return true;
		}
	}
}

split
{	
	if(vars.splitTimer <= 0){
		if(current.fightend && !old.fightend && current.soraHP > 0){
				print("fightend!");
				vars.splitTimer = 300;
				vars.endFight = true;
			}
		}
		
	else if(!current.fightend){
		vars.splitTimer = vars.splitTimer-1;
		vars.endFight = false;
	}
	
	else{
		vars.endFight = false;
	}
	if(vars.endFight){
		if(settings["any"]){
			//Seifer 2
			if(settings["seifer2"] && current.worldID == 0x02 && current.roomID == 0x04 && current.eventID1 == 0x4E){
				return true;
			}
			//Mansion Dusk
			if(settings["mansiondusk"] && current.worldID == 0x02 && current.roomID == 0x0E && current.eventID1 == 0x80){
				return true;
			}
			//Mail Delivery
			if(settings["maildelivery"] && current.worldID == 0x02 && current.roomID == 0x06 && current.eventID1 == 0x5B){
				return true;
			}
			//3 Dusks
			if(settings["3dusksfight1"] && current.worldID == 0x02 && current.roomID == 0x20 && current.eventID1 == 0x9A){
				return true;
			}
			//Twilight Thorn
			else if(settings["twilightthorn"] && current.worldID == 0x02 && current.roomID == 0x22 && current.eventID1 == 0x9D){
				return true;
			}
			//Hayner
			else if(settings["hayner"] && current.worldID == 0x02 && current.roomID == 0x05 && current.eventID1 == 0x54){
				return true;
			}
			//Vivi
			else if(settings["vivi"] && current.worldID == 0x02 && current.roomID == 0x05 && current.eventID1 == 0x55){
				return true;
			}
			//Balls In the Wall
			else if(settings["balls"] && current.worldID == 0x02 && current.roomID == 0x0A && current.eventID1 == 0x78){
				return true;
			}
			//Axel I
			else if(settings["axel1"] && current.worldID == 0x02 && current.roomID == 0x05 && current.eventID1 == 0x57){
				return true;
			}
			//Axel II
			else if(settings["axel2"] && current.worldID == 0x02 && current.roomID == 0x14 && current.eventID1 == 0x89){
				return true;
			}
			//Tower 2nd fight
			else if(settings["tower"] && current.worldID == 0x02 && current.roomID == 0x1E && current.eventID1 == 0x99){
				return true;
			}
			//Bailey
			else if(settings["bailey"] && current.worldID == 0x04 && current.roomID == 0x08 && current.eventID1 == 0x34){
				return true;
			}
			//Shan-Yu
			else if(settings["shanyu"] && current.worldID == 0x08 && current.roomID == 0x09 && current.eventID1 == 0x4B){
				return true;
			}
			//Hydra
			else if(settings["hydra"] && current.worldID == 0x06 && current.roomID == 0x12 && current.eventID1 == 0xAB){
				return true;
			}
			//Hollow Bastion 2
			else if(settings["heartlesspages"] && current.worldID == 0x04 && current.roomID == 0x09 && current.eventID1 == 0x3A){
				return true;
			}
			//Dark Thorn
			else if(settings["darkthorn"] && current.worldID == 0x05 && current.roomID == 0x05 && current.eventID1 == 0x4F){
				return true;
			}
			//Minnie's Escort
			else if(settings["minnieescort"] && current.worldID == 0x0C && current.roomID == 0x00 && current.eventID1 == 0x33){
				return true;
			}
			//TR Pete
			else if(settings["trpete"] && current.worldID == 0x0D && current.roomID == 0x03 && current.eventID1 == 0x35){
				return true;
			}
			//Barbossa
			else if(settings["barbossa"] && current.worldID == 0x10 && current.roomID == 0x0A && current.eventID1 == 0x3C){
				return true;
			}
			//Twin Lords
			else if(settings["twinlords"] && current.worldID == 0x07 && current.roomID == 0x03 && current.eventID1 == 0x3B){
				return true;
			}
			//Oogie Boogie
			else if(settings["oogieboogie"] && current.worldID == 0x0E && current.roomID == 0x09 && current.eventID1 == 0x37){
				return true;
			}
			//Berserker fight
			else if(settings["berserkers"] && current.worldID == 0x02 && current.roomID == 0x04 && current.eventID1 == 0x50){
				return true;
			}
			//Hostile Program
			else if(settings["hostileprogram"] && current.worldID == 0x11 && current.roomID == 0x04 && current.eventID1 == 0x37){
				return true;
			}
			//1k heartless
			else if(settings["1k"] && current.worldID == 0x04 && current.roomID == 0x11 && current.eventID1 == 0x42){
				return true;
			}
			//Grim Reaper II
			else if(settings["grimreaper2"] && current.worldID == 0x10 && current.roomID == 0x01 && current.eventID1 == 0x36){
				return true;
			}
			//Experiment
			else if(settings["experiment"] && current.worldID == 0x0E && current.roomID == 0x07 && current.eventID1 == 0x40){
				return true;
			}
			//Genie Jafar
			else if(settings["geniejafar"] && current.worldID == 0x07 && current.roomID == 0x05 && current.eventID1 == 0x3E){
				return true;
			}
			//Xaldin
			else if(settings["xaldin"] && current.worldID == 0x05 && current.roomID == 0x0F && current.eventID1 == 0x52){
				return true;
			}
			//Storm Rider
			else if(settings["stormrider"] && current.worldID == 0x08 && current.roomID == 0x08 && current.eventID1 == 0x4F){
				return true;
			}
			//Roxas
			else if(settings["roxas"] && current.worldID == 0x12 && current.roomID == 0x15 && current.eventID1 == 0x41){
				return true;
			}
			//Xigbar
			else if(settings["xigbar"] && current.worldID == 0x12 && current.roomID == 0x0A && current.eventID1 == 0x39){
				return true;
			}
			//Luxord
			else if(settings["luxord"] && current.worldID == 0x12 && current.roomID == 0x0E && current.eventID1 == 0x3A){
				return true;
			}
			//Saix
			else if(settings["saix"] && current.worldID == 0x12 && current.roomID == 0x0F && current.eventID1 == 0x38){
				return true;
			}
			//Xenmas I
			else if(settings["xenmas1"] && current.worldID == 0x12 && current.roomID == 0x13 && current.eventID1 == 0x3B){
				return true;
			}
			//Core
			else if(settings["core"] && current.worldID == 0x12 && current.roomID == 0x19 && current.eventID1 == 0x46){
				return true;
			}
			//Armor Xenmas 1
			else if(settings["armorxenmas1"] && current.worldID == 0x12 && current.roomID == 0x18 && current.eventID1 == 0x47){
				return true;
			}
			//Dragon Xenmas
			else if(settings["dragonxenmas"] && current.worldID == 0x12 && current.roomID == 0x16 && current.eventID1 == 0x48){
				return true;
			}
			//Armor Xenmas II
			else if(settings["armorxenmas2"] && current.worldID == 0x12 && current.roomID == 0x17 && current.eventID1 == 0x49){
				return true;
			}
			//Final Xenmas
			else if(settings["finalxenmas"] && current.worldID == 0x12 && current.roomID == 0x14 && current.eventID1 == 0x4A){
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
	else
	{
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
