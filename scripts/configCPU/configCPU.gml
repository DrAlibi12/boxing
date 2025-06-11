
global.cpuId = 2;

var _cpuId;

// CPU 0 => VERY EASY (MINION)
_cpuId = 0;
global.CPU[_cpuId, 0] = 5;		// 0..100 => CPU_DODGE_CAPABILITY
global.CPU[_cpuId, 1] = 5;		// 0..100 => CPU_OPENING_DETECTION_CAPABILITY
global.CPU[_cpuId, 2] = 40;		// 0..100 => CPU_GUARD_CAPABILITY
global.CPU[_cpuId, 3] = 0.2;	// sec    => CPU_MANUAL_RECOVER_PRESS_SPEED
global.CPU[_cpuId, 4] = 0.1;	// sec    => CPU_MANUAL_RECOVER_RELEASE_SPEED
global.CPU[_cpuId, 5] = 1.5;	// sec    => speedMin
global.CPU[_cpuId, 6] = 3;		// sec    => speedMax
global.CPU[_cpuId, 7] = 0;		// 0..100 => CPU_PARRY_CAPABILITY

// CPU 1 => EASY
_cpuId = 1;
global.CPU[_cpuId, 0] = 10;		// 0..100 => CPU_DODGE_CAPABILITY
global.CPU[_cpuId, 1] = 40;		// 0..100 => CPU_OPENING_DETECTION_CAPABILITY
global.CPU[_cpuId, 2] = 40;		// 0..100 => CPU_GUARD_CAPABILITY
global.CPU[_cpuId, 3] = 0.2;	// sec    => CPU_MANUAL_RECOVER_PRESS_SPEED
global.CPU[_cpuId, 4] = 0.1;	// sec    => CPU_MANUAL_RECOVER_RELEASE_SPEED
global.CPU[_cpuId, 5] = 0.5;	// sec    => speedMin
global.CPU[_cpuId, 6] = 0.8;		// sec    => speedMax
global.CPU[_cpuId, 7] = 2;		// 0..100 => CPU_PARRY_CAPABILITY

// CPU 2 => NORMAL
_cpuId = 2;
global.CPU[_cpuId, 0] = 15;		// 0..100 => CPU_DODGE_CAPABILITY
global.CPU[_cpuId, 1] = 50;		// 0..100 => CPU_OPENING_DETECTION_CAPABILITY
global.CPU[_cpuId, 2] = 60;		// 0..100 => CPU_GUARD_CAPABILITY
global.CPU[_cpuId, 3] = 0.2;	// sec    => CPU_MANUAL_RECOVER_PRESS_SPEED
global.CPU[_cpuId, 4] = 0.1;	// sec    => CPU_MANUAL_RECOVER_RELEASE_SPEED
global.CPU[_cpuId, 5] = 0.4;	// sec    => speedMin
global.CPU[_cpuId, 6] = 0.7;	// sec    => speedMax
global.CPU[_cpuId, 7] = 5;		// 0..100 => CPU_PARRY_CAPABILITY

// CPU 3 => HARD
_cpuId = 3;
global.CPU[_cpuId, 0] = 20;		// 0..100 => CPU_DODGE_CAPABILITY
global.CPU[_cpuId, 1] = 55;		// 0..100 => CPU_OPENING_DETECTION_CAPABILITY
global.CPU[_cpuId, 2] = 65;		// 0..100 => CPU_GUARD_CAPABILITY
global.CPU[_cpuId, 3] = 0.2;	// sec    => CPU_MANUAL_RECOVER_PRESS_SPEED
global.CPU[_cpuId, 4] = 0.1;	// sec    => CPU_MANUAL_RECOVER_RELEASE_SPEED
global.CPU[_cpuId, 5] = 0.4;	// sec    => speedMin
global.CPU[_cpuId, 6] = 0.7;	// sec    => speedMax
global.CPU[_cpuId, 7] = 10;		// 0..100 => CPU_PARRY_CAPABILITY

// CPU 4 => HARDER 
_cpuId = 4;
global.CPU[_cpuId, 0] = 55;		// 0..100 => CPU_DODGE_CAPABILITY
global.CPU[_cpuId, 1] = 65;		// 0..100 => CPU_OPENING_DETECTION_CAPABILITY
global.CPU[_cpuId, 2] = 70;		// 0..100 => CPU_GUARD_CAPABILITY
global.CPU[_cpuId, 3] = 0.2;	// sec    => CPU_MANUAL_RECOVER_PRESS_SPEED
global.CPU[_cpuId, 4] = 0.1;	// sec    => CPU_MANUAL_RECOVER_RELEASE_SPEED
global.CPU[_cpuId, 5] = 0.15;	// sec    => speedMin
global.CPU[_cpuId, 6] = 0.3;	// sec    => speedMax
global.CPU[_cpuId, 7] = 15;		// 0..100 => CPU_PARRY_CAPABILITY

// CPU 5 => BEAST MODE (TIRES FAST)
_cpuId = 5;
global.CPU[_cpuId, 0] = 65;		// 0..100 => CPU_DODGE_CAPABILITY
global.CPU[_cpuId, 1] = 65;		// 0..100 => CPU_OPENING_DETECTION_CAPABILITY
global.CPU[_cpuId, 2] = 80;		// 0..100 => CPU_GUARD_CAPABILITY
global.CPU[_cpuId, 3] = 0.1;	// sec    => CPU_MANUAL_RECOVER_PRESS_SPEED
global.CPU[_cpuId, 4] = 0.1;	// sec    => CPU_MANUAL_RECOVER_RELEASE_SPEED
global.CPU[_cpuId, 5] = 0.15;	// sec    => speedMin
global.CPU[_cpuId, 6] = 0.3;	// sec    => speedMax
global.CPU[_cpuId, 7] = 25;		// 0..100 => CPU_PARRY_CAPABILITY


//UNUSED 
// CPU 6 => HARD
_cpuId = 6;
global.CPU[_cpuId, 0] = 30;		// 0..100 => CPU_DODGE_CAPABILITY
global.CPU[_cpuId, 1] = 30;		// 0..100 => CPU_OPENING_DETECTION_CAPABILITY
global.CPU[_cpuId, 2] = 20;		// 0..100 => CPU_GUARD_CAPABILITY
global.CPU[_cpuId, 3] = 0.1;	// sec    => CPU_MANUAL_RECOVER_PRESS_SPEED
global.CPU[_cpuId, 4] = 0.05;	// sec    => CPU_MANUAL_RECOVER_RELEASE_SPEED
global.CPU[_cpuId, 5] = 0.3;	// sec    => speedMin
global.CPU[_cpuId, 6] = 0.4;	// sec    => speedMax
global.CPU[_cpuId, 7] = 25;		// 0..100 => CPU_PARRY_CAPABILITY


/*
  This Script is meant to be called ONLY from inside an obj_virtual_key
*/
function configCPU(_cpuId){
	CPU_DODGE_CAPABILITY = global.CPU[_cpuId, 0];
	CPU_OPENING_DETECTION_CAPABILITY = global.CPU[_cpuId, 1];
	CPU_GUARD_CAPABILITY = global.CPU[_cpuId, 2];
	CPU_MANUAL_RECOVER_PRESS_SPEED = global.CPU[_cpuId, 3];
	CPU_MANUAL_RECOVER_RELEASE_SPEED = global.CPU[_cpuId, 4];
	CPU_PARRY_CAPABILITY = global.CPU[_cpuId, 7];

	speedMin = global.CPU[_cpuId, 5];
	speedMax = global.CPU[_cpuId, 6];
}