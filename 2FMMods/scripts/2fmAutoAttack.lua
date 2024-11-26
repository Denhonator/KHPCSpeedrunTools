LUAGUI_NAME = "2fmAutoSave"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Hold attack to combo"

function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then
		require("VersionCheck")
	else
		ConsolePrint("KH2 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		local input = ReadInt(inputAddress) == 134217732
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
