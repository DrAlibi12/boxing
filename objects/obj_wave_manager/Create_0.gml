/// @description Initialize wave manager

objMatchManager = instance_find(obj_match_manager, 0);
player1 = instance_find(obj_fighter, 0);

waveLength = 20;
waveRemaining = waveLength;

function initWave(_waveLength) {
	waveLength = _waveLength;
	waveRemaining = waveLength;
	alarm[0] = game_get_speed(gamespeed_fps) * 5;
}

function spawnMinion() {
	waveRemaining -= 1;
	var _minion = instance_create_layer(P2_X_OUT, PLAYER_Y, "Bot", obj_fighter_minion);
	_minion.initFighter(2, irandom_range(6, 8), player1, true, 0);
	_minion.owner = id;
	_minion.status = FighterStatus.enterRing;
}
	
function minionDefeated() {
	show_debug_message("MINION DEFEATED");

	alarm[0] = game_get_speed(gamespeed_fps);
}

