/// @description Insert description here
// You can write your code in this editor

if (active) {
	if (!place_meeting(x, y, targetFighter)) {
		//show_debug_message("NOT COLLIDING");
		active = false;
	} else {
		exit;
	}
}

