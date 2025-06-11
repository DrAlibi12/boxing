// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createSkyFallHazard(_leftSide, _rightSide) {
	if (_leftSide)
		spawnHazard(HAZARD_X1, HAZARD_Y, HAZARD_XSCALE, HAZARD_YSCALE, 0, 2, obj_heff_sky_fall, HazardEnd.instaKill);
	
	if (_rightSide)
		spawnHazard(HAZARD_X2, HAZARD_Y, HAZARD_XSCALE, HAZARD_YSCALE, 0, 2, obj_heff_sky_fall, HazardEnd.instaKill);
}