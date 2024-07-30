LUAGUI_NAME = "2fmGummiSkip"
LUAGUI_AUTH = "Sonicshadowsilver2 (edited by deathofall84)"
LUAGUI_DESC = "Open save anywhere"

local canExecute = false

local valor = ""
local save = ""
local savedHP = 0
local savedAbilities = 0
local hold = false
local counter = 30

function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then --PC
        canExecute = true
		if ReadInt(0x80) ==  then --EGS Gloabl
			ConsolePrint('Epic Global Version Detected')
			require("EpicGamesGlobal")
		elseif ReadInt(0x80) ==  then --EGS JP
			ConsolePrint('Epic JP Version Detected')
			require("EpicGamesGlobal")
		elseif ReadInt(0x80) ==  then --Steam Global
			ConsolePrint('Steam Global Version Detected')
			require("SteamGlobal")
		elseif ReadInt(0x80) ==  then --Steam JP
			ConsolePrint('Steam JP Version Detected')
			require("SteamJP")
		end
	end
end

function _OnFrame()
	if canExecute then
		local input = ReadShort(0x29F8AC0-offset)
		if (input == 2816) then 
			if valor == "" then
				valor = ReadString(valorAddr, 46)
				save = ReadString(saveAddr, 46)
			end
			
			if not hold then
				savedHP = ReadByte(soraHP)
				savedAbilities = ReadByte(abilities)
				WriteString(valorAddr, save)
			end
			
			counter = 30
			WriteByte(soraHP, 1)
			
			if ReadByte(abilities) < 128 then
				WriteByte(abilities, ReadByte(abilities) + 128)
			end
			
			hold = true
		elseif ReadByte(valorAddr) == 0x37 then
			WriteString(valorAddr, valor)
			WriteByte(soraHP, savedHP)
			WriteByte(abilities, savedAbilities)
			hold = false
		end
		
		if counter > 0 then
			WriteByte(allowGummi, 0)
			counter = counter - 1
		end
	end
end