;
; AssemblerApplication15.asm
;
; Created: 2/17/2021 3:15:17 PM
; Author : KhaiNguyen
;

/*
//LED 0 Blinking - PortA&B connected
LDI R16,HIGH(RAMEND)
OUT SPH,R16
LDI R16,LOW(RAMEND)
OUT SPL,R16

LDI R20, 0xFF
OUT DDRA, R20	;make PORTA an output port

HERE:
SBI PORTA,0		;set bit PA0 --> set = 1s
CALL DELAY		;DELAY before next one

CBI PORTA,0		;turn on PA1
CALL DELAY		;DELAY before next one
RJMP HERE

//0.15 seconds time delay
DELAY: LDI R20,64			; 64 for 1 sec
	L1: LDI R21, 200
	L2: LDI R22, 250		;  250 - 0.5 sec
	L3: NOP
		NOP
		DEC R22
		BRNE L3
		DEC R21
		BRNE L2
		DEC R20
		BRNE L1
	RET
*/


/*
Write code so that when switch PB0 is closed a binary 0 is sent to LEDs and no LEDs are
on, when LEDs switch PB1 is closed a binary 1 is displayed on LEDs, when LEDs
switch PB2 is closed a binary 2 is displayed on LEDs, when switch PB3 is closed a
binary 3 is displayed on LEDs, keep doing all the way up to when PB7 is closed a binary
7 is displayed on the LEDs.
• Note: Operate the switches one at a time. 
*/

// Activity 3 Part1 - PortA&B not connected
ldi r16, 0x00
out ddrb,r16		; make portb an input --> need to activate pullup resistors
ldi r16, 0xFF
out ddra, r16		; make porta an output
out portb, r16		; activate portb pullup resistors
ldi r16, 0x00
ldi r17, 0x01
ldi r18, 0x02
ldi r19, 0x03 ;.... r20-24 for 0x04 - 0x07
ldi r20, 0x04
ldi r21, 0x05
ldi r22, 0x06
ldi r23, 0x07
mainloop:
	sbis pinb,0				; skip if bit 0 is set
	out porta, r16			; send out 

	sbis pinb,1				; skip if bit 1 is set
	out porta, r17			; send a "1"
	sbic pinb, 1			; skip if switch open
	out porta, r16

	sbis pinb,2				; skip if bit 2 is set
	out porta, r18			; send a "2"
	sbic pinb, 2			; skip if swithc open
	out porta, r16


	sbis pinb,3 			; skip if bit 3 is set
	out porta, r19			; send a "3"
	sbic pinb, 3			; skip if switch open
	out porta, r16

	sbis pinb,4 			; skip if bit 4 is set
	out porta, r20			; send a "4"
	sbic pinb,4				; skip if switch open
	out porta, r16

	sbis pinb,5 			; skip if bit 5 is set
	out porta, r21			; send a "5"
	sbic pinb,5				; skip if switch open
	out porta, r16

	sbis pinb,6 			; skip if bit 6 is set
	out porta, r22			; send a "6"
	sbic pinb,6				; skip if switch open
	out porta, r16

	sbis pinb,7 			; skip if bit 7 is set
	out porta, r23			; send a "7"
	sbic pinb,7				; skip if swithc open
	out porta, r16

	rjmp mainloop



// Activity 3 Part2 - PortA&B not connected
/*
• Write assembly code so that when switch on PB0 is closed (PB0=0) and PB1 is open
(PB1=1), the LEDs sequentially light up starting at PA0 through PA7. In the same code
when switch on PB0 is open (PB0=1) and PB1 is closed (PB1=0), the LEDs sequentially
light up starting at PA7 through PA0.
• Use a subroutine for a 0.5 second DELAY between sequentially turning on the LEDs.
• The LEDs must be turned off when PB0 and PB1 are both open, or closed.
*/
/*
ldi r16, 0x00
out ddrb,r16		; make portb an input --> need to activate pullup resistors
ldi r16, 0xFF		
out ddra, r16		; make porta an output
out portb, r16		; activate portb pullup resistors

ldi r16, 0x00		; store 0x00 for outputing to portA when both switches at same position

mainloop:
	sbis pinb,0				; switch 0 = 0
	call forward			; examine 1 - ON forward / OFF

	sbic pinb,0				; switch 0 = 1
	call backward			; examine 1 - ON backward / OFF
	rjmp mainloop

//------------------------------
forward:
	sbic pinb,1				; switch 1 = 1 
	call turnforward		; subroutine turn ON led forward
				
	sbis pinb,1				; switch 1 = 0
	out porta, r16			; 0x00
	ret
		
	turnforward: 
		SBI porta, 0
		CALL DELAY
		SBI porta, 1
		CALL DELAY
		SBI porta, 2
		CALL DELAY
		SBI porta, 3
		CALL DELAY
		SBI porta, 4
		CALL DELAY
		SBI porta, 5
		CALL DELAY
		SBI porta, 6
		CALL DELAY
		SBI porta, 7
		ret

backward:
	sbis pinb,1			; switch 1 = 0
	call turnbackward	; subroutine turn ON led backward
				
	sbic pinb,1			; switch 1 = 1
	out porta, r16		; 0x00
	ret
		
	turnbackward: 
		SBI porta, 7
		CALL DELAY
		SBI porta, 6
		CALL DELAY
		SBI porta, 5
		CALL DELAY
		SBI porta, 4
		CALL DELAY
		SBI porta, 3
		CALL DELAY
		SBI porta, 2
		CALL DELAY
		SBI porta, 1
		CALL DELAY
		SBI porta, 0
		ret
	
// -----------------Delay block------------------
DELAY:					; 0.5 sec
	ldi r20,32
	L1: LDI R21, 200
		L2: LDI R22, 250
			L3: NOP
				NOP
				DEC R22
				BRNE L3
			DEC R21
			BRNE L2
		DEC R20
		BRNE L1
	RET
	
*/