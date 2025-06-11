/// @description Insert description here
// You can write your code in this editor

fighter = noone;
input = -1;

percentage = 0;
color = c_yellow;

cancelled = false;
lastTime = -1;

lastMove = -1;

moves = array_create(5, -1);

function init(_fighter) {
	fighter = _fighter;
	input = _fighter._input;
}

function find() {
	fighter = instance_find(obj_fighter, 0);
	input = fighter.input;
}

function addNewMove(_moveId) {	
	array_insert(moves, 0, _moveId);
	if (array_length(moves) > 5) {
		// Delete last
		array_delete(moves, 5, 1);
	}
}

function checkMoves() {
	if (fighter.status == lastMove) return;

	var _move = -1;
	switch (fighter.status) {
		case FighterStatus.dodge:
			_move = 0;
			color = c_yellow;
			if (cancelled) {
				_move = 1;
				color = c_gray;
			}
			addNewMove(_move);
			lastMove = FighterStatus.dodge;
		break;
		case FighterStatus.jab:
			_move = 2;
			addNewMove(_move);
			lastMove = FighterStatus.jab;
			color = c_orange;
		break;
		case FighterStatus.hook:
			_move = 3;
			addNewMove(_move);
			lastMove = FighterStatus.hook;
			color = c_red;
		break;
		default:
			lastMove = -1;
		break;
	}
}

/*
function addNewMove() {	
	if (input.hold_time <= MAX_DODGE_TIME) {
		show_debug_message("ADDING DODGE");
		array_insert(moves, 0, 0);
	} else if (cancelled) {
		//show_message("ADDING CANCEL");
		array_insert(moves, 0, 1);
	} else if (input.hold_time < MAX_HOLD_TIME) {
		//show_message("ADDING JAB");
		array_insert(moves, 0, 2);
	} else {
		//show_message("ADDING HOOK");
		array_insert(moves, 0, 3);
	}
	if (array_length(moves) > 5) {
		// Delete last
		array_delete(moves, 5, 1);
	}
}
*/
find();
