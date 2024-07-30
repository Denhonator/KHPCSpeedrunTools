LUAGUI_NAME = "2fmAutoSave"
LUAGUI_AUTH = "Sonicshadowsilver2 (edited by deathofall84)"
LUAGUI_DESC = "Auto save and load auto saves"

local canExecute = false
local prevBlack = 0
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
	local SVE = ReadString(saveAddress, 4)
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

		--reset loadCount
		if ReadByte(loadMenu) == 3 then
			loadCount = 0
			local inputCheck = input == 8192 or input == 196608
			if inputCheck then
				WriteFloat(loadingIndicator, 90)
			end
			if ReadInt(saveSelect) == 0 and ReadInt(save1 + 12) ~= prevSave and inputCheck then
				local f = io.open("KH2autosave.dat", "rb")
				if input == 196608 then
					f = io.open("KH2autosave2.dat", "rb")
				end
				if f ~= nil then
					WriteString(save1, f:read("*a"))
					f:close()
					if input == 8192 then
						ConsolePrint("Loaded autosave")
					else
						ConsolePrint("Loaded backup autosave")
					end
				end
			end
		end

		if ReadInt(continue + 12) ~= prevContinue and ReadByte(writeLogic) == 0 and blacklisted == false then
			if loadCount > 1 then
				local r = io.open("KH2autosave.dat", "rb")
				local f2 = io.open("KH2autosave2.dat", "wb")
				f2:write(r:read("*a"))
				ConsolePrint("Copying Backup")
				f2:close()
				r:close()
			end
			
			local f = io.open("KH2autosave.dat", "wb")
			f:write(ReadString(continue, 69568))
			f:close()
			ConsolePrint("Wrote autosave")

			loadCount = loadCount + 1
		end
		prevSave = ReadInt(save1 + 12)
		prevContinue = ReadInt(continue + 12)
	end
end