;
; AssemblerApplication20-lab6.asm
;
; Created: 3/3/2021 3:08:12 PM
; Author : KhaiNguyen
;

ldi r16,0x00
out ddra, r16
out ddrb, r16
ldi r16, 0xff
out ddrc, r16
out ddrd, r16

; setup I/O
in r17, pina
in r18, pinb

ldi r19, 4
add r17, r19
mul r17, r18

out portc, r1		; higerbyte
out portd, r0		; lowerbyte


/*
// Act 2
// infinite loop
// 0.5sec ON, 0.25 OFF

// 0000 - all 4 closed 



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
LDI R16, HIGH(RAMEND)
OUT SPH, R16
LDI R16, LOW(RAMEND)
OUT SPL, R16 ;initialize stack pointer

LDI R16, 0xFF
OUT DDRA, R16 ;make Port A an output port
OUT PORTB, R16; activate pullups
ldi r17, 0x00
out ddrb, r17

main:

;---------------set up digits


;---------------APPROXIMATE .5 SECOND DELAY
DELAY_P5:// Label for delay function

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

DELAY_P25:// Label for delay function

ldi r20,16
L1_25: LDI R21, 200
L2_25: LDI R22, 250
L3_25: NOP
NOP
DEC R22
BRNE L3_25
DEC R21
BRNE L2_25
DEC R20
BRNE L1_25
RET
*/