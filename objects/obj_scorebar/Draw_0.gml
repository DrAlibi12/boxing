/// @description Insert description here
// You can write your code in this editor

draw_set_alpha(1);

// draw black background
draw_sprite_ext(
	spr_completion_bar, 1,
	x, y,
	1, 1,
	0, c_black, 0.75
);

// draw fill
draw_sprite_ext(
	spr_completion_bar, 1,
	x, y,
	fillXScale, 1,
	0, c_white, 1
);

// draw bar
draw_sprite(spr_completion_bar, 0, x, y);

// draw glow
gpu_set_blendmode(bm_add);
draw_sprite_ext(
	spr_completion_bar_glow, 0,
	x, y,
	fillXScale, 1,
	0, c_white, glowAlpha
);
gpu_set_blendmode(bm_normal);
