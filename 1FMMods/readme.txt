How to use:
- Get LuaBackend https://github.com/Topaz-Reality/LuaBackend/releases/
- Place LuaBackend.exe into this folder and run it while 1FM is running
- Command line program should open, stating that it initialized script successfully.

SaveAnywhere:
- In-game, press L1+L2+R2+Select (or equivalent on your input device)
- You can use this to essentially soft reset by going to title screen
- You can use this to save anywhere. Saving during cutscenes or combat may have unexpected consequences.
- You can access the normal menu through here as well. I have not tested all interactions
- I have prevented opening save menus on top of each other to prevent crashing

InstantGummi:
- Instantly arrive at any selected world
- Warp points are disabled
- Warp drive is disabled (it'd be slower)
- Attempting to travel to Halloween Town or Atlantica will take you to Monstro if it has not yet been visited
- To go to Hollow Bastion 2, select the warp point that takes you there
- There is a possibility that going to Deep Jungle or Neverland for the first time will not initiate the opening cutscenes. In this case, report the issue. You can progress the game by going to treehouse/cabin

Unskippable:
- Allows skipping unskippable cutscenes (Wonderland, HB2)
- Can not skip text boxes or "mini cutscenes" such as drinking enlarge/shrink potions in Wonderland

EarlySkip:
- Allows skipping cutscenes earlier
- May cause glitches

FasterDialog:
- Makes text boxes appear and disappear almost instantly
- Text speed unaffected unless you change textSpeedup to true (line 2)
 - This feature is a little wacky so it's disabled by default

FasterAnims:
- Speeds "mini cutscenes" as well as room transitions
- Also speeds up summon animations. If you don't want that, replace "summonSpeedup = true" with "summonSpeedup = false"
- Default speed multiplier is 2.0, but you can change it to anything you like

Autoattack:
- Holding down attack allows Sora to perform physical attack combos automatically
- This will guarantee very quick combos
- Made for accessibility reasons

RandoNoLogic:
- Randomizes items, level ups, rewards and chests
- Combine with SaveAnywhere to get to world map right away. Everything will be open.
- Has no real objective or logic yet