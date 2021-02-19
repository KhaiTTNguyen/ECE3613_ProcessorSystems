;
; pullup_resistors.asm
;
; Created: 2/19/2021 4:11:47 PM
; Author : KhaiNguyen
;


ldi r16, 0xff
out ddra, r16
out portb, r16		; activate portB pullups
cbi ddrb, 0			; make pb0 input
here: sbic pinb, 0	; if closed skip
rjmp here
sbi porta, 0		; set bit 0 porta
cbi porta, 0		; clear bit 0 porta
rjmp here