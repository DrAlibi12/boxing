/// @description Back to idle

invulnerable = false;

dodgeEnabled = true;

var _prevStatus = status;

status = FighterStatus.idle;
image_index = 0;
stun = 0;

if (dizzy)
	status = FighterStatus.dizzy;

if (winner)
	status = FighterStatus.win;

if (_prevStatus == FighterStatus.dodge && !dodgeFailed) {
	dodgeFailed = true;
	status = FighterStatus.dodge;
}