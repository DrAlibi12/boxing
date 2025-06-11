// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function spawnHazard(_x, _y, _xscale, _yscale, _damage, _duration, _effect=noone, _endAction=HazardEnd.resumeFight, _shakeAmount=0, _shakeDec=0) {
	show_debug_message("SPAWN HAZARD");
	var _hazard = instance_create_layer(_x, _y, "GUI", obj_hazard);
	_hazard.image_xscale = _xscale;
	_hazard.image_yscale = _yscale;
	
	_hazard.damage = _damage;
	_hazard.duration = _duration;
		
	_hazard.hazardEffect = _effect;

	_hazard.endAction = _endAction;

	_hazard.shakeAmount = _shakeAmount;
	_hazard.shakeDec = _shakeDec;
}