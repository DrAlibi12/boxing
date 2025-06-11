/// @description Initialization

event_inherited();

textMaxWidth = TUT_TEXT_MAX_WIDTH;
textSeparation = TUT_TEXT_V_SEP;
textColor = c_white;

paragraphs = noone;
currentParagraph =  -1;
waiting = false;

text = "";
position = 1;
drawing = false;
drawnText = "";

function setParagraphs(newParagraphs) {
	drawing = false;
	paragraphs = newParagraphs;
	currentParagraph = -1;
}

function setText(newText) {
	text = newText;
	drawnText = "";
	position = 1;
}

/*
* Set text box's text speed
* The lower the "newSpeed" value,
* the faster the text will be drawn.
* Min "newSpeed" value = 1
*/
function setSpeed(newSpeed) {
	drawEachSteps = newSpeed;
}

function doAction(actionChar, actionParam) {
	switch (actionChar) {
		case "s": {
			// Set new text speed
			newSpeed = real(actionParam);
			setSpeed(newSpeed);
		}
	}
	
}

function drawNext() {
	currentParagraph++;
	if (currentParagraph >= ds_list_size(paragraphs)) {
		instance_destroy();
		return;
	}
	setText(ds_list_find_value(paragraphs, currentParagraph));
	// DRAW THE WHOLE THING
	drawnText = text;
	waiting = true;

	drawing = true;
}

function skipCurrent() {
	if !(drawing && text != "") return;

	if (waiting) {
		drawNext();
		return;
	}

	position = string_length(text) + 1;
	drawnText = text;
	waiting = true;
}
