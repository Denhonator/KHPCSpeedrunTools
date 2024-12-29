LUAGUI_NAME = "dddTest"
LUAGUI_AUTH = "deathofall84"
LUAGUI_DESC = "Empty test to ensure functioning of Lua Hook process"

function _OnInit()
	if GAME_ID == 0xE86A2A90 and ENGINE_TYPE == 'BACKEND' then
		ConsolePrint("DDD Detected, Lua Hook process configured correctly!")
	end
end

function _OnFrame()

end
