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



	/*
// Activity 3 Part1
ldi r16, 0x00
out ddrb,r16		; make portb an input --> need to actiate pullup resistors
ldi r16, 0xFF
out ddra, r16		; make porta an output
out portb, r16		; activate portb pullup resistors
ldi r16, 0x00
ldi r17, 0x01
ldi r18, 0x02
ldi r19, 0x03
;.... r20-24 for 0x04 - 0x07
mainloop:
	sbis pinb,0				; skip if bit 0 is set
	out porta, r16			; send out 

	sbis pinb,1				; skip if switch is opened / bit 1 is set
	out porta, r17			; send a "1"
	sbic pinb, 1			; skip if swithc open
	out porta, r16

	sbis pinb,2				; skip if switch is opened / bit 1 is set
	out porta, r18			; send a "1"
	sbic pinb, 2			; skip if swithc open
	out porta, r16


	sbis pinb,3 			; skip if switch is opened / bit 1 is set
	out porta, r19			; send a "1"
	sbic pinb, 3			; skip if swithc open
	out porta, r16

	rjmp mainloop

	*/

