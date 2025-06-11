/// @description Insert description here
// You can write your code in this editor

lineId = 0;

xMin = 0;
xMax = 0;
yMin = 0;
yMax = 0;

hDir = 0;
hSpeed = 2;

curY = y;

yShake = 0;

spriteNumber = irandom_range(1, 5);
spriteName = "spr_crowd" + string(spriteNumber);

sprite_index = asset_get_index(spriteName);
image_index = irandom(sprite_get_number(sprite_index) - 1);

timeRandomness = irandom(1000);

function fanMove(_hDir, _hSpd=2) {
	hDir = _hDir;
	
	// farther fans rotate slowly
	_hSpd = _hSpd * 1 - (0.15 * lineId);
	
	hSpeed = _hSpd;
}

// shaker = global.crowdShaker;
