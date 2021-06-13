state("KINGDOM HEARTS Melody of Memory")
{
	byte screenState: "GameAssembly.dll", 0x02D8D338, 0xB8, 0x10, 0x18;
	byte screenFade: "GameAssembly.dll", 0x02E7CBF0, 0xAF0, 0x18;
}

init
{
	timer.IsGameTimePaused = false;
	print(modules.First().ModuleMemorySize.ToString());
}

startup
{
	vars.booting = false;
}

exit
{
	vars.booting = true;
	timer.IsGameTimePaused = true;
}

update
{
	if(vars.booting && current.screenState > 1){
		vars.booting = false;
	}
}

isLoading
{
	return current.screenState == 1 || current.screenState == 5 || current.screenFade == 2 || vars.booting;
}