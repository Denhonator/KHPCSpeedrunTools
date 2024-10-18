LUAGUI_NAME = "recomTest"
LUAGUI_AUTH = "deathofall84"
LUAGUI_DESC = "Empty test to ensure functioning of Lua Hook process"

function _OnInit()
	if GAME_ID == 0x9E3134F5 and ENGINE_TYPE == 'BACKEND' then
		ConsolePrint("KH2 Detected, Lua Hook process configured correctly!")
	end
end

function _OnFrame()

end
