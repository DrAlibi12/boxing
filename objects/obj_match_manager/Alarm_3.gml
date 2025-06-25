/// @description Show options

if (objArcadeProgression != noone && objArcadeProgression.isEnabled && winner == 1) {
	// INCREASE ARCADE LEVEL
	objArcadeProgression.gotoNextFight();
} else {
	var _overlay = instance_create_layer(0, 0, "GUI", obj_overlay);
	_overlay.initOverlay(0.6, obj_end_menu);

	// instance_create_layer(room_width div 2, room_height div 2, "GUI", obj_end_menu);
}

