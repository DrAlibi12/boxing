/// @description Insert description here
// You can write your code in this editor

// Draw text
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(ATTACK_FNT_COLOR);
draw_set_font(fnt_sqrt_obl_64);
draw_text(x, y + FNT_SQRT_FILL_Y_MARGIN_MID, objectiveText);

draw_set_color(c_white);
draw_set_font(fnt_sqrt_obl_shd_64);
draw_text(x, y, objectiveText);

/*
draw_text_ext_shadow(
	x, y, objectiveText,
	font_get_size(fnt_sqrt_obl_shd_64), 860,
	fnt_sqrt_obl_shd_64,
	3, c_white,
	objectiveColor, 1
);
*/

