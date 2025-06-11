/// @description Insert description here
// You can write your code in this editor

btnWidth = sprite_get_width(spr_training_btn_red);

active = false;

startX = x - btnWidth * 1;
startY = y;

glowDisabled = 0;
glowMin = 0;
glowMax = 0.6;

attackEnabled = false;
attackBlend = c_gray;
attackGlow = 0;
attackImage = 0;
attackHoldTime = 1;
attackReleaseTime = 0.5;

guardEnabled = false;
guardBlend = c_gray;
guardGlow = 0;
guardImage = 0;
guardHoldTime = 1;
guardReleaseTime = 0.5;

function setAttackActive(_active, _holdTime=1, _releaseTime=0.5) {
	attackEnabled = _active;
	attackBlend = (attackEnabled) ? c_white : c_gray;
	if (!attackEnabled) {
		alarm[0] = -1;
		alarm[1] = -1;
		attackImage = 0;
		exit;
	}

	attackHoldTime = _holdTime;
	attackReleaseTime = _releaseTime;
	alarm[0] = game_get_speed(gamespeed_fps) * attackReleaseTime;
}

function setGuardActive(_active, _holdTime=1, _releaseTime=0.5) {
	guardEnabled = _active;
	guardBlend = (guardEnabled) ? c_white : c_gray;
	if (!guardEnabled) {
		alarm[2] = -1;
		alarm[3] = -1;
		guardImage = 0;
		exit;
	}
	guardHoldTime = _holdTime;
	guardReleaseTime = _releaseTime;
	alarm[2] = game_get_speed(gamespeed_fps) * guardReleaseTime;
}

//setAttackActive(true);
//setGuardActive(true);
