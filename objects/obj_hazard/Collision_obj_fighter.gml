/// @description Fall into hazard

if (active || alarm[0] != -1) exit;

// PLAYER WILL ONLY BE AFECTED BY A HAZARD IF IT'S ON HAZARD STATUS
if (other.status != FighterStatus.hazard) exit;

//show_debug_message("FIGHTER STATUS " + string(other.status));

active = true;

var _fighter = other;

//show_debug_message("CHECKING SEQUENCE: " + string(_fighter.curSequence));

if (_fighter.curSequence == noone) {
	//show_debug_message("NO SEQUENCE");
	_fighter.status = FighterStatus.hazard;
	_fighter.shaker.shake(shakeAmount, shakeDec);
	_fighter.receiveDamage(damage, damage, 1);
	
	// Remove dizzyness
	_fighter.dizzy = false;
	with (obj_bird) instance_destroy();
	
	//show_debug_message("DAMAGE APPLIED");
}

targetFighter = _fighter;

//show_debug_message("CREATING EFFECT");

// Create hazard effect
if (object_exists(hazardEffect)) {
	var _effect = instance_create_layer(targetFighter.x, PLAYER_Y, "Overlay", hazardEffect);
	_effect.image_xscale *= sign(targetFighter.image_xscale);
	show_debug_message("HAZARD EFFECT CREATED: " + object_get_name(hazardEffect));

	runStartAction();
}

//show_debug_message("SHOCK ALARM 0 SET TO " + string(game_get_speed(gamespeed_fps) * shockDuration) + " STEPS");
alarm[0] = max(1, game_get_speed(gamespeed_fps) * duration);
