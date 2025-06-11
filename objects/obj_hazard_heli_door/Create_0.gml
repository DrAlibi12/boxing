/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

doorHealth = 3;

image_speed = 0;
image_index = 0;

shaker = instance_create_layer(x, y, "Bot", obj_shaker);

layerScenarioId = layer_get_id("Scenario");

xDraw = 0;