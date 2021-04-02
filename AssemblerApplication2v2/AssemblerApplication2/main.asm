;
; AssemblerApplication2.asm
;
; Created: 3/31/2021 3:24:14 PM
; Author : Khai Nguyen
;

 
// ACTIVITY 3 
BEGIN:
LDI R17,0b00100000			; turn ON P?5
OUT PORTA,R17				; output to PORTA

LDI R20,0x8B				; calculation for 7.5 ms time frame
OUT TCNT0,R20				; load timer0
LDI R20,0x05
OUT TCCR0B,R20				; Timer0,Normal mode,int clk prescale 1024
LDI R16,0xFF
OUT DDRA,R16
AGAIN:IN R20,TIFR0			; read TIFR
SBRS R20,0					; Skip if Bit in Register is set if TOV0 is set skip next inst.
RJMP AGAIN

LDI R20,0x0
OUT TCCR0B,R20				; stop Timer0
LDI R20,(1<<TOV0)			; R20 = 0x01
OUT TIFR0,R20				; clear TOV0 flag 

; ----------------- OFF for 2.5ms -----------------
LDI R17,0b00000000			; turn OFF P?5
OUT PORTA,R17				; output to PORTA

LDI R20,0xD8				; calculation for 2.5 ms time frame
OUT TCNT0,R20				; load timer0
LDI R20,0x05
OUT TCCR0B,R20				;Timer0,Normal mode,int clk prescale 1024
LDI R16,0xFF
OUT DDRA,R16
AGAIN2P5:IN R20,TIFR0			;read TIFR
SBRS R20,0					;Skip if Bit in Register is set if TOV0 is set skip next inst.
RJMP AGAIN2P5

LDI R20,0x0
OUT TCCR0B,R20				;stop Timer0
LDI R20,(1<<TOV0)			;R20 = 0x01
OUT TIFR0,R20				;clear TOV0 flag 

RJMP BEGIN

/*
// ACTIVITY 4
.INCLUDE "M324PBDEF.INC"
#define F_CPU 16000000UL
LDI R16,HIGH(RAMEND);init stack pointer
OUT SPH,R16
LDI R16,LOW(RAMEND)
OUT SPL,R16
SBI DDRD,2;PD2 as an output

BEGIN:
	call clockwise_loop
	call stop
	call counter_clockwise_loop
	call stop
JMP BEGIN

//=========================wave pulse with 3sec duration======================
clockwise_loop:
	ldi R23,141					//LDI R20, 141 ; 3sec/(1.3+20)ms = 140 loop iterations
	L1:
		SBI PORTD,2				;PD2 = 1 
		RCALL DELAY_1point3ms
		CBI PORTD,2				;PD2 = 0
		RCALL DELAY_20ms
	DEC R23
	BRNE L1
	RET

stop:
	ldi R23,139					//LDI R20, 139 ; 3sec/(1.5+20)ms = 139 loop iterations
	L1_stop:	
		SBI PORTD,2				;PD2 = 1 
		RCALL DELAY_1point5ms
		CBI PORTD,2				;PD2 = 0
		RCALL DELAY_20ms
	DEC R23
	BRNE L1_stop
	RET

counter_clockwise_loop:
	ldi R23,138				//LDI R20, 138 ; 3sec/(1.7+20)ms = 138 loop iterations
	L1_counter:
		SBI PORTD,2				;PD2 = 1 
		RCALL DELAY_1point7ms
		CBI PORTD,2				;PD2 = 0
		RCALL DELAY_20ms
	DEC R23
	BRNE L1_counter
	RET
//==============================Motor Wave pulses=================================
//--------------DELAY 1.3ms---------------
DELAY_1point3ms:
LDI R20,0xAE
STS 0X0085,R20
;OUTTCNT1H,R20;TEMP = 0xD8
LDI R20,0xBF
STS 0X0084,R20
;OUTTCNT1L,R20;TCNT1L = 0xF0, TCNT1H = TEMP
LDI R20,0x0
sts 0x0080,r20
;OUTTCCR1A,R20;WGM11:10=00
LDI R20,0x1
sts 0x0081,r20
;OUTTCCR1B,R20;WGM13:12=00,CS=CLK
AGAIN13:
lds R20,0X0036
;IN R20,TIFR1;read TIFR1
SBRS R20,TOV1;if OCF1A is set skip next instruction
RJMP AGAIN13
LDI R20,1<<TOV1
STS 0X0036,R20
;OUTTIFR,R20;clear TOV1 flag 
LDI R19,0
sts 0x0080,r19
;OUTTCCR1B,R19;stop timer
sts 0x0081,r19
;OUTTCCR1A,R19;
RET

// ----------DELAY 1.5ms-----------
DELAY_1point5ms:
LDI R20,0xA2
STS 0X0085,R20
;OUTTCNT1H,R20;TEMP = 0xD8
LDI R20,0x3F
STS 0X0084,R20
;OUTTCNT1L,R20;TCNT1L = 0xF0, TCNT1H = TEMP
LDI R20,0x0
sts 0x0080,r20
;OUTTCCR1A,R20;WGM11:10=00
LDI R20,0x1
sts 0x0081,r20
;OUTTCCR1B,R20;WGM13:12=00,CS=CLK
AGAIN15:
lds R20,0X0036
;IN R20,TIFR1;read TIFR1
SBRS R20,TOV1;if OCF1A is set skip next instruction
RJMP AGAIN15
LDI R20,1<<TOV1
STS 0X0036,R20
;OUTTIFR,R20;clear TOV1 flag 
LDI R19,0
sts 0x0080,r19
;OUTTCCR1B,R19;stop timer
sts 0x0081,r19
;OUTTCCR1A,R19;
RET

// ----------DELAY 1.7ms-----------
DELAY_1point7ms:
LDI R20,0x95
STS 0X0085,R20
;OUTTCNT1H,R20;TEMP = 0xD8
LDI R20,0xBF
STS 0X0084,R20
;OUTTCNT1L,R20;TCNT1L = 0xF0, TCNT1H = TEMP
LDI R20,0x0
sts 0x0080,r20
;OUTTCCR1A,R20;WGM11:10=00
LDI R20,0x1
sts 0x0081,r20
;OUTTCCR1B,R20;WGM13:12=00,CS=CLK
AGAIN17:
lds R20,0X0036
;IN R20,TIFR1;read TIFR1
SBRS R20,TOV1;if OCF1A is set skip next instruction
RJMP AGAIN17
LDI R20,1<<TOV1
STS 0X0036,R20
;OUTTIFR,R20;clear TOV1 flag 
LDI R19,0
sts 0x0080,r19
;OUTTCCR1B,R19;stop timer
sts 0x0081,r19
;OUTTCCR1A,R19;
RET

//-----------DELAY 20ms------------
DELAY_20ms:
LDI R20,0xEC
STS 0X0085,R20
;OUTTCNT1H,R20;TEMP = 0xD8
LDI R20,0x77
STS 0X0084,R20
;OUTTCNT1L,R20;TCNT1L = 0xF0, TCNT1H = TEMP
LDI R20,0x0
sts 0x0080,r20
;OUTTCCR1A,R20;WGM11:10=00
LDI R20,0x03
sts 0x0081,r20
;OUTTCCR1B,R20;WGM13:12=00,CS=CLK
AGAIN2:
lds R20,0X0036
;IN R20,TIFR1;read TIFR1
SBRS R20,TOV1;if OCF1A is set skip next instruction
RJMP AGAIN2
LDI R20,1<<TOV1
STS 0X0036,R20
;OUTTIFR,R20;clear TOV1 flag 
LDI R19,0
sts 0x0080,r19
;OUTTCCR1B,R19;stop timer
sts 0x0081,r19
;OUTTCCR1A,R19;
RET
