local lastProg = 0
local textSpeedup = false

function _OnInit()

end

function _OnFrame()
	local textProg = ReadShort(0x232A5F4-0x3A0606)
	
	WriteFloat(0x22E8744-0x3A0606, 0) --finishes box transitions

	if textProg > lastProg and lastProg > 0 and textSpeedup then --1 frame turbo
		WriteFloat(0x233C25C-0x3A0606, 100.0)
	elseif ReadFloat(0x233C25C-0x3A0606) > 1.0 then
		WriteFloat(0x233c25c-0x3A0606, 1.0)
	end

	lastProg = textProg
end