## Update status
All mods have been updated to work with the following versions:
- Epic Games: 1.0.0.10 (Global + JP)
- Steam: 1.0.0.2 (Global + JP)

## Disclaimer:
At the time of this update mods are not allowed for use with runs submitted to speedrun.com

## How to use:

### Pre-reqs
- If you have not already, or run into language you are unfamiliar with go read through the [glossary](GLOSSARY.md) for terms that are used throughout. If there is word or short hand use that is still unclear please reach out so it can be added!
- Please follow the instruction [here](../LUA.md) to setup one of the hook programs to actually run mods then continue

### Setup
- For LuaBackend:
    - Open the `game data` folder (found in `Documents` as `KINGDOM HEARTS HD 1.5+2.5 ReMIX`)
    - Open the `scripts` folder
    - Open the `bbs` folder
- For LuaFrontend:
    - Open the folder you extracted to start (named `LuaFrontend.v1.15` by default)
    - Open the `scripts` folder
    - Open the `bbs` folder
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
- For each mod you wish to install do the following:
    - Open the `Install a new mod` window through the green plus, mods drop down, or keyboard shortcut
    - Press the `Select and install Mod Archive or Lua Script` button
    - Browse to one of the following locations to find the mod files to add:
        - Download of repo:
            - Unzip (if you have not yet) the downloaded repo
            - Open the `BBSMods` folder
            - Open the scripts folder
            - Select your mod
        - Installed with OpenKH setup from `LUA.md`:
            - Navigate to your unzipped `openkh` folder
            - Open the `mods` folder
            - Open the folder for whichever game you used in setup
            - Open the `Denhonator` folder (if this folder is not present check other game folders for the last step)
            - Open the `KHPCSpeedrunTools` folder
            - Open the `BBSMods` folder
            - Select your mod
    - Repeat these steps for each mod you wish to include

### SoftReset
- Press all shoulder buttons + start (or equivalent on your input device) to instantly soft reset

### Unlock Character Select
- Install and you can skip the tutorial and just straight to character selection without save data
