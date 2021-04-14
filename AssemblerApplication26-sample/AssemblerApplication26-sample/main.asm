;
; AssemblerApplication26-sample.asm
;
; Created: 4/8/2021 6:37:54 PM
; Author : Khai Nguyen
;


LDI  R20,0xFF ;R20 = 0xFF
OUT  DDRB,R20  ;DDRA = R20 (Port B output)
LDI R20, 0x95
LDI R21, 0xAA
EOR R20, R21
OUT PORTB, R20

.ORG 0x01A0
DAT_1: .DB "Go Owls"