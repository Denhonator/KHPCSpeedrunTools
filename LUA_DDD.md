# Setting up
So you are having issues getting things working for one of the Lua tools. Fear not this document will get you squared away! Follow ONE of the bellow setups for a Lua tool, then carry on into game specific mods!

## Jump to
- [LuaBackend](#lb)
- [LuaFrontend](#lf)
- [OpenKH Mod Manager](#omm)
- [Game Specific Mods](#mods)

## <a name="lb"></a>LuaBackend

### Install
The first thing you want to do is ensure that you have the three files from the zip download (`DBGHELP.zip`) from https://github.com/Sirius902/LuaBackend/releases (`lua54.dll`, `DBGHELP.dll`(alternatively renamed to `DINPUT8.dll` for Steamdeck), `LuaBackend.toml`) in the game install folder.

For Epic Games that would look like this:

[image](images/epic_install.png)

To get there open the Epic Games Launcher, go to your `Library`, right click the game and click on `Manage`, on the `Instillation` line click on the folder with a magnifying glass.

For Steam that would look like this:

[image](images/steam_install.png)

To get there open Steam, go to the `Properties` for the game, go to the `Installed Files` tab of this menu, and click the `Browse...` button.

### Config
Once this step is complete you want to ensure that you have the correct `game_docs` line inside the .toml file! This points to the folder that the game uses to save data.

For Epic Games that path will look like this:
`KINGDOM HEARTS HD 1.5+2.5 ReMIX`

Since the save location looks like this, with your user name swapped and maybe a different drive:

[image](images/epic_docs.png)

For Steam that path will look like this:
`My Games/KINGDOM HEARTS HD 1.5+2.5 ReMIX`

Since the save location looks like this, with your user name swapped and maybe a different drive:

[image](images/steam_docs.png)

Note after this you should have ONE `game_docs` line per game that does not start with a `#` in the .toml file matching what is described above, any additional `game_docs` lines can stay as long as they start with `#` and a space.

For Epic Games this looks like:

[image](images/epic_toml.png)

For Steam this looks like:

[image](images/steam_toml.png)

(The above is the setup for all applicable games aside from Dream Drop Distance, for that all of the same steps apply except where `KINGDOM HEARTS HD 1.5+2.5 ReMIX` is used is swapped with `KINGDOM HEARTS HD 2.8 Final Chapter Prologue` and `KH_1.5_2.5` is swapped for `KH_2.8`.)

### Scripts
From here you want to make sure you have the `scripts` folder as seen in the last screenshots. Now inside that folder we will be creating a folder per game you are trying to add mods for!

For Kingdom Hearts 1, 2, Re: Chain of Memories, and Birth by Sleep that looks like this:

[image](images/scripts_folder.png)

(In the case of Dream Drop Distance you will want a folder named `kh3d` instead of any of the above names. This will land in the 2.8 packs save folder as is called out above.)

And inside these is where you will place the mods found in this repo! To perform a test copy one of the `test_game.lua` (where game is replaced by a game abbreviation) files from the `test_lua` folder of the repo into the game specific folder. Once you have, open that game and press `F2`. You will know you are good to go if you get a window that looks like this:

[image](images/backend_terminal.png)

Now you can remove the test file and move on to the other mods in this repository! Follow the steps in the game specific readmes for further instructions and happy gaming!

## <a name="lf"></a>LuaFrontend

### Install

Grab the most recent release .rar file from here https://github.com/TopazTK/LuaFrontend/releases and extract it where ever you like. 

### Config

In the extracted folder there is a `config` folder inside this there is a `gameConfig.toml` we need to change a few things here. First, every line that says `Offset` or `Address` replace the elements inside the quotation marks with a 0. Next for each game if there the `Path` value ends in `gl` remove the `gl` from the end.

You should end up with a file that looks like this:

[image](images/luafrontend_config.png)


### Scripts

Next in the extracted folder there is a `scripts` folder with a number of folders inside, rename or replace these so that you end up with something that looks like this:

[image](images/luafrontend_folders.png)

And inside these is where you will place the mods found in this repo! To perform a test copy one of the `test_game.lua` (where game is replaced by a game abbreviation) files from the `test_lua` folder of the repo into the game specific folder. Once you have, open that game and run the `LuaFrontend.exe` from the extracted folder. Inside the new window click the `Engine` option at the top and select `Show Console...`, followed by again in the `Engine` option selecting `Start Engine`. You should end up with a window that looks like this:

[image](images/luafrontend_test.png)

Now you can remove the test file and move on to the other mods in this repository! Follow the steps in the game specific readmes for further instructions and happy gaming!

## <a name="omm"></a>Open KH Mod Manager

### Install
Grab the most recent release .zip file from here https://github.com/OpenKH/OpenKh/releases and extract it where ever you like.

Once you have it unzipped, find the `OpenKh.Tools.ModsManager.exe` and start it up, if it is the first time it will run through their wizard. If you change platforms or languages at a later point go through the wizard again to change the configurations. 

In the wizard:
- Choose `PC Release`, your language, and your platform and click `Detect Instillations` then click `Next`.
- If you intend to use any non `.lua` mods (things from other creators like visual mods), select the game collection at the top and go ahead and add Panacea on this page otherwise just click `Next`.
- Make sure to select the proper game collection on this page, tick the boxes for any games you plan to have mods for, and click `Install and Configure Lua Backend`. Follow up with hitting `Next` again.
- Once again if you plan to have any non `.lua` mods you will need to follow the steps on this stage to extract the game assets for moddification. This page is only for people using things not included in this repo. Tick the `Skip Game Extraction` box and click `Next` in all basic `.lua` use cases.
- On the last page click `Finish`!

* As a note the mod manager may crash out at this stage if being configured for Epic Games this is fine, just boot it again.

### Config
Up to this point you have now setup all of the required pieces to install the mods, now we just need to dump the files into the right place. You have two options from here. Copy paste OR the built in add features.

#### Copy paste
For this option ensure that there is a `mod` folder inside your `openkh` folder and inside said `mod` folder you will want to have a folder for each game you intend to play matching to these names:

- `kh1`
- `kh2`
- `bbs`
- `Recom`
- `kh3d`

Inside the above folder you will want a `scripts` folder and this will be where you place any `.lua` files! Copy and paste in the `io_packages` folder from the game specific folder here and any `.lua` mods you want! You should end up looking something like this:

[image](images/omm_scripts_folder.png)

#### Built in Add
This is only Partially supported by this repo natively as we don't want it to install ALL mods across all games by force, so there are three parts:

- Required Files
- Mods
- Build

The required files portion only needs to be done once to work across all games, but make sure to keep it up to date if you switch between games.

##### Required Files

!!!!! ONLY DO THIS STEP ONCE !!!!!

We will first grab the required files through a repo add. Open the mod install window with the green plus, from the mods drop down, or the appropriate keyboard shortcut. In the new window put in the repo info (Denhonator/KHPCSpeedrunTools) like so:

[image](images/repo_install.png)

Feel free to set this to auto update, to make sure your mods stay working at all times! This part will install the Version checking lua files as well as the variable files that go with each version across all of the games!

##### Mods

For this part we will be adding the desired mods. Once again get into the mod install window mentioned above (green plus, drop down, or shortcut). This time select the `Select and install Mod Archive or Lua Script` button. You should now have a folder from the required files section that contains the full repository, something like `C:\Users\chuds\Downloads\openkh\mods\kh1\Denhonator\KHPCSpeedrunTools`. This has all of the mods for all of the games, select the game you want then navigate to `scripts` folder to find a full list of the available mods (`.lua` files). Select any file from this list and click open.

##### Build

!!!!! DO THIS EVERY TIME YOU ADD or REMOVE A MOD !!!!!

As the last step to the built in route you need to make sure it cross populates the installed mods the the correct run location. Doing so is very simple but very important!

If you are on Steam you can make use of the run related features to start your game, this seems bugged for Epic Games however. In either case you only NEED to click the `Build Only` option in the `Mod Loader` drop down.

## <a name="mods"></a>Game Specific Mods

Follow these links to get to the mods for the given game as well as further documentation on how to use them:

- [Kingdom Hearts 0.2](02Mods)
- [Kingdom Hearts 1](1FMMods)
- [Kingdom Hearts 2](2FMMods)
- [Kingdom Hearts Birth by Sleep](BBSMods)
- [Kingdom Hearts Dream Drop Distance](DDDMods)
- [Kingdom Hearts Re: Chain of Memories](ReCoMMods)
