LUAGUI_NAME = "1fmSaveAnywhere"
LUAGUI_AUTH = "denhonator"
LUAGUI_DESC = "Read readme for button combinations"

local extraSafety = false
local offset = 0x3A0606
local addgummi = 0
local lastInput = 0
local prevHUD = 0
local revertCode = false
local removeWhite = 0
local lastDeathPointer = 0
local soraHUD = 0x280EB1C - offset
local soraHP = 0x2D592CC - offset
local stateFlag = 0x2863958 - offset
local deathCheck = 0x2978E0 - offset
local safetyMeasure = 0x297746 - offset
local whiteFade = 0x233C49C - offset
local blackFade = 0x4D93B8 - offset
local closeMenu = 0x2E90820 - offset
local deathPointer = 0x23944B8 - offset
local warpTrigger = 0x22E86DC - offset
local warpType1 = 0x233C240 - offset
local warpType2 = 0x22E86E0 - offset
local title = 0x233CAB8 - offset
local continue = 0x2DFC5D0 - offset
local config = 0x2DFBDD0 - offset
local cam = 0x503A18 - offset

local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		if ReadShort(deathCheck) == 0x2E74 then
			ConsolePrint("Global version detected")	
		elseif ReadShort(deathCheck-0x1C0) == 0x2E74 then
			deathCheck = deathCheck-0x1C0
			safetyMeasure = safetyMeasure-0x1C0
			extraSafety = false
			ConsolePrint("JP detected")
		end
		canExecute = true
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
	WriteByte(warpType1, 3)
	WriteByte(warpType2, 1)
	if ReadByte(title) == 0 then
		WriteByte(title, 1)
	end
	WriteByte(warpTrigger, 2)
end

function _OnFrame()
	if not canExecute then
		goto done
	end

	local input = ReadInt(0x233D034-offset)
	local savemenuopen = ReadByte(0x232A604-offset)
	
	if input == 1793 and lastInput ~= 1793 and savemenuopen~=4 and ReadByte(0x2350CD4-offset) == 0 then 
		WriteByte(0x2350CD4-offset, 0x1)
		addgummi = 5
	elseif input == 1793 and lastInput ~= 1793 then
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
			WriteByte(closeMenu, 1)
			InstantContinue()
			WriteFloat(cam, -1.0 + ReadByte(config+0x14)*2)
			WriteFloat(cam+4, 1.0 - ReadByte(config+0x18)*2)
		end
	end
	
	if input == 3848 and lastInput ~= 3848 then
		SoftReset()
	end
	
	-- Remove white screen on death (it bugs out this way normally)
	if removeWhite > 0 then
		removeWhite = removeWhite - 1
		-- WriteLong(closeMenu, 0)
		if ReadByte(whiteFade) == 128 then
			WriteByte(whiteFade, 0)
		end
	end
	
	-- Reverts disabling death condition check (or it crashes)
	if revertCode and ReadLong(deathPointer) ~= lastDeathPointer then
		WriteShort(deathCheck, 0x2E74)
		if extraSafety then
			WriteLong(safetyMeasure, 0x8902AB8973058948)
		end
		removeWhite = 1000
		revertCode = false
	end
	
	-- R1 R2 L2 Select
	-- Sora HP to 0 (not necessary)
	-- State to combat
	-- Death condition check disable
	if input == 2817 and ReadFloat(soraHUD) > 0 and ReadByte(soraHP) > 0 and ReadByte(blackFade)==128
												and ReadShort(deathCheck) == 0x2E74 then
		WriteByte(soraHP, 0)
		WriteByte(stateFlag, 1)
		WriteShort(deathCheck, 0x9090)
		if extraSafety then
			WriteLong(safetyMeasure, 0x89020B958735894C)
		end
		revertCode = true
	end
	
	if savemenuopen == 4 and addgummi==1 then
		WriteByte(0x2E1CC28-offset, 3) --Unlock gummi
		WriteByte(0x2E1CB9C-offset, 5) --Set 5 buttons to save menu
		WriteByte(0x2E8F450-offset, 5) --Set 5 buttons to save menu
		WriteByte(0x2E8F452-offset, 5) --Set 5 buttons to save menu
		for i=0,4 do
			WriteByte(0x2E1CBA0+i*4-offset, i) --Set button types
		end
	end
	
	addgummi = addgummi > 0 and addgummi-1 or addgummi
	
	lastInput = input
	lastDeathPointer = ReadLong(deathPointer)
	
	if ReadFloat(soraHUD) == 1 and prevHUD < 1 then
		local f = io.open("autosave.dat", "wb")
		f:write(ReadString(continue, 0x16C00))
		f:close()
		ConsolePrint("Wrote autosave")
	end
	prevHUD = ReadFloat(soraHUD)
	
	::done::
end