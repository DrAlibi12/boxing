// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function VirtualInput(_virtual_key, _max_hold_time, _max_cancel_time) constructor{
	virtual_key = _virtual_key;
	max_hold_time = _max_hold_time;
	max_cancel_time = _max_cancel_time;
	cancel_time = 0; // UNUSED
	pressed_at = 0;
	released_at = 0;
	hold_time = 0;
	is_pressed = false;
	is_held = false;
	is_released = false;
	disabled = false;
	
	function reset() {
		cancel_time = 0;
		pressed_at = 0;
		released_at = 0;
		hold_time = 0;
		is_pressed = false;
		is_held = false;
		is_released = false;
	}
	
	function check(_includeHold=false) {
		is_pressed = false;
		is_released = false;
		if (disabled) exit;
		if (is_held) {
			hold_time = current_time - pressed_at;
			if (virtual_key.released || (max_hold_time != -1 && hold_time > max_hold_time)) {
				hold_time = current_time - pressed_at;
				show_debug_message("RELEASED AFTER: " + string(hold_time));
				released_at = current_time;
				cancel_time = 0;
				is_pressed = false;
				is_held = false;
				is_released = true;
			}
		} else {
			if (virtual_key.pressed || (_includeHold && virtual_key.is_held)) {
				hold_time = 0;
				pressed_at = current_time;
				is_pressed = true;
				is_held = true;
			}
		}
		if (is_pressed || is_held || is_released) {
			show_debug_message("PRESSED: " + string(is_pressed));
			show_debug_message("HELD: " + string(is_held));
			show_debug_message("RELEASED: " + string(is_released));
		}
	}
}
