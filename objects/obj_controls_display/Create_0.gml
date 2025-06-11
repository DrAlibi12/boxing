/// @description Insert description here
// You can write your code in this editor

alpha = 1;
showP1 = false;
showP2 = false;
disappear = false;

alarm[0] = game_get_speed(gamespeed_fps) * 2;

function show(_showP1, _showP2) {
	showP1 = _showP1;
	showP2 = _showP2;
}
