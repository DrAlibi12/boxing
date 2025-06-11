/// @description Insert description here
// You can write your code in this editor

// if (input == noone) exit;

var _cursorImage = (playerId == 1) ? 0 : 1;
var _cursorOrientation = (playerId == 1) ? 1 : -1;

draw_set_color(c_white);
draw_set_font(fnt_debug);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (!selected) {
	var _id = optionId - 1;
	//for (var _i=0; _i <= optionQty - 1; _i++) {
	for (var _i=-1; _i <= -1 + optionQty; _i++) {
		//var _scale = 1 - unselectedScaleSub * abs(_i);
		var _scale = 1;
		var _alpha = 1 - unselectedAlphaSub * abs(_i);
		if (_id < 0) _id += maxOptionId + 1;
		if (_id > maxOptionId) _id -= maxOptionId + 1;
		if (_id != optionId) {
			draw_sprite_ext(
				spr_portraits, _id,
				x, y + (sprite_get_height(spr_portraits) * _scale + vMargin) * _i,
				//x, y + (sprite_get_height(spr_portraits) * _scale + vMargin) * _i,
				_scale * _cursorOrientation, _scale, 0, c_white, _alpha
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
	//spr_options, optionId,
	spr_portraits, optionId,
	x + shaker.xDraw,
	y + shaker.yDraw,
	scale * _cursorOrientation, scale, 0, _color, 1
);
//var _text_width = string_width(options[optionId]) * scale;
var _width = sprite_width * scale;
var _selectX = 0;
/*
if (input.isHeld()) {
	_selectX = abs(lerp(0, SELECT_CONFIRM_TIME, input.getHoldTime() / 100) / 100) * -1 * _cursorOrientation;
	show_debug_message(_selectX);
}
*/
//var _y_displacement = (48 * scale + sprite_width div 2) * sin(degtorad(angle));
draw_sprite_ext(
	spr_cursor, _cursorImage,
	//x - (80 * scale - (_width div 2 * _cursorOrientation) + shaker.xDraw + _selectX) * _cursorOrientation,
	x - (80 * scale * _cursorOrientation) - (_width div 2 * _cursorOrientation) + shaker.xDraw + _selectX,
	y + shaker.yDraw, // + _y_displacement,
	cursorScale * scale * _cursorOrientation, cursorScale * scale,
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

