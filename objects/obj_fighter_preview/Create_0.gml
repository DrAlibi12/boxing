/// @description Insert description here
// You can write your code in this editor

image_index = 0;
image_speed = 0;

fighterId = 0;

timeRandomness = irandom_range(0, 1000);

function setSelected(_fighterId) {
	fighterId = _fighterId;
	image_index = fighterId;
}
