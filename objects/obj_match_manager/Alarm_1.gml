/// @description Insert description here
// You can write your code in this editor

var _continue = true;

var _winner = 0;
with (obj_decision_sign) {
	if (curResult > 3) {
		_continue = false;
		if (other.alarm[2] == -1) other.alarm[2] = game_get_speed(gamespeed_fps);
		exit;
	}	
	//_winner = (other.p1.points[curResult] > other.p2.points[curResult]) ? 1 : 2;
	_winner = other.results[curResult];
	showNextResult(_winner);
}

alarm[1] = game_get_speed(gamespeed_fps);
