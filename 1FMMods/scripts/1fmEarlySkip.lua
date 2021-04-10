local lastInput = 0
local bufferPause = 0

function _OnInit()

end

function _OnFrame()
	nowInput = ReadInt(0x233D034-0x3A0606)
	if ReadInt(0x233AE74-0x3A0606)==1 then
		if bufferPause == 2 then
			WriteInt(0x22E86C8-0x3A0606, 0) --pause
			bufferPause = 0
		elseif bufferPause == 1 then
			--WriteInt(0x232A670-0x3A0606, 1787424224) --skip
			WriteInt(0x22E86C8-0x3A0606, 1) --pause
			bufferPause = 2
		elseif nowInput == 8 and lastInput == 0 and bufferPause == 0 then
			WriteInt(0x233C49C-0x3A0606, 0) --white screen off
			WriteInt(0x233C450-0x3A0606, 128) --canskip
			WriteInt(0x233C454-0x3A0606, 128) --canskip
			WriteInt(0x233C458-0x3A0606, 128) --canskip
			WriteInt(0x233C45C-0x3A0606, 128) --canskip
			WriteInt(0x233C5B8-0x3A0606, 0) --canskip
			WriteInt(0x233CAA0-0x3A0606, 0) --canskip
			WriteInt(0x233CAA4-0x3A0606, 0) --canskip
			bufferPause = 1
		end
	end
	
	lastInput = nowInput
end