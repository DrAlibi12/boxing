/// @description init

/*
objFightSetup = instance_find(obj_fight_setup, 0);
if (!instance_exists(objFightSetup))
	throw("obj_main_menu: NO obj_fight_setup EXISTS!");
*/
objArcade = (instance_number(obj_arcade_progression) > 0)
				? instance_find(obj_arcade_progression, 0)
				: instance_create_layer(0, 0, "GUI", obj_arcade_progression);

objMainMenu = instance_find(obj_main_menu, 0);
if (!instance_exists(objMainMenu))
	throw("obj_story_mode_menu: NO obj_main_menu EXISTS!");

shaker = objMainMenu.shaker;

enabled = true;

//input = createLocalInputManager(1, 1000, 0);
menuInputs = objMainMenu.menuInputs;

navigationEnabled = true;
navigationCooldown = 0.15;

x = room_width div 2;
y = room_height div 2// + 140 - 96;

scale = 1;
angle = 0;

cursorScale = 1;

selected = false;
exiting = false;
exitStartAt = 0;


// STORY MODE MENU
options[0, 0] = "menu_fullscr";
options[0, 1] = 0;
options[0, 2] = -1;
options[0, 3] = noone;
options[1, 0] = "menu_volume";
options[1, 1] = 0;
options[1, 2] = -1;
options[1, 3] = noone;
options[2, 0] = "menu_language"; //"LANGUAGE";
options[2, 1] = 0;
options[2, 2] = -1;
options[2, 3] = noone;

maxOptionId = 2;
optionQty = 3; // MAX OPTIONS VISIBLE AT A TIME
optionId = 0;
optIdXDisplace = 0;
optIdColorize = false;

cancelled = false;

function cancel() {
	cancelled = true;
}

function doRunOption() {
	/*
	if (options[optionId, 2] == rm_training) {
		with (obj_song_player) doFilter(true, 2000);
	} else if (options[optionId, 2] == rm_fight) {
		with (obj_song_player) doFilter(true, 2000);
	}
	*/
	
	objMainMenu.doSetupPlayers();
	
	selected = true;
	cursorScale = 2;
	optIdXDisplace = 250;
	optIdColorize = true;
	alarm[0] = game_get_speed(gamespeed_fps) * 0.05;
	alarm[1] = game_get_speed(gamespeed_fps) * 1;
	
	// Disable to prevent more inputs
	enabled = false;
}
