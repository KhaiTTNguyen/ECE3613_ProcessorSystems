;
; AssemblerApplication26_TimerInterrupts.asm
;
; Created: 4/7/2021 11:14:07 AM
; Author : Khai Nguyen
;
/*

.ORG 0x0;location for reset 
JMP MAIN
.ORG 0x24;location for Timer0 oveflow
JMP T0_OV_ISR
;----main program for initialization
.ORG 0x100
MAIN:LDI R20,HIGH(RAMEND)
OUT SPH,R20
LDI R20,LOW(RAMEND)
OUT SPL,R20
;-------------------
LDI R20,$FF
OUT DDRA,R20;output
LDI R20,0
OUT DDRB, R20
LDI R20,0xFF
OUT DDRD, R20
;--------------------
LDI R20,(1<<TOIE0)		// unmasked timer0 NORMAL mode  need this to run interrupts
;OUT TIMSK0,R20; doesn’t work
sts TIMSK0,R20; does work
SEI						// enable the interrupts
LDI R20,-160  ;value for 10µs 
OUT TCNT0,R20					// timer counter
LDI R20,0x01
OUT TCCR0B,R20					// timer control register no pre-scaling
HERE:	IN	R20,PINB	  
	OUT 	PORTA,R20   
	JMP	HERE	
;--------ISR for Timer 0
T0_OV_ISR:			// toggles PORTD & reset timer
IN R16,PORTD
LDI R17,0xFF
EOR R16,R17
OUT PORTD,R16

LDI R20,-160  ;value for 10µs (reset timer)
OUT TCNT0,R20; load for next round
RETI
*/

/*
Using Timer0 and CTC mode generate a 2msec square wave on pin PORTA.5, while at the same time data is being transferred from PORTC to PORTD.
*/

.ORG	0x0	;location for reset 
	JMP	MAIN
.ORG	0x22	;location for Timer0 COMPARE MATCH CTC MODE
	JMP	T0_CM_ISR
;-main program for initialization and keeping CPU busy
.ORG	0x100
MAIN:	LDI	R20,HIGH(RAMEND)
	OUT	SPH,R20
	LDI	R20,LOW(RAMEND)
	OUT	SPL,R20 
	;------------
	LDI	R20,41		
	OUT	OCR0B,R20				;OCR0 = 0x3E
	LDI	R20,0x0B				;use 0x0C CTC mode 256 0x0C 64-0x0B prescaling
	OUT TCCR0B,R20  
	SBI	DDRA,5	     ;PA5 as an output
	LDI	R20,(1<<OCIE0B)			;Timer0 compare match 
	;OUT	TIMSK0,R20 ;doesn't work
	STS 0x006E,R20
	SEI		   ;Set I 	
	LDI	R20,0x00
	OUT	DDRC,R20	   ;make PORTC input
	LDI	R20,0xFF
	OUT	DDRD,R20	   ;make PORTD output
HERE:	IN	R20,PINC	  
	OUT 	PORTD,R20   
	JMP	HERE	
;--------ISR for Timer 0	
T0_CM_ISR:
	IN	R16,PORTA
	LDI	R17,0x20
	EOR	R16,R17
	OUT 	PORTA,R16
LDI R20,0  ;reset TCNT0 
OUT TCNT0,R20; load for next round
RETI
