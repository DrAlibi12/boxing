/// @description Insert description here
// You can write your code in this editor

gameEnd = false;

roundTextColor = make_color_rgb(232, 232, 244);
roundText = "";

currentRound = 0;

results[1] = 3;
results[2] = 3;
results[3] = 3;
winnerByPoints = 0;

global.crowdShaker = instance_create_layer(0, 0, "Bot", obj_shaker);

isPvp = (room == rm_fight_pvp) ? true : false;

//screenshaker = instance_create_layer(x, y, "GUI", obj_screen_shake);
//screenshaker.shake(10, 0);

timer = instance_create_layer(room_width div 2, TIMER_Y, "GUI", obj_timer);
timer.init(ROUND_TIME, id);

var _objFighter = obj_fighter_char_dodgeB;

p1 = instance_create_layer(P1_X, PLAYER_Y, "Top", _objFighter);
//p1.initFighter(1, Roster.Milo/*global.selectedFighters[1]*/, true, );

var _isCPU = (isPvp) ? false : true;
var _opponent = (isPvp) ? noone : p1;
p2 = instance_create_layer(P2_X, PLAYER_Y, "Top", _objFighter);


global.cpuId = 5;
p1.initFighter(1, Roster.Manley/*global.selectedFighters[1]*/, true, p2);
p2.initFighter(2, Roster.Milo/*global.selectedFighters[2]*/, _isCPU, _opponent);

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
	var _nextRoundMsg = instance_create_layer(x, y, "GUI", obj_next_round);
	_nextRoundMsg.owner = id;
}

function roundStart() {
	if (currentRound > MAX_ROUNDS) {
		calculatePoints();
		exit;
	}
	if (currentRound <= MAX_ROUNDS) {
		audio_play_sound(snd_bell_single, 100, 0);
		timer.start();
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
		winnerByPoints = 1;
	} else if (_p2Wins > _p1Wins) {
		// P2 wins
		winnerByPoints = 2;
	} else {
		// Draw
		winnerByPoints = 3;
	}
	
	var _dSign = instance_create_layer(x, y, "Bot", obj_decision_sign);
	_dSign.appear();
	alarm[1] = game_get_speed(gamespeed_fps);
}

//currentRound = 3;
alarm[0] = 1;

//var _display = instance_create_layer(0, 0, "GUI", obj_controls_display);

//_display.show(isPvp);

