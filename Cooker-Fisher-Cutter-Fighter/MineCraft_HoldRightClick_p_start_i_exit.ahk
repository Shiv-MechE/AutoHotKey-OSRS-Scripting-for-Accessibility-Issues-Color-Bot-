; p   will start script
; o   will reload script
; i   will exit script
; u   will pause script

CoordMode, Mouse, Window
CoordMode, Pixel, Window
SetWorkingDir %A_ScriptDir%
#Warn
#SingleInstance, Force

; the rgb color of sword to detect is B1AFAD
; RGB of empty hunger and health is 282828
; RGB of light brown in bread is BA8727
; Coords for 4th hunger from left to detect 1114, 906, 1087, 911
; Coords for 4th Heart from right to detect 809, 906, 818, 915
; invent slot 1 is 650, 979, 673, 1004
; invent slot 2 is 731, 979, 756, 1004
; invent slot 3 is 810, 979, 834, 1004
; invent slot 4 is 890, 979, 914, 1004
; invent slot 5 is 970, 979, 994, 1004
; invent slot 6 is 1050, 979, 1074, 1004
; invent slot 7 is 1130, 979, 1154, 1004
; invent slot 8 is 1210, 979, 1234, 1004
; invent slot 9 is 1290, 979, 1314, 1004
; 90000, 400000
; 10, 17


p::
loop 800 {
Random, SomeLongSleep, 90000, 900000
Random, SomeShortSleep1, 2145, 11323
;Random, SomeShortSleep2, 10583, 17910
;Random, SomeShortSleep3, 10145, 17323

;Random, RanSlot1, 1, 9
;Random, RanSlot2, 1, 9

Click, Down, Right
Sleep, SomeLongSleep
Click, Up, Right
sleep, SomeShortSleep1
}

; LIST OF FUNCTIONS HERE


ExitApp
]::Reload
i::
Click, Up, Right
ExitApp
u::Pause

