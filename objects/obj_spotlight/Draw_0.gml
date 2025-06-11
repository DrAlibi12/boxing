/// @description Insert description here
// You can write your code in this editor

// draw current overlay
gpu_set_blendmode_ext(bm_dest_color, bm_inv_src_alpha);
draw_set_alpha(image_alpha);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, 0, c_white, image_alpha);
draw_set_alpha(1);
gpu_set_blendmode(bm_normal);

// draw spotlight!
if (image_index == 1) {
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(sprite_index, 2, x, y, image_xscale, 1, 0, image_blend, 0.5);
	gpu_set_blendmode(bm_normal);
}
