/// @description Insert description here
// You can write your code in this editor

if (stopped) exit;

xDraw = irandom_range(-factor, factor);
yDraw = irandom_range(-factor, factor);

factor = approach(factor, 0, decrement);

if (factor == 0) {
	xDraw = 0;
	yDraw = 0;
	stopped = true;
}