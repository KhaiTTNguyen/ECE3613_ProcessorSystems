;
; pullup_resistors.asm
;
; Created: 2/19/2021 4:11:47 PM
; Author : KhaiNguyen
;

/*
ldi r16, 0xff
out ddra, r16
out portb, r16		; activate portB pullups
cbi ddrb, 0			; make pb0 input
here: sbic pinb, 0	; if closed skip
rjmp here
sbi porta, 0		; set bit 0 porta
cbi porta, 0		; clear bit 0 porta
rjmp here
*/

/*
ldi r16, 0xff
out ddrb, r16		; set B as output
out ddrc, r16		; set C as output
out ddrd, r16		; set D as output --> once output, input also affected

ldi r17, 0x8C
out portd, r17		; simulated data out
ldi r18, 0x00
out ddrd, r18		; make D input port
L1:
	in r16, pind	; read from portD to r16
	out portb, r16
	out portc, r16
	rjmp L1
	*/

	/*
//.include <m324pbdef.inc>  
LDI R16, HIGH(RAMEND)
OUT SPH, R16
LDI R16, LOW(RAMEND)
OUT SPL, R16        
ldi r16, $ff
OUT DDRA,R16
HERE:
	sbi porta, porta1
	call DELAY
	sbi porta, porta3
	call DELAY
	sbi porta, porta5
	call DELAY
	sbi porta, porta7
	call DELAY
	
	cbi porta, porta1
	call DELAY
	cbi porta, porta3
	call DELAY
	cbi porta, porta5
	call DELAY
	cbi porta, porta7
	call DELAY
	JMP HERE

DELAY:
	ldi r20,32
	L1: LDI R21, 200
	L2: LDI R22, 250
	L3: NOP
	NOP
	DEC R22
	BRNE L3
	DEC R21
	BRNE L2
	DEC R20
	BRNE L1
	RET
	*/

/*
Write a program to monitor bit PB3. When it is HIGH, send Ox55 to PORTA. 
*/
ldi r16, $ff
out ddra, r16		; output port
cbi ddrb,3			; pin3 is input - need to activate pullups
sbi portb, 3		; activate pullup
L1:
	sbis pinb, 3	; skip next line if pin 3 is high (sw open) - exec if closed
	rjmp L1
	ldi r17, $55
	out porta, r17
	rjmp L1