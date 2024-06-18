LUAGUI_NAME = "1fmSaveAnywhere"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Read readme for button combinations"

local offset = 0x0
local offset_2 = 0x0
local addgummi = 0
local lastInput = 0
local prevHUD = 0
local revertCode = false
local removeWhite = 0
local lastDeathPointer = 0
local canExecute = false
local posDebugString = 0x3EB158

-- change this to true doing the boss rush category
local bossRush = false


function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		if ReadByte(posDebugString) == 0x58 or ReadByte(posDebugString-0x1020) == 0x58 then
			ConsolePrint("Epic Games detected")
			deathCheck = 0x299BE0
			if ReadShort(deathCheck) == 0x2E74 then
				ConsolePrint("Global version detected, no offset change needed")
			elseif ReadShort(deathCheck-0x1C0) == 0x2E74 then -- check this
				ConsolePrint("JP version detected, setting offsets")
				offset = offset + 0x1000
				offset_2 = offset_2 + 0x3090
				deathCheck = deathCheck - 0x1C0
			end
			soraHUD = 0x2812E1C - offset
			soraHP = 0x2D5D5CC - offset
			stateFlag = 0x2867C58 - offset
			whiteFade = 0x234079C - offset
			blackFade = 0x4DD3F8 - offset
			closeMenu = 0x2E94B20 - offset
			deathPointer = 0x23987B8 - offset
			warpTrigger = 0x22EC9DC - offset
			warpType1 = 0x2340540 - offset
			warpType2 = 0x22EC9E0 - offset
			title = 0x2340DB8 - offset
			continue = 0x2E008D0 - offset
			config = 0x2E000D0 - offset
			cam = 0x507D18 - offset_2
			titlescreenpicture = 0x2EE55EC - offset
			titlescreenamvtimer = 0x2EE98D4 - offset
			cutSceneAspect = 0x4DE242 - offset
			inputAddress = 0x2ED3034 - offset
			saveOpenAddress = 0x232E904 - offset
			saveAnywhere = 0x23551D4 - offset
		else
			ConsolePrint("Steam detected")
			deathCheck = 0x29BD70
			soraHUD = 0x281407C
			soraHP = 0x2D5CC4C
			stateFlag = 0x28672C8
			whiteFade = 0x233FE1C
			blackFade = 0x4DC718
			closeMenu = 0x2E941C0
			deathPointer = 0x2382568
			warpTrigger = 0x22EC07C
			warpType1 = 0x233FBC0
			warpType2 = 0x22EC080
			title = 0x23404E8
			continue = 0x2E16B60
			config = 0x2E16360
			cam = 0x506F48
			titlescreenpicture = 0x2EE8BB8
			titlescreenamvtimer = 0x2EE8BA4
			cutSceneAspect = 0x4DD562
			inputAddress = 0x22C92D0
			saveOpenAddress = 0x232DFA4
			saveAnywhere = 0x2354854
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
	if not canExecute then
		goto done
	end

	if ReadByte(titlescreenpicture) == 0 then
		WriteByte(title, 1)
	end

	local input = ReadInt(inputAddress)
	local savemenuopen = ReadByte(saveOpenAddress)
	
	if input == 1793 and lastInput ~= 1793 and savemenuopen~=4 and ReadByte(saveAnywhere) == 0 then 
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
			WriteFloat(cam, -1.0 + ReadByte(config + 0x14) * 2)
			WriteFloat(cam + 4, 1.0 - ReadByte(config + 0x18) * 2)
		end
	end
	
	if input == 3848 and lastInput ~= 3848 then
		SoftReset()
	end
	
	-- Remove white screen on death (it bugs out this way normally)
	if removeWhite > 0 then
		removeWhite = removeWhite - 1
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
		-- WriteByte(0x2E20F28, 3) --Unlock gummi
		WriteByte(0x2E205D5, 3) --Unlock gummi
		-- WriteByte(0x2E20E9C, 5) --Set 5 buttons to save menu
		WriteByte(0x2E20549, 5) --Set 5 buttons to save menu
		-- WriteByte(0x2E93750, 5) --Set 5 buttons to save menu
		WriteByte(0x2E93750 - 0x960, 5) --Set 5 buttons to save menu
		-- WriteByte(0x2E93752, 5) --Set 5 buttons to save menu
		WriteByte(0x2E93752 - 0x960, 5) --Set 5 buttons to save menu
		for i=0,4 do
			-- WriteByte(0x2E20EA0 + i * 4, i) --Set button types
			WriteByte(0x2E2054D + i * 4, i) --Set button types
		end
	end
	
	addgummi = addgummi > 0 and addgummi-1 or addgummi
	
	lastInput = input
	lastDeathPointer = ReadLong(deathPointer)
	
	-- For boss rush comment this if block out as it writes to the auto save files as well
	if ReadFloat(soraHUD) == 1 and prevHUD < 1  and not bossRush then
		local f = io.open("autosave.dat", "wb")
		f:write(ReadString(continue, 0x16C00))
		f:close()
		ConsolePrint("Wrote autosave")
	end
	prevHUD = ReadFloat(soraHUD)

	::done::
end
