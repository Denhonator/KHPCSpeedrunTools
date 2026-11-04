LUAGUI_NAME = "1fmAutoattack"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Hold attack to combo"

local cooldown = 0
local waitForRelease = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		require("VersionCheck")
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		attackInput = (ReadByte(attInp) // (64 - (32 * ReadByte(swapped)))) % 2 == 1
		local selectedCommand = ReadByte(attackCommand)

		if selectedCommand ~= 0 then
			waitForRelease = true
		elseif not attackInput then
			waitForRelease = false
		end

		if ReadInt(menu) == 1 or ReadInt(dialog) == 0 then
			cooldown = 20
		elseif cooldown > 0 then
			cooldown = cooldown - 1
		end
		autofireState = (attackInput and selectedCommand == 0 and not waitForRelease and cooldown == 0) and 1 or 0
		WriteInt(fireState1, autofireState)
		WriteInt(fireState2, autofireState)
	end
end
