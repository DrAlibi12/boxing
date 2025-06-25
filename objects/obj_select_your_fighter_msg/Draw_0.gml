/// @description Insert description here
// You can write your code in this editor

var _text = "SELECT YOUR FIGHTER - SELECT YOUR FIGHTER - SELECT YOUR FIGHTER";

draw_set_valign(fa_middle);
draw_set_halign(fa_left);

// RED BOX
draw_sprite_ext(spr_white_pixel, 0, 0, room_height div 3 - 64, room_width, 128, 0, c_red, 0.5);
// TEXT
//draw_text_ext_shadow(32, 1048, _text, 128, 800, fnt_sqrt_obl_96, 8, c_black, c_white, 1);
draw_text_ext_shadow(xTop + xTopOffset, room_height div 3, _text, 128, room_width * 2, fnt_sqrt_obl_96, 8, c_black, c_white, 0.5);

// BLUE BOX
draw_sprite_ext(spr_white_pixel, 0, 0, room_height div 3 * 2 - 64, room_width, 128, 0, c_blue, 0.5);

// TEXT
draw_set_halign(fa_right);
//draw_text(room_width - 32, 1048, _name2);
draw_text_ext_shadow(xBot + xBotOffset, room_height div 3 * 2, _text, 128, room_width * 2, fnt_sqrt_obl_96, 8, c_black, c_white, 0.5);

draw_set_alpha(1);

