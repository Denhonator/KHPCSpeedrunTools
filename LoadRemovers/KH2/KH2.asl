state("KINGDOM HEARTS II FINAL MIX", "GLOBAL")
{
	bool load : "KINGDOM HEARTS II FINAL MIX.exe", 0x8E9DA3;
	byte black: "KINGDOM HEARTS II FINAL MIX.exe", 0xAB8BC7;
	bool saveload: "KINGDOM HEARTS II FINAL MIX.exe", 0xBEBD34;
	bool fightend: "KINGDOM HEARTS II FINAL MIX.exe", 0xAD6BC0;
	byte titlescreen: "KINGDOM HEARTS II FINAL MIX.exe", 0x711438;
	byte soraHP: "KINGDOM HEARTS II FINAL MIX.exe", 0x2A20C98;
	//byte impreialSquareGateHPPointer: "KINGDOM HEARTS II FINAL MIX.exe", 0x25BD980;
	//byte imperialSquareGateHP: "KINGDOM HEARTS II FINAL MIX.exe", 0x25BD980;
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
	//Roxas Section
	settings.Add("roxassection", true, "Roxas Section");
	settings.Add("seifer2", false, "Seifer 2", "roxassection");
	settings.Add("mansiondusk", false, "Mansion Dusk", "roxassection");
	settings.Add("maildelivery", false, "Mail Delivery", "roxassection");
	settings.Add("3dusksfight1", false, "3 Dusks fight (Heart)", "roxassection");
	settings.Add("twilightthorn", false, "Twilight Thorn", "roxassection");
	settings.Add("hayner", false, "Hayner", "roxassection");
	settings.Add("vivi", false, "Vivi", "roxassection");
	settings.Add("axel1", false, "Axel I", "roxassection");
	settings.Add("balls", false, "Balls In The Wall", "roxassection");
	settings.Add("shadowroxas", false, "Shadow Roxas", "roxassection");
	settings.Add("bag", false, "Moving Bag", "roxassection");
	settings.Add("axel2", true, "Axel II", "roxassection");

	//station fight
	settings.Add("station", true, "Station");

	//Yen Sid's tower
	settings.Add("tower", true, "Yen Sid's Tower second floor");

	settings.Add("bailey", true, "Bailey");
	settings.Add("shanyu", true, "Shan-Yu");
	settings.Add("hydra", true, "Hydra");
	settings.Add("heartlesspages", true, "Heartless steal Winnie's Pages");
	settings.Add("darkthorn", true, "Dark Thorn");
	settings.Add("minnieescort", true, "Minnie Escort");
	settings.Add("trpete", true, "Timeless River Pete");
	settings.Add("barbossa", true, "Barbossa");
	settings.Add("twinlords", true, "Twin Lords");
	settings.Add("oogieboogie", true, "Oogie Boogie");
	settings.Add("berserkers", true, "Berserker's fight");
	settings.Add("hostileprogram", true, "Hostile Program");
	settings.Add("1k", true, "1K Heartless");
	settings.Add("grimreaper2", true, "Grim Reaper II");
	settings.Add("experiment", true, "The Experiment");
	settings.Add("geniejafar", true, "Genie Jafar");
	settings.Add("xaldin", true, "Xaldin");
	settings.Add("stormrider", true, "Storm Rider");
	settings.Add("roxas", true, "Roxas");
	settings.Add("xigbar", true, "Xigbar");
	settings.Add("luxord", true, "Luxord");
	settings.Add("saix", true, "Saix");
	settings.Add("xenmas1", true, "Xenmas I");
	settings.Add("core", true, "Core");
	settings.Add("armorxenmas1", true, "Armored Xenmas I");
	settings.Add("dragonxenmas", true, "Dragon Xenmas");
	settings.Add("armorxenmas2", true, "Armored Xenmas II");
	settings.Add("finalxenmas", true, "Final Xenmas");
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
		
		//Station Fight
		else if(settings["station"] && current.worldID == 0x02 && current.roomID == 0x08 && current.eventID1 == 0x6C){
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
		//Hostile Program
		else if(settings["hostileprogram"] && current.worldID == 0x11 && current.roomID == 0x04 && current.eventID1 == 0x37){
			return true;
		}
		//1k heartless
		else if(settings["1k"] && current.worldID == 0x04 && current.roomID == 0x11 && current.eventID1 == 0x42){
			return true;
		}
		//Oogie Boogie
		else if(settings["oogieboogie"] && current.worldID == 0x0E && current.roomID == 0x09 && current.eventID1 == 0x37){
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
