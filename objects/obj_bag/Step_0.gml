/// @description Insert description here
// You can write your code in this editor

swing = approach(swing, swingMin, 0.05);
image_angle = sine_wave((current_time - swingStartAt) / 1000, 3, swing, 0);

if (abs(image_angle) > 3) screech = true;

if (screech && abs(image_angle) < 1) {
	screech = false;
	var _audio = getRandomAudio("snd_bag_screech", 4);
	audio_play_sound(_audio, 100, false);
}

