// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ConfirmationOverlay(_owner, _titleText, _confirmText, _cancelText, _callback) {
	var _overlay = instance_create_layer(0, 0, "GUI", obj_overlay_confirmation);
	_overlay.owner = _owner;
	_overlay.titleText = _titleText;
	_overlay.confirmText = _confirmText;
	_overlay.cancelText = _cancelText;
	
	_overlay.callback = _callback;
	
	return _overlay;
}
