function CPUBehaviorConfig(_action, _repeatEverySeconds, _maxRepetitions=-1) constructor {
	action = _action;
	everySeconds = _repeatEverySeconds;
	maxRepetitions = _maxRepetitions;
	
	function setBehavior(_cpuFighter) {
		switch (action) {
			case DummyCPUActions.jab:
				//show_message(_cpuFighter);
				//show_message(_cpuFighter.attackInput);
				//_cpuFighter.attackInput.keyboard.doJabsEvery(everySeconds);
				with (obj_virtual_key_atk_dummy) doJabsEvery(other.everySeconds, other.maxRepetitions);
			break;
			case DummyCPUActions.hook:
				//_cpuFighter.attackInput.keyboard.doHooksEvery(everySeconds);
				with (obj_virtual_key_atk_dummy) doHooksEvery(other.everySeconds, other.maxRepetitions);
			break;
			case DummyCPUActions.guard:
				//_cpuFighter.dodgeInput.doGuard(other.everySeconds);
			break;
		}
	}
}
