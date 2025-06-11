/// @description Insert description here
// You can write your code in this editor

event_inherited();

x = TUT_TEXT_POS_X;
y = TUT_TEXT_POS_Y;

started = false;

repetitionsDone = 0;
completed = false;

objectiveText = "";

playerFighter = noone;
playerFighterLastStatus = -1;
playerFighterObjectiveStatus = -1;
cpuFighter = noone;
cpuFighterLastStatus = -1;
cpuFighterObjectiveStatus = -1;
repetitionsNeeded = 1;

objectiveColor = c_black;
completionBar = noone;

scoreAdded = false;

curDelay = 0;
delayCheck = 0;

timeToEnd = 0.5;

function initTutorialObjective(_text, _objective, _owner) {
	owner = _owner;
	
	started = true;
	
	objectiveText = _text;
	
	objectiveColor = _objective.textColor;
	playerFighter = _objective.playerFighter;
	playerFighterObjectiveStatus = _objective.playerStatus;
	cpuFighter = _objective.cpuFighter;
	cpuFighterObjectiveStatus = _objective.cpuStatus;
	repetitionsNeeded = _objective.repetitions;
	delayCheck = _objective.delayCheck;
	
	timeToEnd = _objective.timeToEnd;

	if (completionBar != noone) instance_destroy(completionBar);
	var _barX = x - sprite_get_width(spr_completion_bar) / 2 + sprite_get_xoffset(spr_completion_bar);
	var _barY = y + 64;
	completionBar = instance_create_layer(_barX, _barY, "GUI", obj_scorebar);
	
	completionBar.scoreBarInit(repetitionsNeeded);
}



