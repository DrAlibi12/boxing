enum LOCALE {
	EN,
	ES
}

#macro TRANSLATIONS_DIRECTORY "text/"

#macro SCENES_DIRECTORY "text/scenes/"
#macro SCENE_FILE_FORMAT "scene_{0}.csv"

global.locale = LOCALE.ES;

global.UI_TEXTS = getTranslations("ui.csv");

function getTranslations(_filename) {
	var _filePath = TRANSLATIONS_DIRECTORY + _filename;
	
	if (!file_exists(_filePath)) {
		throw("Translation file <" + _filename + "> does not exist!");
	}
	
	var _csvData = load_csv(_filePath);
	
	var _rowCount = ds_grid_height(_csvData);
	
	var _translations = ds_map_create();
	
	// Starts from row 1 to skip headers
	for (var _i=1; _i < _rowCount; _i++) {
		ds_map_add(_translations, _csvData[# 0, _i], _i);
	}
	
	return [_csvData, _translations];
}

function getText(_translationData, _key) {
	var _text = _key;
	
	var _csvGrid = _translationData[0];
	var _translationMap = _translationData[1];
	
	var _translationMapDefault = _translationData[LOCALE.EN];

	// show_message(_translationMap[? _key]);
	
	if (_translationMap[? _key] != undefined) {
		// show_message(_csvGrid[# 1 + global.locale, _translationMap[? _key]]);
		_text = _csvGrid[# 1 + global.locale, _translationMap[? _key]]
	} else if (_translationMapDefault[? _key] != undefined){
		// Fallback to "main" language
		_text = _csvGrid[# 1 + LOCALE.EN, _translationMapDefault[? _key]]
	}
	
	return _text;
}

function getSceneParagraphs(_sceneId) {
	var _sceneFullId = string(_sceneId);
	if (_sceneId < 10) {
		_sceneFullId = "00" + _sceneFullId;
	} else if (_sceneId < 100) {
		_sceneFullId = "0" + _sceneFullId;
	}
	
	var _filename = string_replace(SCENE_FILE_FORMAT, "{0}", _sceneFullId);
	
	var _filePath = SCENES_DIRECTORY + string_trim(_filename);
	
	if (!file_exists(_filePath)) {
		throw("Scene file <" + _filename + "> does not exist!");
	}
	
	var _csvData = load_csv(_filePath);
	
	var _rowCount = ds_grid_height(_csvData);
	
	var _paragraphs = ds_list_create();

	// Starts from row 1 to skip headers
	for (var _i=1; _i < _rowCount; _i++) {
		var _cmd = _csvData[# 0, _i];
		var _text = _csvData[# 1 + global.locale, _i];
		if (_cmd != "") {
			// Add command to paragraph
			_text = "<" + _cmd + ">" + _text;
		}
		
		ds_list_add(_paragraphs, _text);
	}
	
	return _paragraphs;
}
