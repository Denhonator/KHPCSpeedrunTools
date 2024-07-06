LUAGUI_NAME = "1fmEarlySkip"
LUAGUI_AUTH = "denhonator/TopazTK (edited by deathofall84)"
LUAGUI_DESC = "Allows skipping cutscenes without waiting for them."

local lastFade = 0
local canExecute = false
local posDebugString = 0x3EB158

function _OnInit()
    if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
        canExecute = true
        ConsolePrint("KH1 detected, running script")
        if ReadByte(posDebugString) == 0x58 then
            vars = require("EpicGamesGlobal")
        elseif ReadByte(posDebugString - 0x1020) == 0x58 then
            vars = require("EpicGamesJP")
        else
            vars = require("SteamGlobal") -- Global and JP equal
            if ReadByte(posDebugString - 0xE40) ~= 0x58 then
                vars.skipArray1 = vars.skipArray1 - 0x280
                vars.skipArray2 = vars.skipArray2 - 0x280
            end
        end
        WriteInt(vars.skipArray1, 3284180495)
        WriteInt(vars.skipArray2, 3682930804)
    else
        ConsolePrint("KH1 not detected, not running script")
    end
end

function _OnFrame()
    if canExecute and ReadInt(vars.cutscene) == 1 then
        curFade = math.min(ReadInt(vars.fadeBase) + 20, 128)
        if curFade - 30 > 0 and lastFade < curFade then
            WriteInt(vars.white, 0) --white screen off
            for i=0,3 do
                WriteInt(vars.fadeBase + (i * 4), curFade) --canskip
            end
            WriteInt(vars.skipFlag1, 0) --canskip
            WriteInt(vars.skipFlag2, 0) --canskip
            WriteInt(vars.skipFlag2 + 4, 0) --canskip
        end
        lastFade = curFade
    end
end
