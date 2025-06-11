/// @description Draw joystick

// Inherit the parent event
event_inherited();

// Draw attack buttons
// Square
draw_sprite_ext(
	spr_training_btn_red, attackImage,
	startX, y,
	1, 1,
	0, attackBlend, 1
);
// Triangle
draw_sprite_ext(
	spr_training_btn_white, 0,
	startX + btnWidth,
	y - btnWidth,
	1, 1,
	0, c_gray, 1
);

// Draw guard buttons
// Cross
draw_sprite_ext(
	spr_training_btn_white, 0,
	startX + btnWidth * 2,
	y,
	1, 1,
	0, c_gray, 1

);
// Circle
draw_sprite_ext(
	spr_training_btn_blue, guardImage,
	startX + btnWidth,
	y + btnWidth,
	1, 1,
	0, guardBlend, 1
);

// DRAW GLOW
if (attackEnabled) {
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(
		spr_training_btn_glow, 0,
		startX, y,
		1, 1,
		0, c_white, min(attackGlow, glowMax)
	);
	/*
	draw_sprite_ext(
		spr_training_btn_glow, 0,
		startX + btnWidth,
		y - btnWidth,
		1, 1,
		0, c_white, attackGlow
	);
	*/
	gpu_set_blendmode(bm_normal);
}

if (guardEnabled) {
	gpu_set_blendmode(bm_add);
	/*
	draw_sprite_ext(
		spr_training_btn_glow, 1,
		startX + btnWidth * 2,
		y,
		1, 1,
		0, c_white, guardGlow
	);
	*/
	draw_sprite_ext(
		spr_training_btn_glow, 1,
		startX + btnWidth,
		y + btnWidth,
		1, 1,
		0, c_white, min(guardGlow, glowMax)
	);
	gpu_set_blendmode(bm_normal);
}


