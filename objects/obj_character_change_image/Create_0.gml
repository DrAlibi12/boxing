/// @description Init bouncer

owner = instance_find(obj_dialogue_scene, 0);

character = noone;

newImage = 0;
imageChanged = false;

startXScale = 1;
targetXScale = 1;
startYScale = 1;
targetYScale = 1;
scaleDirection = 1;

scaleSpeedStart = 0.1;
scaleSpeedEnd = 0.06; //0.002;

started = false;

function initImageChanger(_character, _newImage, _startYscale, _targetYscale) {
	character = _character;
	character.allowStretching = true;
	
	newImage = _newImage;
	
	startYScale  = _startYscale;
	targetYScale = _targetYscale;
	startXScale  = 2 - _startYscale;
	targetXScale = 2 - _targetYscale;
	
	scaleDirection = sign(targetYScale - startYScale);
	//show_message(scaleDirection)
	//show_message(startXScale)
	//show_message(startYScale)
	if (scaleDirection == 0) instance_destroy();

	character.stretcher.hScale = startXScale
	character.stretcher.vScale = startYScale;

	// STOP BOUNCE TO ALLOW MOVING
	//character.startX = _targetX;
	//character.bounceEnabled = false;
	//character.waveEnabled = true;
	
	started = true;
}
