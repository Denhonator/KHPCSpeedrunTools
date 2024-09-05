state("KINGDOM HEARTS III", "EGS")
{
	uint IGT : "KINGDOM HEARTS III.exe", 0x092D1DD8, 0xD00, 0x9A60, 0x30, 0x28, 0x320, 0x180, 0x238, 0x50, 0xE30, 0x866C;
	bool load : "KINGDOM HEARTS III.exe", 0x092D1EE0, 0xE30, 0x21C;
	bool saveload : "KINGDOM HEARTS III.exe", 0x09D2E310, 0x2B0, 0x8E8, 0x6120;
	uint transition : "KINGDOM HEARTS III.exe", 0x092D1EE8, 0x600;
	uint kbload : "KINGDOM HEARTS III.exe", 0x09D2E310, 0x120, 0x18, 0x70, 0x90, 0xB8, 0x48;
	uint menuScreen : "KINGDOM HEARTS III.exe", 0x09D2E310, 0x2B0, 0x6B8;
	bool fightend : "KINGDOM HEARTS III.exe", 0x09D62910, 0xA18, 0x700, 0x6D0, 0x178, 0xB0;
	bool fightend2 : "KINGDOM HEARTS III.exe", 0x092D1EE0, 0xE30, 0x268, 0xC0, 0xF8, 0xB0;
	string2 world : "KINGDOM HEARTS III.exe", 0x9302795;
}

state("KINGDOM HEARTS III", "Steam")
{
	uint IGT : "KINGDOM HEARTS III.exe", 0x09DE3B98, 0xD00, 8, 0xE8, 0x500, 0x1E8, 0x440, 0x28, 0x130, 0x118, 0x866C;
	bool load : "KINGDOM HEARTS III.exe", 0x09DE3B98, 0xE30, 0x21C;
	bool saveload : "KINGDOM HEARTS III.exe", 0x09D48E70, 0x2B0, 0x928, 0x6130;
	uint transition : "KINGDOM HEARTS III.exe", 0x09DE3B68, 0x7A0;
	uint kbload : "KINGDOM HEARTS III.exe", 0x09D48E70, 0x120, 0x18, 0x70, 0x90, 0xB8, 0x48;
	uint menuScreen : "KINGDOM HEARTS III.exe", 0x09D48E70, 0x2B0, 0x720;
	bool fightend : "KINGDOM HEARTS III.exe", 0x09D62910, 0xA18, 0x700, 0x6D0, 0x178, 0xB0;
	bool fightend2 : "KINGDOM HEARTS III.exe", 0x09DE3B98, 0xE30, 0x268, 0xC0, 0xF8, 0xB0;
	string2 world : "KINGDOM HEARTS III.exe", 0x87F8825;
}

startup
{
	vars.booting = false;
	vars.lastMenuScreen = 0;
	
	settings.Add("WorldSplit", false, "Split on enter world");
	settings.Add("DataSplit", false, "Split on bosses (like data org)");
	settings.Add("IGT", false, "IGT Mode (don't use)");
}

gameTime 
{
    return settings["IGT"] ? TimeSpan.FromSeconds(current.IGT) : null;
}

split
{
	return (current.world != old.world && settings["WorldSplit"]) ||
		(settings["DataSplit"] && current.fightend2 && !old.fightend2);
}

exit
{
	vars.booting = true;
	timer.IsGameTimePaused = true;
}

init
{
	if (modules.First().ModuleMemorySize == 177639424)
		version = "Steam";
}

update
{
	if(current.saveload){
		vars.booting = false;
		timer.IsGameTimePaused = false;
	}
}

isLoading
{
	if(settings["IGT"]){
		return true;
	}
	if(current.menuScreen!=old.menuScreen){
		vars.lastMenuScreen = old.menuScreen;
	}
	
	//small buffer so timer only pauses if it takes too long after equipping (because of loading)
	vars.menulag = (current.kbload==262145
				&& current.menuScreen==306
				&& vars.lastMenuScreen==307) ? vars.menulag+1 : 0;
	
	return current.load
		|| current.transition > 0
		|| current.saveload
		|| vars.menulag > 7
		|| vars.booting;
	
	//kbload==262145 means the menu is mid-transition and does not take user input
	//menusScreen==306 is the equipment menu in which you get loadings when changing equipment
	//307 is the equipment selection screen
}