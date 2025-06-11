/// @description Blink selected option

if (!selected) {
	optIdColorize = false;
	exit;
}

optIdColorize = !optIdColorize;

alarm[0] = game_get_speed(gamespeed_fps) * 0.05;
