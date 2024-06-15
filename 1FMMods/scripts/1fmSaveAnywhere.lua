LUAGUI_NAME = "1fmSaveAnywhere"
LUAGUI_AUTH = "me"
LUAGUI_DESC = "Read readme for button combinations"

local offset = 0x3A2B86
local addgummi = 0
local lastInput = 0
local prevHUD = 0
local revertCode = false
local removeWhite = 0
local lastDeathPointer = 0
local soraHUD = 0x2812E1C - offset
local soraHP = 0x2D5D5CC - offset
local stateFlag = 0x2867C58 - offset
local deathCheck = 0x299BE0 - offset
local whiteFade = 0x234079C - offset
local blackFade = 0x4DD6B8 - offset
local closeMenu = 0x2E94B20 - offset
local deathPointer = 0x23987B8 - offset
local hardReset = 0x22EC9E4 - offset
local warpTrigger = 0x22EC9DC - offset
local warpType1 = 0x2340540 - offset
local warpType2 = 0x22EC9E0 - offset
local title = 0x2340DB8 - offset
local continue = 0x2E008D0 - offset
local config = 0x2E000D0 - offset
local cam = 0x507D18 - offset
local titlescreenpicture = 0x2EE55EC - offset
local titlescreenamvtimer = 0x2EE98D4 - offset
local cutSceneAspect = 0x4DE242 - offset
local menuReset = 0x2E94B20 - offset
-- change this to true doing the boss rush category
local bossRush = false

local canExecute = false
local language = "en"

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		if ReadShort(deathCheck) == 0x2E74 then
			ConsolePrint("Global version detected")	
		elseif ReadShort(deathCheck-0x1C0) == 0x2E74 then
			deathCheck = deathCheck-0x1C0
			ConsolePrint("JP detected")
			language = "jp"
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

function Reset()
	if language == "en" then
		ConsolePrint("Soft reset")
		WriteByte(warpType1, 0)
		WriteByte(warpType2, 0)
		WriteByte(cutSceneAspect, 127)
		if ReadByte(title) == 0 then
			WriteByte(title, 1)
			WriteInt(titlescreenamvtimer, 0)
		end
		WriteByte(warpTrigger, 2)
		WriteLong(menuReset, 0)
		WriteInt(titlescreenamvtimer, 0)
	else
		-- A soft reset that does not cause bugs for Japanese has not been found yet
		-- This will replicate the return to title from the game it self
		WriteLong(menuReset, 0)
		WriteInt(hardReset, 1)
	end
end

function _OnFrame()
	if not canExecute then
		goto done
	end

	if ReadByte(titlescreenpicture) == 0 then
		WriteByte(title, 1)
	end

	local input = ReadInt(0x2ED3034-offset)
	local savemenuopen = ReadByte(0x232E904-offset)
	
	if input == 1793 and lastInput ~= 1793 and savemenuopen~=4 and ReadByte(0x2354FD4-offset) == 0 then 
		WriteByte(0x2354FD4-offset, 0x1)
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
			WriteFloat(cam, -1.0 + ReadByte(config + 0x14) * 2)
			WriteFloat(cam + 4, 1.0 - ReadByte(config + 0x18) * 2)
		end
	end
	
	if input == 3848 and lastInput ~= 3848 then
		Reset()
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
		revertCode = true
	end
	
	if savemenuopen == 4 and addgummi==1 then
		WriteByte(0x2E20F28 - offset, 3) --Unlock gummi
		WriteByte(0x2E20E9C - offset, 5) --Set 5 buttons to save menu
		WriteByte(0x2E93750 - offset, 5) --Set 5 buttons to save menu
		WriteByte(0x2E93752 - offset, 5) --Set 5 buttons to save menu
		for i=0,4 do
			WriteByte(0x2E20EA0 + i * 4 - offset, i) --Set button types
		end
	end
	
	addgummi = addgummi > 0 and addgummi-1 or addgummi
	
	lastInput = input
	lastDeathPointer = ReadLong(deathPointer)
	
	-- For boss rush comment this if block out as it writes to the auto save files as well
	-- ConsolePrint(soraHUD)
	-- ConsolePrint(prevHUD)
	if ReadFloat(soraHUD) == 1 and prevHUD < 1  and not bossRush then
		local f = io.open("autosave.dat", "wb")
		f:write(ReadString(continue, 0x16C00))
		f:close()
		ConsolePrint("Wrote autosave")
	end
	prevHUD = ReadFloat(soraHUD)

	::done::
end
