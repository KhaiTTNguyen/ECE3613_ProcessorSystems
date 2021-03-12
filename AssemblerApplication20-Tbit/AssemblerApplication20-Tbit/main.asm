;
; AssemblerApplication20-Tbit.asm
;
; Created: 3/12/2021 11:12:06 AM
; Author : KhaiNguyen
;

/*
A switch is connected to pin PB4. Write a program to get the status of the switch and save it in D3 of internal RAM location Ox200
*/

/*
.EQU MYREG = 0x200
SBI portb,4; set pull-up for portb.4
CBI DDRB,4; set data direction for portb.4
IN R17,PINB; READ IN PINB 
BST R17,4; STORE BIT 4 INTO THE "T" BIT IN SREG
LDI R16,0; CLEAR R17
BLD R16,3; BIT LOAD FROM T-BIT INTO R16 BIT 3
STS MYREG,R16; SEND IT TO SRAM
HERE:JMP HERE
*/
/*
A switch is connected to pin PB7. Using the SBRS instruction, write a program to check the status of the switch and perform the following: 
(a) If switch= 0, send letter 'N' to Port A.
(b) If switch= 1, send letter 'Y' to Port A.

*/
/*
CBI	DDRB,7; SET PIN7 AS AN INPUT PIN
SBI	PORTB,7; ACTIVATE THE PULLUP
	LDI	R16,0xFF
	OUT	DDRA,R16; PORTA IS OUTPUT
AGAIN:
	IN  	R20,PINB; READ IN PINB
	SBRS	R20,7; CHECK PINB.7
	RJMP	OVER
	LDI 	R16,'Y'; IF PINB.7 IS A 1 (HIGH) WE ARE HERE
	OUT 	PORTA,R16
	RJMP	AGAIN
OVER:
	LDI 	R16,'N';IF PINB.7 IS A 0 (LOW) WE ARE HERE
	OUT 	PORTA,R16
	RJMP	AGAIN 
	*/


	/*
	Write a program to see if the internal RAM location $195 contains an even value. If so, send it to Port A. If not, make it even and then send it to Port A.

	*/
/*
	.EQU	MYREG = 0x195 ; FOR SIMULATION PURPOSES LETS MAKE BIT 0 OF 0X0195 A "1"
LDI R16,0X01;
STS MYREG,R16; SEND SIMULATED DATA RO 0X0195
	LDI	R16,0xFF
	OUT	DDRA,R16; PORTA IS AN OUTPUT
AGAIN:
	LDS	R16,MYREG; GO GET BYTE AT 0X0195
	SBRS	R16, 0; SKIP IF BIT 0 IS A "1"
	RJMP	OVER
	CBR	R16,0b00000001; IF BIT 0 IS A "1" THEN CLEAR IS TO A "0"
OVER:
	OUT	PORTA,R16
	JMP	AGAIN 
	*/

.INCLUDE <M324pbDEF.INC>
WAIT: ;wait for last write to finish
SBIC  EECR,EEPE  ;check EEPE to see if last write is finished
RJMP  WAIT  ;wait more
LDI  R18,0  ;load high byte of address to R18
LDI  R17,0x5F  ;load low byte of address to R17
OUT  EEARH, R18  ;load high byte of address to EEARH
OUT  EEARL, R17  ;load low byte of address to EEARL
LDI  R16,'G'  ;load 'G' to R16
OUT  EEDR,R16  ;load R16 to EEPROM Data Register
SBI  EECR,EEMPE  ;set Master Write Enable to one
SBI  EECR,EEPE  ;set Write Enable to one   
 jmp WAIT
