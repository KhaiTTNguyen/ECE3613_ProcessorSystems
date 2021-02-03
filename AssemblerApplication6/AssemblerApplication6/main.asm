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

/*
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
*/


ACT1:
	ldi r20, 0xA0	; Load 0xA0 to R20 
	inc r20			; increment the R20 value by 1
	sts 0x100, r20	; store content of r20 to 0x100
	inc r20			; increment the R20 value by 1
	sts 0x101, r20	; store content of r20 to 0x101
	inc r20			; increment the R20 value by 1
	sts 0x102, r20	; store content of r20 to 0x102
	inc r20			; increment the R20 value by 1
	sts 0x103, r20	; store content of r20 to 0x103
	rjmp ACT1
/*
ACT2: 
	ldi r20, 0x20	; load a number 0x20 to R20 
	sts 0x110, r20	; store 0x20 into the memory location 0x110
	dec r20			; decrement the value of R20 by 1
	dec r20			; decrement the value of R20 by another 1
	sts 0x111, r20	; store value after decrement into 0x111
	lds r0, 0x110	; load the contents of 0x110 to R0 
	lds r1, 0x111	; load the contents of 0x111 to R1
	rjmp ACT2
*/
/*
ACT3: 
	ldi r16, 0xb3	; load 0xb3 to r16
	ldi r17, 0x12	; load 0x12 to r17
	mov r18,r16		; save val of r16 to r18 for subtraction
	sub r18,r17		; subtract r17 from r18
	sts 0x200, r18	; store r18 to 0x200
	add r16,r17		; add r17 to r16
	sts 0x201, r16	; store r16 to 0x201
	rjmp ACT3
*/

/*
ACT4:
	in r1, PINA		; read $20 through PINA
	in r2, PINB		; read $3 through PINB
	add r1,r2		; add r2 to r1
	out PORTC,r1	; OUT --> 1 cycle instruction
	rjmp ACT4		; --> infinite loop back
	*/