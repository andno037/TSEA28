68K GAS  ./lab1.s 			page 1


   1               	
   2               	start:
   3 0000 2E7C 0000 		move.l #$7000,a7
   3      7000 
   4               		
   5               		
   6 0006 4EBA 0008 		jsr checkcode
   7               		
   8 000a 1E3C 00E4 		move.b #228,d7
   9 000e 4E4E      		trap #14
  10               	
  11               	checkcode:
  12 0010 183C 0040 		move.b #64,d4
  13 0014 1038 4000 		move.b $4000,d0
  14 0018 1238 4010 		move.b $4010,d1
  15 001c B240      		cmp d0,d1
  16 001e 6638      		bne slut
  17 0020 4EBA 00BA 		jsr printchar
  18 0024 1038 4001 		move.b $4001,d0
  19 0028 1238 4011 		move.b $4011,d1
  20 002c B240      		cmp d0,d1
  21 002e 6628      		bne slut
  22 0030 4EBA 00AA 		jsr printchar
  23 0034 1038 4002 		move.b $4002,d0
  24 0038 1238 4012 		move.b $4012,d1
  25 003c B240      		cmp d0,d1
  26 003e 6618      		bne slut
  27 0040 4EBA 009A 		jsr printchar
  28 0044 1038 4003 		move.b $4003,d0
  29 0048 1238 4013 		move.b $4013,d1
  30 004c B240      		cmp d0,d1
  31 004e 6608      		bne slut
  32 0050 4EBA 008A 		jsr printchar
  33 0054 183C 0040 		move.b #64,d4
  34               	slut:
  35 0058 4E75      		rts
  36               		
  37               		
  38               		
  39               	addkey:
  40               		
  41 005a 11F8 4001 			move.b $4001,$4000
  41      4000 
  42 0060 11F8 4002 			move.b $4002,$4001
  42      4001 
  43 0066 11F8 4003 			move.b $4003,$4002
  43      4002 
  44 006c 11C4 4003 			move.b d4,$4003
  45 0070 4E75      			rts
  46               		
  47               		
  48               	clearinput:
  49               		
  50 0072 11FC 0040 			move.b #$40,$4000
  50      4000 
  51 0078 11FC 0040 			move.b #$40,$4001
  51      4001 
68K GAS  ./lab1.s 			page 2


  52 007e 11FC 0040 			move.b #$40,$4002
  52      4002 
  53 0084 11FC 0040 			move.b #$40,$4003
  53      4003 
  54 008a 4E75      			rts
  55               		
  56               		
  57               		
  58               		
  59               	getkey:
  60               			;d0
  61 008c 1039 0001 			move.b $10082,d0 ;hämtar värden
  61      0082 
  62 0092 0200 0010 			and.b #%10000,d0 ; kollar strobe
  63 0096 0C40 0000 			cmp #0,d0
  64 009a 67F0      			beq getkey		; om ej tryck kolla igen
  65               	skapavärde:
  66 009c 1039 0001 			move.b $10082,d0  ;hämta värd
  66      0082 
  67 00a2 0200 000F 			and.b #%01111,d0  ;ta bort strobe
  68 00a6 1800      			move.b d0,d4      ; spara värdet
  69               	loop:		
  70 00a8 1039 0001 			move.b $10082,d0	;hämta värde
  70      0082 
  71 00ae 0200 0010 			and.b #%10000,d0	; kollar strobe
  72 00b2 0C40 0000 			cmp #0,d0
  73 00b6 66F0      			bne loop		;om man har släpte är det dags att gå till backa
  74 00b8 4E75      			rts
  75               	
  76               	deactivatealarm:
  77 00ba 13FC 0000 			move.b #0,$10080
  77      0001 0080 
  78 00c2 4E75      			rts
  79               			
  80               	activatealarm:
  81 00c4 13FC 0001 			move.b #1,$10080
  81      0001 0080 
  82 00cc 4E75      			rts
  83               			
  84               	printstring:
  85               			;pekare till sträng i a4
  86               			;längd på sträng i d5
  87 00ce 181C      			move.b (a4)+,d4
  88 00d0 4EBA 000A 			jsr printchar
  89 00d4 0605 FFFF 			add.b #-1,d5
  90 00d8 66F4      			bne printstring
  91 00da 4E75      			rts
  92               	
  93               	printchar:
  94 00dc 1F05      			move.b d5,-(a7)
  95               	waittx
  96 00de 1A39 0001 			move.b $10040,d5
  96      0040 
  97 00e4 0205 0002 			and.b #2,d5
  98 00e8 67F4      			beq waittx
  99 00ea 13C4 0001 			move.b d4,$10042
  99      0042 
68K GAS  ./lab1.s 			page 3


 100 00f0 1A1F      			move.b (a7)+,d5
 101 00f2 4E75      			rts
 102               	
 103               	setuppia:
 104 00f4 13FC 0000 		move.b #0,$10084
 104      0001 0084 
 105 00fc 13FC 0001 		move.b #1,$10080
 105      0001 0080 
 106 0104 13FC 0004 		move.b #4,$10084
 106      0001 0084 
 107 010c 13FC 0000 		move.b #0,$10086
 107      0001 0086 
 108 0114 13FC 0000 		move.b #0,$10082
 108      0001 0082 
 109 011c 13FC 0004 		move.b #4,$10086
 109      0001 0086 
 110 0124 4E75      		rts
 111               	
