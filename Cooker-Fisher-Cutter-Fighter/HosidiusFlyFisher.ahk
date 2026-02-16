;Make sure npc indicator is on top, make it a box (orange).
;Use fishing plugin underneath, make sure its purple.
;Make sure you mark every path tile, mark them blue
;Make sure you put a green marker across bank (on outside) to see if you are in that spot b/c of door
;Make sure feathers and fish rod are at the bottom right most positions, right above the lock, search, and deposit inventory buttons
;Make sure "Quantity" option in bank is on "all"
;Angle camera with "Birds Eye" view. At a compass of just slightly west of north. I.e. your heading should be North North North West lol.
;Hide entities: Hide the "Woman" and "Man" just ouside the bank. Be careful not to hide all entities, as this will hide the fishing spot as well.

CoordMode, Mouse, Window
CoordMode, Pixel, Window
SetWorkingDir %A_ScriptDir%
#Warn
#SingleInstance, Force

;Script Specific Global Variables SET THESE
ScriptOverallRunTime:=-10350000 ;Time is in ms, 20700000=5hrs 45mins, 3600000=1Hour, 600000=10min
Random, RandomSleepForLogoutTimer, 2300, 3200
HowManyTimesLoopWasRan=0
NoSleepAfterBank=0
FileAppend, `n ------------------------------------------ `n, errorlog.txt

;Functions
#include RandomBezier().ahk
#include RSLogout().ahk
#include Clickl().ahk
#include MullerAndUniformCordinateChooser().ahk
#include BorderSearch().ahk
#Include BankWindowDetect().ahk
#Include DetectRunEnergy().ahk
#Include rbezierdist().ahk
#Include PathFishToBank().ahk
#Include EnterAndLeaveHosidiusFishBank().ahk
#Include PathBankToFish().ahk



1::
;Timer for logging out and ExitApp 5 seconds after loggout, Times Should be around 5-6hrs (in terms of milliseconds)
SetTimer, CallToForceExitApp, %ScriptOverallRunTime%


;Main Script ---------------------------------------------
Loop
{
Random, ThisISJustForANewSeedLol, 1, 4142467295
Random, ,ThisISJustForANewSeedLol
HowManyTimesLoopWasRan:=HowManyTimesLoopWasRan+1
FileAppend, `n - `n Below is the %HowManyTimesLoopWasRan% loop, errorlog.txt
Random, SleepAfterLoopRestart, 500, 3200
Sleep, SleepAfterLoopRestart

;Inventory Check If last inventory has item then proceed to bank. Else continue fishing.
CheckLastInventoryItemAndBank:

DetectRunEnergy()
	
PixelSearch, LastInventoryItemPixelX, LastInventoryItemPixelY, 865, 571, 905, 611, 0xFF00FF, 20, Fast ;Search if last inventory slot is full
If (errorlevel=0) {
	FileAppend, `n CheckLastInventoryItemAndBank. Inventory full. Initiate banking Errorlevel=0. ,errorlog.txt
	Sleep 10
	PathFishToBank()
	Random, psosollfa, 631, 1678
	sleep psosollfa
	EnterAndLeaveHosidiusFishBank()
	PathBankToFish()
	Continue
}
Else if (errorlevel=2) {
	FileAppend, `n CheckLastInventoryItemAndBank. Errorlevel=2. Logging out/exiting script, errorlog.txt
	Sleep 10
	GoTo, CallToForceExitApp
}
Else {
	FileAppend, `n CheckLastInventoryItemAndBank. Inventory not full. Continue fishing. Errorlevel=1. ,errorlog.txt
	sleep 10
	GoTo, StartFishingChecks 
}

StartFishingChecks:
PixelSearch, FishingSpotVisibleOrNotX, FishingSpotVisibleOrNotY, 0, 40, 650, 450, 0x8E0240, 45, fast
If (errorlevel=0) {
	Random, ChooseRandomFishSpot, 1, 2
	Random, StartFishCheckInitialRandomBezierSpeed, 310, 510
	RandomBezier(0, 0, FishingSpotVisibleOrNotX, FishingSpotVisibleOrNotY, "T"StartFishCheckInitialRandomBezierSpeed "RO OT100 OB100 OL100 OR100 P2-5")
	GoTo SelectFishSpot
}
Else
{
	GoTo CallToForceExitApp
}

SelectFishSpot:
if (ChooseRandomFishSpot=1) {
	PixelSearch, SelectFishSpotx, SelectFishSpoty, 0, 40, 650, 450, 0x0D7DF2, 3, fast
}
Else
{
	PixelSearch, SelectFishSpotx, SelectFishSpoty, 650, 450, 0, 40, 0x0D7DF2, 3, fast
}
MullerAndUniformCordinateChooser(MAUCCSFSx, MAUCCSFSy, SelectFishSpotx-17, SelectFishSpoty-17, SelectFishSpotx+17, SelectFishSpoty+17)
BorderSearch(MAUCCSFSx, MAUCCSFSy, 0x8E0240, 45)
if (BorderSearchV=0) {
	GoTo ClickFishingSpot
}
Else
{
	GoTo SelectFishSpot
}

ClickFishingSpot:
rbezierdist(MAUCCSFSx, MAUCCSFSy)
Clickl()
if (ClicklV=1) {
	GoTo SelectFishSpot
}
else if (ClicklV=0) {
	Random, asjdhasuadgs, 3752, 7158
	sleep, asjdhasuadgs
	GoTo CheckIfIdling
}

CheckIfIdling:
PixelSearch, CheckIfIdlingX, CheckIfIdlingY, 640, 239, 645, 244, 0x57FF00, 3, Fast ;Check if im idling, error 0 means idling.
If (errorlevel=0) {
	FileAppend, `n Detected idling. Return to top of loop., errorlog.txt
	Continue
}
else {
	Random, CheckIfIdlingRandSleep, 390, 610
	sleep CheckIfIdlingRandSleep
	;FileAppend, `n Fishing..., errorlog.txt
	;Random, RandomIdleAntiban, 1, 5
	;Random, RandomIdleAntibanPercent, 1, 1000
	;Check fishing xp
	;check friends list, if yellow detected
	;mousemove random on screen
	;mousemove random off screen
	GoTo, CheckIfIdling
}
}
;This is end for loop

;---------------------------------------------------

;CallToForceExitApp is returned by SetTimer at top of script. CallToForceExitApp will logout and ExitApp.
CallToForceExitApp:
pixelsearch, CTFADetermineLogedinX, CTFADetermineLogedinY, 637, 337, 647, 347, 0x57FF00, 3, Fast ; Checks if im logged in. Checks if the HP indicator is up, if it is then i am logged on, if it isnt then i am at the logout screen. In future i should change this to check something in logout screen.
	If (errorlevel=0) {
		RSLogout()
		Sleep RandomSleepForLogoutTimer
		FileAppend, `n CallToForceExitApp Detected im logged in. Logged out `, exited app. Current time %A_TickCount%, errorlog.txt
		
		ExitApp
	}
	Else If (errorlevel=1) {
		Sleep RandomSleepForLogoutTimer
		FileAppend, `n CallToForceExitApp Detected im logged out. Exited app. Current time %A_TickCount%, errorlog.txt
		ExitApp
	}
	Else {
		Sleep RandomSleepForLogoutTimer
		FileAppend, `n CallToForceExitApp had error level that was not 0 or 1. Current time %A_TickCount%, errorlog.txt
		ExitApp
	}

ExitApp
2::Reload
3::ExitApp
4::Pause


;Always scan for idle
;if idle take a short sleep then find fishing spot, otherwise scan for idle
;find fishing spot, pick random coordinate, verify its color
