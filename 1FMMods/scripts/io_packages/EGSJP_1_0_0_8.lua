-- Current Versions are 1.0.0.2 (Steam) and 1.0.0.10 Epic Games Store
-- shared
animSpeed = 0x233C24C
beepHack = 0x2698DC
blackFade = 0x4D93B8
buttonTypes = 0x2E1CBA0
closeMenu = 0x2E90820
cutscene = 0x233AE74
cutsceneFlagBase = 0x2DE6ED5
deathPointer = 0x23944B8
dest = 0x5041F0
dialog = 0x2998188
fadeBase = 0x233C450
gummiSelect = 0x503CEC
gummiStart = 0x503C00
hookship = 0xED321E
inCutscene = 0x2378B60
inGummi = 0x50421D
inputAddress = 0x233D034
maxHP = 0x2DE59D6
menu = 0x232A600
menuButtonCount = 0x2E1CB9C
menuFunction = 0x2E1CC28
menuItemSlotCount = 0x2E8F452
menuMaxButtonCount = 0x2E8F450
minitimer = 0x232A684
reports = 0x2DE7390
room = 0x233CB44
saveOpenAddress = 0x232A604
skippable = 0x23944E4
soraHP = 0x2D592CC
soraHUD = 0x280EBE1C
stateFlag = 0x2863958
summoning = 0x2D5D62C
textProg = 0x232A5F4
warpTrigger = 0x22E86DC
warpType1 = 0x233C240
warpType2 = 0x22E86E0
white = 0x233C49C
world = 0x233CB4C

-- rando shared
ardOff = 0x2394BB0
khamaActive = 0x2D34730
OCseed = 0x2389480
roomWarp = 0x233CB74
soraPointer = 0x2534680
soraStats = 0x2DE5A06
theonActive = 0x2D35EA0
worldFlagBase = 0x2DE7B20
worldWarp = 0x233CB70

-- 4:3
height = 0x3B1514

-- achievements
ach = 0x21A7628

-- auto attack
attackCommand = 0x52558C
attInp = 0x233D035
fireState1 = 0x23D0600
fireState2 = 0x232A444
swapped = 0x22D6C7E

-- rando chaos
anims = 0x2D29DB0
attackElement = 0x2D23F38
commandMenuPointer = 0x2D333D0
donaldPointer = 0x2D33908
goofyPointer = 0x2D33910
moveSpeed = 0x2D59298
musicBaseSpeed = 0
musicPointer = 0x232A590
musicSpeedHack = 0xA778B
soraResist = 0x2D59308
weaponSize = 0xD2ACA0

-- consistent finishers
gravBreak = 0x3EA148
zantHack = 0x2A2808
zantValue = 0

-- early skip
skipArray1 = 0x17605C
skipArray2 = 0x17AEA3
skipFlag1 = 0x233C5B8
skipFlag2 = 0x233CAA0

-- rando enemy
bossAdjustAddresses = {
	0x6D8374, 0x70A004, 0x233D034, 0x2D33920, 0x2D33DD0,
	0x2D34280, 0x2D34BF4, 0x2D35540, 0x2D35554, 0x2D36CB0,
	0x2D37160, 0x2D37610, 0x2D37AC0, 0x2D38D80, 0x2D396E0,
	0x2D3A040, 0x2D3EB40, 0x2D42830, 0x2D593CC, 0x2D595CC,
	0x2D596CC, 0x2D59ACC
	
}
enemyAddresses = {
	0x7E10C0, 0x8357C0, 0x851EC0, 0x8A4E40, 0x8A4E80,
	0x8A4EC0, 0x8C7100, 0x8CF9C0, 0x8D1100, 0x8E0E40,
	0x914B40, 0x91ABC0, 0x922D80, 0x94DD00, 0x950640,
	0x953940, 0x959A40, 0x959C40, 0x95C2C0, 0x95CDC0,
	0x95CE80, 0x96CE40, 0x972C40, 0x97BBC0, 0x97BC00,
	0x9800C0, 0x988980, 0x9889C0, 0x988A00, 0x992F00,
	0x992F40, 0x992F80, 0x993B00, 0x99C3C0, 0x9A4B20,
	0x9A5200, 0x9A5280, 0x9A8440, 0x9ACC40, 0x9B32C0,
	0x9B8AC0, 0x9C0900, 0x9C43C0, 0x9C4440, 0x9C4480,
	0x9C44C0, 0x9CA840, 0x9CAB80, 0x9CB700, 0x9CF300,
	0x9CF440, 0x9D1580, 0x9D18E0, 0x9D2BC0, 0x9D78C0,
	0x9DE6A0, 0x9E0180, 0x9E0240, 0x9E3820, 0x9F33C0,
	0x9F4600, 0x9F8100, 0x9FA700, 0xA01FC0, 0xA07040,
	0xA20400, 0xA20480, 0xA22500, 0xA2AAC0, 0xA48740,
	0xA54540, 0xA62BC0, 0xA826C0, 0xA8CF80, 0xA8D0C0,
	0xA97800, 0xA97840, 0xAC0800, 0xAC0840, 0xAC0900,
	0xAC0940, 0xAC0980, 0xAD0540, 0xAD0580, 0xAD05C0,
	0xAD0600, 0xAD0640, 0xAD0680, 0xAD06C0, 0xAD0800,
	0xAD08A0, 0xAE5C80, 0xB0ABC0, 0xB0AC00, 0xB0ACA0,
	0xB16D80, 0xB17240, 0xB195C0, 0xB5AAC0, 0xB5C240,
	0xB5C500, 0xBB0BC0
}
bittestRender = 0x232A470
combo = 0x2DE24B4
cutsceneFlags = 0x2DE6ED0
floorStatus = 0x5258FC
glideBarrier = 0x503948
inTournament = 0x2389480
wall = 0x6D8374

-- fast camera
cameraCenter = 0x2534724
cameraInputH = 0x233D060
cameraInputV = 0x233D064
curSpeedH = 0x25344C4
curSpeedV = 0x25344C0
speed = 0x503A1C

-- faster dialogue
textSpeed = 0x233C25C
textTrans = 0x22E8744

-- hook ship
debug1Value = 1
neverland = 0x2DE78C7
posDebug1 = 0x232A3A0
posDebug2 = 0x2534654
posDebugString = 0x3E7F08

-- instant gummi
monstro = 0x2DE78CA
normalDrive = 0x2685EEC
worldWarpBase = 0x50B96A
worldWarpBase2 = 0x50B9DA

-- rando some logic
animHalfPointersAddress = 0x2866498
ardoffsetClock = 0x2394F10
battleLevel = 0x2DE7394
characters = 0x2DE70B4
chestTable = 0x5259E0
chestsOpened = 0x2DE5FF8
chronicles = 0x2DE736B
collectedFruits = 0x232A688
currentTerminus = 0x2392964
donaldAbilityTable = 0x2D232E0
donaldStatTable = 0x2D23278
emblemCount = 0x2DE787D
emblemDoor = 0x2DE788C
enableRC = 0x2DE6244
evidence = 0x2DE67D8
evidenceActiveBizarre = 0x2D39230
evidenceActiveForest = 0x2D39B90
experienceMult = 0x2D59180
goofyAbilityTable = 0x2D23478
goofyStatTable = 0x2D23410
gummiFlagBase = 0x2DE78C0
halfPointersAddress = 0x2EE03B8
infoBoxNotVisible = 0x23D0890
instantGummiFix = 0x25346D0
inventory = 0x2DE5E6A
itemDropID = 0x2849FC8
itemTable = 0x2D20E18
jumpHeights = 0x2D1F46C
language = 0x2E17BAB
libraryFlag = 0x2DE7AF3
lockMenu = 0x232A60C
magicFlags = 0x2DE75EE
magicLevels = 0x2DE5E62
menuCheck = 0x2E8EE98
mermaidKickSpeed = 0x3ED5FC
OCCupDialog = 0x23966B0
OCCupUnlock = 0x2DE77D0
oppositeState = 0x2DE7688
oppositeTrigger = 0x2DE66ED
party2 = 0x2E1CBE5
poohProgress = 0x2DE7718
poohProgress2 = 0x2DE6DF0
randoInitCheck = 0x7A8EE8
RCName = 0x2863390
report1 = 0x1D03584
rewardTable = 0x2D2BA68
roomWarpRead = 0x232A588
savedFruits = 0x2DE770E
sharedAbilities = 0x2DE5F69
shopTableBase = 0x4FB374
shortcuts = 0x2DE6214
slideActive = 0x2D3CA70
sliderProgress = 0x2DE7709
soraAbilityTable = 0x2D22FB8
soraAbilityTable2 = 0x2D22EE8
soraAbilityTable3 = 0x2D22F50
soraStatTable = 0x2D22E80
summons = 0x2DE61A0
summonsReturned = 0x2DE66FC
superglideBaseSpeed = 0
superglideSpeedHack = 0x2AE2B4
synthItems = 0x544500
synthRequirements = 0x544320
terminusTeleUsable = 0x23928A4 -- On: 4378 Off: 4294957296
terminusTeleVisible = 0x2674AC8 -- On: 1166594048 Off: 3323740160
textBox = 0x23D09E4
textPointerBase = 0x2B98900
trinityUnlock = 0x2DE75EB
unequipBlacklist = 0x541FA0
unlockedWarps = 0x2DE78CF
warpCount = 0x50BA3C
warpDefinitions = 0x232A580
waterwayCutsceneFlag = 0x2DE66E2
waterwayGate = 0x2DE763D
waterwayTrinity = 0x2DE7681
weaponTable = 0x2D288E8
worldMapLines = 0x2DE78E2
worldWarps = 0x50B958

-- ASL shared
gummiInventory = 0x2DF184C
magicUnlock = 0x2DE5A44
party1 = 0x2DE5E5F
soraCurAbilities = 0x2DE5A14

-- save anywhere
cam = 0x503A18
config = 0x2DFBDD0
continue = 0x2DFC5D0
cutSceneAspect = 0x4DA202
deathCheck = 0x297720
saveAnywhere = 0x2350CD4
title = 0x233CAB8
titlescreenamvtimer = 0x2EE55E0
titlescreenpicture = 0x2EE55EC

-- unlock 0 volume
volumeZero = 0x3D6A9C
