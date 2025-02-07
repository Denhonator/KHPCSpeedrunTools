# Setting up
If you have not, follow the steps [here](LUA.md) first! Otherwise there are three pieces to this. First a warning, when using the OpenKH Mod Managers `build` or `build and run` operations will reset the `settings.lua` file as it will be rebuilt from the base as well as nuke the `Rando` folder we are going to setup in the next step which is NOT part of the base.

## Jump to
- [LuaBackend or LuaFrontend](#lblf)
- [OpenKH Mod Manager](#omm)
- [Rando Files](#rfiles)

## <a name="lblf"></a>LuaBackend or Lua Frontend - Rando Folder Setup

This is the same for either method with a minor change in folder location. All we need to do is copy the `Rando` folder from the repositories `io_packages` folder in.

### LuaBackend

- The folder location will be inside the `kh1` scripts folder we setup before, this should be located at:
	- For Epic Games:
		- `Documents/KINGDOM HEARTS HD 1.5+2.5 ReMIX/scripts/kh1/io_packages`
	- For Steam:
		- `Documents/My Games/KINGDOM HEARTS HD 1.5+2.5 ReMIX/scripts/kh1/io_packages`
- Copy the `Rando` folder (from this repository, in the 1FMMods io_packages) and it's contents to this location, it should end up looking like this:
	- For Epic Games:
		![image](images/backend_epic_io_packages.png)
	- For Steam:
		![image](images/backend_steam_io_packages.png)

### LuaFrontend

- The folder location will be inside the `kh1` scripts folder we setup before, this should be located at:
	- `<unzipped folder location>/LuaFrontend.v1.15/scripts/kh1/io_packages`
- Copy the `Rando` folder (from this repository, in the 1FMMods io_packages) and it's contents to this location, it should end up looking like this:

![image](images/frontend_io_packages.png)

## <a name="omm"></a>OpenKH - Rando Folder Setup

To ensure everything is running correctly copy the `Rando` folder either from a download of this repository (found in `1FMMods/scripts/io_packages`) OR from the installed location of this repository inside OpenKH (inside the `<openkh path>/mods/<specifc game usualy kh1>/Denhonator/KHPCSpeedrunTools/1FMMods/scripts/io_packages` folder) and place it inside the already built `<openkh path>/mod/kh1/scripts/io_packages` folder. It should end up looking like the following images:

![image](images/openkh_scripts.png)

![image](images/openkh_io_packages.png)

![image](images/openkh_rando.png)

## <a name="rfiles"></a>Rando Files

The last part to ensure proper running is to create and optionally populate the `randofiles` folder. This will be going in the previously discussed `install folder` if you closed that window from the previous steps here is how to get there again:

- Locate your game install folder:
	- For Epic Games:
		- Open the Epic Games Launcher
		- Go to `Library`
		- Right click the game
		- Click `Manage`
		- Click the magnifying glass on the `Installation` line
	- For Steam:
		- Open Steam
		- Select the game from your `Library`
		- Click the gear icon and select `Properties`
		- Select the `Installed Files` tab
		- Click the `Browse...` button

For Epic Games it should end up looking like this:

![image](images/epic_install.png)

For Steam that would look like this:

![image](images/steam_install.png)

Now if you are playing on english all that is left is to create a new folder here and call it `randofiles`. This will be where all generated files are stored.

Optional: If you are playing on French, German, or Spanish there is some support for the translated names of things. Copy the language specific `.txt` file from the repository `randofiles` folder found [here](1FMMods/randofiles) into the newly created folder.
