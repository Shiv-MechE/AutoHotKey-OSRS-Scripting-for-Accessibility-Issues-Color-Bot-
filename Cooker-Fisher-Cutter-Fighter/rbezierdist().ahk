; This will randombezier() by distance from target point.
; Greater the distance, greater the random speed to complete path, and greater the P value.

rbezierdist(xx2,yy2) {
MouseGetPos, MGPRBx, MGPRBy
RBdistance:=sqrt((MGPRBx-xx2)**2+(MGPRBy-yy2)**2)
If (RBdistance<=45) {
	Random, RBDRandMouseOverToBankSpeed, 33, 77
	RandomBezier(0, 0, xx2, yy2, "T"RBDRandMouseOverToBankSpeed "RO P1-2")
}
Else If (RBdistance<=90) {
	Random, RBDRandMouseOverToBankSpeed, 70, 180
	RandomBezier(0, 0, xx2, yy2, "T"RBDRandMouseOverToBankSpeed "RO P2-3")
}
Else If (RBdistance<=160) {
	Random, RBDRandMouseOverToBankSpeed, 160, 290
	RandomBezier(0, 0, xx2, yy2, "T"RBDRandMouseOverToBankSpeed "RO P2-3")
}
Else If (RBdistance<=260) {
	Random, RBDRandMouseOverToBankSpeed, 260, 510
	RandomBezier(0, 0, xx2, yy2, "T"RBDRandMouseOverToBankSpeed "RO P3-4")
}
Else
{
	Random, RBDRandMouseOverToBankSpeed, 400, 830
	RandomBezier(0, 0, xx2, yy2, "T"RBDRandMouseOverToBankSpeed "RO P3-6")
}
Return
}