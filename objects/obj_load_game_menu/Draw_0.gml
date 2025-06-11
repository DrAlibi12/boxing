/// @description Insert description here
// You can write your code in this editor

// if (input == noone) exit;

draw_set_color(c_white);
draw_set_font(fnt_debug);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _id = 0;
for (var _i=0; _i <= optionQty - 1; _i++) {
	if (selected && _i != optionId) continue;
	
	var _scale = (_i == optionId) ? scale : 1 - unselectedScaleSub;
	var _alpha = 1 - unselectedAlphaSub * abs(_i);
	var _color = c_white;
	
	var _x = x + (sprite_get_height(spr_portraits) * 1 + hMargin) * _i;
	var _y = y;
	
	if (_i == optionId) {
		_x += shaker.xDraw;
		_y += shaker.yDraw;
		var _color = (optIdColorize) ? make_color_rgb(80, 80, 80) : c_white;
	}

	draw_sprite_ext(
		spr_portraits, 0,
		_x, _y,
		_scale, _scale, 0, _color, _alpha
	);
}
