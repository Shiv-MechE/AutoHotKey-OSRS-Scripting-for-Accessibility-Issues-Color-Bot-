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
ScriptOverallRunTime:=-1200000 ;Time is in ms, 20700000=5hrs 45mins, 3600000=1Hour, 600000=10min
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
;#Include PathFishToBank().ahk
;#Include EnterAndLeaveHosidiusFishBank().ahk
;#Include PathBankToFish().ahk



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
	GoTo SearchForHosidiusBank
}
Else if (errorlevel=2) {
	FileAppend, `n CheckLastInventoryItemAndBank. Errorlevel=2. Logging out/exiting script, errorlog.txt
	Sleep 10
	GoTo, CallToForceExitApp
}
Else {
	FileAppend, `n CheckLastInventoryItemAndBank. Inventory not full. Continue fishing. Errorlevel=1. ,errorlog.txt
	sleep 10
	GoTo, CookFoodOnStove 
}

SearchForHosidiusBank:
DetectRunEnergy()
pixelsearch, HosidiousFishBankX,HosidiousFishBankY, 0, 35, 650, 450, 0xC75271, 5, fast ;this scans for bank
if (errorlevel=0) {
	MullerAndUniformCordinateChooser(HFBRandX, HFBRandY, HosidiousFishBankX-10, HosidiousFishBankY-10, HosidiousFishBankX+40, HosidiousFishBankY+40, 50)
	pixelsearch, VerifyHFBRandX, VerifyHFBRandY, HFBRandX, HFBRandY, HFBRandX, HFBRandY, 0xC75271, 5, fast ;this scans for bank
	if (errorlevel=0) {
		rbezierdist(HFBRandX, HFBRandY)
		Clickl()
		if (ClicklV=1) {
			GoTo SearchForHosidiusBank
		}
		else {
			Loop 10 {
			Random, WaitingForBankWindowToOpenSleep, 500, 700
			sleep WaitingForBankWindowToOpenSleep
			BankWindowDetect() ;this detects if bank window is open
			If (BankWindowDetectV=0) {
				GoTo DepositItemsHosFishBank
			}
			Else {
				pixelsearch, PlayerStuckIndicateX, PlayerStuckIndicateXY, 0, 35, 650, 450, 0x00CD00, 5, fast ;this scans for shaded green tile which will indicate player stuck outside
				if (errorlevel=0) {
					Sleep 1324
					ExitApp
				}
				Else {
					Continue
				}
			}
			}
			Sleep 1112
			ExitApp
		}
	}
	Else {
		GoTo SearchForHosidiusBank
	}
}
Else {
	ExitApp
}

DepositItemsHosFishBank:
;Deposit Inventory
random, DIHBStartSleep, 500, 2000
MullerAndUniformCordinateChooser(DepositInventX, DepositInventY, 538, 407, 578, 446, 77)
rbezierdist(DepositInventX, DepositInventY)
Clickl()
Random, SleepAfterDepositInvent, 1200, 2120
Sleep SleepAfterDepositInvent
;Take Trout
;MullerAndUniformCordinateChooser(TakeFeathersX, TakeFeathersY, 458, 366, 496, 400, 75)
;rbezierdist(TakeFeathersX, TakeFeathersY)
;Clickl()
;Random, SleepAfterTakeFeathers, 250, 550
;Sleep SleepAfterTakeFeathers
;Take Rod
MullerAndUniformCordinateChooser(TakeRodX, TakeRodY, 518, 366, 556, 400, 80)
rbezierdist(TakeRodX, TakeRodY)
Clickl()
Random, SleepAfterTakeFeathers, 300, 700
Sleep SleepAfterTakeFeathers
GoTo LeaveBankToFishSpot

LeaveBankToFishSpot:
DetectRunEnergy()
pixelsearch, BlueMapPixelx, BlueMapPixely, 799, 100, 826, 130, 0xFE0000, 10, Fast
MullerAndUniformCordinateChooser(LBTFSMCx, LBTFSMCy, BlueMapPixelx-10, BlueMapPixely-8, BlueMapPixelx+13, BlueMapPixely+12, 95)
rbezierdist(LBTFSMCx, LBTFSMCy)
Clickl()
random, LBTFSsomerandomsleep, 220, 500
sleep LBTFSsomerandomsleep
pixelsearch, HosidiousFishBankDoorX,HosidiousFishBankDoorY, 0, 35, 650, 450, 0xEF00FD, 5, fast ;this scans for door
if (errorlevel=0) {
	pixelsearch, BlueMapPixelx, BlueMapPixely, 752, 69, 890, 143, 0xFE0000, 10, Fast
	MullerAndUniformCordinateChooser(LBTFSMCx, LBTFSMCy, BlueMapPixelx-4, BlueMapPixely-4, BlueMapPixelx+10, BlueMapPixely+6, 95)
	rbezierdist(LBTFSMCx, LBTFSMCy)
	Clickl()
}
random, LBTFSsomerandomsleep, 200, 600
sleep LBTFSsomerandomsleep
DetectRunEnergy()
pixelsearch, HosidiusStoveX, HosidiusStoveY, 0, 35, 650, 450, 0x0D7DF1, 5, fast ;this scans for stove
rbezierdist(HosidiusStoveX, HosidiusStoveY)
GoTo CookFoodOnStove

CookFoodOnStove:
pixelsearch, HosidiusStoveX, HosidiusStoveY, 0, 35, 650, 450, 0x0D7DF1, 5, fast ;this scans for stove
MullerAndUniformCordinateChooser(CookStoveX, CookStoveY, HosidiusStoveX-37, HosidiusStoveY, HosidiusStoveX+37, HosidiusStoveY+40, 10)
pixelsearch, VerifyCookStoveX, VerifyCookStoveY, CookStoveX, CookStoveY, CookStoveX, CookStoveY, 0x0D7DF1, 5, fast ;this scans for stove
if (Errorlevel=0) {
	rbezierdist(CookStoveX, CookStoveY)
	MouseGetPos, CFOSBCx, CFOSBCy
	pixelsearch, VerifyCFOSBCx, VerifyCFOSBCy, CFOSBCx, CFOSBCy, CFOSBCx, CFOSBCy, 0x0D7DF1, 10, fast
	if (errorlevel=0) {
	Clickl()
	}
	else {
	GoTo CookFoodOnStove
	}
}
Else {
	GoTo CookFoodOnStove
}
If (ClicklV=1) {
	GoTo CookFoodOnStove
}
MullerAndUniformCordinateChooser(ClickCookX, ClickCookY, 271, 529, 386, 611, 95)
rbezierdist(ClickCookX, ClickCookY)
Loop 40 {
	Random, DetectCookOptionsSleep, 450, 500 
	Sleep DetectCookOptionsSleep
	pixelsearch, CookDetectAllX, CookDetectAllY, 599, 488, 616, 500, 0xDBE0E4, 12, fast ;this scans for the ALL option in cooking option
	If (errorlevel=0) {
		pixelsearch, CookDetectBrownkX, CookDetectBrownkY, 337, 479, 346, 494, 0x203040, 12, fast ;this scans for the ALL option in cooking option
		If (errorlevel=0) {
			GoTo SelectCookFood
			Break
		}
		Else {
			Continue
		}
	}
	Else {
		Continue
	}
}

SelectCookFood:
pixelsearch, CookDetectAllX, CookDetectAllY, 599, 488, 616, 500, 0xDBE0E4, 12, fast ;this scans for the ALL option in cooking option
If (errorlevel=0) {
	pixelsearch, CookDetectBrownkX, CookDetectBrownkY, 337, 479, 346, 494, 0x203040, 12, fast ;this scans for the ALL option in cooking option
	If (errorlevel=0) {
		;MullerAndUniformCordinateChooser(ClickCookX, ClickCookY, 271, 529, 386, 611, 95)
		;rbezierdist(ClickCookX, ClickCookY)
		random, somerandosleepSCF, 130, 320
		sleep somerandosleepSCF
		Clickl()
		Sleep DetectCookOptionsSleep*2.5
	}
}
GoTo CheckIfIdling


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