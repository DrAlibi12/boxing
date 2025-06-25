/// @description Arcade Mode Init

// ALLOW ONLY 1 INSTANCE
if (instance_number(obj_arcade_progression) > 1) instance_destroy();

isEnabled = false;

objFightSetup = instance_find(obj_fight_setup, 0);

preparingNextFight = false;
objFadeOut = noone;

CUR_SLOT_ID = 0;
CUR_CHAPTER_ID = 0;
LAST_CHAPTER_ID = 2;

/*
CHAPTERS[0, 0] => <CHAPTER_NUMBER>
<CHAPTER_NAME_KEY>
<CHAPTER_LAST_EVENT_ID> // "events" are fights currently
*/
CHAPTERS[0, 0] = "I";
CHAPTERS[0, 1] = "chapter_i_name";
CHAPTERS[0, 2] = 2; // "events" are fights currently

CHAPTERS[1, 0] = "II";
CHAPTERS[1, 1] = "chapter_ii_name";
CHAPTERS[1, 2] = 4; // "events" are fights currently

CHAPTERS[2, 0] = "III";
CHAPTERS[2, 1] = "chapter_iii_name";
CHAPTERS[2, 2] = 5; // "events" are fights currently

CUR_FIGHT_ID = 0;
LAST_FIGHT_ID = 5;

/*
// Rename <FIGHT_OPPONENTS> array to EVENTS

FIGHT_OPPONENTS[0, 0] = <FIGHTER_ID>;
FIGHT_OPPONENTS[0, 1] = <CPU_LEVEL_ID>;
FIGHT_OPPONENTS[0, 2] = <STAGE_ID>;
FIGHT_OPPONENTS[0, 3] = <SCENE_ID>;
FIGHT_OPPONENTS[0, 4] = <LEVEL_TYPE>;
FIGHT_OPPONENTS[0, 5] = <FIGHTERS_APPEAR_OUTSIDE_ARRAY>;
FIGHT_OPPONENTS[0, 6] = <UNLOCKS_FIGHTER_ID>;
FIGHT_OPPONENTS[0, 7] = <UNLOCKS_SCENARIO_ID>;
*/

FIGHT_OPPONENTS[0, 0] = Roster.MinionA//Roster.MiloBoss;
FIGHT_OPPONENTS[0, 1] = 3;
FIGHT_OPPONENTS[0, 2] = 0;
FIGHT_OPPONENTS[0, 3] = 3; // scene test
FIGHT_OPPONENTS[0, 4] = LEVEL.BOSS;
FIGHT_OPPONENTS[0, 5] = [false, false];
FIGHT_OPPONENTS[0, 6] = 0;
FIGHT_OPPONENTS[0, 7] = -1;

FIGHT_OPPONENTS[1, 0] = Roster.Manley;
FIGHT_OPPONENTS[1, 1] = 1;
FIGHT_OPPONENTS[1, 2] = 0; // 1 // 1: stage electric
FIGHT_OPPONENTS[1, 3] = 0;
FIGHT_OPPONENTS[1, 4] = LEVEL.NORMAL;
FIGHT_OPPONENTS[1, 5] = [false, false];
FIGHT_OPPONENTS[1, 6] = -1;
FIGHT_OPPONENTS[1, 7] = -1;

FIGHT_OPPONENTS[2, 0] = Roster.Milo;
FIGHT_OPPONENTS[2, 1] = 2;
FIGHT_OPPONENTS[2, 2] = 0;
FIGHT_OPPONENTS[2, 3] = -1;
FIGHT_OPPONENTS[2, 4] = LEVEL.NORMAL;
FIGHT_OPPONENTS[2, 5] = [true, false];
FIGHT_OPPONENTS[2, 6] = -1;
FIGHT_OPPONENTS[2, 7] = -1;

FIGHT_OPPONENTS[3, 0] = Roster.Manley;
FIGHT_OPPONENTS[3, 1] = 3;
FIGHT_OPPONENTS[3, 2] = 1;
FIGHT_OPPONENTS[3, 3] = -1;
FIGHT_OPPONENTS[3, 4] = LEVEL.NORMAL;
FIGHT_OPPONENTS[3, 5] = [false, true];
FIGHT_OPPONENTS[3, 6] = -1;
FIGHT_OPPONENTS[3, 7] = -1;

FIGHT_OPPONENTS[4, 0] = Roster.MinionA;
FIGHT_OPPONENTS[4, 1] = 0;
FIGHT_OPPONENTS[4, 2] = 0;
FIGHT_OPPONENTS[4, 3] = -1;
FIGHT_OPPONENTS[4, 4] = LEVEL.WAVE;
FIGHT_OPPONENTS[4, 5] = [true, true];
FIGHT_OPPONENTS[4, 6] = -1;
FIGHT_OPPONENTS[4, 7] = -1;

FIGHT_OPPONENTS[5, 0] = Roster.TheBoss;
FIGHT_OPPONENTS[5, 1] = 5;
FIGHT_OPPONENTS[5, 2] = 2;
FIGHT_OPPONENTS[5, 3] = -1;
FIGHT_OPPONENTS[5, 4] = LEVEL.BOSS;
FIGHT_OPPONENTS[5, 5] = [true, true];
FIGHT_OPPONENTS[5, 6] = -1;
FIGHT_OPPONENTS[5, 7] = -1;

// END OPTIONS
endOptions = [];
/*
if (os_type == os_android) {
	endOptions[0, 0] = "end_menu_retry";
	endOptions[0, 1] = 100;
	endOptions[0, 2] = rm_fight;		// Repeats same room
} else {
*/
endOptions[0, 0] = "end_menu_retry";
endOptions[0, 1] = 100;
endOptions[0, 2] = rm_fight;		// Repeats same room
endOptions[1, 0] = "end_menu_quit";		// Option Text
endOptions[1, 1] = 100;		// x Displace
endOptions[1, 2] = rm_menu;	// Target Room
//}

function resetArcadeMode() {
	// Disable arcade mode by default
	isEnabled = false;
	
	CUR_CHAPTER_ID = 0;
	CUR_FIGHT_ID = 0;
}

function startNewGame(_slotId) {
	// OVERRIDE SLOT
	global.GAME_STATE.storyModeSlots[_slotId].startGame(_slotId);
	
	CUR_SLOT_ID = _slotId;
	CUR_FIGHT_ID = 0;
	setCurrentChapterFromCurrentEvent();
}

function startLoadedGame(_slotId) {
	CUR_SLOT_ID = _slotId;

	if (global.GAME_STATE.storyModeSlots[_slotId].DATETIME_STARTED == -1) {
		global.GAME_STATE.storyModeSlots[_slotId].startGame(_slotId);
	}
	var _storyModeState = global.GAME_STATE.storyModeSlots[_slotId];
	
	CUR_FIGHT_ID = _storyModeState.CUR_EVENT_ID;
	setCurrentChapterFromCurrentEvent();
}

function setCurrentChapterFromCurrentEvent() {
	if (CUR_FIGHT_ID == 0) {
		CUR_CHAPTER_ID = 0;
		return;
	}
	for (var _i=0; _i <= LAST_CHAPTER_ID; _i++) {
		if (CUR_FIGHT_ID <= CHAPTERS[_i, 2]) {
			CUR_CHAPTER_ID = _i;
			return;
		}
	}
}

function getCurrentChapter() {
	return {
		number: CHAPTERS[CUR_CHAPTER_ID, 0],
		name_key: getText(global.UI_TEXTS, CHAPTERS[CUR_CHAPTER_ID, 1]),
	}
}

function setupCurrentFight() {	
	// SETUP FIGHTERS APPEARENCE SPOT
	objFightSetup.FIGHTER_APPEAR_OUTSIDE[1] = FIGHT_OPPONENTS[CUR_FIGHT_ID, 5][0];
	objFightSetup.FIGHTER_APPEAR_OUTSIDE[2] = FIGHT_OPPONENTS[CUR_FIGHT_ID, 5][1];

	// SETUP LEVEL TYPE
	objFightSetup.LEVEL_TYPE = FIGHT_OPPONENTS[CUR_FIGHT_ID, 4];
	
	var _enemyObj = obj_fighter;
	
	switch (objFightSetup.LEVEL_TYPE) {
		case LEVEL.NORMAL:
			_enemyObj = obj_fighter;
		break;
		case LEVEL.BOSS:
			_enemyObj = obj_fighter_boss;
		break;
		case LEVEL.WAVE:
			_enemyObj = obj_wave_manager;
		break;
	}

	objFightSetup.PLAYER_OBJ_FIGHTER[2] = _enemyObj;
	
	// SET MATCH END OPTIONS
	objFightSetup.fightSetEndOptions(endOptions);
	
	// SET FIGHTERS
	objFightSetup.fightSetFighters(
		// PLAYER FIGHTER (USE CURRENT)
		objFightSetup.PLAYER_OBJ_FIGHTER[1],
		// ARCADE MODE ALWAYS JUAN
		Roster.Juan, // objFightSetup.PLAYER_FIGHTER_ID[1],

		// CPU FIGHTER (USE CURRENT FIGHT)
		objFightSetup.PLAYER_OBJ_FIGHTER[2],
		FIGHT_OPPONENTS[CUR_FIGHT_ID, 0]
	);
	
	// SET CPU LEVEL
	objFightSetup.fightSetPlayers(
		false, 0,
		true, FIGHT_OPPONENTS[CUR_FIGHT_ID, 1]
	);
	
	// SETUP STAGE
	objFightSetup.fightSetStage(FIGHT_OPPONENTS[CUR_FIGHT_ID, 2]);
	
	// SETUP SCENE
	objFightSetup.SCENE_PRE_FIGHT = FIGHT_OPPONENTS[CUR_FIGHT_ID, 3];
	
}

function gotoNextFight() {
	unlockGoodies();

	CUR_FIGHT_ID ++;

	preparingNextFight = true;

	objFadeOut = instance_create_layer(0, 0, "Overlay", obj_fade_out);
	objFadeOut.initFadeOut(c_black, 2.5);
}

function unlockGoodies() {
	var _unlocker = noone;

	var _unlockedFighterId = FIGHT_OPPONENTS[CUR_FIGHT_ID, 6];
	if (_unlockedFighterId != -1) {
		_unlocker = instance_create_layer(0, 0, "GUI", obj_unlocker);
		_unlocker.unlockFighter(_unlockedFighterId);
	}

	var _unlockedScenarioId = FIGHT_OPPONENTS[CUR_FIGHT_ID, 7];
	if (_unlockedScenarioId != -1) {
		_unlocker = instance_create_layer(0, 0, "GUI", obj_unlocker);
		_unlocker.unlockScenario(_unlockedScenarioId);
	}
}
