;
; AssemblerApplication15.asm
;
; Created: 2/17/2021 3:15:17 PM
; Author : KhaiNguyen
;


//LED 0 Blinking
LDI R16,HIGH(RAMEND)
OUT SPH,R16
LDI R16,LOW(RAMEND)
OUT SPL,R16

LDI R20, 0xFF
OUT DDRA, R20	;make PORTA an output port

HERE:
SBI PORTA,0		;set bit PA0 --> set = 1s
CALL DELAY		;DELAY before next one

CBI PORTA,0		;turn on PA1
CALL DELAY		;DELAY before next one
RJMP HERE

//0.15 seconds time delay
DELAY: LDI R20,32			; 64 for 1 sec
	L1: LDI R21, 200
	L2: LDI R22, 250		;  250 - 0.5 sec
	L3: NOP
		NOP
		DEC R22
		BRNE L3
		DEC R21
		BRNE L2
		DEC R20
		BRNE L1
	RET