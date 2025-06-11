/// @description Insert description here
// You can write your code in this editor

// "Danger" more like Recover... This variable
// is used to draw the grayed out half stamina bar 
// required to fill to recover from a stun
danger = false;

sections = 1;

blinkActive = false;
blinkValue = 0;
blinkColor = c_red;
blinkEveryS = 0.1;

barName = "";

maxValue = 0;
effectiveValue = 0;
value = 0;
hDir = 1;

barWidth = sprite_get_width(spr_healthbar);
barHeight = sprite_get_height(spr_healthbar);

curWidth = 0;
curEffectiveWidth = 0;

shaker = instance_create_layer(x, y, "GUI", obj_shaker);
shaker.init(x, y);

function init(_maxValue, _hDir=1, _blinkValue=0, _initialValue=-1) {
	maxValue = _maxValue;
	effectiveValue = (_initialValue == -1) ? _maxValue : _initialValue;
	value = (_initialValue == -1) ? _maxValue : _initialValue;
	hDir = _hDir;
	blinkValue = _blinkValue;
}

function updateValue(_value, _danger=false, _effectiveValue=-1) {
	// show_debug_message("HEALTH UPDATED");
	value = _value;
	danger = _danger;
	if (_effectiveValue != -1) {
		effectiveValue = _effectiveValue;
	} else {
		effectiveValue = _value;
	}
}

function applyDamage(_damage, _effectiveDamage, _shakeEnabled=true) {
	value = clamp(value - _damage, 0, maxValue);
	effectiveValue = clamp(effectiveValue - _effectiveDamage, 0, maxValue);
	// show_debug_message("DAMAGE APPLIED");
	if (_shakeEnabled)
		shaker.shake(20, 1);
}

