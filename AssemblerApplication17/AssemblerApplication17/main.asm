;
; AssemblerApplication17.asm
;
; Created: 2/24/2021 3:17:50 PM
; Author : KhaiNguyen
;
//------------------------------------Activity1--------------------------
;1 setup stack pointer
LDI R16,HIGH(0x0110)	;Set high byte of address for SP
OUT SPH,R16
LDI R16,LOW(0x0110)		;Set low byte of address for SP
OUT SPL,R16

LDI R16,$77
LDI R17,$19
LDI R18,$A2
LDI R19,$08
LDI R20,$6C
LDI R21,$30
LDI R22,$F2

//PUSH values in the STACK
PUSH R16
PUSH R17
PUSH R18
PUSH R19
PUSH R20
PUSH R21
PUSH R22

//POP values from the STACK
POP R22
POP R21
POP R20
POP R19
POP R18
POP R17
POP R16

;2. I/O configuration
LDI R23,$FF
OUT DDRB,R23	;PORTB IS OUTPUT PORT
OUT DDRA,R23	;PORTA IS OUTPUT PORT

ADD R16, R17	; add $77 + $19 
SUB R16, R18	; sub ($77 + $19)-$A2
OUT PORTA, r16
BRCS OUT_B

OUT_B:
	LDI r23, 0b00000001		; to output to portB
	out portb, r23
	ret
/*

//------------------------------------Activity2--------------------------
; PART 1
;1 Assign Directives
.EQU num1=0X100	//set num1=0x100 (address)
.EQU num2=0X101	//set num2=0x101 (address)
.EQU num3=0X102	//set num3=0x102 (address)
.EQU num4=0X103	//set num4=0x103 (address)
.EQU num5=0X104	//set num5=0x104 (address)

;2 load numbers & results to GPRs
LDI R16,$62				; load $62 to R16
LDI R17,$C1+$07			; load $C1+$07 to r17
LDI R18, 0b10100011
LDI R19,240
LDI R20, $AD-$29

;3 Store to mem location w/ directives
STS num1,R16			; store $62 to 0x100
STS num2,R17			; store $C1+$07 to 0x101
STS num3,R18
STS num4,R19
STS num5,R20

// PART 2 
;1 Load value from mem to REG 1-5
LDS r1, num1			; load results from num1 to r1
LDS r2, num2			; load results from num2 to r2
LDS r3, num3			; load results from num3 to r3
LDS r4, num4			; load results from num4 to r4
LDS r5, num5			; load results from num5 to r5

;2 I/O configuration: setup porta as output & portb as input
LDI R16,$00
LDI R17,$FF
OUT DDRB,R16			; PORTB as INPUT PORT
OUT PORTB,R17			; SET UP PULL-UP REGISTER
OUT DDRA,R17			; PORTA as OUTPUT PORT

// READ PINB & OUTPUT PORTA w/ time delay
clr r16
ldi r24, 0x00

read:
	in R16, PINB		; read pinb to r16
	cpi r16, 0x7F		; 0x7F = 0b01111111
	breq R1_out			; output to porta w/ value in R1
	cpi r16, 0xBF		; 0xBF = 0b10111111
	breq R2_out			; output to porta w/ value in R2
	cpi r16, 0xDF		; 0xDF = 0b11011111
	breq R3_out			; output to porta w/ value in R3
	cpi r16, 0xEF		; 0xEF = 0b11101111
	breq R4_out			; output to porta w/ value in R4
	cpi r16, 0xF7		; 0xF7 = 0b11110111
	breq R5_out			; output to porta w/ value in R5
	rjmp read

R1_out:
	out porta, r1
	call Delay_P15sec
	out porta, r24
	call Delay_P15sec
	rjmp read

R2_out:
	out porta, r2
	call Delay_P3sec
	out porta, r24
	call Delay_P3sec
	rjmp read

R3_out:
	out porta, r3
	call Delay_P5sec
	out porta, r24
	call Delay_P5sec
	rjmp read

R4_out:
	out porta, r4
	call Delay_1sec
	out porta, r24
	call Delay_1sec
	rjmp read

R5_out:
	out porta, r5
	call Delay_1P5sec
	out porta, r24
	call Delay_1P5sec
	rjmp read

/// TIME DELAY options
Delay_P15sec:	
	LDI R20,32
	L1_P15: LDI R21, 200
		L2_P15: LDI R22, 75
			L3_P15:NOP
				NOP
				DEC R22
				BRNE L3_P15
			DEC R21
			BRNE L2_P15
		DEC R20
		BRNE L1_P15
RET


Delay_P3sec:	
	LDI R20,32
	L1_P3: LDI R21, 200
		L2_P3: LDI R22, 150
			L3_P3:NOP
				NOP
				DEC R22
				BRNE L3_P3
			DEC R21
			BRNE L2_P3
		DEC R20
		BRNE L1_P3
RET


Delay_P5sec:	
	LDI R20,32
	L1_P5: LDI R21, 200
		L2_P5: LDI R22, 250
			L3_P5:NOP
				NOP
				DEC R22
				BRNE L3_P5
			DEC R21
			BRNE L2_P5
		DEC R20
		BRNE L1_P5
RET

Delay_1sec:	
	LDI R20,64
	L1_1: LDI R21, 200
		L2_1: LDI R22, 250
			L3_1:NOP
				NOP
				DEC R22
				BRNE L3_1
			DEC R21
			BRNE L2_1
		DEC R20
		BRNE L1_1
RET


Delay_1P5sec:	
	LDI R20,96
	L1_1P5: LDI R21, 200
		L2_1P5: LDI R22, 250
			L3_1P5:NOP
				NOP
				DEC R22
				BRNE L3_1P5
			DEC R21
			BRNE L2_1P5
		DEC R20
		BRNE L1_1P5
RET
*/