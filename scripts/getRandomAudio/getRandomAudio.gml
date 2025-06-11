function getRandomAudio(audio_name, max_num) {
	var num = irandom(max_num - 1) + 1;
	var audio = asset_get_index(audio_name + "0" + string(num));
	
	return audio;
}