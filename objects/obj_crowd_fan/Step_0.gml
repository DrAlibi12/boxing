/// @description Insert description here
// You can write your code in this editor

// x = xStart + xPos;
//show_debug_message(hSpeed);
if (hDir != 0) {
	x += hDir * hSpeed;
	hDir = approach(hDir, 0, 0.025);
	
	var _xDistance = xMax - xMin;
	if (x < xMin) {
		x += _xDistance;
	} else if (x > xMax) {
		x -= _xDistance;
	}
	var _halfX = _xDistance div 2;
	var _xPerc = unlerp(0, _halfX, abs(x - xMin - _halfX));
	//show_message("x: " + string(abs(x - xMin - _halfX)) + "; maxX: " + string(_halfX) + " = " + string(_xPerc));
	curY = lerp(yMin, yMax, _xPerc);
}

y = sine_between((current_time + timeRandomness) / 1000, 0.5, curY, curY + 24);

//depth = -y;

//if (instance_exists(global.crowdShaker)) {
//	yShake = global.crowdShaker.yDraw;
//}


