/// @description Draw dialogue text

if (currentText == "") exit;

draw_sprite(spr_dialogue, 0, x + globeX + curDisplacement, y + globeY + curDisplacement);

draw_sprite_ext(spr_dialogue_tail, 0, x + curDisplacement, y + curDisplacement, xScale, yScale, 0, c_white, 1);

draw_sprite(spr_dialogue, 1, x + globeX + curDisplacement, y + globeY + curDisplacement);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_set_font(fnt_dialogue);
draw_text_ext(x + globeX + curDisplacement, y + globeY + curDisplacement, currentText, 44, 350);
