/// @description Insert description here
// You can write your code in this editor

color = c_black;
alphaInc = 0;
alpha = 0;

started = false;
ended = false;

function initFadeOut(_color, _seconds) {
	color = _color;
	alphaInc = 1 / (game_get_speed(gamespeed_fps) * _seconds);
	started = true;
}
