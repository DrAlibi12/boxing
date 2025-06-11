/// @description Insert description here
// You can write your code in this editor

/*
// CROWD CONFIG
scaleMax = 8;
scaleDec = 1.5;
people = 16;
vMargin = - 10 * scaleMax;
vSep = 15 * scaleMax;
hRand = 12 * scaleMax;
crowdRows = 5 //3

// MANUAL TEST VARIABLE
// hSpeed = 2 * scaleMax;

// NO CROWD
people = 0;
crowdRows = 0;

// SPAWN CROWD
var _line;
for (var _i=0; _i < crowdRows; _i++) {
	_line = instance_create_layer(0, 0, "Crowd", obj_crowd_line);
	var _lineScale = scaleMax - _i * scaleDec;
	// Quantity of people per line
	var _linePeople = people * (1 + _i * scaleDec);
	var _xOffset = irandom_range(-hRand, hRand);
	_line.initCrowdLine(_i, x + _xOffset, y - vMargin - vSep * _i, _linePeople, _lineScale);
}
*/

bkgType = BackgroundType.Common;
endless = false;

bkgHDir = 0;
bkgHSpeed = 0;

backgroundMinX = 0;
backgroundMaxX = 0;

crowd = noone;

function setLayerVisible(_layerName, _visible) {
	var _layerId = layer_get_id(_layerName);
	layer_set_visible(_layerId, _visible);
}

function backgroundInit(_bkgType, _backgroundImage, _foregroundImage=-1, _staticBkg=-1, _isEndless=true, _crowd=noone) {
	bkgType = _bkgType;
	endless = _isEndless;
	
	crowd = _crowd;

	setLayerVisible("Scenario", false);
	setLayerVisible("ScenarioFore", false);
	setLayerVisible("Scenario360", false);
	setLayerVisible("Scenario360Fore", false);

	var _backgroundLayerName = "Scenario";
	var _foregroundLayerName = "ScenarioFore";
	var _staticLayerName = "StaticBkg";

	switch (_bkgType) {
		case BackgroundType.Background360:
			_backgroundLayerName = "Scenario360";
			_foregroundLayerName = "Scenario360Fore";

			// SETUP FOREGROUND
			if (_foregroundImage != -1) {
				var _layerId = layer_get_id(_foregroundLayerName);
				var _foregroundId = layer_background_get_id(_layerId);
				layer_background_sprite(_foregroundId, _foregroundImage);
			
				var _foregroundWidth = sprite_get_width(_foregroundImage);
				var _extraWidth = _foregroundWidth - room_width;

				// set foreground at middle point
				layer_x(_layerId, abs(_extraWidth / 2));
				
				setLayerVisible(_foregroundLayerName, true);
			}
		break;
		case BackgroundType.Common:
			_backgroundLayerName = "Scenario";
			_foregroundLayerName = "ScenarioFore";
			
			// SETUP FOREGROUND
			if (_foregroundImage != -1) {
				var _layerId = layer_get_id(_foregroundLayerName);
				var _foregroundId = layer_background_get_id(_layerId);
				layer_background_sprite(_foregroundId, _foregroundImage);
			
				var _foregroundWidth = sprite_get_width(_foregroundImage);
				var _extraWidth = _foregroundWidth - room_width;

				// set foreground at middle point
				layer_x(_layerId, - abs(_extraWidth / 2));

				var _foreground = instance_create_layer(0, 0, "Fore", obj_foreground);
				_foreground.sprite_index = _foregroundImage;
				_foreground.x = layer_get_x(_layerId);
			}
		break;
	}
	
	setLayerVisible(_backgroundLayerName, true);
	// setLayerVisible(_foregroundLayerName, true);
			
	// SETUP BACKGROUND
	var _layerId = layer_get_id(_backgroundLayerName);
	var _backgroundId = layer_background_get_id(_layerId);
	layer_background_sprite(_backgroundId, _backgroundImage);
			
	var _backgroundWidth = sprite_get_width(_backgroundImage);
	var _extraWidth = _backgroundWidth - room_width;

	// set background at middle point
	layer_x(_layerId, - abs(_extraWidth / 2));
	
	// SETUP STATIC IMAGE
	if (_staticBkg != -1) {
		var _staticLayerId = layer_get_id(_staticLayerName);
		var _staticId = layer_background_get_id(_staticLayerId);
		layer_background_sprite(_staticId, _staticBkg);

		// Change background color to white
		// because if its black as default, the image won't be visible
		layer_background_blend(_staticId, c_white);
			
		var _staticWidth = sprite_get_width(_staticBkg);
		var _extraWidth = _staticWidth - room_width;

		// set static background at middle point
		layer_x(_staticLayerId, - abs(_extraWidth / 2));
	}

	if (bkgType == BackgroundType.Common) {
		backgroundMinX = - _extraWidth;
		backgroundMaxX = 0;
	}
}

function backgroundApplySpeed(_hDir, _hSpeed) {
	// ADD _hDir to prevent moving when fighters hit simultaneously
	show_debug_message("OLD DIRECTION: " + string(bkgHDir));
	bkgHDir = clamp(bkgHDir + _hDir, -1, 1);
	show_debug_message("NEW DIRECTION: " + string(bkgHDir));
	bkgHSpeed = _hSpeed;
}

function backgroundCanMove(_hDir) {
	if (endless) return true;

	var _layerId = layer_get_id("Scenario");
	var _layerX = layer_get_x(_layerId);
	
	if ((_hDir == -1 && _layerX == backgroundMinX) || (_hDir == 1 && _layerX == backgroundMaxX)) {
		//show_debug_message("BACKGROUND X: " + string(_layerX));
		//show_debug_message("BACKGROUND MIN X: " + string(backgroundMinX));
		//show_debug_message("BACKGROUND MAX X: " + string(backgroundMaxX));
		return false;
	}
	
	return true;
}

// Returns hDir for Crowd
function backgroundMove(_layerName) {
	var _layerId = layer_get_id(_layerName);
	var _layerX = layer_get_x(_layerId);

	var _hDir = bkgHDir;

	_layerX += bkgHDir * bkgHSpeed;

	if (!endless) {
		_layerX = clamp(_layerX, backgroundMinX, backgroundMaxX);
		
		// STOP CROWD IF BACKGROUND REACHED AN END
		if (_layerX == backgroundMinX || _layerX == backgroundMaxX) {
			_hDir = 0;
		}
	}
	layer_x(_layerId, _layerX)	
	
	return _hDir;
}

function background360Move(_layerName, _spdFactor=1) {
	var _fx_struct = layer_get_fx(_layerName);
	var _param_names = fx_get_parameter_names(_fx_struct);
	
	var _bkgDir = fx_get_parameter(_fx_struct, "g_PanoramaDirection");
	// 0 => x; 1 => y
	var _bkgDirX = _bkgDir[0];
	var _bkgDirY = _bkgDir[1];
	_bkgDirX += bkgHDir * (_spdFactor * bkgHSpeed);
	
	if (_bkgDirX > 1) _bkgDirX -= 1;
	if (_bkgDirX < 0) _bkgDirX += 1;

	//for (var i = 0; i < array_length(_param_names); i ++) {
	//    show_debug_message("Parameter " + string(i) + ": " + _param_names[i]);
	//}

	fx_set_parameter(_fx_struct, "g_PanoramaDirection", [_bkgDirX, _bkgDirY]);
}
