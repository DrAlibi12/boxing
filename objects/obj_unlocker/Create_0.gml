/// @description Init unlocker

// THIS OBJECT DOES NOT DISPLAY ANYTHING (YET)

function unlockFighter(_fighterId) {
	// Avoid "unlocking" if the thing is already unlocked
	if (global.GAME_STATE.unlockedFighters[_fighterId]) return;

	show_debug_message("Unlocked fighter: " + string(_fighterId));
	global.GAME_STATE.unlockedFighters[_fighterId] = true;
	global.GAME_STATE.save();
	alarm[0] = game_get_speed(gamespeed_fps) * 5;
}

function unlockScenario(_scenarioId) {
	// Avoid "unlocking" if the thing is already unlocked
	if (global.GAME_STATE.unlockedScenarios[_scenarioId]) return;
	
	show_debug_message("Unlocked scenario: " + string(_scenarioId));
	global.GAME_STATE.unlockedScenarios[_scenarioId] = true;
	global.GAME_STATE.save();
	alarm[0] = game_get_speed(gamespeed_fps) * 5;
}

// If in 10 seconds is not destroyed, destroy
alarm[0] = game_get_speed(gamespeed_fps) * 10;
