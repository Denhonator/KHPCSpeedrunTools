LUAGUI_NAME = "EnemyRando"
LUAGUI_AUTH = "denhonator"
LUAGUI_DESC = "Randomizes enemies"

local offset = 0x3A0606
local world = 0x233CADC - offset
local room = world + 0x68
local blackfade = 0x4D93B8 - offset
local cutsceneFlags = 0x2DE65D0-0x200 - offset
local monitor = 0
local lastMonitor = 0
local hasChanged = false
local lastAddr = 0
local replaced = false

local normal = {"xa_ew_2010", "xa_ew_2020", "xa_ew_2030", "xa_ew_2050",
				"xa_ex_2010", "xa_ex_2020", "xa_ex_2030", "xa_ex_2040",
				"xa_ex_2050", "xa_ex_2060", "xa_ex_2070", "xa_ex_2080", "xa_ex_2090",
				"xa_ex_2100", "xa_ex_2110", "xa_ex_2120", "xa_ex_2130", "xa_ex_2140",
				"xa_ex_2150", "xa_ex_2160", "xa_ex_2170", "xa_ex_2180",
				"xa_ex_2190", "xa_ex_2200", "xa_ex_2210",
				"xa_ex_2220", "xa_ex_2230", "xa_ex_2240",
				"xa_ex_2250", "xa_ex_2270", "xa_ex_2280",
				"xa_ex_2290", "xa_ex_2320", "xa_ex_2330",
				"xa_ex_2340", "xa_ex_2350", "xa_ex_2380",
				"xa_ex_2390", "xa_pp_3020"}
				
local boss = {"xa_he_3020", "xa_di_3000", "xa_ew_3020", "xa_al_3010",
			  "xa_al_3020", "xa_al_3050", "xa_ex_1090", "xa_ex_1160", "xa_ex_1580",
			  "xa_ex_1630", "xa_ex_2310", "xa_he_1010", "xa_he_3000", "xa_pc_3000",
			  "xa_pi_3000", "xa_pp_3000", "xa_pp_3030", "xa_tz_3000", "xa_tz_3010"}
			  
local trick = {"xa_he_3020", "xa_ex_2310", "xa_he_3000", "xa_pi_3000"}
				
local addrs = {}
				
local bosses = {}

local repl = {}

local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("KH1 detected, running script")
		canExecute = true
		AddAddrs()
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function AddAddrs()
	for i=1,0x10 do
		addrs[i] = {}
	end
	--addrs[3][0xAC0980-offset] = normal[math.random(#normal)] --2nd district yellow
	addrs[3][0xAC0940-offset] = normal[math.random(#normal)] --2nd district blue
	addrs[3][0xAC0900-offset] = normal[math.random(#normal)] --2nd district red
	addrs[3][0xAC0800-offset] = normal[math.random(#normal)] --2nd district shadow
	--addrs[3][0xAC0840-offset] = normal[math.random(#normal)] --2nd district soldier
	addrs[3][0xA97840-offset] = normal[math.random(#normal)] --alleyway shadow
	addrs[3][0xA97800-offset] = normal[math.random(#normal)] --alleyway soldier
	addrs[3][0xB16D80-offset] = normal[math.random(#normal)] --1st district shadow
	addrs[3][0xB0AC00-offset] = normal[math.random(#normal)] --3rd district shadow
	addrs[3][0xB0ABC0-offset] = normal[math.random(#normal)] --3rd district soldier
	--addrs[5][0xA20480-offset] = boss[math.random(#boss)] --treehouse sabor
	addrs[5][0x9F4600-offset] = normal[math.random(#normal)] --camp powerwild
	addrs[5][0x9E3820-offset] = normal[math.random(#normal)] --climbing trees powerwild
	addrs[5][0xA20400-offset] = normal[math.random(#normal)] --treehouse powerwild
	addrs[5][0x992F00-offset] = normal[math.random(#normal)] --cliffs powerwild
	addrs[5][0xA8CF80-offset] = normal[math.random(#normal)] --bamboo powerwild
	--addrs[5][0xA8D0C0-offset] = boss[math.random(#boss)] --bamboo sabor
	--addrs[5][0x992F40-offset] = boss[math.random(#boss)] --cliff clayton
	--addrs[5][0x992F80-offset] = boss[math.random(#boss)] --cliff clayton & stealth sneak
	--addrs[4][0x851EC0-offset] = normal[math.random(#normal)] --rabbithole shadow
	--addrs[4][0x8E0E40-offset] = normal[math.random(#normal)] --lotus forest soldier
	addrs[4][0x9F8100-offset] = trick[math.random(#trick)] --trickmaster
end

function WriteString(addr, s)
	for i=0,#s-1 do
		WriteByte(addr+i, string.byte(s, i+1), false)
	end
end

function Exceptions(addr)
	if ReadByte(cutsceneFlags+0xB05) >= 0x49 and addr == 0x992F00-offset then
		return true
	end
	return ReadByte(addr) ~= 120 or ReadByte(addr+1) ~= 97 or input == 8
end

function _OnFrame()
	local input = ReadInt(0x233D034-offset)
	local w = ReadByte(world)
	
	if canExecute and ReadInt(blackfade) == 0 and w > 0 then
		for addr, v in pairs(addrs[w]) do
			if not Exceptions(addr) then
				WriteString(addr, v)
				if addr == 0xB0ABC0-offset then
					WriteString(addr+0xC0, v)
				else
					WriteString(addr+0x20, v)
				end
				ConsolePrint(string.format("Replaced with %s at %x", v, addr+offset))
			end
		end
	end
end