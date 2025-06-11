/// @description Insert description here
// You can write your code in this editor

if (fighter == noone) exit;

var _cpuStatus = fighter.status;
var _playerStatus = playerFighter.status;
var _acc;

if (!fighter.dizzy) recoveryStarted = false;

switch (_cpuStatus) {
	case FighterStatus.idle:
		if (locked) break;
		checkIdleDodgeCPU(_playerStatus);
		checkGuardCPU(_playerStatus);
		checkDodgeCPU(_playerStatus);
		checkParryCPU(_playerStatus);
	break;
	case FighterStatus.charge:
		if (locked) break;
		// The chance to dodge while charging doesn't exists anymore
		// checkDodgeCPU(_playerStatus);
	break;
	case FighterStatus.guard:
		var _attackStatus = [
			FighterStatus.charge,
			FighterStatus.startJab,
			FighterStatus.jab
		];
		// If player is not attacking
		if (!array_contains(_attackStatus, playerFighter.status)) {
			// stop blocking
			alarm[1] = 1;
		}
	break;
}
