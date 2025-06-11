/// @description Insert description here
// You can write your code in this editor

x = room_width div 2;
y = CROWD_Y;

endless = true;

var _layerId = layer_get_id("Scenario");
scenarioBackgroundId = layer_background_get_id(_layerId);
backgroundSprite = layer_background_get_sprite(scenarioBackgroundId);
backgroundWidth = sprite_get_width(backgroundSprite);
extraWidth = backgroundWidth - room_width;

backgroundMinX = - extraWidth;
backgroundMaxX = 0;
// set midpoint
layer_x(_layerId, - extraWidth / 2);

//backgroundMinX = 0;
//backgroundMaxX = backgroundWidth - room_width;

scaleMax = 8;
scaleDec = 1.5;
people = 16;
vMargin = - 10 * scaleMax;
vSep = 15 * scaleMax;
hRand = 12 * scaleMax;

bkgHDir = 0;
bkgHSpeed = 0;

hSpeed = 2 * scaleMax;

crowdRows = 5 //3

// NO CROWD
people = 0;
crowdRows = 0;


var _line;
for (var _i=0; _i < crowdRows; _i++) {
	_line = instance_create_layer(0, 0, "Crowd", obj_crowd_line);
	var _lineScale = scaleMax - _i * scaleDec;
	// Quantity of people per line
	var _linePeople = people * (1 + _i * scaleDec);
	var _xOffset = irandom_range(-hRand, hRand);
	_line.initCrowdLine(_i, x + _xOffset, y - vMargin - vSep * _i, _linePeople, _lineScale);
}

function crowdMove(_hDir, _hSpeed) {
	// ADD _hDir to prevent moving when fighters hit simultaneously
	show_debug_message("OLD DIRECTION: " + string(bkgHDir));
	bkgHDir = clamp(bkgHDir + _hDir, -1, 1);
	show_debug_message("NEW DIRECTION: " + string(bkgHDir));
	bkgHSpeed = _hSpeed;
	/*
	if (_hDir != 0) {
		with (obj_crowd_fan) {
			fanMove(_hDir, _hSpeed);
		}
	}
	*/
}

function backgroundCanMove(_hDir) {
	if (endless) return true;

	var _layerId = layer_get_id("Scenario");
	var _layerX = layer_get_x(_layerId);
	
	if ((_hDir == -1 && _layerX == backgroundMinX) || (_hDir == 1 && _layerX == backgroundMaxX)) {
		show_debug_message("BACKGROUND X: " + string(_layerX));
		show_debug_message("BACKGROUND MIN X: " + string(backgroundMinX));
		show_debug_message("BACKGROUND MAX X: " + string(backgroundMaxX));
		return false;
	}
	
	return true;
}

function backgroundPanoramaMove(_layerName, _hDir, _spdFactor=1) {
	var _fx_struct = layer_get_fx(_layerName);
	var _param_names = fx_get_parameter_names(_fx_struct);
	
	var _bkgDir = fx_get_parameter(_fx_struct, "g_PanoramaDirection");
	// 0 => x; 1 => y
	var _bkgDirX = _bkgDir[0];
	var _bkgDirY = _bkgDir[1];
	_bkgDirX += _hDir * (_spdFactor * bkgHSpeed);
	
	if (_bkgDirX > 1) _bkgDirX -= 1;
	if (_bkgDirX < 0) _bkgDirX += 1;

	//for (var i = 0; i < array_length(_param_names); i ++) {
	//    show_debug_message("Parameter " + string(i) + ": " + _param_names[i]);
	//}

	fx_set_parameter(_fx_struct, "g_PanoramaDirection", [_bkgDirX, _bkgDirY]);
}
