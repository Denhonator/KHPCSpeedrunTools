LUAGUI_NAME = "bbsTest"
LUAGUI_AUTH = "deathofall84"
LUAGUI_DESC = "Empty test to ensure functioning of Lua Hook process"

function _OnInit()
	if GAME_ID == 0xBED4B944 and ENGINE_TYPE == 'BACKEND' then
		ConsolePrint("BBS Detected, Lua Hook process configured correctly!")
	end
end

function _OnFrame()

end
