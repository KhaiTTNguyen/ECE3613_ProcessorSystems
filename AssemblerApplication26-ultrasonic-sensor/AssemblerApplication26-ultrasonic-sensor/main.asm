;
; AssemblerApplication26-ultrasonic-sensor.asm
;
; Created: 4/14/2021 3:16:06 PM
; Author : Khai Nguyen
;
/*
// Act 1
.ORG	0x0	;location for reset 
	JMP	MAIN
.ORG	0x22	;location for Timer0 compare match B from Interrupt vector table
	JMP	T0_CM_ISR
;-main program for initialization and keeping CPU busy
.ORG	0x100
MAIN:	
	LDI	R20,HIGH(RAMEND)
	OUT	SPH,R20
	LDI	R20,LOW(RAMEND)
	OUT	SPL,R20

	LDI	R20,41		
	OUT	OCR0B,R20	     ;OCR0 = 41
	LDI	R20,0x0B;use 0x0B CTC mode 64 prescaling ; 0b00001011
	OUT TCCR0B,R20  
	SBI	DDRA,5	     ;PA5 as an output
	LDI	R20,(1<<OCIE0B) ;Timer0 compare match 
	;OUT	TIMSK0,R20 ;doesn't work
	STS 0x006E,R20
	SEI		   ;Set global interrupt 	
	LDI	R20,0x00
	OUT	DDRB,R20	   ;make PORTB input
	LDI	R20,0xFF
	OUT PORTB,R20
	OUT	DDRD,R20	   ;make PORTD & A output
	OUT DDRA,R20
	HERE:	IN	R20,PINB	  
	OUT 	PORTA,R20   
	JMP	HERE	
;--------ISR for Timer 0	
T0_CM_ISR:
	IN	R16,PORTD
	LDI	R17,0xFF
	EOR	R16,R17
	OUT 	PORTD,R16
LDI R20,0  ;reset TCNT0 
OUT TCNT0,R20; load for next round
RETI
*/

// Act 2

.ORG 0x0;location for reset 
JMP MAIN
.ORG 0x1E;location for Timer1 oveflow - grab from Reset & Interrupt vector table
JMP T1_OV_ISR
;----main program for initialization
MAIN:
.ORG 0x100
LDI R16,HIGH(RAMEND);init stack pointer
OUT SPH,R16
LDI R16,LOW(RAMEND)
OUT SPL,R16
LDI R20,$FF
OUT DDRA,R20;OUTPUT PORT
OUT DDRD,R20;OUTPUT PORT
OUT PORTB,R20;PULLUPS
LDI R20,0
OUT DDRB,R20;INTPUT PORT
//-----------------------------------------------------
;set up Timer1 initialization 
LDI R20,(1<<TOIE1)
;OUT TIMSK0,R20; doesn’t work
sts TIMSK1,R20; does work
LDI R20,HIGH(-7812)  ; -------------------
STS TCNT1H,R20
;OUT TCNT1H,R20;
LDI R20,LOW(-7812)
STS TCNT1L,R20
;OUT TCNT1L,R20; 
LDI R20,0x0
sts TCCR1A,r20			; timer control register
;OUT TCCR1A,R20;WGM11:10=00
LDI R20,5			; prescaling by 1024
sts TCCR1B,r20
;OUT TCCR1B,R20;WGM13:12=00,CS=CLK
SEI						; enable global interrupts
HERE:IN R20,PINB  
OUT PORTA,R20   
JMP HERE

;--------ISR for Timer 0
T1_OV_ISR:
IN R16,PORTD
LDI R17,0xFF
EOR R16,R17
OUT PORTD,R16
LDI R20,HIGH(-7812)
STS TCNT1H,R20
;OUT TCNT1H,R20;TEMP = 0xD8
LDI R20,LOW(-7812)
STS TCNT1L,R20
;OUT TCNT1L,R20;TCNT1L = 0xF0, TCNT1H = TEMP
RETI
