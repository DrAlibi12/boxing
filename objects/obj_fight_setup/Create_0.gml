/// @description Init fight variables

// Prevent more than 1 instance
if (instance_number(obj_fight_setup) > 1) instance_destroy();

LEVEL_TYPE = LEVEL.NORMAL;

// PLAYER 1
PLAYER_IS_CPU[1]		= false;
PLAYER_CPU_ID[1]		= 5;
PLAYER_OBJ_FIGHTER[1]	= obj_fighter;
PLAYER_FIGHTER_ID[1]	= Roster.Juan;

// PLAYER 2
PLAYER_IS_CPU[2]		= false;
PLAYER_CPU_ID[2]		= 5;
PLAYER_OBJ_FIGHTER[2]	= obj_fighter;
PLAYER_FIGHTER_ID[2]	= Roster.Juan;

// STAGE
STAGE_ID = 0;
END_OVERLAY = noone;
//FIGHTERS_APPEAR_OUTSIDE = true;
FIGHTER_APPEAR_OUTSIDE[1] = true;
FIGHTER_APPEAR_OUTSIDE[2] = true;


// DIALOGUE SCENE
SCENE_PRE_FIGHT = -1;
//SCENE_POST_FIGHT = -1; // UNUSED

// END OPTIONS
END_OPTIONS[0, 0] = "end_menu_retry";
END_OPTIONS[0, 1] = 100;
END_OPTIONS[0, 2] = rm_fight;
END_OPTIONS[1, 0] = "end_menu_quit";	// Option Text Key
END_OPTIONS[1, 1] = 100;				// x Displace
END_OPTIONS[1, 2] = rm_menu;			// Target Room

function fightSetStage(_stageId) {
	STAGE_ID = _stageId;
}

function fightSetPlayers(_p1IsCPU, _p1CpuId, _p2IsCPU, _p2CpuId) {
	// PLAYER 1
	PLAYER_IS_CPU[1] = _p1IsCPU;
	PLAYER_CPU_ID[1] = _p1CpuId;

	// PLAYER 2
	PLAYER_IS_CPU[2] = _p2IsCPU;
	PLAYER_CPU_ID[2] = _p2CpuId;
}

function fightSetFighters(_p1ObjFighter, _p1FighterId, _p2ObjFighter, _p2FighterId) {
	// PLAYER 1
	PLAYER_OBJ_FIGHTER[1]	= _p1ObjFighter;
	PLAYER_FIGHTER_ID[1]	= _p1FighterId;

	// PLAYER 2
	PLAYER_OBJ_FIGHTER[2]	= _p2ObjFighter;
	PLAYER_FIGHTER_ID[2]	= _p2FighterId;
}

/*
Sets Fight End options
_options: 2D Array
	Should contain the following structure:
	_options[<option_id>, 0] => Option Text: string
	_options[<option_id>, 1] => x Displacement: number UNUSED
	_options[<option_id>, 2] => target room: room id
*/
function fightSetEndOptions(_options) {
	END_OPTIONS = _options;
}

