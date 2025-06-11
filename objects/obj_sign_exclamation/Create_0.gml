/// @description initialize sign

signVisible = false;
blinkEvery = 1;

function initBlink(_blinkEvery) {
	blinkEvery = _blinkEvery;
	alarm[0] = game_get_speed(gamespeed_fps) * blinkEvery;
}
