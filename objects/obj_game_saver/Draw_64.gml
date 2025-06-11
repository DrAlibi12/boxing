/// @description Insert description here
// You can write your code in this editor

draw_set_color(c_white);

draw_text(16, 16, "PRESS ENTER TO SAVE");
draw_text(16, 48, "PRESS SPACE TO LOAD");

draw_text(room_width div 2, room_height div 2, "SAVED: " + savedContent);
draw_text(room_width div 2, room_height div 2+ 32, "LOADED: " + loadedContent);
