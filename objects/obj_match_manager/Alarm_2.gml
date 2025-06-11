/// @description SHOW WINNER SPOTLIGHT

audio_play_sound(snd_bell_triple, 100, 0);
audio_play_sound(snd_crowd_victory, 100, 0);

if (timeout) {	
	// SHOW WINNER
	p1.image_index = 7;
	p1.depth = 100;
	p2.image_index = 7;
	p2.depth = 100;
}

with (obj_fight_end_overlay) {
	endCallback();
}


// WINNER SET WIN STATUS
if (winner != noone) {
	with (obj_fighter) {
		if (playerId == other.winner) {
			// STATUS WIN
			alarm[4] = 1;
		}
	}
}

alarm[3] = game_get_speed(gamespeed_fps) * 4;
