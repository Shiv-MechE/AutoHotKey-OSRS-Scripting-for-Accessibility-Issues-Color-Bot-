
DetectBorder(qwedsax, qwedsay, ccoolleerr) {

Global DetectBorderV
DetectBorderV:=2

PixelSearch, rrx, rry, 0, qwedsay, qwedsax, qwedsay, ccoolleerr, 15, Fast RGB
if (errorlevel=0) {
	PixelSearch, rrx, rry, qwedsax, qwedsay, 1900, qwedsay, ccoolleerr, 15, Fast RGB
	if (errorlevel=0) {
		PixelSearch, rrx, rry, qwedsax, 175, qwedsax, qwedsay, ccoolleerr, 15, Fast RGB
		if (errorlevel=0) {
			PixelSearch, rrx, rry, qwedsax, qwedsay, qwedsax, 1000, ccoolleerr, 15, Fast RGB
			if (errorlevel=0) {
				DetectBorderV:=0
				Return
			}
		}
	}
}
DetectBorderV:=1
Return
}