/// @description Insert description here
// You can write your code in this editor

if (fighter == noone) exit;

var _cpuStatus = fighter.status;
var _playerStatus = playerFighter.status;
var _acc;

if (!fighter.dizzy) recoveryStarted = false;

switch (_cpuStatus) {
	case FighterStatus.dizzy:
		if (!recoveryStarted){ 
			recoveryStarted = true;
		    alarm[0] = 1;
			alarm[1] = -1;
			alarm[3] = -1;		
			alarm[4] = -1;
		}
	break;
	case FighterStatus.idle:
		if (locked) break;
		checkGuardCPU(_playerStatus);
		
		checkPreventiveJabCPU(_playerStatus);
		checkHookCPU(_playerStatus);
	break;
	case FighterStatus.guard:
		if (locked) break;
		resetAttackCPU();
		
		checkPreventiveJabCPU(_playerStatus);
		checkHookCPU(_playerStatus);
	break;
	case FighterStatus.hurt:
		if (locked) break;
		resetAttackCPU();
	break;
	case FighterStatus.charge:
		if (locked) break;
		checkPlayerOpeningCPU(_playerStatus);
	break;
}
