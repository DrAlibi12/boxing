/// @description FIGHT PLAY SCENE

if (objFightSetup.SCENE_PRE_FIGHT == -1) exit;

var _scene = instance_create_layer(0, 0, "Overlay", obj_dialogue_scene);
_scene.owner = id;
_scene.callback = function(_owner) {
	// Shows next round message & starts fight
	var _nextRoundMsg = instance_create_layer(x, y, "GUI", obj_next_round);
	_nextRoundMsg.owner = _owner;
}
_scene.playScene(objFightSetup.SCENE_PRE_FIGHT);
