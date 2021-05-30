local offset = 0x3A0606
local anims = 0x2D29DB0 - offset
local attackElement = 0x2D23F38 - offset
local soraResist = 0x2D59308 - offset
local soraPointer = 0x2534680 - offset
local soraStats = 0x2DE59D0 - offset
local donaldPointer = 0x2D33908 - offset
local goofyPointer = donaldPointer + 8
local soraHUD = 0x280EB1C - offset
local jumpHeight = 0x2D592A0 - offset
local weaponSize = 0xD2ACA0 - offset

local commandMenuP = 0x2D333D0 - offset

local music = 0x2329B80 - offset
local musicP = 0x232A590 - offset

local curse = 0x42d4d0 - offset
local musicSpeedHack = 0xA778B - offset

local room = 0x233CB44 - offset
local world = 0x233CADC - offset

local airStatuses = {0, 8, 0x18}
local validCommands = {[0x4B]=true,[0x57]=true,[0x58]=true,[0x5A]=true,
						[0x62]=true,[0x63]=true}
local musics = {0xB8}
local musicExists = {[0xB8] = true}
local animsData = {}
local commandData = {}
local lastRoom = 99
local baseSeed = 0

local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		print("KH1 detected, running script")
		canExecute = true
		for off=0,0x1FF do
			local anim = ReadArray(anims+(off*20), 20)
			if anim[1] >= 0xC8 and anim[1] < 0xDD and anim[1] ~= 0xDB then
				animsData[off+1] = anim
			end
		end
		
		for i=7, 0x1B do
			validCommands[i] = true
		end
		for i=0x1F, 0x26 do
			validCommands[i] = true
		end
		for i=0x2F, 0x34 do
			validCommands[i] = true
		end
		
		local commsA = ReadLong(commandMenuP)
		for i=0, 0x63 do
			if validCommands[i] then
				local command = ReadArrayA(commsA+(i*0x10), 0x10)
				commandData[i+1] = command
			end
		end
		
		for i=0x64, 0x9D do
			if not ((i>=0x6A and i<=0x6D) or (i>=0x71 and i<=0x73) or (i>=0x84 and i<=0x8B)
			or i==0x91 or i==0x96 or i==0x97 or i==0x9C) then
				musics[(#musics)+1] = i
				musicExists[i] = true
			end
		end
		print(#musics)
	else
		print("KH1 not detected, not running script")
	end
end

function SetSeed()
	seedfile = io.open("seed.txt", "r")
	if seedfile ~= nil then
		text = seedfile:read()
		seed = tonumber(text)
		if seed == nil then
			seed = Djb2(text)
		end
		baseSeed = seed
		print("Found existing seed")
	else
		seedfile = io.open("seed.txt", "w")
		local newseed = os.time()
		baseSeed = newseed
		seedfile:write(newseed)
		print("Wrote new seed")
	end
	seedfile:close()
end

function Randomize()
	pool = {}
	for i=1, 0x200 do
		pool[(#pool)+1] = animsData[i]
	end
	
	for i=0, 0x1FF do
		if animsData[i+1] and #pool > 0 then
			WriteByte(anims+(i*20), table.remove(pool, math.random(#pool))[1])
		end
	end
	
	for i=0, 9 do
		WriteByte(attackElement+4+(i*112), math.random(5))
	end
	
	local commsA = ReadLong(commandMenuP)
	pool = {}
	
	for i=0, 0x63 do
		if commandData[i+1] then
			pool[(#pool)+1] = commandData[i+1]
		end
	end
	
	for i=0, 0x63 do
		if commandData[i+1] then
			local command = table.remove(pool, math.random(#pool))
			WriteArrayA(commsA+(i*0x10), command)
		end
	end
	
	local r = math.random(60)*0.1
	if r > 5 or r < 0.5 then
		r = 1
	end
	for i=0, 2 do
		WriteFloat(weaponSize+(i*4), r)
	end

	r = math.random(10)*0.1 + 0.4
	for i=0, 2 do
		WriteFloatA(ReadLong(goofyPointer)+0x40+(i*4), r)
	end
	
	r = math.random(10)*0.1 + 0.4
	for i=0, 2 do
		WriteFloatA(ReadLong(donaldPointer)+0x40+(i*4), r)
	end
	
	r = math.random(10)*0.1 + 0.4
	for i=0, 2 do
		WriteFloatA(ReadLong(soraPointer)+0x40+(i*4), r)
	end
	
	local musicA = ReadLong(musicP)+8
	for i=1, 40 do
		if musicExists[ReadIntA(musicA)] then
			WriteByteA(musicA, musics[math.random(#musics)])
		end
		if musicExists[ReadIntA(musicA+4)] then
			WriteByteA(musicA+4, musics[math.random(#musics)])
		end
		musicA = musicA + 0x20
	end

	if ReadByte(musicSpeedHack) == 0xF3 then
		local r=math.random(10)
		if r==10 then
			WriteByte(musicSpeedHack+4, 0x3D+0xC)
		elseif r==1 then
			WriteByte(musicSpeedHack+4, 0x3D-0x20)
		else
			WriteByte(musicSpeedHack+4, 0x3D)
		end
	end

	-- Movement speed
	WriteFloat(jumpHeight-8, math.random(11)+5)

	for i=0, 5 do
		WriteFloat(soraResist+i*4, ReadFloat(soraResist+i*4) + (math.random(20)*0.1) - 1.0)
	end
	
	local soraAnimSpeedA = ReadLong(soraPointer) + 0x284
	WriteFloatA(soraAnimSpeedA, 0.7+math.random(6)*0.1)
	
	local soraAirA = ReadLong(soraPointer) + 0x70
	local soraAir = ReadByteA(soraAirA)
	if math.random(10)==10 and (soraAir == 0 or soraAir == 8 or soraAir == 0x18) then
		WriteByteA(soraAirA, airStatuses[math.random(3)])
	end
end

function _OnFrame()
	if canExecute then
		local nowRoom = ReadByte(room)

		if ReadFloat(soraHUD) > 0 and ReadFloat(soraResist) == 1.0 then
			math.randomseed(baseSeed+nowRoom+ReadByte(world)*0x100+ReadByte(soraStats+0x36)*0x10000)
			if nowRoom ~= lastRoom then
				Randomize()
				lastRoom = nowRoom
				print("Chaos! Randomized animations among other things")
			end
		end
	end
end