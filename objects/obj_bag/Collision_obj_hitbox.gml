/// @description Shake

// Shake
shaker.shake(20, 1);

var _sound = getRandomAudio("snd_guard", 4);
if (_sound != -1) audio_play_sound(_sound, 100, 0);

// Destroy hitbox to avoid further damage
other.impacted();

swing = min(swing + other.damage, swingMax);

if ((current_time - swingStartAt) / 1000 > 1.1)
	swingStartAt = current_time;
