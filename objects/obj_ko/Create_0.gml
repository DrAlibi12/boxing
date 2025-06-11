/// @description Insert description here
// You can write your code in this editor

depth = -500;

image_alpha = 0;
image_index = 0;
image_speed = 0;
image_xscale = 2;
image_yscale = 2;

function show(_image) {
	visible = true;
	image_index = _image;
	alarm[0] = game_get_speed(gamespeed_fps) * 2;
}