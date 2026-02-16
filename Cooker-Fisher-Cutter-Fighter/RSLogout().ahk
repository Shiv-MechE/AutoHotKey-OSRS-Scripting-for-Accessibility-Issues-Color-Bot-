;RSLogout() Logs out of the game
RSLogout() {
	1XLogDoorCorner := 790
	1YLogDoorCorner := 621
	2XLogDoorCorner := 823
	2YLogDoorCorner := 659
	Random, XLogDC, 1XLogDoorCorner, 2XLogDoorCorner
	Random, YLogDC, 1YLogDoorCorner, 2YLogDoorCorner
	Random, RandomLogDoorSpeed, 678, 823
	RLogDS=T%RandomLogDoorSpeed%
	LogDoorBezierStringParamters="%RLogDS% RO P3-5"
	
	RandomBezier(0, 0, XLogDC, YLogDC, LogDoorBezierStringParamters)
	
	
	Clickl()
	
	
	1XLogButtonCorner := 720
	1YLogButtonCorner := 556
	2XLogButtonCorner := 892
	2YLogButtonCorner := 594
	Random, XLogBC, 1XLogButtonCorner, 2XLogButtonCorner
	Random, YLogBC, 1YLogButtonCorner, 2YLogButtonCorner
	Random, RandomLogButtonSpeed, 201, 321
	RLogBS=T%RandomLogButtonSpeed%
	LogButtomBezierStringParamters="%RLogBS% RO P3-5"

	RandomBezier(0, 0, XLogBC, YLogBC, LogButtomBezierStringParamters)
	
	
	Clickl()
	Return
	
}