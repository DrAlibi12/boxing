/// @description FIGHT END

if (defeatedPlayers[1] || defeatedPlayers[2]) {
	timer.stop();
	gameEnd = true;
} else exit;

if (objFightSetup.LEVEL_TYPE == LEVEL.WAVE) {
	alarm[3] = game_get_speed(gamespeed_fps) * 4;

	if (!(defeatedPlayers[1] && defeatedPlayers[2])) {
		// SET WINNER
		winner = (defeatedPlayers[1]) ? 2 : 1;
	}
}

if (array_contains([LEVEL.NORMAL, LEVEL.BOSS], objFightSetup.LEVEL_TYPE)) {
	//audio_play_sound(snd_bell_triple, 100, 0);
	//audio_play_sound(snd_crowd_victory, 100, 0);

	var _ko = instance_create_layer(room_width div 2, room_height div 2, "GUI", obj_ko);
	
	//roundText = "KNOCKOUT";
	// DEFAULT: DOBLE KO
	_ko.show(1);
	show_debug_message("DOUBLE K.O.");

	if (!(defeatedPlayers[1] && defeatedPlayers[2])) {
		// SET WINNER
		winner = (defeatedPlayers[1]) ? 2 : 1;
		
		with (obj_fighter) {
			if (playerId == other.winner) {
				alarm[0] = -1;
				alarm[1] = -1;
				alarm[2] = -1;
				alarm[3] = -1;
				alarm[6] = -1;
				
				attackInput.reset();
				dodgeInput.reset();
				status = FighterStatus.freeze;
			}
		}
		
		_ko.show(0);
		show_debug_message("K.O.");
		createEndOverlay(false);
	}
	//alarm[3] = game_get_speed(gamespeed_fps) * 4;
	alarm[2] = game_get_speed(gamespeed_fps) * 2;
	global.crowdShaker.shake(50, 0.1);
}

