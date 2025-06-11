/// @description Scale selected option

if (!enabled) exit;

if (exiting) {
	x = sine_between((current_time - exitStartAt) / 1000, 5, - room_width * 0.5, room_width * 1.8);
	if (x >= room_width * 1.7) {
		instance_destroy();
		room_goto(options[optionId, 2]);
	}
}

scale = sine_between(current_time / 1000, 3, 1, 1.05);
//angle = sine_wave(current_time / 1000, 6, 4, 0);
cursorScale = approach(cursorScale, 1, 0.2);
optIdXDisplace = approach(optIdXDisplace, 0, 25);

// Check held status 
var _navDirectionPress = (input.getDown()[0] - input.getUp()[0]);
var _navDirectionHeld = (input.getDown()[1] - input.getUp()[1]);

// Confirm
var _confirm = (input.getAction1()[0] || input.getStart()[0]);


if (selected) exit;

if (_confirm) {
	var _sound = getRandomAudio("snd_ui_confirm", 3);
	if (_sound != -1) audio_play_sound(_sound, 100, 0);
	if (options[optionId, 2] == -1) exit;
	show_debug_message("SELECT");
	selected = true;
	cursorScale = 2;
	optIdXDisplace = 250;
	optIdColorize = true;
	alarm[0] = game_get_speed(gamespeed_fps) * 0.05;
	alarm[1] = game_get_speed(gamespeed_fps) * 1;
} else if (_navDirectionPress != 0 || (_navDirectionHeld != 0 && alarm[2] == -1)) {
	var _sound = getRandomAudio("snd_guard", 4);
	if (_sound != -1) audio_play_sound(_sound, 100, 0);
	show_debug_message("CHANGE");
	if (_navDirectionPress == 1 || _navDirectionHeld == 1) {
		optionId = (optionId + 1 > maxOptionId) ? 0 : optionId + 1;
	} else {
		optionId = (optionId - 1 < 0) ? maxOptionId : optionId - 1;
	}
	alarm[2] = game_get_speed(gamespeed_fps) * navigationCooldown;
}
