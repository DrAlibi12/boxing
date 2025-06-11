/// @description BOUNCE!

if (!started) exit;

var _scaleSpeed = (imageChanged) ? scaleSpeedEnd : scaleSpeedStart;

//character.stretcher.hScale = approach(character.stretcher.hScale, targetXScale, _scaleSpeed);
character.stretcher.vScale = approach(character.stretcher.vScale, targetYScale, _scaleSpeed);
character.stretcher.hScale = 2 - character.stretcher.vScale;

/*
startXScale  = 2 - _startYscale;
targetXScale = 2 - _targetYscale;
*/

//show_debug_message(character.x);

if (imageChanged && character.stretcher.vScale == targetYScale) {
	if (targetYScale == 1) {	
		character.stretcher.hScale = 1;
		character.allowStretching = false;
	
		owner.continueScene();

		instance_destroy();
	} else {
		targetYScale = 1;
	}
}

if ((!imageChanged && scaleDirection == 1 && character.stretcher.vScale >= 1) ||
	(!imageChanged && scaleDirection == -1 && character.stretcher.vScale <= 1)) {
	character.image_index = newImage;
	imageChanged = true;
}

