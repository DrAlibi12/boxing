/// @description Destroy this door and spawn a sky_fall hazard

var _leftSide = (x < room_width div 2) ? true : false;

createSkyFallHazard(_leftSide, !_leftSide);

