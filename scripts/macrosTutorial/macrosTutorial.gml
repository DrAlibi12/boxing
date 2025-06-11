// Position of joystick buttons on tutorial
#macro TUT_UI_JOY_X 176
#macro TUT_UI_JOY_Y 896

// Position of keyboard keys on tutorial
#macro TUT_UI_KEY_X 226
#macro TUT_UI_KEY_Y 820

// Y POSITION TO GET THINGS OUTSIDE OF THE SCREEN
#macro TUT_UI_Y_HIDE 1600

#macro TUT_TEXT_POS_X 960
#macro TUT_TEXT_POS_Y 900
#macro TUT_TEXT_MAX_WIDTH 1300
#macro TUT_TEXT_FONT fnt_text_box
#macro TUT_TEXT_V_SEP font_get_size(TUT_TEXT_FONT) * 1.1

// !!! NOT RGB!! THIS IS BGR!!
#macro ATTACK_FNT_COLOR 0x464B8B
#macro ATTACK_SHD_COLOR 0x1C2456

// !!! NOT RGB!! THIS IS BGR!!
#macro GUARD_FNT_COLOR 0x647459
#macro GUARD_SHD_COLOR 0x293837

enum DummyCPUActions {
	jab,
	hook,
	guard
}

