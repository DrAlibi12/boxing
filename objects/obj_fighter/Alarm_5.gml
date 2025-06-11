/// @description REST

show_debug_message("RESTING");
hp = approach(hp, targetHp, hpInc);
effectiveHp = approach(effectiveHp, targetEffHp, effHpInc);
guardHp = approach(guardHp, targetGuard, guardInc);
healthbar.updateValue(hp, false, effectiveHp);
guardHealthbar.updateValue(guardHp);

if (hp == targetHp && effectiveHp == targetEffHp && guardHp == targetGuard) {
	resting = false;
} else {
	alarm[5] = game_get_speed(gamespeed_fps) * 0.2;
}
