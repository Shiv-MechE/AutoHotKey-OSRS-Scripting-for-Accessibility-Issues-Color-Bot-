; DisconnectDetect() Checks if disconnect.
; If disconnect detected, script will wait until reconnect
; If waiting for more than 60 seconds, it will exit script
; When returning to script, it will give a value of true so that you can use it to return to start of script.
; Main script should look as folos
; loop {
; 
; 		...
; 
; 	If (DisconnectDetect()) {
; 		Continue
; 	}
; 
; 		...
; 
; }
; 257, 61, 277, 76

DisconnectDetect() {
FileAppend, `n Disconnect Detect Called, errorlog.txt
DisconnectDetectStartTime:=A_TickCount
LoopCountDisconnectDetect:=0

Loop 1000 {
CurrentTime:=A_TickCount-DisconnectDetectStartTime
LoopCountDisconnectDetect:=LoopCountDisconnectDetect+1

If (CurrentTime>=73124) {
	FileAppend, `n Disconnect Detect CurrentTime Greater than 63121, errorlog.txt
	ExitApp
}

PixelSearch, DisconnectDetectX, DisconnectDetectY, 257, 61, 277, 76, 0x000000, 2, Fast RGB
If (errorlevel=0) {
	FileAppend, `n Disconnect Detect First Pixel Search Detected, errorlog.txt
	PixelSearch, DisconnectDetectX, DisconnectDetectY, 257, 61, 277, 76, 0xB7B7B7, 30, Fast RGB
	If (errorlevel=0) {
		FileAppend, `n Disconnect Detect Second pixel search detected, errorlog.txt
		random, DisconnectDetectSleep, 0, 5000
		sleep, DisconnectDetectSleep
		Continue
	}
	Else {
		FileAppend, `n DisconnectDetect Second Pixel Search not detected, errorlog.txt
		Break
	}
}
Else {
	FileAppend, `n DisconnectDetect First Pixel Search not detected, errorlog.txt
	Break
}
}


If (LoopCountDisconnectDetect<=1) {
	FileAppend, `n DisconnectDetect Second Return False, errorlog.txt
	Return, false
}
Else {
	FileAppend, `n DisconnectDetect Second Return True, errorlog.txt
	Return, true
}
}