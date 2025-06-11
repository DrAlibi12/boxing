/// @description Insert description here
// You can write your code in this editor

var _layerX = layer_get_x(layerScenarioId);

draw_sprite_ext(
	sprite_index, image_index,
	_layerX + xDraw + shaker.xDraw, y + shaker.yDraw,
	image_xscale, image_yscale,
	image_angle, image_blend, image_alpha
);
