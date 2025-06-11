/// @description Fade Out

var _objFadeOut = instance_create_layer(0, 0, "Overlay", obj_fade_out);
_objFadeOut.initFadeOut(c_black, 2);

alarm[1] = game_get_speed(gamespeed_fps) * 4;