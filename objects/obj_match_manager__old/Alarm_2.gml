/// @description SHOW WINNER BY POINTS

audio_play_sound(snd_bell_triple, 100, 0);

gameEnd = true;

// SHOW WINNER
p1.image_index = 7;
p1.depth = 100;
p2.image_index = 7;
p2.depth = 100;

if (winnerByPoints == 1) {
	p1.image_index = 4;
	p1.depth = -100;
} else if (winnerByPoints == 2) {
	p2.image_index = 4;
	p2.depth = -100;
}

alarm[3] = game_get_speed(gamespeed_fps) * 4;