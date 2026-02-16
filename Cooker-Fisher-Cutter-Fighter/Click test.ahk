;This is a left click function.
;Depress length will be random.
;Random sleep times will be used before and after click.
;Random sleep time between left click down and left click up will be used to simulate depress length.
;Using http://instantclick.io/click-test it seems like my human click is between 40ms and 125ms.
;Using http://instantclick.io/click-test my laptop touchpads click is 130ms +- only 2ms.
;Using http://instantclick.io/click-test just "click" has a mousedown time of 10ms +- only 2ms.
;Using http://instantclick.io/click-test and "click, down" and "click, up" without sleep gives mousedown time of 10-33 ms.

CoordMode, Mouse, Window
CoordMode, Pixel, Window
SetWorkingDir %A_ScriptDir%
#Warn
#SingleInstance, Force

1::
Clicklv=2
;FileAppend, `n Clickl(). Start, clickertest.txt
Random, ClicklSleep1, 120, 478
Random, ClicklSleep2, 36, 96
Random, ClicklSleep3, 65, 405
sleep ClicklSleep1
click, down
MouseGetPos, MGPClicklx, MGPClicklxy
MGPtopx:=MGPClicklx-5
MGPtopy:=MGPClicklxy-5
MGPbotx:=MGPClicklx+5
MGPboty:=MGPClicklxy+5
sleep ClicklSleep2
click, up
sleep 50
PixelSearch, MGPColorClicklx, MGPColorClickly, MGPtopx, MGPtopy, MGPbotx, MGPboty, 0x00FFFF, 3, fast ;searches for yellow on click
If (errorlevel=0) {
    Clicklv=1
    ;FileAppend, Clickl(). Misclick, clickertest.txt
}
Else if (errorlevel=1)
{
    PixelSearch, MGPColorClicklx, MGPColorClickly, MGPtopx, MGPtopy, MGPbotx, MGPboty, 0x0000FF, 3, fast ;searches for red on click
    if (errorlevel=0) {
        Clicklv=0
        ;FileAppend, Clickl(). Target clicked, clickertest.txt
    }
    Else if (errorlevel=1)
    {
        Clicklv=1
        FileAppend, Clickl(). Not yellow or red. count as misclick, clickertest.txt
    }
    Else
    {
        Clicklv=1
        FileAppend, Clickl(). Errorlevel=2 on second pixelsearch in Clickl(), errorlog.txt
    }
}
Else
{
    Clicklv=1
    FileAppend, Clickl(). Errorlevel=2 on 1st pixelsearch in Clickl()
}
sleep ClicklSleep3


2::Reload
3::ExitApp
4::Pause