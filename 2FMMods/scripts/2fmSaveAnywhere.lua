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
		require("VersionCheck")
		if ReadByte(EGSGlobalVersion) == 106 then
			importVars("EpicGamesGlobal")
		elseif ReadByte(EGSJPVersion) == 106 then
			importVars("EpicGamesJP")
		elseif ReadByte(SteamGlobalVersion) == 106 then
			importVars("SteamGlobal")
		elseif ReadByte(SteamJPVersion) == 106 then
			importVars("SteamJP")
		else
			canExecute = false
			ConsolePrint("\n\n!!!!!!!! VERSION ERROR !!!!!!!!\n\nVersion check failed, check variable file version numbers against game version")
		end
	end
end

function _OnFrame()
	if canExecute then
		if ReadShort(inputAddress) == 2816 then
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
		elseif ReadByte(valorAddress) == 0x37 then
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
