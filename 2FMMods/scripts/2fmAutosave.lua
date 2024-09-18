LUAGUI_NAME = "2fmAutoSave"
LUAGUI_AUTH = "Sonicshadowsilver2 (edited by deathofall84)"
LUAGUI_DESC = "Auto save and load auto saves"

local canExecute = false
local prevContinue = 0
local blacklist = {
	"es01", "bb05", "eh20", "eh22", "eh23", "eh24",
	"eh25", "eh26", "eh27", "eh28", "eh29"
}
local blacklisted = false
local loadCount = 0

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
	local SVE = ReadString(autoSaveAddress, 4)
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
		local input = ReadInt(inputAddress)
		local inputCheck = input == 8192 or input == 196608

		--reset loadCount
		if ReadByte(loadMenu) == 3 then
			loadCount = 0
			-- touchpad (left side or share for steam) / L2 R2
			if inputCheck then
				WriteFloat(loadingIndicator, 90)
			end
		end

		if ReadInt(saveSelect) == 0 and ReadInt(save) ~= prevSave and inputCheck then
			local f = io.open("KH2autosave.dat", "rb")
			if input == 196608 then
				f = io.open("KH2autosave2.dat", "rb")
			end
			if f ~= nil then
				WriteString(save - 12, f:read("*a"))
				f:close()
				if input == 8192 then
					ConsolePrint("Loaded autosave")
				else
					ConsolePrint("Loaded backup autosave")
				end
			end
		end

		if ReadInt(continue) ~= prevContinue and ReadByte(writeLogic) == 0 and not blacklisted then
			if loadCount > 1 then
				local r = io.open("KH2autosave.dat", "rb")
				local f2 = io.open("KH2autosave2.dat", "wb")
				f2:write(r:read("*a"))
				ConsolePrint("Copying Backup")
				f2:close()
				r:close()
			end

			local f = io.open("KH2autosave.dat", "wb")
			f:write(ReadString(continue - 12, 69568))
			f:close()
			ConsolePrint("Wrote autosave")

			loadCount = loadCount + 1
		end
		prevSave = ReadInt(save)
		prevContinue = ReadInt(continue)
	end
end
