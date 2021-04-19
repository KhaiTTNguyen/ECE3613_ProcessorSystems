;
; AssemblerApplication26_PinChangeInterrupts.asm
;
; Created: 4/19/2021 11:22:31 AM
; Author : Khai Nguyen
;


.ORG 0 
JMP MAIN
 .ORG 0x0A ; Org the ISR from the Vector Table
;PCINT1 is located at 0x0A
JMP  EX0_ISR 
  MAIN: 
  LDI R20,HIGH(RAMEND)
  OUT SPH,R20 
  LDI R20,LOW(RAMEND) 
  OUT SPL,R20
  LDI R16,$FF
  OUT DDRA,R16
  SBI PORTB,0
  CBI DDRB,0
LDI R20,1<<PCIE1
STS PCICR,r20 ; Unmask PCINT1 in PCICR
LDI R20,1<<PCINT8
STS PCMSK1,r20 ; Unmask PCINT8 in PCIMSK1
SEI ; SET THE INTERRUPT ENABLE FLAG  
HERE:
; This is like a while(1) loop
; We can anything here until 
; the ISR is activated
nop
nop
  JMP HERE
  EX0_ISR: 
 INC R21
 OUT PORTA,R21 
  RETI
