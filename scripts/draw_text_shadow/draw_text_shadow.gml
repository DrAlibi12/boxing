/// @description Adds a shadow to text.
/// @function draw_text_shadow(x, y, string, font, shadow_size, shadow_colour, text_colour);
/// @param x
/// @param y
/// @param string
/// @param font
/// @param shadow_size
/// @param shadow_color
/// @param text_color
function draw_text_shadow(_x, _y, _string, _font, _shadow_size, _shadow_colour, _text_colour){
    draw_set_font(_font);
    draw_set_colour(_shadow_colour);
    draw_text((_x + _shadow_size), (_y + _shadow_size), string(_string));
    draw_set_colour(_text_colour);
    draw_text(_x, _y, string(_string));
}