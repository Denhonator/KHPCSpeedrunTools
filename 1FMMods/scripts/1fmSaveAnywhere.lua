LUAGUI_NAME = "1fmSaveAnywhere"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Read readme for button combinations"

local addgummi = 0
local lastInput = 0
local prevHUD = 0
local revertCode = false
local removeWhite = 0
local lastDeathPointer = 0
local canExecute = false
local bossRush = false
local posDebugString = 0x3EB158

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		if ReadByte(posDebugString) == 0x58 then
			require("EpicGamesGlobal")
		elseif ReadByte(posDebugString - 0x1020) == 0x58 then
			require("EpicGamesJP")
		else
			require("SteamGlobal") -- Global and JP equal
			if ReadByte(posDebugString - 0xE40) ~= 0x58 then
				deathCheck = deathCheck - 0x280
			end
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end

	lastDeathPointer = ReadLong(deathPointer)
end

function InstantContinue()
	if ReadByte(warpTrigger) == 0 then
		ConsolePrint("Instant continue trigger")
		WriteByte(warpType1, 5)
		WriteByte(warpType2, 12)
		WriteByte(warpTrigger, 2)
	end
end

function SoftReset()
	ConsolePrint("Soft reset")
	WriteByte(warpType1, 0)
	WriteByte(warpType2, 0)
	WriteByte(cutSceneAspect, 127)
	if ReadByte(title) == 0 then
		WriteByte(title, 1)
		WriteInt(titlescreenamvtimer, 0)
	end
	WriteByte(warpTrigger, 2)
	WriteLong(closeMenu, 0)
	WriteInt(titlescreenamvtimer, 0)
end

function _OnFrame()
	if canExecute then
		if ReadByte(titlescreenpicture) == 0 then
			WriteByte(title, 1)
		end

		local input = ReadInt(inputAddress)
		local savemenuopen = ReadByte(saveOpenAddress)

		if input == 1793 and lastInput ~= 1793 and savemenuopen ~=4 and ReadByte(saveAnywhere) == 0 then 
			WriteByte(saveAnywhere, 1)
			addgummi = 5
		elseif input == 1793 and ReadByte(saveAnywhere) == 1 then
			WriteLong(closeMenu, 0)
		end
		
		if input == 3968 and lastInput ~= 3968 and ReadLong(closeMenu) == 0 then
			InstantContinue()
		end
		
		if input == 3872 and lastInput ~= 3872 and ReadLong(closeMenu) == 0 then
			local f = io.open("autosave.dat", "rb")
			if f ~= nil then
				WriteString(continue, f:read("*a"))
				f:close()
				ConsolePrint("Loaded autosave")
				WriteByte(closeMenu, 0)
				InstantContinue()
				WriteFloat(cam, -1.0 + ReadByte(config + 20) * 2)
				WriteFloat(cam + 4, 1.0 - ReadByte(config + 24) * 2)
			end
		end
		
		if input == 3848 and lastInput ~= 3848 then
			SoftReset()
		end
		
		-- Remove white screen on death (it bugs out this way normally)
		if removeWhite > 0 then
			removeWhite = removeWhite - 1
			if ReadByte(white) == 128 then
				WriteByte(white, 0)
			end
		end
		
		-- Reverts disabling death condition check (or it crashes)
		if revertCode and ReadLong(deathPointer) ~= lastDeathPointer then
			WriteShort(deathCheck, 11892)
			removeWhite = 1000
			revertCode = false
		end
		
		-- R1 R2 L2 Select
		-- Sora HP to 0 (not necessary)
		-- State to combat
		-- Death condition check disable
		if input == 2817 and ReadFloat(soraHUD) > 0 and ReadByte(soraHP) > 0
						 and ReadByte(blackFade) == 128 and ReadShort(deathCheck) == 11892 then
			WriteByte(soraHP, 0)
			WriteByte(stateFlag, 1)
			WriteShort(deathCheck, 37008)
			revertCode = true
		end
		
		if savemenuopen == 4 and addgummi==1 then
			WriteByte(menuFunction, 3) --Unlock gummi
			WriteByte(menuButtonCount, 5) --Set 5 buttons to save menu
			WriteByte(menuMaxButtonCount, 5) --Set 5 buttons to save menu
			WriteByte(menuItemSlotCount, 5) --Set 5 buttons to save menu
			for i=0,4 do
				WriteByte(buttonTypes + i * 4, i) --Set button types
			end
		end
		
		addgummi = addgummi > 0 and addgummi-1 or addgummi
		
		lastInput = input
		lastDeathPointer = ReadLong(deathPointer)
		
		-- For boss rush comment this if block out as it writes to the auto save files as well
		if ReadFloat(soraHUD) == 1 and prevHUD < 1  and not bossRush then
			local f = io.open("autosave.dat", "wb")
			f:write(ReadString(continue, 93184))
			f:close()
			ConsolePrint("Wrote autosave")
		end
		prevHUD = ReadFloat(soraHUD)
	end
end
