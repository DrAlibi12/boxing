/// @description Insert description here
// You can write your code in this editor

input.check();

if (input.is_held) {
	value = input.hold_time * 100 / input.max_hold_time;
}

if (input.is_released) {
	if (input.hold_time >= input.max_hold_time) {
		value = 100;
		room_goto(rm_menu);
	}
	value = 0;
}
