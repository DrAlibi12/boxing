function HazardConfig(_hazardSpawnerLeft=undefined, _hazardSpawnerRight=undefined) constructor {
	fncSpawnerLeft = (_hazardSpawnerLeft == undefined) ? -1 : asset_get_index(_hazardSpawnerLeft);
	fncSpawnerRight = (_hazardSpawnerRight == undefined) ? -1 : asset_get_index(_hazardSpawnerRight);
	
	function spawnHazards() {
		if (fncSpawnerLeft == fncSpawnerRight) {
			// No hazards
			if (fncSpawnerLeft == -1) return;
		
			fncSpawnerLeft(true, true);
		} else {
			if (fncSpawnerLeft != -1) fncSpawnerLeft(true, false);;
			if (fncSpawnerRight != -1) fncSpawnerRight(false, true);
		}
	}
}
