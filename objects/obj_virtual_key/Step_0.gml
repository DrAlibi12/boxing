/// @description Insert description here
// You can write your code in this editor

if (fighter == noone) exit;

if (keyboard_check_pressed(vk_left)) {
	SPEED --;
}
if (keyboard_check_pressed(vk_right)) {
	SPEED ++;
}
SPEED = clamp(SPEED, 0.5, 4.5);

/*
if (fighter.status == FighterStatus.dizzy && alarm[1] == -1) {
	show_debug_message("CPU PROGRAMMED RECOVERY");
	pressed = true;
	// alarm[0] = -1;
	alarm[1] = 1;
	// alarm[2] = game_get_speed(gamespeed_fps) * 0.01;
}
*/