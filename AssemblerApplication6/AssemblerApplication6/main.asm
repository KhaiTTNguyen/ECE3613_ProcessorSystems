;
; AssemblerApplication6.asm
;
; Created: 2/3/2021 3:16:04 PM
; Author : KhaiNguyen
;


ldi r16, 0x0a
START:
IN R0,PINB
OUT PORTD,R0 ; OUT --> 1 cycle instruction
JMP START ; --> infinite loop back
