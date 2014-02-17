	
	;; du kör go c300 denna fil
start:
	lea $7000,a7
	jsr $20EC				;Initierar PINIT
	jsr tmpinit
	move.l #vpipe,$68	;Lägg in adress i vektor 2
	move.l #hpipe,$74	;Lägg in adress i vektor 5
	and.w #%1111100011111111,SR ;sätter I2,I1,I0 till 0
	;; tmp d1
	move.b  #$12,d1	
	bra Bakgrundsprogram


Bakgrundsprogram:
	or.w #%0000011100000000,SR ;sätter I2,I1,I0 till 1
	jsr $2020
	and.w #%1111100011111111,SR ;sätter I2,I1,I0 till 0
	move.l #1000,d0
	jsr $2000		;Delay
	
	bra Bakgrundsprogram


vpipe:
	move.w $10082,$10082
	jsr $2048
	rte
	
hpipe:
	
	move.w $10080,$10080
	jsr $20A6
	rte
	
	;; stackpekaren har $6FDC


tmpinit:
	
	lea $6000,a1
	move.l #$42,$6ff8
tmploop:	
	
	move.l #$1337,(a1)+
	cmp.l #$42,(a1)
	bne tmploop
	rts
	