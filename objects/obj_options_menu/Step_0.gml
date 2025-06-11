/// @description Scale selected option

if (array_length(menuInputs) == 0) exit;

// CHECK FULLSCREEN TO AVOID INCONSISTENCIES WITH 
// THE GLOBAL VARIABLE:
if (global.fullscreen != window_get_fullscreen()) {
	global.fullscreen = !global.fullscreen;
	if (!global.fullscreen) {
		window_set_size(1280, 720);
	}
}

if (exiting) {
	x = sine_between((current_time - exitStartAt) / 1000, 5, - room_width * 0.5, room_width * 1.8);
	if (x >= room_width * 1.7) {
		instance_destroy();
		
		var _targetRoom = options[optionId, 2];
		
		if (_targetRoom == rm_tutorial_demo && objArcade.CUR_FIGHT_ID > 0) {
			_targetRoom = rm_chapter_intro;
		}
		 
		room_goto(_targetRoom);
	}
}

scale = sine_between(current_time / 1000, 3, 1, 1.05);
//angle = sine_wave(current_time / 1000, 6, 4, 0);
cursorScale = approach(cursorScale, 1, 0.2);
optIdXDisplace = approach(optIdXDisplace, 0, 25);

if (!enabled) exit;

// Cancel
var _cancel1 = (menuInputs[0].getAction2()[0] || menuInputs[0].getSelect()[0]);
var _cancel2 = (menuInputs[1].getAction2()[0] || menuInputs[1].getSelect()[0]);
var _cancel = (_cancel1 || _cancel2);

if (_cancel) {
	cancel();
	exit;
}

// Check held status 
var _navDirectionPress1 = (menuInputs[0].getDown()[0] - menuInputs[0].getUp()[0]);
var _navDirectionHeld1 = (menuInputs[0].getDown()[1] - menuInputs[0].getUp()[1]);
var _navDirectionPress2 = (menuInputs[1].getDown()[0] - menuInputs[1].getUp()[0]);
var _navDirectionHeld2 = (menuInputs[1].getDown()[1] - menuInputs[1].getUp()[1]);

var _navDirectionPress = (_navDirectionPress1 != 0) ? _navDirectionPress1 : _navDirectionPress2;
var _navDirectionHeld = (_navDirectionHeld1 != 0) ? _navDirectionHeld1 : _navDirectionHeld2;

/*
// Confirm
var _confirm1 = (menuInputs[0].getAction1()[0] || menuInputs[0].getStart()[0]);
var _confirm2 = (menuInputs[1].getAction1()[0] || menuInputs[1].getStart()[0]);
var _confirm = (_confirm1 != 0) ? _confirm1 : _confirm2;
*/

var _navHorPress1 = (menuInputs[0].getLeft()[0] - menuInputs[0].getRight()[0]);
var _navHorHeld1 = (menuInputs[0].getLeft()[1] - menuInputs[0].getRight()[1]);
var _navHorPress2 = (menuInputs[1].getLeft()[0] - menuInputs[1].getRight()[0]);
var _navHorHeld2 = (menuInputs[1].getLeft()[1] - menuInputs[1].getRight()[1]);

var _navHorPress = (_navHorPress1 != 0) ? _navHorPress1 : _navHorPress2;
var _navHorHeld = (_navHorHeld1 != 0) ? _navHorHeld1 : _navHorHeld2;

if (_navHorPress != 0 || (_navHorHeld != 0 && alarm[3] == -1)) {
	var _sound = getRandomAudio("snd_guard", 4);
	if (_sound != -1) audio_play_sound(_sound, 100, 0);
	switch (optionId) {
		case 0: // FULLSCREEN SELECTION
			global.fullscreen = !global.fullscreen;
			window_set_fullscreen(global.fullscreen);

			if (!global.fullscreen) {
				window_set_size(1280, 720);
			}
		break;
		case 1: // MAIN VOLUME
			if (_navHorPress == 1 || _navHorHeld == 1) {
				global.masterVolume -= 0.1;
			} else {
				global.masterVolume += 0.1;
			}
			global.masterVolume = clamp(global.masterVolume, 0, 1);
			audio_master_gain(global.masterVolume);
		break;
		case 2: // LANGUAGE SELECTION
			if (_navHorPress == 1 || _navHorHeld == 1) {
				global.locale += 1;
			} else {
				global.locale -= 1;
			}
			if (global.locale < 0) {
				global.locale = LOCALE.ES;
			} else if (global.locale > 1) {
				global.locale = LOCALE.EN;
			}
		break;
	}
	navigationEnabled = false;
	alarm[3] = game_get_speed(gamespeed_fps) * navigationCooldown;
}

/*
if (_confirm) {
	var _sound = getRandomAudio("snd_ui_confirm", 3);
	if (_sound != -1) audio_play_sound(_sound, 100, 0);
	//if (options[optionId, 2] == -1) exit;
	
	// CHECK IF IT'S A STRING...
	if (object_exists(options[optionId, 3])) {
		visible = false;
		enabled = false;

		var _menuObject = options[optionId, 3];
		var _newMenu = instance_create_layer(0, 0, "GUI", _menuObject);
		_newMenu.owner = id;
		
		// If it's new game, set it on the menu
		if (optionId == 0) {
			_newMenu.isNewGame = true;
		}

		exit;
	}
	
	// doRunOption();
	
} else */
if (_navDirectionPress != 0 || (_navDirectionHeld != 0 && alarm[3] == -1)) {
	var _sound = getRandomAudio("snd_guard", 4);
	if (_sound != -1) audio_play_sound(_sound, 100, 0);
	show_debug_message("CHANGE");
	if (_navDirectionPress == 1 || _navDirectionHeld == 1) {
		optionId = (optionId + 1 > maxOptionId) ? 0 : optionId + 1;
	} else {
		optionId = (optionId - 1 < 0) ? maxOptionId : optionId - 1;
	}
	navigationEnabled = false;
	alarm[3] = game_get_speed(gamespeed_fps) * navigationCooldown;
}
