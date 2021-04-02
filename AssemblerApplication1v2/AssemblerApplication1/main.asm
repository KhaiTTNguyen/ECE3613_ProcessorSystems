;
; AssemblerApplication1.asm
;
; Created: 3/31/2021 3:18:21 PM
; Author : Khai Nguyen
;

/*
BEGIN:LDI R20,0xB1
OUT TCNT0,R20;load timer0
LDI R20,0x05
OUT TCCR0B,R20 ;Timer0,Normal mode,int clk prescale 1024
LDI R16,0xFF
OUT DDRA,R16
AGAIN:IN R20,TIFR0;read TIFR
SBRS R20,0 ;Skip if Bit in Register is set if TOV0 is set skip next inst.

RJMP AGAIN
LDI R20,0x0
OUT TCCR0B,R20;stop Timer0
LDI R20,(1<<TOV0);R20 = 0x01
OUT TIFR0,R20;clear TOV0 flag 
EOR R17,R16;toggle A5 of R17
OUT PORTA,R17;toggle PA5
RJMP BEGIN
*/
call Delay_P5sec
end: rjmp end

Delay_P5sec:
ldi r23,192
L1: LDI R21, 200
L2: LDI R22, 250
L3: NOP
NOP
DEC R22
BRNE L3
DEC R21
BRNE L2
DEC R23
BRNE L1
RET