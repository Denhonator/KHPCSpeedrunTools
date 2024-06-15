# LuaBackend

How to use:

Download the specific .toml for the game pack you are interested in from here and place it into the instillation directory alongside the .exe files ie. where you would find things like KINGDOM HEARTS Birth by Sleep FINAL MIX.exe

From https://github.com/Sirius902/LuaBackend/releases download the most recent DBGHELP.zip file and extract the lua54.dll (number may change) and DBGHELP.dll into the same directory as the .toml file

## Updating

There is one essential and one optional value which will need to be changed when updates to the game are released and if the files here have not been updated to work with them this will guide you through finding said information.

The two pieces of information the .toml file needs to ensure a working state are `base` and `thread_struct` being the base address offset for the individual games executable and the address offset for the games thread structure. To find these two pieces of inormation we will be using Cheat Engine if you need to download it go here: https://www.cheatengine.org/downloads.php

### base

This is piece of information is the optional one as it can be set to 0x0 as long as the scripts you are using are updated to match or don't use and offset to begin with. If the script maintainers are using an offset it will most likely be found through the following method.

With the game you are looking for open, open Cheat Engine and attach to the game process. Once you are attached click the Memory View button and a new window will pop up with a highlighted address. This address has the needed offset we are looking for, to ensure you are looking at the correct value the line will have a comment section containing (at least on windows machines) -> MSCOREE.CorExeMain

#### Disclaimer

Check the scripts you intend to use, if they have the offset value associated with them leave it be, if there is no offset in the script set the base in the .toml file to 0x0.

### thread_struct

This is the essential and slightly trickier value to find with the game you are looking for open, open Cheat Engine and attach to the game process. Once attached you will need to do a memory scan, you will be looking for a byte array value type with the following values as Hex (make sure to select the games exe in memory scan options):

```
44 00 49 00 53 00 50 00 4C 00 41 00 59 00
```

This leads to a serachable address that is a close neighbor to the structure. Take this address offset and add `0x58` or `88` (hex value 58 is the same as integer value 88) to it to get the desired value. As an example with version 10.0.0.9 of the Epic Game Re: Chain of Memories open we find address offset `BFAB28` and add `0x58` to get to our desired offset of `0xBFAB80`, for mental math purposes hex values range as follows per digit (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, A, B, C, D, E, F).
