/// @description Insert description here
// You can write your code in this editor

cpuLevelMin = 0;
cpuLevelMax = 5;

function initCPUNivelator(_cpuId) {
	cpuId = _cpuId;
	adjustLevelCPU();
}

function adjustLevelCPU() {
	with (obj_virtual_key_atk) {
		configCPU(other.cpuId);
	}

	with (obj_virtual_key_dodge) {
		configCPU(other.cpuId);
	}
}