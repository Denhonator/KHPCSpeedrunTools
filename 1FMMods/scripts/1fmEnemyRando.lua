LUAGUI_NAME = "EnemyRando"
LUAGUI_AUTH = "denhonator"
LUAGUI_DESC = "Randomizes enemies"

local offset = 0x3A0606
local world = 0x233CADC - offset
local room = world + 0x68
local blackfade = 0x4D93B8 - offset
local whitefade = 0x233C49C - offset
local cutsceneFlags = 0x2DE65D0-0x200 - offset
local worldFlagBase = 0x2DE79D0+0x6C - offset
local ardOff = 0x2394BB0 - offset
local OCard = 0x23A23B0 - offset
local OCseed = 0x2389480 - offset
local state = 0x2863958 - offset
local bittestRender = 0x232A470 - offset
local combo = 0x2DE24B4 - offset
local soraPointer = 0x2534680 - offset
local bossPointer = 0x2D338D0 - offset
local malPointer = 0x2D338A8 - offset
local warpTrigger = 0x22E86DC - offset
local warpType1 = 0x233C240 - offset
local warpType2 = 0x22E86E0 - offset
local worldWarp = 0x233CB70 - offset
local inCutscene = 0x2378B60 - offset
local roomWarp = worldWarp + 4
local counter = 0
local fallcounter = 0
local monitor = 0
local lastMonitor = 0
local hasChanged = false
local lastAddr = 0
local replaced = false
local lastBlack = 0
local bossLastHP = {0,0,0,0,0}
local endfightTimer = 0
local antisorabeaten = false

local normal = {"xa_ew_2010", "xa_ew_2020", "xa_ew_2030",
				"xa_ex_2010", "xa_ex_2020", "xa_ex_2030", "xa_ex_2040",
				"xa_ex_2050", "xa_ex_2060", "xa_ex_2070", "xa_ex_2080", "xa_ex_2090",
				"xa_ex_2100", "xa_ex_2110", "xa_ex_2120", "xa_ex_2130", "xa_ex_2140",
				"xa_ex_2150", "xa_ex_2160", "xa_ex_2170", "xa_ex_2180",
				"xa_ex_2200", "xa_ex_2210",
				"xa_ex_2220", "xa_ex_2230", "xa_ex_2250", "xa_ex_2270",
				"xa_ex_2290", "xa_ex_2320", "xa_ex_2330", "xa_ex_2340",
				"xa_pp_3020"}
				
local powerwild = {"xa_ew_2010", "xa_ew_2020",
				"xa_ex_2010", "xa_ex_2020", "xa_ex_2030", "xa_ex_2040",
				"xa_ex_2050", "xa_ex_2060", "xa_ex_2070", "xa_ex_2080", "xa_ex_2090",
				"xa_ex_2100", "xa_ex_2110", "xa_ex_2120", "xa_ex_2130", "xa_ex_2140",
				"xa_ex_2150", "xa_ex_2160", "xa_ex_2170", "xa_ex_2180",
				"xa_ex_2200", "xa_ex_2210",
				"xa_ex_2220", "xa_ex_2230", "xa_ex_2250", "xa_ex_2270",
				"xa_ex_2290", "xa_ex_2320", "xa_ex_2330", "xa_ex_2340",
				"xa_pp_3020"}
				
local lite = {"xa_ew_2010", "xa_ew_2020",
				"xa_ex_2010", "xa_ex_2020", "xa_ex_2030", "xa_ex_2040",
				"xa_ex_2060", "xa_ex_2080", "xa_ex_2090",
				"xa_ex_2100", "xa_ex_2110", "xa_ex_2120", "xa_ex_2130", "xa_ex_2140",
				"xa_ex_2160", "xa_ex_2170", "xa_ex_2180",
				"xa_ex_2200", "xa_ex_2210",
				"xa_ex_2220", "xa_ex_2240",
				"xa_ex_2250", "xa_ex_2270",
				"xa_ex_2290", "xa_ex_2320"}
				
local shadows = {"xa_ew_2010", "xa_ew_2020", "xa_ew_2030",
				"xa_ex_2010", "xa_ex_2020", "xa_ex_2030", "xa_ex_2040",
				"xa_ex_2050", "xa_ex_2060", "xa_ex_2070", "xa_ex_2080", "xa_ex_2090",
				"xa_ex_2100", "xa_ex_2110", "xa_ex_2120", "xa_ex_2130", "xa_ex_2140",
				"xa_ex_2160", "xa_ex_2170", "xa_ex_2180",
				"xa_ex_2200", "xa_ex_2210",
				"xa_ex_2220", "xa_ex_2230", "xa_ex_2240",
				"xa_ex_2250", "xa_ex_2270",
				"xa_ex_2290", "xa_ex_2320", "xa_ex_2330",
				"xa_ex_2340", "xa_ex_2350", "xa_pp_3020"}
				
local bandit = {"xa_ew_2010", "xa_ew_2020", "xa_ew_2030",
				"xa_ex_2010", "xa_ex_2020", "xa_ex_2030", "xa_ex_2040",
				"xa_ex_2050", "xa_ex_2060", "xa_ex_2070", "xa_ex_2080", "xa_ex_2090",
				"xa_ex_2150", "xa_ex_2160", "xa_ex_2170", "xa_ex_2180",
				"xa_ex_2200", "xa_ex_2210",
				"xa_ex_2220", "xa_ex_2230",
				"xa_ex_2250", "xa_ex_2270", "xa_ex_2280",
				"xa_ex_2290", "xa_ex_2320", "xa_ex_2330",
				"xa_ex_2340", "xa_ex_2380",
				"xa_ex_2390", "xa_pp_3020"}
				
local boss = {"xa_he_3020", "xa_di_3000", "xa_ew_3020", "xa_al_3010", "xa_nm_3000",
			  "xa_al_3050", "xa_ex_1580", "xa_ex_1160", "xa_ex_1150", "xa_ex_1030",
			  "xa_ex_1630", "xa_he_1010", "xa_he_3000", "xa_pc_3000",
			  "xa_pi_3000", "xa_pp_3000", "xa_pp_3030", "xa_ex_1040",
			  "xa_ex_3000", "xa_ex_3010", "xa_pc_3020", "xa_tz_3020"}
			  
local herc = {"xa_he_3020", "xa_di_3000", "xa_al_3010", "xa_nm_3000",
			  "xa_al_3050", "xa_ex_1580", "xa_ex_1160", "xa_ex_1150", "xa_ex_1030",
			  "xa_ex_1630", "xa_he_1010", "xa_he_3000", "xa_pc_3000",
			  "xa_pi_3000", "xa_pp_3000", "xa_pp_3030", "xa_ex_1040",
			  "xa_ex_3000", "xa_ex_3010", "xa_tz_3020"}
			  
local ansem1 = {"xa_he_3020", "xa_ew_3020", "xa_al_3010", "xa_nm_3000", "xa_di_1020",
			  "xa_al_3050", "xa_ex_1580", "xa_ex_1160", "xa_ex_1150", "xa_ex_1030",
			  "xa_he_1010", "xa_he_3000", "xa_pc_3000", "xa_ex_1010", "xa_di_1010",
			  "xa_pi_3000", "xa_pp_3000", "xa_pp_3030", "xa_ex_1040", "xa_di_1030",
			  "xa_ex_3010", "xa_pc_3020"}
			  
local ansem2 = {"xa_he_3020", "xa_nm_3000","xa_ex_1010", "xa_di_1010", "xa_pp_3030",
			  "xa_ex_1580", "xa_ex_1160", "xa_ex_1150", "xa_ex_1030",
			  "xa_he_1010", "xa_he_3000", "xa_pc_3000", "xa_ex_1010",
			  "xa_pi_3000", "xa_pp_3000", "xa_ex_1040", "xa_di_1020", "xa_di_1030",
			  "xa_ex_3000", "xa_ex_3010", "xa_pc_3020", "xa_pp_3010"}
			  
local ansem3 = {"xa_he_3020", "xa_nm_3000","xa_ex_1010", "xa_di_1010",
			  "xa_al_3050", "xa_ex_1580", "xa_ex_1160", "xa_ex_1150", "xa_ex_1030",
			  "xa_he_1010", "xa_he_3000", "xa_pc_3000", "xa_ex_1010",
			  "xa_pi_3000", "xa_pp_3000", "xa_ex_1040", "xa_di_1020", "xa_di_1030",
			  "xa_ex_3000", "xa_pc_3020", "xa_pp_3010"}
			  
local ansem4 = {"xa_nm_3000","xa_ex_1010", "xa_di_1010",
			  "xa_al_3050", "xa_ex_1580", "xa_ex_1160", "xa_ex_1150", "xa_ex_1030",
			  "xa_he_1010", "xa_he_3000", "xa_pc_3000", "xa_ex_1010",
			  "xa_pi_3000", "xa_pp_3000", "xa_ex_1040", "xa_di_1020", "xa_di_1030",
			  "xa_pc_3020", "xa_pp_3010"}

local cloud = {"xa_he_3020", "xa_di_3000", "xa_al_3010", "xa_nm_3000",
			  "xa_al_3050", "xa_ex_1580", "xa_ex_1160", "xa_ex_1150", "xa_ex_1030",
			  "xa_ex_1630", "xa_he_1010", "xa_he_3000", "xa_pc_3000",
			  "xa_pi_3000", "xa_pp_3000", "xa_ex_1040",
			  "xa_ex_3000", "xa_ex_3010", "xa_tz_3020"}
	  
local duo = {"xa_ex_1150", "xa_ex_1030", "xa_ex_1040", "xa_tz_3020"}
			  
local parasite = {"xa_he_1000"}
local pc1riku = {"xa_ex_1160", "xa_di_1010", "xa_di_1030", "xa_ex_1010", 
				"xa_ex_1030", "xa_ex_1040", "xa_ex_1580"}
			  
local jafar = {"xa_di_3000", "xa_nm_3000", "xa_di_1010", "xa_di_1020",
			  "xa_ex_1160", "xa_ex_1150", "xa_ex_1030", "xa_di_1030",
			  "xa_pc_3000", "xa_he_1030", "xa_ex_1010",
			  "xa_pi_3000", "xa_pp_3000", "xa_ex_1040"}
			  
local genie = {"xa_ex_1150", "xa_ex_1030", "xa_tz_3000",
			  "xa_he_1030", "xa_pi_3000", "xa_ex_1040", "xa_ex_4010",
			  "xa_ex_2310", "xa_ex_1010", "xa_di_1030", "xa_di_1020",
			  "xa_di_1010", "xa_aw_1030"}
  
local trick = {"xa_he_3020", "xa_ex_2310", "xa_he_3000", "xa_pi_3000", "xa_nm_3000",
				"xa_ew_2040", "xa_di_1010", "xa_di_1020", "xa_di_1030", "xa_al_3020"}
				
local sabor = {"xa_he_3020", "xa_he_3000", "xa_pi_3000", "xa_nm_3000", "xa_ex_1010",
				"xa_ew_2040", "xa_di_1010", "xa_di_1020", "xa_di_1030", "xa_al_3020",
				"xa_pc_3000", "xa_ex_1580", "xa_ex_1160", "xa_ex_1030", "xa_ex_1040"}
				
sabor = {"xa_tz_3000"}
				
local antisora = {"xa_pi_3000", "xa_nm_3000", "xa_di_1010", "xa_di_1020", 
					"xa_di_1030", "xa_ex_1010", "xa_ex_1160", "xa_ex_1150",
					"xa_ex_1030", "xa_ex_1040", "xa_pp_3000", "xa_ew_2040",
					"xa_al_3010", "xa_ex_1580"}
					
local hook = {"xa_pi_3000", "xa_nm_3000", "xa_di_1010", "xa_di_1020", 
				"xa_di_1030", "xa_ex_1010", "xa_ex_1160", "xa_ex_1150",
				"xa_ex_1030", "xa_ex_1040", "xa_pp_3030", "xa_ew_2040",
				"xa_al_3010", "xa_pc_3000", "xa_di_3000", "xa_al_3020",
				"xa_ew_2050", "xa_he_1010", "xa_pc_3020", "xa_tz_3000",
				"xa_pp_3010", "xa_lm_3030", "xa_ex_1580"}
				
local mal = {"xa_pi_3000", "xa_nm_3000", "xa_di_1010", "xa_di_1020", 
				"xa_di_1030", "xa_ex_1010", "xa_ex_1160", "xa_ex_1580",
				"xa_ex_1030", "xa_ex_1040", "xa_ew_2040",
				"xa_pc_3000", "xa_di_3000", "xa_he_3000",
				"xa_ew_2050", "xa_pc_3020", "xa_tz_3000",
				"xa_pp_3010", "xa_lm_3030", "xa_ex_1010"}
				
local dragmal = {"xa_ex_3010", "xa_ex_1040", "xa_ex_1580",
				"xa_he_3000", "xa_nm_3000", "xa_pp_3000", "xa_di_3000",
				"xa_di_1020", "xa_pc_3020", "xa_ex_1030", "xa_ex_1160", 
				"xa_di_1010", "xa_lm_3030", "xa_pi_3000", "xa_ex_1010",
				"xa_di_1030"}
				
local chern = {"xa_lm_3030", "xa_ex_3010", "xa_he_3000", "xa_pi_3000", 
				"xa_ex_1040", "xa_pp_3000", "xa_ex_1580", "xa_ex_1030",
				"xa_di_1010", "xa_di_1020", "xa_di_1030", "xa_ex_1010",
				"xa_ex_1160", "xa_pc_3000", "xa_he_3020", "xa_al_3010",
				"xa_ew_2040", "xa_ew_2050"}
		
local behe = {"xa_lm_3030", "xa_ew_2040", "xa_ex_2310"}
					
local lsb = {"xa_ex_2010", "xa_ex_2030", "xa_ex_2070", "xa_ex_2090", "xa_ex_2100"}

local riku1 = {"xa_ex_1010", "xa_di_1010", "xa_di_1020", "xa_di_1030",
				"xa_ex_1030", "xa_ex_1040", "xa_ex_1150", "xa_pi_3000",
				"xa_pp_3000", "xa_ew_2040", "xa_ew_2050", "xa_he_3000",
				"xa_tz_3000", "xa_ex_1580"}
				
local riku2 = {"xa_ex_1010", "xa_di_1010", "xa_di_1020", "xa_di_1030",
				"xa_ex_1030", "xa_ex_1040", "xa_ex_1150", "xa_pi_3000",
				"xa_pp_3000", "xa_ew_2040", "xa_ew_2050", "xa_he_3000",
				"xa_tz_3000", "xa_ex_1160", "xa_ex_3010", "xa_lm_3030",
				"xa_al_3010"}

local leon = {"xa_ex_1010", "xa_di_1010", "xa_di_1020", "xa_di_1030",
				"xa_ex_1160", "xa_ex_1040", "xa_pi_3000",
				"xa_pp_3000", "xa_ew_2040", "xa_ew_2050", "xa_he_3000",
				"xa_tz_3000", "xa_he_3020", "xa_lm_3030", "xa_ex_1580"}
				
local dside = {"xa_ex_1010", "xa_di_1010", "xa_di_1020", "xa_di_1030",
				"xa_ex_1040", "xa_pi_3000", "xa_ex_1580", "xa_ex_1030",
				"xa_pp_3000", "xa_ew_2040", "xa_he_3000",
				"xa_tz_3000", "xa_he_3020", "xa_lm_3030", "xa_ex_1160"}

local test = {"pc_6730.moa"}
				
local addrs = {}

local used = {}

local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("KH1 detected, running script")
		canExecute = true
		seedfile = io.open("randofiles/seed.txt", "r")
		if seedfile ~= nil then
			text = seedfile:read()
			seedstring = text
			seed = tonumber(text)
			if seed == nil then
				seed = Djb2(text)
			end
			math.randomseed(seed)
			ConsolePrint("Found existing seed")
		else
			seedfile = io.open("randofiles/seed.txt", "w")
			local newseed = os.time()
			math.randomseed(newseed)
			seedstring = string.format("%d", newseed)
			seedfile:write(newseed)
			ConsolePrint("Wrote new seed")
		end
		seedfile:close()
		AddAddrs()
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function Djb2(str)
	hash = 5381

	for c in string.gmatch(str, '.') do
		hash = ((hash << 5) + hash) + string.byte(c)
	end

	return hash
end

function RoomWarp(w, r)
	WriteByte(warpType1, 5)
	WriteByte(warpType2, 10)
	WriteByte(worldWarp, w)
	WriteByte(roomWarp, r)
	WriteByte(warpTrigger, 2)
end

function PickRandom(t)
	local s = ""
	for i=1,10 do
		local s1 = t[math.random(#t)]
		if used[s1] == nil or s == "" or used[s1] < used[s] then
			s = s1
		end
		if used[s] == nil then
			break
		end
	end
	if used[s] == nil then
		used[s] = 1
	else
		used[s] = used[s] + 1
	end
	return s
end

function AddAddrs()
	for i=1,0x21 do
		addrs[i] = {}
	end
	--addrs[3][0xAC0980-offset] = PickRandom(normal) --2nd district yellow
	--addrs[3][0xAC0940-offset] = PickRandom(normal) --2nd district blue
	--addrs[3][0xAC0900-offset] = PickRandom(normal) --2nd district red
	addrs[3][0xAC0800-offset] = PickRandom(normal) --2nd district shadow
	addrs[3][0xB17240-offset] = PickRandom(leon) --tt leon
	--addrs[3][0xAC0840-offset] = PickRandom(normal) --2nd district soldier
	addrs[3][0xA97840-offset] = PickRandom(normal) --alleyway shadow
	addrs[3][0xA97800-offset] = PickRandom(lite) --alleyway soldier
	addrs[3][0xB16D80-offset] = PickRandom(normal) --1st district shadow
	addrs[3][0xB0AC00-offset] = PickRandom(normal) --3rd district shadow
	addrs[3][0xB0ABC0-offset] = PickRandom(normal) --3rd district soldier
	addrs[3][0x9CAB80-offset] = PickRandom(normal) --gizmo shadow
	--addrs[3][0xB0ACA0-offset] = test[math.random(#test)] --guard armor
	--addrs[5][0xA20480-offset] = boss[math.random(#boss)] --treehouse sabor
	addrs[5][0x9F4600-offset] = PickRandom(powerwild) --camp powerwild
	addrs[5][0x9E3820-offset] = PickRandom(powerwild) --climbing trees powerwild
	addrs[5][0xA20400-offset] = PickRandom(lite) --treehouse powerwild
	addrs[5][0x992F00-offset] = PickRandom(powerwild) --cliffs powerwild
	addrs[5][0xA8CF80-offset] = PickRandom(lite) --bamboo powerwild
	addrs[5][0xA8D0C0-offset] = PickRandom(sabor) --bamboo sabor
	--addrs[5][0x992F40-offset] = boss[math.random(#boss)] --cliff clayton
	--addrs[5][0x992F80-offset] = test[math.random(#test)] --cliff clayton & stealth sneak
	--addrs[4][0x851EC0-offset] = PickRandom(normal) --rabbithole shadow
	--addrs[4][0x8E0E40-offset] = PickRandom(normal) --lotus forest soldier
	addrs[4][0x9F8100-offset] = PickRandom(trick) --trickmaster
	--addrs[11][0xAD05C0-offset] = PickRandom(normal) --oc shadow
	addrs[11][0xAD0540-offset] = PickRandom(cloud) --oc cloud
	addrs[11][0xAD0800-offset] = PickRandom(herc) --oc herc
	addrs[11][0x95CDC0-offset] = PickRandom(duo) --oc leon
	addrs[11][0x95CE80-offset] = PickRandom(duo) --oc yuffie
	--addrs[11][0xAD08A0-offset] = cerb[math.random(#cerb)] --oc cerb
	--addrs[11][0xAD0580-offset] = PickRandom(normal) --oc soldier
	--addrs[11][0xAD0600-offset] = PickRandom(normal) --oc large body
	--addrs[11][0xAD0640-offset] = PickRandom(normal) --oc red
	--addrs[11][0xAD0680-offset] = PickRandom(normal) --oc blue
	--addrs[11][0xAD06C0-offset] = PickRandom(normal) --oc blue
	addrs[8][0x95C2C0-offset] = PickRandom(normal) --alley bandit
	addrs[8][0x953940-offset] = PickRandom(normal) --mainstreet bandit
	addrs[8][0xA826C0-offset] = PickRandom(normal) --plaza bandit
	addrs[8][0x9E0180-offset] = PickRandom(normal) --desert: cave bandit
	addrs[8][0x91ABC0-offset] = PickRandom(normal) --bazaar bandit
	--addrs[8][0x9C4440-offset] = test[math.random(#test)] --pot cent 1
	--addrs[8][0x9C4480-offset] = test[math.random(#test)] --pot cent 2
	--addrs[8][0x9C43C0-offset] = test[math.random(#test)] --pot cent pot spider
	--addrs[8][0x9C44C0-offset] = test[math.random(#test)] --pot cent pot spider
	--addrs[8][0x9E0240-offset] = test[math.random(#test)] --tiger head
	addrs[8][0x9B32C0-offset] = PickRandom(lite) --cave entrance bandit
	addrs[8][0x9ACC40-offset] = PickRandom(bandit) --cave hall air soldier
	addrs[8][0x972C40-offset] = PickRandom(lite) --bottomless shadow
	addrs[8][0x97BBC0-offset] = PickRandom(jafar) --jafar
	addrs[8][0x97BC00-offset] = PickRandom(genie) --genie
	--addrs[8][0x99C3C0-offset] = test[math.random(#test)] --genie jafar
	--addrs[12][0x9800C0-offset] = PickRandom(normal) --chamber 1 ghost
	--addrs[12][0x9D2BC0-offset] = PickRandom(normal) --chamber 2 airsoldier
	--addrs[12][0x9D78C0-offset] = PickRandom(normal) --chamber 5 ghost
	addrs[12][0x9CF300-offset] = PickRandom(parasite) --pc1
	addrs[12][0x9CF440-offset] = PickRandom(pc1riku) --pc1 riku
	--addrs[12][0x9CB700-offset] = test[math.random(#test)] --pc2
	--addrs[10][0xA62BC0-offset] = PickRandom(lite) --square ghost
	addrs[10][0xA01FC0-offset] = PickRandom(lite) --graveyard ghost
	addrs[10][0xA22500-offset] = PickRandom(normal) --moonlight hill whight
	addrs[10][0x9A8440-offset] = PickRandom(normal) --bridge whight
	addrs[10][0xB195C0-offset] = PickRandom(lite) --manor whight
	--addrs[10][0x8A4E40-offset] = test[math.random(#test)] --lock
	--addrs[10][0x8A4E80-offset] = test[math.random(#test)] --shock
	--addrs[10][0x8A4EC0-offset] = test[math.random(#test)] --barrel
	--addrs[10][0x9A5280-offset] = test[math.random(#test)] --oogie
	--addrs[10][0x9A5200-offset] = test[math.random(#test)] --oogie gargoyles
	addrs[13][0x993B00-offset] = PickRandom(normal) --ship hold anti sora
	addrs[13][0x959A40-offset] = PickRandom(normal) --ship hold anti sora
	addrs[13][0x959C40-offset] = PickRandom(normal) --ship hold anti sora
	addrs[13][0x9C0900-offset] = PickRandom(normal) --ship galley anti sora
	addrs[13][0x9A4B20-offset] = PickRandom(antisora) --anti sora
	--addrs[13][0x9D1580-offset] = PickRandom(normal) --ship pirate
	addrs[13][0x9D18E0-offset] = PickRandom(hook) --hook
	addrs[15][0x9F33C0-offset] = PickRandom(riku1) --riku1
	addrs[15][0x9DE6A0-offset] = PickRandom(normal) --tower wyvern
	addrs[15][0x950640-offset] = PickRandom(normal) --gates wyvern
	addrs[15][0x94DD00-offset] = PickRandom(normal) --base level darkball
	addrs[15][0xB5AAC0-offset] = PickRandom(normal) --waterway defender
	--addrs[15][0x9B8AC0-offset] = PickRandom(normal) --lift stop defender
	addrs[15][0xA2AAC0-offset] = PickRandom(mal) --maleficent
	addrs[15][0xA07040-offset] = PickRandom(dragmal) --dragon maleficent
	addrs[15][0xBB0BC0-offset] = PickRandom(riku2) --riku2
	addrs[15][0x9CA840-offset] = PickRandom(behe) --HB behemoth
	addrs[16][0xA54540-offset] = PickRandom(normal) --EotW Invisible
	addrs[16][0xA48740-offset] = PickRandom(normal) --EotW Darkball
	addrs[16][0xAE5C80-offset] = PickRandom(normal) --TT Terminal Solider
	addrs[16][0x7E10C0-offset] = PickRandom(normal) --WL Terminal Wizard
	addrs[16][0x8C7100-offset] = PickRandom(normal) --OC Terminal Air Solider
	addrs[16][0x8D1100-offset] = PickRandom(normal) --DJ Terminal Powerwild
	addrs[16][0x914B40-offset] = PickRandom(normal) --AG Terminal Bandit
	addrs[16][0x9FA700-offset] = PickRandom(normal) --AT Terminal Neon
	addrs[16][0x8CF9C0-offset] = PickRandom(normal) --HT Terminal Ghost
	addrs[16][0x922D80-offset] = PickRandom(normal) --NL Terminal Pirate
	addrs[16][0x8357C0-offset] = PickRandom(normal) --HB Terminal Invisible
	addrs[16][0x96CE40-offset] = PickRandom(chern) --chernabog
	addrs[16][0xB5C240-offset] = PickRandom(ansem1) --ansem1
	addrs[17][0xB5C240-offset] = PickRandom(ansem2) --ansem2
	addrs[17][0xB5C500-offset] = PickRandom(dside) --darkside
	--addrs[17][0x988980-offset] = PickRandom(normal) --artillery
	--addrs[17][0x9889C0-offset] = PickRandom(normal) --face
	addrs[17][0x988A00-offset] = PickRandom(ansem3) --ansem3
	addrs[18][0x988A00-offset] = PickRandom(ansem4) --ansem3
	addrs[19][0x988A00-offset] = PickRandom(ansem4) --ansem3
	addrs[20][0x988A00-offset] = PickRandom(ansem4) --ansem3
	addrs[21][0x988A00-offset] = PickRandom(ansem4) --ansem3
	
	local logfile = io.open("randofiles/enemyrandolog.txt", "w+")
	for i=1,0x21 do
		for key, value in pairs(addrs[i]) do
			ConsolePrint(string.format("Put %s at %x", value, key+offset))
			logfile:write(string.format("%x : %s\n", key+offset, value))
		end
	end
	logfile:close()
end

function WriteString(addr, s)
	local existed = true
	for i=0,#s-1 do
		if ReadByte(addr+i) ~= string.byte(s, i+1) then
			existed = false
		end
		WriteByte(addr+i, string.byte(s, i+1))
	end
	return existed
end

function Exceptions(addr)
	local input = ReadInt(0x233D034-offset)
	if input == 8 then
		return true
	elseif ReadByte(cutsceneFlags+0xB05) >= 0x49 and addr == 0x992F00-offset then
		return true
	elseif addr == 0xA54540-offset and (ReadByte(room) == 5 or ReadByte(room) == 11) then
		return true
	end
	return not (ReadByte(addr) == 120 and ReadByte(addr+1) == 97)
end

function BossAdjust(bossHP)
	local w = ReadByte(world)
	local r = ReadByte(room)
	local addr = {0, 0, 0, 0, 0}
	local e = {"", "", "", "", ""}
	local heightAdjust = 0
	local hp = {0, 0, 0, 0, 0}
	local bossHPs = {bossHP, 0, 0, 0, 0}
	local str = 0
	local def = 0
	local endArd = 0
	local endtime = 300
	
	--Herc cup
	if w == 11 and r == 2 and ReadInt(OCseed-8) == 0x210 then
		if ReadInt(OCseed) == 0x0909 then
			addr[1] = 0x2D34BF4 - offset
			e[1] = addrs[11][0xAD0800-offset]
		elseif ReadInt(OCseed) == 0x0606 then
			addr[1] = 0x2D35554 - offset
			e[1] = addrs[11][0xAD0540-offset]
		end
		heightAdjust = e[1] == "xa_ew_3020" and 1200 or 0
		heightAdjust = e[1] == "xa_pc_3020" and 900 or heightAdjust
		if heightAdjust > 0 and ReadFloat(addr[1]+0x14) == -20 and ReadInt(bossHP) > 1000 then
			WriteFloat(addr[1]+0x14, heightAdjust)
		end
	elseif w == 3 and r == 0 and ReadByte(cutsceneFlags+0xB04) == 0x17 then
		addr[1] = 0x2D3EB40 - offset
		e[1] = addrs[3][0xB17240-offset]
		hp[1] = 120
		str = 8
		def = 8
	elseif w == 4 and r == 1 and ReadByte(cutsceneFlags+0xB07) == 0x2B then
		addr[1] = 0x2D3A040 - offset
		e[1] = addrs[4][0x9F8100-offset]
		hp[1] = 600
		str = 9
		def = 9
		endArd = 0xC4
	elseif w == 5 and r == 2 and ReadByte(cutsceneFlags+0xB05) == 0x3F then
		addr[1] = 0x2D35EA0 - offset
		e[1] = addrs[5][0xA8D0C0-offset]
		hp[1] = 180
		str = 0xC
		def = 0xB
		endArd = 0x154
		endtime = 500
	elseif w == 5 and r == 2 and ReadByte(cutsceneFlags+0xB05) == 0x42 
	and ReadShort(ardOff) == 0x182 and ReadByte(inCutscene) == 3 then
		WriteShort(ardOff, 0x183)
		ConsolePrint("Progress cutscene")
	elseif w == 8 and r == 0x10 and ReadByte(cutsceneFlags+0xB08) == 0x46 then
		addr[1] = 0x2D36CB0 - offset
		addr[2] = 0x2D37160 - offset
		e[1] = addrs[8][0x97BBC0-offset]
		e[2] = addrs[8][0x97BC00-offset]
		hp[1] = 500
		hp[2] = 500
		bossHPs[2] = bossHPs[1]+0x100
		str = 0x11
		def = 0xF
		endArd = 0xC8
		if ReadByte(ardOff) == 0xF2 then
			WriteByte(ardOff, 0xF3)
		end
	elseif w == 0xC and r == 4 and ReadByte(cutsceneFlags+0xB09) == 0x2B then
		addr[1] = 0x2D34730 - offset
		e[1] = addrs[12][0x9CF440-offset]
		hp[1] = 600
		str = 0x14
		def = 0x11
		endArd = 0x54
	elseif w == 0xD and r == 6 and ReadByte(cutsceneFlags+0xB0D) == 0x32 then
		addr[1] = 0x2D37610 - offset
		e[1] = addrs[13][0x9A4B20-offset]
		hp[1] = 750
		str = 0x1B
		def = 0x15
		endArd = 0x42
		if antisorabeaten and ReadByte(ardOff) == 0x8C then
			WriteByte(ardOff, 0xC3)
			ConsolePrint("Cutscene start")
			antisorabeaten = false
		end
	elseif w == 0xD and r == 8 and ReadByte(cutsceneFlags+0xB0D) == 0x50
	and ReadShort(ardOff) == 0x36D then
		addr[1] = 0x2D396E0 - offset
		e[1] = addrs[13][0x9D18E0-offset]
		hp[1] = 900
		str = 0x1B
		def = 0x15
		endArd = 0x389
		if ReadShort(ardOff) == 0x3D3 then
			WriteByte(ardOff, 0x3D4)
			ConsolePrint("Give reward")
		end
	elseif w == 0xF and r == 4 and ReadByte(cutsceneFlags+0xB0E) == 0x28 then
		addr[1] = 0x2D42830 - offset
		e[1] = addrs[15][0x9F33C0-offset]
		hp[1] = 500
		str = 0x1F
		def = 0x18
		endArd = 0x57
	elseif w == 0xF and r == 0xB and ReadByte(cutsceneFlags+0xB0E) == 0x50 then
		addr[1] = 0x2D35EA0 - offset
		e[1] = addrs[15][0xA2AAC0-offset]
		hp[1] = 900
		str = 0x1F
		def = 0x18
		endArd = 0x55
	elseif w == 0xF and r == 0xC and ReadByte(cutsceneFlags+0xB0E) == 0x5A then
		addr[1] = 0x2D35540 - offset
		e[1] = addrs[15][0xA07040-offset]
		hp[1] = 1200
		str = 0x1F
		def = 0x18
		endArd = 0x50
		if ReadShort(addr[1]+0x4B0) == 32768 then
			ConsolePrint("Disabling collision")
			for i=1,45 do --disable collision
				WriteShort(addr[1]+0x4B0*i, 0)
			end
		end
		heightAdjust = e[1] == "xa_ew_3020" and 1200 or 0
		heightAdjust = e[1] == "xa_pc_3020" and 900 or heightAdjust
		if heightAdjust > 0 and ReadFloat(addr[1]+0x14) == 0 then
			WriteFloat(addr[1]+0x14, heightAdjust)
			WriteInt(bittestRender, 0x00400000)
		end
	elseif w == 0xF and r == 0xE and ReadByte(cutsceneFlags+0xB0E) == 0x6E
	and ReadShort(ardOff) == 0x67 then
		addr[1] = 0x2D37AC0 - offset
		e[1] = addrs[15][0xBB0BC0-offset]
		hp[1] = 900
		bossHPs[1] = 0x2D593CC - offset
		str = 0x1F
		def = 0x18
		endArd = 0x68
	elseif w == 0xF and r == 0xF and ReadByte(cutsceneFlags+0xB0E) == 0xAA then
		addr[1] = 0x2D34730 - offset
		e[1] = addrs[15][0x9CA840-offset]
		hp[1] = 1350
		str = 0x23
		def = 0x1B
		endArd = 0x4B
		if ReadShort(addr[1]+0x4B0) == 32768 then
			ConsolePrint("Disabling collision")
			for i=1,24 do --disable collision
				WriteShort(addr[1]+0x4B0*i, 0)
			end
		end
	elseif w == 0x10 and r == 0x1A then
		addr[1] = 0x2D34730 - offset
		e[1] = addrs[16][0x96CE40-offset]
		hp[1] = 1500
		str = 0x23
		def = 0x1B
		endArd = 0x58
		if ReadShort(addr[1]+0x4B0) == 32768 then
			ConsolePrint("Disabling collision")
			for i=1,15 do --disable collision
				WriteShort(addr[1]+0x4B0*i, 0)
			end
			local glideBarrier = 0x503948 - offset
			local floorStatus = 0x5258FC - offset
			WriteFloat(glideBarrier, 2000)
			for i=0,3 do
				WriteByte(floorStatus+i*12, 0)
			end
		end
		local wall = 0x6D8374 - offset
		if ReadByte(wall) == 0x18 then
			WriteByte(wall, 0x19)
		end
		if ReadByte(addr[1]+0x70) == 2 then
			fallcounter = fallcounter + 1
			if fallcounter > 120 then
				fallcounter = 0
				WriteByte(addr[1]+0x70, 0)
			end
		end
	elseif w == 0x10 and r == 0x1E and ReadShort(ardOff) >= 0xD5 then
		if ReadShort(ardOff) == 0xD5 and ReadByte(cutsceneFlags+0xB0F) == 0x64 then
			addr[1] = 0x2D38D80 - offset
			e[1] = addrs[16][0xB5C240-offset]
			endArd = 0xD6
			heightAdjust = e[1] == "xa_ew_3020" and 1200 or 0
			heightAdjust = e[1] == "xa_pc_3020" and 950 or heightAdjust
			if heightAdjust > 0 and ReadFloat(addr[1]+0x14) == -160 then
				WriteFloat(addr[1]+0x14, heightAdjust)
				WriteFloat(addr[1]+0x10, 200)
				WriteInt(bittestRender, 0x751)
			end
		elseif ReadShort(ardOff) == 0xFC then
			addr[1] = 0x2D37610 - offset
			e[1] = addrs[17][0xB5C500-offset]
			bossHPs[1] = 0x2D595CC - offset
			endArd = 0xFD
			endtime = 400
			if ReadShort(addr[1]+0x4B0) ~= 0 then
				ConsolePrint("Disabling collision")
				for i=1,10 do --disable collision
					WriteShort(addr[1]+0x4B0*(i+0), 0)
				end
			end
		elseif ReadShort(ardOff) == 0x11C then
			addr[1] = 0x2D3A040 - offset
			bossHPs[1] = 0x2D593CC - offset
			e[1] = addrs[17][0xB5C240-offset]
			endArd = 0x11D
			endtime = 200
			heightAdjust = e[1] == "xa_ew_3020" and 1200 or 0
			heightAdjust = e[1] == "xa_pc_3020" and 900 or heightAdjust
			if heightAdjust > 0 and ReadFloat(addr[1]+0x14) == 40 then
				WriteFloat(addr[1]+0x14, heightAdjust)
			end
		end
		hp[1] = 1500
		str = 0x28
		def = 0x1E
		if ReadShort(ardOff) >= 0xFC and ReadFloat(addr[1]+0x10) > -1300 then
			WriteFloat(addr[1]+0x10, -1400)
		end
	elseif w == 0x10 and r == 0x21 then
		endtime = 100
		if ReadByte(worldFlagBase+0xE4) == 0 then
			addr[1] = 0x2D34280 - offset
			e[1] = addrs[17][0x988A00-offset]
			bossHPs[1] = 0x2D592CC - offset
		elseif ReadByte(worldFlagBase+0xE4) == 1 then
			addr[1] = 0x2D35EA0 - offset
			e[1] = addrs[18][0x988A00-offset]
			bossHPs[1] = 0x2D59ACC - offset
		elseif ReadByte(worldFlagBase+0xE4) == 2 then
			addr[1] = 0x2D33DD0 - offset
			e[1] = addrs[19][0x988A00-offset]
			bossHPs[1] = 0x2D593CC - offset
		elseif ReadByte(worldFlagBase+0xE4) == 3 then
			addr[1] = 0x2D33DD0 - offset
			e[1] = addrs[20][0x988A00-offset]
			bossHPs[1] = 0x2D593CC - offset
		elseif ReadByte(worldFlagBase+0xE4) == 4 then
			addr[1] = 0x2D33920 - offset
			e[1] = addrs[21][0x988A00-offset]
			bossHPs[1] = 0x2D592CC - offset
		end
		if ReadShort(addr[1]+0x4B0*4) ~= 0 then
			ConsolePrint("Disabling collision")
			for i=1,50 do --disable collision
				WriteShort(addr[1]+0x4B0*(i+3), 0)
			end
		end
		local floorStatus = 0x5258FC - offset
		for i=0,3 do
			WriteByte(floorStatus+i*12, 0)
		end
		if ReadByte(0x70944C-offset) == 0x10 then
			for i=0,101 do
				WriteByte(0x70944C+0x14*i-offset, 0x11)
			end
			for i=0,87 do
				WriteByte(0x70A004+0x14*i-offset, 0x19)
			end
		end
		WriteFloat(0x52591C-offset, 25000)
		hp[1] = 1500
		str = 0x28
		def = 0x1E
	end
	
	local kills = 0
	for i=1,5 do
		if hp[i] == 0 then
			break
		end
		
		if string.find(e[i], "xa_di_") or string.find(e[i], "xa_ex_1010") then
			hp[i] = hp[i]*0.5
		elseif string.find(e[i], "xa_pp_3010") ~= nil then
			hp[i] = hp[i]*0.3
		end
		
		if hp[i] > 0 and ReadShort(bossHPs[i]+4) ~= hp[i] then
			WriteShort(bossHPs[i], hp[i])
			WriteShort(bossHPs[i]+4, hp[i])
			WriteShort(bossHPs[i]+0x10, str) --str
			WriteShort(bossHPs[i]+0x14, def) --def
		end
		if hp[i] > 0 and ReadInt(bossHPs[i]) == 0 and ReadByte(state) & 1 == 1 then
			kills = kills+1
		end
		
		if string.find(e[i], "xa_di_1") ~= nil 
		and ReadByte(combo) > 4 and ReadShort(bossHPs[i]) < bossLastHP[i] then
			WriteFloat(addr[i]+0x28C, 0)
		end
		bossLastHP[i] = ReadShort(bossHPs[i])
	end
	if kills > 0 then
		endfightTimer = endfightTimer + 1
		if endfightTimer > endtime then
			if w == 3 and r == 0 then
				WriteByte(cutsceneFlags+0xB04, 0x1A)
				RoomWarp(3, 0x21)
			elseif w == 0x10 and r == 0x21 and ReadByte(worldFlagBase+0xE4) < 3 then
				WriteByte(worldFlagBase+0xE7+ReadByte(worldFlagBase+0xE4), 0xD)
				RoomWarp(0x10, 0x43+ReadByte(worldFlagBase+0xE4))
			elseif w == 0x10 and r == 0x21 and ReadByte(worldFlagBase+0xE4) == 3 then
				WriteByte(worldFlagBase+0xE4, 4)
				RoomWarp(0x10, 0x3F)
			else
				WriteByte(ardOff, endArd)
			end
			if w == 0xD and r == 6 then
				antisorabeaten = true
				WriteByte(cutsceneFlags+0xB0D, 0x28)
			end
			endfightTimer = 0
			ConsolePrint("Fight end")
		end
	else
		endfightTimer = 0
	end
end

function Fixes()
	local bossHP = 0x2D595CC - offset
	if ReadByte(0x2DE5E5F - offset) == 0xFF and ReadByte(0x2DE5E60 - offset) == 0xFF then
		bossHP = 0x2D593CC - offset
	end
	if ReadByte(world) == 0xD and ReadByte(room) == 8 then
		bossHP = 0x2D596CC - offset
	end
	
	--Add Riku to PC1
	if ReadByte(world) == 0xC and ReadByte(worldFlagBase+0x9E) == 2 then
		WriteByte(worldFlagBase+0x9E, 0)
	end

	BossAdjust(bossHP)

	if counter > 0 then
		counter = counter - 1
	end
end

function _OnFrame()
	local w = ReadByte(world)
	
	if w == 16 and ReadByte(cutsceneFlags+0xB0F) > 0x64 and ReadByte(worldFlagBase+0xE4) == 0 then
		w = 17
	elseif w == 16 and ReadByte(cutsceneFlags+0xB0F) > 0x64 and ReadByte(worldFlagBase+0xE4) == 1 then
		w = 18
	elseif w == 16 and ReadByte(cutsceneFlags+0xB0F) > 0x64 and ReadByte(worldFlagBase+0xE4) == 2 then
		w = 19
	elseif w == 16 and ReadByte(cutsceneFlags+0xB0F) > 0x64 and ReadByte(worldFlagBase+0xE4) == 3 then
		w = 20
	elseif w == 16 and ReadByte(cutsceneFlags+0xB0F) > 0x64 and ReadByte(worldFlagBase+0xE4) == 4 then
		w = 21
	end
	
	if canExecute and (ReadInt(blackfade) == 0 or ReadInt(whitefade) == 0x80) and w > 0 then
		local s = ""
		for addr, v in pairs(addrs[w]) do
			if not Exceptions(addr) then
				local existed = WriteString(addr, v)
				if addr == 0xB0ABC0-offset then
					existed = WriteString(addr+0xC0, v)
				else
					existed = WriteString(addr+0x20, v)
				end
				if not existed then
					s = s .. string.format("Replaced with %s at %x\n", v, addr+offset)
				end
			end
		end
		if s~="" then
			addBreakout = string.find(s, "xa_di_") ~= nil
			hpScale = string.find(s, "xa_pp_3010") ~= nil and 0.4 or 1
			hpScale = (addBreakout or string.find(s, "xa_ex_1010")) ~= nil and 0.6 or hpScale
			heightAdjust = string.find(s, "xa_ew_3020") ~= nil and 1200 or 0
			heightAdjust = string.find(s, "xa_pc_3020") ~= nil and 900 or heightAdjust
			ConsolePrint(s)
		end
		lastBlack = ReadInt(blackfade)
	end
	Fixes()
end