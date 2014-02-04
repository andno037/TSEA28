
start:
	jsr setuppia
	jsr setuptext
reset:
	jsr clearinput
	jsr deactivatealarm
waitfora:	
	jsr getkey
	cmp #$A,d4
	bne waitfora		
activated	
	jsr activatealarm
waitforf:
	jsr getkey
	cmp #$F,d4
	beq ftryckt
	cmp #$A,d4
	bge waitforf
	jsr addkey
	bra waitforf
ftryckt:
	jsr checkcode
	cmp #1,d4
	beq reset
	move.b #16,d5
	move.l #$4020,a4
	jsr printstring
	jsr clearinput
	bra waitforf
	
	
rensaminne:
	move.b #228,d7
	trap #14
	
checkcode:
	move.b #0,d4
	move.b $4000,d0
	move.b $4010,d1
	cmp d0,d1
	bne slut
	move.b $4001,d0
	move.b $4011,d1
	cmp d0,d1
	bne slut
	move.b $4002,d0
	move.b $4012,d1
	cmp d0,d1
	bne slut
	move.b $4003,d0
	move.b $4013,d1
	cmp d0,d1
	bne slut
	move.b #1,d4
slut:
	rts
	
addkey:
	
		move.b $4001,$4000
		move.b $4002,$4001
		move.b $4003,$4002
		move.b d4,$4003
		rts
	
	
clearinput:
	
		move.b #$40,$4000
		move.b #$40,$4001
		move.b #$40,$4002
		move.b #$40,$4003
		rts
	
	
	
	
getkey:
		;d0
		move.b $10082,d0 ;hämtar värden
		and.b #%10000,d0 ; kollar strobe
		cmp #0,d0
		beq getkey		; om ej tryck kolla igen
skapavärde:
		move.b $10082,d0  ;hämta värd
		and.b #%01111,d0  ;ta bort strobe
		move.b d0,d4      ; spara värdet
loop:		
		move.b $10082,d0	;hämta värde
		and.b #%10000,d0	; kollar strobe
		cmp #0,d0
		bne loop		;om man har släpte är det dags att gå till backa
		rts

deactivatealarm:
		move.b #0,$10080
		rts
		
activatealarm:
		move.b #1,$10080
		rts
		
printstring:
		;pekare till sträng i a4
		;längd på sträng i d5
		move.b (a4)+,d4
		jsr printchar
		add.b #-1,d5
		bne printstring
		rts

printchar:
		move.b d5,-(a7)
waittx
		move.b $10040,d5
		and.b #2,d5
		beq waittx
		move.b d4,$10042
		move.b (a7)+,d5
		rts

setuptext:
	move.l #$46656c61,$4020
	move.l #$6b746967,$4024
	move.l #$206b6f64,$4028
	move.l #$21212121,$402c
	rts
		
setuppia:
	move.b #0,$10084
	move.b #1,$10080
	move.b #4,$10084
	move.b #0,$10086
	move.b #0,$10082
	move.b #4,$10086
	rts

	