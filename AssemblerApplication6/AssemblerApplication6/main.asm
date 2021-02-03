;
; AssemblerApplication6.asm
;
; Created: 2/3/2021 3:16:04 PM
; Author : KhaiNguyen
;

/*
ldi r16, 0x0a
START:
IN R0,PINB
OUT PORTD,R0 ; OUT --> 1 cycle instruction
JMP START ; --> infinite loop back
*/

START:
	LDI R16,0X55	;LOAD 0X55 TO R16
	STS 0X200,R16	;STORE R16 VALUE TO 0X200
	LDI R17,0X34	;LOAD 0X34 TO R17
	STS 0X201,R17	;STORE R17 VALUE TO 0X201
	ADD R16,R17		;ADD R16 AND R17 AND STORE IN R16
	STS 0X202,R16	;STORE THE SUM INTO 0X202
	RJMP START		;JUMP BACK TO THE LABEL START 
					; - relative jump 32-bit cmd - only 64bits back & forth
					; JMP - jump only 32K bits