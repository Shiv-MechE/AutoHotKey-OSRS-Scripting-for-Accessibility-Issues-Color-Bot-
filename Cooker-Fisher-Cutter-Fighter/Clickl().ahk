;This is a left click function.
;Depress length will be random.
;Random sleep times will be used before and after click.
;Random sleep time between left click down and left click up will be used to simulate depress length.
;Using http://instantclick.io/click-test it seems like my human click is between 40ms and 125ms.
;Using http://instantclick.io/click-test my laptop touchpads click is 130ms +- only 2ms.
;Using http://instantclick.io/click-test just "click" has a mousedown time of 10ms +- only 2ms.
;Using http://instantclick.io/click-test and "click, down" and "click, up" without sleep gives mousedown time of 10-33 ms.
;If it detects a red X from an osrs click, it will return ClicklV=0
;If it detects a yellow X from an osrs click (misclick), it will return ClicklV=1

Clickl() {
	Global ClicklV
	ClicklV:=2
	;FileAppend, `n Clickl(). Start, clickertest.txt
	Random, ClicklSleep1, 10, 60
	Random, ClicklSleep2, 80, 110
	Random, ClicklSleep3, 40, 210
	sleep ClicklSleep1
	click, down
	sleep ClicklSleep2
	MouseGetPos, MGPClicklx, MGPClicklxy
	MGPtopx:=MGPClicklx-5
	MGPtopy:=MGPClicklxy-5
	MGPbotx:=MGPClicklx+5
	MGPboty:=MGPClicklxy+5
	PixelSearch, MGPColorClicklx, MGPColorClickly, MGPtopx, MGPtopy, MGPbotx, MGPboty, 0x00FFFF, 5, fast ;searches for yellow on click
	If (errorlevel=0) {
		ClicklV:=1
		FileAppend, Clickl(). Misclick, clickertest.txt
	}
	Else if (errorlevel=1)
	{
		PixelSearch, MGPColorClicklx, MGPColorClickly, MGPtopx, MGPtopy, MGPbotx, MGPboty, 0x0000FF, 5, fast ;searches for red on click
		if (errorlevel=0) {
			ClicklV:=0
			;FileAppend, Clickl(). Target clicked, clickertest.txt
		}
		Else if (errorlevel=1)
		{
			ClicklV=1
			;FileAppend, Clickl(). Not yellow or red. count as misclick, clickertest.txt
		}
		Else
		{
			FileAppend, Clickl(). Errorlevel=2 on second pixelsearch in Clickl(), errorlog.txt
			ExitApp
		}
	}
	Else
	{
		FileAppend, Clickl(). Errorlevel=2 on 1st pixelsearch in Clickl()
		ExitApp
	}
	click, up
	sleep ClicklSleep3
	Return
}