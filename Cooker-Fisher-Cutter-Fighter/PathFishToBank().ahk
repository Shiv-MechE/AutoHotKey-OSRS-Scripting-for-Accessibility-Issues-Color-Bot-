;This function will walk me to hosidius bankf rom hosidiuos fish spot
;Tiles must be marked, and it will click random around marked tiles on minimap
;808,142 is player dot on map
;716,136 left most on map is 
;92 pixels difference on 
;Max distance i click away from blue on map should be 17
;map tile is 5 pixels accross the y axis


;CoordMode, Mouse, Window
;CoordMode, Pixel, Window
;SetWorkingDir %A_ScriptDir%
;#Warn
;#SingleInstance, Force
;#Include RSLogout().ahk
;#Include RandomBezier().ahk
;#Include Clickl().ahk
;#Include MullerAndUniformCordinateChooser().ahk
;#Include BorderSearch().ahk
;#Include BankWindowDetect().ahk
;#Include DetectRunEnergy().ahk
;#Include rbezierdist().ahk
;#SingleInstance, Force

PathFishToBank() {
PathFishToBankStartTime := A_TickCount

Loop {
ChooseTopOrBotPathToBank: ;this is only used as a start of path script, disregard the name
DetectRunEnergy()
PathFishToBankCurrentTime := A_TickCount-PathFishToBankStartTime
if (PathFishToBankCurrentTime>55000)
	exitapp
pixelsearch, BankPixelx, BankPixely, 0, 35, 650, 450, 0xC85271, 10, Fast
if (errorlevel=0) {
	Return
}
Else {
	GoTo, SearchMapForBlueDotToBank
}

SearchMapForBlueDotToBank:
Random, MapPixelSearchProbabilityFarClose, 1, 100
If MapPixelSearchProbabilityFarClose between 1 and 93 
{
	Random, FMPSP, 0, 3
	pixelsearch, BlueMapPixelx, BlueMapPixely, 718+FMPSP*10, 35, 718+(FMPSP+1)*10, 217, 0xFE0000, 10, Fast
	if (errorlevel=0)
		GoTo RandomBluePointMapToBank
	Else {
		GoTo ChooseTopOrBotPathToBank
	}
}
Else 
{
	Random, FMPSP, 4, 8
	pixelsearch, BlueMapPixelx, BlueMapPixely, 718+FMPSP*10, 35, 718+(FMPSP+1)*10, 217, 0xFE0000, 10, Fast
	if (errorlevel=0)
		GoTo RandomBluePointMapToBank
	Else {
		GoTo ChooseTopOrBotPathToBank
	}
}

RandomBluePointMapToBank:
MullerAndUniformCordinateChooser(RandFarMapPixelx, RandFarMapPixely, 718+FMPSP*10, BlueMapPixely-19, 718+(FMPSP+1)*10, BlueMapPixely+19, 2)
RBPMTBDistance:=sqrt((RandFarMapPixelx-808)**2+(RandFarMapPixely-142)**2)
MouseGetPos, RBPMTBcurx, RBPMTBcury
MouseGetPosDistance:=sqrt((RBPMTBcurx-808)**2+(RBPMTBcury-142)**2) ;distance from current mouse to map center
RBPMTBDistanceCurrent:=sqrt((RandFarMapPixelx-RBPMTBcurx)**2+(RandFarMapPixely-RBPMTBcury)**2) ;distance from current mouse to choosen mapmove coordinate
random, RBPMTBrandomousemove, 1, 100
If (RBPMTBDistance<=83) && (RBPMTBDistanceCurrent<=11) && (MouseGetPosDistance<=83)
{
	Clickl()
	GoTo PathFishToBankSleepBeforeRepeat
}
Else If (RBPMTBDistance<=83) && (RBPMTBrandomousemove>=99) {
	MullerAndUniformCordinateChooser(RandomMouseMisclickX, RandomMouseMisclickY, 748, 42, 870, 193, 39)
	rbezierdist(RandomMouseMisclickX, RandomMouseMisclickY)
	click down
	random, SomeRandomSleep, 10, 80
	sleep SomeRandomSleep
	click up
	rbezierdist(RandFarMapPixelx, RandFarMapPixely)
	Clickl()
	GoTo PathFishToBankSleepBeforeRepeat
	; This is a random chance to misclick on minimap
}
Else If (RBPMTBDistance<=83) {
	rbezierdist(RandFarMapPixelx, RandFarMapPixely)
	Clickl()
	if (RBPMTBrandomousemove<=27) {
		MullerAndUniformCordinateChooser(RBPMTBrandomousemovex, RBPMTBrandomousemovey, BlueMapPixelx-61, BlueMapPixely-66, BlueMapPixelx+67, BlueMapPixely+63, 50)
		sleep RBPMTBrandomousemove+40
		rbezierdist(RBPMTBrandomousemovex, RBPMTBrandomousemovey)
		GoTo PathFishToBankSleepBeforeRepeat
	}
	Else {
		GoTo PathFishToBankSleepBeforeRepeat
	}
}
Else {
	GoTo ChooseTopOrBotPathToBank
}

PathFishToBankSleepBeforeRepeat:
MullerAndUniformCordinateChooser(FarClickLongerSleep, CloseClickShorterSleep, 1560, 512, 4130, 1689, 47)		;this isnt choosing a coordinate. It is choosing a random sleep time.
If (FMPSP>=4) {
	sleep CloseClickShorterSleep
}
Else {
	sleep FarClickLongerSleep
}
GoTo ChooseTopOrBotPathToBank

}
}