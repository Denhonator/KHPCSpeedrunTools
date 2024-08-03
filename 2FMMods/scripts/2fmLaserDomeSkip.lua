LUAGUI_NAME = "2fmLaserDomeSkip"
LUAGUI_AUTH = "Sonicshadowsilver2 (edited by deathofall84)"
LUAGUI_DESC = "Skip Laser Dome in final fight"

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
		if ReadShort(location) == 5138 and ReadInt(xemnasHP) == 1 then
			WriteInt(xemnasHP,0)
		end
	end
end
