local offset = 0x56450E
local offset2 = 0x56454E

local continue = 0x29F8C80 - offset2
local save1 = 0x9A70B0 - offset2
local saveselect = 0x2614A20 - offset2

local canExecute = false
local prevBlack = 0
local prevContinue = 0
local blacklist = {"es01", "bb05", "eh20", "eh22", "eh23", "eh24", "eh25", "eh26", "eh27", "eh28", "eh29"}
local blacklisted = false

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
SVE = ReadString(0x9B8130 - offset2, 4)
for i = 1, 11 do
	if SVE ~= blacklist[i] then
	blacklisted = false
	end
end
for i = 1, 11 do
	if SVE == blacklist[i] then
	blacklisted = true
	end
end
	if canExecute then
		local input = ReadInt(0x29F89B0-offset)
		local LoadingIndicator = 0x8E9DA0-offset2
		local loadmenu = 0x741320-0x56454E
		if input & 8192 == 8192 and ReadByte(loadmenu) == 0x03 then
			WriteFloat(LoadingIndicator, 90)
		end
		if (input & 8192 == 8192 and ReadInt(saveselect) == 0 and ReadInt(save1+0xC) ~= prevSave) then 
			local f = io.open("KH2autosave.dat", "rb")
			if f ~= nil then
				WriteString(save1, f:read("*a"))
				f:close()
				ConsolePrint("Loaded autosave")
			end
		end
		if ReadInt(continue+0xC) ~= prevContinue and ReadByte(0x711438-offset2) == 0 and blacklisted == false then
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
