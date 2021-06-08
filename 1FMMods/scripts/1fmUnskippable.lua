local lastCutscene = 0
local lastSkippable = 0
local canExecute = false
local world = 0x233CADC - 0x3A0606

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		print("KH1 detected, running script")
	else
		print("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if not canExecute then
		goto done
	end
	
	local cutsceneNow = ReadInt(0x233AE74-0x3A0606)
	local skippableStatus = ReadByte(0x23944E4-0x3A0606)
	local summoning = ReadInt(0x2D5D62C-0x3A0606)
	local HUD = ReadFloat(0x280EB1C-0x3A0606)
	local blackFade = ReadByte(0x4D93B8-0x3A0606)
	if cutsceneNow > 0 and (ReadByte(world) == 4 or ReadByte(world) >= 0xF) and summoning == 0 then
		WriteByte(0x23944E4-0x3A0606, 1) --make skippable
	end
	
	lastSkippable = skippableStatus
	lastCutscene = cutsceneNow
	::done::
end