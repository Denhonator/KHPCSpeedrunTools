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

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
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
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute and ReadByte(menu) == 0 then
		local currentSpeedH = ReadFloat(curSpeedH)
		local currentSpeedV = ReadFloat(curSpeedV)

		if ReadFloat(cameraCenter) > 1 then
			WriteFloat(cameraCenter, ReadFloat(cameraCenter)-centerSpeed)
		end

		if math.abs(ReadFloat(speed)) == 1.0 then -- This way it works for inverted camera
			WriteFloat(speed, ReadFloat(speed) * overallSpeed)
			WriteFloat(speed - 4, ReadFloat(speed - 4) * overallSpeed)
		end

		if ReadFloat(curSpeedH) ~= 0 then
			if math.abs(ReadFloat(cameraInputH)) > 0.05 then
				maxH = math.max(currentSpeedH + ReadFloat(cameraInputH) * accelerationSpeed, -0.44)
				WriteFloat(curSpeedH, math.min(maxH, 0.44))
			else
				WriteFloat(curSpeedH, currentSpeedH * (1.0 - deaccelerationSpeed * 10))
			end
		end
		if ReadFloat(curSpeedV) ~= 0 then
			if math.abs(ReadFloat(cameraInputV)) > 0.05 then
				maxV = math.max(currentSpeedV - ReadFloat(cameraInputV) * accelerationSpeedV, -0.44)
				WriteFloat(curSpeedV, math.min(maxV, 0.44))
			else
				WriteFloat(curSpeedV, currentSpeedV * (1.0 - deaccelerationSpeedV * 10))
			end
		end
	end
end

