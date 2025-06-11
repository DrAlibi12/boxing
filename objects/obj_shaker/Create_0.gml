/// @description Insert description here
// You can write your code in this editor

xStart = 0;
yStart = 0;

xDraw = 0;
yDraw = 0;

factor = 0;
decrement = 0;
stopped = true;

function init(_x, _y) {
	xStart = _x;
	yStart = _y;
}

function shake(_factor, _decrement) {
	stopped = false;
	factor = _factor;
	decrement = _decrement;
}
