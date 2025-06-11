// Manages up to 2 different inputs for a player
function InputManager(_keyboardInput, _joystickInput) constructor {
	keyboard = _keyboardInput;
	joystick = _joystickInput;
	
	// keyboard or joystick
	activeInput = (joystick == -1) ? keyboard : noone;
	wasReleased = false;
	wasCancelled = false;
	
	function setDisabled(_disabled) {
		keyboard.reset();
		keyboard.disabled = _disabled;
		if (joystick != -1) {
			joystick.reset();
			joystick.disabled = _disabled;
		}
	}
	
	function getActiveInput() {
		if (wasReleased || wasCancelled) {
			// activeInput = noone;
			activeInput = (joystick == -1) ? keyboard : noone;
			wasReleased = false;
			wasCancelled = false;
		}
		return activeInput;
	}
	
	function check(_includeHold=false) {
		//if (joystick == -1) return keyboard.check();
		
		if (getActiveInput() == noone) {
			keyboard.check(_includeHold);

			if (keyboard.is_pressed || (_includeHold && keyboard.is_held)) {
				// THIS FUCKS UP THE DIZZY RECOVERY AND OTHER THINGS
				// In case the input was being held, reset the pressed_at time
				keyboard.is_pressed = true;
				keyboard.is_held = true;
				keyboard.pressed_at = current_time;
				keyboard.hold_time = 0;
				
				// show_debug_message("KEYBOARD PRESSED");
				activeInput = keyboard;
				return;
			}
		
			joystick.check();
			if (joystick.is_pressed || (_includeHold && joystick.is_held)) {
				// THIS FUCKS UP THE DIZZY RECOVERY AND OTHER THINGS
				// In case the input was being held, reset the pressed_at time
				joystick.is_pressed = true;
				joystick.pressed_at = current_time;
				joystick.hold_time = 0;
				
				// show_debug_message("JOYSTICK PRESSED");
				activeInput = joystick;
				return;
			}
		} else {
			activeInput.check();
			// show_debug_message("active input held time: " + string(activeInput.hold_time));
		}
	}

	function reset() {
		keyboard.reset();
		if (joystick != -1) joystick.reset();
		// activeInput = noone;
		activeInput = (joystick == -1) ? keyboard : noone;
	}

	function isPressed() {
		//if (joystick == -1) return keyboard.is_pressed;

		if (activeInput == noone) return false;
		
		return activeInput.is_pressed;
	}

	function isHeld() {
		//if (joystick == -1) return keyboard.is_held;

		if (activeInput == noone) return false;
		
		return activeInput.is_held;
	}
	
	function isReleased() {
		//if (joystick == -1) return keyboard.is_released;

		//show_debug_message("keyboard " + string(keyboard));
		//show_debug_message("joystick " + string(joystick));
		//show_debug_message("activeInput " + string(activeInput));

		if (activeInput == noone) {
			return (wasReleased) ? true : false;
		}
		
		var _isReleased = activeInput.is_released;
		wasReleased = _isReleased;
		
		return _isReleased;
	}

	function isCancel() {
		//if (joystick == -1) return keyboard.is_cancel;

		if (activeInput == noone) {
			return (wasCancelled) ? true : false;
		}
		
		var _isCancel = activeInput.is_cancel;
		wasCancelled = _isCancel;
		
		return _isCancel;
	}

	function getHoldTime() {
		//if (joystick == -1) return keyboard.hold_time;
		
		if (activeInput == noone) return 0;
		
		return activeInput.hold_time;
	}

}