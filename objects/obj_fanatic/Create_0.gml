/// @description Insert description here
// You can write your code in this editor

image_speed = 0;
image_index = irandom(sprite_get_number(sprite_index) - 1);

timeRandomness = irandom(1000);
yStart = y;

image_xscale = 1 - 2 * irandom(1);

alarm[0] = game_get_speed(gamespeed_fps) * random_range(0.2, 0.6);

shaker = global.crowdShaker;
