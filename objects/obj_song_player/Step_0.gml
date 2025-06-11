/// @description play loop

if (room == rm_fight_cpu || room == rm_fight_pvp) exit;

if ((!audio_is_playing(bgm_main_loop) && !audio_is_playing(bgm_main_intro)) && interacted && playing) {
	//show_message("PLAYING");
	audio_play_sound(bgm_main_loop, 50, true);
	audio_play_sound(bgm_main_loop_filter, 50, true);
}
if (!cheer && playing && audio_is_playing(bgm_main_intro)) {
	show_debug_message(audio_sound_get_track_position(introBgm));
	if (audio_sound_get_track_position(introBgm) >= 4.4) {
		//alarm[1] = -1;
		//room_goto(rm_menu);
		playCrowd();
	}
}
