/// @description Insert description here
// You can write your code in this editor

if (targetAlpha <= 0) exit;

image_alpha = approach(image_alpha, 1, 0.01);

// show_debug_message("ALPHA: " + string(image_alpha))

if (image_alpha == targetAlpha) {
	targetAlpha = -1;
}
