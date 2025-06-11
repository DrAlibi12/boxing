if (status == FighterStatus.knockdown) exit;

hp = approach(hp, effectiveHp, character.hpRecovery);
//healthbar.updateValue(hp, false, effectiveHp);