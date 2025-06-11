/// @description Insert description here
// You can write your code in this editor

x = room_width div 2;
y = room_height div 2;

realX = x;
realY = y;

image_speed = 0;

shaker = instance_create_layer(x, y, "Bot", obj_shaker);
shaker.init(x, y);

function shake(_factor, _decrement) {
	shaker.shake(_factor, _decrement);
}