LUAGUI_NAME = "1fmFasterAnims"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Speeds up animations during which you can't play"

local sceneSpeedup = true
local summonSpeedup = true
local speedMult = 2.0

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		require("VersionCheck")
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function any(array, value)
	for _, val in pairs(array) do
		if val == value then return true end
	end
	return false
end

function _OnFrame()
    if not canExecute then
        return
    end

    local currentWorld = ReadByte(world)
    local currentRoom = ReadByte(room)
    local dialogState = ReadByte(dialog)

    -- Destiny Island dialog safety
    local DIBoatSide =
    	currentWorld == 1 and
    	currentRoom == 2 and
    	(dialogState >= 1
    		and dialogState <= 5)

    -- 100 Acre Wood
    if currentWorld == 6  or DIBoatSide then
        WriteFloat(animSpeed, 1.0)
        return
    end

    local state = ReadByte(stateFlag)
    local cutscene = ReadInt(inCutscene)
    local canSkip = ReadInt(skippable)
    local HUD = ReadFloat(soraHUD)

    -- Normal menus
    local menuOpen =
        ReadByte(menu) ~= 0 or
        ReadByte(menuCheck) ~= 0

    -- Shops and synthesis
    local shopUI =
        (dialogState == 7
            and state == 12)
        or
        (dialogState == 0
            and state == 14
            and cutscene == 2
            and canSkip == 3072)

    -- Olympus Coliseum selection screen
    local olympusMenu =
        currentWorld == 11
        and currentRoom == 1
        and state == 12
        and HUD < 1

    -- Menus and shops always run at normal speed
    if menuOpen or shopUI or olympusMenu then
        WriteFloat(animSpeed, 1.0)
        return
    end

    -- Olympus post-battle transition
    local olympusVictoryTransition =
        currentWorld == 11
        and currentRoom == 2
        and cutscene == 2
        and (state == 1 or state == 2 or state == 3)
        and ReadInt(minitimer) > 0

    local inScene =
    	HUD < 1 and
    	cutscene > 0 and
    	cutscene ~= 8  and
    	canSkip ~= 1025 and
    	sceneSpeedup

    local inSummoning =
    	ReadInt(summoning) == 1 and
    	summonSpeedup

    if inScene or inSummoning or olympusVictoryTransition then
        WriteFloat(animSpeed, speedMult)
    else
        WriteFloat(animSpeed, 1.0)
    end
end
