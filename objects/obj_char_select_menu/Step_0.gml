/// @description Scale selected option

scale = sine_between(current_time / 1000, 3, minScale, maxScale);
cursorScale = approach(cursorScale, 1, 0.2);
optIdXDisplace = approach(optIdXDisplace, 0, 25);

if (!enabled || input == noone) exit;

// Check held status 
var _navDirectionPress = (input.getDown()[0] - input.getUp()[0]);
var _navDirectionHeld = (input.getDown()[1] - input.getUp()[1]);

// Confirm
var _confirm = (input.getAction1()[0] || input.getStart()[0]);

// Cancel
var _cancel = (input.getAction2()[0] || input.getSelect()[0]);

if (_cancel) {
	cancelSelection();
	exit;
}

if (selected) exit;

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
	preview.setSelected(optionId);
	
	navigationEnabled = false;
	alarm[2] = game_get_speed(gamespeed_fps) * navigationCooldown;
}
