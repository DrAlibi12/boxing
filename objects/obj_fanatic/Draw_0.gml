/// @description Insert description here
// You can write your code in this editor

var _yShake = 0;

if (instance_exists(global.crowdShaker)) {
	_yShake = global.crowdShaker.yDraw;
}

draw_sprite_ext(
	sprite_index, image_index,
	x, y + _yShake,
	image_xscale, image_yscale,
	0, c_white, 1
);
