function JoystickMenuInput(_joystickId) constructor {
	joystickId = _joystickId;
	
	axisTreshold = 0.4;
	
	function getButton(_button) {
		if (joystickId == -1) {
			return [false, false, false];
		}
		var _pressed = gamepad_button_check_pressed(joystickId, _button);
		var _held = gamepad_button_check(joystickId, _button);
		var _released = gamepad_button_check_released(joystickId, _button);
		
		return [_pressed, _held, _released];
	}
	
	function getDirection(_dPadBtn, _axis, _axisValue) {
		if (joystickId == -1) {
			return [false, false, false];
		}
		var _dirAxis = gamepad_axis_value(joystickId, _axis);
		var _padPressed = gamepad_button_check_pressed(joystickId, _dPadBtn);
		var _padHeld = gamepad_button_check(joystickId, _dPadBtn);
		var _padReleased = gamepad_button_check_released(joystickId, _dPadBtn);
		
		var _pressed = _padPressed;
		var _held = (_padHeld || (sign(_dirAxis) == sign(_axisValue) && abs(_dirAxis) > axisTreshold)) ? true : false;
		var _released = _padReleased;
		
		return [_pressed, _held, _released];
	}
	
	function getLeft() {
		return getDirection(gp_padl, gp_axislh, -1);
	}

	function getRight() {
		return getDirection(gp_padr, gp_axislh, 1);
	}
	
	function getUp() {
		return getDirection(gp_padu, gp_axislv, -1);
	}

	function getDown() {
		return getDirection(gp_padd, gp_axislv, 1);
	}

	function getAction1() {
		return getButton(gp_face1);
	}

	function getAction2() {
		return getButton(gp_face2);
	}

	function getAction3() {
		return getButton(gp_face3);
	}

	function getAction4() {
		return getButton(gp_face4);
	}
	
	function getStart() {
		return getButton(gp_start);
	}

	function getSelect() {
		return getButton(gp_select);
	}
}
