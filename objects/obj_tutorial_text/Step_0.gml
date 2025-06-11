/// @description Insert description here
// You can write your code in this editor

if (!drawing || waiting) return;
/*
currentSteps++;

var camera_x = camera_get_view_x(view_camera[0]) + 400
var camera_y = camera_get_view_y(view_camera[0]) + 400

// Set font to correctly check string width
draw_set_font(TEXT_ENGINE_FONT);
if (currentSteps mod drawEachSteps == 0 || keyboard_check(FAST_FORWARD_KEY)) {	
	if (position > string_length(text)) {
		waiting = true;
		return;
	}
	
	var newChar = string_char_at(text, position); 
	
	if (newChar == "<") {
		position++;
		var actionChar = string_char_at(text, position);
		position++;
		var actionParam = "";
		while (string_char_at(text, position) != ">") {
			actionParam += string_char_at(text, position)
			position++;
		}
		doAction(actionChar, actionParam);
		position++;
		newChar = string_char_at(text, position);
	}
	
	drawnText += newChar;
	position++;
	if (textBeep != -1 && newChar != " ") {
		//audio_stop_sound(textBeep);
		//audio_play_sound(textBeep, 50, false);
	}
}
*/