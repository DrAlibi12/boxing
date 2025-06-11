function colorMultiply(_color1, _color2) {
	var _r1 = color_get_red(_color1);
	var _g1 = color_get_green(_color1);
	var _b1 = color_get_blue(_color1);
	
	var _r2 = color_get_red(_color2);
	var _g2 = color_get_green(_color2);
	var _b2 = color_get_blue(_color2);

	return make_color_rgb(_r1 * _r2, _g1 * _g2, _b1 * _b2);
}