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
	byte titlescreen : "KINGDOM HEARTS FINAL MIX.exe", 0x7FE990;
	byte hp : "KINGDOM HEARTS FINAL MIX.exe", 0x2D592CC;
	
	byte fightend : "KINGDOM HEARTS FINAL MIX.exe", 0x2D500B8;
}

startup
{
	vars.booting = false;
	vars.summontimer = 0;
}

start
{
	return (current.hp > 0 && old.hp == 0) || (current.titlescreen != 1 && old.titlescreen == 1);
}

split
{
	return current.fightend == 2 && old.fightend == 0;
}

exit
{
	vars.booting = true;
	timer.IsGameTimePaused = true;
}

init
{
	timer.IsGameTimePaused = false;
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
	|| (current.load2 && current.hp == 0) 
	|| vars.booting;
}