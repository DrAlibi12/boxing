/// @description Insert description here
// You can write your code in this editor

// CROWD CONFIG
x = room_width div 2;
y = CROWD_Y;

scaleMax = 8;
scaleDec = 1.5;
people = 16;
crowdRows = 5 //3

// MANUAL TEST VARIABLE
// hSpeed = 2 * scaleMax;

// NO CROWD
// people = 0;
// crowdRows = 0;

function initCrowd(_scaleMax, _scaleDec, _rows, _peoplePerRow, _autoSpawn=true) {
	scaleMax = _scaleMax;
	scaleDec = _scaleDec;
	crowdRows = _rows;
	people = _peoplePerRow;

	vMargin = - 10 * scaleMax;
	vSep = 15 * scaleMax;
	hRand = 12 * scaleMax;
	
	if (_autoSpawn) {
		spawnCrowd();
	}
}

function spawnCrowd() {
	if (crowdRows <= 0) return;

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
}

function moveCrowd(_hDir, _speed) {
	if (crowdRows <= 0) return;
	
	with (obj_crowd_fan) {
		fanMove(_hDir, _speed);
	}
}
