CoordMode, Mouse, Window
CoordMode, Pixel, Window
SetWorkingDir %A_ScriptDir%
#Warn
#SingleInstance, Force
#Include RSLogout().ahk
#Include RandomBezier().ahk
#Include Clickl().ahk
#SingleInstance, Force

1::
Loop {
random, xxx, 318, 335
random, yyy, 236, 255
random, speed, 2, 5
random, sleepxx, 180000, 280000
random, chancechance, 1,100
if (chancechance<56)
	clickl()
else
{
MouseMove,xxx,yyy,speed
	clickl()
}
sleep sleepxx

}
2::Reload
3::ExitApp
4::Pause