function createLocalMenuInputManager(_playerId, _keyboardKeys) {
	var _keyboard = -1;
	if (!ds_map_empty(_keyboardKeys)) {
		_keyboard = new KeyboardMenuInput(_keyboardKeys);
	}

	var _joystickManager = instance_find(obj_joystick_manager, 0);
	var _joystickId = _joystickManager.getJoystickForPlayer(_playerId);
	var _joystick = -1;
	if (_joystickId != -1) {
		_joystick = new JoystickMenuInput(_joystickId);
	}
	return new MenuInputManager(_playerId, _keyboard, _joystick);
}
