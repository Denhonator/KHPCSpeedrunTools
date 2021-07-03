local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute == true then
		WriteArray(0x7FF77252ACF3, { 0xEB, 0x10 }, true)
		WriteArray(0x7FF772525EAC, { 0x0F, 0x96, 0xC0 }, true)
	end
end