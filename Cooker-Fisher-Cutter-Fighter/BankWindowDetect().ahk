;Detects if bank window is open
;Returns BankWindowDetectV=0 if bank window detected
;Else Returns BankWindowDetectV=1 (bank window NOT detected)

BankWindowDetect() {
Global BankWindowDetectV
BankWindowDetectV:=2
PixelSearch, BankWindowDetectBWDX, BankWindowDetectBWDY, 608, 61, 615, 69, 0x010000, 50, fast 					;searches for black on X to close window
If (errorlevel=0) {
	PixelSearch, BankWindowDetectBWDX, BankWindowDetectBWDY, 609, 142, 623, 156, 0x060809, 50, fast 			;searches for black on up arrow in scroll
	If (errorlevel=0) {
		PixelSearch, BankWindowDetectBWDX, BankWindowDetectBWDY, 600, 100, 616, 112, 0x311430, 100, fast 		;searches for purple on wrench
		If (errorlevel=0) {
			PixelSearch, BankWndowDetectBWDX, BankWindowDetectBWDY, 48, 360, 80, 371, 0x397DAB, 50, fast 		;searches for orange on incinerate icon
			If (errorlevel=0) {
				PixelSearch, BankWindowDetectBWDX, BankWindowDetectBWDY, 66, 63, 92, 78, 0x2191F0, 50, fast 	;searches for orange on the bank capacity
				If (errorlevel=0) {
				BankWindowDetectV:=0
				;fileappend, %BankWindowDetectV% bank detected `n, color.txt 
				}
				Else {
				BankWindowDetectV:=1
				;fileappend, %BankWindowDetectV% bank not detected `n, color.txt 
				}
			}
			Else {
				BankWindowDetectV:=1
				;fileappend, %BankWindowDetectV% bank not detected `n, color.txt 
			}
		}
		Else {
			BankWindowDetectV:=1
			;fileappend, %BankWindowDetectV% bank not detected `n, color.txt 
		}
	}
	Else {
		BankWindowDetectV:=1
		;fileappend, %BankWindowDetectV% bank not detected `n, color.txt 
	}
}
Else {
	BankWindowDetectV:=1
	;fileappend, %BankWindowDetectV% bank not detected `n, color.txt 
}
Return
}