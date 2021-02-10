;
; AssemblerApplication10.asm
;
; Created: 2/10/2021 11:24:19 AM
; Author : KhaiNguyen
;

/*
Write a program to 
(a) load the PORTA register with the value OxAA,
 and (b) comple­ment Port A 500 times.
 Read the final value back into R20 and store the result in SRAM at 0x0100.
*/
/*
LDI R20, 0xAA
LDI R21, 100
loop1: 
	ldi R18, 5
	loop2:
		out porta, r20
		com r20
		dec r19
		brne loop2

	dec r21
	brne loop1

in r20, portA ; -- to register first
sts 0x0100,r20
nop
*/


.EQU MYLOC=0x200
	LDS r30, MYLOC
	TST R30
	BRNE NEXT
	LDI R30, 0x55
	STS MYLOC, R30
NEXT: 
jmp NEXT