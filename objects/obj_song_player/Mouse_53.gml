/// @description Insert description here
// You can write your code in this editor

if (os_browser == browser_not_a_browser || interacted) exit;

interacted = true;

if (audio_is_playing(bgm_main_intro_filter) ||audio_is_playing(bgm_main_intro)
	|| audio_is_playing(bgm_main_loop_filter) ||audio_is_playing(bgm_main_loop)) exit;

if (room == rm_menu)
	alarm[0] = 2;
