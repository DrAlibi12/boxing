/// @description Insert description here
// You can write your code in this editor


scale = sine_between(current_time / 1000, 3, 1, 1.05);

// Cancel
var _cancel1 = (menuInputs[0].getAction2()[0] || menuInputs[0].getSelect()[0]);
var _cancel2 = (menuInputs[1].getAction2()[0] || menuInputs[1].getSelect()[0]);
var _cancel = (_cancel1 || _cancel2);

if (_cancel) {
	optionCancel();
	exit;
}

// Check held status 
var _navDirectionPress1 = (menuInputs[0].getDown()[0] - menuInputs[0].getUp()[0]);
var _navDirectionHeld1 = (menuInputs[0].getDown()[1] - menuInputs[0].getUp()[1]);
var _navDirectionPress2 = (menuInputs[1].getDown()[0] - menuInputs[1].getUp()[0]);
var _navDirectionHeld2 = (menuInputs[1].getDown()[1] - menuInputs[1].getUp()[1]);

var _navDirectionPress = (_navDirectionPress1 != 0) ? _navDirectionPress1 : _navDirectionPress2;
var _navDirectionHeld = (_navDirectionHeld1 != 0) ? _navDirectionHeld1 : _navDirectionHeld2;

// Confirm
var _confirm1 = (menuInputs[0].getAction1()[0] || menuInputs[0].getStart()[0]);
var _confirm2 = (menuInputs[1].getAction1()[0] || menuInputs[1].getStart()[0]);
var _confirm = (_confirm1 != 0) ? _confirm1 : _confirm2;


if (_confirm) {
	var _sound = getRandomAudio("snd_ui_confirm", 3);
	if (_sound != -1) audio_play_sound(_sound, 100, 0);
	//if (options[optionId, 2] == -1) exit;
	
	if (optionId == 0) {
		optionConfirm();
	} else {
		optionCancel();
	}
	
} else if (_navDirectionPress != 0 || (_navDirectionHeld != 0 && alarm[3] == -1)) {
	var _sound = getRandomAudio("snd_guard", 4);
	if (_sound != -1) audio_play_sound(_sound, 100, 0);

	if (_navDirectionPress == 1 || _navDirectionHeld == 1) {
		optionId = (optionId + 1 > maxOptionId) ? 0 : optionId + 1;
	} else {
		optionId = (optionId - 1 < 0) ? maxOptionId : optionId - 1;
	}
	navigationEnabled = false;

	alarm[3] = game_get_speed(gamespeed_fps) * navigationCooldown;
}

