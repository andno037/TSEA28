start:
	move.b #64,d4
	jsr printchar
	move.b #228,d7
	trap #14
	