
EnterAndLeaveHosidiusFishBank() {
Global ClicklV
Global BankWindowDetectV
DetectRunEnergy()

pixelsearch, HosidiousFishBankDoorX,HosidiousFishBankDoorY, 0, 35, 650, 450, 0xEF00FD, 5, fast ;this scans for door
if (errorlevel=0) {
	Random, EALHFBSFHBDInitialRandomBezierSpeed, 211, 398
	RandomBezier(0, 0, HosidiousFishBankDoorX, HosidiousFishBankDoorY, "T"EALHFBSFHBDInitialRandomBezierSpeed "RO OT20 OB20 OL20 OR20 P2-5")
}

SearchForHosidiusBankDoor:
pixelsearch, HosidiousFishBankDoorX,HosidiousFishBankDoorY, 0, 35, 650, 450, 0xEF00FD, 5, fast ;this scans for door
if (errorlevel=0) {
	MullerAndUniformCordinateChooser(HFBDRandX, HFBDRandY, HosidiousFishBankDoorX-10, HosidiousFishBankDoorY-10, HosidiousFishBankDoorX+50, HosidiousFishBankDoorY+35, 50)
	pixelsearch, VerifyHFBDRandX, VerifyHFBDRandY, HFBDRandX, HFBDRandY, HFBDRandX, HFBDRandY, 0xEF00FD, 5, fast ;this scans for door
	if (errorlevel=0) {
		rbezierdist(HFBDRandX, HFBDRandY)
		Clickl()
		if (ClicklV=1) {
			GoTo SearchForHosidiusBankDoor
		}
		else {
			Loop 100 {
			Random, WaitingForDoorToOpenSleep, 70, 130
			sleep WaitingForDoorToOpenSleep
			pixelsearch, WFDTOSGFBDx,WFDTOSGFBDy, 0, 35, 650, 450, 0xEF00FD, 5, fast ;this scans for door
			if (errorlevel=0) {
				Continue
			}
			Else {
				pixelsearch, HosidiousFishBankX,HosidiousFishBankY, 0, 35, 650, 450, 0xC75271, 5, fast ;this scans for bank
				Random, EALHFBSFHBInitialRandomBezierSpeed, 170, 310
				RandomBezier(0, 0, HosidiousFishBankX, HosidiousFishBankY, "T"EALHFBSFHBInitialRandomBezierSpeed "RO OT20 OB20 OL20 OR20 P2-5")
				Break
			}
			}
		}
	}
	Else {
		GoTo SearchForHosidiusBankDoor
	}
}
Else {
	pixelsearch, HosidiousFishBankX,HosidiousFishBankY, 0, 35, 650, 450, 0xC75271, 5, fast ;this scans for bank
	Random, EALHFBSFHBInitialRandomBezierSpeed, 170, 310
	RandomBezier(0, 0, HosidiousFishBankX, HosidiousFishBankY, "T"EALHFBSFHBInitialRandomBezierSpeed "RO OT20 OB20 OL20 OR20 P2-5")
	GoTo SearchForHosidiusBank
}

SearchForHosidiusBank:
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
			Loop 100 {
			Random, WaitingForBankWindowToOpenSleep, 150, 220
			sleep WaitingForBankWindowToOpenSleep
			BankWindowDetect() ;this detects if bank window is open
			If (BankWindowDetectV=0) {
				GoTo DepositItemsHosFishBank
			}
			Else {
				pixelsearch, PlayerStuckIndicateX, PlayerStuckIndicateXY, 0, 35, 650, 450, 0x00CD00, 5, fast ;this scans for shaded green tile which will indicate player stuck outside
				if (errorlevel=0) {
					Sleep 1324
					GoTo SearchForHosidiusBankDoor
				}
				Else {
					Continue
				}
			}
			}
			Sleep 1112
			GoTo SearchForHosidiusBankDoor
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
;Take Feathers
MullerAndUniformCordinateChooser(TakeFeathersX, TakeFeathersY, 458, 366, 496, 400, 75)
rbezierdist(TakeFeathersX, TakeFeathersY)
Clickl()
Random, SleepAfterTakeFeathers, 100, 700
Sleep SleepAfterTakeFeathers
;Take Rod
MullerAndUniformCordinateChooser(TakeRodX, TakeRodY, 518, 366, 556, 400, 80)
rbezierdist(TakeRodX, TakeRodY)
Clickl()
Random, SleepAfterTakeFeathers, 300, 700
Sleep SleepAfterTakeFeathers
GoTo LeaveBankToFishSpot

LeaveBankToFishSpot:
random, LBTFSMapClick, 1, 100
If (LBTFSMapClick<50) {
	MullerAndUniformCordinateChooser(LBTFSMCx, LBTFSMCy, 872, 179, 882, 202, 1)
	rbezierdist(LBTFSMCx, LBTFSMCy)
	Clickl()
	GoTo LeavingBankDoorCheck
}
Else {
	MullerAndUniformCordinateChooser(LBTFSMCx, LBTFSMCy, 851, 195, 875, 206, 1)
	rbezierdist(LBTFSMCx, LBTFSMCy)
	Clickl()
	GoTo LeavingBankDoorCheck
}

LeavingBankDoorCheck:
sleep 200
pixelsearch, HosidiousFishBankDoorX,HosidiousFishBankDoorY, 0, 35, 650, 450, 0xEF00FD, 5, fast ;this scans for door
if (errorlevel=0) {
	Random, EALHFBLBDCInitialRandomBezierSpeed, 567, 876
	RandomBezier(0, 0, HosidiousFishBankDoorX, HosidiousFishBankDoorY, "T"EALHFBLBDCInitialRandomBezierSpeed "RO OT20 OB20 OL20 OR20 P2-5")
	pixelsearch, HosidiousFishBankDoorX,HosidiousFishBankDoorY, 0, 35, 650, 450, 0xEF00FD, 5, fast ;this scans for door
	MullerAndUniformCordinateChooser(HFBDRandX, HFBDRandY, HosidiousFishBankDoorX-10, HosidiousFishBankDoorY-10, HosidiousFishBankDoorX+50, HosidiousFishBankDoorY+35, 50)
	pixelsearch, VerifyHFBDRandX, VerifyHFBDRandY, HFBDRandX, HFBDRandY, HFBDRandX, HFBDRandY, 0xEF00FD, 5, fast ;this scans for door
	if (errorlevel=0) {
		rbezierdist(HFBDRandX, HFBDRandY)
		Clickl()
		if (ClicklV=1) {
			GoTo LeaveBankToFishSpot
		}
		else {
			Loop 100 {
			Random, WaitingForDoorToOpenSleep, 110, 145
			sleep WaitingForDoorToOpenSleep
			pixelsearch, WFDTOSGFBDx,WFDTOSGFBDy, 0, 35, 650, 450, 0xEF00FD, 5, fast ;this scans for door
			if (errorlevel=0) {
				Continue
			}
			Else {
				Break
			}
			}
		}
	}
	Else {
		GoTo LeavingBankDoorCheck
	}
}
Else {
	Random, somerandomsleep5t6t, 123, 155
	Sleep somerandomsleep5t6t
}

CheckIfLeftBank:
Loop 8 {
Random, somerandomsleep5t6t, 1542, 1940
Sleep somerandomsleep5t6t
pixelsearch, HosidiousFishBankX,HosidiousFishBankY, 0, 35, 650, 450, 0xC75271, 5, fast ;this scans for bank
if (errorlevel=0) {
	Continue
}
Else {
	Return
}
}
pixelsearch, HosidiousFishBankX,HosidiousFishBankY, 0, 35, 650, 450, 0xC75271, 5, fast ;this scans for bank
if (errorlevel=0) {
	GoTo LeaveBankToFishSpot
}
Else {
	Return
}



}
