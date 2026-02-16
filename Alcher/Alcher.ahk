;Runelite Tag Inventory item: Tag nature rune rgb color #FF00FA
;Spell filters ingame: Only select "Show utility" and "Show spells you lack magic level...."
;Put nats on bottom right most inventory slot, put alch items on top right most slot, coins on bottom left inventory
;Put the runelite window on the top left of screen

CoordMode, Mouse, Window
CoordMode, Pixel, Window
SetWorkingDir %A_ScriptDir%
#Warn
#SingleInstance, Force

;Script Specific Global Variables SET THESE
ScriptOverallRunTime:=-20700000 ;Time is in ms, 20700000=5hrs 45mins, 3600000=1Hour, 600000=10min
Random, RandomSleepForLogoutTimer, 2300, 3200
HowManyTimesLoopWasRan=0
NoSleepAfterBank=0
FileAppend, `n ------------------------------------------ `n, errorlog.txt

;Functions
#include RSLogout().ahk
#include Clickl().ahk
#include MullerAndUniformCordinateChooser().ahk
#Include rbezierdist().ahk
#Include DisconnectDetect().ahk
#Include RandChanceBreak().ahk
#Include RandomBezier().ahk
#Include AlchMageBookDetect().ahk
#Include AlchInventoryDetect().ahk
#Include LoggedInDetect().ahk
#Include TimingChecker().ahk
#Include AlchClickNormal().ahk
#Include AlchClickFast().ahk
#Include AlchClickSlow().ahk
#Include AlchClickNormal().ahk
#Include RandChanceMoveMouse().ahk

1::
;Timer for logging out and ExitApp 5 seconds after loggout, Times Should be around 5-6hrs (in terms of milliseconds)
SetTimer, CallToForceExitApp, %ScriptOverallRunTime%
Random, SomeSleep, 2354, 4564
Sleep, SomeSleep

;Define the global variables for timing
Global SomeVarDefinedInRandChanceBreak:=1
Global TimeSinceMageBookSeen := 0
Global MageBookCurrentTime := A_TickCount
Global TimeSinceInventorySeen := 0
Global InventoryCurrentTime := A_TickCount
Random, SomeCheckerThresholdShorter, 26000, 96000
Global SomeCheckerThresholdShorter
Random, SomeCheckerThresholdShorter, 26000, 96000
Global SomeCheckerThresholdLarger := 200000
Random, SomeCheckerThresholdLarger, 115000, 230000

Send {F6}
sleep RandomSleepForLogoutTimer
MullerAndUniformCordinateChooser(AlchClickX, AlchClickY, 885, 307, 901, 332, 50)
rbezierdist(AlchClickX, AlchClickY)

;Alch Spell Coordinates
;883, 309, 911, 336
;Item Coordinates
;868, 301, 905, 337
;Entire Screen 13, 41, 647, 450

;Main Script ---------------------------------------------
Loop {
Random, ThisISJustForANewSeedLol, 1, 4142467295
Random, ,ThisISJustForANewSeedLol
HowManyTimesLoopWasRan:=HowManyTimesLoopWasRan+1
FileAppend, `n Below is the %HowManyTimesLoopWasRan% loop, errorlog.txt

Random, ChanceForNormalFastSlow, 1, 1000

If (ChanceForNormalFastSlow<631) {
;Normal speed here
Random, NormalLoopCount, 989, 1759
Loop %NormalLoopCount% {
FileAppend, `n NormalSpeed, errorlog.txt
RandChanceMoveMouse()
LoggedInDetect()
DisconnectDetect()
TimingChecker()
AlchMageBookDetect()
AlchClickNormal()
AlchInventoryDetect()
RandChanceBreak()
If (SomeVarDefinedInRandChanceBreak=0) {
	Break
}
SomeVarDefinedInRandChanceBreak:=1
If (ChanceForNormalFastSlow<37) {
	LoggedInDetect()
	DisconnectDetect()
	AlchMageBookDetect()
	AlchClickFast()
	AlchInventoryDetect()
	RandChanceBreak()
	If (SomeVarDefinedInRandChanceBreak=0) {
		Break
	}
}
Else If (ChanceForNormalFastSlow>600) {
	LoggedInDetect()
	DisconnectDetect()
	TimingChecker()
	AlchMageBookDetect()
	AlchClickSlow()
	AlchInventoryDetect()
	RandChanceBreak()
	If (SomeVarDefinedInRandChanceBreak=0) {
	Break
	}
}
Else {
Continue
}
}
}

Else If (ChanceForNormalFastSlow>=631) && (ChanceForNormalFastSlow<746){
;Slow speed here
Random, SlowLoopCount, 782, 1132
Loop %SlowLoopCount% {
FileAppend, `n SlowSpeed, errorlog.txt
RandChanceMoveMouse()
LoggedInDetect()
DisconnectDetect()
TimingChecker()
AlchMageBookDetect()
AlchClickSlow()
AlchInventoryDetect()
RandChanceBreak()
If (SomeVarDefinedInRandChanceBreak=0) {
Break
}
If (ChanceForNormalFastSlow<660) {
	LoggedInDetect()
	DisconnectDetect()
	AlchMageBookDetect()
	AlchClickFast()
	AlchInventoryDetect()
	RandChanceBreak()
	If (SomeVarDefinedInRandChanceBreak=0) {
	Break
	}
}
Else If (ChanceForNormalFastSlow>710) {
	LoggedInDetect()
	DisconnectDetect()
	TimingChecker()
	AlchMageBookDetect()
	AlchClickNormal()
	AlchInventoryDetect()
	RandChanceBreak()
	If (SomeVarDefinedInRandChanceBreak=0) {
	Break
	}
}
Else {
Continue
}
}
}

Else If (ChanceForNormalFastSlow>=746) {
;Fast speed here
Random, FastLoopCount, 458, 863
Loop %FastLoopCount% {
FileAppend, `n FastSpeed, errorlog.txt
RandChanceMoveMouse()
LoggedInDetect()
DisconnectDetect()
TimingChecker()
AlchMageBookDetect()
AlchClickFast()
AlchInventoryDetect()
RandChanceBreak()
If (SomeVarDefinedInRandChanceBreak=0) {
Break
}
If (ChanceForNormalFastSlow<779) {
	LoggedInDetect()
	DisconnectDetect()
	TimingChecker()
	AlchMageBookDetect()
	AlchClickSlow()
	AlchInventoryDetect()
	RandChanceBreak()
	If (SomeVarDefinedInRandChanceBreak=0) {
	Break
	}
}
Else If (ChanceForNormalFastSlow>983) {
	LoggedInDetect()
	DisconnectDetect()
	TimingChecker()
	AlchMageBookDetect()
	AlchClickNormal()
	AlchInventoryDetect()
	RandChanceBreak()
	If (SomeVarDefinedInRandChanceBreak=0) {
	Break
	}
}
Else {
Continue
}
}
}

Else {
Continue
}


}
;This is end for loop

;---------------------------------------------------

;CallToForceExitApp is returned by SetTimer at top of script. CallToForceExitApp will logout and ExitApp.
CallToForceExitApp:
pixelsearch, t8678x, t8678y, 690, 50, 717, 70, 0xAB2B2D, 70, Fast RGB ; Red in compass
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