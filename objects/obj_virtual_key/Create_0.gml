/// @description init

input = noone;

SPEED = 4;

fighter = noone;

pressed = false;
released = false;

timeMin = game_get_speed(gamespeed_fps) * MAX_DODGE_TIME;
timeMax = game_get_speed(gamespeed_fps) * MAX_HOLD_TIME;

function isPressed() {
	return pressed;
}

function isReleased() {
	return released;
}

alarm[0] = game_get_speed(gamespeed_fps);
