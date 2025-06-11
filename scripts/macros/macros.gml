// MENU
#macro SELECT_CONFIRM_TIME 1000	// 1 second
#macro SELECT_CHANGE_TIME 300	// 0.2 second

// OLD
/*
#macro MAX_HOLD_TIME 300	// 0.3 second
#macro MIN_HOOK_TIME 250	// 0.25 second
#macro MAX_CANCEL_TIME 100	//150	// 0.15 second
#macro MAX_DODGE_TIME 100	// 0.1 second
#macro GUARD_DURATION 0.1	// 0.1 seconds
#macro JAB_DURATION 0.2
#macro HOOK_DURATION 0.4
#macro JAB_START_TIME 0.2
#macro HOOK_START_TIME 0.4
*/

#macro MAX_HP 30
#macro HP_RECOVERY 1 // 0.5
#macro HP_RECOVER_EVERY 0.5 // seconds

#macro P1_KEY vk_space
#macro P2_KEY vk_enter



// 2 BUTTONS
global.ATTACK_KEY[1] = ord("Z");
global.DODGE_KEY[1] = ord("X");

global.ATTACK_KEY[2] = ord("K");
global.DODGE_KEY[2] = ord("L");
// FOR SHIT SCENARIO TESTS WHEN PLAYERS ATTACK AT THE SAME TIME
//global.ATTACK_KEY[2] = global.ATTACK_KEY[1];

#macro GUARD_SECTION_VALUE 5

#macro DODGE_COST GUARD_SECTION_VALUE

#macro HIT_GUARD_RECOVERY GUARD_SECTION_VALUE div 2

#macro MAX_GUARD_HP 20
#macro GUARD_SECTIONS 4
#macro GUARD_DANGER_VALUE DODGE_COST
#macro GUARD_AUTO_RECOVER_EVERY 0.1 // 0.5
#macro GUARD_HP_RECOVERY_AUTO 0.25	// 0.5	// seconds
#macro GUARD_HP_RECOVERY_MANUAL 2
#macro GUARD_RECOVERY_DAMAGE DODGE_COST div 2
#macro GUARD_VALUE_TO_RECOVER MAX_GUARD_HP // MAX_GUARD_HP / 2

// INPUT VARIABLES
// READABILITY BUT QUITE SLOW
#macro MAX_HOLD_TIME 700	// 0.8 second
#macro MIN_HOOK_TIME 600	// 0.6 second
#macro MAX_CANCEL_TIME 100	// 0.1 second
#macro MAX_DODGE_TIME 150	// 0.15 second

#macro DODGE_DURATION 0.2
#macro DODGE_RECOVER_DURATION 0.3
#macro GUARD_DURATION 0.1	// 0.2 seconds
#macro JAB_DURATION 0.2
#macro HOOK_DURATION 0.4
#macro JAB_START_TIME 0.2
#macro HOOK_START_TIME 0.4

#macro PIERCE_DAMAGE_FACTOR 0.5

// Max hold time for parry
#macro PARRY_MAX_TIME 75
global.PARRY_INVALID_STATUS = [
	FighterStatus.charge,
	//FighterStatus.dodge, // prevent parrying while dodging
	FighterStatus.startJab,
	FighterStatus.startHook,
	FighterStatus.jab,
	FighterStatus.hook,
	FighterStatus.freeze // prevent parrying a parry
];

// ACTIVATION FLAGS
//global.PARRY_ENABLED = true;
// KOUT-78 - disable parry
global.PARRY_ENABLED = false;


/*
#macro JAB_DURATION 0.15
#macro HOOK_DURATION 0.5
#macro JAB_START_TIME 0.15
#macro HOOK_START_TIME 0.35
*/

// DAMAGES
#macro EFFECTIVE_DAMAGE_FACTOR 0.2
#macro JAB_DAMAGE 5 // 3
#macro HOOK_DAMAGE 16
// THESE ARE UNUSED
#macro JAB_DAMAGE_MIN 0.5
#macro JAB_DAMAGE_MAX 2.5
// GUARD DAMAGE
// KOUT-78 - JAB DAMAGE = GUARD_SECTION_VALUE / 2
#macro JAB_GUARD_DAMAGE GUARD_SECTION_VALUE / 2  // GUARD_SECTION_VALUE * 1.5 //MAX_GUARD_HP div 2
#macro HOOK_GUARD_DAMAGE MAX_GUARD_HP

#macro STUN_DURATION 0.3	// 0.3 seconds UNUSED
#macro JAB_STUN 0.25		// 0.3 seconds
#macro HOOK_STUN 0.6	// 0.3 seconds

// SCORE
#macro JAB_SCORE 1		// 0.3 seconds
#macro HOOK_SCORE 3		// 0.3 seconds

#macro DECISION_SIGN_Y 144

#macro HEALTHBAR_P1_X 32
#macro HEALTHBAR_P2_X 1888 // 1920 - 32
#macro HEALTHBAR_Y 32
#macro GUARD_HEALTHBAR_Y HEALTHBAR_P1_X + sprite_get_height(spr_healthbar)

#macro BGM_MAX_VOLUME 0.7

#macro TIMER_Y 96

// ROUND CONFIG
#macro MAX_ROUNDS 1
#macro ROUND_END_X 1200
#macro ROUND_TIME 80

// PLAYER POSITION
#macro P1_X 544
#macro P1_X_OUT P1_X - ROUND_END_X
#macro P2_X 1344
#macro P2_X_OUT P2_X + ROUND_END_X
#macro PLAYER_Y 1080

// BOSS POSITION
#macro BOSS_WALK_BACK_X 1600

// SELECTION SCREEN
#macro PREVIEW_X 384
#macro PREVIEW_Y 1088

#macro CHAR_SELECTION_MENU_H_MARGIN 64
#macro CHAR_SELECTION_MENU_V_MARGIN 24
#macro CHAR_SELECTION_MENU_Y sprite_get_height(spr_portraits) div 2 + CHAR_SELECTION_MENU_V_MARGIN

// CROWD MANAGER POSITION
#macro CROWD_Y 1080 //928

// Vertical margin for "fill" of fnt_sqrt_obl_64
// regarding fnt_sqrt_obl_shd_64
#macro FNT_SQRT_FILL_Y_MARGIN_TOP 6
#macro FNT_SQRT_FILL_Y_MARGIN_MID 3

enum FighterStatus {
	enterRing,
	waiting,
	idle,
	guard,
	charge,
	cancel,
	dodge,
	parry,
	startJab,
	startHook,
	jab,
	hook,
	hurt,
	dizzy,
	knockdown,
	freeze,
	win,
	roundEnd,
	playSequence,
	hazard,
	bossWalkBack,
	bossPrepareSpecial,
	bossSpecial,
	bossSpecialEnd
}

// Level types
enum LEVEL {
	PVP,
	NORMAL,
	WAVE,
	BOSS
}

#macro HAZARD_XSCALE 384
#macro HAZARD_YSCALE 192

#macro HAZARD_Y 1024
#macro HAZARD_X1 0
#macro HAZARD_X2 1536


enum HazardEnd {
	resumeFight,
	instaKill
}