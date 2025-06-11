function MenuInputManager(_playerId, _keyboardInput=-1, _joystickInput=-1) constructor {
	playerId = _playerId;
	
	keyboard = _keyboardInput;
	joystick = _joystickInput;
	
	//show_message(keyboard);
	//show_message(joystick);
		
	function returnInput(_keyboardData, _joystickData) {
		return [
			(_keyboardData[0] || _joystickData[0]),
			(_keyboardData[1] || _joystickData[1]),
			(_keyboardData[2] || _joystickData[2])
		];
	}
	
	function getLeft() {
		var _keyboard = (keyboard != -1) ? keyboard.getLeft() : [false, false, false];
		var _joystick = (joystick != -1) ? joystick.getLeft() : [false, false, false];
		
		return returnInput(_keyboard, _joystick);
	}

	function getRight() {
		var _keyboard = (keyboard != -1) ? keyboard.getRight() : [false, false, false];
		var _joystick = (joystick != -1) ? joystick.getRight() : [false, false, false];
		
		return returnInput(_keyboard, _joystick);
	}
	
	function getUp() {
		var _keyboard = (keyboard != -1) ? keyboard.getUp() : [false, false, false];
		var _joystick = (joystick != -1) ? joystick.getUp() : [false, false, false];
		
		return returnInput(_keyboard, _joystick);
	}

	function getDown() {
		var _keyboard = (keyboard != -1) ? keyboard.getDown() : [false, false, false];
		var _joystick = (joystick != -1) ? joystick.getDown() : [false, false, false];
		
		return returnInput(_keyboard, _joystick);
	}

	function getAction1() {
		var _keyboard = (keyboard != -1) ? keyboard.getAction1() : [false, false, false];
		var _joystick = (joystick != -1) ? joystick.getAction1() : [false, false, false];
		
		return returnInput(_keyboard, _joystick);
	}

	function getAction2() {
		var _keyboard = (keyboard != -1) ? keyboard.getAction2() : [false, false, false];
		var _joystick = (joystick != -1) ? joystick.getAction2() : [false, false, false];
		
		return returnInput(_keyboard, _joystick);
	}

	function getAction3() {
		var _keyboard = (keyboard != -1) ? keyboard.getAction3() : [false, false, false];
		var _joystick = (joystick != -1) ? joystick.getAction3() : [false, false, false];
		
		return returnInput(_keyboard, _joystick);
	}

	function getAction4() {
		var _keyboard = (keyboard != -1) ? keyboard.getAction4() : [false, false, false];
		var _joystick = (joystick != -1) ? joystick.getAction4() : [false, false, false];
		
		return returnInput(_keyboard, _joystick);
	}
	
	function getStart() {
		var _keyboard = (keyboard != -1) ? keyboard.getStart() : [false, false, false];
		var _joystick = (joystick != -1) ? joystick.getStart() : [false, false, false];
		
		return returnInput(_keyboard, _joystick);
	}

	function getSelect() {
		var _keyboard = (keyboard != -1) ? keyboard.getSelect() : [false, false, false];
		var _joystick = (joystick != -1) ? joystick.getSelect() : [false, false, false];
		
		return returnInput(_keyboard, _joystick);
	}
	
}

