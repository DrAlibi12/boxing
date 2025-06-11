/// @description Press

locked = false;

pressed = true;

// var _max = MAX_HOLD_TIME / (1 + irandom(2)) / 1000;
//show_debug_message(_max);

// UNUSED
/*
var _minTime = MAX_DODGE_TIME / 1000;
if (fighter.guardHp < 3)
	_minTime = MAX_DODGE_TIME * 1.5 / 1000
*/

var _holdTime = random_range( //holdTimeMin / 1000, holdTimeMax / 1000);
	//MAX_DODGE_TIME * (1 + irandom(0.5)) / 1000,
	//(MAX_DODGE_TIME - (MAX_DODGE_TIME / random_range(2, 3))) / 1000,
	//MAX_DODGE_TIME / 1000,
	//_minTime,
	holdTimeMax / (1 + irandom(2)) / 1000,
	
	/// MODO BESTIA
	//(MAX_DODGE_TIME - (irandom(MAX_DODGE_TIME / 3))) / 1000

	/// TEST
	//(MAX_DODGE_TIME + MAX_DODGE_TIME * 0.1) / 1000

	// TEST HOOKS
	//MAX_HOLD_TIME * (1 + irandom(0.5)) / 1000
	
	// JAM VERSION
	holdTimeMax / (1 + irandom(2)) / 1000
);

if (fighter != noone && fighter.dizzy) {
	show_debug_message("PRESSING TO RECOVER");
	_holdTime = CPU_MANUAL_RECOVER_PRESS_SPEED;
}

alarm[1] = max(1, game_get_speed(gamespeed_fps) * _holdTime);

//show_debug_message(_holdTime);
//show_debug_message(alarm[1]);


