/// @description Insert description here
// You can write your code in this editor

if (path_position <= 0.5) {
	image_xscale = (!mirror) ? -1 : 1;
	depth = 200;
} else {
	depth = -100;
	image_xscale = (!mirror) ? 1 : -1;
}