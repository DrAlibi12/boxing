/// @description Just release, then press again to attack

locked = false;

released = true;

var _moveAgainAfterTime = random_range(speedMin, speedMax);

alarm[0] = max(1, game_get_speed(gamespeed_fps) * _moveAgainAfterTime);

