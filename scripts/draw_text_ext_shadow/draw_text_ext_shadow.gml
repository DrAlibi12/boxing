/// @description Adds a shadow to text.
/// @function draw_text_ext_shadow(x, y, string, sep, width, font, shadow_size, shadow_colour, text_colour);
/// @param x
/// @param y
/// @param string
/// @param sep
/// @param width
/// @param font
/// @param shadow_size
/// @param shadow_color
/// @param text_color
/// @param text_alpha
function draw_text_ext_shadow(_x, _y, _string, _sep, _width, _font, _shadow_size, _shadow_colour, _text_colour, _text_alpha){
    draw_set_font(_font);
	draw_set_alpha(_text_alpha);
    draw_set_color(_shadow_colour);
    draw_text_ext((_x + _shadow_size), (_y + _shadow_size), string(_string), _sep, _width);
    draw_set_colour(_text_colour);
    draw_text_ext(_x, _y, string(_string), _sep, _width);
}