;
; AssemblerApplication20_statusRegsFlags.asm
;
; Created: 3/5/2021 11:26:25 AM
; Author : KhaiNguyen
;

ldi r16, (1<<ddrb7)|(1<<ddrb5)|(1<<ddrb3)|(1<<ddrb1)
out ddrb,r16


ldi r16, (1<<portb7)|(1<<portb5)|(1<<portb3)|(1<<portb1)
out portb,r16

LDI R16, (1<<SREG_S)|(1<<SREG_N)|(1<<SREG_V)|(1<<SREG_I)		; use substitute names for bit 5,3,4,7 of SREG
out SREG,r16

.EQU CONST1 = 0x10
.EQU CONST2 = 0x91
.EQU CONST3 = 0x14
.EQU ADDR = (0x91 << 1)+1
LDI    R20,CONST1&CONST2
LDI    R21,CONST2|CONST3
LDI    R30,LOW(ADDR)			; take lower byte & put in R30
LDI    R31,HIGH(ADDR)			; take higher byte & put in R31


// Calculate the values that are loaded into the TCNTlL and TCNTlH I/O registers.

LDI    R16,HIGH(15900)

STS    0x0085,R16        ;TCNTlH-0x0085					 HIGH(15900) ; not located in 64 I/O registers

LDI    R16,LOW(15900)

STS    0x0084,R16        ;TCNTlL-0x0084 (or sth else)    LOW(15900) ; ; not located in 64 I/O registers - but in extended I/O

nop
