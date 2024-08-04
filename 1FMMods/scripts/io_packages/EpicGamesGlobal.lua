-- shared
beepHack = 0x26BD5C
maxHP = 0x2DE9CE6
menu = 0x232E900
dialog = 0x299C488
blackFade = 0x4DD3F8
world = 0x2340E4C
room = 0x2340E44
soraHUD = 0x2812E1C
cutscene = 0x233F174
white = 0x234079C
fadeBase = 0x2340750
inCutscene = 0x237CE60
skippable = 0x23987E4
summoning = 0x2D6192C
minitimer = 0x232E984
animSpeed = 0x234054C
dest = 0x508280
inGummi = 0x5082AD
gummiSelect = 0x507D7C
gummiStart = 0x507C90
cutsceneFlagBase = 0x2DEB1E5
soraHP = 0x2D5D5CC
stateFlag = 0x2867C58
closeMenu = 0x2E94B20
deathPointer = 0x23987B8
warpTrigger = 0x22EC9DC
warpType1 = 0x2340540
warpType2 = 0x22EC9E0
inputAddress = 0x2341334
saveOpenAddress = 0x232E904
menuFunction = 0x2E20F28
menuButtonCount = 0x2E20E9C
menuMaxButtonCount = 0x2E93750
menuItemSlotCount = 0x2E93752
buttonTypes = 0x2E20EA0

-- rando shared
soraStats = 0x2DE9D16
khamaActive = 0x2D38A30
theonActive = 0x2D3A1A0
party1 = 0x2DEA16F
OCseed = 0x238D780
worldWarp = 0x2340E70
roomWarp = 0x2340E74
ardOff = 0x2398EB0
worldFlagBase = 0x2DEBE30

-- 4:3
height = 0x3B4594

-- achievements
ach = 0x21AB8A8

-- auto attack
attInp = 0x2341335
swapped = 0x22DAF7E
attackCommand = 0x52960C
fireState1 = 0x23D4900
fireState2 = 0x232E744

-- rando chaos
anims = 0x2D2E0B0
commandMenuPointer = 0x2D376D0
attackElement = 0x2D28238
soraPointer = 0x2538990
donaldPointer = 0x2D37C08
goofyPointer = 0x2D37C10
weaponSize = 0xD2EF20
musicPointer = 0x232E890
musicSpeedHack = 0xA778B
musicBaseSpeed = 36701
moveSpeed = 0x2D5D498
soraResist = 0x2D5D508

-- consistent finishers
zantHack = 0x2A4B08
gravBreak = 0x3ED378
zantValue = 48100

-- early skip
skipArray1 = 0x1783BC
skipArray2 = 0x17D203
skipFlag1 = 0x23408B8
skipFlag2 = 0x2340DA0

-- rando enemy
cutsceneFlags = 0x2DEB1E0
inTournament = 0x238D77C
bittestRender = 0x232E770
combo = 0x2DE67B4
glideBarrier = 0x5079D8
floorStatus = 0x52997C
wall = 0x6DC614
enemyAddresses = {
	0x7E5340, 0x839A40, 0x856140, 0x8A90C0, 0x8A9100,
	0x8A9140, 0x8CB380, 0x8D3C40, 0x8D5380, 0x8E50C0,
	0x918DC0, 0x91EE40, 0x927000, 0x951F80, 0x9548C0,
	0x957BC0, 0x95DCC0, 0x95DEC0, 0x960540, 0x961040,
	0x961100, 0x9710C0, 0x976EC0, 0x97FE40, 0x97FE80,
	0x984340, 0x98CC00, 0x98CC40, 0x98CC80, 0x997180,
	0x9971C0, 0x997200, 0x997D80, 0x9A0640, 0x9A8DA0,
	0x9A9480, 0x9A9500, 0x9AC6C0, 0x9B0EC0, 0x9B7540,
	0x9BCD40, 0x9C4B80, 0x9C8640, 0x9C86C0, 0x9C8700,
	0x9C8740, 0x9CEAC0, 0x9CEE00, 0x9CF980, 0x9D3580,
	0x9D36C0, 0x9D5800, 0x9D5B60, 0x9D6E40, 0x9DBB40,
	0x9E2920, 0x9E4400, 0x9E44C0, 0x9E7AA0, 0x9F7640,
	0x9F8880, 0x9FC380, 0x9FE980, 0xA06240, 0xA0B2C0,
	0xA24680, 0xA24700, 0xA26780, 0xA2ED40, 0xA4C9C0,
	0xA587C0, 0xA66E40, 0xA86940, 0xA91200, 0xA91340,
	0xA9BA80, 0xA9BAC0, 0xAC4A80, 0xAC4AC0, 0xAC4B80,
	0xAC4BC0, 0xAC4C00, 0xAD47C0, 0xAD4800, 0xAD4840,
	0xAD4880, 0xAD48C0, 0xAD4900, 0xAD4940, 0xAD4A80,
	0xAD4B20, 0xAE9F00, 0xB0EE40, 0xB0EE80, 0xB0EF20,
	0xB1B000, 0xB1B4C0, 0xB1D840, 0xB5ED40, 0xB604C0,
	0xB60780, 0xBB4E40
}
bossAdjustAddresses = {
	0x5079D8, 0x52997C, 0x52999C, 0x6DC5F4, 0x70D6CC,
	0x70E284, 0x2340E94, 0x2D37C20, 0x2D380D0, 0x2D38580,
	0x2D38EF4, 0x2D39840, 0x2D39854, 0x2D3AFB0, 0x2D3B460,
	0x2D3B910, 0x2D3BDC0, 0x2D3D080, 0x2D3D9E0, 0x2D3E340,
	0x2D42E40, 0x2D46B30, 0x2D5D6CC, 0x2D5D8CC, 0x2D5D9CC,
	0x2D5DDCC, 0x2DEA170
}

-- fast camera
curSpeedV = 0x25387D0
curSpeedH = 0x25387D4
cameraCenter = 0x2538A34
speed = 0x507AAC
cameraInputH = 0x2341360
cameraInputV = 0x2341364

-- faster dialogue
textTrans = 0x22ECA44
textProg = 0x232E8F4
textSpeed = 0x234055C

-- hook ship
hookship = 0xED751E
neverland = 0x2DEBBD7
posDebug1 = 0x232E6A0
posDebug2 = 0x2538964
debug1Value = 1

-- instant gummi
worldWarpBase = 0x50F9FA
worldWarpBase2 = 0x50FA6A
monstro = 0x2DEBBDA
normalDrive = 0x268A1EC

-- rando some logic
superglideBaseSpeed = 1573500
superglideSpeedHack = 0x2B05B4
mermaidKickSpeed = 0x3F081C
shopTableBase = 0x4FF3C4
worldWarps = 0x50F9E8
warpCount = 0x50FACC
chestTable = 0x529A60
unequipBlacklist = 0x546020
synthRequirements = 0x5483A0
synthItems = 0x548580
randoInitCheck = 0x7AD188
report1 = 0x1D07804
warpDefinitions = 0x232E880
roomWarpRead = 0x232E888
lockMenu = 0x232E90C
collectedFruits = 0x232E988
terminusTeleUsable = 0x2396BA4 -- On: 4378 Off: 4294957296
currentTerminus = 0x2396C64
ardoffsetClock = 0x2399210
OCCupDialog = 0x239A9B0
infoBoxNotVisible = 0x23D4B90
textBox = 0x23D4364
instantGummiFix = 0x2538058
terminusTeleVisible = 0x2678DC8 -- On: 1166594048 Off: 3323740160
itemDropID = 0x284E2C8
RCName = 0x2867690
animHalfPointersAddress = 0x286A798
textPointerBase = 0x2B9CC00
jumpHeights = 0x2D2376C
itemTable = 0x2D25118
soraStatTable = 0x2D27180
soraAbilityTable2 = 0x2D271E8
soraAbilityTable3 = 0x2D27250
soraAbilityTable = 0x2D272B8
donaldStatTable = 0x2D27578
donaldAbilityTable = 0x2D275E0
goofyStatTable = 0x2D27710
goofyAbilityTable = 0x2D27778
weaponTable = 0x2D2CBE8
rewardTable = 0x2D2FD68
evidenceActiveBizarre = 0x2D3D530
evidenceActiveForest = 0x2D3DE90
slideActive = 0x2D40410
experienceMult = 0x2D5D480
soraStats = 0x2DE9CFD
magicLevels = 0x2DEA172
inventory = 0x2DEA17A
sharedAbilities = 0x2DEA279
chestsOpened = 0x2DEA2F8
summons = 0x2DEA4B0
shortcuts = 0x2DEA524
enableRC = 0x2DEA554
waterwayCutsceneFlag = 0x2DEA9F2
oppositeTrigger = 0x2DEA9FD
summonsReturned = 0x2DEAA0C
evidence = 0x2DEAAE8
poohProgress2 = 0x2DEB100
characters = 0x2DEB3C4
chronicles = 0x2DEB67B
reports = 0x2DEB6A0
battleLevel = 0x2DEB6A4
trinityUnlock = 0x2DEB8FB
magicFlags = 0x2DEB8FE
waterwayGate = 0x2DEB94D
waterwayTrinity = 0x2DEB991
oppositeState = 0x2DEB998
sliderProgress = 0x2DEBA19
savedFruits = 0x2DEBA1E
poohProgress = 0x2DEBA28
OCCupUnlock = 0x2DEBAE0
emblemCount = 0x2DEBB8D
emblemDoor = 0x2DEBB9C
gummiFlagBase = 0x2DEBBD0
unlockedWarps = 0x2DEBBDF
worldMapLines = 0x2DEBBF2
libraryFlag = 0x2DEBE03
language = 0x2E1BEAB
party2 = 0x2E20EE5
menuCheck = 0x2E93198
menuState = 0x2E93568
halfPointersAddress = 0x2EE46B0

-- rando some logic - used in ASL
gummiInventory = 0x2DF5B5C
magicUnlock = 0x2DE9D54
soraCurAbilities = 0x2DE9D24

-- save anywhere
deathCheck = 0x299BE0
title = 0x2340DB8
continue = 0x2E008E0
config = 0x2E000E0
cam = 0x507AA8
titlescreenpicture = 0x2EE55EC
titlescreenamvtimer = 0x2EE98D4
cutSceneAspect = 0x4DE242
saveAnywhere = 0x23551D4

-- unlock 0 volume
volumeZero = 0x3D9B24
