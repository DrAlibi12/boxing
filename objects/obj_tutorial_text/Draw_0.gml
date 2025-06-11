/// @description Insert description here
// You can write your code in this editor

if (!drawing) return;

// draw text box

draw_set_alpha(0.5);
draw_sprite(spr_tutorial_overlay, 0, 0, room_height);
draw_set_alpha(1);

//draw_set_font(TUT_TEXT_FONT);
//draw_set_color(textColor);
//draw_set_alpha(1);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

//draw_text_ext();
draw_text_ext_shadow(x, y, drawnText, textSeparation, textMaxWidth, TUT_TEXT_FONT, 3, c_black, textColor, 1);

/*
if (waiting) {
	draw_sprite(spr_text_engine_cursor, -1, x, y)
}
*/
