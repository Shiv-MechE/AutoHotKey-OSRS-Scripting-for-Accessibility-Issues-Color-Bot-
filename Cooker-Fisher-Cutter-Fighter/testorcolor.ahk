CoordMode, Mouse, Window
CoordMode, Pixel, Window
SetWorkingDir %A_ScriptDir%
#Warn
#SingleInstance, Force
#Include RSLogout().ahk
#Include RandomBezier().ahk
#Include Clickl().ahk
#Include MullerAndUniformCordinateChooser().ahk
#Include border_method.ahk
#Include BankWindowDetect().ahk
#SingleInstance, Force


1::
fileappend, `n ###### `n, color.txt
Loop 300 {
MullerAndUniformCordinateChooser(x13, y13, 301, 188, 433, 315, 0)
BorderSearch(x13, y13, 0x8E0240, 45)
If (BorderSearchV=0) {
	fileappend, IN BORDER `n, color.txt
	mousemove, x13, y13, 0
}
Else if (BorderSearchV=1) 
{
	fileappend, out `n, color.txt
}
Else if (BorderSearchV=2) 
{
	fileappend, BorderSearchV=2 `n, color.txt
}
Else
{
	fileappend, ------------- `n, color.txt
}

}

;Clickl()
;fileappend, %Clicklv% `n, color.txt

;Random,x1,0,30
;Random,x2,0,150
;Random,y1,0,30
;Random,y2,0,150
;CurrentPosNewPosDistance:=sqrt((x1-x2)**2+(y1-y2)**2)

;send {left down}
;sleep 1354
;send {left up}
;send {down down}
;sleep 1354
;send {down up}


;If (CurrentPosNewPosDistance<90) {
;	MsgBox, <90 and %CurrentPosNewPosDistance%
;}
;Else If CurrentPosNewPosDistance between 90 and 120 
;{
;	MsgBox, between 90 and 120 the value was %CurrentPosNewPosDistance%
;}
;Else {
;	MsgBox, else and %CurrentPosNewPosDistance%
;}
;PixelGetColor, TreePixelColor, x1, y1
;if (TreePixelColor=TreePixelColor) {
;	msgbox, match
;}
;else
;	msgbox, else

;ttt=6
;FileAppend, `n `n `n %ttt% `n, qwqw.txt
;loop 1000 {
;PixelSearch, LastInventoryItemPixelX, LastInventoryItemPixelY, 861, 572, 908, 611, 0x0000FF, ttt, Fast ;Search if last inventory slot is full
;if errorlevel=0
;	FileAppend, 0, qwqw.txt
;Else if errorlevel=1
;	FileAppend, 1, qwqw.txt
;Else if errorlevel=2
;	FileAppend, 2, qwqw.txt
;}
;Pause




;xx1:=145
;xx2:=345
;yy1:=546
;yy2:=247
;CurrentPosNewPosDistance:=sqrt((xx1-xx2)**2+(yy1-yy2)**2)
;MsgBox, %CurrentPosNewPosDistance%

;MouseGetPos, CurrentPixelColorX, CurrentPixelColorY
;PixelGetColor, CurrentPixelColor, %CurrentPixelColorX%, %CurrentPixelColorY%
;MsgBox, %CurrentPixelColor%, %CurrentPixelColorX%, %CurrentPixelColorY%
;random, tyuiuyt, 254, 375
;RandomBezier(0, 0, 10, 10, "T"tyuiuyt "RO P3-4")



2::Reload
3::ExitApp
4::Pause