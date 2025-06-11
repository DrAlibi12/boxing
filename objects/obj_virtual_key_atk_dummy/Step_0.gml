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
		if ((doJabs || doHooks) && alarm[0] == -1 && alarm[1] == -1) {
			if (repetitions != -1 && curRepetitions >= repetitions) {
				doJabs = false;
				doHooks = false;
				return;
			}
			// show_message("ATTACK DUMMY");
			alarm[0] = max(1, game_get_speed(gamespeed_fps) * attackEverySeconds);
		}
	break;
}
