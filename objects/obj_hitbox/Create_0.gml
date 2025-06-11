/// @description Insert description here
// You can write your code in this editor

owner = noone;
life = -1;
damage = 0;
effectiveDamageFactor = EFFECTIVE_DAMAGE_FACTOR;
stun = 0;
points = 0;

heavy = false;
unstoppable = false;

function impacted() {
	instance_destroy();
	owner.addPoints(points);
}
