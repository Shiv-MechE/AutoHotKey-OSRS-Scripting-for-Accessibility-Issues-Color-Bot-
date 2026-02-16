CoordMode, Mouse, Window
CoordMode, Pixel, Window
SetWorkingDir %A_ScriptDir%
#Warn
#SingleInstance, Force
#Include RSLogout().ahk
#Include RandomBezier().ahk
#Include Clickl().ahk
#Include MullerAndUniformCordinateChooser().ahk
#Include BorderSearch().ahk
#Include BankWindowDetect().ahk
#Include DetectRunEnergy().ahk
#Include rbezierdist().ahk
#SingleInstance, Force

1::
loop 1000 {
MullerAndUniformCordinateChooser(rtx, rty, 400, 300, 500, 400, 80)
mousemove, rtx, rty,0
click
}



2::Reload
3::ExitApp
4::Pause