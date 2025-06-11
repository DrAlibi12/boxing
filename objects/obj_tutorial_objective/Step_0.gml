/// @description Check fighter's objective status 

if (completed || !started) exit;

var _curPlayerStatus = playerFighter.status;
var _curCpuStatus = cpuFighter.status;


if (scoreAdded) {
	if ((playerFighterObjectiveStatus != noone && _curPlayerStatus != playerFighterObjectiveStatus) || 
		(cpuFighterObjectiveStatus != noone && _curCpuStatus != cpuFighterObjectiveStatus)) {
		
		scoreAdded = false;
	} else {
		exit;
	}
}

if ((playerFighterObjectiveStatus == noone || _curPlayerStatus == playerFighterObjectiveStatus) &&
	(cpuFighterObjectiveStatus == noone || _curCpuStatus == cpuFighterObjectiveStatus)) {
		
	if (delayCheck != 0 && curDelay < delayCheck) {
		curDelay += 1;
	} else {
		curDelay = 0;
	
		scoreAdded = true;

		repetitionsDone += 1;
	
		completionBar.scoreAdd(1);
	
		if (repetitionsDone >= repetitionsNeeded) {
			completed = true;
			with (playerFighter) {
				attackInput.setDisabled(true);
				attackInput.reset();
				dodgeInput.setDisabled(true);
				dodgeInput.reset();
			}
			alarm[0] = game_get_speed(gamespeed_fps) * timeToEnd;
		}
	}
} else {
	curDelay = 0;
}

playerFighterLastStatus = _curPlayerStatus;
cpuFighterLastStatus = _curCpuStatus;

