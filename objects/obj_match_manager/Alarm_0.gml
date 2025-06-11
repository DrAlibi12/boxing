/// @description Insert description here
// You can write your code in this editor

currentRound++;
if (currentRound <= MAX_ROUNDS) {
	//roundText = "ROUND   " + string(currentRound);
	roundText = "";
} else {
	roundText = "DECISION";
	createEndOverlay(true);
}

nextRound();