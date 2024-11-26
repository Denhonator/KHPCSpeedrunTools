LUAGUI_NAME = "1fmEarlySkip"
LUAGUI_AUTH = "denhonator/TopazTK (edited by deathofall84)"
LUAGUI_DESC = "Allows skipping cutscenes without waiting for them."

local lastFade = 0

function _OnInit()
    if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
        require("VersionCheck")
        if canExecute then
            WriteInt(skipArray1, 3284180495)
            WriteInt(skipArray2, 3682930804)
        end
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

