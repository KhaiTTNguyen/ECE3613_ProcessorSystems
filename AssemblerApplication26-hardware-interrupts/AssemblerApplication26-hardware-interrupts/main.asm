;
; AssemblerApplication26-hardware-interrupts.asm
;
; Created: 4/14/2021 11:36:08 AM
; Author : Khai Nguyen
;

.ORG 0 
JMP MAIN
 .ORG 0x02 ; Org the ISR from the Vector Table
; INTO is located at 0x02
JMP  EX0_ISR 
  MAIN: 
  LDI R20,HIGH(RAMEND)
  OUT SPH,R20 
  LDI R20,LOW(RAMEND) 
  OUT SPL,R20
  LDI R16,$FF
  OUT DDRA,R16
OUT PORTB,R16
  SBI PORTD,2
  CBI DDRD,2
LDI r21,0
LDI R20,1<<INT0
  OUT EIMSK,R20 
  LDI R20,0X02 ;MAKE int0 FALLING EDGE TRIGGER
  STS 0X0069,r20
  ; OUT EICRA,R20
  SEI ; SET THE INTERRUPT ENABLE FLAG <-----------------
HERE:
; This is like a while(1) loop
; We can anything here until 
; the ISR is activated
  JMP HERE
  EX0_ISR: 
INC R21
 OUT PORTA,R21 
  RETI
