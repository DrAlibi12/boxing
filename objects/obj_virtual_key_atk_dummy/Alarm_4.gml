/// @description Just press once, then press again to attack

locked = false;

pressed = true;

var _moveAgainAfterTime = random_range(speedMin, speedMax);

alarm[0] = max(1, game_get_speed(gamespeed_fps) * _moveAgainAfterTime);

