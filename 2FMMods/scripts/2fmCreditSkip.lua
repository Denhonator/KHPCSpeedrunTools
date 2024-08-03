LUAGUI_NAME = "2fmCreditSkip"
LUAGUI_AUTH = "Sonicshadowsilver2 (edited by deathofall84)"
LUAGUI_DESC = "Allow cutscene skip in credits"

local canExecute = false

function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then --PC
        canExecute = true
		if ReadByte(0x660E04) == 106 or ReadByte(0x660DC4) == 106 then --EGS
			ConsolePrint('Epic Games Version Detected')
			require("EpicGamesGlobal") -- Both versions share addresses
		elseif ReadByte(0x660E74) == 106 then -- Steam Global
			ConsolePrint('Steam Global Version Detected')
			require("SteamGlobal")
		elseif ReadByte(0x65FDF4) == 106 then -- Steam JP
			ConsolePrint('Steam JP Version Detected')
			require("SteamJP")
		end
	end
end

function _OnFrame()
	if canExecute then
		if ReadShort(location) == 5138 or ReadShort(location) == 1 then --Final Xemnas & Ending
			if ReadByte(pause) == 2 then
				WriteByte(pause, 0) --Enable Pause
			end
		end
    end
end
