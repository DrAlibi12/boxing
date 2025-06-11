/// @description Insert description here
// You can write your code in this editor

draw_self();

draw_set_color(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_round);

draw_text(x, y + 180, "ROUNDS");
draw_text(x, y + 280, "1");
draw_text(x, y + 380, "2");
draw_text(x, y + 480, "3");

var _mark_index_left = -1;
for (var _i=1; _i <= 3; _i++) {
	if (results[_i] == 0) continue;
	if (results[_i] == 3) {
		draw_sprite(spr_decision_mark, 2, x - 96, y + 180 + (100 * _i));
		draw_sprite(spr_decision_mark, 2, x + 96, y + 180 + (100 * _i));
		continue;
	}
	_mark_index_left = (results[_i] == 1) ? 0 : 1;
	draw_sprite(spr_decision_mark, _mark_index_left, x - 96, y + 180 + (100 * _i));
	_mark_index_left = 1 - (_mark_index_left * 1);
	draw_sprite(spr_decision_mark, _mark_index_left, x + 96, y + 180 + (100 * _i));
}

