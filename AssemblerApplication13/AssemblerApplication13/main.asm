;
; AssemblerApplication13.asm
;
; Created: 2/15/2021 11:19:40 AM
; Author : KhaiNguyen
;

/*
LDI R16,HIGH(RAMEND)
OUT SPH,R16
LDI R16,LOW(RAMEND)
OUT SPL,R16        
LDI R20,15
LDI R21,5
CALL FUNC_NAME
INC  R20
L1:     RJMP  L1
FUNC_NAME:
        ADD  R20,R21
        SUBI  R20,3
CALL SUB_1
NOP
        RET
SUB_1:
PUSH R20
PUSH R21
POP R21
POP R20
RET
*/

/*
.ORG 0
LDI R16,HIGH(RAMEND)  ;load SPH
OUT SPH,R16
LDI R16,LOW(RAMEND)  ;load SPL
OUT SPL,R16
LDI  R20,0xFF ;R20 = 0xFF
OUT  DDRA,R20  ;DDRA = R20 (Port B output)
BACK:
LDI  R16,0x55	;load R16 with 0x55 - lightup
OUT  PORTA,R16  ;send 55H to port A
CALL DELAY		;time delay
LDI  R16,0xAA	;load R16 with 0xAA
OUT  PORTA,R16  ;send 0xAA to port A
CALL DELAY		;time delay
RJMP BACK		;keep doing this indefinitely


DELAY:
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
*/
/*
LDI R20, 200

BACK: LDI R21, 100

HERE: DEC R21

BRNE HERE

DEC R20

BRNE BACK

nop

*/

/*
LDI r16, $3F

LDI r17, $D6

ADD R16, R17

BRCS INVERT ; or BRHS 

BRCC SUBT ;

INVERT:
COM R16
RJMP  EXIT

SUBT:
SUB R16, r17
rjmp EXIT

EXIT: RJMP  EXIT
*/

/*
Write a program to continuously monitor the PB0 and PB3 bits. When both of them are LOW, 
send ASCII ‘L’ to PORTD; otherwise, send ASCII ‘H’ to PORTD. */

/*
cbi ddrb,0
cbi ddrb,3

ldi r16, $ff
out ddrd, r16 ; make portd output
L1:
	sbic pinb,0		; or low, send 'L' = clear = 0
	rjmp L2			; exec if pinb5 high
	IS_LOW:
	ldi r17, 'L'
	out portd, r17
	rjmp L1

L2: 
	sbis pinb,3		; if 3 Low exec next
	rjmp IS_LOW
	ldi r17, 'H'
	out portd, r17
	rjmp L1
nop
*/


cbi ddrb,0

ldi r16, $ff
out ddrd, r16 ; make portd output
out ddra, r16 ; make porta output

L1:
	sbic pinb,0		; or low, send 'L' = clear = 0
	rjmp L2			; exec if pinb0 high
	IS_LOW:
	ldi r17, 'L'
	out portd, r17
	rjmp L1

L2: 
	sbis pinb,0		; if 0 low go back else send 'H' to porta
	rjmp IS_LOW
	ldi r17, 'H'
	out porta, r17
	rjmp L1
nop
