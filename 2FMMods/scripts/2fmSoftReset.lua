LUAGUI_NAME = "2fmSoftReset"
LUAGUI_AUTH = "Sonicshadowsilver2 (edited by deathofall84)"
LUAGUI_DESC = "Soft reset"

local canExecute = false

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
	if canExecute and ReadShort(inputAddress) == 3848 then
		WriteByte(softReset, 1)
		WriteInt(rng, 1)
		WriteByte(spawns, 0)
	end
end
