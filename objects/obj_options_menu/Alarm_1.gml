/// @description Start room transition

exiting = true;
exitStartAt = current_time;

with (obj_game_logo) doExit();

// Black fade out
var _fadeOut = instance_create_layer(0, 0, "Overlay", obj_fade_out);
_fadeOut.initFadeOut(c_black, 0.8);
