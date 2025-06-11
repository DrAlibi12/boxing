/// @description Insert description here
// You can write your code in this editor

draw_sprite_ext(sprite_index, signVisible, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if (signVisible)
	draw_sprite_ext(sprite_index, 2, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
