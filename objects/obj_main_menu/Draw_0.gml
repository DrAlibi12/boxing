/// @description Insert description here
// You can write your code in this editor

draw_set_color(c_white);
draw_set_font(fnt_debug);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_sqrt_obl_128);

var _selectedOptionText = "";

if (!selected) {
	var _id = optionId - 1;
	for (var _i=0; _i <= optionQty - 1; _i++) {
		if (_id < 0) _id += maxOptionId + 1;
		if (_id > maxOptionId) _id -= maxOptionId + 1;
		if (_id != optionId) {
			/*
			draw_sprite_ext(
				spr_options, _id,
				x, y + 140 * _i,
				0.5, 0.5, 0, c_white, 0.5
			);
			*/
			draw_text_transformed(
				x, y + 140 * _i,
				getText(global.UI_TEXTS, options[_id, 0]),
				0.7, 0.7, 0
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

/*
// DRAW LANGUAGE OPTIONS:
if (optionId == 2) {
	draw_sprite_ext(
		spr_flags, global.locale,
		x + shaker.xDraw,
		y + shaker.yDraw,
		scale, scale,
		angle, c_white, 1
	);
} else {
*/
	var _color = (optIdColorize) ? make_color_rgb(80, 80, 80) : c_white;
	draw_set_color(_color);
	draw_text_transformed(
		x + shaker.xDraw + optIdXDisplace,
		y + 140 + shaker.yDraw,
		//options[optionId, 0],
		getText(global.UI_TEXTS, options[optionId, 0]),
		scale, scale, angle
	);
	/*
	draw_sprite_ext(
		spr_options, optionId,
		x + shaker.xDraw + optIdXDisplace,
		y + 140 + shaker.yDraw,
		scale, scale, 0, _color, 1
	);
	*/
//}

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

// DRAW CURSOR GLOVE
_selectedOptionText = getText(global.UI_TEXTS, options[optionId, 0]);
var _cursor_x = x;
_cursor_x -= string_width(_selectedOptionText) / 2;
	
draw_sprite_ext(
	spr_cursor, 0,
	//x - 80 * scale - _width div 2 + shaker.xDraw + options[optionId, 1] + _selectX,
	_cursor_x - 80 * scale + shaker.xDraw,
	y + 140 + shaker.yDraw, // + _y_displacement,
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

