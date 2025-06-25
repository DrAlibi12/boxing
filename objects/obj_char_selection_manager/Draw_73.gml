/// @description Insert description here
// You can write your code in this editor

/*
draw_sprite(spr_keys, 0, 160, 1008);

if (drawInputKey2) 
	draw_sprite(spr_keys, 1, room_width - 160, 1008);
*/

draw_sprite(spr_name_flag, 0, 0, 1080);
draw_sprite(spr_name_flag, 1, room_width - sprite_get_width(spr_name_flag), 1080);

var _name1 = global.FIGHTER_NAMES[selectionMenues[1].optionId];
var _name2 = global.FIGHTER_NAMES[selectionMenues[2].optionId];

draw_set_valign(fa_bottom);
draw_set_halign(fa_left);

//draw_text(32, 1048, _name1);
draw_text_ext_shadow(32, 1048, _name1, 128, 800, fnt_sqrt_obl_96, 8, c_black, c_white, 1);

draw_set_halign(fa_right);
//draw_text(room_width - 32, 1048, _name2);
draw_text_ext_shadow(room_width - 32, 1048, _name2, 128, 800, fnt_sqrt_obl_96, 8, c_black, c_white, 1);
