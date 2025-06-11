/// @description Throw attack

if (status == FighterStatus.startJab) {
	status = FighterStatus.jab;
} else if (status == FighterStatus.startHook) {
	status = FighterStatus.hook;
}

stretcher.stretch(1.2, 0.03);
