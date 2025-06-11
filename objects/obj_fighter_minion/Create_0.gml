/// @description Insert description here
/// @description Insert description here
// You can write your code in this editor

// Match manager
objMatchManager = instance_find(obj_match_manager, 0);

var _keyboardAttackInput = new KeyboardInput(ord("Z"), 500, 0, 0);
attackInput = new InputManager(_keyboardAttackInput, -1);

var _keyboardDodgeInput = new KeyboardInput(ord("Z"), MAX_HOLD_TIME, 0, 0);
dodgeInput = new InputManager(_keyboardDodgeInput, -1);

charId = Roster.Juan;
character = noone;

dodgeEnabled = true;

playerId = 1;

opponent = noone;

strengthFactor = 1;

timeRandomness = irandom_range(0, 1000);

currentRound = 1;
points[1] = 0;
points[2] = 0;
points[3] = 0;

startX = x;

defeated = false;

winner = false;

effectiveHp = MAX_HP;
hp = MAX_HP;
guardHp = MAX_GUARD_HP;
stun = 0;
dizzy = false;
dodgeFailed = false;

// minHp = 0 -> Allows fighter to be knocked out
// Set to 1 or higher to avoid death (this is currently used at the tutorial)
minHp = 0;

healthbar = noone;
guardHealthbar = noone;

// Rest variables
resting = true;
hpDifference = 0;
targetHp = 0;
effHpDifference = 0;
targetEffHp = 0;
guardDifference = 0;
targetGuard = 0;

image_index = 0;
image_speed = 0;

invulnerable = false;

jabImage = 0;

jabReady = false;
hookReady = false;
overlayColor = c_white;
overlayAlpha = 0;

hitbox = noone;

visible = false;
status = FighterStatus.waiting;

sequenceName = "";
sequenceStatusEnd = FighterStatus.idle;
sequenceOpponentWait = false;
curSequence = noone;

shaker = instance_create_layer(x, y, "Top", obj_shaker);
shaker.init(x, y);

stretcher = instance_create_layer(x, y, "Top", obj_stretcher);
stretcher.initStretcher(image_xscale, image_yscale);

dropParticles = instance_create_layer(x, y - 715, "Top", obj_sweat_particles);

function initFighter(_playerId, _fighterId, _opponent=noone, _isCPU=false, _idCPU=-1) {
	//show_message(string(_playerId) + " " + string(_fighterId) + " " + string(_opponent) + " " + string(_isCPU) + " " + string(_idCPU));
	
	playerId = _playerId;
	
	opponent = _opponent;
	
	timeRandomness = irandom_range(0, 1000);
	
	image_xscale = (playerId == 1) ? 1 : -1;
	
	fighterId = _fighterId;
	character = new Fighter();
	character.loadFighter(fighterId);
	
	// SET PLAYER'S POSITION
	startX = P2_X + irandom_range(-48, 48);
	//x = startX - (ROUND_END_X * image_xscale);
	//x = (playerId == 1) ? P1_X_OUT : P2_X_OUT;
	
	// SET HP, GUARD & HEALTHBARS VALUES
	// HEALTH
	hp = character.maxHp;
	
	// SET GUARD & HEALTHBAR MAX VALUES
	// GUARD
	guardHp = character.maxGuardHp;
	
	// NEW INPUT
	if (_isCPU) {
		var _vKeyAtk = instance_create_layer(0, 0, "Bot", obj_virtual_key_atk);
		_vKeyAtk.initAttackKeyCPU(id, _idCPU, _opponent);
		var _vKeyDodge = instance_create_layer(0, 0, "Bot", obj_virtual_key_dodge);
		_vKeyDodge.initDodgeKeyCPU(id, _idCPU, _opponent);
		
		var _virtualInputAtk = new VirtualInput(_vKeyAtk, character.inputMaxHoldTime, character.inputCancelTime);
		var _virtualInputDodge = new VirtualInput(_vKeyDodge, character.inputMaxHoldTime, character.inputCancelTime);
		
		attackInput = new InputManager(_virtualInputAtk, -1);
		dodgeInput = new InputManager(_virtualInputDodge, -1);
		
		var _cpuNivelator = instance_create_layer(0, 0, "GUI", obj_cpu_nivelator);
		_cpuNivelator.initCPUNivelator(_idCPU);
		
	} else {
		if (os_type == os_android) {
			// MOBILE CONTROLS
			var _vKeyAtk = instance_create_layer(0, 0, "Overlay", obj_mobile_input);
			_vKeyAtk.initMobileInput(1);
			var _vKeyDodge = instance_create_layer(0, 0, "Overlay", obj_mobile_input);
			_vKeyDodge.initMobileInput(-1);
		
			var _virtualInputAtk = new VirtualInput(_vKeyAtk, character.inputMaxHoldTime, character.inputCancelTime);
			var _virtualInputDodge = new VirtualInput(_vKeyDodge, -1, 0);
		
			attackInput = new InputManager(_virtualInputAtk, -1);
			dodgeInput = new InputManager(_virtualInputDodge, -1);
		} else {
			// PC Controls
			var _keyboardAttackInput = new KeyboardInput(global.ATTACK_KEY[playerId], character.inputMaxHoldTime, character.inputCancelTime, 0);
			var _keyboardDodgeInput = new KeyboardInput(global.DODGE_KEY[playerId], -1, 0, character.inputMaxDodgeTime);

			var _joystickAttackInput = -1;
			var _joystickDodgeInput = -1;

			var _joystickManager = instance_find(obj_joystick_manager, 0);
			var _joystickId = _joystickManager.getJoystickForPlayer(_playerId);
			if (_joystickId != -1) {
				_joystickAttackInput = new JoystickInputBtn(_joystickId, [gp_face3, gp_face4], character.inputMaxHoldTime, character.inputCancelTime, 0);
				_joystickDodgeInput = new JoystickInputBtn(_joystickId, [gp_face1, gp_face2], -1, 0, character.inputMaxDodgeTime);
			}

			attackInput = new InputManager(_keyboardAttackInput, _joystickAttackInput);
			dodgeInput = new InputManager(_keyboardDodgeInput, _joystickDodgeInput);
		}
	}

	// INIT "STRETCHER"
	stretcher.initStretcher(abs(image_xscale), image_yscale, image_xscale);
	
	sprite_index = character.sprite;
}

function doWait(_imageIndex=-1) {
	attackInput.reset();
	dodgeInput.reset();
	status = FighterStatus.waiting;
	if (_imageIndex != -1) {
		image_index = _imageIndex;
	}
	alarm[0] = -1;
	alarm[6] = -1;
}

function doDodge() {
	show_debug_message("Doing dodge");
	dodgeFailed = false;
	if (guardHp < DODGE_COST) {
		audio_play_sound(snd_grunt01, 100, 0);
		shaker.shake(10, 0.5);
		dodgeFailed = true;
	} else {
		guardHp -= DODGE_COST;
		guardHp = max(0, guardHp);
		if (instance_exists(guardHealthbar))
			guardHealthbar.applyDamage(DODGE_COST, DODGE_COST);
	}
	overlayAlpha = 0;
	jabReady = false;
	hookReady = false;
	status = FighterStatus.dodge;
}

// TO BE UNUSED
function addPoints(_points) {
	points[currentRound] += _points;
}

function getJabHurtImage() {
	jabImage = 1 - (1 * jabImage);
	return 6 + jabImage;
}

function checkSweat() {
	if (hp == 0 || guardHp > DODGE_COST) {
		dropParticles.stop();
		return;
	}
	if (dropParticles.emiting) {
		if (!dizzy) {
			shaker.shake(3, 0.5);
		}

		var _images = [3, 6, 7];
		var _dropShiftValue = -100 * image_xscale;
	    dropShift = (array_contains(_images, image_index)) ? _dropShiftValue : 0;

		dropParticles.x = x + dropShift;

		return;
	}
	
	// START SWEAT PARTICLES 
	dropParticles.start();
	shaker.shake(3, 0.5);
}

function checkAttackCharge() {
	if (guardHp >= DODGE_COST && (attackInput.isPressed() || attackInput.isHeld())) {
		status = FighterStatus.charge;
	}
}

function checkAttacksReady() {
	if (attackInput.isPressed()) {
		jabReady = false;
		hookReady = false;
		return;
	}
	if (attackInput.isHeld() || attackInput.isReleased()) {
		if (!hookReady && attackInput.getHoldTime() >= character.inputMinHookTime) {
			hookReady = true;
			overlayColor = c_red;
			overlayAlpha = 1;
		} else if (!jabReady && attackInput.getHoldTime() > 0) {
			jabReady = true;
			//overlayColor = c_white;
			//overlayAlpha = 1;
		}
	}
}

function checkRelease(includeDodge=true) {
	if (includeDodge && dodgeInput.isReleased()) {
		if (dodgeInput.getHoldTime() <= character.inputMaxDodgeTime) {
			show_debug_message("DODGE");
			dodgeInput.reset();
			attackInput.reset();
			doDodge();
			exit;
		}
	}
	if (attackInput.isReleased() && guardHp >= DODGE_COST) {
		with (hitbox) instance_destroy();
		if (attackInput.getHoldTime() >= character.inputMinHookTime) {
			show_debug_message("HOOK");
			alarm[0] = -1;
			status = FighterStatus.startHook;
			// ATTACK COST
			guardHp -= DODGE_COST;
			guardHp = max(0, guardHp);
			if (instance_exists(guardHealthbar))
				guardHealthbar.applyDamage(DODGE_COST, DODGE_COST);
		} else {
			show_debug_message("JAB");
			alarm[0] = -1;
			status = FighterStatus.startJab;
			// ATTACK COST
			guardHp -= DODGE_COST;
			guardHp = max(0, guardHp);
			if (instance_exists(guardHealthbar))
				guardHealthbar.applyDamage(DODGE_COST, DODGE_COST);
		} 
		jabReady = false;
		hookReady = false;
		attackInput.reset();
	}
}

// UNUSED
/*
function checkCancel() {
	if (attackInput.isCancel()) {
		show_debug_message("<GUARD> CANCEL");
		alarm[0] = game_get_speed(gamespeed_fps) * 0.05;
	}
}
*/

function recoverHP() {
	// Recover HP
	if (hp < effectiveHp && alarm[1] == -1)
		alarm[1] = game_get_speed(gamespeed_fps) * character.hpRecoveryTime;
}

// FROM DIZZY STATUS
function checkRecovery() {
	if (dizzy) {
		alarm[0] = -1;
		if (attackInput.isPressed()) {
			guardHp = approach(guardHp, character.maxGuardHp, character.guardManualRecoveryValue);
			//guardHealthbar.updateValue(guardHp, true);
			shaker.shake(10, 0.5);
			
			//show_debug_message("RECOVERING GUARD: " + string(guardHp));
			if (guardHp >= character.maxGuardHp) {
				audio_stop_sound(snd_dizzy);
				with (obj_bird) instance_destroy();
				dizzy = false;
				alarm[0] = 1;
			}
		}
	}
}

function recoverGuard() {
	// Recover Guard HP
	if (guardHp < character.maxGuardHp && alarm[3] == -1)
		alarm[3] = game_get_speed(gamespeed_fps) * character.guardAutoRecoveryTime;
}

function checkDizzy(_damage=0) {
	if (guardHp <= 0) {
		alarm[0] = -1;
		addPoints(-3);
		shaker.shake(30, 3);
		audio_play_sound(snd_dizzy, 50, 1);
		audio_play_sound(snd_guard_break, 100, 0);
		guardHp = 0;
		//guardHealthbar.updateValue(guardHp, true);
		dizzy = true;
		
		// Do pierce damage
		_damage *= PIERCE_DAMAGE_FACTOR;
		var _effectiveDamage = _damage * EFFECTIVE_DAMAGE_FACTOR;

		hp -= _damage;
		effectiveHp -= _effectiveDamage;
		//healthbar.applyDamage(_damage, _effectiveDamage);
		
		var _mirror = (image_xscale == -1);
		var _birdX = 156 * image_xscale;
		var _bird = instance_create_layer(x + _birdX, y - 680, "Top", obj_bird);
		_bird.fly(0, _mirror);
		_bird = instance_create_layer(x + _birdX, y - 680, "Top", obj_bird);
		_bird.fly(0.33, _mirror);
		_bird = instance_create_layer(x + _birdX, y - 680, "Top", obj_bird);
		_bird.fly(0.66, _mirror);
		status = FighterStatus.dizzy;
	}
}

function waveWalk() {
	y = sine_between((current_time + timeRandomness) / 1000, 0.5, PLAYER_Y, PLAYER_Y + 40);
}

function waveStance() {
	//y = sine_between((current_time + timeRandomness) / 1000, 0.75, PLAYER_Y, PLAYER_Y + 30);
	y = sine_between((current_time + timeRandomness) / 1000, 0.5, PLAYER_Y, PLAYER_Y + 40);
}

function bounceStance() {
	/*
	var _t = (current_time + timeRandomness) / 1000;
	var _decimals = _t mod 1;
	//show_message(_decimals);
	var _offsetX = lerp(0, 40, _decimals);
	x = startX + _offsetX;
	*/
	//x = sine_between((current_time + timeRandomness) / 1000, 1.5, startX, startX + 40 * image_xscale);
	x = sine_between((current_time + timeRandomness) / 1000, 1, startX, startX + 30 * image_xscale);
}

// IF THERE WON'T BE MORE THAN 1 ROUND, ERASE THIS
function rest() {
	// TODO: Recover a bit of HP & Guard HP between rounds
	resting = true;
	targetEffHp = min(character.maxHp, effectiveHp + character.maxHp * character.restHpRecoveryFactor);
	// Divided by 20 because "resting" alarm will be called 20 times
	effHpInc = (targetEffHp - effectiveHp) / 20;
	targetHp = targetEffHp;
	hpInc = (targetHp - hp) / 20;
	targetGuard = min(character.maxGuardHp, guardHp + character.maxGuardHp * character.restGuardRecoveryFactor);
	guardInc = (targetGuard - guardHp) / 20;
	// resting alarm will be called 20 times, each every half a second
	alarm[5] = game_get_speed(gamespeed_fps) * 0.5;
}

function doFreeze(_time=1) {
	// Back to idle in time
	alarm[0] = _time;

	alarm[1] = -1;
	alarm[2] = -1;
	alarm[3] = -1;
	alarm[4] = -1;
	alarm[5] = -1;
	alarm[6] = -1;
	
	status = FighterStatus.freeze;
}

function checkParry() {
	if (!global.PARRY_ENABLED ||
		dizzy || // prevent parrying while dizzy
		array_contains(global.PARRY_INVALID_STATUS, status)
	) return false;
	
	// CHECK PARRY 100ms
	if (dodgeInput.isHeld() && dodgeInput.getHoldTime() <= PARRY_MAX_TIME) {
		attackInput.reset();
		
		// DO NOT RESET DODGE INPUT, TO ALLOW GUARD
		//dodgeInput.reset();
		
		audio_play_sound(snd_parry, 100, 0);		
		
		// guard image
		image_index = 1;
		with (obj_fighter) {
			// SHAKE EM!
			shaker.shake(20, 0.5);
			doFreeze(game_get_speed(gamespeed_fps));
		}
		// Counter
		alarm[7] = game_get_speed(gamespeed_fps) * 0.5;
		return true;
	}

	return false;
}

function setSequence(_sequenceName, _endStatus=FighterStatus.idle, _opponentWait=false) {
	status = FighterStatus.playSequence;
	sequenceName = _sequenceName;
	sequenceStatusEnd = _endStatus;
	sequenceOpponentWait = _opponentWait;
}

function receiveDamage(_damage, _effectiveDamage, _minimumHealth=0) {
	hp -= _damage;
	hp = max(hp, _minimumHealth);
	effectiveHp -= _effectiveDamage;
	effectiveHp = max(effectiveHp, _minimumHealth);
	//healthbar.applyDamage(_damage, _effectiveDamage);
}
