function KeyboardMenuInput(_dsMapKeys) constructor {
	// Directions
	leftKey = ds_map_find_value(_dsMapKeys, "left");
	rightKey = ds_map_find_value(_dsMapKeys, "right");
	upKey = ds_map_find_value(_dsMapKeys, "up");
	downKey = ds_map_find_value(_dsMapKeys, "down");
	
	action1Key = ds_map_find_value(_dsMapKeys, "action1");
	action2Key = ds_map_find_value(_dsMapKeys, "action2");
	action3Key = ds_map_find_value(_dsMapKeys, "action3");
	action4Key = ds_map_find_value(_dsMapKeys, "action4");
		
	startKey = ds_map_find_value(_dsMapKeys, "start");
	selectKey = ds_map_find_value(_dsMapKeys, "select");
	
	/*
	show_message("Left " + string(leftKey));
	show_message("Right " + string(rightKey));
	show_message("Up " + string(upKey));
	show_message("Down " + string(downKey));

	show_message("1 " + string(action1Key));
	show_message("2 " + string(action2Key));
	show_message("3 " + string(action3Key));
	show_message("4 " + string(action4Key));

	show_message("Start " + string(startKey));
	show_message("Select " + string(selectKey));
	*/
	
	// return array of booleans:
	// 0 => pressed
	// 1 => held
	// 2 => released
	function getKey(_key) {
		if (is_undefined(_key))
			return [false, false, false];
		
		var _pressed = keyboard_check_pressed(_key);
		var _held = keyboard_check(_key);
		var _released = keyboard_check_released(_key);
		
		return [_pressed, _held, _released];
	}
	
	function getLeft() {
		return getKey(leftKey);
	}

	function getRight() {
		return getKey(rightKey);
	}
	
	function getUp() {
		return getKey(upKey);
	}

	function getDown() {
		return getKey(downKey);
	}

	function getAction1() {
		return getKey(action1Key);
	}

	function getAction2() {
		return getKey(action2Key);
	}

	function getAction3() {
		return getKey(action3Key);
	}

	function getAction4() {
		return getKey(action4Key);
	}
	
	function getStart() {
		return getKey(startKey);
	}

	function getSelect() {
		return getKey(selectKey);
	}
}

