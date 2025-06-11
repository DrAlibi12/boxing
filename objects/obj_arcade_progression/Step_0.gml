/// @description AT END OF AN EVENT (FIGHT OR WHATEVER)

if (!preparingNextFight) exit;

if (instance_exists(objFadeOut) && objFadeOut.ended) {
	var _target = rm_fight;

	// PLAY CHAPTER INTRO
	var _prevChapterId = CUR_CHAPTER_ID;
	setCurrentChapterFromCurrentEvent();
	if (_prevChapterId != CUR_CHAPTER_ID) {
		_target = rm_chapter_intro;
	}

	if (CUR_FIGHT_ID > LAST_FIGHT_ID) {
		// GAME SAVE
		// SAVE COMPLETED STATUS!
		//global.GAME_STATE.storyModeSlots[CUR_SLOT_ID].saveCompleted();

		// RESET FIGHT ID!
		CUR_FIGHT_ID = 0;
		_target = rm_arcade_end;
	} else {
		show_debug_message("SAVING GAME...");
		// GAME SAVE
		// SAVE CURRENT EVENT
		global.GAME_STATE.storyModeSlots[CUR_SLOT_ID].save(CUR_FIGHT_ID);
		show_debug_message("GAME SAVED!");
	}
	
	room_goto(_target);
}
