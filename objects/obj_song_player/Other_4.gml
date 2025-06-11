/// @description Insert description here
// You can write your code in this editor

if (room != rm_intro && room != rm_menu && room != rm_char_selection && room != rm_training) {
	audio_stop_sound(bgm_main_intro);
	audio_stop_sound(bgm_main_loop);
	audio_stop_sound(bgm_main_intro_filter);
	audio_stop_sound(bgm_main_loop_filter);
	audio_stop_sound(snd_crowd);
	audio_play_sound(snd_crowd, 50, true);
	playing = false;
	exit;
}

// cheer = false;

if (!audio_is_playing(bgm_main_intro) && !audio_is_playing(bgm_main_loop)) {
	doFilter(false, 0);
	setVolume(BGM_MAX_VOLUME, 0);
	cheer = false;
	introBgm = audio_play_sound(bgm_main_intro, 50, false);
	audio_play_sound(bgm_main_intro_filter, 50, false);
	if (os_browser == browser_not_a_browser || interacted)
		playing = true;
} else {
	switch(room) {
		case rm_menu:
			doFilter(false, 500);
		break;
		case rm_training:
			doFilter(true, 500);
		break;
		case rm_training_shadow_boxing:
			doFilter(true, 500);
		break;
	}
}

