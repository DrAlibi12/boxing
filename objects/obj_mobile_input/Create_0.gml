/// @description init

// Disable Right Mouse button with double tap on mobile
device_mouse_dbclick_enable(false);
// Disable double tap
//gesture_double_tap_time(0);

depth = -200;

x = room_width div 2;
y = 0;

curDevice = noone;

pressed = false;
is_held = false;
released = false;

fighter = noone;

function initMobileInput(_xPosition=1) {
	image_xscale = room_width div 2 * _xPosition;
	image_yscale = room_height;
	image_alpha = 0.1;
	
	//holdTimeMin = fighter.character.inputMaxDodgeTime;
	//holdTimeMax = fighter.character.inputMaxHoldTime;
}

function press() {
	pressed = true;
}

function release() {
	released = true;
}

function isPressed() {
	return pressed;
}

function isReleased() {
	return released;
}
