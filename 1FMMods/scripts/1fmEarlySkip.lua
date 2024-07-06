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
        if ReadByte(posDebugString) == 0x58 or ReadByte(posDebugString - 0x1020) == 0x58 then
            if ReadByte(posDebugString) == 0x58 then
                ConsolePrint("Epic Games Global version detected")
                offset = 0x0
                offset2 = 0x0
            else
                ConsolePrint("Epic Games JP version detected")
                offset = 0x1C0
                offset2 = 0x1000
            end
            skipArray1 = 0x1783BC - offset
            skipArray2 = 0x17D203 - offset
            cutscene = 0x233F174 - offset2
            white = 0x234079C - offset2
            fadeBase = 0x2340750 - offset2
            skipFlag1 = 0x23408B8 - offset2
            skipFlag2 = 0x2340DA0 - offset2
        else
            posDebugString = 0x3EA318
            if ReadByte(posDebugString) == 0x58 then
                ConsolePrint("Steam Global version detected")
                offset = 0x0
            else
                ConsolePrint("Steam JP version detected")
                offset = 0x280
            end
            skipArray1 = 0x17A49C - offset
            skipArray2 = 0x17F323 - offset
            cutscene = 0x233E808
            white = 0x233FE1C
            fadeBase = 0x233FDD0
            skipFlag1 = 0x233FEE8
            skipFlag2 = 0x23404D0
        end
        WriteInt(skipArray1, 3284180495)
        WriteInt(skipArray2, 3682930804)
    else
        ConsolePrint("KH1 not detected, not running script")
    end
end

function _OnFrame()
    if canExecute and ReadInt(cutscene) == 1 then
        curFade = math.min(ReadInt(fadeBase) + 20, 128)
        if curFade - 30 > 0 and lastFade < curFade then
            WriteInt(white, 0) --white screen off
            for i=0,3 do
                WriteInt(fadeBase + (i * 4), curFade) --canskip
            end
            WriteInt(skipFlag1, 0) --canskip
            WriteInt(skipFlag2, 0) --canskip
            WriteInt(skipFlag2 + 4, 0) --canskip
        end
        lastFade = curFade
    end
end
