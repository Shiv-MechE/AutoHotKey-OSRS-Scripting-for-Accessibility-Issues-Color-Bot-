;In Runelite Plugins: Search for "RuneLite". Go to its settings. Go all the way to the bottom and click "Reset". We want this back to defaults.
;In Runelite: Search for "Tile Indicators" plugin. Go all the way to the bottom and click "Reset". Activate this plugin if not already active. Go to settings for this plugin. Select "Highlight current true tile". Deselect other 2 highlight options. Change "Color of Current True Tile Highlighting" to 00FF57. When selecting color it might appear as "FF00FF57" which is ok.
;In Runelite: Search for "NPC Indicators" plugin. Go all the way to the bottom and click "Reset". Activate this plugin if not already active. In NPCs to Highlight type "Chicken". Change "Highlight Color" to FF00FA. Make sure "Highlight Hull" is only thing selected under "Render Style". 
;In Runelite: Search for "Opponent Information" plugin. Go to the bottom and click "Reset". Activate this plugin if not already active. When attacking foes, this overlay will appear on screen and show you opponent's/chicken's health. Make sure this overlay is located in its default position on the top-left.
;In Runelite: Search for "Low Detail" plugin. Make sure its activated.
;Try not to have other overlays or markers active that can confuse the script.
;Best camera placement is facing West. Have camera at a high position (hold Up Arrow Key).
;Set the ScriptOverallRunTime variable to how long you want the script to run before logout. Set the time in Milliseconds. Make sure the negative sign stays there. "ScriptOverallRunTime:=-60000" is correct. "ScriptOverallRunTime:=60000" is incorrect.
;Keep all AHK files in 1 folder.
;Choose a world where there arnt many people for best script performance.
;Strongly suggest botting a max 1-2hrs in a single session (take breaks).
;Strongly suggest not botting excessively in a single day, especially if your account is new.
;Strongly suggest playing at reasonable hours for your IP location. I.g. if you'r IP is in Italy, bot sometime between 9am and 12pm Italy time.



CoordMode, Mouse, Window
CoordMode, Pixel, Window
SetWorkingDir %A_ScriptDir%
#Warn
#SingleInstance, Force

;Script Specific Variables SET THESE
random, AboutAMinute, 50345, 65423
TimeAtScriptStart := A_TickCount
TimeSinceLastAttack := A_TickCount
AttackChickenTries:=0
CoordPickerTries:=0
random, ScriptOverallRunTimeT, -18700000, -20700000
ScriptOverallRunTime:=ScriptOverallRunTimeT ;Time is in milliseconds, i.g. 20700000=5hrs 45mins, 3600000=1Hour, 600000=10min. The negative sign is intentional, keep it.
Random, RandomSleepForLogoutTimer, 2300, 3200
HowManyTimesLoopWasRan=0
NoSleepAfterBank=0
FileAppend, `n ------------------------------------------ `n ------------------------------------------ `n ------------------------------------------ `n Script Start Current Time %A_TickCount% `n, errorlog.txt

;Functions
#include RandomBezier().ahk
#include RSLogoutChick().ahk
#include Clickch().ahk
#include Clickl().ahk
#include MullerAndUniformCordinateChooser().ahk
#include BorderSearch().ahk
#Include BankWindowDetect().ahk
#Include DetectRunEnergyChick().ahk
#Include rbezierdist().ahk
#Include DetectBorder().ahk
#Include DisconnectDetect().ahk
#Include RandChanceBreak().ahk
;#Include PathFishToBank().ahk
;#Include EnterAndLeaveHosidiusFishBank().ahk
;#Include PathBankToFish().ahk



1::
;Timer for logging out and ExitApp 5 seconds after logout
SetTimer, CallToForceExitApp, %ScriptOverallRunTime%

sleep, RandomSleepForLogoutTimer

;Main Script ---------------------------------------------
Loop
{
Random, ThisISJustForANewSeedLol, 1, 4142467295
Random, ,ThisISJustForANewSeedLol
HowManyTimesLoopWasRan:=HowManyTimesLoopWasRan+1
TimeElapsedSinceScriptStart := A_TickCount-TimeAtScriptStart
FileAppend, `n - `n Below is the %HowManyTimesLoopWasRan% loop and time elapsed since script start is %TimeElapsedSinceScriptStart% milliseconds and current tickcount is %A_TickCount%, errorlog.txt
ElapsedTimeSinceLastAttack := A_TickCount - TimeSinceLastAttack
If (ElapsedTimeSinceLastAttack>=AboutAMinute) {
	FileAppend, `n  ElapsedTimeSinceLastAttack was %ElapsedTimeSinceLastAttack% logging out because stuck or elapsed time more than a minute since last attack, errorlog.txt
	GoTo, CallToForceExitApp
}

DetectRunEnergyChick()

Random, WhichQuad, 0, 500
ScanForChickens:
AttackChickenTries:=0
;will try to pick a random quadrant, and have it scan from closest to me to outards.

;Quadrant 1
If (WhichQuad>=0 AND WhichQuad<=100) {
PixelSearch, ChickenDetX, ChickenDetY, 335,239,653,34, 0xFF00FA, 10, Fast RGB ;Check if im idling, error 0 means idling.
If (errorlevel=0) {
	FileAppend, `n Q1 Chicken Detected, errorlog.txt
	CoordPickerTries:=0
	GoTo, AttackChicken
}
Else
	FileAppend, `n Q1 FAIL, errorlog.txt
	Continue
}

;Quadrant 2
Else If (WhichQuad>=100 AND WhichQuad<=200) {
PixelSearch, ChickenDetX, ChickenDetY, 320,238,0,0, 0xFF00FA, 10, Fast RGB ;Check if im idling, error 0 means idling.
If (errorlevel=0) {
	FileAppend, `n Q2 Chicken Detected, errorlog.txt
	CoordPickerTries:=0
	GoTo, AttackChicken
}
Else
	FileAppend, `n Q2 FAIL, errorlog.txt
	Continue
}

;Quadrant 3
Else If (WhichQuad>=200 AND WhichQuad<=300) {
PixelSearch, ChickenDetX, ChickenDetY, 319,251,7,459, 0xFF00FA, 10, Fast RGB ;Check if im idling, error 0 means idling.
If (errorlevel=0) {
	FileAppend, `n Q3 Chicken Detected, errorlog.txt
	CoordPickerTries:=0
	GoTo, AttackChicken
}
Else
	FileAppend, `n Q3 FAIL, errorlog.txt
	Continue
}

;Quadrant 4
Else If (WhichQuad>=300 AND WhichQuad<=400) {
PixelSearch, ChickenDetX, ChickenDetY, 334,254,653,457, 0xFF00FA, 10, Fast RGB ;Check if im idling, error 0 means idling.
If (errorlevel=0) {
	FileAppend, `n Q4 Chicken Detected, errorlog.txt
	CoordPickerTries:=0
	GoTo, AttackChicken
}
Else
	FileAppend, `n Q4 FAIL, errorlog.txt
	Continue
}

;-------------------------

;Full Top Left
Else If (WhichQuad>=400 AND WhichQuad<=425) {
PixelSearch, ChickenDetX, ChickenDetY, 0,0,651,461, 0xFF00FA, 10, Fast RGB ;Check if im idling, error 0 means idling.
If (errorlevel=0) {
	FileAppend, `n FTL Chicken Detected, errorlog.txt
	CoordPickerTries:=0
	GoTo, AttackChicken
}
Else
	FileAppend, `n FTL FAIL, errorlog.txt
	Continue
}

;Full Top Right
Else If (WhichQuad>=425 AND WhichQuad<=450) {
PixelSearch, ChickenDetX, ChickenDetY, 650,35,0,461, 0xFF00FA, 10, Fast RGB ;Check if im idling, error 0 means idling.
If (errorlevel=0) {
	FileAppend, `n FTR Chicken Detected, errorlog.txt
	CoordPickerTries:=0
	GoTo, AttackChicken
}
Else
	FileAppend, `n FTR FAIL, errorlog.txt
	Continue
}

;Full Bottom Left
Else If (WhichQuad>=450 AND WhichQuad<=475) {
PixelSearch, ChickenDetX, ChickenDetY, 0,461,650,35, 0xFF00FA, 10, Fast RGB ;Check if im idling, error 0 means idling.
If (errorlevel=0) {
	FileAppend, `n FBL Chicken Detected, errorlog.txt
	CoordPickerTries:=0
	GoTo, AttackChicken
}
Else
	FileAppend, `n FBL FAIL, errorlog.txt
	Continue
}

;Full Bottom Right
Else If (WhichQuad>=475 AND WhichQuad<=500) {
PixelSearch, ChickenDetX, ChickenDetY, 651,461,0,0, 0xFF00FA, 10, Fast RGB ;Check if im idling, error 0 means idling.
If (errorlevel=0) {
	FileAppend, `n FBR Chicken Detected, errorlog.txt
	CoordPickerTries:=0
	GoTo, AttackChicken
}
Else
	FileAppend, `n FBR FAIL, errorlog.txt
	Continue
}

AttackChicken:
ElapsedTimeSinceLastAttack := A_TickCount - TimeSinceLastAttack
If (ElapsedTimeSinceLastAttack>=AboutAMinute) {
	FileAppend, `n  ElapsedTimeSinceLastAttack was %ElapsedTimeSinceLastAttack% logging out because stuck, errorlog.txt
	GoTo, CallToForceExitApp
}

MullerAndUniformCordinateChooser(ChickenClickX, ChickenClickY, ChickenDetX-10, ChickenDetY-10, ChickenDetX+10, ChickenDetY+10, 20)
DetectBorder(ChickenClickX, ChickenClickY, 0xFF00FA)

If (CoordPickerTries>=50) {
	Continue
	FileAppend, `n Too many tries to Detect Border ATTACKCHICKEN, errorlog.txt
}

Else If (DetectBorderV=1){
	CoordPickerTries:=CoordPickerTries+1
	FileAppend, `n Failed detect border, errorlog.txt
	GoTo, AttackChicken
}

Else {
	FileAppend, `n Attempting to click chicken, errorlog.txt
	AttackChickenTries:=AttackChickenTries+1
	MouseMove, ChickenClickX, ChickenClickY,0
	If (DisconnectDetect()) {
		Continue
	}
	Clickch()
	If (ClicklV=0) {
		FileAppend, `n Red X, errorlog.txt
		RandChanceBreak()
		;MullerAndUniformCordinateChooser(SleepRedClick, SleepYellowClick, 4000, 80, 8000, 120, 90)
		;Sleep SleepRedClick
		MullerAndUniformCordinateChooser(SleepRedClick, SleepYellowClick, 5000, 80, 7000, 120, 90)
		DetectRunEnergyChick()
		;Sleep after clicking chicken
		sleep SleepRedClick
		GoTo, CheckIfIdling
	}
	Else if (AttackChickenTries>=20) {
		FileAppend, `n AttackChickenTries>=20, errorlog.txt
		DetectRunEnergyChick()
		;Sleep after misclicking chicken
		Sleep SleepYellowClick
		GoTo, ScanForChickens
	}
	Else 
		FileAppend, `n Yellow X, errorlog.txt
		Continue
}

CheckIfIdling:
;red in RL health bar: 621411
;green in RL health bar: 0A8633
;coord RL health bar color check x1,y1,x2,y2: 123,92,171,104
PixelSearch, CheckIfIdlingX, CheckIfIdlingY, 123,92,171,104, 0x631516, 10, Fast RGB ;Check if im idling, error 0 means idling.
If (errorlevel=0) {
	TimeSinceLastAttack := A_TickCount
	FileAppend, `n Doing Action...R, errorlog.txt
	Random, CheckIfIdlingRandSleep, 390, 610
	sleep CheckIfIdlingRandSleep
	;Random, RandomIdleAntiban, 1, 5
	;Random, RandomIdleAntibanPercent, 1, 1000
	;Check fishing xp
	;check friends list, if yellow detected
	;mousemove random on screen
	;mousemove random off screen
	GoTo, CheckIfIdling
}

Else if (errorlevel=1) {
PixelSearch, CheckIfIdlingX, CheckIfIdlingY, 123,92,171,104, 0x0A8633, 4, Fast RGB ;Check if im idling, error 0 means idling.
If (errorlevel=0) {
	TimeSinceLastAttack := A_TickCount
	FileAppend, `n Doing Action...G, errorlog.txt
	Random, CheckIfIdlingRandSleep, 390, 610
	sleep CheckIfIdlingRandSleep
	;Random, RandomIdleAntiban, 1, 5
	;Random, RandomIdleAntibanPercent, 1, 1000
	;Check fishing xp
	;check friends list, if yellow detected
	;mousemove random on screen
	;mousemove random off screen
	GoTo, CheckIfIdling
}
}

Else {
	FileAppend, `n Idle returning to top, errorlog.txt
	Continue
}


















FileAppend, `n This is end for loop, errorlog.txt
}
;This is end for loop

;---------------------------------------------------

;CallToForceExitApp is returned by SetTimer at top of script. CallToForceExitApp will logout and ExitApp.
CallToForceExitApp:
pixelsearch, CTFADetermineLogedinX, CTFADetermineLogedinY, 212, 155, 397, 312, 0x00F452, 20, Fast RGB; Checks if im logged in. Checks if the HP indicator is up, if it is then i am logged on, if it isnt then i am at the logout screen. In future i should change this to check something in logout screen.
	If (errorlevel=0) {
		RSLogoutChick()
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
2::
FileAppend, `n - `n You Pressed The Hotkey To Reload App, errorlog.txt
Reload
3::
FileAppend, `n - `n You Pressed The Hotkey To ExitApp, errorlog.txt
ExitApp
4::
FileAppend, `n - `n You Pressed The Hotkey To Pause App, errorlog.txt
Pause