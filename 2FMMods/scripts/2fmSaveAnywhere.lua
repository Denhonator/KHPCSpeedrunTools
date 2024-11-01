LUAGUI_NAME = "2fmGummiSkip"
LUAGUI_AUTH = "Sonicshadowsilver2 (edited by deathofall84)"
LUAGUI_DESC = "Open save anywhere"

local valor = ""
local save = ""
local savedHP = 0
local savedAbilities = 0
local hold = false
local counter = 30

function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then
		require("VersionCheck")
	end
end

function _OnFrame()
	if canExecute then
		if ReadInt(inputAddress) == 212992 then
			if valor == "" then
				valor = ReadString(valorAddress, 46)
				save = ReadString(saveAddress, 46)
			end

			if not hold then
				savedHP = ReadByte(soraHP)
				savedAbilities = ReadByte(abilities)
				WriteString(valorAddress, save)
			end

			counter = 30
			WriteByte(soraHP, 1)

			if ReadByte(abilities) < 128 then
				WriteByte(abilities, ReadByte(abilities) + 128)
			end

			hold = true
		elseif ReadByte(valorAddress) == 55 then
			WriteString(valorAddress, valor)
			WriteByte(soraHP, savedHP)
			WriteByte(abilities, savedAbilities)
			hold = false
		end

		if counter > 0 then
			WriteByte(saveMenuSlot, 0)
			counter = counter - 1
		end
	end
end
