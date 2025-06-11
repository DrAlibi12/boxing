/// @description Insert description here
// You can write your code in this editor

if (stopped) exit;

hScale = approach(hScale, hStart, decrement);
vScale = approach(vScale, vStart, decrement);

if (hScale == hStart && vScale == vStart) {
	stopped = true;
}