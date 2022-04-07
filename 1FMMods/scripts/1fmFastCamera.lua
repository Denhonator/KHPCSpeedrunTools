LUAGUI_NAME = "1fmFastCamera"
LUAGUI_AUTH = "denhonator"
LUAGUI_DESC = "Speeds up camera movement, instant R3"

local overallSpeed = 1.4
local accelerationSpeed = 0.01

local offset = 0x3A0606
-- For some reason can't write to these addresses
local accel = 0x3E7F58 - offset
local deaccel = 0x3E7F5C - offset
local curSpeedV = 0x25344C0 - offset
local curSpeedH = 0x25344C4 - offset
local cameraInputH = 0x233D060 - offset
local cameraInputV = 0x233D064 - offset
-----
local snap = 0x1DD299 - offset
local accelHack = 0x1E2924 - offset
local deaccelHack = 0x1E291B - offset
local speed = 0x503A1C - offset

local versionCheck = 0x3D6AB8 - offset

local lastSpeedH = 0
local lastSpeedV = 0

local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" and ReadFloat(versionCheck) == 0 then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
	else
		ConsolePrint("KH1 Global not detected, not running script")
	end

	if canExecute then
		-- Enables instant camera centering
		if ReadInt(snap) == 0x0215EFBF then
			WriteInt(snap, 0x02357487)
		end
		-- Changes it to read acceleration values from elsewhere
		--WriteInt(accelHack, 0x0020563C)
		--WriteInt(deaccelHack, 0x00205645)
	end
end

function _OnFrame()
	if canExecute then
		local currentSpeedH = ReadFloat(curSpeedH)
		local currentSpeedV = ReadFloat(curSpeedV)
		local difH = currentSpeedH - lastSpeedH
		local difV = currentSpeedV - lastSpeedV
		
		if math.abs(ReadFloat(speed)) == 1.0 then -- This way it works for inverted camera
			WriteFloat(speed, ReadFloat(speed) * overallSpeed)
		end
		
		if math.abs(ReadFloat(cameraInputH)) > 0.05 then
			WriteFloat(curSpeedH, math.min(math.max(currentSpeedH + ReadFloat(cameraInputH) * accelerationSpeed, -0.44), 0.44))
		else
			WriteFloat(curSpeedH, currentSpeedH * (1.0 - accelerationSpeed * 10))
		end
		if math.abs(ReadFloat(cameraInputV)) > 0.05 then
			WriteFloat(curSpeedV, math.min(math.max(currentSpeedV + ReadFloat(cameraInputV) * accelerationSpeed, -0.44), 0.44))
		else
			WriteFloat(curSpeedV, currentSpeedV * (1.0 - accelerationSpeed * 10))
		end
		lastSpeedH = currentSpeedH
		lastSpeedV = currentSpeedV
	end
end