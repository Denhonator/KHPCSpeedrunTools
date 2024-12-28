## Update status
All mods have been updated to work with the following versions:
- Epic Games: 1.0.0.9 (Global + JP)
- Epic Games: 1.0.0.10 (Global + JP)
- Steam: 1.0.0.1 (Global + JP)
- Steam: 1.0.0.2 (Global + JP)

## Disclaimer:
Not all of these scripts are allowed in speedruns

## How to use:

### LuaBackend or LuaFrontend
- !!! Please follow the instruction [here](../LUA.md) to setup one of the hook programs to actually run mods then continue !!!
- Create or copy the `io_packages` folder (can be found inside scripts here) inside of your kh2 scripts folder from the previous install step. (Should have something like scripts/kh2/io_packages)
- If you created the folder yourself copy the version lua files for your version from the repo into it, ie. `EGSGlobal_1_0_0_10.lua` for Current English Epic Games.
- Likewise to the last step copy in the `VersionCheck.lua` file.
- These two files should live inside `io_packages` which should be inside the game folder inside the `scripts` folder.
- Your `io_packages` folder should look something like this: [image](../images/versioned_io_packages.png)
- Finally place any scripts you intend to use at the base level of scripts and start the game.
- Your scripts folder should look something like this: [image](../images/game_scripts.png)
- If you wish to add or remove a script while playing simply copy to or delete it from the folder and press `F1` while the game is focused to reload scripts.
- As a note you do not need to have the scripts in more than one place if you are playing across both Epic and Steam

### AutoAttack:
- Allows physically attacking continuously by holding attack button in combat.

### Autosave:
- Automatically saves the latest continue state to a local file
- Load the autosave by holding select (touch pad on EGS, left side of touch pad or options for Steam) when loading any save (or equivalent on your input device)
- Alternatively load secondary auto save with L2 + R2 (or equivalent on your input device)

### CreditSkip:
- Allows scene skipping of credits
- Skip the credits like you would a cutscene

### GummiSkip:
- As worlds get unlocked, you can enter them without having to do gummi missions

### LaserDomeSkip:
- Autmatically skip laser dome RC segment of final Xemnas fight

### LoadSaveMenu:
- Allows the in game opening of the save/load menu where possible
- Normally opens with just start, during x opens with Start + R2 (or equivalent on your input device)

### QuickHP0:
- Instantly set your HP to 0
- Trigger with L2 + R2 (or equivalent on your input device)

### SaveAnywhere:
- Bring up the save menu anywhere, which allows going to world map
- In-game, press L2 + R2 + R1 (or equivalent on your input device) to prompt and follow with Triangle (or equivalent on your input device) to open
- Works by replacing Auto Valor command, which may have some limitations
- Saving when you normally wouldn't be able to may or may not work well

### SoftReset:
- In-game, press L1 + L2 + R1 + R2 + Start (or equivalent on your input device)
- Also resets RNG
- Sound effects may get muffled over time. This is a known bug in the game unrelated to this script. Hard reset when that happens.
