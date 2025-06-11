/// @description Insert description here
// You can write your code in this editor

// Must be in the target position to be punched
if (abs(x - P2_X) > 64) exit;

if (!invulnerable && other.owner.object_index != obj_fighter_minion) {
	if (status == FighterStatus.guard) {		
		var _guard = getRandomAudio("snd_guard", 4);
		audio_play_sound(_guard, 100, 0);
		
		shaker.shake(10, 0.5);
		
		var _guardDamage = other.guardDamage;
		guardHp -= _guardDamage;
		//guardHealthbar.applyDamage(_guardDamage, _guardDamage);
		checkDizzy(other.damage);
		exit;
	}

	alarm[0] = -1;
	// Avoid dodge cancel after getting hit
	alarm[2] = -1;
	// Avoid starting attack after getting hit
	alarm[6] = -1;
	
	// Reset charged attacks	
	jabReady = false;
	hookReady = false;

	status = FighterStatus.hurt;

	// RESET INPUTS
	attackInput.reset();
	//dodgeInput.reset();

	var _damage = other.damage;
	// KOUT-78 - Every hit has its effective damage factor
	var _effectiveDamage = _damage * other.effectiveDamageFactor; //EFFECTIVE_DAMAGE_FACTOR;
	
	hp -= _damage;
	effectiveHp -= _effectiveDamage;
	stun = other.stun;
	
	//healthbar.applyDamage(_damage, _effectiveDamage);

	// Avoid death if minHp > 0
	hp = max(hp, minHp);

	if (hp <= 0) {
		// Destroy hitbox to avoid further damage
		// Also to add score
		other.impacted();
		status = FighterStatus.knockdown;
		defeated = true;
		
		//objMatchManager.setPlayerDefeated(playerId);
		owner.minionDefeated();
		
		audio_play_sound(snd_knockdown, 100, 0);
		
		//with (obj_background_scroller) {
		//	backgroundApplySpeed(other.image_xscale, 0);
		//}
		return;
	} else {
		// If minion is still alive, push back
		show_debug_message("PUSHED");
		setSequence("push_start", FighterStatus.hazard, true);
	}

	var _sound = getRandomAudio("snd_punch_low", 4);
	audio_play_sound(_sound, 100, 0);
	_sound = getRandomAudio("snd_punch", 4);
	audio_play_sound(_sound, 100, 0);

	/*
	var _pushToHazard = false;
	// Move background
	with (obj_background_scroller) {
		if (!backgroundCanMove(other.image_xscale)) {
			show_debug_message("CAN MOVE");
			_pushToHazard = true;
		}
		backgroundApplySpeed(other.image_xscale, _damage * 3);
	}
	if (_pushToHazard && place_meeting(x, y, obj_hazard)) {
		show_debug_message("PUSHED");
		setSequence("push_start", FighterStatus.hazard, true);
	}
	*/

	// RECOVER "DODGE" VALUE OF GUARD 
	// ONLY IF NOT DIZZY
	if (!dizzy) {
		guardHp += HIT_GUARD_RECOVERY;
		guardHp = min(guardHp, MAX_GUARD_HP);
		//if (instance_exists(guardHealthbar))
		//	guardHealthbar.applyDamage(-DODGE_COST, -DODGE_COST);
	}
	
	// Shake
	shaker.shake(_damage * 10, _damage div 2);

	// Set hurt image
	image_index = (other.hitId == 0) ? getJabHurtImage() : 8;
	
	// Destroy hitbox to avoid further damage
	// Also to add score
	other.impacted();
}
