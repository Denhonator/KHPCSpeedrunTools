LUAGUI_NAME = "1fmTest"
LUAGUI_AUTH = "deathofall84"
LUAGUI_DESC = "Empty test to ensure functioning of Lua Hook process"

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == 'BACKEND' then
		ConsolePrint("KH1 Detected, Lua Hook process configured correctly!")
	end
end

function _OnFrame()

end
