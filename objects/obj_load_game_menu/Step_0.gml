/// @description Scale selected option

scale = sine_between(current_time / 1000, 3, minScale, maxScale);
cursorScale = approach(cursorScale, 1, 0.2);
optIdXDisplace = approach(optIdXDisplace, 0, 25);

if (!enabled || menuInputs == noone) exit;

if (selected) exit;

// Cancel
var _cancel1 = (menuInputs[0].getAction2()[0] || menuInputs[0].getSelect()[0]);
var _cancel2 = (menuInputs[1].getAction2()[0] || menuInputs[1].getSelect()[0]);
var _cancel = (_cancel1 || _cancel2);

if (_cancel) {
	cancelLoad();
	exit;
}

// Check held status 
var _navDirectionPress1 = (menuInputs[0].getRight()[0] - menuInputs[0].getLeft()[0]);
var _navDirectionHeld1 = (menuInputs[0].getRight()[1] - menuInputs[0].getLeft()[1]);
var _navDirectionPress2 = (menuInputs[1].getRight()[0] - menuInputs[1].getLeft()[0]);
var _navDirectionHeld2 = (menuInputs[1].getRight()[1] - menuInputs[1].getLeft()[1]);

var _navDirectionPress = (_navDirectionPress1 != 0) ? _navDirectionPress1 : _navDirectionPress2;
var _navDirectionHeld = (_navDirectionHeld1 != 0) ? _navDirectionHeld1 : _navDirectionHeld2;

// Confirm
var _confirm1 = (menuInputs[0].getAction1()[0] || menuInputs[0].getStart()[0]);
var _confirm2 = (menuInputs[1].getAction1()[0] || menuInputs[1].getStart()[0]);
var _confirm = (_confirm1 != 0) ? _confirm1 : _confirm2;

if (_confirm) {
	confirmSelection();
} else if (_navDirectionPress != 0 || (_navDirectionHeld != 0 && alarm[2] == -1)) {
	var _sound = getRandomAudio("snd_guard", 4);
	if (_sound != -1) audio_play_sound(_sound, 100, 0);
	show_debug_message("CHANGE");
	if (_navDirectionPress == 1 || _navDirectionHeld == 1) {
		optionId = (optionId + 1 > maxOptionId) ? 0 : optionId + 1;
	} else {
		optionId = (optionId - 1 < 0) ? maxOptionId : optionId - 1;
	}
	// CHANGE FIGHTER PREVIEW
	//preview.setSelected(optionId);
	
	navigationEnabled = false;
	alarm[2] = game_get_speed(gamespeed_fps) * navigationCooldown;
}
