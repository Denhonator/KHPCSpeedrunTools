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

function inTimedEvent()
	return ReadInt(minitimer) > 0 and any({6, 11}, ReadByte(world))
end

function inSummoning()
	return ReadInt(summoning) == 1 and summonSpeedup
end

function inScene()
	return (ReadFloat(soraHUD) < 1 and ReadInt(inCutscene) > 0 and ReadInt(inCutscene) ~= 8  and ReadInt(skippable) ~= 1025) and sceneSpeedup
end

function inDIBoatSide()
	return ReadByte(world) == 1 and ReadByte(room) == 2 and (ReadByte(dialog) >= 1 and ReadByte(dialog) <= 5)
end



function _OnFrame()
    if not canExecute then
        return
    end

    local currentWorld = ReadByte(world)

    -- 100 Acre Wood
    if currentWorld == 6 then
        WriteFloat(animSpeed, 1.0)
        return
    end

    -- Normal menus
    local menuOpen =
        ReadByte(menu) ~= 0 or
        ReadByte(menuCheck) ~= 0

    -- Shops and synthesis
    local shopUI =
        (ReadByte(dialog) == 7
            and ReadByte(stateFlag) == 12)
        or
        (ReadByte(dialog) == 0
            and ReadByte(stateFlag) == 14
            and ReadInt(inCutscene) == 2
            and ReadInt(skippable) == 3072)

    -- Olympus Coliseum selection screen
    local olympusMenu =
        currentWorld == 11
        and ReadByte(room) == 1
        and ReadByte(stateFlag) == 12
        and ReadFloat(soraHUD) < 1

    -- Timed event protection
    local timedEvent = inTimedEvent()

    -- Olympus post-battle transition
    local state = ReadByte(stateFlag)

    local olympusVictoryTransition =
        currentWorld == 11
        and ReadByte(room) == 2
        and ReadInt(inCutscene) == 2
        and (state == 1 or state == 2 or state == 3)

    -- Menus and shops always run at normal speed
    if menuOpen or shopUI or olympusMenu then
        WriteFloat(animSpeed, 1.0)
        return
    end

    -- Timed challenges: accelerate post-battle scenes only
    if timedEvent then
        if olympusVictoryTransition then
            WriteFloat(animSpeed, speedMult)
        else
            WriteFloat(animSpeed, 1.0)
        end
        return
    end

    -- Normal scene and summon acceleration
    local speedUp =
        (inScene() or inSummoning())
        and not inDIBoatSide()

    if speedUp then
        WriteFloat(animSpeed, speedMult)
    else
        WriteFloat(animSpeed, 1.0)
    end
end
