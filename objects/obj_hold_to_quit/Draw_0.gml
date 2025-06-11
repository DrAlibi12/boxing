/// @description Insert description here
// You can write your code in this editor

// Draw button sprite
//draw_sprite(buttonSprite, buttonImage, x, y);

// Draw info text
draw_set_font(fnt_text_box);
draw_set_halign(fa_right);
draw_set_valign(fa_middle);

var _text = string_replace_all(text, "{0}", textReplacement[textActiveId]);
draw_text_shadow(
	x - 64, y,
	_text,
	TUT_TEXT_FONT,
	3, c_black,
	c_white
);

// Draw progress bar
draw_circular_bar(
	x, y,
	value, 100,
	c_orange,
	32 + value / 5,
	1, 18
);

