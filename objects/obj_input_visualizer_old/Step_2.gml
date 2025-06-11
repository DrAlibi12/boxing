/// @description Insert description here
// You can write your code in this editor

if (input == -1) exit;
if (input.hold_time <= 0) exit;
if (cancelled && lastTime == input.hold_time) exit;

if (input.is_cancel) {
	cancelled = true;
	color = c_gray;
	exit;
}

cancelled = false;
percentage = input.hold_time * 100 / input.max_hold_time;
if (input.hold_time <= MAX_DODGE_TIME) {
	color = c_yellow;
	if (!fighter.dodgeEnabled) color = c_gray;
} else if (input.hold_time < MIN_HOOK_TIME) {
	color = c_orange;
} else {
	color = c_red;
}

if (input.hold_time != 0) {	
	lastTime = input.hold_time;
}

