/// @description Insert description here
// You can write your code in this editor

glowAlpha = approach(glowAlpha, glowAlphaTarget, 0.05);

if (glowAlpha == glowAlphaTarget) {
	glowAlphaTarget = 1 - (1 * glowAlphaTarget);
}

/*
// DEBUG - INCREASE BAR VALUE WITH LEFT & RIGHT KEYS
var _add = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);

if (_add != 0) {
	scoreAdd(_add);
}
*/