local offset = 0x56454E

local canExecute = false

local valorAddr = 0x2A60214 - offset
local saveAddr = 0x2A5A8A4 - offset
local soraHP = 0x2A20C98 - offset
local abilities = 0x2A20E68 - offset
local allowGummi = 0xBEB690 - offset

local valor = ""
local save = ""
local savedHP = 0
local savedAbilities = 0
local hold = false
local counter = 30

function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH2 detected, running script")
		if ReadInt(0x2A5A056-offset) > 0 and ReadInt(0x2A59056-offset) == 0 then
			offset = 0x56550E
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
		local input = ReadShort(0x29F8AC0-offset)
		if (input == 2816) then 
			if valor == "" then
				valor = ReadString(valorAddr+2, 46)
				save = ReadString(saveAddr+2, 46)
			end
			
			if not hold then
				savedHP = ReadByte(soraHP)
				savedAbilities = ReadByte(abilities+2)
				WriteString(valorAddr+2, save)
			end
			
			counter = 30
			WriteByte(soraHP, 1)
			
			if ReadByte(abilities+2) < 128 then
				WriteByte(abilities+2, ReadByte(abilities+2)+128)
			end
			
			hold = true
		elseif ReadByte(valorAddr+2) == 0x37 then
			WriteString(valorAddr+2, valor)
			WriteByte(soraHP, savedHP)
			WriteByte(abilities+2, savedAbilities)
			hold = false
		end
		
		if counter > 0 then
			WriteByte(allowGummi, 0)
			counter = counter - 1
		end
	end
end