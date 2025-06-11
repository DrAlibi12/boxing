/// @description Init

if (instance_number(obj_joystick_manager) > 1) instance_destroy();

joystickIds = ds_list_create();
ds_list_clear(joystickIds);

function getJoystickForPlayer(_playerNumber) {
	var _joystickId = ds_list_find_value(joystickIds, _playerNumber -1); 
	return (is_undefined(_joystickId)) ? -1 : _joystickId;
}

function initJoysticks() {
	var gp_num = gamepad_get_device_count();

	var foundGUIDs = ds_list_create();
	var joystickGUID = noone;
	for (var i = 0; i < gp_num; i++) {
		show_debug_message(gamepad_is_connected(i));
		if (gamepad_is_connected(i)) {
			joystickGUID = gamepad_get_guid(i);

			show_debug_message("joystick exists with id: " + string(i));
			show_debug_message("joystick id: " + joystickGUID);
			show_debug_message("joystick name: " + gamepad_get_description(i));
			// show_debug_message("joystick mapping: " + gamepad_get_mapping(i));	

			// If joystick GUID was already registered, skip
			if (ds_list_find_index(foundGUIDs, joystickGUID) != -1) {
				show_debug_message("DUPLICATED ENTRY FOR JOYSTICK GUID " + joystickGUID);
				show_debug_message("REPLACING...");
				var _joystickIndex = ds_list_find_index(foundGUIDs, joystickGUID);
				ds_list_replace(joystickIds, _joystickIndex, i);
				continue;
			}
		
			ds_list_add(foundGUIDs, joystickGUID);
			ds_list_add(joystickIds, i);
	    }
	}
	ds_list_destroy(foundGUIDs);

	show_debug_message("JOYSTICKS: " + string(ds_list_size(joystickIds)));
}

// Delay 1 frame joystick search
// Otherwise it doesn't work
alarm[0] = 1;
