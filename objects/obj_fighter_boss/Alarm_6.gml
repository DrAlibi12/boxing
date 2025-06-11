/// @description Insert description here
// You can write your code in this editor

if (status == FighterStatus.bossPrepareSpecial) {
	status = FighterStatus.bossSpecial;
	return;
}

event_inherited();
