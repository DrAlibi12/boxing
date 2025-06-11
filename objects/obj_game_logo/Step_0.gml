/// @description Insert description here
// You can write your code in this editor

if (curSequence != noone) {
	if (layer_sequence_is_finished(curSequence)) {
		layer_sequence_destroy(curSequence);
		curSequence = noone;
		instance_destroy();
	}
}