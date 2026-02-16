; This will click at a slowish speed

AlchClickSlow() {
Random, SomeChanceACN, 0, 1000
MullerAndUniformCordinateChooser(AlchClickSlowSleep1, AlchClickSlowSleep2, 11, 1347, 621, 935, 70)
If (SomeChanceACN<432) {
Sleep AlchClickSlowSleep1
}
Else {
Sleep AlchClickSlowSleep2
}
Clickl()
Return
}