LUAGUI_NAME = "2fmQuickHP0"
LUAGUI_AUTH = "Sonicshadowsilver2 (edited by deathofall84)"
LUAGUI_DESC = "Instant kill self with specific input"

function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then --PC
        canExecute = true
		require("VersionCheck")
	end
end

function _OnFrame()
	if canExecute then
		if ReadShort(inputAddress + 4) == 13 and ReadInt(soraHP) ~= 0 then
			WriteInt(soraHP, 0)
		end
	end
end
