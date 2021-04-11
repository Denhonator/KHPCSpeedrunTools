state("KINGDOM HEARTS III")
{
	uint IGT : "KINGDOM HEARTS III.exe", 0x092D1DD8, 0xD00, 0x9A60, 0x30, 0x28, 0x320, 0x180, 0x238, 0x50, 0xE30, 0x866C;
	bool load : "KINGDOM HEARTS III.exe", 0x092D1EE0, 0xE30, 0x21C;
	bool saveload : "KINGDOM HEARTS III.exe", 0x09D2E310, 0x2B0, 0x8E8, 0x6120;
	uint transition : "KINGDOM HEARTS III.exe", 0x092D1EE8, 0x600;
	uint kbload : "KINGDOM HEARTS III.exe", 0x09D2E310, 0x120, 0x18, 0x70, 0x90, 0xB8, 0x48;
	uint menuScreen : "KINGDOM HEARTS III.exe", 0x09D2E310, 0x2B0, 0x6B8;
	byte linkAttraction : "KINGDOM HEARTS III.exe", 0x0A704830, 0x178, 0x8, 0x130, 0x88, 0x634;
	bool linkAttractionLoaded : "KINGDOM HEARTS III.exe", 0x0A70D140, 0x50, 0x270, 0x4C;
	bool paused : "KINGDOM HEARTS III.exe", 0x0916A740, 0x110, 0x64;
	bool menuing2 : "KINGDOM HEARTS III.exe", 0x09D2E310, 0x2B0, 0x6B4;
	bool fightend : "KINGDOM HEARTS III.exe", 0x09D62910, 0xA18, 0x700, 0x6D0, 0x178, 0xB0;
	string2 world : "KINGDOM HEARTS III.exe", 0x9302795;
}

startup
{
	vars.booting = false;
	vars.lastMenuScreen = 0;
	
	settings.Add("WorldSplit", false, "Split on enter world");
	settings.Add("FightSplit", false, "Split on fight end");
	settings.Add("IGT", false, "IGT Mode (don't use)");
}

gameTime 
{
    return settings["IGT"] ? TimeSpan.FromSeconds(current.IGT) : null;
}

split
{
	return (settings["FightSplit"] && current.fightend && !old.fightend) ||
		(current.world != old.world && settings["WorldSplit"]);
}

exit
{
	vars.booting = true;
	timer.IsGameTimePaused = true;
}

init
{

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
				
	vars.summonlag = current.linkAttraction == 1 ? vars.summonlag + (current.paused ? 0 : 1) : 0;
	if(old.linkAttractionLoaded && !current.linkAttractionLoaded){
		vars.summonlag = -30;
	}
	
	return current.load
		|| (vars.summonlag > 40 && !current.paused && !current.linkAttractionLoaded)
		|| current.transition > 0
		|| current.saveload
		|| vars.menulag > 7
		|| vars.booting;
	
	//kbload==262145 means the menu is mid-transition and does not take user input
	//menusScreen==306 is the equipment menu in which you get loadings when changing equipment
	//307 is the equipment selection screen
	//linkAttraction == 6 means game is loading in a link
}