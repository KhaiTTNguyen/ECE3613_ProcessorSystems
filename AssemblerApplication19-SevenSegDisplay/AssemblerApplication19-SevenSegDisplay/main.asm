;
; AssemblerApplication19-SevenSegDisplay.asm
;
; Created: 3/1/2021 11:18:34 AM
; Author : KhaiNguyen
;

.equ one=0b00000110
.equ two=0b01011011
.equ three=0b01001111
.equ four=0b01100110
.equ five=0b01101101
.equ six=0b01111100
.equ seven=0b0000111
.equ eight=0b01111111
.equ nine=0b01100111
.equ zero=0b00111111
.equ H=0b01110110
.equ E=0b01111001
.equ L=0b00111000
.equ O=0b00111111

LDI R16, HIGH(RAMEND)
OUT SPH, R16
LDI R16, LOW(RAMEND)
OUT SPL, R16 ;initialize stack pointer
LDI R16, 0xFF
LDI R17, 0x00
OUT DDRA, R16 ;make Port A an output port
OUT portb, r16			; activate pullups
out ddrb, r17
;---------------set up digits

main:
sbis pinb,0
call digits
sbis pinb, 1
call TUID
sbis pinb, 2
call hello
rjmp main

digits: 
LDI R16, zero //0 for seven seg
OUT PORTA, R16 ;Write digit
CALL DELAY
LDI R16, one //1 for seven seg
OUT PORTA, R16 ;Write digit
CALL DELAY
LDI R16, two //2 for seven seg
OUT PORTA, R16 ;Write digit
CALL DELAY
LDI R16, three //3 for seven seg
OUT PORTA, R16 ;Write digit
CALL DELAY
LDI R16, four //4 for seven seg
OUT PORTA, R16 ;Write digit
CALL DELAY
LDI R16, five //5 for seven seg
OUT PORTA, R16 ;Write digit
CALL DELAY
LDI R16, six //6 for seven seg
OUT PORTA, R16 ;Write digit
CALL DELAY
LDI R16, seven //7 for seven seg
OUT PORTA, R16 ;Write digit
CALL DELAY
LDI R16, eight //8 for seven seg
OUT PORTA, R16 ;Write digit
CALL DELAY
LDI R16, nine //9 for seven seg
OUT PORTA, R16 ;Write digit
CALL DELAY
RET

TUID:
LDI R16, nine //9 for seven seg
OUT PORTA, R16 ;Write digit
CALL DELAY
LDI R16, one //1 for seven seg
OUT PORTA, R16 ;Write digit
CALL DELAY
LDI R16, five //5 for seven seg
OUT PORTA, R16 ;Write digit
CALL DELAY
LDI R16, five //5 for seven seg
OUT PORTA, R16 ;Write digit
CALL DELAY
ret

HELLO:
LDI R16, H //H for seven seg
OUT PORTA, R16 ;Write digit
CALL DELAY
LDI R16, E //E for seven seg
OUT PORTA, R16 ;Write digit
CALL DELAY
LDI R16, L //L for seven seg
OUT PORTA, R16 ;Write digit
CALL DELAY
LDI R16, L //L for seven seg
OUT PORTA, R16 ;Write digit
CALL DELAY
LDI R16, O //O for seven seg
OUT PORTA, R16 ;Write digit
CALL DELAY
ret
;---------------APPROXIMATE .5 SECOND DELAY
DELAY:// Label for delay function

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

