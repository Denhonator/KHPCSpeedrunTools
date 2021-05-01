local lastCutscene = 0
local canExecute = false

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
	local skippableStatus = ReadInt(0x23944E4-0x3A0606)
	if cutsceneNow>0 then
		WriteInt(0x23944E4-0x3A0606, 1025) --make skippable
	elseif lastCutscene>0 and skippableStatus==1025 then
		WriteInt(0x23944E4-0x3A0606, 0) --make skippable
	end
	
	lastCutscene = cutsceneNow
	::done::
end