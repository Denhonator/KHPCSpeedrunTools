LUAGUI_NAME = "2fmLaserDomeSkip"
LUAGUI_AUTH = "Sonicshadowsilver2 (edited by deathofall84)"
LUAGUI_DESC = "Skip Laser Dome in final fight"

local canExecute = false

function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then --PC
        canExecute = true
		if ReadInt(0x80) ==  then --EGS Gloabl
			ConsolePrint('Epic Global Version Detected')
			require("EpicGamesGlobal")
		elseif ReadInt(0x80) ==  then --EGS JP
			ConsolePrint('Epic JP Version Detected')
			require("EpicGamesGlobal")
		elseif ReadInt(0x80) ==  then --Steam Global
			ConsolePrint('Steam Global Version Detected')
			require("SteamGlobal")
		elseif ReadInt(0x80) ==  then --Steam JP
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
