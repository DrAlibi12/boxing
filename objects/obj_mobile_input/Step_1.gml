/// @description Insert description here
// You can write your code in this editor

if (curDevice == noone) {
	for (var _i=0; _i <= 1; _i++) {
		var _x = device_mouse_x(_i);
		var _y = device_mouse_y(_i);
		// If "mouse" is touching the input
		// and the input is pressed
		show_debug_message("MOUSE X: " + string(_x));
		show_debug_message("MOUSE Y: " + string(_y));
		show_debug_message("IS TOUCHING: " + string(collision_point(_x, _y, obj_mobile_input, false, false)));
		show_debug_message("IS PRESSED: " + string(device_mouse_check_button_pressed(_i, mb_left) == id));
		if (collision_point(_x, _y, obj_mobile_input, false, false) == id &&
			device_mouse_check_button_pressed(_i, mb_left)) {
			curDevice = _i;
			pressed = true;
			is_held = true;
			break;
		}
	}
} else {
	if (device_mouse_check_button_released(curDevice, mb_left) || !device_mouse_check_button(curDevice, mb_left) ) {
		is_held = false;
		released = true;
		curDevice = noone;
	}
}

