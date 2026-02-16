;Tells you if your point is inside an outline with a given color.
;You should always get your outlin color by sampling it ingame.
;The color you select from the runelite/OpenOSRS plugins might not be the same as ingame.
;Works by seeing if the border is present to the left, right, up, and down directions.
;Is default formatted to window mode on the OSRS playable area. Playable area is from points (0,40) to (650,450)
;
;Will return BorderSearchV:=0 if within outline, BorderSearchV:=1 if outside outline
;
;BSpointX is the X coordinate of the point
;BSpointY is the Y coordinate of the point
;BSpointColor is the color of your border in BGR 0xXXXXXX. E.g.: If exactly white, you would write 0xFFFFFF.
;Below are optional variables.
;BSsearchThreshold is the PixelSearch variation, defaulted to 50.
;BSsearchBound1x is x value of the top left point of your search area, default is the playable OSRS screen.
;BSsearchBound1y is y value of the top left point of your search area, default is the playable OSRS screen.
;BSsearchBound2x is x value of the bottom right point of your search area, default is the playable OSRS screen.
;BSsearchBound2y is y value of the bottom right point of your search area, default is the playable OSRS screen.

BorderSearch(BSpointX, BSpointY, BSpointColor, BSsearchThreshold:=50, BSsearchBound1x:=0, BSsearchBound1y:=40, BSsearchBound2x:=650, BSsearchBound2y:=450) {
Global BorderSearchV
BorderSearchV:=2
PixelSearch, rrx, rry, BSsearchBound1x, BSpointY, BSpointX, BSpointY, BSpointColor, BSsearchThreshold, fast
if (errorlevel=0) {
	PixelSearch, rrx, rry, BSpointX, BSpointY, BSsearchBound2x, BSpointY, BSpointColor, BSsearchThreshold, fast
	if (errorlevel=0) {
		PixelSearch, rrx, rry, BSpointX, BSsearchBound1y, BSpointX, BSpointY, BSpointColor, BSsearchThreshold, fast
		if (errorlevel=0) {
			PixelSearch, rrx, rry, BSpointX, BSpointY, BSpointX, BSsearchBound2y, BSpointColor, BSsearchThreshold, fast
			if (errorlevel=0) {
				BorderSearchV:=0
				fileappend, %BorderSearchV% %BSpointX% %BSpointY% %BSpointColor% `n, tk.txt
			}
			else
			{
				BorderSearchV:=1
				fileappend, %BorderSearchV% %BSpointX% %BSpointY% %BSpointColor% `n, tk.txt
			}
		}
		else
		{
			BorderSearchV:=1
			fileappend, %BorderSearchV% %BSpointX% %BSpointY% %BSpointColor% `n, tk.txt
		}
	}
	else
	{
		BorderSearchV:=1
		fileappend, %BorderSearchV% %BSpointX% %BSpointY% %BSpointColor% `n, tk.txt
	}
	
}
else
{
	BorderSearchV:=1
	fileappend, %BorderSearchV% %BSpointX% %BSpointY% %BSpointColor% `n, tk.txt
}
Return
}