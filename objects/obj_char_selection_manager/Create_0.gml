/// @description Init Character Selection Manager

objFightSetup = instance_find(obj_fight_setup, 0);
if (!instance_exists(objFightSetup))
	throw("obj_match_manager: NO obj_fight_setup EXISTS!");

initialized = false;
starting = false;
playerNumber = 1;

drawInputKey2 = objFightSetup.PLAYER_IS_CPU[2];

selectionMenues[1] = noone;
selectionMenues[2] = noone;

fightersSelected[1] = noone;
fightersSelected[2] = noone;

targetRoom = -1;

objFadeOut = instance_create_layer(0, 0, "Foreground", obj_fade_out);

instance_create_layer(0, 0, "Back", obj_select_your_fighter_msg);

function deselectPlayer(_playerId, _reassignInput=false) {
	fightersSelected[_playerId] = noone;
	enabled = true;
	/*
	if (objFightSetup.PLAYER_IS_CPU[2]) {
		alarm[1] = 2;
		return;
	}
	*/
}

function setSelectedPlayer(_playerId, _fighterId) {
	fightersSelected[_playerId] = _fighterId;
	
	/*
	// HOW TO DETERMINE PLAYER 2 IF THERE'S ONLY 1 PLAYER TO SELECT?
	// DEFINE THIS FOR ARCADE MODE MENU
	if (playerNumber == 1) {		
	}
	*/
	
	var _player1Fighter = obj_fighter;
	var _player2Fighter = obj_fighter;
	
	if (_playerId == 1 && objFightSetup.PLAYER_IS_CPU[2]) {
		alarm[1] = 2;
		return;
	}
	
	if (fightersSelected[1] != noone && fightersSelected[2] != noone) {
		// Avoid cancelling selection after both player selected a fighter
		with (obj_char_select_menu) enabled = false;
		
		objFightSetup.fightSetFighters(
			_player1Fighter, fightersSelected[1],
			_player2Fighter, fightersSelected[2]
		);
		alarm[0] = game_get_speed(gamespeed_fps) * 2;
		starting = true;
	}
}

function initGameStarter(_players/*, _targetRoom*/) {
	playerNumber = _players;
	initialized = true;
	// targetRoom should be "targetScenario". Scenarios include room + background + size + crowd data
	// Should be decided by "Select Scenario Screen"
	targetRoom = rm_fight; // _targetRoom;
	
	for (var _i=1; _i <= _players; _i++) {
		selectionMenues[_i] = instance_create_layer(0, 0, "GUI", obj_char_select_menu);
		selectionMenues[_i].initSelectMenu(_i);
		
		// ASSIGN KEY TO CPU ONLY IF PLAYER 1 IS CPU
		var _inputKey = (_i == 1 || objFightSetup.PLAYER_IS_CPU[_i]) ? P1_KEY : P2_KEY;
		if (_i == 1 || !objFightSetup.PLAYER_IS_CPU[_i]) {
			selectionMenues[_i].assignInputKey(_i);
		}
	}	
}
