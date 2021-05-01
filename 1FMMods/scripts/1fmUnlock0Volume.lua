local offset = 0x3A0606
local BGM1 = 0x3D6ABC - offset
local minVolume = 0x14E5DB - offset
local minVolumeMaster = 0x115076 - offset
local minVolumeBGM = 0x114E88 - offset
local minVolumeSFX = 0x1153CD - offset
local minVolumeVoices = 0x115578 - offset
local minSaveVolume = 0x14E50D - offset

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		WriteShort(minSaveVolume, 0x9090)
		WriteShort(minVolume, 0x10EB)
		WriteShort(minVolumeMaster, 0x9090)
		WriteShort(minVolumeBGM, 0x9090)
		WriteArray(minVolumeSFX, {0x90, 0x90, 0x90, 0x90, 0x90, 0x90})
		WriteArray(minVolumeVoices, {0x90, 0x90, 0x90, 0x90, 0x90, 0x90})
		print("KH1 detected, running script")
	else
		print("KH1 not detected, not running script")
	end
end

function _OnFrame()
	
end