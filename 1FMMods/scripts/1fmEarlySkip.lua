LUAGUI_NAME = "1fmEarlySkip"
LUAGUI_AUTH = "denhonator/TopazTK (edited by deathofall84)"
LUAGUI_DESC = "Allows skipping cutscenes without waiting for them."

local lastFade = 0
local canExecute = false

local function importVars(file)
    if not pcall(require, file) then
        local errorString = "\n\n!!!!!!!! IMPORT ERROR !!!!!!!!\n\n"
        local msg = ""
        local slashIdx = string.find(file, "/")
        if slashIdx then
            msg = string.format("%s.lua missing, get it from the Github!", string.sub(file, slashIdx + 1, #file))
        else
            msg = string.format("%s.lua missing, get it from the Github!", file)
        end
        ConsolePrint(string.format("%s%s%s", errorString, msg, errorString))
    end
end

function _OnInit()
    if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
        canExecute = true
        ConsolePrint("KH1 detected, running script")
        importVars("VersionCheck")
        if ReadByte(EGSGlobalVersion) == 106 then
            importVars("EpicGamesGlobal")
        elseif ReadByte(EGSJPVersion) == 106 then
            importVars("EpicGamesJP")
        elseif ReadByte(SteamGlobalVersion) == 106 then
            importVars("SteamGlobal")
        elseif ReadByte(SteamJPVersion) == 106 then
            importVars("SteamJP")
        else
            ConsolePrint("\n\n!!!!!!!! VERSION ERROR !!!!!!!!\n\nVersion check failed, check variable file version numbers against game version")
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

