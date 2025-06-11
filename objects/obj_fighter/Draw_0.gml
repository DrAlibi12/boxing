/// @description Insert description here
// You can write your code in this editor

//draw_set_color(c_white);
//draw_text(32, 536 + playerId * 96, status);

/*draw_set_font(fnt_debug);
draw_text(64, 536 + 64 * playerId, guardHp);
draw_text(64, 700 + 64 * playerId, input.is_pressed);
*/
/*
// INPUT DEBUG
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_font(fnt_debug);
draw_text(64, 400 * playerId, attackInput.isPressed());
draw_text(64, 400 * playerId + 32, attackInput.isHeld());
draw_text(64, 400 * playerId + 64, attackInput.isReleased());
draw_text(64, 400 * playerId + 96, dodgeInput.isPressed());
draw_text(64, 400 * playerId + 128, dodgeInput.isHeld());
draw_text(64, 400 * playerId + 160, dodgeInput.isReleased());
*/

draw_sprite_ext(
	sprite_index, image_index,
	x + shaker.xDraw, max(PLAYER_Y, y + shaker.yDraw),
	stretcher.hScale * stretcher.hDir, stretcher.vScale,
	0, image_blend, image_alpha
);

if (overlayAlpha > 0) {
	draw_sprite_ext(
		sprite_index, image_index,
		x + shaker.xDraw, max(PLAYER_Y, y + shaker.yDraw),
		stretcher.hScale * stretcher.hDir, stretcher.vScale,
		0, overlayColor, overlayAlpha
	);
}

//draw_set_color(c_white);
//draw_text(64, 700 + 64 * playerId, status);
//draw_text(64, 700 + 64 * playerId, points[currentRound]);
