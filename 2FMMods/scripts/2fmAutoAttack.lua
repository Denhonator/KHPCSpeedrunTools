LUAGUI_NAME = "2fmAutoSave"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Hold attack to combo"

local canExecute = false
local attackInput = 0x780481 - offset
local inputAddress = 0x71144B - offset
local commandMenuItem = 0x2A0DD7C - offset
local inDialog = 0x2A139D0 - offset
local combatStatus = 0x2A0EAC4 - offset
local holdAttack = 0x2A5A056 - offset

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
		local attackButton = ReadByte(attackInput)
		local input = ReadByte(inputAddress) == attackButton
		local command = ReadByte(commandMenuItem) == 0
		local dialog = ReadByte(inDialog) == 0
		local inCombat = ReadByte(combatStatus) & 3 > 0

		if (input and command and dialog and inCombat) then 
			WriteByte(holdAttack, 1)
		else
			WriteByte(holdAttack, 0)
		end
	end
end