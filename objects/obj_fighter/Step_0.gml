/// @description Step event

overlayAlpha = approach(overlayAlpha, 0, 0.1);

// { KOUT-78
if ((hp > 0 && !winner) && hp < character.maxHp / 3) {
	var _maxShakeFactor = 20;
	var _shakeFactor =(character.maxHp / 3 - hp) * _maxShakeFactor / (character.maxHp / 3);	
	shaker.shake(_shakeFactor, 0);
} else if (!shaker.stopped && shaker.decrement == 0) {
	shaker.stopped = true
	shaker.factor = 0;
}
// } KOUT-78

//if (status == FighterStatus.waiting) exit;

//if (playerId == 1)
//	show_debug_message("ESTADO JUGADOR>>>>>>>>>>>>>>>>>>>>> " + string(status));

if (hp > 0) y = PLAYER_Y;

switch (status) {
	case FighterStatus.waiting:
		// Check guard
		dodgeInput.check(!dizzy);
		
		if (!allowStretching) stretcher.hScale = 1;
		if (!allowStretching) stretcher.vScale = 1;
		if (waveEnabled) waveStance();
		if (bounceEnabled) bounceStance();
	break;
	case FighterStatus.enterRing:
		stretcher.hScale = 1;
		stretcher.vScale = 1;
		invulnerable = false;
		alarm[0] = -1;
		alarm[1] = -1;
		alarm[2] = -1;
		visible = true;
		image_index = 0;
		var _targetX = startX;
		x = approach(x, _targetX, 10);
		waveStance();
		// bounceStance();
		attackInput.reset();
		
		// Check guard
		dodgeInput.check(!dizzy);
		
		if (x == _targetX) status = FighterStatus.waiting;
	break;
	case FighterStatus.idle:
		// Read input
		attackInput.check(!dizzy);
		dodgeInput.check(!dizzy);
		recoverGuard();
		depth = 200;
		waveStance();
		bounceStance();
		recoverHP();
		checkRelease(dodgeEnabled);
		image_index = 0;
		checkAttackCharge();
		if (dodgeInput.isPressed() || dodgeInput.isHeld())
			status = FighterStatus.guard;
	break;
	case FighterStatus.guard:
		// Read input
		attackInput.check(!dizzy);
		dodgeInput.check(!dizzy);

		waveStance();
		bounceStance();

		/*
		// slowly consume guard
		var _guardDamage = 0.05;
		guardHp -= _guardDamage;
		guardHealthbar.applyDamage(_guardDamage, _guardDamage, false);
		*/
		
		recoverGuard();
		
		depth = 200;
		recoverHP();
		invulnerable = false;
		image_index = 1;
		checkAttacksReady();
		// If guard is released, go back to idle
		if (dodgeInput.isReleased())
			status = FighterStatus.idle;
		// Unless is an attack...
		checkAttackCharge();
		// ... or a dodge
		checkRelease(dodgeEnabled);
		//if (alarm[0] == -1) alarm[0] = game_get_speed(gamespeed_fps) * character.guardDuration;
	break;
	case FighterStatus.charge:
		invulnerable = false;
		// Read input
		attackInput.check(!dizzy);
		dodgeInput.check(!dizzy);
		recoverHP();
		recoverGuard();
		depth = 200;
		image_index = 2;
		checkAttacksReady();
		checkRelease(dodgeEnabled);
		// checkCancel();
	break;
	case FighterStatus.dodge:
		dodgeEnabled = false;
		// Read input
		attackInput.check(!dizzy);
		dodgeInput.check(!dizzy);
		recoverHP();
		recoverGuard();
		depth = 200;
		image_index = 12;
		// ONLY IF DODGE DID NOT FAILED PLAYER GETS INVULNERABLE
		if (!dodgeFailed) {
			image_index = 3;
			invulnerable = true;
		}
		if (alarm[0] == -1) {
			var _dodgeDuration = character.dodgeDuration;
			if (dodgeFailed) _dodgeDuration = character.dodgeRecoverDuration;
			alarm[0] = game_get_speed(gamespeed_fps) * _dodgeDuration;
			var _sound = getRandomAudio("snd_nylon", 2);
			if (_sound != -1) audio_play_sound(_sound, 100, 0);
		}
		checkAttacksReady();
		checkRelease(false);
		/*
		if (input.is_pressed) {
			status = FighterStatus.charge;
			alarm[0] = -1;
		}
		*/
	break;
	case FighterStatus.startJab:
		dodgeInput.check(!dizzy);
		recoverHP();
		recoverGuard();
		invulnerable = false;
		image_index = 10;
		if (alarm[6] == -1)
			alarm[6] = game_get_speed(gamespeed_fps) * character.jabStartTime;
	break;
	case FighterStatus.startHook:
		dodgeInput.check(!dizzy);
		recoverHP();
		recoverGuard();
		invulnerable = false;
		image_index = 11;
		if (alarm[6] == -1)
			alarm[6] = game_get_speed(gamespeed_fps) * character.hookStartTime;
	break;
	case FighterStatus.jab:
		// Read input
		attackInput.check(!dizzy);
		dodgeInput.check(!dizzy);
		recoverHP();
		checkAttacksReady();
		recoverGuard();
		invulnerable = false;
		depth = 100;
		image_index = 4;
		// SHOW RECOVERY FRAME
		//if (!instance_exists(hitbox)) image_index = 2;
		if (alarm[0] == -1) {
			image_index = 4;
			hitbox = instance_create_layer(x + 800 * image_xscale, y - 500, "Top", obj_hitbox);
			hitbox.owner = id;
			hitbox.life = 1;
			hitbox.hitId = 0;
			
			/// KOUT-78 - PUNCHES CAUSE NO DAMAGE IF YOU ARE TIRED (LOW STAMINA)
			var _strengthFactor = (guardHp < DODGE_COST / 2) ? 0 : strengthFactor;
			hitbox.damage = character.jabDamage * _strengthFactor;
			// JAB_GUARD_DAMAGE IS ALWAYS THE SAME
			/// KOUT-78 - JABS DO NO GUARD DAMAGE
			hitbox.guardDamage = JAB_GUARD_DAMAGE; // 0
			hitbox.points = JAB_SCORE;
			hitbox.stun = character.jabStun;
			// KOUT-78 - Differentiated damage factor
			hitbox.effectiveDamageFactor = EFFECTIVE_DAMAGE_FACTOR;
			
			alarm[0] = game_get_speed(gamespeed_fps) * character.jabDuration;

			hitbox.damage = character.jabDamage * _strengthFactor;

			// KOUT-78 - hit sound
			var _hitSoundName = (hitbox.damage > 0) ? "snd_ushing" : "snd_grunt";
			var _hitSound = getRandomAudio(_hitSoundName, 2);
			if (_hitSound != -1) audio_play_sound(_hitSound, 100, 0);
			
			// Reset strength Factor
			strengthFactor = 1
		}
	break;
	case FighterStatus.hook:
		// Read input
		dodgeInput.check(!dizzy);
		recoverHP();
		recoverGuard();
		invulnerable = false;
		depth = 100;
		image_index = 5;
		// SHOW RECOVERY FRAME
		//if (!instance_exists(hitbox)) image_index = 2;
		if (alarm[0] == -1) {
			image_index = 5;
			hitbox = instance_create_layer(x + 800 * image_xscale, y - 500, "Top", obj_hitbox);
			hitbox.owner = id;
			hitbox.life = 1;
			hitbox.hitId = 1;
			/// KOUT-78 - PUNCHES CAUSE NO DAMAGE IF YOU ARE TIRED (LOW STAMINA)
			var _strengthFactor = (guardHp < DODGE_COST / 2) ? 0 : strengthFactor;
			hitbox.damage = character.hookDamage * _strengthFactor;
			// HOOK_GUARD_DAMAGE IS ALWAYS THE SAME
			hitbox.guardDamage = HOOK_GUARD_DAMAGE;
			hitbox.points = HOOK_SCORE;
			hitbox.stun = character.hookStun;
			// KOUT-78 - make unstoppable (only if causes damage
			hitbox.unstoppable = (hitbox.damage > 0) ? true : false;
			// KOUT-78 - Differentiated damage factor
			hitbox.effectiveDamageFactor = 0.8;
			
			alarm[0] = game_get_speed(gamespeed_fps) * character.hookDuration;

			// KOUT-78 - hit sound
			var _hitSoundName = (hitbox.damage > 0) ? "snd_ushing" : "snd_grunt";
			var _hitSound = getRandomAudio(_hitSoundName, 2);
			if (_hitSound != -1) audio_play_sound(_hitSound, 100, 0);

			// Reset strength Factor
			strengthFactor = 1
		}
	break;
	case FighterStatus.hurt:
		// Read input
		attackInput.check(!dizzy);
		checkRecovery();
		depth = 200;
		attackInput.reset();
		
		dodgeInput.check(!dizzy);
				
		if (alarm[0] == -1) alarm[0] = game_get_speed(gamespeed_fps) * stun;
	break;
	case FighterStatus.dizzy:
		// Read input
		attackInput.check(!dizzy);
		checkRecovery();
		depth = 200;
		image_index = 7;
		attackInput.reset();
		dodgeInput.reset();
	break;
	case FighterStatus.knockdown:
		invulnerable = true;
		if (curSequence == noone) {
			stretcher.hScale = 1;
			stretcher.vScale = 1;
			dropParticles.stop();
			depth = 200;
			with (obj_bird) instance_destroy();
			audio_stop_sound(snd_dizzy);

			var sq = (playerId == 1) ? sq_knockout_p1 : sq_knockout_p2;
			curSequence = layer_sequence_create("Bot", x, y, sq);
			var sq_elem = layer_sequence_get_instance(curSequence);
			sequence_instance_override_object(sq_elem, obj_fighter, id);
			
			show_debug_message("KO SEQUENCE CREATED");

		}
		if (layer_sequence_is_finished(curSequence)) {
			with (obj_fighter) {
				if (other.id != id) {
					winner = true;
				}
			}
			audio_play_sound(snd_fall, 100, 0);
			layer_sequence_destroy(curSequence);
			curSequence = noone;
			status = FighterStatus.freeze;
		}
	break;
	case FighterStatus.win:
		invulnerable = true;
		image_index = 0;
		stretcher.hScale = 1;
		stretcher.vScale = 1;
		// JUMP TO POSITION
		x = (playerId == 1) ? P1_X : P2_X;
		y = PLAYER_Y;
	break;
	case FighterStatus.roundEnd:
		invulnerable = true;
		alarm[0] = -1;
		alarm[1] = -1;
		alarm[2] = -1;
		image_index = 0;
		stretcher.hScale = 1;
		stretcher.vScale = 1;
		var _targetX = startX - ROUND_END_X * image_xscale;
		x = approach(x, _targetX, 10);
		waveWalk();
		attackInput.reset();
		dodgeInput.reset();
	break;
	case FighterStatus.playSequence:
		// SEQUENCE WON'T PLAY IF PLAYER IS KNOCKED OUT
		if (opponent.status == FighterStatus.knockdown) return;
		
		invulnerable = true;
		
		// Read input (for dizzy status only)
		attackInput.check(!dizzy);
		checkRecovery();
		attackInput.reset();
		
		// LAST MINUTE ADDITION TO CHECK FOR GUARD AFTER HAZARD
		// NOT TESTED!
		dodgeInput.check(!dizzy);
		
		alarm[0] = -1;	// Prevent returning to idle
		
		var _sqAssetName = "sq_" + sequenceName + "_p" + string(playerId)
		var _sq = asset_get_index(_sqAssetName);
		if (_sq == -1) {
			show_debug_message("ASSET " + _sqAssetName + " DOES NOT EXIST");
			status = FighterStatus.idle;
			invulnerable = false;
			exit;
		}
		depth = 200;
		if (curSequence == noone) {
			opponent.doWait();
			curSequence = layer_sequence_create("Bot", x, y, _sq);
			var sq_elem = layer_sequence_get_instance(curSequence);
			sequence_instance_override_object(sq_elem, obj_fighter, id);
		}
		if (layer_sequence_is_finished(curSequence)) {
			if (sequenceOpponentWait) {
				opponent.doWait();
			} else {
				opponent.status = FighterStatus.idle;
			}
			layer_sequence_destroy(curSequence);
			curSequence = noone;
			status = sequenceStatusEnd; // (dizzy) ? FighterStatus.dizzy : sequenceStatusEnd;
			invulnerable = false;
		}
	break;
	case FighterStatus.freeze:
		// Check guard
		dodgeInput.check(!dizzy);
	break;
	case FighterStatus.hazard:
		invulnerable = true;
		
		// LAST MINUTE ADDITION TO CHECK FOR GUARD AFTER HAZARD
		// NOT TESTED!
		// Read guard for when the player recovers
		dodgeInput.check(!dizzy);
	break;
}

checkSweat();
