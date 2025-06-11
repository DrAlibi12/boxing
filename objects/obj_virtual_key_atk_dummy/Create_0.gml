/// @description init

// SLOW ACCEPTABLE ("EASY")
CPU_MANUAL_RECOVER_PRESS_SPEED = 0.23
CPU_MANUAL_RECOVER_RELEASE_SPEED = 0.2;

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

doJabs = false;
doHooks = false;

attackHoldTime = 0;
attackEverySeconds = 0;

curRepetitions = 0;
repetitions = 0;

function initAttackKeyCPU(_fighter, _idCPU, _opponent) {
	configCPU(_idCPU);
	
	fighter = _fighter;
	holdTimeMin = fighter.character.inputMaxDodgeTime;
	holdTimeMax = fighter.character.inputMaxHoldTime;

	playerFighter = _opponent;
}

function doJabsEvery(_seconds, _repetitions=-1) {
	doJabs = true;
	doHooks = false;
	attackHoldTime = 150;
	attackEverySeconds = _seconds;
	curRepetitions = 0;
	repetitions = _repetitions;
}

function doHooksEvery(_seconds, _repetitions=-1) {
	doJabs = false;
	doHooks = true;	
	attackHoldTime = holdTimeMax;
	attackEverySeconds = _seconds;
	curRepetitions = 0;
	repetitions = _repetitions;
}

// Stops any previously started "attack every" configuration
function stop() {
	doJabs = false;
	doHooks = false;
	attackEverySeconds = 0;
}

function isPressed() {
	return pressed;
}

function isReleased() {
	return released;
}

