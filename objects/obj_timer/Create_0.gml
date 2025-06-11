/// @description Insert description here
// You can write your code in this editor

fontEffect = {
	glowEnable : true,
	glosStart : 0,
	glowEnd : 256,
	glowColour : c_red,
	glowAlpha : 0.75
}
font_enable_effects(fnt_timer, true, fontEffect);

time = 0;
owner = noone;
timeString = "";

function init(_time, _owner) {
	time = _time;
	owner = _owner;
}

function start() {
	alarm[0] = game_get_speed(gamespeed_fps);
}

function timeToString() {
	var _min = time div 60;
	var _sec = (_min > 0) ? time - (60 * _min) : time;
	var _secStr = (_sec > 9) ? string(_sec) : "0" + string(_sec);
	return string(_min) + ":" + _secStr;
}

function stop() {
	alarm[0] = -1;
}