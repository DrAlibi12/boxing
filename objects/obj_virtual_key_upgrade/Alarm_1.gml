/// @description Release

locked = false;

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
//speedMin = 0.1;
//speedMax = 0.3;
var _moveAgainAfterTime = random_range(speedMin, speedMax);

if (fighter != noone && fighter.dizzy) {
	show_debug_message("CPU RECOVERING");
	_moveAgainAfterTime = CPU_MANUAL_RECOVER_RELEASE_SPEED;
}

alarm[0] = max(1, game_get_speed(gamespeed_fps) * _moveAgainAfterTime);

show_debug_message(alarm[0]);
