/// @description Insert description here
// You can write your code in this editor

draw_set_color(c_white);
draw_set_font(fnt_debug);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (!selected) {
	var _id = optionId + 1;
	for (var _i=0; _i <= maxOptionId - 1; _i++) {
		if (_id < 0) _id += maxOptionId + 1;
		if (_id > maxOptionId) _id -= maxOptionId + 1;
		if (_id != optionId) {

			draw_sprite_ext(
				sprite_index, _id,
				x, y + 120 + 80 * _i,
				0.5, 0.5, 0, c_white, 0.5
			);
			//draw_text_transformed(x, y + 80 * _i, options[_id, 0], 0.7, 0.7, 0);
		}
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
var _color = (optIdColorize) ? make_color_rgb(80, 80, 80) : c_white;
draw_sprite_ext(
	sprite_index, optionId,
	x + shaker.xDraw + optIdXDisplace,
	y + shaker.yDraw,
	scale, scale, 0, _color, 1
);
//var _text_width = string_width(options[optionId]) * scale;
var _width = sprite_width * scale;

var _selectX = 0;
/*
if (input.isHeld()) {
	_selectX = abs(lerp(0, SELECT_CONFIRM_TIME, input.getHoldTime() / 100) / 100) * -1;
	show_debug_message(_selectX);
}
*/
//var _y_displacement = (48 * scale + sprite_width div 2) * sin(degtorad(angle));
draw_sprite_ext(
	spr_cursor, cursorImage,
	x - 80 * scale - _width div 2 + shaker.xDraw + options[optionId, 1] + _selectX,
	y + shaker.yDraw, // + _y_displacement,
	cursorScale * scale, cursorScale * scale,
	angle, c_white, 1
);