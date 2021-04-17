;
; AssemblerApplication26-lightsensor.asm
;
; Created: 4/16/2021 11:12:20 AM
; Author : Khai Nguyen
;

.ORG 0 
JMP MAIN
 .ORG 0x04 ; Org the ISR from the Vector Table 0x02 PD2 int0 , 0x04 PD3 int1 in interupt vector table
; INTO is located at 0x02
JMP  EX0_ISR 
  MAIN: 
  LDI R20,HIGH(RAMEND)
  OUT SPH,R20 
  LDI R20,LOW(RAMEND) 
  OUT SPL,R20
  LDI R16,$FF
  OUT DDRA,R16 // output on A
OUT PORTB,R16 
  SBI PORTD,3  // activate input pin for PD3
  CBI DDRD,3 // clear PD3
LDI r21,0
LDI R20,1<<INT1 ; Count Pulses on PD2 (INT0), PD
  OUT EIMSK,R20 
  LDI R20,0X02 ;MAKE int0 0x02 FALLING EDGE TRIGGER--- 0x01 - both rising & falling edge
  STS 0X0069,r20
  ; OUT EICRA,R20
  SEI ; SET THE INTERRUPT ENABLE FLAG 
HERE:
; This is like a while(1) loop
; We can anything here until 
; the ISR is activated
  JMP HERE
  EX0_ISR: 
INC R21
 OUT PORTA,R21 
  RETI

