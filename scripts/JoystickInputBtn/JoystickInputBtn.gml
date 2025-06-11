// Joystick input multiple buttons
function JoystickInputBtn(_deviceId, _buttons, _max_hold_time, _max_cancel_time, _min_cancelable_time=0) constructor{
	// control variables
	currentButton = gp_face1; // alternates between buttons list, depending which one was pressed
	
	deviceId = _deviceId;
	buttons = _buttons;
	btnQty = array_length(buttons);
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
		/*
		// REMOVED "CANCELLABLE" MOVES
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
		} else {*/
		if (is_held) {
			show_debug_message("JOYSTICK HOLD -> " + string(currentButton));
			hold_time = current_time - pressed_at;
			//show_message(string(hold_time) + " > " + string(max_hold_time));
			if ((max_hold_time != -1 && hold_time > max_hold_time) || gamepad_button_check_released(deviceId, currentButton)) {
				//show_message(string(currentButton) + " released at " + string(current_time));
				released_at = current_time;
				cancel_time = 0;
				is_pressed = false;
				is_held = false;
				is_released = true;
				/*
				if (hold_time <= min_cancelable_time) {
					is_released = true;
					is_cancelable = false;
					return;
				}
				is_cancelable = true;
				*/
			}
		} else {
			// check if a button was pressed
			var _buttonWasPressed = false;
			var _buttonIsHeld = false;
			var _buttonPressed = -1;
				
			for (var _i=0; _i < btnQty; _i++) {
				//_buttonWasPressed = gamepad_button_check(deviceId, buttons[_i]);
				_buttonWasPressed = gamepad_button_check_pressed(deviceId, buttons[_i]);
				_buttonIsHeld = gamepad_button_check(deviceId, buttons[_i]);
				if (_buttonWasPressed || _buttonIsHeld) {
					_buttonPressed = buttons[_i];
					currentButton = _buttonPressed;
					hold_time = 0;
					pressed_at = current_time;
					is_pressed = _buttonWasPressed;
					is_held = true;
					break;
				}
			}
		}
		//}
	}
}