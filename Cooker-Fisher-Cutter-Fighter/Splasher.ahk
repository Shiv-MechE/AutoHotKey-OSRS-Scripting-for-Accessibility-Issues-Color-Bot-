;Make npc marker FILL
;Get curse to be in 2nd row, leftmost part of mage book (deselect both Show spells you lack)

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
#include RandomBezier().ahk
#include RSLogout().ahk
#include Clickl().ahk
#include MullerAndUniformCordinateChooser().ahk
#include BorderSearch().ahk
#Include BankWindowDetect().ahk
#Include DetectRunEnergy().ahk
#Include rbezierdist().ahk
#Include DetectBorder().ahk
#Include DisconnectDetect().ahk
#Include RandChanceBreak().ahk



1::
;Timer for logging out and ExitApp 5 seconds after loggout, Times Should be around 5-6hrs (in terms of milliseconds)
SetTimer, CallToForceExitApp, %ScriptOverallRunTime%
Random, SomeSleep, 2354, 3564
Sleep, SomeSleep

;Main Script ---------------------------------------------
Loop {

;Curse spell. Change the below failsafe pixel search AND muller in ClickCurse
;706, 373, 729, 397 when using curse
;762, 294, 786, 314
;693, 322, 728, 348

;CurseSpell Color BGR #ED06A9

;Ogre. Change the muller in ClickOgre
;490, 282, 688, 478
;418, 261, 535, 443
;244, 268, 360, 448
;13, 41, 647, 450  Entire screen

Random, ThisISJustForANewSeedLol, 1, 4142467295
Random, ,ThisISJustForANewSeedLol
HowManyTimesLoopWasRan:=HowManyTimesLoopWasRan+1
FileAppend, `n Below is the %HowManyTimesLoopWasRan% loop, errorlog.txt

pixelsearch, SpellIconX, SpellIconY, 706, 373, 729, 397, 0xA906ED, 15, Fast RGB
If (errorlevel!=0) {
	FileAppend, `n SpellIcon color not detected. Runes likely ran out. Logging out and exiting app., errorlog.txt
	GoTo CallToForceExitApp
	ExitApp
}

ClickCurse:
FileAppend, `n ClickCurse, errorlog.txt
CurrentTimePreOgre:=A_TickCount
MullerAndUniformCordinateChooser(CurseSpellX, CurseSpellY, 706, 373, 729, 397, 80)
MullerAndUniformCordinateChooser(SomeRandomSleep, SpeedToCurse, 623, 500, 974, 900, 85)
RandomBezier(0,0,CurseSpellX,CurseSpellY,"T"SpeedToCurse "RO P1-3")
sleep SomeRandomSleep
;RandChanceBreak()
If (DisconnectDetect()) {
	Continue
}
Clickl()

ClickOgre:
FileAppend, `n ClickOgre, errorlog.txt
ClickOgreTimeElapsed:=A_TickCount-CurrentTimePreOgre
If (ClickOgreTimeElapsed>30000) {
	GoTo CallToForceExitApp
	ExitApp
}
MullerAndUniformCordinateChooser(OgreX, OgreY, 130, 162, 300, 315, 77)
DetectBorder(OgreX, OgreY, 0xFF00FA)
if (DetectBorderV=0) {
	Random, SpeedToOgre, 130, 320
	RandomBezier(0,0, OgreX, OgreY,"T"SpeedToOgre "RO P1-3")
	;RandChanceBreak()
	If (DisconnectDetect()) {
		Continue
	}
	Clickl()
}
Else {
GoTo ClickOgre
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