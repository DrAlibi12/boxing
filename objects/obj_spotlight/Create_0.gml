/// @description Insert description here
// You can write your code in this editor

event_inherited();

objMatchManager = instance_find(obj_match_manager, 0);

endCallback = function() {
	var _xScale = 0;
	with (objMatchManager) {
		if (winner == 1) {
			p1.image_index = 4;
			p1.depth = 100;
			_xScale = 1;
		} else if (winner == 2) {
			p2.image_index = 4;
			p2.depth = 100;
			_xScale = -1;
		}
	}
	
	showSpotlight(_xScale, c_orange);
}

image_alpha = 0;
targetAlpha = 1;

image_speed = 0;

// Determines wether to draw full overlay or overlay with gap
image_index = 0;

// Determines which player won with the horizontal orientation of the spotlight
//  1 = P1
// -1 = P2
image_xscale = 1;

// Spotlight color
image_blend = c_white;

function showSpotlight(_xScale, _color) {
	image_alpha = 1;
	visible = true;
	image_index = 1;
	image_xscale = _xScale;
	image_blend = _color;
}