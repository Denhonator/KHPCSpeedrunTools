-- Current Versions are 1.0.0.2 (Steam) and 1.0.0.10 Epic Games Store
-- shared
beepHack = 0x26BEDC
maxHP = 0x2DE9D66
menu = 0x232E980
dialog = 0x299C508
blackFade = 0x4DD3F8
world = 0x2340ECC
room = 0x2340EC4
soraHUD = 0x2812E9C
cutscene = 0x233F1F4
white = 0x234081C
fadeBase = 0x23407D0
inCutscene = 0x237CEE0
skippable = 0x2398864
summoning = 0x2D619AC
minitimer = 0x232EA04
animSpeed = 0x23405CC
dest = 0x508280
inGummi = 0x5082AD
gummiSelect = 0x507D7C
gummiStart = 0x507C90
cutsceneFlagBase = 0x2DEB265
soraHP = 0x2D5D64C
stateFlag = 0x2867CD8
closeMenu = 0x2E94BA0
deathPointer = 0x2398838
warpTrigger = 0x22ECA8C
warpType1 = 0x23405C0
warpType2 = 0x22ECA90
inputAddress = 0x23413B4
saveOpenAddress = 0x232E984
menuFunction = 0x2E20FA8
menuButtonCount = 0x2E20F1C
menuMaxButtonCount = 0x2E937D0
menuItemSlotCount = 0x2E937D2
buttonTypes = 0x2E20F20

-- rando shared
soraStats = 0x2DE9D96
khamaActive = 0x2D38AB0
theonActive = 0x2D3A220
party1 = 0x2DEA1EF
OCseed = 0x238D800
worldWarp = 0x2340EF0
roomWarp = 0x2340EF4
ardOff = 0x237D180
worldFlagBase = 0x2DEBEB0

-- 4:3
height = 0x3B4584

-- achievements
ach = 0x21AB928

-- auto attack
attInp = 0x23413B5
swapped = 0x22DAFFE
attackCommand = 0x52968C
fireState1 = 0x23D4980
fireState2 = 0x232E7C4

-- rando chaos
anims = 0x2D2E130
commandMenuPointer = 0x2D37750
attackElement = 0x2D282B8
soraPointer = 0x2538A10
donaldPointer = 0x2D37C88
goofyPointer = 0x2D37C90
weaponSize = 0xD2EFA0
musicPointer = 0x232E910
musicSpeedHack = 0xA7ACB
musicBaseSpeed = 36701
moveSpeed = 0x2D5D518
soraResist = 0x2D5D588

-- consistent finishers
zantHack = 0x2A4C88
gravBreak = 0x3ED3C8
zantValue = 48100

-- early skip
skipArray1 = 0x17853C
skipArray2 = 0x17D383
skipFlag1 = 0x2340938
skipFlag2 = 0x2340E20

-- rando enemy
cutsceneFlags = 0x2DEB260
inTournament = 0x238D7F8
bittestRender = 0x232E7F0
combo = 0x2DE6834
glideBarrier = 0x5079D8
floorStatus = 0x5299FC
wall = 0x6DD694
enemyAddresses = {
	0x7E53C0, 0x839AC0, 0x8561C0, 0x8A9140, 0x8A9180,
	0x8A91C0, 0x8CB400, 0x8D3CC0, 0x8D5400, 0x8E5140,
	0x918E40, 0x91EEC0, 0x927080, 0x952000, 0x954940,
	0x957C40, 0x95DD40, 0x95DF40, 0x9605C0, 0x9610C0,
	0x961180, 0x971140, 0x976F40, 0x97FEC0, 0x97FF00,
	0x9843C0, 0x98CC80, 0x98CCC0, 0x98CD00, 0x997200,
	0x997240, 0x997280, 0x997E00, 0x9A06C0, 0x9A8E20,
	0x9A9500, 0x9A9580, 0x9AC740, 0x9B0F40, 0x9B75C0,
	0x9BCDC0, 0x9C4C00, 0x9C86C0, 0x9C8740, 0x9C8780,
	0x9C87C0, 0x9CEB40, 0x9CEE80, 0x9CFA00, 0x9D3600,
	0x9D3740, 0x9D5880, 0x9D5BE0, 0x9D6EC0, 0x9DBBC0,
	0x9E29A0, 0x9E4480, 0x9E4540, 0x9E7B20, 0x9F76C0,
	0x9F8900, 0x9FC400, 0x9FEA00, 0xA062C0, 0xA0B340,
	0xA24700, 0xA24780, 0xA26800, 0xA2EDC0, 0xA4CA40,
	0xA58840, 0xA66EC0, 0xA869C0, 0xA91280, 0xA913C0,
	0xA9BB00, 0xA9BB40, 0xAC4B00, 0xAC4B40, 0xAC4C00,
	0xAC4C40, 0xAC4C80, 0xAD4840, 0xAD4880, 0xAD48C0,
	0xAD4900, 0xAD4940, 0xAD4980, 0xAD49C0, 0xAD4B00,
	0xAD4BA0, 0xAE9F80, 0xB0EEC0, 0xB0EF00, 0xB0EFA0,
	0xB1B080, 0xB1B540, 0xB1D8C0, 0xB5EDC0, 0xB60540,
	0xB60800, 0xBB4EC0
}
bossAdjustAddresses = {
	0x5079D8, 0x5299FC, 0x529A1C, 0x6DC674, 0x70D74C,
	0x70E304, 0x2340F14, 0x2D37CA0, 0x2D38150, 0x2D38600,
	0x2D38AB0, 0x2D38F74, 0x2D398C0, 0x2D398D4, 0x2D3A220,
	0x2D3B030, 0x2D3B4E0, 0x2D3B990, 0x2D3BE40, 0x2D3D100,
	0x2D3DA60, 0x2D3E3C0, 0x2D42EC0, 0x2D46BB0, 0x2D5D74C,
	0x2D5D94C
}

-- fast camera
curSpeedV = 0x2538850
curSpeedH = 0x2538854
cameraCenter = 0x2538AB4
speed = 0x507AAC
cameraInputH = 0x23413E0
cameraInputV = 0x23413E4

-- faster dialogue
textTrans = 0x22ECAC4
textProg = 0x232E974
textSpeed = 0x23405DC

-- hook ship
posDebugString = 0x3EB1A8
hookship = 0xED751E
neverland = 0x2DEBC57
posDebug1 = 0x232E720
posDebug2 = 0x25389E4
debug1Value = 1

-- instant gummi
worldWarpBase = 0x50F9FA
worldWarpBase2 = 0x50FA6A
monstro = 0x2DEBC5A
normalDrive = 0x268A26C

-- rando some logic
superglideBaseSpeed = 1573500
superglideSpeedHack = 0x2B0734
mermaidKickSpeed = 0x3F087C
shopTableBase = 0x4FF3C4
worldWarps = 0x50FA68
warpCount = 0x50FB4C
chestTable = 0x529AE0
unequipBlacklist = 0x5460A0
synthRequirements = 0x548420
synthItems = 0x548600
randoInitCheck = 0x7AD208
report1 = 0x1D07884
warpDefinitions = 0x232E900
roomWarpRead = 0x232E908
lockMenu = 0x232E98C
collectedFruits = 0x232EA08
terminusTeleUsable = 0x2396C24 -- On: 4378 Off: 4294957296
currentTerminus = 0x2396CE4
ardoffsetClock = 0x2399290
OCCupDialog = 0x239AA30
infoBoxNotVisible = 0x23D4C10
textBox = 0x23D43E4
instantGummiFix = 0x25380D8
terminusTeleVisible = 0x2678E48 -- On: 1166594048 Off: 3323740160
itemDropID = 0x284E348
RCName = 0x2867710
animHalfPointersAddress = 0x286A818
textPointerBase = 0x2B9CC80
jumpHeights = 0x2D237EC
itemTable = 0x2D25198
soraStatTable = 0x2D27200
soraAbilityTable2 = 0x2D27268
soraAbilityTable3 = 0x2D272D0
soraAbilityTable = 0x2D27338
donaldStatTable = 0x2D275F8
donaldAbilityTable = 0x2D27660
goofyStatTable = 0x2D27790
goofyAbilityTable = 0x2D277F8
weaponTable = 0x2D2CC68
rewardTable = 0x2D2FDE8
evidenceActiveBizarre = 0x2D3D5B0
evidenceActiveForest = 0x2D3DF10
slideActive = 0x2D40490
experienceMult = 0x2D5D500
soraStats = 0x2DE9D7D
magicLevels = 0x2DEA1F2
inventory = 0x2DEA1FA
sharedAbilities = 0x2DEA2F9
chestsOpened = 0x2DEA378
summons = 0x2DEA530
shortcuts = 0x2DEA5A4
enableRC = 0x2DEA5D4
waterwayCutsceneFlag = 0x2DEAA72
oppositeTrigger = 0x2DEAA7D
summonsReturned = 0x2DEAA8C
evidence = 0x2DEAB68
poohProgress2 = 0x2DEB180
characters = 0x2DEB444
chronicles = 0x2DEB6FB
reports = 0x2DEB720
battleLevel = 0x2DEB724
trinityUnlock = 0x2DEB97B
magicFlags = 0x2DEB97E
waterwayGate = 0x2DEB9CD
waterwayTrinity = 0x2DEBA11
oppositeState = 0x2DEBA18
sliderProgress = 0x2DEBA99
savedFruits = 0x2DEBA9E
poohProgress = 0x2DEBAA8
OCCupUnlock = 0x2DEBB60
emblemCount = 0x2DEBC0D
emblemDoor = 0x2DEBC1C
gummiFlagBase = 0x2DEBC50
unlockedWarps = 0x2DEBC5F
worldMapLines = 0x2DEBC72
libraryFlag = 0x2DEBE83
language = 0x2E1BF2B
party2 = 0x2E20F65
menuCheck = 0x2E93218
halfPointersAddress = 0x2EE4730

-- rando some logic - used in ASL
gummiInventory = 0x2DF5BDC
magicUnlock = 0x2DE9DD4
soraCurAbilities = 0x2DE9DA4

-- save anywhere
deathCheck = 0x299D60
title = 0x2340E38
continue = 0x2E00960
config = 0x2E00160
cam = 0x507AA8
titlescreenpicture = 0x2EE566C
titlescreenamvtimer = 0x2EE9954
cutSceneAspect = 0x4DE242
saveAnywhere = 0x2355254

-- unlock 0 volume
volumeZero = 0x3D9B74
