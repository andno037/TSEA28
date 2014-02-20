	;; du kör go c300 inann denna fill
start:
	lea $7000,a7
	jsr $20EC 		; Initierar PINIT
	move.l #vklick,$68
	move.l #hklick,$74
	 
	clr.l d3
	clr.l d4

	move.l #128,d2
	
	move.l #$ff,d5
	move.l #$ff,d6
	
kollserv:
	move.l #1000,d0
	move.b d2,$10080
	and.w #%1111100011111111,SR
	jsr $2000
	or.w #%0000011100000000,SR ;sätter I2,I1,I0 till 1
	cmp.b #$ff,d6
	beq kollserv
flyttaboll:
	cmp.b #$ff,d5
	beq flyttaH
flyttaV:
	lsl.b #1,d2
	cmp.b #0,d2
	bne kollserv
	add #1,d4
	move.b #$ff,d6
	move.b #1,d2
	bra kollserv
flyttaH:
	lsr.b #1,d2
	cmp.b #0,d2
	bne kollserv
	add #1,d3
	move.b #$ff,d6
	move.b #128,d2
	bra kollserv
	
vklick:
	or.w #%0000011100000000,SR ;sätter I2,I1,I0 till 1
	tst.w $10082
	cmp.b #128,d2
	bne nejV
	move.b #$ff,d5
	move.b #0,d6
	bra slutV
nejV:
	add.b #1,d4
	move.b #$ff,d6
	move.b #0,d5
	move.b #1,d2
slutV:
	rte


hklick:
	or.w #%0000011100000000,SR ;sätter I2,I1,I0 till 1
	tst.w $10080
	cmp.b #1,d2
	bne nejH
	move.b #$0,d5
	move.b #0,d6
	bra slutH
nejH:
	add.b #1,d3
	move.b #$ff,d6
	move.b #$ff,d5
	move.b #128,d2
slutH:
	rte




