;
; AssemblerApplication26_Counterch9.asm
;
; Created: 4/2/2021 11:31:21 AM
; Author : Khai Nguyen
;


 .INCLUDE "M324PBDEF.INC"
CBI  DDRB,0  ;make T0 (PB0) input
SBI PORTB,0;ACTITATE PULL-UP
LDI  R20,0xff
OUT  DDRA,R20  ;make PORTA output
LDI  R20,0x06
OUT  TCCR0B,R20  ;counter, falling edge
AGAIN:
IN  R20,TCNT0
OUT  PORTA,R20  ;PORTD = TCNT0
IN  R16,TIFR0
SBRS R16,TOV0  ;monitor TOV0 flag
RJMP AGAIN ;keep doing if Timer0 flag is low
LDI  R16,1<<TOV0
OUT  TIFR0, R16  ;clear TOV0 flag
RJMP AGAIN ;keep doing it
