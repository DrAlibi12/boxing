/// @description Insert description here
// You can write your code in this editor

if (targetAlpha <= 0) exit;

image_alpha = approach(image_alpha, 1, 0.02);

if (image_alpha == targetAlpha) {
	targetAlpha = -1;
	instance_create_layer(x, y, "GUI", targetObject);
}