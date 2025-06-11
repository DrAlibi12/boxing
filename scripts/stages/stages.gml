enum BackgroundType {
	Common,
	Background360
}

#macro BKG_360_SPD_FACTOR -0.00015
#macro BKG_HDIR_DECR 0.025

function setupStage(_backgroundType, _backgroundSprite, _foregroundSprite, _staticBkg, _isEndless, _bgm, _fightersOutside, _fightEndOverlay=noone, _hazardConfig=undefined, _crowdConfig=undefined, _effectsConfig=undefined) {
	var _crowd = noone;
	if (_crowdConfig != undefined) {
		_crowd = _crowdConfig.spawnCrowd();
	}

	var _backgroundScroller = instance_create_layer(0, 0, "Back", obj_background_scroller);
	_backgroundScroller.backgroundInit(_backgroundType, _backgroundSprite, _foregroundSprite, _staticBkg, _isEndless, _crowd);
	
	var _objFightSetup = instance_find(obj_fight_setup, 0);
	
	// _fightEndOverlay
	// add fight end overlay to match manager or fight setup
	_objFightSetup.END_OVERLAY = _fightEndOverlay;
	
	// _fightersOutside
	// add x and y start positions to fight setup
	_objFightSetup.FIGHTERS_APPEAR_OUTSIDE = _fightersOutside;
	
	// _crowdConfig,
	// Setup crowd
	
	// _effectsConfig
	// Setup effect layers
	
	// PLAY STAGE MUSIC
	audio_stop_all();
	if (_bgm != -1) {
		audio_play_sound(_bgm, 100, true);
	}
	
	// _hazardConfig	
	// Setup hazards
	if (_hazardConfig != undefined) _hazardConfig.spawnHazards();
}

function loadStage(_stageId=0) {
	// Load current stage from file
	var _fileName = string(_stageId);
	while (string_length(_fileName) < 3) {
		_fileName = "0" + _fileName;
	}
		
	var _file = file_text_open_read(working_directory + "stage/" + string(_fileName));
	
	// Read parameters from file
		
	// Background Type
	var _backgroundType = file_text_read_real(_file);
	file_text_readln(_file);

	// Background Image
	var _backgroundImageName = file_text_read_string(_file);
	var _backgroundImage = asset_get_index(_backgroundImageName);
	file_text_readln(_file);
		
	// Foreground Image
	var _foregroundImageName = file_text_read_string(_file);
	var _foregroundImage = asset_get_index(_foregroundImageName);
	file_text_readln(_file);
	
	// Static Background Image
	var _staticImageName = file_text_read_string(_file);
	var _staticImage = asset_get_index(_staticImageName);
	file_text_readln(_file);
		
	// Is Endless
	var _isEndless = bool(file_text_read_real(_file));
	file_text_readln(_file);

	// BGM
	var _bgmName = file_text_read_string(_file);
	var _bgm = asset_get_index(_bgmName);
	file_text_readln(_file);
	
	// Fight End Overlay
	var _endOverlayName = file_text_read_string(_file);
	var _endOverlay = asset_get_index(_endOverlayName);
	file_text_readln(_file);
		
	// Fighters Start Outside
	var _startOutside = bool(file_text_read_real(_file));
	file_text_readln(_file);
		
	// Hazard Spawn Left Function
	var _hazardLeftName = file_text_read_string(_file);
	file_text_readln(_file);

	// Hazard Spawn Right Function
	var _hazardRightName = file_text_read_string(_file);
	file_text_readln(_file);
	
	// Crowd parameters...
	var _crowdRows = file_text_read_real(_file);
	file_text_readln(_file);
	
	var _crowdPerRow = file_text_read_real(_file);
	file_text_readln(_file);
	
	var _crowdScaleMax = file_text_read_real(_file);
	file_text_readln(_file);

	var _crowdScaleDec = file_text_read_real(_file);
	file_text_readln(_file);

	var _crowdAutoSpawn = bool(file_text_read_real(_file));
	file_text_readln(_file);

	// Effect parameters...
		

	// CREATE CONFIG STRUCTS
	
	var _hazardConfig = undefined;
	if (!_isEndless) {
		_hazardConfig = new HazardConfig(_hazardLeftName, _hazardRightName);
	}

	var _crowdConfig = undefined;
	if (_crowdRows > 0) {
		_crowdConfig = new CrowdConfig(_crowdRows, _crowdPerRow, _crowdScaleMax, _crowdScaleDec, _crowdAutoSpawn);
	}
	
	// MOCKUP
	setupStage(
		_backgroundType,
		_backgroundImage,
		_foregroundImage,
		_staticImage,
		_isEndless,			// Background is Endless
		_bgm,				// BGM
		_startOutside,		// Appear Outside
		_endOverlay,		// Fight End Overlay
		_hazardConfig,		// Hazard Config
		_crowdConfig,		// Crowd Config
		undefined			// Effects Config
	);
}
