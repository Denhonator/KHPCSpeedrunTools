state("KINGDOM HEARTS Melody of Memory")
{
	bool loading: "GameAssembly.dll", 0x02D99138, 0xB8, 0, 0x98, 0x10, 0x48, 8;
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
	if(vars.booting && current.screenFade > 1){
		vars.booting = false;
	}
}

isLoading
{
	return current.loading || current.screenFade == 2 || vars.booting;
}