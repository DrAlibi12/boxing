/*
function invokeTutorialText(_ownerObj) {
	var _text = instance_create_layer(
		TUT_TEXT_POS_X,
		TUT_TEXT_POS_Y,
		"GUI",
		obj_tutorial_text
	);
	_text.owner = _ownerObj;
	
	var _paragraphs = ds_list_create();
	ds_list_add(_paragraphs, "Tutorial 1: texto 1. Aca hay una explicación de algo");
	ds_list_add(_paragraphs, "Tutorial 2: texto 2. Aca hay una explicación de algo. asd asdf as df as df asd f asd f");
	ds_list_add(_paragraphs, "Tutorial 3: texto 3. Aca hay una explicación de algo asd asdf as df as df asd f asd f");
	ds_list_add(_paragraphs, "Tutorial 4: texto 4. Aca hay una explicación de algoasd asdf as df as df asd f asd f asd asdf as df as df asd f asd f");
	ds_list_add(_paragraphs, "Tutorial 5: texto 5. Aca hay una explicación de algo asd asdf as df as df asd f asd f asdkf asdfa asd");

	_text.setParagraphs(_paragraphs);
	_text.drawNext();
}
*/

function splitIntoParagraphs(_text) {
	var _arrayParagraphs = string_split(_text, "\\n");
	
	// Convert to list
	var _listParagraphs = ds_list_create();

	for(var _i=0; _i < array_length(_arrayParagraphs); _i++) {
	    ds_list_add(_listParagraphs, _arrayParagraphs[_i]);
	}
	
	return _listParagraphs;
}

function invokeTutorialText(_text, _owner) {
	var _objText = instance_create_layer(
		TUT_TEXT_POS_X,
		TUT_TEXT_POS_Y,
		"GUI",
		obj_tutorial_text
	);
	_objText.owner = _owner;
	
	var _paragraphs = splitIntoParagraphs(_text);
	
	_objText.setParagraphs(_paragraphs);
	_objText.drawNext();
}
