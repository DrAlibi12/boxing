/// @description Initialize tutorial

#region DIRECTOR INPUT
input = createLocalMenuInputManager(
	1, global.PLAYER_KEYBOARD[1]
);
#endregion DIRECTOR INPUTS

#region OBJ HOLD TO QUIT
var _margin = 96;
holdToQuit = instance_create_layer(room_width - _margin, _margin, "GUI", obj_hold_to_quit);
holdToQuit.initializeQuit(1, function () {
	with (obj_fighter) {
		doWait(0);
	}
	with (obj_tutorial_step) instance_destroy();
	with (obj_tutorial_director) {
		currentStepId = array_length(tutorialSteps);
		completed = true;
	}
});
#endregion

#region INPUT
//  TUTORIAL INPUTS!
var _joystickManager = instance_find(obj_joystick_manager, 0);
joystickId = _joystickManager.getJoystickForPlayer(1);

// show_message(joystickId);

// Spawn joystick UI
joystickUI = instance_create_layer(
	TUT_UI_JOY_X, TUT_UI_JOY_Y,
	"GUI", obj_tutorial_ui_joystick
);

// Spawn keyboard UI
keyboardUI = instance_create_layer(
	TUT_UI_KEY_X, TUT_UI_KEY_Y,
	"GUI", obj_tutorial_ui_keyboard
);

if (joystickId != -1) {
	keyboardUI.visible = false;
	joystickUI.visible = true;
} else {
	keyboardUI.visible = true;
	joystickUI.visible = false;
}

// HIDE INPUTS
with (obj_tutorial_ui_input) y = TUT_UI_Y_HIDE;
#endregion INPUT

objFightSetup = instance_find(obj_fight_setup, 0);
if (!instance_exists(objFightSetup))
	throw("obj_match_manager: NO obj_fight_setup EXISTS!");

#region INSTANTIATE FIGHTERS
p1 = instance_create_layer(P1_X, PLAYER_Y, "Top", objFightSetup.PLAYER_OBJ_FIGHTER[1]);
p2 = instance_create_layer(P2_X, PLAYER_Y, "Top", objFightSetup.PLAYER_OBJ_FIGHTER[2]);

p1.initFighter(1, objFightSetup.PLAYER_FIGHTER_ID[1], p2, objFightSetup.PLAYER_IS_CPU[1], objFightSetup.PLAYER_CPU_ID[1]);

// SET CHARACTER CPU FOR TRAINING
//objFightSetup.PLAYER_FIGHTER_ID[2] = Roster.Milo;
p2.initFighter(2, objFightSetup.PLAYER_FIGHTER_ID[2], p1, objFightSetup.PLAYER_IS_CPU[2], objFightSetup.PLAYER_CPU_ID[2]);
#endregion INSTANTIATE FIGHTERS

#region SETUP PLAYER
// MAKE PLAYER INVINCIBLE
p1.minHp = 1;

// HIDE PLAYER HEALTHBARS OUTSIDE OF THE SCREEN
// TO USE THEM LATER
//p1.healthbar.x = - p1.healthbar.sprite_width;
//p1.guardHealthbar.x = - p1.guardHealthbar.sprite_width;
#endregion SETUP PLAYER

#region SETUP CPU
// MAKE CPU INVINCIBLE
p2.minHp = 1;

// CPU DUMMY CONTROLS
var _vKeyAtk = instance_create_layer(0, 0, "Bot", obj_virtual_key_atk_dummy);
_vKeyAtk.initAttackKeyCPU(p2, 0, p1);
var _vKeyDodge = instance_create_layer(0, 0, "Bot", obj_virtual_key_dodge_dummy);
_vKeyDodge.initDodgeKeyCPU(p2, 0, p1);

var _virtualInputAtk = new VirtualInput(_vKeyAtk, p2.character.inputMaxHoldTime, p2.character.inputCancelTime);
var _virtualInputDodge = new VirtualInput(_vKeyDodge, p2.character.inputMaxHoldTime, p2.character.inputCancelTime);

p2.attackInput = new InputManager(_virtualInputAtk, -1);
p2.dodgeInput = new InputManager(_virtualInputDodge, -1);

// Hide CPU Bars
p2.healthbar.visible = false;
p2.guardHealthbar.visible = false;
#endregion SETUP CPU


/*
ARRAY tutorialSteps
is a list of steps of the tutorial, taking into
account both explanation texts and tutorial objectives

The structure is the following:
tutorialSteps[_stepId, 0] = object_index (obj_tutorial_text, obj_tutorial_objective, obj_tutorial_event)
tutorialSteps[_stepId, 1] = translation_key (corresponds to the key of the .csv file of the text to show)
tutorialSteps[_stepId, 2] = replacement value for text (if there's any)
tutorialSteps[_stepId, 3] = TutorialObjective struct instance
tutorialSteps[_stepId, 4] = InputHelperConfig struct instance
tutorialSteps[_stepId, 5] = CPUBehaviorConfig struct instance
tutorialSteps[_stepId, 6] = obj_tutorial_event start function 
tutorialSteps[_stepId, 7] = Countdown in seconds to destroy obj_tutorial_event after running the action
tutorialSteps[_stepId, 8] = obj_tutorial_event step function 
*/
tutorialSteps = [];

currentStepId = 0;

completed = false;

translations = getTranslations("tutorial.csv");

// DISABLE PARRY AT BEGINNING OF TUTORIAL
global.PARRY_ENABLED = false;

var _stepId = 0;
tutorialSteps[_stepId, 0] = obj_tutorial_text;
tutorialSteps[_stepId, 1] = "tut_txt_01";
tutorialSteps[_stepId, 2] = undefined;
tutorialSteps[_stepId, 3] = noone;

_stepId = 1;
tutorialSteps[_stepId, 0] = obj_tutorial_objective;
tutorialSteps[_stepId, 1] = "tut_obj_jab";
tutorialSteps[_stepId, 2] = 4;
tutorialSteps[_stepId, 3] = new TutorialObjective(p1, FighterStatus.jab, p2, noone, 4, c_red);
tutorialSteps[_stepId, 4] = new InputHelperConfig(0.15, 1, 0, 0);
tutorialSteps[_stepId, 5] = noone;

var _stepId = 2;
tutorialSteps[_stepId, 0] = obj_tutorial_text;
tutorialSteps[_stepId, 1] = "tut_txt_02";
tutorialSteps[_stepId, 2] = undefined;
tutorialSteps[_stepId, 3] = noone;

_stepId = 3;
tutorialSteps[_stepId, 0] = obj_tutorial_objective;
tutorialSteps[_stepId, 1] = "tut_obj_hook";
tutorialSteps[_stepId, 2] = 3;
tutorialSteps[_stepId, 3] = new TutorialObjective(p1, FighterStatus.hook, p2, noone, 3, c_red);
tutorialSteps[_stepId, 4] = new InputHelperConfig(0.6, 1, 0, 0);
tutorialSteps[_stepId, 5] = noone;

_stepId = 4;
tutorialSteps[_stepId, 0] = obj_tutorial_text;
tutorialSteps[_stepId, 1] = "tut_txt_03";
tutorialSteps[_stepId, 2] = undefined;
tutorialSteps[_stepId, 3] = noone;

_stepId = 5;
tutorialSteps[_stepId, 0] = obj_tutorial_objective;
tutorialSteps[_stepId, 1] = "tut_obj_guard";
tutorialSteps[_stepId, 2] = 3;
tutorialSteps[_stepId, 3] = new TutorialObjective(p1, FighterStatus.guard, p2, FighterStatus.jab, 3, c_blue);
tutorialSteps[_stepId, 4] = new InputHelperConfig(0, 0, 300, 0.5);
tutorialSteps[_stepId, 5] = new CPUBehaviorConfig(DummyCPUActions.jab, 2, -1);

_stepId = 6;
tutorialSteps[_stepId, 0] = obj_tutorial_text;
tutorialSteps[_stepId, 1] = "tut_txt_04";
tutorialSteps[_stepId, 2] = undefined;
tutorialSteps[_stepId, 3] = noone;

_stepId = 7;
tutorialSteps[_stepId, 0] = obj_tutorial_event;
tutorialSteps[_stepId, 1] = "";
tutorialSteps[_stepId, 2] = undefined;
tutorialSteps[_stepId, 3] = noone;
tutorialSteps[_stepId, 4] = noone;
tutorialSteps[_stepId, 5] = noone;
tutorialSteps[_stepId, 6] = function () {
	// Player Guard
	p1.status = FighterStatus.guard;

	// Player Disable controls
	p1.attackInput.setDisabled(true);
	p1.dodgeInput.setDisabled(true);

	// Enable CPU
	p2.status = FighterStatus.idle;
	
	var _cpuConfig = new CPUBehaviorConfig(DummyCPUActions.hook, 0.1, 1);
	_cpuConfig.setBehavior(p2);
};
tutorialSteps[_stepId, 7] = 2;
tutorialSteps[_stepId, 8] = undefined;

_stepId = 8;
tutorialSteps[_stepId, 0] = obj_tutorial_text;
tutorialSteps[_stepId, 1] = "tut_txt_05";
tutorialSteps[_stepId, 2] = undefined;
tutorialSteps[_stepId, 3] = noone;

_stepId = 9;
tutorialSteps[_stepId, 0] = obj_tutorial_objective;
tutorialSteps[_stepId, 1] = "tut_obj_dizzy";
tutorialSteps[_stepId, 2] = undefined;
tutorialSteps[_stepId, 3] = new TutorialObjective(p1, FighterStatus.idle, p2, noone, 1, c_blue);
tutorialSteps[_stepId, 4] = new InputHelperConfig(0.1, 0.1, 0, 0);
tutorialSteps[_stepId, 5] = noone;

_stepId = 10;
tutorialSteps[_stepId, 0] = obj_tutorial_text;
tutorialSteps[_stepId, 1] = "tut_txt_06";
tutorialSteps[_stepId, 2] = undefined;
tutorialSteps[_stepId, 3] = noone;

_stepId = 11;
tutorialSteps[_stepId, 0] = obj_tutorial_objective;
tutorialSteps[_stepId, 1] = "tut_obj_dodge";
tutorialSteps[_stepId, 2] = 3;
tutorialSteps[_stepId, 3] = new TutorialObjective(p1, FighterStatus.dodge, p2, FighterStatus.hook, 3, c_blue, 1);
tutorialSteps[_stepId, 4] = new InputHelperConfig(0, 0, 0.1, 1);
tutorialSteps[_stepId, 5] = new CPUBehaviorConfig(DummyCPUActions.hook, 3, -1);

_stepId = 12;
tutorialSteps[_stepId, 0] = obj_tutorial_text;
tutorialSteps[_stepId, 1] = "tut_txt_07";
tutorialSteps[_stepId, 2] = undefined;
tutorialSteps[_stepId, 3] = noone;

_stepId = 13;
// EVENT - HIGHLIGHT PLAYER GUARD BAR
tutorialSteps[_stepId, 0] = obj_tutorial_event;
tutorialSteps[_stepId, 1] = "";
tutorialSteps[_stepId, 2] = undefined;
tutorialSteps[_stepId, 3] = noone;
tutorialSteps[_stepId, 4] = noone;
tutorialSteps[_stepId, 5] = noone;
tutorialSteps[_stepId, 6] = function () {
	// EVENT - HIGHLIGHT PLAYER GUARD BAR
	show_debug_message("EVENT - HIGHLIGHT PLAYER GUARD BAR");
	
	var _signX = HEALTHBAR_P1_X + sprite_get_width(spr_guard_healthbar) + 24
	var _signY = GUARD_HEALTHBAR_Y + sprite_get_height(spr_guard_healthbar) / 2;
	var _exclamation = instance_create_layer(_signX, _signY, "GUI", obj_sign_exclamation);
	_exclamation.initBlink(0.3);
};
tutorialSteps[_stepId, 7] = 0.1;
tutorialSteps[_stepId, 8] = undefined;

_stepId = 14;
tutorialSteps[_stepId, 0] = obj_tutorial_text;
tutorialSteps[_stepId, 1] = "tut_txt_08";
tutorialSteps[_stepId, 2] = undefined;
tutorialSteps[_stepId, 3] = noone;

_stepId = 15;
// EVENT - GET PLAYER TIRED
tutorialSteps[_stepId, 0] = obj_tutorial_event;
tutorialSteps[_stepId, 1] = "";
tutorialSteps[_stepId, 2] = undefined;
tutorialSteps[_stepId, 3] = noone;
tutorialSteps[_stepId, 4] = noone;
tutorialSteps[_stepId, 5] = noone;
tutorialSteps[_stepId, 6] = function () {
	// EVENT - CPU ATTACK PLAYER
	show_debug_message("EVENT START - GET PLAYER TIRED");
	
	// Player Guard
	p1.status = FighterStatus.guard;
	
	// Player Disable controls
	p1.attackInput.setDisabled(true);
	p1.dodgeInput.setDisabled(true);

	// Enable CPU
	p2.status = FighterStatus.idle;
	
	var _cpuConfig = new CPUBehaviorConfig(DummyCPUActions.jab, 0.15);
	_cpuConfig.setBehavior(p2);
};
tutorialSteps[_stepId, 7] = -1;
tutorialSteps[_stepId, 8] = function () {
	// EVENT - ATTACK PLAYER UNTIL GUARD IS LOW
	if (other.alarm[0] != -1) return;

	show_debug_message("EVENT STEP - GET PLAYER TIRED");
	
	if (p1.guardHp <= GUARD_SECTION_VALUE) {
		// PLAYER DISABLE RECOVER
		p1.character.guardAutoRecoveryTime = 0; // 0.1 to recover
		p1.alarm[3] = -1;

		// STOP CPU ATTACK
		with (obj_virtual_key_atk_dummy) stop();
		
		// FINISH THIS EVENT
		if (other.alarm[0] == -1) other.alarm[0] = 1;
	}
};

_stepId = 16;
tutorialSteps[_stepId, 0] = obj_tutorial_text;
tutorialSteps[_stepId, 1] = "tut_txt_09";
tutorialSteps[_stepId, 2] = undefined;
tutorialSteps[_stepId, 3] = noone;

_stepId = 17;
// EVENT - PLAYER RECOVER GUARD
tutorialSteps[_stepId, 0] = obj_tutorial_event;
tutorialSteps[_stepId, 1] = "";
tutorialSteps[_stepId, 2] = undefined;
tutorialSteps[_stepId, 3] = noone;
tutorialSteps[_stepId, 4] = noone;
tutorialSteps[_stepId, 5] = noone;
tutorialSteps[_stepId, 6] = function () {
	show_debug_message("EVENT START - PLAYER RECOVER GUARD");
	
	// CHARACTER RECOVER
	p1.doWait(0);
	
	// Player Disable controls
	p1.attackInput.setDisabled(true);
	p1.dodgeInput.setDisabled(true);
	
	// ALLOW PLAYER TO RECOVER
	p1.character.guardAutoRecoveryTime = 0.1;
};
tutorialSteps[_stepId, 7] = -1;
tutorialSteps[_stepId, 8] = function () {
	if (other.alarm[0] != -1) return;

	show_debug_message("EVENT STEP - PLAYER RECOVER GUARD");
	if (p1.alarm[3] == -1) p1.alarm[3] = game_get_speed(gamespeed_fps) * p1.character.guardAutoRecoveryTime;
	
	if (p1.guardHp == MAX_GUARD_HP) {
		// RE-ENABLE PARRY FOR NEXT TUTORIAL OBJECTIVE
		global.PARRY_ENABLED = true;

		audio_play_sound(snd_score_full, 100, 0);
		instance_destroy(obj_sign_exclamation);
		if (other.alarm[0] == -1) other.alarm[0] = 1;
	}
};

_stepId = 18;
tutorialSteps[_stepId, 0] = obj_tutorial_text;
tutorialSteps[_stepId, 1] = "tut_txt_10";
tutorialSteps[_stepId, 2] = undefined;
tutorialSteps[_stepId, 3] = noone;

_stepId = 19;
tutorialSteps[_stepId, 0] = obj_tutorial_text;
tutorialSteps[_stepId, 1] = "tut_txt_11";
tutorialSteps[_stepId, 2] = undefined;
tutorialSteps[_stepId, 3] = noone;

_stepId = 20;
tutorialSteps[_stepId, 0] = obj_tutorial_objective;
tutorialSteps[_stepId, 1] = "tut_obj_counter";
tutorialSteps[_stepId, 2] = 2;
tutorialSteps[_stepId, 3] = new TutorialObjective(p1, FighterStatus.freeze, p2, FighterStatus.freeze, 2, c_blue, 2, 1.5);
tutorialSteps[_stepId, 4] = new InputHelperConfig(0, 0, 0.5, 1.5);
tutorialSteps[_stepId, 5] = new CPUBehaviorConfig(DummyCPUActions.jab, 2);

_stepId = 21;
tutorialSteps[_stepId, 0] = obj_tutorial_text;
tutorialSteps[_stepId, 1] = "tut_txt_12";
tutorialSteps[_stepId, 2] = undefined;
tutorialSteps[_stepId, 3] = noone;

function stepStart() {
	if (currentStepId >= array_length(tutorialSteps)) {
		// TUTORIAL END
		alarm[2] = game_get_speed(gamespeed_fps) * 1;
		return;
	}
	
	var _objStep = tutorialSteps[currentStepId, 0];

	// GET CURRENT TEXT FROM CSV & LANGUAGE
	var _text = getText(translations, tutorialSteps[currentStepId, 1]);
	if (tutorialSteps[currentStepId, 2] != undefined) {
		_text = string_replace_all(_text, "{0}", tutorialSteps[currentStepId, 2]);
	}

	switch (_objStep) {
		case obj_tutorial_objective:
			// SHOW INPUT HELPERS
			with (obj_tutorial_ui_input) y = startY;
			
			// Check input helper config
			var _inputHelperConfig = tutorialSteps[currentStepId, 4];
			if (is_struct(_inputHelperConfig)) {
				_inputHelperConfig.applyConfig();
			}
			
			// VALIDATE OBJECTIVE EXISTENCE
			if (tutorialSteps[currentStepId, 3] == noone) {
				throw ("No Objective exists for tutorial step #" + string(currentStepId));
			}
			
			// CHECK CPU BEHAVIOR
			var _cpuBehaviourConfig = tutorialSteps[currentStepId, 5];
			if (tutorialSteps[currentStepId, 5] != noone) {
				_cpuBehaviourConfig.setBehavior(p2);
			}
			
			// Enable players
			if (!p1.dizzy) p1.status = FighterStatus.idle;
			p2.status = FighterStatus.idle;
			
			// Enable controls
			p1.attackInput.setDisabled(false);
			p1.dodgeInput.setDisabled(false);

			// SPAWN TUTORIAL OBJECTIVE
			var _tutorialObjective = tutorialSteps[currentStepId, 3];
			var _objective = instance_create_layer(0, 0, "GUI", obj_tutorial_objective);
			_objective.initTutorialObjective(_text, _tutorialObjective, id);
			
		break;
		case obj_tutorial_text:
			// HIDE INPUT HELPERS
			with (obj_tutorial_ui_input) y = TUT_UI_Y_HIDE;
			
			// SPAWN TUTORIAL TEXT
			invokeTutorialText(_text, id);
		break;
		case obj_tutorial_event:
			// HIDE INPUT HELPERS
			with (obj_tutorial_ui_input) y = TUT_UI_Y_HIDE;

			// show_message("SPAWN EVENT");

			// SPAWN TUTORIAL EVENT
			var _event = instance_create_layer(0, 0, "GUI", obj_tutorial_event);
			_event.initEvent(tutorialSteps[currentStepId, 6], id, tutorialSteps[currentStepId, 8]);

			// PLAY EVENT
			_event.runCallback(tutorialSteps[currentStepId, 7]);
		break;
		default:
			throw ("Unkown tutorial step object: " + string(object_get_name(_objStep)));
		break;
	}	
}

function nextStep() {
	if (currentStepId >= array_length(tutorialSteps)) {
		// TUTORIAL END
		alarm[2] = game_get_speed(gamespeed_fps) * 3;
		return;
	}

	// Player Disable controls
	p1.attackInput.setDisabled(true);
	p1.dodgeInput.setDisabled(true);
	with (obj_fighter) {
		if (!dizzy) doWait(0);
	}

	with (obj_virtual_key_atk_dummy) stop();
	with (obj_virtual_key_dodge_dummy) stop();
	with (obj_tutorial_ui_input) {
		y = TUT_UI_Y_HIDE;
		setAttackActive(false);
		setGuardActive(false);
	}
	
	currentStepId += 1;

	// NEXT STEP
	alarm[1] = game_get_speed(gamespeed_fps) * 1;
}

function tutorialStart() {
	// P1 WAIT
	p1.doWait(0);
	p1.invulnerable = false;
	// P2 WAIT
	p2.doWait(0);
	p2.invulnerable = false;
	
	stepStart();
}

p1.status = FighterStatus.enterRing;
p2.status = FighterStatus.enterRing;

// Start tutorial in X seconds
alarm[0] = game_get_speed(gamespeed_fps) * 3;

// stepStart();
