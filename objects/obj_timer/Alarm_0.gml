/// @description Decrease timer

time --;

if (time > 0) {
	alarm[0] = game_get_speed(gamespeed_fps);
} else {
	owner.timerEnd();
}
