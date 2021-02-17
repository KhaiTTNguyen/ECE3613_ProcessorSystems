;
; AssemblerApplication14.asm
;
; Created: 2/17/2021 11:04:52 AM
; Author : KhaiNguyen
;

/*
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
	rjmp L1

	// once portD output, input pin also got same value (due to circuit config)
	*/

ldi r16, 0xFF
out ddra, r16			; make portA input
out portb, r16			; activate all pullups resistors on//close switches

ldi r16, 0x00			
out ddrb, r16			; make B input port
L2: 
	in r16, pinb		; input from pinB	// use PIN --> must firist activate pull up resistors
	out porta, r16		; send to porta LEDs	-- > output also send same data to input
	rjmp L2

