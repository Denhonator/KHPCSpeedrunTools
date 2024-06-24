LUAGUI_NAME = "1fmFastCamera"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Speeds up camera movement and camera centering"

local centerSpeed = 2
local overallSpeed = 1.2
local overallSpeedV = 1.2
local accelerationSpeed = 0.001
local accelerationSpeedV = 0.0014
local deaccelerationSpeedV = -0.001
local deaccelerationSpeed = -0.0016
local canExecute = false
local offset = 0x0

local posDebugString = 0x3EB158

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		if ReadByte(posDebugString) == 0x58 or ReadByte(posDebugString - 0x1020) == 0x58 then
			ConsolePrint("Epic Games detected")
			if ReadByte(posDebugString) == 0x58 then
				ConsolePrint("Global version detected, no offset change needed")				
			elseif ReadByte(posDebugString) ~= 0x58 and ReadByte(posDebugString - 0x1020) == 0x58 then
				ConsolePrint("JP version detected, setting offsets")
				offset = 0x1000
			end
			curSpeedV = 0x25387D0 - offset
			curSpeedH = 0x25387D4 - offset
			cameraInputH = 0x2341360 - offset
			cameraInputV = 0x2341364 - offset
			cameraCenter = 0x2538A34 - offset
			speed = 0x507AAC - offset
			menuOpen = 0x232E900 - offset
		else
			ConsolePrint("Steam detected")
			curSpeedV = 0x25380EC
			curSpeedH = 0x25380F0
			cameraInputH = 0x23407E0
			cameraInputV = 0x23407E4
			cameraCenter = 0x2537EEC
			speed = 0x506CDC
			menuOpen = 0x232DFA0
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute and ReadByte(menuOpen) == 0 then
		local currentSpeedH = ReadFloat(curSpeedH)
		local currentSpeedV = ReadFloat(curSpeedV)
		
		if ReadFloat(cameraCenter) > 1 then
			WriteFloat(cameraCenter, ReadFloat(cameraCenter)-centerSpeed)
		end
		
		if math.abs(ReadFloat(speed)) == 1.0 then -- This way it works for inverted camera
			WriteFloat(speed, ReadFloat(speed) * overallSpeed)
			WriteFloat(speed - 4, ReadFloat(speed - 4) * overallSpeedV)
		end
		
		if ReadFloat(curSpeedH) ~= 0 then
			if math.abs(ReadFloat(cameraInputH)) > 0.05 then
				WriteFloat(curSpeedH, math.min(math.max(currentSpeedH + ReadFloat(cameraInputH) * accelerationSpeed, -0.44), 0.44))
			else
				WriteFloat(curSpeedH, currentSpeedH * (1.0 - deaccelerationSpeed * 10))
			end
		end
		if ReadFloat(curSpeedV) ~= 0 then
			if math.abs(ReadFloat(cameraInputV)) > 0.05 then
				WriteFloat(curSpeedV, math.min(math.max(currentSpeedV - ReadFloat(cameraInputV) * accelerationSpeedV, -0.44), 0.44))
			else
				WriteFloat(curSpeedV, currentSpeedV * (1.0 - deaccelerationSpeedV * 10))
			end
		end
	end
end