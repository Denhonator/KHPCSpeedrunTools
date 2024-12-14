-- Current Versions are 1.0.0.2 (Steam) and 1.0.0.10 Epic Games Store
-- shared
animSpeed = 0x23405CC
beepHack = 0x26BEDC
blackFade = 0x4DD3F8
buttonTypes = 0x2E20F20
closeMenu = 0x2E94BA0
cutscene = 0x233F1F4
cutsceneFlagBase = 0x2DEB265
deathPointer = 0x2398838
dest = 0x508280
dialog = 0x299C508
fadeBase = 0x23407D0
gummiSelect = 0x507D7C
gummiStart = 0x507C90
hookship = 0xED751E
inCutscene = 0x237CEE0
inGummi = 0x50832D
inputAddress = 0x23413B4
maxHP = 0x2DE9D66
menu = 0x232E980
menuButtonCount = 0x2E20F1C
menuFunction = 0x2E20FA8
menuItemSlotCount = 0x2E937D2
menuMaxButtonCount = 0x2E937D0
minitimer = 0x232EA04
reports = 0x2DEB720
room = 0x2340EC4
saveOpenAddress = 0x232E984
skippable = 0x2398864
soraHP = 0x2D5D64C
soraHUD = 0x2812E9C
stateFlag = 0x2867CD8
summoning = 0x2D619AC
textProg = 0x232E974
warpTrigger = 0x22ECA8C
warpType1 = 0x23405C0
warpType2 = 0x22ECA90
white = 0x234081C
world = 0x2340ECC

-- rando shared
ardOff = 0x2398F30
khamaActive = 0x2D38AB0
OCseed = 0x238D800
roomWarp = 0x2340EF4
soraPointer = 0x2538A10
soraStats = 0x2DE9D96
theonActive = 0x2D3A220
worldFlagBase = 0x2DEBEB0
worldWarp = 0x2340EF0

-- 4:3
height = 0x3B4584

-- achievements
ach = 0x21AB928

-- auto attack
attackCommand = 0x52960C
attInp = 0x23413B5
fireState1 = 0x23D4980
fireState2 = 0x232E7C4
swapped = 0x22DB02E

-- rando chaos
anims = 0x2D2E130
attackElement = 0x2D282B8
commandMenuPointer = 0x2D37750
donaldPointer = 0x2D37C88
goofyPointer = 0x2D37C90
moveSpeed = 0x2D5D518
musicBaseSpeed = 36797
musicPointer = 0x232E910
musicSpeedHack = 0xA778B
soraResist = 0x2D5D588
weaponSize = 0xD2EFA0

-- consistent finishers
gravBreak = 0x3ED3C8
zantHack = 0x2A4C88
zantValue = 47724

-- early skip
skipArray1 = 0x17853C
skipArray2 = 0x17D383
skipFlag1 = 0x2340938
skipFlag2 = 0x2340E20

-- rando enemy
bossAdjustAddresses = {
	0x6DC674, 0x70E304, 0x2340F14, 0x2D37CA0, 0x2D38150,
	0x2D38600, 0x2D38F74, 0x2D398C0, 0x2D398D4, 0x2D3B030,
	0x2D3B4E0, 0x2D3B990, 0x2D3BE40, 0x2D3D100, 0x2D3DA60,
	0x2D3E3C0, 0x2D42EC0, 0x2D46BB0, 0x2D5D74C, 0x2D5D94C,
	0x2D5DA4C, 0x2D5DE4C
}
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
bittestRender = 0x232E7F0
combo = 0x2DE6834
cutsceneFlags = 0x2DEB260
floorStatus = 0x52997C
glideBarrier = 0x5079D8
inTournament = 0x238D7F8
wall = 0x6DC694

-- fast camera
cameraCenter = 0x2538AB4
cameraInputH = 0x23413E0
cameraInputV = 0x23413E4
curSpeedH = 0x2538854
curSpeedV = 0x2538850
speed = 0x507AAC

-- faster dialogue
textSpeed = 0x23405DC
textTrans = 0x22ECB74

-- hook ship
debug1Value = 1
neverland = 0x2DEBC57
posDebug1 = 0x232E720
posDebug2 = 0x25389E4
posDebugString = 0x3EB1A8

-- instant gummi
monstro = 0x2DEBC5A
normalDrive = 0x268A26C
worldWarpBase = 0x50F9FA
worldWarpBase2 = 0x50FA6A

-- rando some logic
animHalfPointersAddress = 0x286A818
ardoffsetClock = 0x2399290
battleLevel = 0x2DEB724
characters = 0x2DEB444
chestTable = 0x529A60
chestsOpened = 0x2DEA378
chronicles = 0x2DEB6FB
collectedFruits = 0x232EA08
currentTerminus = 0x2396CE4
donaldAbilityTable = 0x2D27660
donaldStatTable = 0x2D275F8
emblemCount = 0x2DEBC0D
emblemDoor = 0x2DEBC1C
enableRC = 0x2DEA5D4
evidence = 0x2DEAB68
evidenceActiveBizarre = 0x2D3D5B0
evidenceActiveForest = 0x2D3DF10
experienceMult = 0x2D5D500
goofyAbilityTable = 0x2D277F8
goofyStatTable = 0x2D27790
gummiFlagBase = 0x2DEBC50
halfPointersAddress = 0x2EE4730
infoBoxNotVisible = 0x23D4C10
instantGummiFix = 0x25389C8
inventory = 0x2DEA1FA
itemDropID = 0x284E348
itemTable = 0x2D25198
jumpHeights = 0x2D237EC
language = 0x2E1BF2B
libraryFlag = 0x2DEBE83
lockMenu = 0x232E98C
magicFlags = 0x2DEB97E
magicLevels = 0x2DEA1F2
menuCheck = 0x2E93218
mermaidKickSpeed = 0x3F087C
OCCupDialog = 0x239AA30
OCCupUnlock = 0x2DEBB60
oppositeState = 0x2DEBA18
oppositeTrigger = 0x2DEAA7D
party2 = 0x2E20F65
poohProgress = 0x2DEBAA8
poohProgress2 = 0x2DEB180
randoInitCheck = 0x7AD208
RCName = 0x2867710
report1 = 0x1D07884
rewardTable = 0x2D2FDE8
roomWarpRead = 0x232E908
savedFruits = 0x2DEBA9E
sharedAbilities = 0x2DEA2F9
shopTableBase = 0x4FF3C4
shortcuts = 0x2DEA5A4
slideActive = 0x2D40490
sliderProgress = 0x2DEBA99
soraAbilityTable = 0x2D27338
soraAbilityTable2 = 0x2D27268
soraAbilityTable3 = 0x2D272D0
soraStatTable = 0x2D27200
summons = 0x2DEA530
summonsReturned = 0x2DEAA8C
superglideBaseSpeed = 1573212
superglideSpeedHack = 0x2B0734
synthItems = 0x548580
synthRequirements = 0x5483A0
terminusTeleUsable = 0x2396C24 -- On: 4378 Off: 4294957296
terminusTeleVisible = 0x2678E48 -- On: 1166594048 Off: 3323740160
textBox = 0x23D4D64
textPointerBase = 0x2B9CC80
trinityUnlock = 0x2DEB97B
unequipBlacklist = 0x546020
unlockedWarps = 0x2DEBC5F
warpCount = 0x50FACC
warpDefinitions = 0x232E900
waterwayCutsceneFlag = 0x2DEAA72
waterwayGate = 0x2DEB9CD
waterwayTrinity = 0x2DEBA11
weaponTable = 0x2D2CC68
worldMapLines = 0x2DEBC72
worldWarps = 0x50F9E8

-- ASL shared
gummiInventory = 0x2DF5BDC
magicUnlock = 0x2DE9DD4
party1 = 0x2DEA1EF
soraCurAbilities = 0x2DE9DA4

-- save anywhere
cam = 0x507AA8
config = 0x2E00160
continue = 0x2E00960
cutSceneAspect = 0x4DE242
deathCheck = 0x299D60
saveAnywhere = 0x2355254
title = 0x2340E38
titlescreenamvtimer = 0x2EE9954
titlescreenpicture = 0x2EE9968

-- unlock 0 volume
volumeZero = 0x3D9B74
