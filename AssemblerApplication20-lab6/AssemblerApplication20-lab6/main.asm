;
; AssemblerApplication20-lab6.asm
;
; Created: 3/3/2021 3:08:12 PM
; Author : KhaiNguyen
;
/*

ldi r16,0x00		; load 0x00 to r16, prepare to set input ports
out ddra, r16		; set porta as input
out ddrb, r16		; set portb as input
ldi r16, 0xFF		; load 0xFF to r16, prepare to set input ports
out ddrc, r16		; set portc as output
out ddrd, r16		; set portd as output

; setup I/O
in r17, pina		; take input from porta	- $7a
in r18, pinb		; take input from porta - $9

ldi r19, 4			; load 4 to r19 prepare for arithmetic ops
add r17, r19		; add r19 to porta input
mul r17, r18		; mult r17 & r18 - results stored in r1 & r0 

out portc, r1		; higerbyte
out portd, r0		; lowerbyte

*/

// Act 2
// infinite loop
// 0.5sec ON, 0.25 OFF

;---------------set up digits
.equ ONE=0b00000110
.equ TWO=0b01011011
.equ THREE=0b01001111
.equ FOUR=0b01100110
.equ FIVE=0b01101101
.equ SIX=0b01111100
.equ SEVEN=0b0000111
.equ EIGHT=0b01111111
.equ NINE=0b01100111
.equ ZERO=0b00111111

LDI R16, 0xFF
OUT DDRA, R16 ;make Port A an output port
OUT PORTB, R16; activate pullups
ldi r17, 0x00
out ddrb, r17

// READ PINB & OUTPUT PORTA w/ time delay
clr r16
ldi r24, 0x00

read:
	in R16, PINB		; read pinb to r16
	cpi r16, 0x00		; 0x01 = 0b00000000 - 0
	breq R0_out			; output to 7seg w/ ZERO
	cpi r16, 0x01		; 0x01 = 0b00000001 - 1
	breq R1_out			; output to 7seg w/ ONE
	cpi r16, 0x02		; 0x02 = 0b00000010 - 2       
	breq R2_out			; output to 7seg w/ TWO
	cpi r16, 0x03		; 0x03 = 0b00000011 - 3
	breq R3_out			; output to 7seg w/ THREE
	cpi r16, 0x04		; 0x04 = 0b00000100 - 4
	breq R4_out			; output to 7seg w/ FOUR
	cpi r16, 0x05		; 0x05 = 0b00000101 - 5
	breq R5_out			; output to 7seg w/ FIVE
	cpi r16, 0x06		; 0x06 = 0b00000110 - 6 
	breq R6_out			; output to 7seg w/ SIX
	cpi r16, 0x07		; 0x07 = 0b00000111 - 7
	breq R7_out			; output to 7seg w/ SEVEN
	cpi r16, 0x08		; 0x08 - 0b00001000 - 8
	breq R8_out			; output to 7seg w/ EIGHT
	cpi r16, 0x09		; 0x09 - 0b00001000 - 9
	breq R9_out			; output to 7seg w/ NINE
	rjmp read

R0_out:
	out porta, ZERO
	call Delay_P5sec
	out porta, r24
	call Delay_P25sec
	rjmp read

R1_out:
	out porta, ONE
	call Delay_P5sec
	out porta, r24
	call Delay_P25sec
	rjmp read

R2_out:
	out porta, TWO
	call Delay_P5sec
	out porta, r24
	call Delay_P25sec
	rjmp read

R3_out:
	out porta, THREE
	call Delay_P5sec
	out porta, r24
	call Delay_P25sec
	rjmp read

R4_out:
	out porta, FOUR
	call Delay_P5sec
	out porta, r24
	call Delay_P25sec
	rjmp read

R5_out:
	out porta, FIVE
	call Delay_P5sec
	out porta, r24
	call Delay_P25sec
	rjmp read

R6_out:
	out porta, SIX
	call Delay_P5sec
	out porta, r24
	call Delay_P25sec
	rjmp read

R7_out:
	out porta, SEVEN
	call Delay_P5sec
	out porta, r24
	call Delay_P25sec
	rjmp read

R8_out:
	out porta, EIGHT
	call Delay_P5sec
	out porta, r24
	call Delay_P25sec
	rjmp read

R9_out:
	out porta, NINE
	call Delay_P5sec
	out porta, r24
	call Delay_P25sec
	rjmp read
;---------------APPROXIMATE .5 SECOND DELAY
Delay_P5sec:// Label for delay function

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

Delay_P25sec:// Label for delay function

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