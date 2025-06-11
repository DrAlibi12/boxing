/// @description Insert description here
// You can write your code in this editor

if (appearing) {
	//y = approach(y, DECISION_SIGN_Y, 4);
	y = lerp(y, DECISION_SIGN_Y, 0.2);
	if (abs(y - DECISION_SIGN_Y) <= 2) {
		y = DECISION_SIGN_Y;
		appearing = false;
	}
}