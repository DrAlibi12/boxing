// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function InputHelperConfig(_attackHold, _attackEvery, _guardHold, _guardEvery) constructor {
	attackHold = _attackHold;
	attackEvery = _attackEvery;
	guardHold = _guardHold;
	guardEvery = _guardEvery;
	
	function applyConfig() {
		var _attackActive = attackHold > 0;
		var _guardActive = guardHold > 0;
		var _attackHold = attackHold;
		var _attackEvery = attackEvery;
		var _guardHold = guardHold;
		var _guardEvery = guardEvery;
		
		with (obj_tutorial_ui_input) {
			setAttackActive(_attackActive, _attackHold, _attackEvery);
			setGuardActive(_guardActive, _guardHold, _guardEvery);
		}
	}
}