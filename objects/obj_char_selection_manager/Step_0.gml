/// @description Insert description here
// You can write your code in this editor

if (!initialized) exit;

/*
var _fightersSelected = 0;

with (obj_char_select_menu) {
	if (selected) _fightersSelected += 1;
}

show_debug_message(_fightersSelected)

if (_fightersSelected == playerNumber && !starting) {
	alarm[0] = game_get_speed(gamespeed_fps) * 2;
	starting = true;
}
*/

if (starting && objFadeOut.ended) {
	room_goto(targetRoom);
}
