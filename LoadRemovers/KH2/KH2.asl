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
	vars.currentSplit = 0;
	vars.fightEnd = false;
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
	settings.Add("seifer2", true, "Seifer 2");
	settings.Add("mansiondusk", true, "Mansion Dusk");
	settings.Add("maildelivery", true, "Mail Delivery");
	settings.Add("3dusksfight1", true, "3 Dusks fight (Heart)");
	settings.Add("twilightthorn", true, "Twilight Thorn");
	settings.Add("hayner", true, "Hayner");
	settings.Add("vivi", true, "Vivi");
	settings.Add("axel1", true, "Axel I");
	settings.Add("setzer", true, "Setzer");
	settings.Add("balls", true, "Balls In The Wall");
	settings.Add("shadowroxas", true, "Shadow Roxas");
	settings.Add("bag", true, "Moving Bag");
	settings.Add("axel2", true, "Axel II");
	settings.Add("station", true, "Station");
	settings.Add("tower", true, "Yen Sid's Tower second floor");
	settings.Add("bailey", true, "Bailey");
	settings.Add("shanyu", true, "Shan-Yu");
	settings.Add("hydra", true, "Hydra");
	settings.Add("darkthorn", true, "Dark Thorn");
	settings.Add("minnieescort", true, "Minnie Escort");
	settings.Add("trpete", true, "Timeless River Pete");
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

}

split
{	
	if(vars.splitTimer <= 0){
		if(current.fightend && !old.fightend && current.soraHP > 0){
				print("fightend!");
				vars.splitTimer = 300;
				vars.fightEnd = true;
			}
		}
		
	else if(!current.fightend){
		vars.splitTimer = vars.splitTimer-1;
	}
	
	else{
		vars.fightEnd = false;
	}
	
	if(vars.fightEnd){
		//Seifer 2
		if(settings["seifer2"] && current.worldID == 0x02 && current.roomID == 0x04 && current.eventID1 == 0x4E){
			vars.fightEnd = false;
			return true;
		}
		//Mansion Dusk
		if(settings["mansiondusk"] && current.worldID == 0x02 && current.roomID == 0x0E && current.eventID1 == 0x80){
			vars.fightEnd = false;
			return true;
		}
		//Mail Delivery
		if(settings["maildelivery"] && current.worldID == 0x02 && current.roomID == 0x06 && current.eventID1 == 0x5B){
			vars.fightEnd = false;
			return true;
		}
		//3 dusks
		if(settings["3dusksfight1"] && current.worldID == 0x02 && current.roomID == 0x20 && current.eventID1 == 0x9A){
			vars.fightEnd = false;
			return true;
		}
		//Twilight Thorn
		else if(settings["twilightthorn"] && current.worldID == 0x02 && current.roomID == 0x22 && current.eventID1 == 0x9D){
			vars.fightEnd = false;
			return true;
		}
		//Hayner
		else if(settings["hayner"] && current.worldID == 0x02 && current.roomID == 0x05 && current.eventID1 == 0x54){
			vars.fightEnd = false;
			return true;
		}
		//Vivi
		else if(settings["vivi"] && current.worldID == 0x02 && current.roomID == 0x05 && current.eventID1 == 0x55){
			vars.fightEnd = false;
			return true;
		}
		//Axel I
		else if(settings["axel1"] && current.worldID == 0x02 && current.roomID == 0x05 && current.eventID1 == 0x57){
			vars.fightEnd = false;
			return true;

		//Axel II
		else if(settings["axel2"] && current.worldID == 0x02 && current.roomID == 0x17 && current.eventID1 == 0x89){
			vars.fightEnd = false;
			return true;
		}
		
		//Station Fight
		else if(settings["station"] && current.worldID == 0x02 && current.roomID == 0x08 && current.eventID1 == 0x6C){
			vars.fightEnd = false;
			return true;
		}
		//Tower 2nd fight
		else if(settings["tower"] && current.worldID == 0x02 && current.roomID == 0x1E && current.eventID1 == 0x99){
			vars.fightEnd = false;
			return true;
		}
		//Bailey
		else if(settings["bailey"] && current.worldID == 0x04 && current.roomID == 0x08 && current.eventID1 == 0x34){
			vars.fightEnd = false;
			return true;
		}
		//Shan-Yu
		else if(settings["shanyu"] && current.worldID == 0x08 && current.roomID == 0x09 && current.eventID1 == 0x4B){
			vars.fightEnd = false;
			return true;
		}
		//Hydra
		else if(settings["hydra"] && current.worldID == 0x06 && current.roomID == 0x12 && current.eventID1 == 0xAB){
			vars.fightEnd = false;
			return true;
		}
		//Heartless steal the pages
		else if(settings["heartlesspages"] && current.worldID == 0x04 && current.roomID == 0x09 && current.eventID1 == 0x48){
			vars.fightEnd = false;
			return true;
		}
		//Dark Thorn
		else if(settings["darkthorn"] && current.worldID == 0x05 && current.roomID == 0x05 && current.eventID1 == 0x4F){
			vars.fightEnd = false;
			return true;
		}
		//Minnie's Escort
		else if(settings["minnieescort"] && current.worldID == 0x0C && current.roomID == 0x00 && current.eventID1 == 0x33){
			vars.fightEnd = false;
			return true;
		}
		//TR Pete
		else if(settings["trpete"] && current.worldID == 0x0D && current.roomID == 0x03 && current.eventID1 == 0x35){
			vars.fightEnd = false;
			return true;
		}
		//Barbossa
		else if(settings["barbossa"] && current.worldID == 0x10 && current.roomID == 0x0A && current.eventID1 == 0x3C){
			vars.fightEnd = false;
			return true;
		}
		//Twin Lords
		else if(settings["twinlords"] && current.worldID == 0x07 && current.roomID == 0x03 && current.eventID1 == 0x3B){
			vars.fightEnd = false;
			return true;
		}
		//Oogie Boogie
		else if(settings["oogieboogie"] && current.worldID == 0x0E && current.roomID == 0x09 && current.eventID1 == 0x37){
			vars.fightEnd = false;
			return true;
		}
		//Grim Reaper II
		else if(settings["grimreaper2"] && current.worldID == 0x10 && current.roomID == 0x01 && current.eventID1 == 0x36){
			vars.fightEnd = false;
			return true;
		}
		//Experiment
		else if(settings["experiment"] && current.worldID == 0x0E && current.roomID == 0x07 && current.eventID1 == 0x40){
			vars.fightEnd = false;
			return true;
		}
		//Genie Jafar
		else if(settings["bag"] && current.worldID == 0x07 && current.roomID == 0x05 && current.eventID1 == 0x3E){
			vars.fightEnd = false;
			return true;
		}
		//Xaldin
		else if(settings["xaldin"] && current.worldID == 0x05 && current.roomID == 0x0F && current.eventID1 == 0x52){
			vars.fightEnd = false;
			return true;
		}
		//Storm Rider
		else if(settings["stormrider"] && current.worldID == 0x08 && current.roomID == 0x08 && current.eventID1 == 0x4F){
			vars.fightEnd = false;
			return true;
		}
		//Roxas
		else if(settings["roxas"] && current.worldID == 0x12 && current.roomID == 0x15 && current.eventID1 == 0x41){
			vars.fightEnd = false;
			return true;
		}
		//Xigbar
		else if(settings["xigbar"] && current.worldID == 0x12 && current.roomID == 0x0A && current.eventID1 == 0x39){
			vars.fightEnd = false;
			return true;
		}
		//Luxord
		else if(settings["luxord"] && current.worldID == 0x12 && current.roomID == 0x0E && current.eventID1 == 0x3A){
			vars.fightEnd = false;
			return true;
		}
		//Saix
		else if(settings["saix"] && current.worldID == 0x12 && current.roomID == 0x0F && current.eventID1 == 0x38){
			vars.fightEnd = false;
			return true;
		}
		//Xenmas I
		else if(settings["xenmas1"] && current.worldID == 0x12 && current.roomID == 0x13 && current.eventID1 == 0x3B){
			vars.fightEnd = false;
			return true;
		}
		//Core
		else if(settings["core"] && current.worldID == 0x12 && current.roomID == 0x19 && current.eventID1 == 0x46){
			vars.fightEnd = false;
			return true;
		}
		//Armor Xenmas 1
		else if(settings["armorxenmas1"] && current.worldID == 0x12 && current.roomID == 0x18 && current.eventID1 == 0x47){
			vars.fightEnd = false;
			return true;
		}
		//Dragon Xenmas
		else if(settings["dragonxenmas"] && current.worldID == 0x12 && current.roomID == 0x16 && current.eventID1 == 0x48){
			vars.fightEnd = false;
			return true;
		}
		//Armor Xenmas II
		else if(settings["armorxenmas2"] && current.worldID == 0x12 && current.roomID == 0x17 && current.eventID1 == 0x49){
			vars.fightEnd = false;
			return true;
		}
		//Final Xenmas
		else if(settings["finalxenmas"] && current.worldID == 0x12 && current.roomID == 0x1C && current.eventID1 == 0x44){
			vars.fightEnd = false;
			return true;
		}
	}
	
	else{
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