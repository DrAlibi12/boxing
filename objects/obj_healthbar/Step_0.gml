/// @description update healthbar width

if (maxValue == 0) exit;

curWidth = value * barWidth / maxValue;
if (!danger && sections > 1) {
	var _sectionValue = maxValue / sections;
	curWidth = (value - value mod _sectionValue) * barWidth / maxValue;
}

curEffectiveWidth = effectiveValue * barWidth / maxValue;

if (value <= blinkValue || danger) {
	// shaker.shake(20, 1);
	if (alarm[0] == -1)
		alarm[0] = game_get_speed(gamespeed_fps) * blinkEveryS;
} else {
	blinkActive = false;
}

image_blend = c_white;
if (blinkActive) image_blend = blinkColor;
