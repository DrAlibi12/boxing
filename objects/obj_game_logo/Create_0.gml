/// @description Insert description here
// You can write your code in this editor

curSequence = noone;

function doExit() {
	curSequence = layer_sequence_create(layer, x, y, sq_game_logo_out);
	var sq_elem = layer_sequence_get_instance(curSequence);
	sequence_instance_override_object(sq_elem, obj_game_logo, id);
}