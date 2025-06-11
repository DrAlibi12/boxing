/// @description init

matchManager = instance_find(obj_match_manager, 0);

objFightSetup = instance_find(obj_fight_setup, 0);

playerId = (matchManager.winner == noone || objFightSetup.PLAYER_IS_CPU[2]) ? 1 : matchManager.winner;

input = createLocalMenuInputManager(
	playerId, global.PLAYER_KEYBOARD[playerId]
);

enabled = true;

navigationEnabled = true;
navigationCooldown = 0.15;

depth = -2000;

x = room_width div 2;
y = room_height div 2;

scale = 1;
angle = 0;

cursorScale = 1;

cursorImage = (playerId == 2) ? 1 : 0;

selected = false;
exiting = false;
exitStartAt = 0;

maxOptionId = 2;
optionId = 0
optIdXDisplace = 0;
optIdColorize = false;

options[0, 0] = "REMATCH";
options[0, 1] = 100;
options[0, 2] = room;	// Repeats same room
options[1, 0] = "SELECT";
options[1, 1] = -50;
options[1, 2] = rm_char_selection;	// Go to select
options[1, 0] = "QUIT";
options[2, 1] = 225;
options[2, 2] = rm_menu;
/*
options[2, 0] = "SELECT FIGHTER";
options[2, 1] = 0;
options[2, 2] = rm_menu;
*/

maxOptionId = array_length(options) - 1;
optionId = 0
optIdXDisplace = 0;
optIdColorize = false;

shaker = instance_create_layer(x, y, "GUI", obj_shaker);
shaker.init(x, y);
shaker.shake(2, 0);

// If browser, avoid QUIT option
//if (os_browser != browser_not_a_browser)
//	maxOptionId = 2;

