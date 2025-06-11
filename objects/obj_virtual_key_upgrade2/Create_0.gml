/// @description init

input = noone;

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
released = false;

recoveryStarted = false;

// timeMin = game_get_speed(gamespeed_fps) * MAX_DODGE_TIME;
// timeMax = game_get_speed(gamespeed_fps) * MAX_HOLD_TIME;
holdTimeMin = MAX_DODGE_TIME;
holdTimeMax = MAX_HOLD_TIME;

// VARIABLE TO PREVENT CPU CHANGING DECISIONS
locked = false;

function initCPU(_fighter, _idCPU, _opponent) {
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

function resetAttackCPU() {
	if (alarm[0] == -1 && alarm[1] == -1) {
		show_debug_message("CPU RESET ATTACK");
		var _speed = irandom_range(speedMin, speedMax);
		alarm[0] = max(1, game_get_speed(gamespeed_fps) * _speed);
	}
}

function checkPreventiveJabCPU(_playerStatus) {
	// CHECK PLAYER OPENING
	if ((_playerStatus == FighterStatus.charge && playerFighter.hookReady)) {
		_acc = irandom(100);
		if (_acc < CPU_OPENING_DETECTION_CAPABILITY) {
			alarm[0] = -1;
			alarm[1] = -1;
			alarm[3] = 1;
		}
	}
}

function checkPlayerOpeningCPU(_playerStatus) {
	// CHECK PLAYER OPENING
	if (( _playerStatus == FighterStatus.charge ||
		 (_playerStatus == FighterStatus.dodge && playerFighter.dodgeFailed))
		&& fighter.jabReady) {
		_acc = irandom(100);
		if (_acc < CPU_OPENING_DETECTION_CAPABILITY) {			
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
			show_debug_message("CPU GUARD!");
			alarm[0] = -1;
			alarm[1] = -1;
			alarm[3] = -1;
			alarm[5] = -1;
		}
	}
}

function checkIdleDodgeCPU(_playerStatus) {
	// CHECK IDLE DODGE
	if ((!fighter.input.isPressed() && !fighter.input.isHeld()) && (_playerStatus == FighterStatus.startHook || _playerStatus == FighterStatus.startJab)) {
		// PREVENT DODGING ALWAYS
		var _acc = irandom(100);
		if (_acc < CPU_DODGE_CAPABILITY) {
			// PREVENT DODGING BEFORE TIME
			var _dodgeAfterTime = 1;
			var _dodgeDurationFrames = max(1, game_get_speed(gamespeed_fps) * fighter.character.dodgeDuration);
			if (playerFighter.alarm[6] == -1) return;
			if (playerFighter.alarm[6] > _dodgeDurationFrames && _playerStatus == FighterStatus.startHook) {
				show_debug_message("PLAYER ATTACKS IN: " + string(playerFighter.alarm[6]));
				show_debug_message("CPU DODGE LASTS: " + string(_dodgeDurationFrames));
				_dodgeAfterTime = playerFighter.alarm[6] - _dodgeDurationFrames div 2;
				// return;
			}
			// DODGE!
			show_debug_message("CPU IDLE DODGE!");
			alarm[0] = -1;
			alarm[1] = -1;
			show_debug_message(">>>>>> IDLE DODGING IN " + string(_dodgeAfterTime));
			alarm[5] = _dodgeAfterTime;
		}
	}
}

function checkDodgeCPU(_playerStatus) {
	// CHECK DODGE
	if ((alarm[3] == -1 && alarm[4] == -1) && (_playerStatus == FighterStatus.startHook || _playerStatus == FighterStatus.startJab)) {
		// PREVENT DODGING ALWAYS
		var _acc = irandom(100);
		if (_acc < CPU_DODGE_CAPABILITY) {
			// PREVENT DODGING BEFORE TIME
			var _dodgeAfterTime = 1;
			var _dodgeDurationFrames = max(1, game_get_speed(gamespeed_fps) * fighter.character.dodgeDuration);
			if (playerFighter.alarm[6] == -1) return;
			if (playerFighter.alarm[6] > _dodgeDurationFrames && _playerStatus == FighterStatus.startHook) {
				show_debug_message("PLAYER ATTACKS IN: " + string(playerFighter.alarm[6]));
				show_debug_message("CPU DODGE LASTS: " + string(_dodgeDurationFrames));
				_dodgeAfterTime = playerFighter.alarm[6] - _dodgeDurationFrames div 2;
				// return;
			}
			// DODGE!
			show_debug_message("CPU WISE DODGE!");
			alarm[0] = -1;
			alarm[1] = -1;
			alarm[5] = -1;
			show_debug_message(">>>>>> DODGING IN " + string(_dodgeAfterTime));
			alarm[3] = _dodgeAfterTime;
		}
	}
}

// UNUSED
function checkPreventiveDodgeCPU(_playerStatus) {
	// CHECK PREVENTIVE DODGE
	if ((alarm[3] == -1 && alarm[4] == -1) && _playerStatus == FighterStatus.dodge && playerFighter.jabReady) {
		// PREVENT DODGING ALWAYS
		var _acc = irandom(100);
		if (fighter.guardHp >= DODGE_COST && _acc < CPU_DODGE_CAPABILITY) {
			show_debug_message("CPU PREVENTIVE DODGE");
			alarm[0] = -1;
			alarm[1] = -1;
			alarm[3] = 2;
		}
	}
}

alarm[0] = game_get_speed(gamespeed_fps);
