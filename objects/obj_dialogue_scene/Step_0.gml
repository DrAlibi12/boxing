/// @description Insert description here
// You can write your code in this editor

if (ds_list_size(paragraphs) == 0) exit;

if (paused) exit;

var _confirm1 = (menuInputs[0].getAction1()[0] || menuInputs[0].getStart()[0]);
var _confirm2 = (menuInputs[1].getAction1()[0] || menuInputs[1].getStart()[0]);
var _confirm = (_confirm1 || _confirm2);

if (_confirm || currentText == "") {
	currentParagraph += 1;
	if (currentParagraph >= ds_list_size(paragraphs)) {
		instance_destroy();
		//currentParagraph = 0;
		//yScale = -1 * (0 + irandom(1));
	}
	currentText = ds_list_find_value(paragraphs, currentParagraph);
	
	checkCommand();

	if (irandom(1) == 0) {
		yScale = 1;
	} else {
		yScale = -1;
	}

	globeY = irandom_range(globeYMin, globeYMax) * yScale;

	curDisplacement = irandom(maxDisplacement) * xScale;
}

