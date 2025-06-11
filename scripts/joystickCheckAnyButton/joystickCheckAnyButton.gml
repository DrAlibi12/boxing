function joystickCheckAnyButton(_joystickId) {
	if (!gamepad_is_connected(_joystickId)) return false;

	padL = gamepad_button_check_pressed(_joystickId, gp_padl);
	padR = gamepad_button_check_pressed(_joystickId, gp_padr);
	padU = gamepad_button_check_pressed(_joystickId, gp_padu);
	padD = gamepad_button_check_pressed(_joystickId, gp_padd);

	face1 = gamepad_button_check_pressed(_joystickId, gp_face1);
	face2 = gamepad_button_check_pressed(_joystickId, gp_face2);
	face3 = gamepad_button_check_pressed(_joystickId, gp_face3);
	face4 = gamepad_button_check_pressed(_joystickId, gp_face4);

	startBtn = gamepad_button_check_pressed(_joystickId, gp_start);
	selectBtn = gamepad_button_check_pressed(_joystickId, gp_select);

	return (
		padL || padR || padU || padD ||
		face1 || face2 || face3 || face4 ||
		startBtn || selectBtn
	);
}