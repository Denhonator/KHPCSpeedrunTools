## Update status
All mods have been updated to work with the following versions:
- Epic Games: 1.0.0.10 (Global + JP)
- Steam: 1.0.0.2 (Global + JP)

## Disclaimer:
At the time of this update mods are not allowed for use with runs submitted to speedrun.com

## How to use:

### LuaBackend or LuaFrontend
- !!! Please follow the instruction [here](../LUA.md) to setup one of the hook programs to actually run mods then continue !!!
- Create or copy the `io_packages` folder (can be found inside scripts here) inside of your recom scripts folder from the previous install step. (Should have something like scripts/recom/io_packages)
- If you created the folder yourself copy the version lua files for your version from the repo into it, ie. `EpicGamesGlobal.lua` for English Epic Games.
- Likewise to the last step copy in the `VersionCheck.lua` file.
- These two files should live inside `io_packages` which should be inside the game folder inside the `scripts` folder.
- Your `io_packages` folder should look something like this: [image](../images/io_packages.png)
- Finally place any scripts you intend to use at the base level of scripts and start the game.
- Your scripts folder should look something like this: [image](../images/game_scripts.png)
- If you wish to add or remove a script while playing simply copy to or delete it from the folder and press `F1` while the game is focused to reload scripts.
- As a note you do not need to have the scripts in more than one place if you are playing across both Epic and Steam

### SoftReset:
- Press all shoulder buttons + start to instantly soft reset
- Equavivalent buttons on keyboard work (shift + C + R + E + 4 default)

### RebirthUnlock
- Install and Reverse Rebirth will be unlocked even without clear data
