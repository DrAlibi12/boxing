function StoryModeState() constructor {
	SLOT_ID = -1;
	DATETIME_STARTED = -1;
	DATETIME_SAVED = -1;
	CUR_EVENT_ID = 0;
	
	function startGame(_slotId) {
		SLOT_ID = _slotId;
		DATETIME_STARTED = date_current_datetime();
		DATETIME_SAVED = date_current_datetime();
		CUR_EVENT_ID = 0;
		global.GAME_STATE.save();
	}
	
	function load(_slotId, _startedDate, _lastSaveDate, _eventId) {
		SLOT_ID = _slotId;
		DATETIME_STARTED = (_startedDate != "") ? string_to_datetime(_startedDate) : -1;
		DATETIME_SAVED = (_lastSaveDate != "") ? string_to_datetime(_lastSaveDate) : -1;
		CUR_EVENT_ID = (_eventId != "") ? real(_eventId) : 0;
		show_debug_message(SLOT_ID);
		show_debug_message(DATETIME_STARTED);
		show_debug_message(date_datetime_string(DATETIME_STARTED));
		show_debug_message(DATETIME_SAVED);
		show_debug_message(date_datetime_string(DATETIME_SAVED));
		show_debug_message("EVENT ID: " + string(CUR_EVENT_ID));
	}

	function save(_eventId=-1) {
		CUR_EVENT_ID = (_eventId != -1) ? _eventId : CUR_EVENT_ID;
		DATETIME_SAVED = date_current_datetime();
		global.GAME_STATE.save();
	}
	
	function getSaveString() {
		if (DATETIME_STARTED == -1) return ",,";
		var _saveString = date_datetime_string(DATETIME_STARTED) + ","
						+ date_datetime_string(DATETIME_SAVED) + ","
						+ string(CUR_EVENT_ID);
						
		return _saveString;
	}
	
}
