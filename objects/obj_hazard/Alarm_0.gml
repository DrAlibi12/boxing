/// @description Insert description here
// You can write your code in this editor

show_debug_message("ALARM SHOT");

if (instance_exists(targetFighter)) {
	show_debug_message("RUNNING END ACTION");
	runEndAction();
} else {
	show_debug_message("FIGHTER NOT FOUND: " + string(targetFighter));
}

// Destroy shockwave
with (obj_hazard_effect) instance_destroy();

show_debug_message("HAZARD EFFECT DESTROYED");

active = false;