LUAGUI_NAME = "2fmLaserDomeSkip"
LUAGUI_AUTH = "Sonicshadowsilver2 (edited by deathofall84)"
LUAGUI_DESC = "Skip Laser Dome in final fight"

function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then --PC
        canExecute = true
		require("VersionCheck")
	end
end

function _OnFrame()
	if canExecute then
		if ReadShort(location) == 5138 and ReadInt(xemnasHP) == 1 then
			WriteInt(xemnasHP,0)
		end
	end
end
