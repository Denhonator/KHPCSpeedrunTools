local offset = 0x56450E
local offset2 = 0x56454E

local continue = 0x29F8C80 - offset2
local save1 = 0x9A70B0 - offset2
local saveselect = 0x2614A20 - offset2

local canExecute = false
local prevBlack = 0
local prevContinue = 0

function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH2 detected, running script")
		if ReadInt(0x2A5A056-offset) > 0 and ReadInt(0x2A59056-offset) == 0 then
			offset = 0x56550E
			offset2 = 0x56554E
			ConsolePrint("Detected JP version. If this is incorrect, try reloading at a different time")
		else
			ConsolePrint("Detected GLOBAL version. If this is incorrect, try reloading at a different time")
		end
	else
		ConsolePrint("KH2 not detected, not running script")
	end
end

function _OnFrame()
SVE = ReadInt(0x9B8130 - offset2)
BL1 = 825258853 --es01, considered a world-transition. Plays when you idle too long in Pause Menu
BL2 = 892363362 --bb05
BL3 = 808609893 --eh20
BL4 = 842164325 --eh22
BL5 = 858941541 --eh23
BL6 = 875718757 --eh24
BL7 = 892495973 --eh25
BL8 = 909273189 --eh26
BL9 = 926050405 --eh27
BL10 = 942827621 --eh28
BL11 = 959604837 --eh29
	if canExecute then
		local input = ReadInt(0x29F89B0-offset)
		if (input == 8192 and ReadInt(saveselect) == 0 and ReadInt(save1+0xC) ~= prevSave) then 
			local f = io.open("KH2autosave.dat", "rb")
			if f ~= nil then
				WriteString(save1, f:read("*a"))
				f:close()
				ConsolePrint("Loaded autosave")
			end
		end
		if ReadInt(continue+0xC) ~= prevContinue and ReadByte(0x711438-offset2) == 0 and SVE ~= BL1 and SVE ~= BL2 and SVE ~= BL3 and SVE ~= BL4 and SVE ~= BL5 and SVE ~= BL6 and SVE ~= BL7 and SVE ~= BL8 and SVE ~= BL9 and SVE ~= BL10 and SVE ~= BL11 then
			local f = io.open("KH2autosave.dat", "wb")
			f:write(ReadString(continue, 0x10FC0))
			f:close()
			ConsolePrint("Wrote autosave")
		end
		prevInput = input
		prevSave = ReadInt(save1+0xC)
		prevContinue = ReadInt(continue+0xC)
	end
end
