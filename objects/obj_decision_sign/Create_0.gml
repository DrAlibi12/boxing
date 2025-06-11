/// @description Insert description here
// You can write your code in this editor

appearing = false;
y = - sprite_get_height(sprite_index) div 2;

curResult = 1;

results[1] = 0;
results[2] = 0;
results[3] = 0;

function appear() {
	appearing = true;
	audio_play_sound(snd_paper, 100, 0);
}

function showNextResult(_winner) {
	//audio_play_sound(snd_guard01, 100, 0);
	audio_play_sound(snd_scribble, 100, 0);
	results[curResult] = _winner;
	curResult++;
}

