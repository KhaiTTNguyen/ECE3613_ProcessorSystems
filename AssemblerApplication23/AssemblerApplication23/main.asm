;
; AssemblerApplication23.asm
;
; Created: 3/31/2021 11:21:46 AM
; Author : KhaiNguyen
;


.INCLUDE "M324PBDEF.INC"
LDI R16,HIGH(RAMEND);init stack pointer
OUT SPH,R16
LDI R16,LOW(RAMEND)
OUT SPL,R16
SBI DDRA,5;PA5 as an output
BEGIN:SBI PORTA,5;PA5 = 1
RCALL DELAY
CBI PORTA,5;PA5 = 0
RCALL DELAY
RJMP BEGIN

DELAY:
LDI R20, HIGH(-16000)								; NORMAL mode -- only need to change these
;OUT   TCNT1H,R20 doesn't work must use the STS instruction
STS TCNT1H,R20
LDI R20, LOW(-16000)								; NORMAL mode -- only need to change these
;OUT   TCNT1L,R20 doesn't work must use the STS instruction
STS TCNT1L,R20
LDI R20,0x0
sts 0x0080,r20
;OUT TCCR1A,R20;WGM11:10=00
LDI R20,0x1
sts 0x0081,r20
;OUT TCCR1B,R20;WGM13:12=00,CS=CLK no prescaling
AGAIN:
lds R20,0X0036
;IN R20,TIFR1;read TIFR1
SBRS R20,TOV1;if OCF1A is set skip next instruction
RJMP AGAIN
LDI R20,1<<TOV1
STS 0X0036,R20
;OUTTIFR,R20;clear TOV1 flag
LDI R19,0
sts 0x0080,r19
;OUTTCCR1B,R19;stop timer
sts 0x0081,r19
;OUTTCCR1A,R19;
RET
