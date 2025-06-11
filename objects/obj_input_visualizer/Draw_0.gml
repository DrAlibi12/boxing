/// @description 

if (input == -1) exit;

draw_circular_bar(
	x, y,
	1, 1,
	c_black,
	50,
	1, 22
);

draw_circular_bar(
	x, y,
	percentage, 100,
	color,
	48,
	1, 18
);

if (!movesVisible) exit;

for (var _i=0; _i < 5; _i++) {
	if (moves[_i] == -1) break;

	draw_sprite_ext(
		text_sprite,
		moves[_i],
		x + 48 * alignment, y - 128 - 96 * _i,
		1, 1, 0, c_white, 1 - _i * 0.2
	);
}