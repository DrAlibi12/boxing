/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

btnWidth = sprite_get_width(spr_training_key_red);

// Key Text y displace for each image_index
yDisplace[0] = -4;
yDisplace[1] = yDisplace[0] + 11;

attackText = chr(global.ATTACK_KEY[1]);
guardText = chr(global.DODGE_KEY[1]);

attackImage = 0;
guardImage = 0;
