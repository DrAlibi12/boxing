/// @description Insert description here
// You can write your code in this editor

//image_xscale = 10;
//image_yscale = 400;
//x = x - image_xscale / 2;
//y = y - image_yscale;

targetFighter = noone;

enabled = true;

active = false;

shakeAmount = 30;
shakeDec = 0;
damage = 5;
duration = 0.75;

// Any child of obj_hazard_effect
hazardEffect = obj_hazard_effect;

endAction = HazardEnd.resumeFight;

function resumeFight() {
	show_debug_message("RESUME FIGHT");
	targetFighter.setSequence("push_end");
	targetFighter.shaker.shake(10, 0.75);
}

function instaKill() {
	show_debug_message("INSTA KILL");
	//targetFighter.setSequence("push_away", FighterStatus.freeze, true);

	with (targetFighter) {
		receiveDamage(hp, effectiveHp, 0);
		defeated = true;
		objMatchManager.setPlayerDefeated(playerId);
		//targetFighter.status = FighterStatus.knockdown;
	}
}

function runStartAction() {
	show_debug_message("CHECK START ACTION BASED ON HAZARD EFFECT");
	switch (hazardEffect) {
		case obj_heff_sky_fall:
			targetFighter.setSequence("push_away", FighterStatus.freeze, true);
		break;
	}
}

function runEndAction() {
	show_debug_message("CHECK END ACTION");
	switch (endAction) {
		case HazardEnd.resumeFight:
			resumeFight();
		break;
		case HazardEnd.instaKill:
			instaKill();
		break;
		default:
			resumeFight();
		break;		
	}
}
