
#macro GS_SAVE_FILE_NAME "gamestate.sav"

global.GAME_STATE = new GameState();
global.GAME_STATE.load();

/*
// TEST SAVE/LOAD
global.GAME_STATE.storyModeSlots[0].startGame(0);
global.GAME_STATE.storyModeSlots[0].save(2);

global.GAME_STATE.storyModeSlots[1].startGame(1);
global.GAME_STATE.storyModeSlots[1].save();

global.GAME_STATE.storyModeSlots[2].startGame(2);
global.GAME_STATE.storyModeSlots[2].save(4);

global.GAME_STATE.unlockedFighters[1] = true;

global.GAME_STATE.unlockedScenarios[1] = true;
global.GAME_STATE.unlockedScenarios[3] = true;
global.GAME_STATE.unlockedScenarios[4] = true;

global.GAME_STATE.save();
global.GAME_STATE.load();
*/

function GameState() constructor {
	gameStateString = "";
	storyModeSlots = [new StoryModeState(), new StoryModeState(), new StoryModeState()];
	unlockedFighters = [false, false];
	unlockedScenarios = [false, false, false, false, false];
	
	function loadStoryModeSave(_slotId, _storyModeStateString) {
		var _storyModeState = string_split(_storyModeStateString, ",");
		
		if (array_length(_storyModeState) <= 1) {
			return;
		}
		
		var _startedDate = _storyModeState[0];
		var _lastSaveDate = _storyModeState[1];
		var _eventId = string_replace(_storyModeState[2], "\r\n", "");
		_eventId = string_replace(_eventId, "\n", "");
		storyModeSlots[_slotId].load(_slotId, _startedDate, _lastSaveDate, _eventId);		
	}
	
	function save() {
		/// Open save file
		var _saveFile = file_text_open_write(GS_SAVE_FILE_NAME);
	
		// Write new game state
		//file_text_write_string(_saveFile, _gameState);
		
		// SAVE STORY SLOT 0
		var _storySlotStr = storyModeSlots[0].getSaveString();
		file_text_write_string(_saveFile, _storySlotStr);
		file_text_writeln(_saveFile);

		// SAVE STORY SLOT 1
		_storySlotStr = storyModeSlots[1].getSaveString();
		file_text_write_string(_saveFile, _storySlotStr);
		file_text_writeln(_saveFile);

		// SAVE STORY SLOT 2
		_storySlotStr = storyModeSlots[2].getSaveString();
		file_text_write_string(_saveFile, _storySlotStr);
		file_text_writeln(_saveFile);


		// SAVE UNLOCKED FIGHTERS
		var _unlockableFighterArr = []
		
		// UNLOCKABLE FIGHTER A
		_unlockableFighterArr[0] = real(unlockedFighters[0]);
		// UNLOCKABLE FIGHTER B
		_unlockableFighterArr[1] = real(unlockedFighters[1]);

		var _unlockableFightersStr = array_to_string(_unlockableFighterArr, ",");
		file_text_write_string(_saveFile, _unlockableFightersStr);
		file_text_writeln(_saveFile);


		// SAVE UNLOCKED SCENARIOS
		var _unlockableScenariosArr = []
		
		// UNLOCKABLE SCENARIO A
		_unlockableScenarioArr[0] = real(unlockedScenarios[0]);
		// UNLOCKABLE SCENARIO B
		_unlockableScenarioArr[1] = real(unlockedScenarios[1]);
		// UNLOCKABLE SCENARIO A
		_unlockableScenarioArr[2] = real(unlockedScenarios[2]);
		// UNLOCKABLE SCENARIO B
		_unlockableScenarioArr[3] = real(unlockedScenarios[3]);
		// UNLOCKABLE SCENARIO B
		_unlockableScenarioArr[4] = real(unlockedScenarios[4]);

		var _unlockableScenariosStr = array_to_string(_unlockableScenarioArr, ",");
		file_text_write_string(_saveFile, _unlockableScenariosStr);
		file_text_writeln(_saveFile);


		// Close save file
		file_text_close(_saveFile);
	}

	function load() {
		if (!file_exists(GS_SAVE_FILE_NAME)) return "";

		// Open save file
		var _saveFile = file_text_open_read(GS_SAVE_FILE_NAME);
	
		// Read game state
		//var _gameState = file_text_read_string(_saveFile);
	
		if (file_text_eof(_saveFile)) {
			file_text_close(_saveFile);
			return;
		}
	
		// READ STORY SLOT 0
		var _storyModeStateStr = file_text_readln(_saveFile);
		loadStoryModeSave(0, _storyModeStateStr);
		
		if (file_text_eof(_saveFile)) {
			file_text_close(_saveFile);
			return;
		}
		
		// READ STORY SLOT 1
		_storyModeStateStr = file_text_readln(_saveFile);
		loadStoryModeSave(1, _storyModeStateStr);

		if (file_text_eof(_saveFile)) return;

		// READ STORY SLOT 2
		_storyModeStateStr = file_text_readln(_saveFile);
		loadStoryModeSave(2, _storyModeStateStr);

		if (file_text_eof(_saveFile)) {
			file_text_close(_saveFile);
			return;
		}

		// READ UNLOCKED FIGHTERS
		var _unlockedFightersStr = file_text_readln(_saveFile);
		var _unlockedFighterArr = string_split(_unlockedFightersStr, ",");

		// UNLOCKED FIGHTER A
		unlockedFighters[0] = bool(_unlockedFighterArr[0]);

		// UNLOCKED FIGHTER B
		unlockedFighters[1] = bool(_unlockedFighterArr[0]);

		if (file_text_eof(_saveFile)) {
			file_text_close(_saveFile);
			return;
		}

		// READ UNLOCKED SCENARIOS
		var _unlockedScenariosStr = file_text_readln(_saveFile);
		var _unlockedScenarioArr = string_split(_unlockedScenariosStr, ",");

		unlockedScenarios[0] = bool(_unlockedScenarioArr[0]);
		unlockedScenarios[1] = bool(_unlockedScenarioArr[1]);
		unlockedScenarios[2] = bool(_unlockedScenarioArr[2]);
		unlockedScenarios[3] = bool(_unlockedScenarioArr[3]);
		unlockedScenarios[4] = bool(_unlockedScenarioArr[4]);
	
		// Close save file
		file_text_close(_saveFile);
	}
	
}

