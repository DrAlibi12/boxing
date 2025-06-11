/// @description Insert description here
// You can write your code in this editor

owner = instance_find(obj_dialogue_scene, 0);

character = noone;

startX = 0;
targetX = 0;

started = false;

function initMover(_character, _targetX) {
	character = _character;
	
	targetX = _targetX;
	
	// STOP BOUNCE TO ALLOW MOVING
	character.startX = _targetX;
	character.bounceEnabled = false;
	character.waveEnabled = true;
	
	started = true;
}