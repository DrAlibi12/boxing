function CrowdConfig(_rows, _peoplePerRow, _scaleMax, _scaleDec, _autoSpawn) constructor {
	rows = _rows;
	peoplePerRow = _peoplePerRow;
	scaleMax = _scaleMax;
	scaleDec = _scaleDec;
	autoSpawn = _autoSpawn;
	
	function spawnCrowd() {
		var _crowd = instance_create_layer(0, 0, "Crowd", obj_crowd_manger);
		_crowd.initCrowd(scaleMax, scaleDec, rows, peoplePerRow, autoSpawn);
		
		return _crowd;
	}
	
}
