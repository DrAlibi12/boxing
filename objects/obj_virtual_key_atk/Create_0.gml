/// @description init

depth = -200;

attackInput = noone;
dodgeInput = noone;

// PERCENTAGE (AT 100% DODGES ARE PERFECT)
CPU_DODGE_CAPABILITY = 1;
// PERCENTAGE (AT 100% READS OPENINGS PERFECTCLY)
CPU_OPENING_DETECTION_CAPABILITY = 10;
// PERCENTAGE (AT 100% BLOCKS JABS PERFECTLY)
CPU_GUARD_CAPABILITY = 10;

// SLOW ACCEPTABLE ("EASY")
CPU_MANUAL_RECOVER_PRESS_SPEED = 0.2;
CPU_MANUAL_RECOVER_RELEASE_SPEED = 0.1;

// Time CPU takes to make a new move (in seconds
// ORIGINAL
speedMin = 0.5;
speedMax = 2;
//speedMin = 0.2 //0.25;
//speedMax = 0.4 //0.6;

//speedMin = 0.6 //0.25;
//speedMax = 0.9 //0.6;

fighter = noone;
playerFighter = noone;

pressed = false;
is_held = false;
released = false;

recoveryStarted = false;

// timeMin = game_get_speed(gamespeed_fps) * MAX_DODGE_TIME;
// timeMax = game_get_speed(gamespeed_fps) * MAX_HOLD_TIME;
holdTimeMin = 1; // MAX_DODGE_TIME;
holdTimeMax = MAX_HOLD_TIME;

//holdTime = 0;

// VARIABLE TO PREVENT CPU CHANGING DECISIONS
locked = false;

curAction = "";

function initAttackKeyCPU(_fighter, _idCPU, _opponent) {
	configCPU(_idCPU);
	
	fighter = _fighter;
	holdTimeMin = fighter.character.inputMaxDodgeTime;
	holdTimeMax = fighter.character.inputMaxHoldTime;

	playerFighter = _opponent;
}

function isPressed() {
	return pressed;
}

function isReleased() {
	return released;
}

function preventiveJab() {
	alarm[0] = -1;
	alarm[1] = -1;
	alarm[3] = 1;
	holdTimeMin = 1;
	holdTimeMax = fighter.character.inputMinHookTime * 0.5;
}

function prepareJab() {
	alarm[0] = 1;
	alarm[1] = -1;
	alarm[3] = -1;
	alarm[4] = -1;
	holdTimeMin = 1;
	holdTimeMax = fighter.character.inputMinHookTime * 0.5;
}

function prepareHook() {
	alarm[0] = 1;
	alarm[1] = -1;
	alarm[3] = -1;
	alarm[4] = -1;
	holdTimeMin = fighter.character.inputMinHookTime;
	holdTimeMax = fighter.character.inputMaxHoldTime;
}

function resetAttackCPU() {
	if (alarm[0] == -1 && alarm[1] == -1) {
		curAction = "resetAttackCPU";
		show_debug_message("CPU RESET ATTACK");
		var _speed = irandom_range(speedMin, speedMax);
		alarm[0] = max(1, game_get_speed(gamespeed_fps) * _speed);
	}
}

function checkPreventiveJabCPU(_playerStatus) {
	// CHECK PLAYER OPENING
	if ((_playerStatus == FighterStatus.idle || _playerStatus == FighterStatus.charge)
		&& playerFighter.hookReady && alarm[3] == -1) {
		_acc = irandom(100);
		if (_acc < CPU_OPENING_DETECTION_CAPABILITY) {
			curAction = "checkPreventiveJabCPU";
			preventiveJab();
		}
	}
	if ((_playerStatus == FighterStatus.dodge)
		&& playerFighter.status == FighterStatus.charge && alarm[3] == -1) {
		_acc = irandom(100);
		if (_acc < CPU_OPENING_DETECTION_CAPABILITY) {
			curAction = "checkPreventiveJabCPU";
			prepareJab();
		}
	} 
}

function checkHookCPU(_playerStatus) {
	// CHECK PLAYER OPENING
	if (_playerStatus == FighterStatus.guard && alarm[0] == -1 && playerFighter.dodgeInput.getHoldTime() > 150) {
		_acc = irandom(100);
		if (_acc < CPU_OPENING_DETECTION_CAPABILITY) {
			curAction = "checkHookCPU";
			
			if (irandom(9) <= 4) {
				prepareHook();
			} else {
				prepareJab();
			}
		}
	}
}

function checkPlayerOpeningCPU(_playerStatus) {
	// CHECK PLAYER OPENING
	if (( _playerStatus == FighterStatus.idle || _playerStatus == FighterStatus.charge ||
		 (_playerStatus == FighterStatus.dodge && playerFighter.dodgeFailed))
		&& fighter.jabReady) {
		_acc = irandom(100);
		if (_acc < CPU_OPENING_DETECTION_CAPABILITY) {			
			curAction = "checkPlayerOpeningCPU";
			alarm[0] = -1;
			alarm[1] = 1;
		}
	}
}

function checkGuardCPU(_playerStatus) {
	// CHECK GUARD
	if (_playerStatus == FighterStatus.startJab && fighter.guardHp >= GUARD_SECTION_VALUE * 2) {
		// JAB GUARD (DO NOTHING)
		_acc = irandom(100);
		if (_acc < CPU_GUARD_CAPABILITY) {			
			curAction = "checkGuardCPU";
			show_debug_message("CPU GUARD!");
			alarm[0] = -1;
			alarm[1] = -1;
			alarm[3] = -1;
		}
	}
}

// Random auto-jabs
alarm[0] = game_get_speed(gamespeed_fps);

