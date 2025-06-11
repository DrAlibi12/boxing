/// @description Insert description here
// You can write your code in this editor

pressed = true;

alarm[2] = game_get_speed(gamespeed_fps) * 0.01;

if (fighter.status != FighterStatus.dizzy) {
	alarm[2] = -1;
	// OLD
	alarm[0] = game_get_speed(gamespeed_fps) * 0.05;
	//alarm[0] = game_get_speed(gamespeed_fps) * random_range(0.5, 3);
}