function _OnInit()
	canExecute = false
end

function CheckVersion()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then
		if ReadString(0x09A92F0,4) == 'KH2J' then --EGS
			ConsolePrint('Epic Version Detected')
			input = 0x29FAD30
			softreset = 0xABA69A
			rng = 0x753350
			spawns = 0x2AE57B8
			canExecute = true
		elseif ReadString(0x09A9830,4) == 'KH2J' or  ReadString(0x09A8830,4) == 'KH2J' then --Steam
			if ReadString(0x09A9830,4) == 'KH2J' then -- Global
				ConsolePrint('Steam Global Version Detected')
				offset = 0x0
			else -- JP
				ConsolePrint('Steam JP Version Detected')
				offset = 0x1000
			end
			input = 0xBF3120 - offset
			softreset = 0xABABDA - offset
			rng = 0x7535C0 - offset
			spawns = 0x2AE5CF8 - offset
			canExecute = true
		end
	end
end

function _OnFrame()
	if not canExecute then
		CheckVersion()
	end

	if canExecute and ReadInt(input) == 247042 then
		WriteByte(softreset, 1)
		WriteInt(rng, 0x00000001)
		WriteByte(spawns, 0)
	end
end
