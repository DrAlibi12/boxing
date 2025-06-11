/// @description Recover HP

if (status == FighterStatus.knockdown) exit;

hp = approach(hp, effectiveHp, character.hpRecovery);
healthbar.updateValue(hp, false, effectiveHp);

//if (hp < effectiveHp)
//	alarm[1] = game_get_speed(gamespeed_fps) * character.hpRecoveryTime;
