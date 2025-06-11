// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createElectricHazard(_leftSide, _rightSide) {
	if (_leftSide)
		spawnHazard(HAZARD_X1, HAZARD_Y, HAZARD_XSCALE, HAZARD_YSCALE, 5, 0.75, obj_heff_electric_shock, HazardEnd.resumeFight, 30, 0);
	
	if (_rightSide)
		spawnHazard(HAZARD_X2, HAZARD_Y, HAZARD_XSCALE, HAZARD_YSCALE, 5, 0.75, obj_heff_electric_shock, HazardEnd.resumeFight, 30, 0);
}