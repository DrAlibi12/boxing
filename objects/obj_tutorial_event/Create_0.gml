/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

startCallback = function() {
	show_debug_message("obj_tutorial_event callback is an empty function");
};

startCallbackExecuted = false;

stepCallback = -1;

function initEvent(_callback, _owner, _stepCallback=undefined) {
	owner = _owner
	startCallback = _callback;
	stepCallback = _stepCallback;
}

function runCallback(_endEventAfterSeconds=-1) {
	startCallback();
	startCallbackExecuted = true;
	if (_endEventAfterSeconds != -1)
		alarm[0] = max(1, game_get_speed(gamespeed_fps) * _endEventAfterSeconds);
}

