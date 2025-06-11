function createLocalInputManager(_playerId, _maxHoldTime, _cancelTime, _minCancelableTime=0) {
	var _key = (_playerId == 1) ? P1_KEY : P2_KEY;
	var _keyboard = new KeyboardInput(_key, _maxHoldTime, _cancelTime, _minCancelableTime);
	var _joystickManager = instance_find(obj_joystick_manager, 0);
	var _joystickId = _joystickManager.getJoystickForPlayer(_playerId);
	var _joystick = -1;
	if (_joystickId != -1) {
		_joystick = new JoystickInput(_joystickId, _maxHoldTime, _cancelTime, _minCancelableTime);
	}
	return new InputManager(_keyboard, _joystick);
}