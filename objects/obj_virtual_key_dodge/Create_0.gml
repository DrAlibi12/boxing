/// @description init

depth = -200;

input = noone;

// PERCENTAGE (AT 100% DODGES ARE PERFECT)
CPU_DODGE_CAPABILITY = 1;
// PERCENTAGE (AT 100% READS OPENINGS PERFECTCLY)
CPU_OPENING_DETECTION_CAPABILITY = 10;
// PERCENTAGE (AT 100% BLOCKS JABS PERFECTLY)
CPU_GUARD_CAPABILITY = 10;
// PERCENTAGE (AT 100% PARRIES ALL ATTACKS)
CPU_PARRY_CAPABILITY = 20;

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
holdTimeMin = MAX_DODGE_TIME;
holdTimeMax = MAX_HOLD_TIME;

// VARIABLE TO PREVENT CPU CHANGING DECISIONS
locked = false;

curAction = "";

function initDodgeKeyCPU(_fighter, _idCPU, _opponent) {
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

function checkGuardCPU(_playerStatus) {
	// CHECK GUARD
	if (_playerStatus == FighterStatus.charge && playerFighter.jabReady && !playerFighter.hookReady) {
		// show_message("CHECK GUARD");
		// JAB GUARD (ACTIVE GUARD!)
		_acc = irandom(100);
		if (_acc < CPU_GUARD_CAPABILITY && alarm[2] == -1) {
			curAction = "checkGuardCPU";
			//show_debug_message("CPU GUARD!");
			alarm[0] = -1;
			alarm[1] = -1;
			alarm[2] = 1;
		}
	}
}

// PENDING: Change CPU_GUARD_CAPABILITY to CPU_PARRY_CAPABILITY
function checkParryCPU(_playerStatus) {
	// CHECK PARRY
	if (_playerStatus == FighterStatus.startJab || _playerStatus == FighterStatus.startHook) {
		// show_message("CHECK PARRY");
		_acc = irandom(100);
		if (_acc < CPU_PARRY_CAPABILITY && alarm[2] == -1 && playerFighter.alarm[6] != -1) {
			curAction = "checkParryCPU";
			//show_debug_message("CPU PARRY!");
			//show_debug_message("PLAYER ATTACKS IN: " + string(playerFighter.alarm[6]));

			var _parryAfterTime = max(1, playerFighter.alarm[6]);

			alarm[0] = -1;
			alarm[1] = -1;
			alarm[2] = _parryAfterTime;
		}
	}
}

function checkIdleDodgeCPU(_playerStatus) {
	// CHECK IDLE DODGE
	if ((!fighter.attackInput.isPressed() && !fighter.attackInput.isHeld()) && (_playerStatus == FighterStatus.startHook/* || _playerStatus == FighterStatus.startJab*/)) {
		// PREVENT DODGING ALWAYS
		var _acc = irandom(100);
		if (_acc < CPU_DODGE_CAPABILITY) {
			curAction = "checkIdleDodgeCPU";
			// PREVENT DODGING BEFORE TIME
			var _dodgeAfterTime = 1;
			var _dodgeDurationFrames = max(1, game_get_speed(gamespeed_fps) * fighter.character.dodgeDuration);
			if (playerFighter.alarm[6] == -1) return;
			if (playerFighter.alarm[6] > _dodgeDurationFrames && _playerStatus == FighterStatus.startHook) {
				//show_debug_message("PLAYER ATTACKS IN: " + string(playerFighter.alarm[6]));
				//show_debug_message("CPU DODGE LASTS: " + string(_dodgeDurationFrames));
				_dodgeAfterTime = playerFighter.alarm[6] - _dodgeDurationFrames div 2;
				// return;
			}
			// DODGE!
			//show_debug_message("CPU IDLE DODGE!");
			//show_debug_message(">>>>>> IDLE DODGING IN " + string(_dodgeAfterTime));
			alarm[0] = _dodgeAfterTime;
			alarm[1] = -1;
			alarm[2] = -1;
		}
	}
}

function checkDodgeCPU(_playerStatus) {
	// CHECK DODGE
	if ((alarm[0] == -1 && alarm[1] == -1) && (_playerStatus == FighterStatus.startHook/* || _playerStatus == FighterStatus.startJab*/)) {
		// PREVENT DODGING ALWAYS
		var _acc = irandom(100);
		if (_acc < CPU_DODGE_CAPABILITY) {
			curAction = "checkDodgeCPU";
			// PREVENT DODGING BEFORE TIME
			var _dodgeAfterTime = 1;
			var _dodgeDurationFrames = max(1, game_get_speed(gamespeed_fps) * fighter.character.dodgeDuration);
			if (playerFighter.alarm[6] == -1) return;
			if (playerFighter.alarm[6] > _dodgeDurationFrames && _playerStatus == FighterStatus.startHook) {
				//show_debug_message("PLAYER ATTACKS IN: " + string(playerFighter.alarm[6]));
				//show_debug_message("CPU DODGE LASTS: " + string(_dodgeDurationFrames));
				_dodgeAfterTime = playerFighter.alarm[6] - _dodgeDurationFrames div 2;
				// return;
			}
			// DODGE!
			//show_debug_message("CPU WISE DODGE!");
			//show_debug_message(">>>>>> DODGING IN " + string(_dodgeAfterTime));
			alarm[0] = _dodgeAfterTime;
			alarm[1] = -1;
			alarm[2] = -1;
		}
	}
}

// UNUSED
function checkPreventiveDodgeCPU(_playerStatus) {
	// CHECK PREVENTIVE DODGE
	if ((alarm[0] == -1 && alarm[1] == -1) && _playerStatus == FighterStatus.dodge && playerFighter.jabReady) {
		// PREVENT DODGING ALWAYS
		var _acc = irandom(100);
		if (fighter.guardHp >= DODGE_COST && _acc < CPU_DODGE_CAPABILITY) {
			curAction = "checkPreventiveDodgeCPU";
			//show_debug_message("CPU PREVENTIVE DODGE");
			alarm[0] = 2;
		}
	}
}
