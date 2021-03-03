;
; AssemblerApplication19.asm
;
; Created: 3/3/2021 11:11:00 AM
; Author : KhaiNguyen
;
; X=10000000, Y=1010; j=5, i=1
; X=X|(1<<5)|(1<<3)|=10000000|00100000|00001000
/*
LDI R16, 0b01101000	; 0x68
LDI r21, 8			; loop counter
LDI r22, 0			; initialize to 0, counting of 1's
clc					; clear carry bit
again:
	ROL r16			; rotate MSB --> carry
	brcc next		; BRCS for counting 0's
	inc r22			; found a 1 - incre counter
	next: 
	dec r21
	brne again
	nop

	*/

/* Write a Program that finds the 1st high bit of an 8-bit data item. Scan the bits from D0 to D7. As an example data item use 0x68. */
LDI R16, 0b01101000	; 0x68
LDI r21, 0			; loop counter
again:	rol r16
		brcs finish
		inc r21
		cpi r21,8 
		brne again
		finish : nop