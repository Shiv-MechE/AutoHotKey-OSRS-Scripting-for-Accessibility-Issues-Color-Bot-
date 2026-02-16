; Detects black on run energy at around 70%
; If black detected, run energy is below 70%
; If black NOT detect, run energy is at or above 70%
; DetectRunEnergyV:=0 means run energy available, and not selected
; DetectRunEnergyV:=1 means run energy available, and already selected
; DetectRunEnergyV:=2 means run energy is kinda low (70% or below), and could or could not be selected
; 019ABE is the yellow run energy color to search in BGR


DetectRunEnergy() {
Global DetectRunEnergyV
DetectRunEnergyV:=3
PixelSearch, DetectRunEnergyX, DetectRunEnergyY, 701, 183, 704, 183, 0x131313, 8, fast
if (errorlevel=0) {
	DetectRunEnergyV:=2
}
else {
	PixelSearch, DetectRunSelectedX, DetectRunSelectedY, 704, 189, 728, 198, 0x019ABE, 40, fast
	If (errorlevel=0) {
		DetectRunEnergyV:=1
		}
	Else {
		DetectRunEnergyV:=0
	}
	
}
Random, ClickRunOrNot, 1, 100
If (DetectRunEnergyV=0) && (ClickRunOrNot<72) {
	Loop 300 {
	MullerAndUniformCordinateChooser(RandRunClickX, RandRunClickY, 712-15, 191-15, 712+15, 191+15, thctylq:=80)
	RandRunClickDist:=sqrt((RandRunClickX-712)**2+(RandRunClickY-191)**2)
	If (RandRunClickDist<=15) {
		rbezierdist(RandRunClickX, RandRunClickY)
		Clickl()
		Break
	}
	Else {
		Continue
	}
	}
}
Return
}