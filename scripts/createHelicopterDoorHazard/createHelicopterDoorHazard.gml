// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function createHelicopterDoorHazard(_leftSide, _rightSide) {
	if (_leftSide) {
		var _hazard = instance_create_layer(126, 1095, "Back", obj_hazard_heli_door);
		_hazard.xDraw = 126;
		
		_hazard.image_xscale = 1;
		_hazard.image_yscale = 1;
	
		_hazard.damage = 3;
		_hazard.duration = 0.05;
		
		_hazard.hazardEffect = noone;

		_hazard.endAction = HazardEnd.resumeFight;

		_hazard.shakeAmount = 10;
		_hazard.shakeDec = 0.5;
	}
	
	if (_rightSide) {
		var _hazard = instance_create_layer(room_width - 126, 1095, "Back", obj_hazard_heli_door);
		_hazard.xDraw = sprite_get_width(bkg_helicopter) - 126;

		_hazard.image_xscale = -1;
		_hazard.image_yscale = 1;
	
		_hazard.damage = 3;
		_hazard.duration = 0.05;
		
		_hazard.hazardEffect = noone;

		_hazard.endAction = HazardEnd.resumeFight;

		_hazard.shakeAmount = 10;
		_hazard.shakeDec = 0.5;
	}
}

