/// @description Auto Recover Guard HP

if (dizzy || status == FighterStatus.knockdown) exit;

guardHp = approach(guardHp, character.maxGuardHp, character.guardAutoRecoveryValue);
if (instance_exists(guardHealthbar))
	guardHealthbar.updateValue(guardHp);

//if (guardHp >= character.maxGuardHp div 2 && (hp < MAX_HP && alarm[1] == -1))
//	alarm[1] = game_get_speed(gamespeed_fps) * character.hpRecoveryTime;
