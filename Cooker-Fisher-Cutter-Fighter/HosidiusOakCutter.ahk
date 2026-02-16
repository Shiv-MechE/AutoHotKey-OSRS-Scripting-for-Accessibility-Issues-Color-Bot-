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
#Include EnterandLeaveHosidiusFishBank().ahk



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
Random, SleepAfterLoopRestart, 2345, 6452
Sleep, SleepAfterLoopRestart


;Inventory Check If last inventory has item then proceed to bank. Else continue woodcutting.
CheckLastInventoryItemAndBank:
PixelSearch, LastInventoryItemPixelX, LastInventoryItemPixelY, 865, 571, 905, 611, 0xFF00FF, 20, Fast ;Search if last inventory slot is full
If (errorlevel=0) {
	FileAppend, `n CheckLastInventoryItemAndBank. Inventory full. Initiate banking Errorlevel=0. ,errorlog.txt
	Sleep 10
	GoTo, BankYourShit
}
Else if (errorlevel=2) {
	FileAppend, `n CheckLastInventoryItemAndBank. Errorlevel=2. Logging out/exiting script, errorlog.txt
	Sleep 10
	GoTo, CallToForceExitApp
}
Else {
	FileAppend, `n CheckLastInventoryItemAndBank. Inventory not full. Continue woodcutting. Errorlevel=1. ,errorlog.txt
	sleep 10
	GoTo, StartWoodcuttingChecks 
}


;Last inventory slot was detected full from CheckLastInventoryItemAndBank, proceed to banking
BankYourShit:
PixelSearch, BankerBankPixelX, BankerBankPixelY, 0, 40, 650, 450, 0x0D7DF2, 3, Fast ;Search screen for orange indicator (bank booth or banker)
random, ClickBankerBankX, BankerBankPixelX-65, BankerBankPixelX+65
random, ClickBankerBankY, BankerBankPixelY-25, BankerBankPixelY+110
;FileAppend, `n BankYourShit. ClickBankerBankX is %ClickBankerBankX% . ClickBankerBankY is %ClickBankerBankY% ,errorlog.txt
PixelSearch, ClickBankerBankXX, ClickBankerBankYY, ClickBankerBankX, ClickBankerBankY, ClickBankerBankX, ClickBankerBankY, 0x0D7DF2, 3, Fast ;Check if random bank cord is on bank
	If (errorlevel=1) {
		;FileAppend, `n BankYourShit. Random pixel was not on Bank. Will go back and search again. ,errorlog.txt
		GoTo, BankYourShit
	}
	Else If (errorlevel=2) {
		FileAppend, `n BankYourShit. Error Level 2. Some error prevented command from running search, errorlog.txt
		GoTo, CallToForceExitApp
	}
	Else {
		FileAppend, `n BankYourShit. Random pixel was on Bank. Will proceed to click it. ,errorlog.txt
	}
Random, BYSSleepBeforeStart, 1589, 13452
Sleep, BYSSleepBeforeStart
Random, RandMouseOverToBankSpeed, 401, 602
RandomBezier(0, 0, ClickBankerBankXX, ClickBankerBankYY, "T"RandMouseOverToBankSpeed "RO P3-5")
Sleep 123
Clickl()
sleep 350
DetectBankWindowStartTime := A_TickCount
GoTo, DetectBankWindow

DetectBankWindow:
Random, RandDBWTimeElapsedThreshhold, 4356, 6789
ElapsedTime := A_TickCount - DetectBankWindowStartTime
If (ElapsedTime>=RandDBWTimeElapsedThreshhold) {
	GoTo, CheckIfIdling
}
Else {
PixelSearch, BankTravelOrangeX, BankTravelOrangeY, 0, 40, 650, 450, 0x0D7DF2, 3, Fast ;Check if orange from bank is present
If (errorlevel=1) {
	PixelSearch, BankTravelPurpleX, BankTravelPurpleY, 0, 40, 650, 450, 0xF000FE, 3, Fast ;Check if purple from oak tree is present
	If (errorlevel=1) {
		PixelSearch, CheckIfIdlingX, CheckIfIdlingY, 640, 239, 645, 244, 0x57FF00, 3, Fast ;Check if im idling, error 0 means idling. Therfore logged on.
		If (errorlevel=0) {
			FileAppend, `n DetectBankWindow. Bank window detected. ,errorlog.txt
			GoTo, DepositItemsCloseBankWindow
		}
		Else If (errorlevel=1) OR (errorlevel=2) {
			GoTo CallToForceExitApp
		}
		Else
			DBWTimeElapsed=DBWTimeElapsed+500
			GoTo, DetectBankWindow
	}
	Else
		DBWTimeElapsed=DBWTimeElapsed+500
		GoTo, DetectBankWindow
}
Else
	DBWTimeElapsed=DBWTimeElapsed+500
	GoTo, DetectBankWindow
}

DepositItemsCloseBankWindow:
Random, DBWSleepBeforeDepositAll, 465, 2345
Sleep, DBWSleepBeforeDepositAll
Random, RandMouseOverToDeposInvent, 684, 896
RandomBezier(0, 0, 557, 427, "T"RandMouseOverToDeposInvent "RO OT17 OB17 OL17 OR17 P3-5")
Clickl()
Random, DBWSleepBeforeCloseWindow, 120,278
Sleep DBWSleepBeforeCloseWindow
Random, RandMouseOverToBankX, 601, 801
RandomBezier(0, 0, 611, 65, "T"RandMouseOverToBankX "RO OT10 OB10 OL10 OR10 P3-5")
Sleep 112
Clickl()
NoSleepAfterBank=1
Sleep 500
GoTo StartWoodcuttingChecks


;Bank and oak tree must be visible at all times to continue
StartWoodcuttingChecks:
PixelSearch, BankPixelX, BankPixelY, 10, 40, 650, 450, 0x0D7DF2, 3, Fast ;Search for bank
	If (errorlevel=0) {
		PixelSearch, OakTreePixelX, OakTreePixelY, 10, 40, 650, 450, 0xF000FE, 3, Fast ;Search for Oak Tree
		If (errorlevel=0) {
			FileAppend, `n Bank and Tree Detected! Script start., errorlog.txt
			FileAppend, `n Initial Bank cords (%BankPixelX% `, %BankPixelY%). Initial Oak Cords (%OakTreePixelX%`,%OakTreePixelY%) , errorlog.txt
			GoTo, FindRandPixelOnTree
		}
		Else {
			FileAppend, `n Bank detected. Oak Tree NOT detected. Script start. Will sleep 200`, then go back to start of loop., errorlog.txt
			Sleep 200
			Continue
		}
	}
	Else {
		PixelSearch, OakTreePixelX, OakTreePixelY, 10, 40, 650, 450, 0xF000FE, 3, Fast
		If (errorlevel=0) {
			FileAppend, `n Bank NOT detected. Oak tree was detected. Script start., errorlog.txt
			GoTo, CallToForceExitApp
		}
		Else {
			FileAppend, `n Bank NOT detected. Oak tree NOT detected. Script start., errorlog.txt
			GoTo, CallToForceExitApp
		}
	}


;Tree and bank detected, store coordinate and proceed to click tree.
FindRandPixelOnTree:
random, ClickOakTreeX, OakTreePixelX-110, OakTreePixelX+110
random, ClickOakTreeY, OakTreePixelY-110, OakTreePixelY+110
FileAppend, `n FindRandPixelOnTree. ClickOakTreeX is %ClickOakTreeX% . ClickOakTreeY is %ClickOakTreeY% ,errorlog.txt
PixelSearch, ClickOakTreeXX, ClickOakTreeYY, ClickOakTreeX, ClickOakTreeY, ClickOakTreeX, ClickOakTreeY, 0xF000FE, 3, Fast ;Check if random oak tree cord is on oak
	If (errorlevel=0) {
		FileAppend, `n FIndRandPixelOnTree. Random pixel was on tree. Will proceed to click it. ,errorlog.txt
		GoTo, RandOakTreePixelFound
	}
	If (errorlevel=1) {
		;FileAppend, `n FIndRandPixelOnTree. Random pixel was not on tree. Will go back and search again. ,errorlog.txt
		GoTo, FindRandPixelOnTree
	}
	If (errorlevel=2) {
		FileAppend, `n FindRandPixelOnTree. Error Level 2. Some error prevented command from running search, errorlog.txt
		GoTo, CallToForceExitApp
	}


RandOakTreePixelFound:
Random, RITPFSleepBeforeStart, 1256, 13452
If (NoSleepAfterBank!=0) {
	Random, RITPFSleepBeforeStart, 689, 1345
	NoSleepAfterBank=0
}
Sleep, RITPFSleepBeforeStart
MouseGetPos, CurrentPixelColorX, CurrentPixelColorY
PixelGetColor, CurrentPixelColor, %CurrentPixelColorX%, %CurrentPixelColorY%
CurrentPosNewPosDistance:=sqrt((ClickOakTreeXX-CurrentPixelColorX)**2+(ClickOakTreeYY-CurrentPixelColorY)**2)
Random, ROTPFMouseChance, 1, 1000
FileAppend, `n RandOakTreePixelFound. Distance bt MouseCurrPos and oak tree pixel is %CurrentPosNewPosDistance%. ROTPFMouseChance is %ROTPFMouseChance%. ,errorlog.txt
PixelGetColor, TreePixelColor, ClickOakTreeXX, ClickOakTreeYY
FileAppend, `n FindRandPixelOnTree. CurrentPixelColor= %CurrentPixelColor% and TreePixelColor=%TreePixelColor%,errorlog.txt
If (CurrentPosNewPosDistance<90) && (CurrentPixelColor=TreePixelColor) && (ROTPFMouseChance<=783);If cursor close and on tree it will click without moving mouse (random weighted chance)
{
	Clickl()
	FileAppend, `n FindRandPixelOnTree. Mouse not moved`, cursor already on tree`, just clicked.,errorlog.txt
}
Else If (CurrentPosNewPosDistance<90) ;If cursor close and on tree it will click while moving mouse (random weighted chance)
{
	random, ROTPFCloseColorMatchMove, 89, 194
	RandomBezier(0, 0, ClickOakTreeXX, ClickOakTreeYY, "T"ROTPFCloseColorMatchMove "RO P2")
	Clickl()
	FileAppend, `n FindRandPixelOnTree. Cursor already on tree`, mouse still moved. ,errorlog.txt
}
Else If CurrentPosNewPosDistance between 90 and 300 ;If Cursor medium distance, it will just move mouse to new pixel
{
	random, ROTPFCloseColormatchMove, 254, 374
	RandomBezier(0, 0, ClickOakTreeXX, ClickOakTreeYY, "T"ROTPFCloseColormatchMove "RO P3-4")
	Clickl()
	FileAppend, `n FindRandPixelOnTree. Cursor is was medium distance to oak tree`, mouse moved. ,errorlog.txt
}
Else {
	random, ROTPFCloseColormatchMove, 534, 687
	RandomBezier(0, 0, ClickOakTreeXX, ClickOakTreeYY, "T"ROTPFCloseColormatchMove "RO P3-5")
	Clickl()
	FileAppend, `n FindRandPixelOnTree. Else. Cursor is probably further than medium distance. Mouse moved to oak tree. ,errorlog.txt
}

FileAppend, `n RandOakTreePixelFound. Clicked the oak tree pixel., errorlog.txt
Random, RandOakTreePixelFoundSleep, 5123, 6423
sleep, RandOakTreePixelFoundSleep
GoTo, CheckIfIdling


CheckIfIdling:
PixelSearch, CheckIfIdlingX, CheckIfIdlingY, 640, 239, 645, 244, 0x57FF00, 3, Fast ;Check if im idling, error 0 means idling.
If (errorlevel=0) {
	FileAppend, `n Detected idling. Return to top of loop., errorlog.txt
	Continue
}
else {
	Random, CheckIfIdlingRandSleep, 390, 610
	sleep CheckIfIdlingRandSleep
	;FileAppend, `n Chopping..., errorlog.txt
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