/// @description Insert description here
// You can write your code in this editor

if (owner == noone) exit;

// Overlay
draw_sprite_ext(
	spr_white_pixel, 0,
	0, 0, room_width, room_height,
	0, c_black, 0.7
);

draw_set_color(c_white);
draw_set_font(fnt_sqrt_obl_64);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// TITLE TEXT
draw_text(x, y - 80, titleText);

// OPTIONS TEXT
drawOption(0);
drawOption(1);

