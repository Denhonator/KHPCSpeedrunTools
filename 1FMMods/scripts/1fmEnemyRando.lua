LUAGUI_NAME = "EnemyRando"
LUAGUI_AUTH = "denhonator"
LUAGUI_DESC = "Randomizes enemies"

local offset = 0x3A0606
local world = 0x233CADC - offset
local room = world + 0x68
local blackfade = 0x4D93B8 - offset
local whitefade = 0x233C49C - offset
local cutsceneFlags = 0x2DE65D0-0x200 - offset
local hercBossY = 0x2D34BF4 - offset
local ardOff = 0x2394BB0 - offset
local bossHP = 0x2D595CC - offset
local state = 0x2863958 - offset
local monitor = 0
local lastMonitor = 0
local hasChanged = false
local lastAddr = 0
local replaced = false
local lastBlack = 0
local endfightTimer = 0

local normal = {"xa_ew_2010", "xa_ew_2020", "xa_ew_2030",
				"xa_ex_2010", "xa_ex_2020", "xa_ex_2030", "xa_ex_2040",
				"xa_ex_2050", "xa_ex_2060", "xa_ex_2070", "xa_ex_2080", "xa_ex_2090",
				"xa_ex_2100", "xa_ex_2110", "xa_ex_2120", "xa_ex_2130", "xa_ex_2140",
				"xa_ex_2150", "xa_ex_2160", "xa_ex_2170", "xa_ex_2180",
				"xa_ex_2190", "xa_ex_2200", "xa_ex_2210",
				"xa_ex_2220", "xa_ex_2230",
				"xa_ex_2250", "xa_ex_2270", "xa_ex_2280",
				"xa_ex_2290", "xa_ex_2320", "xa_ex_2330",
				"xa_ex_2340", "xa_ex_2380",
				"xa_ex_2390", "xa_pp_3020"}
				
local lite = {"xa_ew_2010", "xa_ew_2020", "xa_ew_2030", "xa_ew_2050",
				"xa_ex_2010", "xa_ex_2020", "xa_ex_2030", "xa_ex_2040",
				"xa_ex_2050", "xa_ex_2060", "xa_ex_2070", "xa_ex_2080", "xa_ex_2090",
				"xa_ex_2100", "xa_ex_2110", "xa_ex_2120", "xa_ex_2130", "xa_ex_2140",
				"xa_ex_2160", "xa_ex_2170", "xa_ex_2180",
				"xa_ex_2190", "xa_ex_2200", "xa_ex_2210",
				"xa_ex_2220", "xa_ex_2230", "xa_ex_2240",
				"xa_ex_2250", "xa_ex_2270", "xa_ex_2280",
				"xa_ex_2290", "xa_ex_2320", "xa_ex_2330",
				"xa_ex_2340", "xa_ex_2350", "xa_ex_2380",
				"xa_ex_2390", "xa_pp_3020"}
				
local bandit = {"xa_ew_2010", "xa_ew_2020", "xa_ew_2030", "xa_ew_2050",
				"xa_ex_2010", "xa_ex_2020", "xa_ex_2030", "xa_ex_2040",
				"xa_ex_2050", "xa_ex_2060", "xa_ex_2070", "xa_ex_2080", "xa_ex_2090",
				"xa_ex_2150", "xa_ex_2160", "xa_ex_2170", "xa_ex_2180",
				"xa_ex_2190", "xa_ex_2200", "xa_ex_2210",
				"xa_ex_2220", "xa_ex_2230",
				"xa_ex_2250", "xa_ex_2270", "xa_ex_2280",
				"xa_ex_2290", "xa_ex_2320", "xa_ex_2330",
				"xa_ex_2340", "xa_ex_2380",
				"xa_ex_2390", "xa_pp_3020"}
				
local boss = {"xa_he_3020", "xa_di_3000", "xa_ew_3020", "xa_al_3010", "xa_nm_3000",
			  "xa_al_3050", "xa_ex_1580", "xa_ex_1160", "xa_ex_1150", "xa_ex_1030",
			  "xa_ex_1630", "xa_ex_2310", "xa_he_1010", "xa_he_3000", "xa_pc_3000",
			  "xa_pi_3000", "xa_pp_3000", "xa_pp_3030", "xa_tz_3010", "xa_ex_1040",
			  "xa_ex_3000", "xa_pc_3020", "xa_tz_3020"}
			  
local jafar = {"xa_di_3000", "xa_nm_3000",
			  "xa_ex_1160", "xa_ex_1150", "xa_ex_1030",
			  "xa_pc_3000", "xa_he_1030",
			  "xa_pi_3000", "xa_pp_3000", "xa_ex_1040"}
  
local trick = {"xa_he_3020", "xa_ex_2310", "xa_he_3000", "xa_pi_3000", "xa_nm_3000"}
local test = {"xa_nm_3000"}
				
local addrs = {}

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
	--addrs[3][0xB0ACA0-offset] = test[math.random(#test)] --guard armor
	--addrs[5][0xA20480-offset] = boss[math.random(#boss)] --treehouse sabor
	addrs[5][0x9F4600-offset] = normal[math.random(#normal)] --camp powerwild
	addrs[5][0x9E3820-offset] = normal[math.random(#normal)] --climbing trees powerwild
	addrs[5][0xA20400-offset] = normal[math.random(#normal)] --treehouse powerwild
	addrs[5][0x992F00-offset] = normal[math.random(#normal)] --cliffs powerwild
	addrs[5][0xA8CF80-offset] = lite[math.random(#lite)] --bamboo powerwild
	--addrs[5][0xA8D0C0-offset] = boss[math.random(#boss)] --bamboo sabor
	--addrs[5][0x992F40-offset] = boss[math.random(#boss)] --cliff clayton
	--addrs[5][0x992F80-offset] = test[math.random(#test)] --cliff clayton & stealth sneak
	--addrs[4][0x851EC0-offset] = normal[math.random(#normal)] --rabbithole shadow
	--addrs[4][0x8E0E40-offset] = normal[math.random(#normal)] --lotus forest soldier
	addrs[4][0x9F8100-offset] = trick[math.random(#trick)] --trickmaster
	--addrs[11][0xAD05C0-offset] = normal[math.random(#normal)] --oc shadow
	addrs[11][0xAD0540-offset] = boss[math.random(#boss)] --oc cloud
	addrs[11][0xAD0800-offset] = test[math.random(#test)] --oc herc
	--addrs[11][0xAD08A0-offset] = cerb[math.random(#cerb)] --oc cerb
	addrs[11][0xAD0580-offset] = normal[math.random(#normal)] --oc soldier
	--addrs[11][0xAD0600-offset] = normal[math.random(#normal)] --oc large body
	--addrs[11][0xAD0640-offset] = normal[math.random(#normal)] --oc red
	--addrs[11][0xAD0680-offset] = normal[math.random(#normal)] --oc blue
	--addrs[11][0xAD06C0-offset] = normal[math.random(#normal)] --oc blue
	addrs[8][0x95C2C0-offset] = normal[math.random(#normal)] --alley bandit
	addrs[8][0x953940-offset] = normal[math.random(#normal)] --mainstreet bandit
	addrs[8][0xA826C0-offset] = normal[math.random(#normal)] --plaza bandit
	addrs[8][0x9E0180-offset] = normal[math.random(#normal)] --desert: cave bandit
	addrs[8][0x91ABC0-offset] = normal[math.random(#normal)] --bazaar bandit
	--addrs[8][0x9C4440-offset] = test[math.random(#test)] --pot cent 1
	--addrs[8][0x9C4480-offset] = test[math.random(#test)] --pot cent 2
	--addrs[8][0x9C43C0-offset] = test[math.random(#test)] --pot cent pot spider
	--addrs[8][0x9C44C0-offset] = test[math.random(#test)] --pot cent pot spider
	--addrs[8][0x9E0240-offset] = test[math.random(#test)] --tiger head
	addrs[8][0x9B32C0-offset] = normal[math.random(#normal)] --cave entrance bandit
	addrs[8][0x9ACC40-offset] = bandit[math.random(#bandit)] --cave hall air soldier
	addrs[8][0x972C40-offset] = normal[math.random(#normal)] --bottomless shadow
	addrs[8][0x97BBC0-offset] = jafar[math.random(#jafar)] --jafar
end

function WriteString(addr, s)
	for i=0,#s-1 do
		WriteByte(addr+i, string.byte(s, i+1), false)
	end
end

function Exceptions(addr)
	local input = ReadInt(0x233D034-offset)
	if input == 8 then
		return true
	end
	if ReadByte(cutsceneFlags+0xB05) >= 0x49 and addr == 0x992F00-offset then
		return true
	end
	return ReadByte(addr) ~= 120 or ReadByte(addr+1) ~= 97
end

function Fixes()
	local addr = 0xAD0800-offset
	--ConsolePrint(string.format("%x", ReadLong(addr)))
	if ReadByte(addr) == 120 and ReadByte(addr+1) == 97
	and ReadByte(addr+4) == 0x77 and ReadByte(addr+6) == 51
	and ReadByte(addr+8) == 50 and ReadFloat(hercBossY) == -20 then
		WriteFloat(hercBossY, 1200)
	end
	if ReadByte(addr) == 120 and ReadByte(addr+1) == 97
	and ReadByte(addr+4) == 99 and ReadByte(addr+6) == 51
	and ReadByte(addr+8) == 50 and ReadFloat(hercBossY) == -20 then
		WriteFloat(hercBossY, 900)
	end
	
	if ReadByte(world) == 8 and ReadByte(room) == 0x10 then
		if ReadByte(cutsceneFlags+0xB08) == 0x46 and ReadByte(ardOff) < 0xC8 and
			ReadInt(bossHP) == 0 and ReadByte(state) & 1 == 1 then
			endfightTimer = endfightTimer + 1
		else
			endfightTimer = 0
		end
		if endfightTimer > 300 then
			WriteByte(ardOff, 0xC8)
			ConsolePrint("Cutscene started")
		elseif ReadByte(ardOff) == 0xF2 then
			WriteByte(ardOff, 0xF3)
			ConsolePrint("Give magic")
		end
	end
end

function _OnFrame()
	local w = ReadByte(world)
	
	if canExecute and ReadInt(blackfade) == 0 and w > 0 then
		local logfile = io.open("enemyrandolog.txt", "w+")
		for addr, v in pairs(addrs[w]) do
			if not Exceptions(addr) then
				WriteString(addr, v)
				if addr == 0xB0ABC0-offset then
					WriteString(addr+0xC0, v)
				else
					WriteString(addr+0x20, v)
				end
				ConsolePrint(string.format("Replaced with %s at %x", v, addr+offset))
				logfile:write(string.format("Replaced with %s at %x\n", v, addr+offset))
			end
		end
		logfile:close()
		lastBlack = ReadInt(blackfade)
	end
	Fixes()
end