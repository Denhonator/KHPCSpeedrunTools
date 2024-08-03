## Disclaimer:
Not all of these scripts are allowed in speedruns

## How to use:

### LuaBackend
- Get LuaBackend https://github.com/Sirius902/LuaBackend
- Follow the instructions on those pages on how to set up the scripts
- Create or copy the `io_packages` folder (can be found inside scripts here) inside of your kh1 scripts folder from the previous install step. (Should have something like scripts/kh1/io_packages)
- If you created the folder yourself copy the version lua files for your version from the repo into it, ie. `EpicGamesGlobal.lua` for English Epic Games.
- As a note you do not need to have the scripts in more than one place if you are playing across both Epic and Steam

### LuaFrontend
- Get LuaFrontend https://github.com/TopazTK/LuaFrontend
- Follow the instructions on those pages on how to set up the scripts
- Create or copy the `io_packages` folder (can be found inside scripts here) inside of your LuaFrontend folder from the previous install step. (Should be on the same level as the `LuaFrontend.exe`)
- If you created the folder yourself copy the version lua files for your version from the repo into it, ie. `EpicGamesGlobal.lua` for English Epic Games.

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
- Normally opens with just start, during x opens with start + R2 (or equivalent on your input device)

### QuickHP0:
- Instantly set your HP to 0
- Trigger with L2 + R2 (or equivalent on your input device)

### SaveAnywhere:
- Bring up the save menu anywhere, which allows going to world map
- In-game, press L2+R2+R1+Triangle (or equivalent on your input device)
- Works by replacing Auto Valor command, which may have some limitations
- Saving when you normally wouldn't be able to may or may not work well

### SoftReset:
- In-game, press L1 + L2 + R1 + R2 + Start (or equivalent on your input device)
- Also resets RNG
- Sound effects may get muffled over time. This is a known bug in the game unrelated to this script. Hard reset when that happens.
