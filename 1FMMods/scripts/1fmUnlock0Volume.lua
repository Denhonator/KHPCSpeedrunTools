local offset = 0x3A0606
local BGM = 0x3D6ABC - offset
local BGMJP = 0x3D6A9C - offset
local minVolume = 0x14E5DB - offset
local minVolumeMaster = 0x115076 - offset
local minVolumeBGM = 0x114E88 - offset
local minVolumeSFX = 0x1153CD - offset
local minVolumeVoices = 0x115578 - offset
local minSaveVolume = 0x14E50D - offset

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		print("KH1 detected, running script")
		print("Requires LuaBackend 1.0 or higher")
		if math.abs(ReadFloat(BGM) - 0.1) < 0.01 then
			WriteFloat(BGM, 0)
			print(string.format("Set BGM setting 1 to %.1f", ReadFloat(BGM)))
		elseif math.abs(ReadFloat(BGMJP) - 0.1) < 0.01 then
			WriteFloat(BGMJP, 0)
			print(string.format("Set BGM setting 1 to %.1f", ReadFloat(BGMJP)))
		end
	else
		print("KH1 not detected, not running script")
	end
end

function _OnFrame()
	
end