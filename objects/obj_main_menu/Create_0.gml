/// @description init

objFightSetup = instance_find(obj_fight_setup, 0);
if (!instance_exists(objFightSetup))
	throw("obj_main_menu: NO obj_fight_setup EXISTS!");

objArcade = (instance_number(obj_arcade_progression) > 0)
				? instance_find(obj_arcade_progression, 0)
				: instance_create_layer(0, 0, "GUI", obj_arcade_progression);

enabled = true;

//input = createLocalInputManager(1, 1000, 0);
menuInputs = [];

navigationEnabled = true;
navigationCooldown = 0.15;

x = room_width div 2;
y = room_height div 2;

scale = 1;
angle = 0;

cursorScale = 1;

selected = false;
exiting = false;
exitStartAt = 0;


// STORY MODE MENU
storyOptions[0, 0] = "story_menu_new_game";
storyOptions[0, 1] = 0;
storyOptions[0, 2] = -1;
storyOptions[0, 3] = "NEW_GAME";
storyOptions[1, 0] = "story_menu_continue";
storyOptions[1, 1] = 0;
storyOptions[1, 2] = -1;
storyOptions[1, 3] = "LOAD";

// FREEPLAY MODE MENU
freplayOptions[0, 0] = "NEW GAME";
freeplayOptions[0, 0] = "CONTINUE";

// MAIN MENU
options[0, 0] = "menu_arcade"; //"ARCADE";
options[0, 1] = 0;
options[0, 2] = rm_tutorial_demo;
options[0, 3] = obj_story_mode_menu; //"LOAD";
//options[0, 3] = "LOAD"; //rm_tutorial_demo;
options[1, 0] = "menu_pvp"; // "P1 VS P2";
options[1, 1] = 46;
options[1, 2] = rm_char_selection;
options[1, 3] = noone;
options[2, 0] = "menu_options"; //"OPTIONS";
options[2, 1] = 0;
options[2, 2] = 0//-1;
options[2, 3] = obj_options_menu;
/*options[2, 0] = "menu_language"; //"LANGUAGE";
options[2, 1] = 0;
options[2, 2] = -1;
options[2, 3] = noone;*/
options[3, 0] = "menu_quit"; //"QUIT";
options[3, 1] = 225;
options[3, 2] = rm_quit;
options[3, 3] = noone;
options[4, 0] = "TEST"; //"QUIT";
options[4, 1] = 0;
options[4, 2] = rm_fight;
options[4, 3] = noone;

	

// OLD OPTIONS
//options[0, 0] = "P1 VS CPU";
//options[0, 1] = 0;
//options[0, 2] = rm_fight;
//options[0, 2] = rm_char_selection;
//options[1, 2] = rm_char_selection;
//options[2, 0] = "CPU VS CPU";
//options[2, 1] = - 32;
//options[2, 2] = rm_fight_club;
//options[2, 2] = rm_char_selection;
//options[3, 0] = "TRAINING";
//options[3, 1] = 59;
//options[3, 2] = rm_training;


maxOptionId = array_length(options) - 1;
optionQty = 3; // MAX OPTIONS VISIBLE AT A TIME
optionId = 0
optIdXDisplace = 0;
optIdColorize = false;

function doRunOption() {
	if (options[optionId, 2] == rm_training) {
		with (obj_song_player) doFilter(true, 2000);
	} else if (options[optionId, 2] == rm_fight) {
		with (obj_song_player) doFilter(true, 2000);
	}
	
	doSetupPlayers();
	
	selected = true;
	cursorScale = 2;
	optIdXDisplace = 250;
	optIdColorize = true;
	alarm[0] = game_get_speed(gamespeed_fps) * 0.05;
	alarm[1] = game_get_speed(gamespeed_fps) * 1;
	
	// Disable to prevent more inputs
	enabled = false;
}

function doSetupPlayers() {
	//show_message("option id: " + string(optionId));
	switch (optionId) {
		case 0:
			// P1 VS CPU
			var _cpu = 2; // irandom(5);
			//show_message("CPU id: " + string(_cpu));
			objFightSetup.fightSetPlayers(false, -1, true, _cpu);

			// CREATE ARCADE PROGRESSION OBJECT
			//var _objArcade = instance_create_layer(0, 0, "GUI", obj_arcade_progression);
	
			// LOAD GAME!!!!
			/*
			if (global.GAME_STATE.storyModeSlots[0].DATETIME_STARTED == -1) {
				global.GAME_STATE.storyModeSlots[0].startGame(0);
			}
			_objArcade.startLoadedGame(global.GAME_STATE.storyModeSlots[0]);
			*/
		break;
		case 1:
			// P1 VS P2
			objFightSetup.fightSetPlayers(false, -1, false, -1);
			
			// END OPTIONS
			var _END_OPTIONS = [];
			_END_OPTIONS[0, 0] = "end_menu_rematch";
			_END_OPTIONS[0, 1] = 100;
			_END_OPTIONS[0, 2] = rm_fight;
			//_END_OPTIONS[1, 0] = "end_menu_selection";
			//_END_OPTIONS[1, 1] = 100;
			//_END_OPTIONS[1, 2] = rm_select_fighters;
			_END_OPTIONS[1, 0] = "end_menu_quit";	// Option Text Key
			_END_OPTIONS[1, 1] = 100;				// x Displace
			_END_OPTIONS[1, 2] = rm_menu;			// Target Room

			objFightSetup.fightSetEndOptions(_END_OPTIONS);
			
		break;
		case 2:
			// CPU VS P2
			//var _cpu1 = irandom(5);
			//var _cpu2 = irandom(5);
			var _cpuMax = 5;
			objFightSetup.fightSetPlayers(true, _cpuMax, true, _cpuMax);
		break;
	}
}

shaker = instance_create_layer(x, y, "GUI", obj_shaker);
shaker.init(x, y);
shaker.shake(2, 0);

// If browser, avoid QUIT option
if (os_browser != browser_not_a_browser)
	maxOptionId = 3;

// wait 2 frames to enable controls
alarm[2] = 2;