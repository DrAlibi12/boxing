/// @description Press

pressed = true;

// Conver to ms
var _holdTime = attackHoldTime / 1000;

if (fighter != noone && fighter.dizzy) {
	show_debug_message("PRESSING TO RECOVER");
	_holdTime = CPU_MANUAL_RECOVER_PRESS_SPEED;
}

alarm[1] = max(1, game_get_speed(gamespeed_fps) * _holdTime);

//show_debug_message(_holdTime);
//show_debug_message(alarm[1]);


