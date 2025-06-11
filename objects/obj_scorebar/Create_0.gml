/// @description Insert description here
// You can write your code in this editor

glowAlpha = 1;
glowAlphaTarget = 0;

scoreBarMax = 100;
scoreBarCur = 0;

fillXScale = 0;

function scoreBarInit(_maxValue) {
	scoreBarMax = _maxValue;
}

function scoreAdd(_add) {
	scoreBarCur += _add;
	scoreBarCur = max(min(scoreBarMax, scoreBarCur), 0);
	
	fillXScale = lerp(0, scoreBarMax, scoreBarCur / scoreBarMax) / scoreBarMax;
	
	glowAlpha = 1.5;
	glowAlphaTarget = 0;
	
	var _sound = (scoreBarCur == scoreBarMax) ? snd_score_full : snd_score_increase;
	
	audio_play_sound(_sound, 100, 0);
}

