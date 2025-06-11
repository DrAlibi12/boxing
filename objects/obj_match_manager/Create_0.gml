/// @description Insert description here
// You can write your code in this editor

objFightSetup = instance_find(obj_fight_setup, 0);
if (!instance_exists(objFightSetup))
	throw("obj_match_manager: NO obj_fight_setup EXISTS!");

// THIS OBJECT MIGHT NOT EXIST, AND IT SHOULDN'T BE AN ERROR
objArcadeProgression = instance_find(obj_arcade_progression, 0);
if (instance_exists(objArcadeProgression) && objArcadeProgression.isEnabled)
	objArcadeProgression.setupCurrentFight();

// SETUP STAGE!
loadStage(objFightSetup.STAGE_ID);

gameEnd = false;

roundTextColor = make_color_rgb(232, 232, 244);
roundText = "";

currentRound = 0;

results[1] = 3;
results[2] = 3;
results[3] = 3;
winner = noone;
timeout = false;

global.crowdShaker = instance_create_layer(0, 0, "Bot", obj_shaker);

//screenshaker = instance_create_layer(x, y, "GUI", obj_screen_shake);
//screenshaker.shake(10, 0);

depth = 0;

timer = instance_create_layer(room_width div 2, TIMER_Y, "GUI", obj_timer);
timer.init(ROUND_TIME, id);
timer.depth = -100;

var _objFighterP1 = objFightSetup.PLAYER_OBJ_FIGHTER[1];
var _objFighterP2 = objFightSetup.PLAYER_OBJ_FIGHTER[2];

var _p1X = (objFightSetup.FIGHTER_APPEAR_OUTSIDE[1]) ? P1_X_OUT : P1_X;
var _p2X = (objFightSetup.FIGHTER_APPEAR_OUTSIDE[2]) ? P2_X_OUT : P2_X;

p1 = instance_create_layer(_p1X, PLAYER_Y, "Top", _objFighterP1);
p2 = instance_create_layer(_p2X, PLAYER_Y, "Top", _objFighterP2);

p1.initFighter(1, objFightSetup.PLAYER_FIGHTER_ID[1], p2, objFightSetup.PLAYER_IS_CPU[1], objFightSetup.PLAYER_CPU_ID[1]);

switch (objFightSetup.LEVEL_TYPE) {
	case LEVEL.NORMAL:
		p2.initFighter(2, objFightSetup.PLAYER_FIGHTER_ID[2], p1, objFightSetup.PLAYER_IS_CPU[2], objFightSetup.PLAYER_CPU_ID[2]);
	break;
	case LEVEL.BOSS:
		p2.initFighter(2, objFightSetup.PLAYER_FIGHTER_ID[2], p1, objFightSetup.PLAYER_IS_CPU[2], objFightSetup.PLAYER_CPU_ID[2]);
	break;
	case LEVEL.WAVE:
		p2.initWave(10);
	break;
}

defeatedPlayers[1] = false;
defeatedPlayers[2] = false;

function setPlayerDefeated(_playerId) {
	defeatedPlayers[_playerId] = true;
	
	alarm[4] = 1;
}

function createEndOverlay(_visible) {
	if (object_exists(objFightSetup.END_OVERLAY)) {
		var _overlay = instance_create_layer(x, y, "GUI", objFightSetup.END_OVERLAY);
		_overlay.depth = 0;
		_overlay.visible = _visible;
	}
}

function timerEnd() {
	audio_stop_sound(snd_dizzy);
	with (obj_bird) instance_destroy();
	audio_play_sound(snd_bell_single, 100, 0);
	
	roundText = "";
	with (obj_fighter) {
		alarm[0] = -1;
		alarm[1] = -1;
		alarm[2] = -1;
		alarm[3] = -1;
		invulnerable = true;
		dizzy = false;
		status = FighterStatus.roundEnd;
		rest();
	}
	alarm[0] = game_get_speed(gamespeed_fps) * 5;
}

function nextRound() {
	with (obj_fighter) {
		status = FighterStatus.enterRing;
	}
	if (currentRound <= MAX_ROUNDS) {
		timer.init(ROUND_TIME, id);
	}
	if (objFightSetup.SCENE_PRE_FIGHT != -1) {
		// PLAY FIGHT SCENE RIGHT AWAY
		alarm[5] = 1; //game_get_speed(gamespeed_fps) * 2;
	} else {
		// START FIGHT WITHOUT SCENE
		var _nextRoundMsg = instance_create_layer(x, y, "GUI", obj_next_round);
		_nextRoundMsg.owner = id;
	}
}

function roundStart() {
	if (currentRound > MAX_ROUNDS) {
		calculatePoints();
		exit;
	}
	if (currentRound <= MAX_ROUNDS) {
		audio_play_sound(snd_bell_single, 100, 0);
		if (objFightSetup.LEVEL_TYPE != LEVEL.WAVE)
			timer.start();
		roundText = "FIGHT";
	}
	with (obj_fighter) {
		currentRound = other.currentRound;
		status = FighterStatus.idle;
		invulnerable = false;
	}
}

function calculatePoints() {
	/*
	Each round is given a separate 10-point
	evaluation by the judges.
	The majority of rounds are scored 10-9,
	with the better boxer scoring 10 to win
	the round and the other boxer scoring 9.
	A boxer forfeits a point if they are
	knocked down or sufficiently injured
	for the referee to call a standing count.
	*/
	//show_message("POINT CALCULATION");
	with (obj_fighter) {
		depth = 300;
		status = FighterStatus.freeze;
	}
	
	var _roundResults = "";
	var _result = "";
	for (var _i=1; _i <= MAX_ROUNDS; _i++) {
		_result = 3;
		if (p1.points[_i] > p2.points[_i]) {
			_result = 1;		
		} else if (p2.points[_i] > p1.points[_i]) {
			_result = 2;
		}
		results[_i] = _result; 
		_roundResults += string(_result);
	}
	
	var _p1Wins = string_count("1", _roundResults);
	var _p2Wins = string_count("2", _roundResults);
	
	if (_p1Wins > _p2Wins) {
		// P1 wins
		winner = 1;
	} else if (_p2Wins > _p1Wins) {
		// P2 wins
		winner = 2;
	} else {
		// Draw
		//winner = 3;
		// PREVENT DRAW WITH RANDOM WINNER!
		winner = irandom(1) + 1;
	}
	
	if (winner == 1) {
		p1.depth = 100;
		p2.depth = 200;
	} else {
		p1.depth = 200;
		p2.depth = 100;
	}
	
	//var _dSign = instance_create_layer(x, y, "Bot", obj_decision_sign);
	//_dSign.appear();
	//alarm[1] = game_get_speed(gamespeed_fps);
	
	gameEnd = true;

	timeout = true;
	alarm[2] = game_get_speed(gamespeed_fps) * 3;
}

//currentRound = 3;
alarm[0] = 1;

// OLD CONTROL HELPERS
// var _display = instance_create_layer(0, 0, "GUI", obj_controls_display);
// _display.show(!objFightSetup.PLAYER_IS_CPU[1], !objFightSetup.PLAYER_IS_CPU[2]);

