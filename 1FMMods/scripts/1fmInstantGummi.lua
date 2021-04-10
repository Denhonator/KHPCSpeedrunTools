local prevWarp = 0
local warpAdd = 0
local buf = 60
local neverlandOpen = buf
local djOpen = buf

function _OnInit()
	--if ReadByte(0x2DE78C7-0x3A0606) > 2 then
	--	neverlandOpen = 0
	--end
	--
	--if ReadByte(0x2DE78C3-0x3A0606) > 2 then
	--	djOpen = 0
	--end
end

function _OnFrame()
	local selection = ReadInt(0x503CEC-0x3A0606)
	local realSelection = selection
	local realWorld = ReadByte(0x503C04-0x3A0606)
	local soraWorld = ReadByte(0x233CADC-0x3A0606)
	local room = ReadByte(0x25346D0-0x3A0606)
	
	local monstroOpen = ReadByte(0x2DE78CA-0x3A0606) > 1
	local neverlandState = ReadByte(0x2DE78C7-0x3A0606) > 2
	local deepJungleState = ReadByte(0x2DE78C3-0x3A0606) > 2
	djOpen = (deepJungleState and djOpen>0) and djOpen-1 or djOpen
	neverlandOpen = (neverlandState and neverlandOpen>0) and neverlandOpen-1 or neverlandOpen
	if djOpen==0 and not deepJungleState then
		djOpen = buf
	end
	if neverlandOpen==0 and not neverlandState then
		neverlandOpen = buf
	end
	
	-- Deep Jungle and Neverland first visit
	warpAdd = realWorld==5 and 0x6A8640 or (0x6A8640-0x400)
	if room > 0 and realWorld > 0 and neverlandOpen==1 or djOpen==1 then
		WriteByte(warpAdd-0x3A0606, prevWarp) --room mod
		print("Reverted warp to normal")
	end
	if (realWorld==5 and djOpen>2) or ((realWorld == 13 or realWorld == 7) and neverlandOpen>2) then
		prevWarp = realWorld==5 and 14 or 0
		WriteByte(warpAdd-0x3A0606, realWorld==5 and 0 or 6) --room mod
		print(prevWarp)
	end
	
	if room > 0 and soraWorld ~= selection then
		WriteInt(0x503CEC-0x3A0606, soraWorld)
	end
	
	-- Replace HT and Atlantica with Monstro at first
	if not monstroOpen and (selection == 10 or selection == 9) then
		selection = selection == 9 and 18 or 17
		--WriteInt(0x503CEC-0x3A0606, selection)
	end
	-- Change warp to Hollow Bastion
	if selection == 25 then 
		selection = 15
		WriteInt(0x503CEC-0x3A0606, selection)
	end
	-- Change warp to Agrabah
	if selection == 21 then
		selection = 8
		WriteInt(0x503CEC-0x3A0606, selection)
	end
	
	-- Go directly to location
	local curDest = ReadInt(0x5041F0-0x3A0606)
	if curDest < 40 then
		selection = selection > 20 and 0 or selection
		WriteInt(0x5041F0-0x3A0606, selection)
		WriteInt(0x503C00-0x3A0606, selection)
		WriteInt(0x2685EEC-0x3A0606, 0)
	else
		WriteInt(0x503C00-0x3A0606, realSelection)
	end
end