state("KINGDOM HEARTS II FINAL MIX")
{
	bool load : "KINGDOM HEARTS II FINAL MIX.exe", 0x8E9D93;
	byte black: "KINGDOM HEARTS II FINAL MIX.exe", 0xAB8B87;
	bool saveload: "KINGDOM HEARTS II FINAL MIX.exe", 0xBEBCF4;
	bool fightend: "KINGDOM HEARTS II FINAL MIX.exe", 0x7151D4;
	byte titlescreen: "KINGDOM HEARTS II FINAL MIX.exe", 0x711438;
	byte soraHP: "KINGDOM HEARTS II FINAL MIX.exe", 0x2A20C58;
}

startup
{
	vars.booting = false;
}

start
{

}

split
{
	return current.fightend && !old.fightend && current.soraHP > 0;
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
	return current.load || current.saveload || current.black==128;
}