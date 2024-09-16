LUAGUI_NAME = "EnemyRando"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Randomizes enemies"

local counter = 0
local fallcounter = 0
local bossLastHP = {0, 0, 0, 0, 0}
local endfightTimer = 0
local antisorabeaten = false

local addrs = {}

local used = {}

local canExecute = false
local posDebugString = 0x3EB1C8

local function Djb2(str)
	hash = 5381

	for c in string.gmatch(str, '.') do
		hash = ((hash << 5) + hash) + string.byte(c)
	end

	return hash
end

local function PickRandom(t)
	local s = ""
	for _=1, 10 do
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

local function AddAddrs()
	for i=0, 32 do
		addrs[i + 1] = {}
	end
	-- addrs[3][enemyAddresses[82]] = PickRandom(normal) -- 2nd district yellow
	-- addrs[3][enemyAddresses[81]] = PickRandom(normal) -- 2nd district blue
	-- addrs[3][enemyAddresses[80]] = PickRandom(normal) -- 2nd district red
	addrs[3][enemyAddresses[78]] = PickRandom(lite) -- 2nd district shadow
	addrs[3][enemyAddresses[97]] = PickRandom(leon) -- tt leon
	-- addrs[3][enemyAddresses[79]] = PickRandom(normal) -- 2nd district soldier
	addrs[3][enemyAddresses[77]] = PickRandom(lite) -- alleyway shadow
	addrs[3][enemyAddresses[76]] = PickRandom(lite) -- alleyway soldier
	addrs[3][enemyAddresses[96]] = PickRandom(normal) -- 1st district shadow
	addrs[3][enemyAddresses[94]] = PickRandom(normal) -- 3rd district shadow
	addrs[3][enemyAddresses[93]] = PickRandom(lite) -- 3rd district soldier
	addrs[3][enemyAddresses[48]] = PickRandom(normal) -- gizmo shadow
	-- addrs[3][enemyAddresses[95]] = test[math.random(#test)] -- guard armor
	-- addrs[5][enemyAddresses[67]] = boss[math.random(#boss)] -- treehouse sabor
	addrs[5][enemyAddresses[61]] = PickRandom(powerwild) -- camp powerwild
	addrs[5][enemyAddresses[59]] = PickRandom(powerwild) -- climbing trees powerwild
	addrs[5][enemyAddresses[66]] = PickRandom(lite) -- treehouse powerwild
	addrs[5][enemyAddresses[30]] = PickRandom(powerwild) -- cliffs powerwild
	addrs[5][enemyAddresses[74]] = PickRandom(lite) -- bamboo powerwild
	addrs[5][enemyAddresses[75]] = PickRandom(sabor) -- bamboo sabor
	-- addrs[5][enemyAddresses[31]] = boss[math.random(#boss)] -- cliff clayton
	-- addrs[5][enemyAddresses[32]] = test[math.random(#test)] -- cliff clayton & stealth sneak
	-- addrs[4][enemyAddresses[3]] = PickRandom(normal) -- rabbithole shadow
	-- addrs[4][enemyAddresses[10]] = PickRandom(normal) -- lotus forest soldier
	addrs[4][enemyAddresses[62]] = PickRandom(trick) -- trickmaster
	-- addrs[11][enemyAddresses[85]] = PickRandom(normal) -- oc shadow
	addrs[11][enemyAddresses[83]] = PickRandom(cloud) -- oc cloud
	addrs[11][enemyAddresses[90]] = PickRandom(herc) -- oc herc
	addrs[11][enemyAddresses[20]] = PickRandom(duo) -- oc leon
	addrs[11][enemyAddresses[21]] = PickRandom(duo) -- oc yuffie
	-- addrs[11][enemyAddresses[91]] = cerb[math.random(#cerb)] -- oc cerb
	-- addrs[11][enemyAddresses[84]] = PickRandom(normal) -- oc soldier
	-- addrs[11][enemyAddresses[86]] = PickRandom(normal) -- oc large body
	-- addrs[11][enemyAddresses[87]] = PickRandom(normal) -- oc red
	-- addrs[11][enemyAddresses[88]] = PickRandom(normal) -- oc blue
	-- addrs[11][enemyAddresses[89]] = PickRandom(normal) -- oc blue
	addrs[8][enemyAddresses[19]] = PickRandom(bandit) -- alley bandit
	addrs[8][enemyAddresses[16]] = PickRandom(lite) -- mainstreet bandit
	addrs[8][enemyAddresses[73]] = PickRandom(bandit) -- plaza bandit
	addrs[8][enemyAddresses[57]] = PickRandom(lite) -- desert: cave bandit
	addrs[8][enemyAddresses[12]] = PickRandom(bandit) -- bazaar bandit
	-- addrs[8][enemyAddresses[44]] = test[math.random(#test)] -- pot cent 1
	-- addrs[8][enemyAddresses[45]] = test[math.random(#test)] -- pot cent 2
	-- addrs[8][enemyAddresses[43]] = test[math.random(#test)] -- pot cent pot spider
	-- addrs[8][enemyAddresses[46]] = test[math.random(#test)] -- pot cent pot spider
	-- addrs[8][enemyAddresses[58]] = test[math.random(#test)] -- tiger head
	-- addrs[8][enemyAddresses[40]] = PickRandom(lite) -- cave entrance bandit
	-- addrs[8][enemyAddresses[39]] = PickRandom(bandit) -- cave hall air soldier
	-- addrs[8][enemyAddresses[23]] = PickRandom(lite) -- bottomless shadow
	addrs[8][enemyAddresses[24]] = PickRandom(jafar) -- jafar
	addrs[8][enemyAddresses[25]] = PickRandom(genie) -- genie
	-- addrs[8][enemyAddresses[34]] = test[math.random(#test)] -- genie jafar
	-- addrs[12][enemyAddresses[26]] = PickRandom(normal) -- chamber 1 ghost
	-- addrs[12][enemyAddresses[54]] = PickRandom(normal) -- chamber 2 airsoldier
	-- addrs[12][enemyAddresses[55]] = PickRandom(normal) -- chamber 5 ghost
	addrs[12][enemyAddresses[50]] = PickRandom(parasite) -- pc1
	addrs[12][enemyAddresses[51]] = PickRandom(pc1riku) -- pc1 riku
	-- addrs[12][enemyAddresses[49]] = test[math.random(#test)] -- pc2
	-- addrs[10][enemyAddresses[72]] = PickRandom(lite) -- square ghost
	-- addrs[10][enemyAddresses[64]] = PickRandom(lite) -- graveyard ghost
	-- addrs[10][enemyAddresses[68]] = PickRandom(normal) -- moonlight hill whight
	-- addrs[10][enemyAddresses[38]] = PickRandom(normal) -- bridge whight
	-- addrs[10][enemyAddresses[98]] = PickRandom(lite) -- manor whight
	-- addrs[10][enemyAddresses[4]] = test[math.random(#test)] -- lock
	-- addrs[10][enemyAddresses[5]] = test[math.random(#test)] -- shock
	-- addrs[10][enemyAddresses[6]] = test[math.random(#test)] -- barrel
	-- addrs[10][enemyAddresses[37]] = test[math.random(#test)] -- oogie
	-- addrs[10][enemyAddresses[36]] = test[math.random(#test)] -- oogie gargoyles
	addrs[13][enemyAddresses[33]] = PickRandom(normal) -- ship hold anti sora
	addrs[13][enemyAddresses[17]] = PickRandom(normal) -- ship hold anti sora
	addrs[13][enemyAddresses[18]] = PickRandom(normal) -- ship hold anti sora
	addrs[13][enemyAddresses[42]] = PickRandom(normal) -- ship galley anti sora
	addrs[13][enemyAddresses[35]] = PickRandom(antisora) -- anti sora
	-- addrs[13][enemyAddresses[52]] = PickRandom(normal) -- ship pirate
	addrs[13][enemyAddresses[53]] = PickRandom(hook) -- hook
	addrs[15][enemyAddresses[60]] = PickRandom(riku1) -- riku1
	addrs[15][enemyAddresses[56]] = PickRandom(normal) -- tower wyvern
	addrs[15][enemyAddresses[15]] = PickRandom(normal) -- gates wyvern
	addrs[15][enemyAddresses[14]] = PickRandom(normal) -- base level darkball
	addrs[15][enemyAddresses[99]] = PickRandom(normal) -- waterway defender
	-- addrs[15][enemyAddresses[41]] = PickRandom(normal) -- lift stop defender
	addrs[15][enemyAddresses[69]] = PickRandom(mal) -- maleficent
	addrs[15][enemyAddresses[65]] = PickRandom(dragmal) -- dragon maleficent
	addrs[15][enemyAddresses[102]] = PickRandom(riku2) -- riku2
	addrs[15][enemyAddresses[47]] = PickRandom(behe) -- HB behemoth
	addrs[16][enemyAddresses[71]] = PickRandom(normal) -- EotW Invisible
	addrs[16][enemyAddresses[70]] = PickRandom(normal) -- EotW Darkball
	addrs[16][enemyAddresses[92]] = PickRandom(normal) -- TT Terminal Soldier
	addrs[16][enemyAddresses[1]] = PickRandom(normal) -- WL Terminal Wizard
	addrs[16][enemyAddresses[7]] = PickRandom(normal) -- OC Terminal Air Soldier
	addrs[16][enemyAddresses[9]] = PickRandom(normal) -- DJ Terminal Powerwild
	addrs[16][enemyAddresses[11]] = PickRandom(normal) -- AG Terminal Bandit
	addrs[16][enemyAddresses[63]] = PickRandom(normal) -- AT Terminal Neon
	addrs[16][enemyAddresses[8]] = PickRandom(normal) -- HT Terminal Ghost
	addrs[16][enemyAddresses[13]] = PickRandom(normal) -- NL Terminal Pirate
	addrs[16][enemyAddresses[2]] = PickRandom(normal) -- HB Terminal Invisible
	addrs[16][enemyAddresses[22]] = PickRandom(chern) -- chernabog
	addrs[16][enemyAddresses[100]] = PickRandom(ansem1) -- ansem1
	addrs[17][enemyAddresses[100]] = PickRandom(ansem2) -- ansem2
	addrs[17][enemyAddresses[101]] = PickRandom(dside) -- darkside
	-- addrs[17][enemyAddresses[27]] = PickRandom(normal) -- artillery
	-- addrs[17][enemyAddresses[28]] = PickRandom(normal) -- face
	addrs[17][enemyAddresses[29]] = PickRandom(ansem3) -- ansem3
	addrs[18][enemyAddresses[29]] = PickRandom(ansem4) -- ansem3
	addrs[19][enemyAddresses[29]] = PickRandom(ansem4) -- ansem3
	addrs[20][enemyAddresses[29]] = PickRandom(ansem4) -- ansem3
	addrs[21][enemyAddresses[29]] = PickRandom(ansem3) -- ansem3


	local logfile = io.open("randofiles/enemyrandolog.txt", "w+")
	for i=0, 32 do
		for key, value in pairs(addrs[i + 1]) do
			ConsolePrint(string.format("Put %s at %x", value, key))
			logfile:write(string.format("%x : %s\n", key, value))
		end
	end
	logfile:close()
end

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		require("VersionCheck")
		importVars("Rando/enemyTables")
		if ReadByte(EGSGlobalVersion) == 106 then
			importVars("EpicGamesGlobal")
		elseif ReadByte(EGSJPVersion) == 106 then
			importVars("EpicGamesJP")
		elseif ReadByte(SteamGlobalVersion) == 106 then
			importVars("SteamGlobal")
		elseif ReadByte(SteamJPVersion) == 106 then
			importVars("SteamJP")
		else
			canExecute = false
			ConsolePrint("\n\n!!!!!!!! VERSION ERROR !!!!!!!!\n\nVersion check failed, check variable file version numbers against game version")
		end
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

local function RoomWarp(w, r)
	WriteByte(soraHP, ReadByte(soraHP + 4))
	WriteByte(warpType1, 5)
	WriteByte(warpType2, 10)
	WriteByte(worldWarp, w)
	WriteByte(roomWarp, r)
	WriteByte(warpTrigger, 2)
end

local function WriteString(addr, s)
	local existed = true
	for i=0, #s - 1 do
		if ReadByte(addr + i) ~= string.byte(s, i + 1) then
			existed = false
		end
		WriteByte(addr + i, string.byte(s, i + 1))
	end
	return existed
end

local function Exceptions(addr)
	local input = ReadInt(inputAddress)
	if input == 8 then
		return true
	elseif ReadByte(cutsceneFlags + 5) >= 73 and addr == enemyAddresses[30] then
		return true
	elseif addr == enemyAddresses[71] and (ReadByte(room) == 5 or ReadByte(room) == 11) then
		return true
	elseif (addr == enemyAddresses[76] and ReadByte(cutsceneFlags + 4) < 32) or
		(addr == enemyAddresses[77] and ReadByte(cutsceneFlags + 4) >= 32) then
		return true
	elseif (addr == enemyAddresses[94] and ReadByte(cutsceneFlags + 4) >= 32) or
		(addr == enemyAddresses[93] and ReadByte(cutsceneFlags + 4) < 32) then
		return true
	end
	return not (ReadByte(addr) == 120 and ReadByte(addr + 1) == 97)
end

local function BossAdjust(bossHP)
	local w = ReadByte(world)
	local r = ReadByte(room)
	local addr = {0, 0, 0, 0, 0}
	local e = {"", "", "", "", ""}
	local heightAdjust
	local hp = {0, 0, 0, 0, 0}
	local bossHPs = {bossHP, 0, 0, 0, 0}
	local str = 0
	local def = 0
	local endArd = 0
	local endtime = 300

	-- Herc cup
	if w == 11 and r == 2 and ReadInt(inTournament) == 528 then
		if ReadByte(OCseed) == 9 then
			addr[1] = bossAdjustAddresses[11]
			e[1] = addrs[11][enemyAddresses[90]]
		elseif ReadByte(OCseed) == 6 then
			addr[1] = bossAdjustAddresses[13]
			e[1] = addrs[11][enemyAddresses[83]]
		end
		heightAdjust = e[1] == "xa_ew_3020" and 1200 or 0
		heightAdjust = e[1] == "xa_pc_3020" and 900 or heightAdjust
		if heightAdjust > 0 and ReadFloat(addr[1] + 20) == -20 and ReadInt(bossHP) > 1000 then
			WriteFloat(addr[1] + 20, heightAdjust)
		end
	elseif w == 3 and r == 0 and ReadByte(cutsceneFlags + 4) == 23 then
		addr[1] = bossAdjustAddresses[21]
		e[1] = addrs[3][enemyAddresses[97]]
		hp[1] = 120
		str = 8
		def = 8
	elseif w == 4 and r == 1 and ReadByte(cutsceneFlags + 7) == 43 then
		addr[1] = bossAdjustAddresses[20]
		e[1] = addrs[4][enemyAddresses[62]]
		hp[1] = 600
		str = 9
		def = 9
		endArd = 196
	elseif w == 5 and r == 2 and ReadByte(cutsceneFlags + 5) == 63 then
		addr[1] = theonActive
		e[1] = addrs[5][enemyAddresses[75]]
		hp[1] = 180
		str = 12
		def = 11
		endArd = 340
		endtime = 500
	elseif w == 5 and r == 2 and ReadByte(cutsceneFlags + 5) == 66
				  and ReadShort(ardOff) == 386 and ReadByte(inCutscene) == 3 then
		WriteShort(ardOff, 387)
		ConsolePrint("Progress cutscene")
	elseif w == 8 and r == 16 and ReadByte(cutsceneFlags + 8) == 70 then
		addr[1] = bossAdjustAddresses[14]
		addr[2] = bossAdjustAddresses[15]
		e[1] = addrs[8][enemyAddresses[24]]
		e[2] = addrs[8][enemyAddresses[25]]
		hp[1] = 500
		hp[2] = 500
		bossHPs[2] = bossHPs[1] + 256
		str = 17
		def = 15
		endArd = 200
	elseif w == 8 and r == 16 and  ReadByte(ardOff) == 242 then
		WriteByte(ardOff, 243)
	elseif w == 12 and r == 4 and ReadByte(cutsceneFlags + 9) == 43 then
		addr[1] = khamaActive
		e[1] = addrs[12][enemyAddresses[51]]
		hp[1] = 600
		str =   20
		def = 17
		endArd = 84
	elseif w == 13 and r == 6 and ReadByte(cutsceneFlags + 13) == 50 then
		addr[1] = bossAdjustAddresses[16]
		e[1] = addrs[13][enemyAddresses[35]]
		hp[1] = 750
		str = 27
		def = 21
		endArd = 66
		if antisorabeaten and ReadByte(ardOff) == 140 then
			WriteByte(ardOff, 195)
			ConsolePrint("Cutscene start")
			antisorabeaten = false
		end
	elseif w == 13 and r == 8 and (ReadByte(cutsceneFlags + 13) == 80 or ReadByte(cutsceneFlags + 13) == 83)
				   and (ReadShort(ardOff) == 877 or ReadShort(ardOff) == 979) then
		addr[1] = bossAdjustAddresses[19]
		e[1] = addrs[13][enemyAddresses[53]]
		hp[1] = 900
		str = 27
		def = 21
		endArd = 905
		if ReadShort(ardOff) == 979 then
			WriteByte(ardOff, 980)
			ConsolePrint("Give reward")
		end
	elseif w == 15 and r == 4 and ReadByte(cutsceneFlags + 14) == 40 then
		addr[1] = bossAdjustAddresses[22]
		e[1] = addrs[15][enemyAddresses[60]]
		hp[1] = 500
		str = 31
		def = 24
		endArd = 87
		endtime = 200
	elseif w == 15 and r == 11 and ReadByte(cutsceneFlags + 14) == 80 then
		addr[1] = theonActive
		e[1] = addrs[15][enemyAddresses[69]]
		hp[1] = 900
		str = 31
		def = 24
		endArd = 55
	elseif w == 15 and r == 12 and ReadByte(cutsceneFlags + 14) == 60 then
		addr[1] = bossAdjustAddresses[12]
		e[1] = addrs[15][enemyAddresses[65]]
		hp[1] = 1200
		str = 31
		def = 24
		endArd = 80
		if ReadShort(addr[1] + 1200) == 32768 then
			ConsolePrint("Disabling collision")
			for i=1, 45 do -- disable collision
				WriteShort(addr[1] + 1200 * i, 0)
			end
		end
		heightAdjust = e[1] == "xa_ew_3020" and 1200 or 0
		heightAdjust = e[1] == "xa_pc_3020" and 900 or heightAdjust
		if heightAdjust > 0 and ReadFloat(addr[1] + 20) == 0 then
			WriteFloat(addr[1] + 20, heightAdjust)
			WriteInt(bittestRender, 4194304)
		end
	elseif w == 15 and r == 14 and ReadByte(cutsceneFlags + 14) == 110
				   and ReadShort(ardOff) == 103 then
		addr[1] = bossAdjustAddresses[17]
		e[1] = addrs[15][enemyAddresses[102]]
		hp[1] = 900
		bossHPs[1] = bossAdjustAddresses[23]
		str = 31
		def = 24
		endArd = 104
	elseif w == 15 and r == 15 and ReadByte(cutsceneFlags + 14) == 170 then
		addr[1] = khamaActive
		e[1] = addrs[15][enemyAddresses[47]]
		hp[1] = 1350
		str = 35
		def = 27
		endArd = 75
		if ReadShort(addr[1] + 1200) == 32768 then
			ConsolePrint("Disabling collision")
			for i=1, 24 do -- disable collision
				WriteShort(addr[1] + 1200 * i, 0)
			end
		end
	elseif w == 16 and r == 26 then
		addr[1] = khamaActive
		e[1] = addrs[16][enemyAddresses[22]]
		hp[1] = 1500
		str = 35
		def = 27
		endArd = 88
		if ReadShort(addr[1] + 1200) == 32768 then
			ConsolePrint("Disabling collision")
			for i=1, 15 do -- disable collision
				WriteShort(addr[1] + 1200 * i, 0)
			end
			WriteFloat(glideBarrier, 2000)
			for i=0, 3 do
				WriteByte(floorStatus + i * 12, 0)
			end
		end
		if ReadByte(wall) == 24 then
			WriteByte(wall, 25)
		end
		if ReadByte(addr[1] + 112) == 2 then
			fallcounter = fallcounter + 1
			if fallcounter > 120 then
				fallcounter = 0
				WriteByte(addr[1] + 112, 0)
			end
		end
	elseif w == 16 and r == 30 and ReadShort(ardOff) >= 213 then
		if ReadShort(ardOff) == 213 and ReadByte(cutsceneFlags + 15) == 100 then
			addr[1] = bossAdjustAddresses[18]
			e[1] = addrs[16][enemyAddresses[100]]
			endArd = 214
			heightAdjust = e[1] == "xa_ew_3020" and 1200 or 0
			heightAdjust = e[1] == "xa_pc_3020" and 950 or heightAdjust
			if heightAdjust > 0 and ReadFloat(addr[1] + 20) == -160 then
				WriteFloat(addr[1] + 20, heightAdjust)
				WriteFloat(addr[1] + 16, 200)
				WriteInt(bittestRender, 1873)
			end
		elseif ReadShort(ardOff) == 252 then
			addr[1] = bossAdjustAddresses[16]
			e[1] = addrs[17][enemyAddresses[101]]
			bossHPs[1] = bossAdjustAddresses[24]
			endArd = 253
			endtime = 400
			if ReadShort(addr[1] + 1200) ~= 0 then
				ConsolePrint("Disabling collision")
				for i=1, 10 do -- disable collision
					WriteShort(addr[1] + 1200 * i, 0)
				end
			end
		elseif ReadShort(ardOff) == 284 then
			addr[1] = bossAdjustAddresses[20]
			bossHPs[1] = bossAdjustAddresses[23]
			e[1] = addrs[17][enemyAddresses[100]]
			endArd = 285
			endtime = 200
			heightAdjust = e[1] == "xa_ew_3020" and 1200 or 0
			heightAdjust = e[1] == "xa_pc_3020" and 900 or heightAdjust
			if heightAdjust > 0 and ReadFloat(addr[1] + 20) == 40 then
				WriteFloat(addr[1] + 20, heightAdjust)
			end
		end
		hp[1] = 1500
		str = 40
		def = 30
		if ReadShort(ardOff) >= 252 and ReadFloat(addr[1] + 16) > -1300 then
			WriteFloat(addr[1] + 16, -1400)
		end
	elseif w == 16 and r == 33 then
		endtime = 100
		if ReadByte(worldFlagBase) == 0 then
			addr[1] = bossAdjustAddresses[10]
			e[1] = addrs[17][enemyAddresses[29]]
			bossHPs[1] = soraHP
		elseif ReadByte(worldFlagBase) == 1 then
			addr[1] = theonActive
			e[1] = addrs[18][enemyAddresses[29]]
			bossHPs[1] = bossAdjustAddresses[26]
		elseif ReadByte(worldFlagBase) == 2 then
			addr[1] = bossAdjustAddresses[9]
			e[1] = addrs[19][enemyAddresses[29]]
			bossHPs[1] = bossAdjustAddresses[23]
		elseif ReadByte(worldFlagBase) == 3 then
			addr[1] = bossAdjustAddresses[9]
			e[1] = addrs[20][enemyAddresses[29]]
			bossHPs[1] = bossAdjustAddresses[23]
		elseif ReadByte(worldFlagBase) == 4 then
			addr[1] = bossAdjustAddresses[8]
			e[1] = addrs[21][enemyAddresses[29]]
			bossHPs[1] = soraHP
		end
		if ReadShort(addr[1] + 4800) ~= 0 then
			ConsolePrint("Disabling collision")
			for i=1, 50 do -- disable collision
				WriteShort(addr[1] + 1200 * (i + 3), 0)
			end
		end
		for i=0, 3 do
			WriteByte(floorStatus + i * 12, 0)
		end
		if ReadByte(bossAdjustAddresses[5]) == 16 then
			for i=0, 101 do
				WriteByte(bossAdjustAddresses[5] + 20 * i, 17)
			end
			for i=0, 87 do
				WriteByte(bossAdjustAddresses[6] + 20 * i, 25)
			end
		end
		WriteFloat(bossAdjustAddresses[3], 25000)
		hp[1] = 1500
		str = 40
		def = 30
	end

	if ReadInt(bossAdjustAddresses[7]) == 20224 then
		for i=1, 5 do
			if hp[i] > 0 then
				WriteShort(bossHPs[i], 1)
			end
		end
	end

	local kills = 0
	for i=1, 5 do
		if hp[i] == 0 then
			break
		end

		if string.find(e[i], "xa_di_") or string.find(e[i], "xa_ex_1010") then
			hp[i] = hp[i] * 0.5
		elseif string.find(e[i], "xa_pp_3010") ~= nil then
			hp[i] = hp[i] * 0.3
		end

		if hp[i] > 0 and ReadShort(bossHPs[i] + 4) ~= hp[i] then
			WriteShort(bossHPs[i], hp[i])
			WriteShort(bossHPs[i] + 4, hp[i])
			WriteShort(bossHPs[i] + 16, str) -- str
			WriteShort(bossHPs[i] + 20, def) -- def
		end

		if hp[i] > 0 and ReadInt(bossHPs[i]) == 0 and ReadByte(stateFlag) & 1 == 1 then
			kills = kills + 1
		end

		if ReadByte(combo) > 4 and string.find(e[i], "xa_di_1") ~= nil
							   and ReadShort(bossHPs[i]) < bossLastHP[i] then
			WriteFloat(addr[i] + 652, 0)
		end
		bossLastHP[i] = ReadShort(bossHPs[i])
	end
	if kills > 0 then
		endfightTimer = endfightTimer + 1
		if endfightTimer > endtime then
			if w == 3 and r == 0 then
				WriteByte(cutsceneFlags + 4, 26)
				RoomWarp(3, 33)
			elseif w == 16 and r == 33 and ReadByte(worldFlagBase) < 3 then
				WriteByte(worldFlagBase + 3 + ReadByte(worldFlagBase), 13)
				RoomWarp(16, 67 + ReadByte(worldFlagBase))
			elseif w == 16 and r == 33 and ReadByte(worldFlagBase) == 3 then
				WriteByte(worldFlagBase, 4)
				RoomWarp(16, 63)
			else
				WriteByte(ardOff, endArd)
			end
			if w == 13 and r == 6 then
				antisorabeaten = true
				WriteByte(cutsceneFlags + 13, 40)
			end
			endfightTimer = 0
			ConsolePrint("Fight end")
		end
	else
		endfightTimer = 0
	end
end

local function Fixes()
	local bossHP = bossAdjustAddresses[24]
	if ReadByte(party1) == 255 and ReadByte(party1 - 1) == 255 then
		bossHP = bossAdjustAddresses[23]
	end
	if ReadByte(world) == 13 and ReadByte(room) == 8 then
		bossHP = bossAdjustAddresses[25]
	end

	-- Add Riku to PC1
	if ReadByte(world) == 12 and ReadByte(worldFlagBase - 70) == 2 then
		WriteByte(worldFlagBase - 70, 0)
	end

	BossAdjust(bossHP)

	if counter > 0 then
		counter = counter - 1
	end
end

function _OnFrame()
	local w = ReadByte(world)

	if w == 16 and ReadByte(cutsceneFlags + 15) > 100 and ReadByte(worldFlagBase) == 0 then
		w = 17
	elseif w == 16 and ReadByte(cutsceneFlags + 15) > 100 and ReadByte(worldFlagBase) == 1 then
		w = 18
	elseif w == 16 and ReadByte(cutsceneFlags + 15) > 100 and ReadByte(worldFlagBase) == 2 then
		w = 19
	elseif w == 16 and ReadByte(cutsceneFlags + 15) > 100 and ReadByte(worldFlagBase) == 3 then
		w = 20
	elseif w == 16 and ReadByte(cutsceneFlags + 15) > 100 and ReadByte(worldFlagBase) == 4 then
		w = 21
	end

	if canExecute and (ReadInt(blackFade) == 0 or ReadInt(white) == 128) and w > 0 and w ~= 255 then
		local s = ""
		for addr, v in pairs(addrs[w]) do
			if not Exceptions(addr) then
				local existed
				WriteString(addr, v)
				if addr == enemyAddresses[93] then
					existed = WriteString(addr + 192, v)
				else
					existed = WriteString(addr + 32, v)
				end
				if not existed then
					s = s .. string.format("Replaced with %s at %x\n", v, addr)
				end
			end
		end
		if s ~= "" then
			addBreakout = string.find(s, "xa_di_") ~= nil
			hpScale = string.find(s, "xa_pp_3010") ~= nil and 0.4 or 1
			hpScale = (addBreakout or string.find(s, "xa_ex_1010")) ~= nil and 0.6 or hpScale
			heightAdjust = string.find(s, "xa_ew_3020") ~= nil and 1200 or 0
			heightAdjust = string.find(s, "xa_pc_3020") ~= nil and 900 or heightAdjust
			ConsolePrint(s)
		end
	end
	Fixes()
	oldTournament = ReadInt(inTournament)
end

