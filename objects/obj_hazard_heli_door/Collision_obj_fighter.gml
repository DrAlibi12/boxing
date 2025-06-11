/// @description Insert description here
// You can write your code in this editor

if (active || alarm[0] != -1) exit;

// PLAYER WILL ONLY BE AFECTED BY A HAZARD IF IT'S ON HAZARD STATUS
if (other.status != FighterStatus.hazard) exit;

// Damage door
doorHealth -= 1;

// Play door sound
var _sound = (doorHealth > 0) ? snd_heli_door_damage : snd_heli_door_destroyed;
audio_play_sound(_sound, 100, 0);

// Shake that door!
shaker.shake(15, 0.75);

// Inherit the parent event
event_inherited();
