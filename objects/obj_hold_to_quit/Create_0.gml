/// @description Insert description here
// You can write your code in this editor

holdTime = 0;
holdTimeMax = 3000;

input = noone;

endCallback = undefined;

// GET TEXT FROM "ui.csv" & CURRENT LANGUAGE
text = getText(global.UI_TEXTS, "hold_to_skip");
textReplacement[0] = getText(global.UI_TEXTS, "key_space")
textReplacement[1] = getText(global.UI_TEXTS, "joy_start");

textActiveId = 0;

function initializeQuit(_playerIdInput, _endCallback) {
	input = createLocalMenuInputManager(
		_playerIdInput, global.PLAYER_KEYBOARD[_playerIdInput]
	);
	endCallback = _endCallback;
}
