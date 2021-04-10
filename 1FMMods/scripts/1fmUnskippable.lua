local lastCutscene = 0

function _OnInit()

end

function _OnFrame()
	local cutsceneNow = ReadInt(0x233AE74-0x3A0606)
	local skippableStatus = ReadInt(0x23944E4-0x3A0606)
	if cutsceneNow>0 then
		WriteInt(0x23944E4-0x3A0606, 1025) --make skippable
	elseif lastCutscene>0 and skippableStatus==1025 then
		WriteInt(0x23944E4-0x3A0606, 0) --make skippable
	end
	
	lastCutscene = cutsceneNow
end