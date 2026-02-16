; This will detect if the inventory is open for alching
; Will include a time since inventory detected variable
; Keep Alch items on top right of ivnentory
; Keep Natures on bottom right of ivnentory
; Keep coins on bottom left of ivnentory (MINIMUM OF 10,000 GP)
; Colors are in RGB

AlchInventoryDetect() {
FileAppend, `n AlchInventoryDetect() called, errorlog.txt

; Red on inventory icon color 76281E - 790, 247, 794, 254
; Pink on border of rune color A921A3 - 863, 568, 906, 611
; Yellow on coins color E0AB0D - 706, 567, 748, 606

TimeSinceInventorySeen := A_TickCount-InventoryCurrentTime
pixelsearch, t75648x, t75648y, 790, 247, 794, 254, 0x76281E, 70, Fast RGB ; Red on inventory icon color
If (Errorlevel=0) {
	pixelsearch, t78395x, t78395y, 863, 568, 906, 611, 0xA921A3, 70, Fast RGB ; Pink on border of rune color
	If (Errorlevel=0) {
		pixelsearch, t89898x, t89898y, 706, 567, 748, 606, 0xE0AB0D, 70, Fast RGB ; Yellow on coins color E0AB0D
		If (Errorlevel=0) {
			FileAppend, `n Inventory for Alching OPENED, errorlog.txt
			TimeSinceInventorySeen := A_TickCount-InventoryCurrentTime
			InventoryCurrentTime := A_TickCount
			;pixelsearch, t75648x, t75648y, 864, 339, 906, 229, 0xEE17DF, 25, Fast RGB ; Purple on alchable item to see if ran out of alchs
		}
		Else {
		FileAppend, `n Inventory CLOSED lvl 3, errorlog.txt
		}
	}
	Else {
	FileAppend, `n Inventory CLOSED lvl 2, errorlog.txt
	}
}
Else {
FileAppend, `n Inventory CLOSED lvl 1, errorlog.txt
}
Return
}