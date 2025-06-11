/// @description Insert description here
// You can write your code in this editor

color = c_black;
alphaInc = 0;
alpha = 1;

started = false;
ended = false;

function initFadeIn(_color, _seconds) {
	color = _color;
	alphaDec = 1 / (game_get_speed(gamespeed_fps) * _seconds);
	started = true;
}
