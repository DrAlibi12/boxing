/// @description Insert description here
// You can write your code in this editor

objArcade = instance_find(obj_arcade_progression, 0);

// CUR_FIGHT_ID

chapter = objArcade.getCurrentChapter();

function drawChapter() {
	draw_set_color(c_white);
	draw_set_font(fnt_chapter);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	var _x = room_width div 2;
	var _yNum = room_height * 0.25;
	var _yName = _yNum + 200;
	draw_text(_x, _yNum, chapter.number);
	draw_text(_x, _yName, chapter.name_key);
}

alarm[0] = game_get_speed(gamespeed_fps) * 3;