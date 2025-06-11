/// @description MOVE!

if (!started) exit;

character.x = approach(character.x, targetX, 10);

show_debug_message(character.x);

if (character.x == targetX) {
	character.bounceEnabled = true;
	
	owner.continueScene();
	instance_destroy();	
}
