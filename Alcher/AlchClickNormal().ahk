; This will click at a normalish speed

AlchClickNormal() {
Random, SomeChanceACN, 0, 1000
MullerAndUniformCordinateChooser(AlchClickNomalSleep1, AlchClickNomalSleep2, 11, 1347, 20, 140, 73)
If (SomeChanceACN<132) {
Sleep AlchClickNomalSleep1
}
Else {
Sleep AlchClickNomalSleep2
}
Clickl()
Return
}