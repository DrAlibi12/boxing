/// @description Insert description here
// You can write your code in this editor

var _zeros = "";
var _value = 0;
var _qtyData = 10;

var _dataStr = "";
var _gameState = "";

for (var _i=0; _i < _qtyData; _i++) {
	_value = irandom(9999);
	show_debug_message(_value);
	
	_zeros = "";
	_zeros = (_value < 1000) ? "0" : _zeros;
	_zeros = (_value < 100) ? "00" : _zeros;
	_zeros = (_value < 10) ? "000" : _zeros;
	
	_dataStr = _zeros + string(_value);
	
	_gameState += _dataStr;
}

savedContent = global.GAME_STATE.save(_gameState);
