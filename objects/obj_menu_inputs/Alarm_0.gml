/// @description Insert description here
// You can write your code in this editor

var _mapKeys = ds_map_create();
ds_map_add(_mapKeys, "left", vk_left);
ds_map_add(_mapKeys, "right", vk_right);
ds_map_add(_mapKeys, "up", vk_up);
ds_map_add(_mapKeys, "down", vk_down);
ds_map_add(_mapKeys, "action1", ord("Z"));
ds_map_add(_mapKeys, "action2", ord("X"));
ds_map_add(_mapKeys, "action3", ord("C"));
ds_map_add(_mapKeys, "action4", ord("V"));
ds_map_add(_mapKeys, "start", vk_enter);
ds_map_add(_mapKeys, "select", vk_escape);

menuInput = createLocalMenuInputManager(
	1, _mapKeys
);
