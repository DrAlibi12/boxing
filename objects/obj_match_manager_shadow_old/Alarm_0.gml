/// @description Insert description here
// You can write your code in this editor

currentRound++;
if (currentRound <= 3) {
	roundText = "ROUND   " + string(currentRound);
} else {
	roundText = "DECISION";
}	

nextRound();