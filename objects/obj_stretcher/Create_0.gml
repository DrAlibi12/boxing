/// @description Insert description here
// You can write your code in this editor

hDir = 1;
hStart = 1;
vStart = 1;

hScale = 1;
vScale = 1;

decrement = 0;
stopped = true;

function initStretcher(_hScale, _vScale, _hDir=1) {
	hDir = _hDir;
	hStart = _hScale;
	vStart = _vScale;
}

function stretch(_hScale, _decrement) {
	stopped = false;
	hScale = _hScale;
	vScale = vStart - (hScale - hStart);
	decrement = _decrement;
}
