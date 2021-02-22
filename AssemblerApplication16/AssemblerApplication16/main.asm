;
; AssemblerApplication16.asm
;
; Created: 2/22/2021 11:18:30 AM
; Author : KhaiNguyen
;


cbi ddrb,5
cbi ddrb,6

ldi r16, $ff
out ddra, r16 ; make porta output
L1:
	sbic pinb,5		; or low, send $55
	rjmp L2			; exec if pinb5 high
	IS_LOW:
	ldi r17, $55
	out porta, r17
	rjmp L1

L2: 
	sbis pinb,6		; if 6 Low exec next
	rjmp IS_LOW
	ldi r17, $AA
	out porta, r17
	rjmp L1