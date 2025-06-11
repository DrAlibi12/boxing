/// @description Insert description here
// You can write your code in this editor

audio_stop_all();

doFilter(false, 0);
setVolume(BGM_MAX_VOLUME, 0);
cheer = false;
introBgm = audio_play_sound(bgm_main_intro, 50, false);
audio_play_sound(bgm_main_intro_filter, 50, false);
audio_stop_sound(snd_crowd);
audio_play_sound(snd_crowd, 50, true);

playing = true;
