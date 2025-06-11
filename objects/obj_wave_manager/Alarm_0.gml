/// @description Insert description here
// You can write your code in this editor

if (waveRemaining > 0 && instance_number(obj_fighter_minion) < 4) {
	spawnMinion();
	alarm[0] = game_get_speed(gamespeed_fps) * 2;
} if (waveRemaining == 0) {
	var _aliveMinions = 0;
	
	with (obj_fighter_minion) {
		if (hp > 0) _aliveMinions += 1;
	}
	
	if (_aliveMinions == 0) {
		// END WAVE LEVEL
		objMatchManager.setPlayerDefeated(2);
	}
}

