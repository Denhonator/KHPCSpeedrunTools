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