/// @description Insert description here
// You can write your code in this editor

var _hDir = keyboard_check(vk_right) - keyboard_check(vk_left);

if (_hDir != 0) {
	crowdMove(_hDir, other.hSpeed);
}

if (bkgHDir != 0) {
	var _hDir = bkgHDir;

	var _layerId = layer_get_id("Scenario");
	var _layerX = layer_get_x(_layerId);
	
	_layerX += bkgHDir * bkgHSpeed;

	bkgHDir = approach(bkgHDir, 0, 0.025);

	if (!endless) {
		_layerX = clamp(_layerX, backgroundMinX, backgroundMaxX);
		
		// STOP CROWD IF BACKGROUND REACHED AN END
		if (_layerX == backgroundMinX || _layerX == backgroundMaxX) {
			_hDir = 0;
		}
	}
	layer_x(_layerId, _layerX)	

	backgroundPanoramaMove("Scenario360", _hDir, -0.0001);
	backgroundPanoramaMove("Scenario360Fore", _hDir, -0.0001);
	
	// Move crowd
	with (obj_crowd_fan) {
		fanMove(_hDir, other.bkgHSpeed);
	}


}