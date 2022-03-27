LUAGUI_NAME = "1fmEarlySkip"
LUAGUI_AUTH = "denhonator/TopazTK"
LUAGUI_DESC = "Allows skipping cutscenes without waiting for them."

local lastInput = 0
local lastFade = 0
local canExecute = false

function _OnInit()
    if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
        canExecute = true
        ConsolePrint("KH1 detected, running script")

        if ReadInt(-0x22A5AA) == 0xC3C0940F then
            WriteArray(-0x22A5AA, { 0x0F, 0x9E, 0xC0, 0xC3 })
            WriteArray(-0x225763, { 0x7E, 0x10, 0x85, 0xDB })
        elseif ReadInt(-0x22A75A) == 0xC3C0940F then
            WriteArray(-0x22A75A, { 0x0F, 0x9E, 0xC0, 0xC3 })
            WriteArray(-0x225913, { 0x7E, 0x10, 0x85, 0xDB })
        end
    else
        ConsolePrint("KH1 not detected, not running script")
    end
end

function _OnFrame()
    if ReadInt(-0x22A5AA) ~= 0xC3C09E0F and ReadInt(-0x22A75A) ~= 0xC3C09E0F then
        nowInput = ReadInt(0x233D034-0x3A0606)
        if canExecute and ReadInt(0x233AE74-0x3A0606)==1 then
            local curFade = math.min(ReadInt(0x233C450-0x3A0606)+20, 128)
            if curFade-30 > 0 and lastFade < curFade then
                WriteInt(0x233C49C-0x3A0606, 0) --white screen off
                WriteInt(0x233C450-0x3A0606, curFade) --canskip
                WriteInt(0x233C454-0x3A0606, curFade) --canskip
                WriteInt(0x233C458-0x3A0606, curFade) --canskip
                WriteInt(0x233C45C-0x3A0606, curFade) --canskip
                WriteInt(0x233C5B8-0x3A0606, 0) --canskip
                WriteInt(0x233CAA0-0x3A0606, 0) --canskip
                WriteInt(0x233CAA4-0x3A0606, 0) --canskip
            end
            lastFade = curFade
        end
        lastInput = nowInput
    end 
end
