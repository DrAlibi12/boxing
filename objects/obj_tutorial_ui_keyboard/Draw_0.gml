/// @description Draw joystick

// Inherit the parent event
event_inherited();

// Draw attack key
draw_sprite_ext(
	spr_training_key_red, attackImage,
	startX, y,
	1, 1,
	0, attackBlend, 1
);
// Draw attack key text
draw_set_font(fnt_keyboard);
draw_set_valign(fa_middle);
draw_set_alpha(color_get_red(attackBlend));
draw_set_color(ATTACK_SHD_COLOR);
draw_text(startX, y + yDisplace[attackImage], attackText);
draw_set_color(ATTACK_FNT_COLOR);
draw_text(startX, y + yDisplace[attackImage] + 2, attackText);
 
// Draw guard button
draw_sprite_ext(
	spr_training_key_blue, guardImage,
	startX + btnWidth,
	y + btnWidth,
	1, 1,
	0, guardBlend, 1
);
// Draw guard key text
draw_set_valign(fa_middle);
draw_set_alpha(color_get_red(guardBlend));
draw_set_color(GUARD_SHD_COLOR);
draw_text(startX + btnWidth, y + btnWidth + yDisplace[guardImage], guardText);
draw_set_color(GUARD_FNT_COLOR);
draw_text(startX + btnWidth, y + btnWidth + yDisplace[guardImage] + 2, guardText);

// DRAW GLOW
if (attackEnabled) {
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(
		spr_training_key_red_glow, 0,
		startX, y + 11,
		1, 1,
		0, c_white, min(attackGlow, glowMax)
	);
	gpu_set_blendmode(bm_normal);
}

if (guardEnabled) {
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(
		spr_training_key_blue_glow, 1,
		startX + btnWidth,
		y + btnWidth + 11,
		1, 1,
		0, c_white, min(guardGlow, glowMax)
	);
	gpu_set_blendmode(bm_normal);
}


