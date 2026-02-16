;This script was semi-inspired by scripts from the internet.

; This function returns a random coordinate from a rectangle defined by 2 points.
; The random coordinate is weighted towards a "Normal Gaussian Distribution" at the center of your rectangle.
; A uniform distribution will be used 10% of the time to account for potential deadspots at corners.
; Values returned will always be positive.
; Values returned will always be an integer. Rounded to nearest pixel to center to prevent values outside defined rectangle. 
; Due to rounding, there may be a 1 pixel border that is never chosen. In other words, the pixels making up the defined box may never be chosen.
;
; MAUCCcoordinatenamex: is the random x coordinate the function returns
; MAUCCcoordinatenamey: is the random y coordinate the function returns
; corner1x: X coordinate of TOP LEFT corner of the box you want a random cordinate
; corner1y: Y coordinate of TOP LEFT corner of the box you want a random cordinate
; corner2x: X coordinate of BOTTOM RIGHT corner of the box you want a random cordinate
; corner2y: Y coordinate of BOTTOM RIGHT corner of the box you want a random cordinate
; thctylq: Optional parameter defaults to 90. This is the % chance that normal distribution will be used to determine random coordinate as opposed to uniform distribution.
;
; For example: MullerAndUniformCordinateChooser(AbsorptionX, AbsorptionY, 865, 571, 905, 611)
; This will define AbsorptionX as possibly 878, and will define AbsorptionY as possibly 593
;
; If you want to test function you can run the following code with paint open:
; #include FILNAME.AHK     remember, "FILNAME.AHK" is whatever you save this file as.
; Loop 3000 {
; MullerAndUniformCordinateChooser(AbsorptionX, AbsorptionY, 865, 571, 905, 611)
; mousemove, AbsorptionX, AbsorptionY, 0
; click
; }



MullerAndUniformCordinateChooser(ByRef MAUCCcoordinatenamex, ByRef MAUCCcoordinatenamey, corner1x, corner1y, corner2x, corner2y, thctylq:=90) {
;Define some variables

PI:=3.142
centerx:=(corner1x+corner2x)/2
centery:=(corner1y+corner2y)/2
xhalfwidth:=centerx-corner1x
yhalfwidth:=centery-corner1y

;"mulleruniform" determines chance for point retrieved by normal distribution or uniform distribution

random, mulleroruniform, 1, 1000
thttylq:=thctylq*10

;Determining point by normal distribution

if	(mulleroruniform<=thttylq)
{
	loop {
	random, xrgm1, 0, 1.0
	random, xrgm2, 0, 1.0
	z0:=sqrt((-2)*ln(xrgm1))*cos(2*PI*xrgm2)
	if z0 between -2.38 and 2.38
		break
	}
	loop {
	random, xrgm1, 0, 1.0
	random, xrgm2, 0, 1.0
	z1:=sqrt((-2)*ln(xrgm1))*sin(2*PI*xrgm2)
	if z1 between -2.38 and 2.38
		break
	}
	
;Makes values always positive

	MAUCCcoordinatenamex:=abs((xhalfwidth/2.38)*z0+centerx)
	MAUCCcoordinatenamey:=abs((yhalfwidth/2.38)*z1+centery)
;Integer Rounding

	if (MAUCCcoordinatenamex<=centerx)
	{
		MAUCCcoordinatenamex:=Ceil(MAUCCcoordinatenamex)
	}
	Else
		MAUCCcoordinatenamex:=Floor(MAUCCcoordinatenamex)
	if (MAUCCcoordinatenamey<=centery)
		MAUCCcoordinatenamey:=Ceil(MAUCCcoordinatenamey)
	Else
		MAUCCcoordinatenamey:=Floor(MAUCCcoordinatenamey)
}

;Determining point by uniform distribution

Else 
{
	random, uniformchoicex, corner1x+xhalfwidth*.05, corner2x-xhalfwidth*.05
	random, uniformchoicey, corner1y+yhalfwidth*.05, corner2y-yhalfwidth*.05
	
;Makes values always positive

	MAUCCcoordinatenamex:=abs(uniformchoicex)
	MAUCCcoordinatenamey:=abs(uniformchoicey)
;Integer Rounding

	if (MAUCCcoordinatenamex<=centerx)
	{
		MAUCCcoordinatenamex:=Ceil(MAUCCcoordinatenamex)
	}
	Else
		MAUCCcoordinatenamex:=Floor(MAUCCcoordinatenamex)
	if (MAUCCcoordinatenamey<=centery)
		MAUCCcoordinatenamey:=Ceil(MAUCCcoordinatenamey)
	Else
		MAUCCcoordinatenamey:=Floor(MAUCCcoordinatenamey)
}
Return
}