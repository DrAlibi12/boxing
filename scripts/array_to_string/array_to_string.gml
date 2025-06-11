// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function array_to_string(_array, _separator="") {
	var _arrayString = "";
	
	for (var _i=0; _i < array_length(_array); _i++) {
		_arrayString += is_string(_array[_i]) ? _array[_i] : string(_array[_i]);
		if (_i < array_length(_array) - 1) {
			_arrayString += _separator;
		}
	}

	return _arrayString;
}