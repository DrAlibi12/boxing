/// @description Check current active input

if (completed) {
	var _ended = false;
	with (obj_fade_out) {
		_ended = ended;
	}
	if (_ended) {
		// IN CASE THE TUTORIAL IS SKIPPED, RE-ENABLE PARRY
		global.PARRY_ENABLED = true;
		objFightSetup.LEVEL_TYPE = LEVEL.WAVE;
		objFightSetup.PLAYER_OBJ_FIGHTER[2] = obj_wave_manager;
		room_goto(rm_chapter_intro); //rm_fight);
	}
}

// READ DIRECTOR INPUTS
// Confirm
var _confirm = (input.getAction1()[0]); // || input.getStart()[0]);

// Pass tutorial texts!
if (_confirm && instance_exists(obj_tutorial_text)) {
	with (obj_tutorial_text) skipCurrent();
}

if (joystickId == -1) exit;

// Check change to keyboard
if (joystickUI.visible && keyboard_check_pressed(vk_anykey)) {
	show_debug_message("UI KEYBOARD");
	keyboardUI.visible = true;
	joystickUI.visible = false;
}

// Check change to joystick
if (keyboardUI.visible && joystickCheckAnyButton(joystickId)) {
	show_debug_message("UI JOYSTICK");
	keyboardUI.visible = false;
	joystickUI.visible = true;
}

if (instance_exists(holdToQuit))
	holdToQuit.textActiveId = (keyboardUI.visible) ? 0 : 1;
 