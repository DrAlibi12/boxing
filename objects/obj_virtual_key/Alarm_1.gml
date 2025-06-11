/// @description Release

released = true;
pressed = false;

/*
alarm[0] = irandom_range(
	game_get_speed(gamespeed_fps) * MAX_DODGE_TIME div 2 / 1000,
	game_get_speed(gamespeed_fps) * MAX_HOLD_TIME / 1000
);
*/

// OLD
//alarm[0] = game_get_speed(gamespeed_fps) * 0.05;
var _speedMin = 0.1;
var _speedMax = 0.3;
var _moveAgainAfterTime = random_range(_speedMin, _speedMax);

if (fighter != noone && fighter.dizzy) {
	show_debug_message("CPU RECOVERING");
	_moveAgainAfterTime = 0.1;
}

alarm[0] = game_get_speed(gamespeed_fps) * _moveAgainAfterTime;
//var _pressAgainAfter = random_range(MAX_CANCEL_TIME * (5 - SPEED) / 1000, MAX_CANCEL_TIME * (9 - SPEED) / 1000);
//alarm[0] = game_get_speed(gamespeed_fps) * _pressAgainAfter;


show_debug_message(alarm[0]);
