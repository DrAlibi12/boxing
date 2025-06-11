
global.fullscreen = window_get_fullscreen();
global.masterVolume = 1;

global.selectedFighters[1] = Roster.Juan;
global.selectedFighters[2] = Roster.Juan;

// PLAYER KEYBOARDS
global.PLAYER_KEYBOARD[1] = ds_map_create();
ds_map_add(global.PLAYER_KEYBOARD[1], "left", ord("A"));
ds_map_add(global.PLAYER_KEYBOARD[1], "right", ord("D"));
ds_map_add(global.PLAYER_KEYBOARD[1], "up", ord("W"));
ds_map_add(global.PLAYER_KEYBOARD[1], "down", ord("S"));
ds_map_add(global.PLAYER_KEYBOARD[1], "action1", ord("Z"));
ds_map_add(global.PLAYER_KEYBOARD[1], "action2", ord("X"));
ds_map_add(global.PLAYER_KEYBOARD[1], "action3", ord("C"));
ds_map_add(global.PLAYER_KEYBOARD[1], "action4", ord("V"));
ds_map_add(global.PLAYER_KEYBOARD[1], "start", vk_space);
ds_map_add(global.PLAYER_KEYBOARD[1], "select", vk_escape);

global.PLAYER_KEYBOARD[2] = ds_map_create();
ds_map_add(global.PLAYER_KEYBOARD[2], "left", vk_left);
ds_map_add(global.PLAYER_KEYBOARD[2], "right", vk_right);
ds_map_add(global.PLAYER_KEYBOARD[2], "up", vk_up);
ds_map_add(global.PLAYER_KEYBOARD[2], "down", vk_down);
ds_map_add(global.PLAYER_KEYBOARD[2], "action1", ord("K"));
ds_map_add(global.PLAYER_KEYBOARD[2], "action2", ord("L"));
ds_map_add(global.PLAYER_KEYBOARD[2], "action3", ord("I"));
ds_map_add(global.PLAYER_KEYBOARD[2], "action4", ord("O"));
ds_map_add(global.PLAYER_KEYBOARD[2], "start", vk_enter);
ds_map_add(global.PLAYER_KEYBOARD[2], "select", vk_backspace);



