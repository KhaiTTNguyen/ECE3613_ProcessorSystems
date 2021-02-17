;
; AssemblerApplication14.asm
;
; Created: 2/17/2021 11:04:52 AM
; Author : KhaiNguyen
;

ldi r16, 0xFF
out ddra,r16			; set porta as output
out ddrd,r16			; set portd as output
ldi r17, 0x55
out portd, r17			; sent out data to portd

ldi r18, 0x00
out ddrd, r18			; make portd input
L1:
	in r16, pind		; read in from D
	out porta, r16		; output to A
	rjump L1