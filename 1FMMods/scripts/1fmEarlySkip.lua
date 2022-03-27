LUAGUI_NAME = "1fmEarlySkip"
LUAGUI_AUTH = "denhonator/TopazTK"
LUAGUI_DESC = "Allows skipping cutscenes without waiting for them."

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
end
