// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Fighter() constructor {
	// FIGHTER DETAILS
	fighterId = Roster.Juan;
	name = "Juan Punch";
	sprite = spr_fighter_new;
	
	// INPUT SPEEDS
	inputMaxHoldTime = MAX_HOLD_TIME;
	inputMaxDodgeTime = MAX_DODGE_TIME;
	inputMinHookTime = MIN_HOOK_TIME
	inputCancelTime = MAX_CANCEL_TIME
	
	// HEALTH
	maxHp = MAX_HP;
	hpRecovery = HP_RECOVERY;
	hpRecoveryTime = HP_RECOVER_EVERY;

	// STAMINA / GUARD
	guardHpSections = GUARD_SECTIONS;
	maxGuardHp = GUARD_SECTIONS * GUARD_SECTION_VALUE; // MAX_GUARD_HP;
	guardAutoRecoveryTime = GUARD_AUTO_RECOVER_EVERY;
	guardAutoRecoveryValue = GUARD_HP_RECOVERY_AUTO;
	guardManualRecoveryValue = GUARD_HP_RECOVERY_MANUAL;
	
	// SPEED
	dodgeDuration = DODGE_DURATION;
	dodgeRecoverDuration = DODGE_RECOVER_DURATION;
	guardDuration = GUARD_DURATION;
	jabDuration = JAB_DURATION;
	hookDuration = HOOK_DURATION;
	jabStartTime = JAB_START_TIME;
	hookStartTime = HOOK_START_TIME;

	// DAMAGES
	jabDamage = JAB_DAMAGE;
	hookDamage = HOOK_DAMAGE;	
	effDamageFactor = EFFECTIVE_DAMAGE_FACTOR;
	// STUN TIME (UNUSED)
	jabStun = JAB_STUN;
	hookStun = HOOK_STUN;
	
	// RESTING CAPABILITIES (BETWEEN ROUNDS)
	restHpRecoveryFactor = 0.2;
	restGuardRecoveryFactor = 0.3;
	
	function loadFighter(_fighterId=Roster.Juan) {
		fighterId = _fighterId;
		
		var _fileName = string(fighterId);
		while (string_length(_fileName) < 3) {
			_fileName = "0" + _fileName;
		}
		
		var _file = file_text_open_read(working_directory + "char/" + string(_fileName));
		
		var _name = file_text_read_string(_file);
		file_text_readln(_file);
		var _spriteName = file_text_read_string(_file);
		var _sprite = asset_get_index(_spriteName);
		file_text_readln(_file);

		var _inputMaxHoldTime = file_text_read_real(_file);
		file_text_readln(_file);
		var _inputMaxDodgeTime = file_text_read_real(_file);
		file_text_readln(_file);
		var _inputMinHookTime = file_text_read_real(_file);
		file_text_readln(_file);
		var _inputCancelTime = file_text_read_real(_file);
		file_text_readln(_file);
		
		var _maxHp = file_text_read_real(_file);
		file_text_readln(_file);
		var _hpRecovery = file_text_read_real(_file);
		file_text_readln(_file);
		var _hpRecoveryTime = file_text_read_real(_file);
		file_text_readln(_file);
		
		var _guardHpSections = file_text_read_real(_file);
		file_text_readln(_file);
		var _guardAutoRecoveryTime = file_text_read_real(_file);
		file_text_readln(_file);
		var _guardAutoRecoveryValue = file_text_read_real(_file);
		file_text_readln(_file);		
		var _guardManualRecoveryValue = file_text_read_real(_file);
		file_text_readln(_file);

		var _dodgeDuration = file_text_read_real(_file);
		file_text_readln(_file);
		var _dodgeRecoverDuration = file_text_read_real(_file);
		file_text_readln(_file);
		var _guardDuration = file_text_read_real(_file);
		file_text_readln(_file);
		var _jabDuration = file_text_read_real(_file);
		file_text_readln(_file);
		var _hookDuration = file_text_read_real(_file);
		file_text_readln(_file);	
		var _jabStartTime = file_text_read_real(_file);
		file_text_readln(_file);	
		var _hookStartTime = file_text_read_real(_file);
		file_text_readln(_file);	
		var _jabDamage = file_text_read_real(_file);
		file_text_readln(_file);	
		var _hookDamage = file_text_read_real(_file);
		file_text_readln(_file);	
		var _effDamageFactor = file_text_read_real(_file);
		file_text_readln(_file);	
		var _jabStun = file_text_read_real(_file);
		file_text_readln(_file);	
		var _hookStun = file_text_read_real(_file);
		file_text_readln(_file);
		var _restHpRecoveryFactor = file_text_read_real(_file);
		file_text_readln(_file);	
		var _restGuardRecoveryFactor = file_text_read_real(_file);
		file_text_readln(_file);
	
		file_text_close(_file);
		
		// FIGHTER DETAILS
		name = _name;
		// Default sprite
		sprite = spr_fighter_new;
		if (_sprite != -1)
			sprite = _sprite;
		
		// INPUT SPEEDS
		inputMaxHoldTime = _inputMaxHoldTime;
		inputMaxDodgeTime = _inputMaxDodgeTime;
		inputMinHookTime = _inputMinHookTime;
		inputCancelTime = _inputCancelTime;
		
		// HEALTH
		maxHp = _maxHp;
		hpRecovery = _hpRecovery;
		hpRecoveryTime = _hpRecoveryTime;

		// STAMINA / GUARD
		guardHpSections = _guardHpSections;
		maxGuardHp = guardHpSections * GUARD_SECTION_VALUE;
		guardAutoRecoveryTime = _guardAutoRecoveryTime;
		guardAutoRecoveryValue = _guardAutoRecoveryValue;
		guardManualRecoveryValue = _guardManualRecoveryValue;
	
		// SPEED
		dodgeDuration = _dodgeDuration;
		dodgeRecoverDuration = _dodgeRecoverDuration;
		guardDuration = _guardDuration;
		jabDuration = _jabDuration;
		hookDuration = _hookDuration;
		jabStartTime = _jabStartTime;
		hookStartTime = _hookStartTime;

		// DAMAGES
		jabDamage = _jabDamage;
		hookDamage = _hookDamage;
		effDamageFactor = _effDamageFactor;
		// STUN TIME (UNUSED)
		jabStun = _jabStun;
		hookStun = _hookStun;
	
		// RESTING CAPABILITIES (BETWEEN ROUNDS)
		restHpRecoveryFactor = _restHpRecoveryFactor;
		restGuardRecoveryFactor = _restGuardRecoveryFactor;
	}

}
