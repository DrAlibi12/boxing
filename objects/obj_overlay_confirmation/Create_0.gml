/// @description Insert description here
// You can write your code in this editor

var _xPort = camera_get_view_x(view_camera[view_current]);
var _yPort = camera_get_view_y(view_camera[view_current]);
var _wPort = view_get_wport(view_current);
var _hPort = view_get_hport(view_current);

x = _xPort + _wPort / 2;
y = _yPort + _hPort / 2;

owner = noone;

var _menuInput1 = createLocalMenuInputManager(
	1, global.PLAYER_KEYBOARD[1]
);
var _menuInput2 = createLocalMenuInputManager(
	2, global.PLAYER_KEYBOARD[2]
);
menuInputs = [_menuInput1, _menuInput2];

color = c_black;
titleText = "Are you sure?";
confirmText = "Yes";
cancelText = "No";

callback = function (_confirmed) { show_debug_message("Confirmed: " + string(_confirmed)); };

optionId = 0;
maxOptionId = 1;

scale = 1;
navigationEnabled = true;
navigationCooldown = 0.15;

shaker = instance_create_layer(x, y, "GUI", obj_shaker);
shaker.init(x, y);
shaker.shake(2, 0);

function drawOption(_optionId) {
	var _text = confirmText
	if (_optionId != 0) {
		_text = cancelText;
	}
	
	var _scale = (_optionId == optionId) ? 1 : 0.75;
	var _alpha = 0.8;
	var _color = c_white;
	
	var _x = x;
	var _y = y + 70 * _optionId;
	
	if (_optionId == optionId) {
		_x += shaker.xDraw;
		_y += shaker.yDraw;
	}

	draw_text_transformed(
		_x, _y,
		_text,
		_scale, _scale, 0
	);
}

function optionConfirm() {
	callback(true);
	instance_destroy();
}

function optionCancel() {
	callback(false);
	instance_destroy();
}
