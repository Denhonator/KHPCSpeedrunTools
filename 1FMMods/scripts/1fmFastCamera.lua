LUAGUI_NAME = "1fmFastCamera"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Speeds up camera movement and camera centering"

local centerSpeed = 2
local overallSpeed = 1.2
local accelerationSpeed = 0.001
local accelerationSpeedV = 0.0014
local deaccelerationSpeedV = -0.001
local deaccelerationSpeed = -0.0016
local canExecute = false

local posDebugString = 0x3EB158

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		if ReadByte(posDebugString) == 0x58 then
			vars = require("EpicGamesGlobal")
		elseif ReadByte(posDebugString - 0x1020) == 0x58 then
			vars = require("EpicGamesJP")
		elseif ReadByte(posDebugString - 0xE40) == 0x58 then
			vars = require("SteamGlobal") -- Global and JP equal
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute and ReadByte(vars.menu) == 0 then
		local currentSpeedH = ReadFloat(vars.curSpeedH)
		local currentSpeedV = ReadFloat(vars.curSpeedV)
		
		if ReadFloat(vars.cameraCenter) > 1 then
			WriteFloat(vars.cameraCenter, ReadFloat(vars.cameraCenter)-centerSpeed)
		end
		
		if math.abs(ReadFloat(vars.speed)) == 1.0 then -- This way it works for inverted camera
			WriteFloat(vars.speed, ReadFloat(vars.speed) * overallSpeed)
			WriteFloat(vars.speed - 4, ReadFloat(vars.speed - 4) * overallSpeed)
		end
		
		if ReadFloat(vars.curSpeedH) ~= 0 then
			if math.abs(ReadFloat(vars.cameraInputH)) > 0.05 then
				maxH = math.max(vars.currentSpeedH + ReadFloat(vars.cameraInputH) * accelerationSpeed, -0.44)
				WriteFloat(vars.curSpeedH, math.min(maxH, 0.44))
			else
				WriteFloat(vars.curSpeedH, vars.currentSpeedH * (1.0 - deaccelerationSpeed * 10))
			end
		end
		if ReadFloat(vars.curSpeedV) ~= 0 then
			if math.abs(ReadFloat(vars.cameraInputV)) > 0.05 then
				maxV = math.max(vars.currentSpeedV - ReadFloat(vars.cameraInputV) * accelerationSpeedV, -0.44)
				WriteFloat(vars.curSpeedV, math.min(maxV, 0.44))
			else
				WriteFloat(vars.curSpeedV, vars.currentSpeedV * (1.0 - deaccelerationSpeedV * 10))
			end
		end
	end
end