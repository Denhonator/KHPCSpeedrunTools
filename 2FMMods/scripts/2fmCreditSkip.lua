LUAGUI_NAME = "2fmCreditSkip"
LUAGUI_AUTH = "Sonicshadowsilver2 (edited by deathofall84)"
LUAGUI_DESC = "Allow cutscene skip in credits"

function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then
		require("VersionCheck")
	else
		ConsolePrint("KH2 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		if ReadShort(location) == 5138 or ReadShort(location) == 1 then --Final Xemnas & Ending
			if ReadByte(pause) == 2 then
				WriteByte(pause, 0) --Enable Pause
			end
		end
    end
end
