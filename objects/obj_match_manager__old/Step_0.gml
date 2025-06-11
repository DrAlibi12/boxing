/// @description Insert description here
// You can write your code in this editor

if (gameEnd) exit;

var _winner = noone;

var _defeated = 0;
with (obj_fighter) {
	if (defeated) _defeated ++;
}

if (_defeated == 1) {
	with (obj_fighter) {
		if (hp > 0) {
			alarm[4] = game_get_speed(gamespeed_fps) * 2;
			_winner = id;
		}	
	}
}

if (_winner != noone || _defeated > 1) {
	timer.stop();
	gameEnd = true;
	audio_play_sound(snd_bell_triple, 100, 0);
	audio_play_sound(snd_crowd_victory, 100, 0);
	var _ko = instance_create_layer(room_width div 2, room_height div 2, "GUI", obj_ko);
	if (_defeated > 1) {		
		_ko.show(1);
		show_debug_message("DOUBLE K.O.");
	} else {
		_ko.show(0);
		show_debug_message("K.O.");
	}
	alarm[3] = game_get_speed(gamespeed_fps) * 4;
	global.crowdShaker.shake(50, 0.1);
}

