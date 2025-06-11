// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function JoystickInput(_deviceId, _max_hold_time, _max_cancel_time, _min_cancelable_time=0) constructor{
	// control variables
	currentButton = gp_face1; // alternates between gp_face1/2/3/4
	
	deviceId = _deviceId;
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
			if (gamepad_button_check_pressed(deviceId, currentButton)) {
				is_cancelable = false;
				is_released = false;
				is_cancel = true;
			}			
		} else {
			if (is_held) {
				hold_time = current_time - pressed_at;
				//show_message(string(hold_time) + " > " + string(max_hold_time));
				if (hold_time > max_hold_time || gamepad_button_check_released(deviceId, currentButton)) {
					//show_message(string(currentButton) + " released at " + string(current_time));
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
				// gp_face1 or gp_face2 or gp_face3 or gp_face4
				var _gp_face1 = gamepad_button_check_pressed(deviceId, gp_face1);
				var _gp_face2 = gamepad_button_check_pressed(deviceId, gp_face2);
				var _gp_face3 = gamepad_button_check_pressed(deviceId, gp_face3);
				var _gp_face4 = gamepad_button_check_pressed(deviceId, gp_face4);

				var _buttonPressed;
				_buttonPressed = (_gp_face4) ? gp_face4 : -1;
				_buttonPressed = (_gp_face3) ? gp_face3 : _buttonPressed;
				_buttonPressed = (_gp_face2) ? gp_face2 : _buttonPressed;
				_buttonPressed = (_gp_face1) ? gp_face1 : _buttonPressed;
				
				if (_buttonPressed != -1) {
					//show_message("PRESSED " + string(_buttonPressed));
					currentButton = _buttonPressed;
					hold_time = 0;
					pressed_at = current_time;
					is_pressed = true;
					is_held = true;
				}
			}
		}
	}
}