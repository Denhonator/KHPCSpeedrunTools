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
	if canExecute then
		local input = ReadInt(0x29F89B0-offset)
		if (input == 8192 and ReadInt(saveselect) == 0) then 
			local f = io.open("KH2autosave.dat", "rb")
			if f ~= nil then
				WriteString(save1, f:read("*a"))
				f:close()
			end
		end
		if ReadInt(continue+0xC) ~= prevContinue and ReadByte(0x711438-offset2) == 0 then
			local f = io.open("KH2autosave.dat", "wb")
			f:write(ReadString(continue, 0x10FC0))
			f:close()
			ConsolePrint("Wrote autosave")
		end
		prevInput = input
		prevContinue = ReadInt(continue+0xC)
	end
end