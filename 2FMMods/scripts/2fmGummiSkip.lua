LUAGUI_NAME = "2fmGummiSkip"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Skip gummi missions"

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
		for i=0, 16 do
			if ReadByte(TT + (i * 4)) >= 2 then
				WriteByte(TT + (i * 4), 0)
			end
		end
		for i=353, 361 do
			if ReadByte(TT + i) == 1 then
				WriteByte(TT + i, 2)
			end
		end
	end
end