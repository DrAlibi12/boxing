/// @description Insert description here
// You can write your code in this editor

audio_stop_all();

audio_play_sound(snd_fanfare_arcade_end, 100, 0);

alarm[0] = game_get_speed(gamespeed_fps) * 6;