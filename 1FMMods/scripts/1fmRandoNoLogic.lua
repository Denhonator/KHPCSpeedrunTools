local offset = 0x3A0606
local btltbl = 0x2D1F3C0
local itemTable = btltbl+0x1A58
local soraStatTable = btltbl+0x3AC0
local donaldStatTable = soraStatTable+0x3F8
local goofyStatTable = donaldStatTable+0x198
local soraAbilityTable = btltbl+0x3BF8
local donaldAbilityTable = soraAbilityTable+0x3F8
local goofyAbilityTable = donaldAbilityTable+0x198
local rewardTable = btltbl+0xC6A8
local chestTable = 0x5259E0

local TTWarp = 0x5229B0+0x9B570C+6
local worldWarps = 0x50B940
local worldFlagBase = 0x2DE79D0+0x6C
local gummiFlagBase = 0x2DE78C0
local worldMapLines = 0x2DE78E2

local enableRC = 0x2DE6244
local lockMenu = 0x232A60C
local party1 = 0x2DE5E5F
local party2 = 0x2E1CBE5
local soraHUD = 0x280EB1C

local gotoWorldMap = 0x2E1CC24
local openMenu = 0x2350CD4
local closeMenu = 0x2E90820
local menuCheck = 0x2E1BBBC
local input = 0x233D034

function _OnInit()

end

function InstantGummi()
	WriteByte(gotoWorldMap-offset, 1)
	WriteLong(closeMenu-offset, 0)
end

function _OnFrame()
	local TTWorld = ReadByte(TTWarp-offset)
	if TTWorld==3 then
		WriteByte(TTWarp-offset, 1) -- Change it to DI world ID
		WriteShort(worldWarps+0xE8-offset, 1) -- Add DI warp
		WriteShort(worldWarps+0xF0-offset, 0xFFFF)
		WriteByte(worldFlagBase+7-offset, 0)
	end
	
	if ReadInt(input-offset) == 3848 then
		InstantGummi()
	end
	
	if ReadFloat(soraHUD-offset) > 0 and ReadByte(lockMenu-offset) > 0 then
		WriteByte(lockMenu-offset, 0) -- Unlock menu
	end
	
	if ReadByte(gummiFlagBase-offset) ~= 3 then
		for i=0,14 do
			WriteByte(gummiFlagBase-offset+i, 3)
		end
		WriteInt(worldMapLines-offset, 0xFFFFFFFF)
		WriteByte(worldMapLines+4-offset, 0xFF)
		
		for i=0,1 do
			WriteByte(party1+i-offset, i+1)
			WriteByte(party2+i-offset, i+1)
		end
	end
	
	if ReadByte(enableRC-offset) ~= 0x0 then
		WriteByte(enableRC-offset, 0x0)
	end
end