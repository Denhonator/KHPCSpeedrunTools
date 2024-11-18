LUAGUI_NAME = "2fmGummiSkip"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Skip gummi missions"

function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then --PC
        canExecute = true
		require("VersionCheck")
	end
end

function _OnFrame()
	if canExecute then
		for i=0, 16 do
			if ReadByte(gummiSkip + (i * 4)) >= 2 then
				WriteByte(gummiSkip + (i * 4), 0)
			end
		end
		for i=353, 361 do
			if ReadByte(gummiSkip + i) == 1 then
				WriteByte(gummiSkip + i, 2)
			end
		end
	end
end
