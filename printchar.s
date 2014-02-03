printchar:
	move.b d5,-(a7)
waittx:
	move.b $10040,d5
	and.b #2,d5
	beq waittx
	move.b d4,$10042
	move.b (a7)+,d5
	rts
	