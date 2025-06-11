/// @description Insert description here
// You can write your code in this editor

gameEnd = false;

roundTextColor = make_color_rgb(232, 232, 244);
roundText = "";

visible = false;

currentRound = 0;

results[1] = 3;
results[2] = 3;
results[3] = 3;
winnerByPoints = 0;

global.crowdShaker = instance_create_layer(0, 0, "Bot", obj_shaker);

isPvp = false;

//screenshaker = instance_create_layer(x, y, "GUI", obj_screen_shake);
//screenshaker.shake(10, 0);

//timer = instance_create_layer(room_width div 2, TIMER_Y, "GUI", obj_timer);
//timer.init(ROUND_TIME, id);

//var _objFighter = obj_fighter_dodge_only_cancel_2btn;
var _objFighter = obj_fighter_ch_atk_use_g_cues;
//var _objFighterCPU = obj_fighter_base;
//var _objFighterCPU = obj_fighter_base_cpu_use_guard;
var _objFighterCPU = obj_fighter_ch_atk_use_g_cues;

p1 = instance_create_layer(P1_X, PLAYER_Y, "Top", _objFighter);
p1.playerId = 1;
//p1.x = p1.x - ROUND_END_X;
p1.input = new Input(P1_KEY, MAX_HOLD_TIME, MAX_CANCEL_TIME);
var _p1Healthbar = instance_create_layer(HEALTHBAR_P1_X, HEALTHBAR_Y, "GUI", obj_healthbar);
_p1Healthbar.init(p1.hp);
p1.healthbar = _p1Healthbar;
var _p1GuardHealthbar = instance_create_layer(HEALTHBAR_P1_X, GUARD_HEALTHBAR_Y, "GUI", obj_healthbar);
_p1GuardHealthbar.sprite_index = spr_guard_healthbar;
_p1GuardHealthbar.barHeight = sprite_get_height(spr_guard_healthbar);
// _p1GuardHealthbar.barName = "G     U     A     R     D";
_p1GuardHealthbar.barName = "S   T   A   M   I   N   A";
_p1GuardHealthbar .init(p1.guardHp);
p1.guardHealthbar = _p1GuardHealthbar ;
var _p1Visualizer = instance_create_layer(96, 1080 - 96, "GUI", obj_input_visualizer);
_p1Visualizer.init(p1);

p1.strengthFactor = 0;


var _p2Input = new Input(P2_KEY, MAX_HOLD_TIME, MAX_CANCEL_TIME);
var _vKey;
_vKey = instance_create_layer(0, 0, "Bot", obj_virtual_key);
_p2Input = new VirtualInput(_vKey, MAX_HOLD_TIME, MAX_CANCEL_TIME);
_objFighter = obj_fighter_base;
p2 = instance_create_layer(P2_X, PLAYER_Y, "Top", _objFighterCPU);
p2.playerId = 2;
//p2.x = p2.x + ROUND_END_X;
p2.input = _p2Input;
_vKey.fighter = p2;
_p2Input.fighter = p2;
p2.image_xscale = -1;
var _p2Healthbar = instance_create_layer(HEALTHBAR_P2_X, HEALTHBAR_Y, "GUI", obj_healthbar);
_p2Healthbar.init(p2.hp, -1);
p2.healthbar = _p2Healthbar;
var _p2GuardHealthbar = instance_create_layer(HEALTHBAR_P2_X, GUARD_HEALTHBAR_Y, "GUI", obj_healthbar);
_p2GuardHealthbar.sprite_index = spr_guard_healthbar;
_p2GuardHealthbar.barHeight = sprite_get_height(spr_guard_healthbar);
//_p2GuardHealthbar.barName = "G   U   A   R   D";
_p2GuardHealthbar.barName = "S   T   A   M   I   N   A";
_p2GuardHealthbar.init(p2.guardHp, -1);
p2.guardHealthbar = _p2GuardHealthbar;
p2.image_blend = c_black;
p2.image_alpha = 0.75;

p2.strengthFactor = 0;


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
	if (currentRound <= 3) {
		timer.init(ROUND_TIME, id);
	}
	var _nextRoundMsg = instance_create_layer(x, y, "GUI", obj_next_round);
	_nextRoundMsg.owner = id;
}

function roundStart() {
	if (currentRound > 3) {
		calculatePoints();
		exit;
	}
	if (currentRound <= 3) {
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
	for (var _i=1; _i <= 3; _i++) {
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
//alarm[0] = 1;

with (obj_fighter) {
	visible = true;
	status = FighterStatus.idle;
}

var _display = instance_create_layer(0, 0, "GUI", obj_controls_display);

_display.show(true, false);

