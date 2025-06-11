/// @description Insert description here
// You can write your code in this editor

// x = room_width div 2;
//y = CROWD_Y;

lineId = 0;

function initCrowdLine(_lineId, _x, _y, _people=16, _scale=1) {
	lineId = _lineId;
	
	x = _x;
	y = _y;

	scale = _scale; // 10;
	hSep = 40 * scale;

    var _halfPeople = _people div 2;

	xMin = x - _halfPeople * hSep;
	xMax = x + _halfPeople * hSep;

	yMin = y;
	yMax = y + 20 * scale;

	var _fan;
	for (var _i=-_halfPeople; _i < _halfPeople; _i++) {
		var _fanY = y + abs(_i) * 2 * scale;
		_fan = instance_create_layer(x + hSep * _i, _fanY, "Crowd", obj_crowd_fan);
		_fan.lineId = lineId;
		_fan.image_xscale = scale;
		_fan.image_yscale = scale;
		_fan.xMin = xMin;
		_fan.xMax = xMax;
		_fan.yMin = yMin;
		_fan.yMax = yMax;	
	}
}
