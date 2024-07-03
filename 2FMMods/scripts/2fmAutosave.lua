local GameVersion = 0
local canExecute = false
local prevBlack = 0
local prevContinue = 0
local blacklist = {"es01", "bb05", "eh20", "eh22", "eh23", "eh24", "eh25", "eh26", "eh27", "eh28", "eh29"}
local blacklisted = false

function _OnInit()
	GameVersion = 0
end

function GetVersion() --Define anchor addresses
	if GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then --PC
		if ReadString(0x09A92F0,4) == 'KH2J' then --EGS
			GameVersion = 2
			print('[2fmAutoSave] - Epic Version Detected')
			continue = 0x29FAFC0
			save1 = 0x9A92F0
			saveselect = 0x2616D60
			sveAddr = 0x9BA370
			inputAddr = 0x29FAD30
			LoadingIndicator = 0x8EBFF0
			loadmenu = 0x743350
			writeLogic = 0x713438
            canExecute = true
		elseif ReadString(0x09A9830,4) == 'KH2J' then --Steam Global
			GameVersion = 3
			print('[2fmAutoSave] - Steam Global Version Detected')
			continue = 0x29FB500
			save1 = 0x9A9830
			saveselect = 0x2617460
			sveAddr = 0x9BA8B0
			inputAddr = 0xBF3120
			LoadingIndicator = 0x8EC540
			loadmenu = 0x7435D0
			writeLogic = 0x7134A0
            canExecute = true
		elseif ReadString(0x09A8830,4) == 'KH2J' then --Steam JP
			GameVersion = 4
			print('[2fmAutoSave] - Steam JP Version Detected')
			continue = 0x29FA500
			save1 = 0x9A8830
			saveselect = 0x2616460
			sveAddr = 0x9B98B0
			inputAddr = 0xBF2120
			LoadingIndicator = 0x8EB540
			loadmenu = 0x7425D0
			writeLogic = 0x7124A0
            canExecute = true
		end
	end
end

function _OnFrame()
	if GameVersion == 0 then --Get anchor addresses
		GetVersion()
		return
	end
	
	SVE = ReadString(sveAddr, 4)
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
		local input = ReadInt(inputAddr)
		if input & 8192 == 8192 and ReadByte(loadmenu) == 0x03 then
			WriteFloat(LoadingIndicator, 90)
		end
		if (input & 8192 == 8192 and ReadInt(saveselect) == 0 and ReadInt(save1+0xC) ~= prevSave) then 
			local f = io.open("KH2autosave.dat", "rb")
			if f ~= nil then
				WriteString(save1, f:read("*a"))
				f:close()
				print("Loaded autosave")
			end
		end
		if ReadInt(continue+0xC) ~= prevContinue and ReadByte(writeLogic) == 0 and blacklisted == false then
			local f = io.open("KH2autosave.dat", "wb")
			f:write(ReadString(continue, 0x10FC0))
			f:close()
			print("Wrote autosave")
		end
		prevInput = input
		prevSave = ReadInt(save1+0xC)
		prevContinue = ReadInt(continue+0xC)
	end
end
