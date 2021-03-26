;
; AssemblerApplication22.asm
;
; Created: 3/26/2021 11:10:08 AM
; Author : KhaiNguyen
;


;.INCLUDE "M324pbDEF.INC"
/*
LDI R16,0xFF
OUT DDRA,R16
LDI R16,0X20
BEGIN:
LDI R20,-160
OUT TCNT0,R20;load timer0
LDI R20,0x01
OUT TCCR0B,R20 ;Timer0,Normal mode, no prescaler

AGAIN:IN R20,TIFR0			;read TIFR
SBRS R20,0					;Skip if Bit in Register is set if TOV0 is set skip next inst.

RJMP AGAIN
LDI R20,0x0
OUT TCCR0B,R20;stop Timer0
LDI R20,(1<<TOV0);R20 = 0x01
OUT TIFR0,R20;clear TOV0 flag 
EOR R17,R16;toggle A5 of R17
OUT PORTA,R17;toggle PA5
RJMP BEGIN
*/



/*
LDI R16,0xFF
OUT DDRA,R16
LDI R16,0X20
BEGIN:
LDI R20,-40
OUT TCNT0,R20;load timer0
LDI R20,0x02
OUT TCCR0B,R20 ;Timer0,Normal mode, prescaler = 8

AGAIN:IN R20,TIFR0			;read TIFR
SBRS R20,0					;Skip if Bit in Register is set if TOV0 is set skip next inst.

RJMP AGAIN
LDI R20,0x0
OUT TCCR0B,R20;stop Timer0
LDI R20,(1<<TOV0);R20 = 0x01
OUT TIFR0,R20;clear TOV0 flag 
EOR R17,R16;toggle A5 of R17
OUT PORTA,R17;toggle PA5
RJMP BEGIN
*/


LDI R16,0xFF
OUT DDRA,R16
LDI R16,0X20
BEGIN:
LDI R20,-62
OUT TCNT0,R20;load timer0
LDI R20,0x04
OUT TCCR0B,R20 ;Timer0,Normal mode, prescaler = 256

AGAIN:IN R20,TIFR0			;read TIFR
SBRS R20,0					;Skip if Bit in Register is set if TOV0 is set skip next inst.

RJMP AGAIN
LDI R20,0x0
OUT TCCR0B,R20;stop Timer0
LDI R20,(1<<TOV0);R20 = 0x01
OUT TIFR0,R20;clear TOV0 flag 
EOR R17,R16;toggle A5 of R17
OUT PORTA,R17;toggle PA5
RJMP BEGIN

