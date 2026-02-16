;Dont forget to reset the logout timer that logs if stuck
;This will take random breaks of 0 ish mins to < 5 ish mins

RandChanceBreak() {

Random, ChanceBreak, 1, 10000
Random, ChanceBreakThreshold, 15, 30
FileAppend, `n ChanceBreak is %ChanceBreak% and ChanceBreakThreshold is %ChanceBreakThreshold%, errorlog.txt
If (ChanceBreak<ChanceBreakThreshold) {
	Random, SleepTime, 1359, 249746
	FileAppend, `n BREAK taking break of %SleepTime%ms. , errorlog.txt
	Sleep, SleepTime
	Global ElapsedTimeSinceLastAttack := 1
	Global TimeSinceLastAttack := A_TickCount
}
Return

}