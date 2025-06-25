/// @description init

objFightSetup = instance_find(obj_fight_setup, 0);
if (!instance_exists(objFightSetup))
	throw("obj_match_manager: NO obj_fight_setup EXISTS!");

selectionManager = instance_find(obj_char_selection_manager, 0);
if (!instance_exists(selectionManager))
	throw("obj_char_select_menu: NO OWNER (obj_char_selection_manager) EXISTS!");

playerId = 1;

enabled = true;

input = noone;
preview = noone;

navigationEnabled = true;
navigationCooldown = 0.15;

//x = room_width div 2;
//y = room_height div 2;

minScale = 1;
maxScale = 1.1;

scale = 1;
hMargin = CHAR_SELECTION_MENU_H_MARGIN;
vMargin = CHAR_SELECTION_MENU_V_MARGIN;

angle = 0;
//unselectedScale = 0.75;
unselectedScaleSub = 0.2;
unselectedAlphaSub = 0.25;

cursorScale = 1;

selected = false;

maxOptionId = 5;
optionQty = 5;
optionId = 0
optIdXDisplace = 0;
optIdColorize = false;

shaker = instance_create_layer(x, y, "GUI", obj_shaker);
shaker.init(x, y);
shaker.shake(1, 0);

function initSelectMenu(_playerId=1) {
	playerId = _playerId;
	
	var _xPosAdd = (playerId == 1) ? -1 : 1;
	x = room_width div 2 + (sprite_width div 2 + hMargin) * _xPosAdd;
	y = CHAR_SELECTION_MENU_Y;
	
	preview = instance_create_layer(PREVIEW_X, PREVIEW_Y, "FighterPreview", obj_fighter_preview);
	if (playerId != 1) {
		preview.x = room_width - PREVIEW_X;
		preview.image_xscale = -1;
	}
}

function assignInputKey(_playerId) {
	input = createLocalMenuInputManager(
		_playerId, global.PLAYER_KEYBOARD[_playerId]
	);
}

function cancelSelection() {
	if (!selected) {
		if (playerId == 2 && objFightSetup.PLAYER_IS_CPU[2]) {
			// Deselect player 1
			selectionManager.deselectPlayer(1);
			// Remove input from this (CPU) selector
			input = noone;
		} else {
			room_goto(rm_menu);
		}
	}
	
	selected = false;
	enabled = true;
	
	// Cancel selection 
	selectionManager.deselectPlayer(playerId);
}

function confirmSelection() {
	var _sound = getRandomAudio("snd_ui_confirm", 3);
	if (_sound != -1) audio_play_sound(_sound, 100, 0);
	show_debug_message("SELECT");
	// input.setDisabled(true);
	// input.reset();
	selected = true;
	cursorScale = 2;
	optIdXDisplace = 250;
	optIdColorize = true;
	global.selectedFighters[playerId] = optionId;
	
	selectionManager.setSelectedPlayer(playerId, optionId);
	
	// enabled = false;
	
	alarm[0] = game_get_speed(gamespeed_fps) * 0.05;
}