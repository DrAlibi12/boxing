/// @description Insert description here
// You can write your code in this editor

//part_emitter_region(partSys, partEmitter, x - 96, x + 96, y, y + 250, ps_shape_rectangle, ps_distr_gaussian);
//part_emitter_region(partSys, partEmitter, x - 128, x + 128, y, y + 400, ps_shape_rectangle, ps_distr_linear);


//part_emitter_region(partSys, partEmitterLeft, x - xDistance, x - xDistance, y, y + 250, ps_shape_line, ps_distr_gaussian);
//part_emitter_region(partSys, partEmitterRight, x + xDistance, x + xDistance, y, y + 250, ps_shape_line, ps_distr_gaussian);
part_emitter_region(partSys, partEmitterLeft, x - xDistance, x - xDistance div 2, y, y + 300, ps_shape_rectangle, ps_distr_linear);
part_emitter_region(partSys, partEmitterRight, x + xDistance div 2, x + xDistance, y, y + 300, ps_shape_rectangle, ps_distr_linear);

if (!emiting) exit;

if (alarm[0] == -1)
	alarm[0] = game_get_speed(gamespeed_fps) * sweatEveryS;
