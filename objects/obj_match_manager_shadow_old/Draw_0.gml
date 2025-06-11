/// @description Insert description here
// You can write your code in this editor

draw_self();

draw_set_font(fnt_round);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_black);
draw_text(x, y + 210, roundText);
draw_set_color(roundTextColor);
draw_text(x, y + 202, roundText);
