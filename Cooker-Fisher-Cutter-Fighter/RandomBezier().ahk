;THIS SCRIPT WAS FOUND ON THE INTERNET
/*
    RandomBezier.ahk
    Copyright (C) 2012,2013 Antonio França
    This script is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.
    This script is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.
    You should have received a copy of the GNU Affero General Public License
    along with this script.  If not, see <http://www.gnu.org/licenses/>.
*/

;========================================================================
; 
; Function:     RandomBezier
; Description:  Moves the mouse through a random Bézier path
; URL (+info):  --------------------
;
; Last Update:  30/May/2013 03:00h BRT
;
; Created by MasterFocus
; - https://github.com/MasterFocus
; - http://masterfocus.ahk4.net
; - http://autohotkey.com/community/viewtopic.php?f=2&t=88198
;
;========================================================================

;https://github.com/MasterFocus/AutoHotkey/tree/master/Functions/RandomBezier

; this must be added, typically put under other options, like the ones we went over at the start.

;RandomBezier(X1,Y1,X2,Y2,"Tq RO RD OTq OBq OLq ORq Pq")

;X1 and Y1 are your starting coordinates, your mouse will jump to those coordinates if they are different to the current cursor position
;X2 and Y2 are the destination coordinates

;Optional parameters (These must be inside the quotation marks and can be used in any order after the 2 sets of coordinates)
; q is used as a plaseholer for a number.

;Tq is the time it will take to move your mouse to the destination in milliseconds, default is T200
;RO means Relative Origin, which means the X1 and Y1 coordinates are relative to the cursor position, commonly used along with setting X1 and Y1 to 0
;RD means Relative Destination, which means the X2 and Y2 coordinates are relative to the cursor position, not commonly used
;OTq means offset top, which is the limit of how much higher the mouse could randomly move in pixels than the highest of the 2 given coordinates, Default is OT100
;OBq means offset bottom, which is the limit of how much lower the mouse could randomly move in pixels than the lowest of the 2 given coordinates, Default is OB100
;OLq means offset left, which is the limit of how far left the mouse could randomly move in pixels than the farthest left of the 2 given coordinates, Default is OL100
;ORq means offset right, which is the limit of how far right the mouse could randomly move in pixels than the farthest right of the 2 given coordinates, Default is OR100
;Pq Means the amount of points to be used to determine the path the mouse will take, Typically  used with lower numbers as there will be less chance of mouse moving back on itself, this can also be a range, Default is P2-5

;Example:
;RandomBezier(0,0,100,100,"T400 RO OT15 OB15 OL15 OR15 P3-4")

RandomBezier( X0, Y0, Xf, Yf, O="" ) {
    Time := RegExMatch(O,"i)T(\d+)",M)&&(M1>0)? M1: 200
    RO := InStr(O,"RO",0) , RD := InStr(O,"RD",0)
    N:=!RegExMatch(O,"i)P(\d+)(-(\d+))?",M)||(M1<2)? 2: (M1>19)? 19: M1
    If ((M:=(M3!="")? ((M3<2)? 2: ((M3>19)? 19: M3)): ((M1=="")? 5: ""))!="")
        Random, N, %N%, %M%
    OfT:=RegExMatch(O,"i)OT(-?\d+)",M)? M1: 100, OfB:=RegExMatch(O,"i)OB(-?\d+)",M)? M1: 100
    OfL:=RegExMatch(O,"i)OL(-?\d+)",M)? M1: 100, OfR:=RegExMatch(O,"i)OR(-?\d+)",M)? M1: 100
    MouseGetPos, XM, YM
    If ( RO )
        X0 += XM, Y0 += YM
    If ( RD )
        Xf += XM, Yf += YM
    If ( X0 < Xf )
        sX := X0-OfL, bX := Xf+OfR
    Else
        sX := Xf-OfL, bX := X0+OfR
    If ( Y0 < Yf )
        sY := Y0-OfT, bY := Yf+OfB
    Else
        sY := Yf-OfT, bY := Y0+OfB
    Loop, % (--N)-1 {
        Random, X%A_Index%, %sX%, %bX%
        Random, Y%A_Index%, %sY%, %bY%
    }
    X%N% := Xf, Y%N% := Yf, E := ( I := A_TickCount ) + Time
    While ( A_TickCount < E ) {
        U := 1 - (T := (A_TickCount-I)/Time)
        Loop, % N + 1 + (X := Y := 0) {
            Loop, % Idx := A_Index - (F1 := F2 := F3 := 1)
                F2 *= A_Index, F1 *= A_Index
            Loop, % D := N-Idx
                F3 *= A_Index, F1 *= A_Index+Idx
            M:=(F1/(F2*F3))*((T+0.000001)**Idx)*((U-0.000001)**D), X+=M*X%Idx%, Y+=M*Y%Idx%
        }
        MouseMove, %X%, %Y%, 0
        Sleep, 1
    }
    MouseMove, X%N%, Y%N%, 0
    Return N+1
}