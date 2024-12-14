-- -- Current Versions are 1.0.0.2 (Steam) and 1.0.0.10 Epic Games Store
-- -- shared
-- animSpeed = 0x233C24C
-- beepHack = 0x2698DC
-- blackFade = 0x4D93B8
-- buttonTypes = 0x2E1CBA0
-- closeMenu = 0x2E90820
-- cutscene = 0x233AE74
-- cutsceneFlagBase = 0x2DE6ED5
-- deathPointer = 0x23944B8
-- dest = 0x5041F0
-- dialog = 0x2998188
-- fadeBase = 0x233C450
-- gummiSelect = 0x503CEC
-- gummiStart = 0x503C00
-- hookship = 0xED321E
-- inCutscene = 0x2378B60
-- inGummi = 0x50421D
-- inputAddress = 0x233D034
-- maxHP = 0x2DE59D6
-- menu = 0x232A600
-- menuButtonCount = 0x2E1CB9C
-- menuFunction = 0x2E1CC28
-- menuItemSlotCount = 0x2E8F452
-- menuMaxButtonCount = 0x2E8F450
-- minitimer = 0x232A684
-- reports = 0x2DE7390
-- room = 0x233CB44
-- saveOpenAddress = 0x232A604
-- skippable = 0x23944E4
-- soraHP = 0x2D592CC
-- soraHUD = 0x280EBE1C
-- stateFlag = 0x2863958
-- summoning = 0x2D5D62C
-- textProg = 0x232A5F4
-- warpTrigger = 0x22E86DC
-- warpType1 = 0x233C240
-- warpType2 = 0x22E86E0
-- white = 0x233C49C
-- world = 0x233CB4C

-- -- rando shared
-- ardOff = 0x2394BB0
-- khamaActive = 0x2D34730
-- OCseed = 0x2389480
-- roomWarp = 0x233CB74
-- soraPointer = 0x2534680
-- soraStats = 0x2DE5A06
-- theonActive = 0x2D35EA0
-- worldFlagBase = 0x2DE7B20
-- worldWarp = 0x233CB70

-- -- 4:3
-- height = 0x3B1534

-- -- achievements
-- ach = 0x21A7628

-- -- auto attack
-- attackCommand = 0x52558C
-- attInp = 0x233D035
-- fireState1 = 0x23D0600
-- fireState2 = 0x232A444
-- swapped = 0x22D6C7E

-- -- rando chaos
-- anims = 0x2D29DB0
-- attackElement = 0x2D23F38
-- commandMenuPointer = 0x2D333D0
-- donaldPointer = 0x2D33908
-- goofyPointer = 0x2D33910
-- moveSpeed = 0x2D59298
-- musicBaseSpeed = 0
-- musicPointer = 0x232A590
-- musicSpeedHack = 0xA778B
-- soraResist = 0x2D59308
-- weaponSize = 0xD2ACA0

-- -- consistent finishers
-- gravBreak = 0x3EA148
-- zantHack = 0x2A2808
-- zantValue = 0

-- -- early skip
-- skipArray1 = 0x17605C
-- skipArray2 = 0x17AEA3
-- skipFlag1 = 0x233C5B8
-- skipFlag2 = 0x233CAA0

-- -- rando enemy
-- bossAdjustAddresses = {
-- 	0x6D8374, 0x70A004, 0x233D034, 0x2D33920, 0x2D33DD0,
-- 	0x2D34280, 0x2D34BF4, 0x2D35540, 0x2D35554, 0x2D36CB0,
-- 	0x2D37160, 0x2D37610, 0x2D37AC0, 0x2D38D80, 0x2D396E0,
-- 	0x2D3A040, 0x2D3EB40, 0x2D42830, 0x2D593CC, 0x2D595CC,
-- 	0x2D596CC, 0x2D59ACC
	
-- }
enemyAddresses = {
	0x7E4340, 0x838A40, 0x855140, 0x8A80C0, 0x8A8100,
	0x8A8140, 0x8CA380, 0x8D2C40, 0x8D4380, 0x8E40C0,
	0x917DC0, 0x91DE40, 0x926000, 0x950F80, 0x9538C0,
	0x956BC0, 0x95CCC0, 0x95CEC0, 0x95F540, 0x960040,
	0x960100, 0x9700C0, 0x975EC0, 0x97EE40, 0x97EE80,
	0x983340, 0x98BC00, 0x98BC40, 0x98BC80, 0x996180,
	0x9961C0, 0x996200, 0x996D80, 0x99F640, 0x9A7DA0,
	0x9A8480, 0x9A8500, 0x9AB6C0, 0x9AFEC0, 0x9B6540,
	0x9BBD40, 0x9C3B80, 0x9C7640, 0x9C76C0, 0x9C7700,
	0x9C7740, 0x9CDAC0, 0x9CDE00, 0x9CE980, 0x9D2580,
	0x9D26C0, 0x9D4800, 0x9D4B60, 0x9D5E40, 0x9DAB40,
	0x9E1920, 0x9E3400, 0x9E34C0, 0x9E6AA0, 0x9F6640,
	0x9F7880, 0x9FB380, 0x9FD980, 0xA05240, 0xA0A2C0,
	0xA23680, 0xA23700, 0xA25780, 0xA2DD40, 0xA4B9C0,
	0xA577C0, 0xA65E40, 0xA85940, 0xA90200, 0xA90340,
	0xA9AA80, 0xA9AAC0, 0xAC3A80, 0xAC3AC0, 0xAC3B80,
	0xAC3BC0, 0xAC3C00, 0xAD37C0, 0xAD3800, 0xAD3840,
	0xAD3880, 0xAD38C0, 0xAD3900, 0xAD3940, 0xAD3A80,
	0xAD3B20, 0xAE8F00, 0xB0DE40, 0xB0DE80, 0xB0DF20,
	0xB1A000, 0xB1A4C0, 0xB1C840, 0xB5DD40, 0xB5F4C0,
	0xB5F780, 0xBB3E40
}
-- bittestRender = 0x232A470
-- combo = 0x2DE24B4
-- cutsceneFlags = 0x2DE6ED0
-- floorStatus = 0x5258FC
-- glideBarrier = 0x503948
-- inTournament = 0x2389480
-- wall = 0x6D8374

-- -- fast camera
-- cameraCenter = 0x2534724
-- cameraInputH = 0x233D060
-- cameraInputV = 0x233D064
-- curSpeedH = 0x25344C4
-- curSpeedV = 0x25344C0
-- speed = 0x503A1C

-- -- faster dialogue
-- textSpeed = 0x233C25C
-- textTrans = 0x22E8744

-- -- hook ship
-- debug1Value = 1
-- neverland = 0x2DE78C7
-- posDebug1 = 0x232A3A0
-- posDebug2 = 0x2534654
-- posDebugString = 0x3E7F28

-- -- instant gummi
-- monstro = 0x2DE78CA
-- normalDrive = 0x2685EEC
-- worldWarpBase = 0x50B96A
-- worldWarpBase2 = 0x50B9DA

-- rando some logic
animHalfPointersAddress = 0x2869798
ardoffsetClock = 0x2398210
battleLevel = 0x2DEA6A4
characters = 0x2DEA3C4
chestTable = 0x528A60
chestsOpened = 0x2DE92F8
chronicles = 0x2DEA67B
collectedFruits = 0x232D988
currentTerminus = 0x2395C64
donaldAbilityTable = 0x2D265E0
donaldStatTable = 0x2D26578
emblemCount = 0x2DEAB8D
emblemDoor = 0x2DEAB9C
enableRC = 0x2DE9554
evidence = 0x2DE9AE8
evidenceActiveBizarre = 0x2D3C530
evidenceActiveForest = 0x2D3CE90
experienceMult = 0x2D5C480
goofyAbilityTable = 0x2D26778
goofyStatTable = 0x2D26710
gummiFlagBase = 0x2DEABD0
halfPointersAddress = 0x2EE36B0
infoBoxNotVisible = 0x23D3B90
instantGummiFix = 0x2537058
inventory = 0x2DE917A
itemDropID = 0x284D2C8
itemTable = 0x2D24118
jumpHeights = 0x2D2276C
language = 0x2E1AEAB
libraryFlag = 0x2DEAE03
lockMenu = 0x232D90C
magicFlags = 0x2DEA8FE
magicLevels = 0x2DE9172
menuCheck = 0x2E92198
mermaidKickSpeed = 0x3EF80C
OCCupDialog = 0x23999B0
OCCupUnlock = 0x2DEAAE0
oppositeState = 0x2DE99FD
oppositeTrigger = 0x2DE99FD
party2 = 0x2E1FEE5
poohProgress = 0x2DEAA28
poohProgress2 = 0x2DEA100
randoInitCheck = 0x7AC188
RCName = 0x2866690
report1 = 0x1D06804
rewardTable = 0x2D2ED68
roomWarpRead = 0x232D888
savedFruits = 0x2DEAA1E
sharedAbilities = 0x2DE9279
shopTableBase = 0x4FE3C4
shortcuts = 0x2DE9524
slideActive = 0x2D3F410
sliderProgress = 0x2DEAA19
soraAbilityTable = 0x2D262B8
soraAbilityTable2 = 0x2D261E8
soraAbilityTable3 = 0x2D26250
soraStatTable = 0x2D26180
summons = 0x2DE94B0
summonsReturned = 0x2DE9A0C
superglideBaseSpeed = 1569852
superglideSpeedHack = 0x2B03F4
synthItems = 0x547580
synthRequirements = 0x5473A0
terminusTeleUsable = 0x2395BA4  -- On: 4378 Off: 4294957296
terminusTeleVisible = 0x2677DC8 -- On: 1166594048 Off: 3323740160
textBox = 0x23D3364
textPointerBase = 0x2B9BC00
trinityUnlock = 0x2DEA8FB
unequipBlacklist = 0x545020
unlockedWarps = 0x2DEABDF
warpCount = 0x50EACC
warpDefinitions = 0x232D880
waterwayCutsceneFlag = 0x2DE99F2
waterwayGate = 0x2DEA94D
waterwayTrinity = 0x2DEA991
weaponTable = 0x2D2BBE8
-- worldMapLines = 0x2DE78E2
-- worldWarps = 0x50B958

-- -- ASL shared
-- gummiInventory = 0x2DF184C
-- magicUnlock = 0x2DE5A44
-- party1 = 0x2DE5E5F
-- soraCurAbilities = 0x2DE5A14

-- -- save anywhere
-- cam = 0x503A18
-- config = 0x2DFBDD0
-- continue = 0x2DFC5D0
-- cutSceneAspect = 0x4DA202
-- deathCheck = 0x2978E0
-- saveAnywhere = 0x2350CD4
-- title = 0x233CAB8
-- titlescreenamvtimer = 0x2EE55E0
-- titlescreenpicture = 0x2EE55EC

-- -- unlock 0 volume
-- volumeZero = 0x3D6ABC
