/// @description Insert description here
// You can write your code in this editor

path = noone;
mirror = false;

function fly(_startingPoint=0, _mirror=false) {
	path = path_duplicate(pth_bird);
	mirror = _mirror;
	if (mirror) {
		path_mirror(path);
	}
	path_start(path, 15, path_action_continue, false);
	path_position = _startingPoint;
}