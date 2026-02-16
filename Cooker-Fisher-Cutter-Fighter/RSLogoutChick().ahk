;RSLogoutChick() Logs out of the game
RSLogoutChick() {
	1XLogDoorCorner := 790
	1YLogDoorCorner := 621
	2XLogDoorCorner := 823
	2YLogDoorCorner := 659
	Random, XLogDC, 1XLogDoorCorner, 2XLogDoorCorner
	Random, YLogDC, 1YLogDoorCorner, 2YLogDoorCorner
	random, sleep0, 101, 253
	sleep, sleep0
	
	MouseMove, XLogDC, YLogDC, 0
	random, sleep1, 170, 253
	sleep, sleep1
	Clickch()
	
	random, sleep2, 200, 600
	sleep, sleep2
	
	
	1XLogButtonCorner := 720
	1YLogButtonCorner := 556
	2XLogButtonCorner := 892
	2YLogButtonCorner := 594
	Random, XLogBC, 1XLogButtonCorner, 2XLogButtonCorner
	Random, YLogBC, 1YLogButtonCorner, 2YLogButtonCorner

	MouseMove, XLogBC, YLogBC, 0
	random, sleep3, 101, 253
	sleep, sleep3
	Clickch()
	random, sleep3, 101, 253
	sleep, sleep3
	Return
	
}