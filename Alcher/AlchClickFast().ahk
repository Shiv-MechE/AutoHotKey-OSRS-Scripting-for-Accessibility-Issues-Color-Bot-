; This will click at a slowish speed

AlchClickFast() {
Random, SomeChanceACN, 0, 1000
MullerAndUniformCordinateChooser(AlchClickFastSleep1, AlchClickFastSleep2, 11, 1347, 11, 50, 73)
If (SomeChanceACN<214) {
Sleep AlchClickFastSleep1
}
Else {
Sleep AlchClickFastSleep2
}
Clickl()
Return
}