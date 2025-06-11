/// @description init

/*
objFightSetup = instance_find(obj_fight_setup, 0);
if (!instance_exists(objFightSetup))
	throw("obj_match_manager: NO obj_fight_setup EXISTS!");

selectionManager = instance_find(obj_char_selection_manager, 0);
if (!instance_exists(selectionManager))
	throw("obj_char_select_menu: NO OWNER (obj_char_selection_manager) EXISTS!");
*/

owner = noone;

isNewGame = false;

slotId = -1;

playerId = 1;

enabled = true;

objMainMenu = instance_find(obj_main_menu, 0);
menuInputs = objMainMenu.menuInputs;

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
unselectedScaleSub = 0.25;
unselectedAlphaSub = 0.25;

cursorScale = 1;

selected = false;

maxOptionId = 2;
optionQty = 3;
optionId = 0
optIdXDisplace = 0;
optIdColorize = false;

shaker = instance_create_layer(x, y, "GUI", obj_shaker);
shaker.init(x, y);
shaker.shake(1, 0);

x = (room_width - sprite_get_width(spr_portraits) * 2 - hMargin * 2) / 2;
y = room_height * 0.65;

cancelled = false;

function cancelLoad() {
	cancelled = true;
}

function startGame() {
	var _sound = getRandomAudio("snd_ui_confirm", 3);
	if (_sound != -1) audio_play_sound(_sound, 100, 0);
	show_debug_message("SELECT");
	
	enabled = false;

	selected = true;
	cursorScale = 2;
	optIdXDisplace = 250;
	optIdColorize = true;
	//global.selectedFighters[playerId] = optionId;
	
	//selectionManager.setSelectedPlayer(playerId, optionId);
	
	// LOAD GAME!!!!
	var _slotId = optionId;
	var _objArcade = instance_find(obj_arcade_progression, 0);
	_objArcade.startLoadedGame(_slotId);
	
	//with (obj_main_menu) {
	//	doRunOption();
	//}
	owner.doRunOption();
	
	// enabled = false;
	
	alarm[0] = game_get_speed(gamespeed_fps) * 0.05;
}

function confirmSelection() {
	enabled = false;
	
	if (isNewGame) {
		// IF GAME SLOT IS NOT EMPTY, SHOW CONFIRMATION
		if (global.GAME_STATE.storyModeSlots[optionId].DATETIME_STARTED != -1) {
			var _callbackFunction = function (_confirmed) {
				if (_confirmed) {
					global.GAME_STATE.storyModeSlots[optionId].startGame(optionId);
					
					startGame();
				} else {
					enabled = true;
				}
			}
	
			var _overwriteQuestion = getText(global.UI_TEXTS, "story_overwrite_msg");
			var _yes = getText(global.UI_TEXTS, "yes");
			var _no = getText(global.UI_TEXTS, "no");
			
			overlay = ConfirmationOverlay(id, _overwriteQuestion, _yes, _no, _callbackFunction);
			
			return;
		}
		
		startGame();
	} else {
		// IF LOADED GAME IS EMPTY, CANCEL
		if (global.GAME_STATE.storyModeSlots[optionId].DATETIME_STARTED == -1) {
			var snd_cancel = getRandomAudio("snd_nylon", 2);
			if (snd_cancel != -1) audio_play_sound(snd_cancel, 100, 0);
			show_debug_message("SELECT");
		
			enabled = true;
			return;
		}
		
		startGame();
	}
}

