LUAGUI_NAME = "2fmTest"
LUAGUI_AUTH = "deathofall84"
LUAGUI_DESC = "Empty test to ensure functioning of Lua Hook process"

function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then
		ConsolePrint("KH2 Detected, Lua Hook process configured correctly!")
	end
end

function _OnFrame()

end
