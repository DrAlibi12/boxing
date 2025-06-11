/// @description Move the background

/*
// MANUAL TEST
var _hDir = keyboard_check(vk_right) - keyboard_check(vk_left);

if (_hDir != 0) {
	crowdMove(_hDir, other.hSpeed);
}
*/

if (bkgHDir == 0) exit;

var _hDir = bkgHDir;

if (bkgType == BackgroundType.Background360) {
	background360Move("Scenario360", BKG_360_SPD_FACTOR);
	background360Move("Scenario360Fore", BKG_360_SPD_FACTOR);
} else {
	// Background scenario will stop the crowd if it reaches an end
	// (only if background is not endless)
	_hDir = backgroundMove("Scenario");
	backgroundMove("ScenarioFore");
}

// Move crowd
if (instance_exists(crowd)) crowd.moveCrowd(_hDir, bkgHSpeed);

bkgHDir = approach(bkgHDir, 0, BKG_HDIR_DECR);

