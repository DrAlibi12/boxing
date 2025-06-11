/// @description Insert description here
// You can write your code in this editor

emiting = false;
sweatEveryS = 0.075;

xDistance = 128;

partSys = part_system_create();
part_system_depth(partSys, 0);
// part_system_depth(partSys, 300);

dropMiddle = part_type_create();
part_type_sprite(dropMiddle, spr_sweat_drop, false, false, true);
//part_type_scale(dropMiddle, -1, 1);
part_type_scale(dropMiddle, 1, 1);
part_type_size(dropMiddle, 0.4, 1, 0, 0);
part_type_life(dropMiddle, game_get_speed(gamespeed_fps) * 2, game_get_speed(gamespeed_fps) * 2);
part_type_alpha3(dropMiddle, 0.25, 1, 0);
part_type_direction(dropMiddle, 220, 320, 0, 0);
part_type_orientation(dropMiddle, 0, 360, 0, 0, true);
part_type_gravity(dropMiddle, 0.1, 270);
part_type_speed(dropMiddle, 8, 16, 0, 0);

dropLeft = part_type_create();
part_type_sprite(dropLeft, spr_sweat_drop, false, false, true);
//part_type_scale(dropLeft, -1, 1);
part_type_scale(dropLeft, 1, 1);
part_type_size(dropLeft, 0.25, 1, 0, 0);
part_type_life(dropLeft, game_get_speed(gamespeed_fps) div 2, game_get_speed(gamespeed_fps) div 2);
part_type_alpha3(dropLeft, 1, 1, 0);
part_type_direction(dropLeft, 140, 200, 2, 0);
//part_type_direction(dropLeft, 220, 270, 1.3, 0);
part_type_orientation(dropLeft, 0, 0, 0, 0, true);
part_type_speed(dropLeft, 8, 16, 0, 0);

dropRight = part_type_create();
part_type_sprite(dropRight, spr_sweat_drop, false, false, true);
part_type_scale(dropRight, 1, 1);
part_type_size(dropRight, 0.25, 1, 0, 0);
part_type_life(dropRight, game_get_speed(gamespeed_fps) div 2, game_get_speed(gamespeed_fps) div 2);
part_type_alpha3(dropRight, 1, 1, 0);
//part_type_direction(dropRight, 65, 40, -1.3, 0);
//part_type_direction(dropRight, 270, 320, -1.3, 0);
part_type_direction(dropRight, -20, 40, -2, 0);
part_type_orientation(dropRight, 0, 0, 0, 0, true);
part_type_speed(dropRight, 8, 16, 0, 0);

/*
partEmitter = part_emitter_create(partSys);
part_emitter_region(partSys, partEmitter, x - 128, x + 128, y, y + 400, ps_shape_rectangle, ps_distr_linear);
*/

partEmitterLeft = part_emitter_create(partSys);
part_emitter_region(partSys, partEmitterLeft, x - xDistance, x - xDistance div 2, y, y + 300, ps_shape_rectangle, ps_distr_linear);

partEmitterRight = part_emitter_create(partSys);
part_emitter_region(partSys, partEmitterRight, x + xDistance div 2, x + xDistance, y, y + 300, ps_shape_rectangle, ps_distr_linear);

function start(_quantity=1) {
	emiting = true;
	quantity = _quantity;
}

function stop() {
	emiting = false;
}

