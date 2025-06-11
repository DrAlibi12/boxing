/// @description Insert description here
// You can write your code in this editor

shaker = instance_create_layer(x, y, "Top", obj_shaker);
shaker.init(x, y);

screech = false;

swingStartAt = 0;
swingMin = 2;
swingMax = 20;
swing = swingMin;