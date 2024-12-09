LUAGUI_NAME = "2fmSoftReset"
LUAGUI_AUTH = "Sonicshadowsilver2 (edited by deathofall84)"
LUAGUI_DESC = "Soft reset"

function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then
		require("VersionCheck")
	else
		ConsolePrint("KH2 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute and ReadShort(inputAddress) == 3848 then
		WriteByte(softReset, 1)
		WriteInt(rng, 1)
		WriteByte(spawns, 0)
	end
end
