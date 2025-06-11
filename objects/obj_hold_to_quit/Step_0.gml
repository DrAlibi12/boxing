/// @description Insert description here
// You can write your code in this editor

if (input == noone) exit;

var _isHeld = input.getStart()[1];

if (_isHeld) {
	// Add ms from delta_time
	holdTime += delta_time / 1000;
} else {
	holdTime = 0;
}

value = holdTime * 100 / holdTimeMax;

if (holdTime >= holdTimeMax) {
	value = 100;
	instance_destroy();
}
