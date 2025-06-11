/// @description Insert description here
// You can write your code in this editor

var _menuInput1 = createLocalMenuInputManager(
	1, global.PLAYER_KEYBOARD[1]
);
var _menuInput2 = createLocalMenuInputManager(
	2, global.PLAYER_KEYBOARD[2]
);

menuInputs = [_menuInput1, _menuInput2];

objArcadeProgression = instance_find(obj_arcade_progression, 0);

owner = noone;
callback = function(_owner) { show_debug_message("Dialogue callback is empty"); };

characters = [];
for (var _i=0; _i < instance_number(obj_fighter); _i++) {
	var _character = instance_find(obj_fighter, _i);
	// _i + 1 so array starts on PLAYER 1 and not PLAYER 0
	characters[_i + 1] = _character;
}

sceneId = -1;

paused = false;

startX = P1_X + 180;
startY = PLAYER_Y - 560;

x = startX;
y = startY;

maxDisplacement = 24;
curDisplacement = irandom(maxDisplacement);

xScale = 1;

if (irandom(1) == 0) {
	yScale = 1;
} else {
	yScale = -1;
}

globeYMin = 0
globeYMax = -250;
globeY = irandom_range(globeYMin, globeYMax) * yScale;

globeX = 280 * xScale;

fullText = "";
paragraphs = ds_list_create();

currentParagraph = 0;
currentText = ds_list_find_value(paragraphs, currentParagraph);

targetCharacter = characters[1];

function setTargetPlayer(_playerId=1) {
	targetCharacter = characters[_playerId];

	xScale = characters[_playerId].stretcher.hDir; // (_playerId == 1) ? 1 : -1;
	
	x = characters[_playerId].x; //(_playerId == 1) ? P1_X : P2_X;
	x += 180 * xScale;
	
	globeX = 280 * xScale;
}

function checkCommand() {
	if (string_char_at(currentText, 1) == "<") {
		var _cmdStartPos = 2;
		var _cmdEndPos = string_pos(">", currentText);
		var _cmd = string_copy(currentText, _cmdStartPos, _cmdEndPos - _cmdStartPos);
		runCommand(_cmd);
		currentText = string_split(currentText, ">")[1];
	}
}

function playScene(_sceneId) {
	//fullText = "<P2>THIS IS A TEST TEXT OF P2.\\n<P1> THIS IS A TEST TEXT OF P1.\\nALL WRITTEN HERE MUST APPEAR IN THE SCREEN AND YOU SHOULD BE ABLE TO READ IT WITHOUT ANY PROBLEM. \\nALSO THIS TEXT SHOULD APPEAR WITHIN THE DIALOGUE GLOBE, WITHOUT EXCEEDING ITS BOUNDARIES";
	//paragraphs = splitIntoParagraphs(fullText);
	sceneId = _sceneId;

	paragraphs = getSceneParagraphs(_sceneId);

	currentParagraph = 0;
	currentText = ds_list_find_value(paragraphs, currentParagraph);

	checkCommand();
}

function continueScene() {
	paused = false;
}

function runCommand(_cmd) {
	var _cmdCode = string_char_at(_cmd, 1);
	var _cmdArgsRaw = string_copy(_cmd, 2, string_length(_cmd) - 1);
	var _cmdArgs = string_split(_cmdArgsRaw, ",");
	
	var _playerId;
	switch (_cmdCode) {
		case "P": // Change Target player
			_playerId = real(_cmdArgs[0]);
			setTargetPlayer(_playerId);
		break;
		case "D": // Target Change Facing Direction
			var _facingDirection = real(_cmdArgs[0]);
			//show_message(_facingDirection);
			_facingDirection = (_facingDirection < 0) ? -1 : 1;
			targetCharacter.stretcher.hDir = _facingDirection;
		break;
		case "M": // Target Move
			paused = true;
			var _xMove = real(_cmdArgs[0]);
			var _mover = instance_create_layer(0, 0, "GUI", obj_character_mover);
			var _curX = targetCharacter.startX;
			var _targetX = _curX + _xMove;
			_mover.initMover(targetCharacter, _targetX);
		break;
		case "I": // Target Change Image
			paused = true;
			var _imageIndex = real(_cmdArgs[0]);
			var _startYScale = real(_cmdArgs[1]);
			var _targetYScale = real(_cmdArgs[2]);
			var _imageChanger = instance_create_layer(0, 0, "GUI", obj_character_change_image);
			_imageChanger.initImageChanger(targetCharacter, _imageIndex, _startYScale, _targetYScale);
		break;
		case "S": // Target shake
			var _factor = real(_cmdArgs[0]);
			var _decrement = real(_cmdArgs[1]);
			targetCharacter.shaker.shake(_factor, _decrement);
		break;
		case "B": // Target Wave & Bounce (enable/disable)
			// THIS WILL RESET THE CHARACTER TO IT'S FIGHING SPOT
			// USE CAREFULLY
			var _enable = bool(real(_cmdArgs[0]));
			targetCharacter.waveEnabled = _enable;
			targetCharacter.bounceEnabled = _enable;
		break;
		case "W": // Wait miliseconds
			var _miliseconds = real(_cmdArgs[0]);
			var _seconds = _miliseconds / 1000;
			paused = true;
			alarm[0] = game_get_speed(gamespeed_fps) * _seconds;
		break;
		case "C": // Spawn new character
			var _xScale = real(_cmdArgs[0]);
			var _x = real(_cmdArgs[1]);
			var _characterId = real(_cmdArgs[2]);
			var _image = real(_cmdArgs[3]);
			
			var _character = instance_create_layer(_x, PLAYER_Y, "GUI", obj_fighter);
			_character.initFighter(1, _characterId, noone, false, 0);
			_character.startX = _x;
			_character.x = _x;
			_character.image_index = _image;
			_character.stretcher.hDir = _xScale;
			_character.status = FighterStatus.enterRing;
			
			// Add to characters:
			characters[array_length(characters)] = _character;			
		break;
		case "E": // End scene
			// pause to prevent the fight starting
			paused = true;
			// End the scene going to "next fight" from obj arcade
			objArcadeProgression.gotoNextFight();
		break;
		case "X": // Run function
			var _functionName = _cmdArgs[0];
			var _arg1 = _cmdArgs[1];
			var _function = asset_get_index(_functionName);
			_function(_arg1);
		break;
	}
}
