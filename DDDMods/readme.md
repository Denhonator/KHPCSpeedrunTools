## Update status
All mods have been updated to work with the following versions:
- Epic Games: 1.0.0.10 (Global)
- Steam: 1.0.0.2 (Global + JP)

## Disclaimer:
At the time of this update mods are not allowed for use with runs submitted to speedrun.com

## How to use:

### Setup
- For LuaBackend:
    - Open the `game data` folder (found in `Documents` as `KINGDOM HEARTS HD 2.8 Final Chapter Prologue`)
    - Open the `scripts` folder
    - Open the `kh3d` folder
- For LuaFrontend:
    - Open the folder you extracted to start (named `LuaFrontend.v1.15` by default)
    - Open the `scripts` folder
    - Open the `ddd` folder
- For OpenKH Mod Manager:
    - Skip down to [here](#omm_skip)
- Copy in any desired mod files (either from the full download or from [here](scripts))
- Create the `io_packages` folder (or copy it if you downloaded the repo as a zip)
- (optional) If you copied the folder you can delete all version files aside from the one you intend to use
- Your scripts folder should look something like this:  
![image](../images/game_scripts.png)
- If you created the folder yourself we need to copy two files from into it, open your new `io_packages` folder and:
    - Copy the version lua file for your version from the repo into it from the list below:
        - [EpicGamesGlobal.lua](scripts/io_packages/EpicGamesGlobal.lua) (Current English Epic Games)
        - [EpicGamesJP.lua](scripts/io_packages/EpicGamesJP.lua) (Current Japanese Epic Games)
        - [SteamGlobal.lua](scripts/io_packages/SteamGlobal.lua) (Current English Steam)
        - [SteamJP.lua](scripts/io_packages/SteamJP.lua) (Current Japanese Steam)
    - Copy the [VersionCheck.lua](scripts/io_packages/VersionCheck.lua) file
- Your `io_packages` folder should look something like this:  
![image](../images/versioned_io_packages.png)

* If you wish to add or remove a script while playing simply copy to or delete it from the folder and press `F1` while the game is focused to reload scripts
* As a note you do not need to have the scripts in more than one place if you are playing across both Epic and Steam

### <a name="omm_skip"></a> Setup - Open KH Mod Manager
- Open the `Collection Settings` menu via the button on the right side:
![image](images/collection_settings.png)
- Select any and all mods in this pop up you wish to run with
- Close the pop up
- In the `Patching` menu select one of the `Build` options

### SoftReset
- Press all shoulder buttons + start to instantly soft reset
- Equavivalent buttons on keyboard work (shift + C + R + E + 4 default)

### Unlock Critical Mode
- Install and the Critical difficulty mode will be available even without game clear save data
