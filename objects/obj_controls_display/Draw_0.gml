/// @description Insert description here
// You can write your code in this editor

draw_set_alpha(alpha);

if (showP1)
	draw_sprite(spr_keys, 0, room_width div 4, room_height div 2);

if (showP2)
	draw_sprite(spr_keys, 1, room_width div 4 * 3, room_height div 2);

draw_set_alpha(1);

