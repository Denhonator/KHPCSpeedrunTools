LUAGUI_NAME = "2fmAutoSave"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Hold attack to combo"

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
		local input = ReadShort(inputAddress) == 16384
		local command = ReadByte(commandMenuItem) == 0
		local dialog = ReadByte(inDialogue) == 0
		local inCombat = ReadByte(btlTyp) & 3 > 0

		if input and command and dialog and inCombat then
			WriteByte(autoAttack, 1)
		else
			WriteByte(autoAttack, 0)
		end
	end
end
