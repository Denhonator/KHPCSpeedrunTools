state("KINGDOM HEARTS FINAL MIX")
{
	bool blackInv : "KINGDOM HEARTS FINAL MIX.exe", 0x4D93B8;
	byte white : "KINGDOM HEARTS FINAL MIX.exe", 0x233C49C;
	bool paused : "KINGDOM HEARTS FINAL MIX.exe", 0x232A63C;
	bool cutscene : "KINGDOM HEARTS FINAL MIX.exe", 0x233AE74;
	bool load : "KINGDOM HEARTS FINAL MIX.exe", 0x232A368;
	bool load2: "KINGDOM HEARTS FINAL MIX.exe", 0x233AEB0;
	bool saveload : "KINGDOM HEARTS FINAL MIX.exe", 0x2E1CBB8;
	//bool saveloadInv : "KINGDOM HEARTS FINAL MIX.exe", 0x2E97740;
	bool summonload : "KINGDOM HEARTS FINAL MIX.exe", 0x2D50988;
	bool partyload : "KINGDOM HEARTS FINAL MIX.exe", 0x2E1BAFC;
	byte titlescreen : "KINGDOM HEARTS FINAL MIX.exe", 0x7FE990;
	byte hp : "KINGDOM HEARTS FINAL MIX.exe", 0x2D592CC;
	
	byte fightend : "KINGDOM HEARTS FINAL MIX.exe", 0x2D500B8;
	ushort room : "KINGDOM HEARTS FINAL MIX.exe", 0x2534638;
}

startup
{
	vars.booting = false;
	vars.summontimer = 0;
	vars.opposite = 0;
	vars.clayton = 0;
	vars.leon = 0;
	
	settings.Add("opposite", true, "Remove pre Opposite Armor split");
	settings.Add("clayton", true, "Remove pre Clayton split");
	settings.Add("finalrest", true, "Split on final rest enter");
	settings.Add("leon", true, "Split on Leon kill/death");
}

start
{
	return (current.hp > 0 && old.hp == 0) || (current.titlescreen != 1 && old.titlescreen == 1);
}

split
{
	if(current.fightend == 2 && old.fightend == 0){
		if(settings["opposite"] && current.room == 416 && vars.opposite == 0){
			vars.opposite = 1;
		}
		else if(settings["clayton"] && current.room == 10400 && vars.clayton == 0){
			vars.clayton = 1;
		}
		else if(current.room != 26016){
			vars.opposite = 0;
			vars.clayton = 0;
			return true;
		}
	}
	if(settings["leon"] && current.room == 26016 && vars.leon == 0
			&& ((current.hp == 0 && old.hp>0) || (current.white > 0 && old.white == 0))){
		vars.leon = 1;
		return true;
	}
	if(settings["finalrest"] && current.room == 56608 && old.room == 0){
		return true;
	}
	return false;
}

exit
{
	vars.booting = true;
	timer.IsGameTimePaused = true;
}

init
{
	timer.IsGameTimePaused = false;
	vars.leon = 0;
}

update
{
	if(vars.booting && current.titlescreen == 1){
		vars.booting = false;
	}
}

isLoading
{
	vars.summontimer = current.summonload ? vars.summontimer + (current.paused ? 0 : 1) : 0;
	
	return ((current.load 
	|| !current.blackInv
	|| (current.white == 128 && !current.cutscene)
	|| vars.summontimer > 30) && !current.paused)
	|| current.saveload
	|| current.partyload
	|| (current.load2 && current.hp == 0) 
	|| vars.booting;
}