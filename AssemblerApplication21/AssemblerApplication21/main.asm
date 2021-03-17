;
; AssemblerApplication21.asm
;
; Created: 3/17/2021 3:47:18 PM
; Author : KhaiNguyen
;

/*
// Activity 1
//Initializing the Z pointer
LDI ZH,HIGH(DataSet1<<1) ;higher byte of the address, 0x0200
LDI ZL,LOW(DataSet1<<1)  ;lower byte of the address, 0x0200
LDI XH,HIGH(0x0100); higher byte of the address, 0x0100
LDI XL,LOW(0x0100); lower byte of the address, 0x0100
LDI R17,4 	; counter
//Retrieve the data from the program memory
Main: 	LPM R16,Z+
	ST X+,R16
	DEC R17
BRNE Main
NOP
//Initializing the Z pointer
LDI ZH,HIGH(DataSet2<<1) ;higher byte of the address, 0x0204
LDI ZL,LOW(DataSet2<<1)  ;lower byte of the address, 0x0204
LDI XH,HIGH(0x0200); higher byte of RAM address, 0x0200
LDI XL,LOW(0x0200); lower byte of RAM address, 0x0200
LDI R17,6 	; counter
//Retrieve the data from the program memory
Main1: 	LPM R16,Z+
	ST X+,R16
	DEC R17
BRNE Main1
NOP

//Initializing the Z pointer
LDI ZH,HIGH(DataSet3<<1) ;higher byte of the address
LDI ZL,LOW(DataSet3<<1)  ;lower byte of the address
LDI XH,HIGH(0x0400); higher byte of RAM address, 0x0400
LDI XL,LOW(0x0400); lower byte of RAM address, 0x0400
LDI R17,4 	; counter
//Retrieve the data from the program memory
Main2: 	LPM R16,Z+
	ST X+,R16
	DEC R17
BRNE Main2
NOP
//ASCII letter A, B, C in the program memory location 0x100 (physical address: 0x200)
.ORG 0x0100
DataSet1: .DB 0x44, 0xB2, 0x73, 0x0F
DataSet2: .DB 'T','E','M','P','L','E'
DataSet3: .DB "Engr"

*/

// ACTIVITY 2
/*
Write a code to write your last name set in the flash memory at 0x0300 (physical address), then
copy the data to SRAM location 0x0100 and then send the data from SRAM to EEPROM at the
ACT IV IT Y 3 . LED OP ERAT ION
starting location 0x0010. Read it out of EEPROM and send the hexadecimal value for each letter
in your last name to PORTA with a delay of 0.5sec between each character (fill the name table
provided in the worksheet). Run this in hardware on the 324PB.
*/
LDI R16, 0xFF
OUT DDRA, R16
// SETUP POINTERS
LDI ZH,HIGH(0x0300)			;higher byte of the address, 0x0300
LDI ZL,LOW(LASTNAME<<1)		;lower byte of the address, 0x0300
LDI XH,HIGH(0x0100)			; higher byte of the address, 0x0100
LDI XL,LOW(0x0100)			; lower byte of the address, 0x0100
LDI R17, 6					; counter

//1.COPY TO SRAM starting 0x100
Main3: 	LPM R16,Z+
	ST X+,R16
	DEC R17
BRNE Main3
NOP

//2.SEND FROM SRAM TO EEPROM
// reset X pointer back to 0x100
LDI XH,HIGH(0x0100); higher byte of the address, 0x0100
LDI XL,LOW(0x0100); lower byte of the address, 0x0100
LDI R20, 6

LDI R18,0x00 ;load a high byte of EEPROM address to R18
LDI R17,0x10 ;load a low byte of EEPROM address to R17
LOOP:
	WAIT:			; wait for the last write to finish
	SBIC EECR, EEPE ;check EEPE to see if the last write is finished
	RJMP WAIT		;wait more

OUT EEARH, R18 ;load a high byte of address to EEARH
OUT EEARL, R17 ;load a low byte of address to EEARL

LD R16,X+ ;load NAME to R16

// EEPROM
OUT EEDR,R16 ;load R16 to EEPROM Data Register
SBI EECR,EEMPE ;set Master Write Enable to one
SBI EECR,EEPE ;set Write Enable to one
//SBI EECR,EERE ;set Read Enable to one
//IN R16,EEDR ;load EEPROM Data Register to R16

//4. SEND TO PORTA
OUT PORTA,R16 ;out R16 to PORTA
CALL DELAY
INC R17
DEC R20
BRNE LOOP
HERE: JMP HERE

.ORG (0x0300>>1)
LASTNAME: .DB "NGUYEN"

;---------------APPROXIMATE .5 SECOND DELAY
DELAY:// Label for delay function

ldi r23,32
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