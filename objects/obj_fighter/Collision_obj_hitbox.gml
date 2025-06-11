/// @description Insert description here
// You can write your code in this editor

if (!invulnerable && other.owner != id) {
	if (!other.unstoppable && checkParry()) exit;

	// KOUT-78 - if attack has no damage, dont't react to it
	if (other.damage == 0) {
		var _guard = getRandomAudio("snd_guard", 4);
		audio_play_sound(_guard, 100, 0);
		exit;
	}
	
	if (status == FighterStatus.guard) {
		var _guard = getRandomAudio("snd_guard", 4);
		audio_play_sound(_guard, 100, 0);
		
		shaker.shake(10, 0.5);
		
		var _prevGuardHp = guardHp;
		
		var _guardDamage = other.guardDamage;
		guardHp -= _guardDamage;
		guardHealthbar.applyDamage(_guardDamage, _guardDamage);
		
		// KOUT-78 - Temporarily remove dizzy status
		//checkDizzy(other.damage);
		//exit;
		// KOUT78 - Replace dizzy with single "guard break"
		// If the attack is not unstoppable, it will be guarded
		// Otherwise, the damage application will apply normally
		if (!other.unstoppable && _prevGuardHp > DODGE_COST * 1.15) {
			exit;
		}
		
		// KOUT-78 - GUARD STUN
		guardStun = other.stun;
		alarm[8] = game_get_speed(gamespeed_fps) * guardStun;
	}

	alarm[0] = -1;
	// Avoid dodge cancel after getting hit
	alarm[2] = -1;
	// Avoid starting attack after getting hit
	alarm[6] = -1;
	
	var _damage = other.damage;
	// KOUT_78 - Every hit has its effective damage factor
	var _effectiveDamage = _damage * other.effectiveDamageFactor; //EFFECTIVE_DAMAGE_FACTOR;
	
	hp -= _damage;
	effectiveHp -= _effectiveDamage;
	stun = other.stun;
	
	healthbar.applyDamage(_damage, _effectiveDamage);

	// Avoid death if minHp > 0
	// KOUT-78 - Can't knockout an opponent without a HOOK/HEAVY ATTACK
	var _minHp = (other.unstoppable/*|| effectiveHp <= 1*/) ? minHp : 1;
	hp = max(hp, _minHp);

	if (hp <= 0) {
		healthbar.updateValue(0, false, 0);
		guardHealthbar.updateValue(0, false, 0);

		// Destroy hitbox to avoid further damage
		// Also to add score
		other.impacted();
		status = FighterStatus.knockdown;
		defeated = true;
		
		objMatchManager.setPlayerDefeated(playerId);
		
		audio_play_sound(snd_knockdown, 100, 0);
		
		with (obj_background_scroller) {
			backgroundApplySpeed(other.image_xscale, 0);
		}
		return;
	}
	
	var _sound = getRandomAudio("snd_punch_low", 4);
	audio_play_sound(_sound, 100, 0);
	_sound = getRandomAudio("snd_punch", 4);
	audio_play_sound(_sound, 100, 0);

	// Shake
	shaker.shake(_damage * 10, _damage div 2);

	// UNSTOPPABLE WHEN HOOK IS READY
	if (!other.unstoppable && (hookReady || status == FighterStatus.startHook)) {
		var _punch = getRandomAudio("snd_punch_low", 4);
		audio_play_sound(_punch, 100, 0);
		shaker.shake(10, 0.5);
		other.impacted();
		return;
	}

	// Reset charged attacks	
	jabReady = false;
	hookReady = false;

	status = FighterStatus.hurt;

	// RESET INPUTS
	attackInput.reset();
	//dodgeInput.reset();

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

	// RECOVER "DODGE" VALUE OF GUARD 
	// ONLY IF NOT DIZZY
	if (!dizzy) {
		guardHp += HIT_GUARD_RECOVERY;
		guardHp = min(guardHp, MAX_GUARD_HP);
		if (instance_exists(guardHealthbar))
			guardHealthbar.applyDamage(-DODGE_COST, -DODGE_COST);
	}

	// Set hurt image
	image_index = (other.hitId == 0) ? getJabHurtImage() : 8;
	
	// Destroy hitbox to avoid further damage
	// Also to add score
	other.impacted();
}
