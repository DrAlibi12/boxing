/// @description Draw bar

// draw_text(x + 32, y - 64 , curWidth);

// Draw background
draw_sprite_ext(
	sprite_index, 1,
	x + shaker.xDraw, y + shaker.yDraw,
	hDir, 1, 0, image_blend, 1
);

// Draw background fill
draw_sprite_part_ext(
	sprite_index, 3,
	barWidth - curEffectiveWidth, 0, curEffectiveWidth, barHeight,
	x + shaker.xDraw, y + shaker.yDraw,
	hDir, 1, image_blend, 1
)

if (danger) {
	// Draw danger line
	draw_sprite_part_ext(
		sprite_index, 3,
		// HALF BAR
		//barWidth / 2, 0, barWidth / 2, barHeight,
		// FULL BAR
		0, 0, barWidth, barHeight,
		x + shaker.xDraw, y + shaker.yDraw,
		hDir, 1, image_blend, 1
	)
}

// Draw fill
draw_sprite_part_ext(
	sprite_index, 2,
	barWidth - curWidth, 0, curWidth, barHeight,
	x + shaker.xDraw, y + shaker.yDraw,
	hDir, 1, image_blend, 1
)

// Draw outline
draw_sprite_ext(
	sprite_index, 0,
	x + shaker.xDraw, y + shaker.yDraw,
	hDir, 1, 0, image_blend, 1
)

draw_set_font(fnt_guard);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(x + hDir * (barWidth div 2), y + (barHeight div 2), barName);
