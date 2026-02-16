; This will detect if the mage book is open for alching
; Will include a time since mage book detected variable
; Spell filters ingame: Only select "Show utility" and "Show spells you lack magic level...."
; Colors are in RGB

AlchMageBookDetect() {
FileAppend, `n AlchMageBookDetect() called, errorlog.txt

; Green on low alchemy 339433 - 772, 322, 788, 330
; Red on supeheat item = AF1402 - 831, 326, 842, 335
; Alch color yellow on 3rd ball= FAF60C - 898, 324, 909, 334
; Brown on Enchant Crossbow 623F17 - 703, 308, 732, 339
; Red in spellbook icon color 77281E - 913, 246, 950, 282
TimeSinceMageBookSeen := A_TickCount-MageBookCurrentTime
pixelsearch, t35648x, t35648y, 772, 322, 788, 330, 0x339433, 70, Fast RGB ; Green check
If (Errorlevel=0) {
	pixelsearch, t89745x, t89745y, 831, 326, 842, 335, 0xAF1402, 70, Fast RGB ; Superheat check
	If (Errorlevel=0) {
		pixelsearch, t97685x, t97685y, 898, 324, 909, 334, 0xFAF60C, 70, Fast RGB ; Alch yellow check
		If (Errorlevel=0) {
			pixelsearch, t79858x, t79858y, 703, 308, 732, 339, 0x623F17, 70, Fast RGB ; Brown CB Check
			If (Errorlevel=0) {
				pixelsearch, t49854x, t49854y, 913, 246, 950, 282, 0x77281E, 70, Fast RGB ; Red Spellbook Icon Check
				If (Errorlevel=0) {
				FileAppend, `n MageBook for Alching OPENED, errorlog.txt
				TimeSinceMageBookSeen := A_TickCount-MageBookCurrentTime
				MageBookCurrentTime := A_TickCount
				}
				Else {
				FileAppend, `n MageBook CLOSED lvl 5, errorlog.txt
				}
			}
			Else {
			FileAppend, `n MageBook CLOSED lvl 4, errorlog.txt
			}
		}
		Else {
		FileAppend, `n MageBook CLOSED lvl 3, errorlog.txt
		}
	}
	Else {
	FileAppend, `n MageBook CLOSED lvl 2, errorlog.txt
	}
}
Else {
FileAppend, `n MageBook CLOSED lvl 1, errorlog.txt
}
Return
}