/// @description Insert description here
// You can write your code in this editor

draw_set_font(fnt_debug);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_sqrt_obl_128);

if (!selected) {
	var _id = 0;
	for (var _i=0; _i <= optionQty - 1; _i++) {
		if (_id < 0) _id += maxOptionId + 1;
		if (_id > maxOptionId) _id -= maxOptionId + 1;
		
		var _scale = 0.7;
		var _x = x;
		var _y = y + 140 * _i;
		var _color = c_white;
		if (_id == optionId) {
			_x = x + shaker.xDraw + optIdXDisplace;
			_y = y + 140 * _i + shaker.yDraw;
			_scale = scale;
			
			var _color = (optIdColorize) ? make_color_rgb(80, 80, 80) : c_white;
		}

		draw_set_color(_color);
		draw_text_transformed(
			_x, _y,
			getText(global.UI_TEXTS, options[_id, 0]),
			_scale, _scale, 0
		);

		_id++;
	}
}

draw_set_alpha(1);
/*
draw_text_transformed(
	x + shaker.xDraw,
	y + 80 + shaker.yDraw,
	options[optionId],
	scale, scale, angle
);
*/

/*
var _color = (optIdColorize) ? make_color_rgb(80, 80, 80) : c_white;
draw_set_color(_color);
draw_text_transformed(
	x + shaker.xDraw + optIdXDisplace,
	y + 140 + shaker.yDraw,
	//options[optionId, 0],
	getText(global.UI_TEXTS, options[optionId, 0]),
	scale, scale, angle
);
*/


var _selectedOptionText = getText(global.UI_TEXTS, options[optionId, 0]);
var _cursor_x = x;
_cursor_x -= string_width(_selectedOptionText) / 2;

// DRAW CURSOR GLOVE
draw_sprite_ext(
	spr_cursor, 0,
	//x - 80 * scale + shaker.xDraw + options[optionId, 1] - 500,
	_cursor_x - 80 * scale + shaker.xDraw,
	y + (140 * optionId) + shaker.yDraw, // + _y_displacement,
	cursorScale * scale, cursorScale * scale,
	angle, c_white, 1
);

/*
for (var _i=0; _i <= maxOptionId; _i++) {
	if (_i == optionId) continue;
	draw_text(x, y + 80 * _i, options[_i]);
}

draw_text_transformed(x, y + 80 * optionId, options[optionId], scale, scale, angle);
var _text_width = string_width(options[optionId]) * scale;
var _y_displacement = (48 * scale + _text_width div 2) * sin(degtorad(angle));
draw_sprite_ext(
	spr_cursor, -1,
	x - 48 * scale - _text_width div 2, y + 80 * optionId + _y_displacement,
	scale, scale,
	angle, c_white, 1
);

