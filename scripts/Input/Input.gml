// OLD Keyboard Input 
function Input(_key, _max_hold_time, _max_cancel_time, _min_cancelable_time=0) constructor{
	key = _key;
	max_hold_time = _max_hold_time;
	max_cancel_time = _max_cancel_time;
	min_cancelable_time = _min_cancelable_time;
	cancel_time = 0;
	pressed_at = 0;
	released_at = 0;
	hold_time = 0;
	is_pressed = false;
	is_held = false;
	is_cancelable = false;
	is_released = false;
	is_cancel = false;
	disabled = false;
	
	function reset() {
		cancel_time = 0;
		pressed_at = 0;
		released_at = 0;
		hold_time = 0;
		is_pressed = false;
		is_held = false;
		is_cancelable = false;
		is_released = false;
		is_cancel = false;
	}
	
	function check() {
		is_pressed = false;
		is_released = false;
		is_cancel = false;
		if (disabled) exit;
		if (is_cancelable) {
			//show_message("is cancelable");
			cancel_time = current_time - released_at;
			if (cancel_time > max_cancel_time) {
				is_cancelable = false;
				is_released = true;
				return;
			}
			if (keyboard_check_pressed(key)) {
				is_cancelable = false;
				is_released = false;
				is_cancel = true;
			}
		} else {
			if (is_held) {
				hold_time = current_time - pressed_at;
				if (hold_time > max_hold_time || keyboard_check_released(key)) {
					//show_message("released at " + string(current_time));
					released_at = current_time;
					cancel_time = 0;
					is_pressed = false;
					is_held = false;
					// THIS CODE MAKES "DODGES" OCCUR IMMEDIATELY
					if (hold_time <= min_cancelable_time) {
						is_released = true;
						is_cancelable = false;
						return;
					}
					is_cancelable = true;
				}
			} else {
				if (keyboard_check_pressed(key)) {
					hold_time = 0;
					pressed_at = current_time;
					is_pressed = true;
					is_held = true;
				}
			}
		}
	}
}