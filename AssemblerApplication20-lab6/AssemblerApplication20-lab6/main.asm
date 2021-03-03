;
; AssemblerApplication20-lab6.asm
;
; Created: 3/3/2021 3:08:12 PM
; Author : KhaiNguyen
;

ldi r16,0x00		; load 0x00 to r16, prepare to set input ports
out ddra, r16		; set porta as input
out ddrb, r16		; set portb as input
ldi r16, 0xFF		; load 0xFF to r16, prepare to set input ports
out ddrc, r16		; set portc as output
out ddrd, r16		; set portd as output

; setup I/O
in r17, pina		; take input from porta	- $7a
in r18, pinb		; take input from porta - $9

ldi r19, 4			; laod 4 to r19 prepare for arithmetic ops
add r17, r19		; add r19 to porta input
mul r17, r18		; mult r17 & r18 - results stored in r1 & r0 

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