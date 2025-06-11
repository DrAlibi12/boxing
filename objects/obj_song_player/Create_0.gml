/// @description init

interacted = false;

if (os_browser == browser_not_a_browser)
	interacted = true;

playing = false;
filtered = false;

introBgm = -1;
cheer = false;

function doFilter(_enable, _time=0) {
	filtered = _enable;
	if (!filtered) {
		audio_sound_gain(bgm_main_intro, BGM_MAX_VOLUME, _time);
		audio_sound_gain(bgm_main_loop, BGM_MAX_VOLUME, _time);
		audio_sound_gain(bgm_main_intro_filter, 0, _time);
		audio_sound_gain(bgm_main_loop_filter, 0, _time);
	} else {
		audio_sound_gain(bgm_main_intro, 0, _time);
		audio_sound_gain(bgm_main_loop, 0, _time);
		audio_sound_gain(bgm_main_intro_filter, BGM_MAX_VOLUME, _time);
		audio_sound_gain(bgm_main_loop_filter, BGM_MAX_VOLUME, _time);		
	}
}

/*
	_time -> miliseconds
	_stop -> wether to stop the song after the countdown
*/
function mute(_time=0, _stop=false) {
	audio_sound_gain(bgm_main_intro, 0, _time);
	audio_sound_gain(bgm_main_loop, 0, _time);
	audio_sound_gain(bgm_main_intro_filter, 0, _time);
	audio_sound_gain(bgm_main_loop_filter, 0, _time);
	alarm[0] = -1;
	if (_stop)
		alarm[2] = game_get_speed(gamespeed_fps) * _time / 1000;
	cheer = true;
}

function playCrowd() {
	cheer = true;
	audio_sound_gain(snd_intro_crowd, 0.6, 0);
	audio_play_sound(snd_intro_crowd, 50, false);
	audio_play_sound(snd_crowd, 50, true);
}

function setVolume(_volume=1, _time=0) {
	if (!filtered) {
		audio_sound_gain(bgm_main_intro, min(BGM_MAX_VOLUME, _volume), _time);
		audio_sound_gain(bgm_main_loop, min(BGM_MAX_VOLUME, _volume), _time);
		audio_sound_gain(bgm_main_intro_filter, 0, 0);
		audio_sound_gain(bgm_main_loop_filter, 0, 0);
	} else {
		audio_sound_gain(bgm_main_intro_filter, min(BGM_MAX_VOLUME, _volume), _time);
		audio_sound_gain(bgm_main_loop_filter, min(BGM_MAX_VOLUME, _volume), _time);
		audio_sound_gain(bgm_main_intro, 0, 0);
		audio_sound_gain(bgm_main_loop, 0, 0);
	}
}

alarm[1] = game_get_speed(gamespeed_fps) * 3.8;