;
; AssemblerApplication21.asm
;
; Created: 3/17/2021 3:47:18 PM
; Author : KhaiNguyen
;

//Initializing the Z pointerLDI ZH,HIGH(DataSet1<<1) ;higher byte of the address, 0x0200LDI ZL,LOW(DataSet1<<1)  ;lower byte of the address, 0x0200LDI XH,HIGH(0x0100); higher byte of the address, 0x0100LDI XL,LOW(0x0100); lower byte of the address, 0x0100LDI R17,4 	; counter//Retrieve the data from the program memoryMain: 	LPM R16,Z+	ST X+,R16	DEC R17BRNE MainNOP//Initializing the Z pointerLDI ZH,HIGH(DataSet2<<1) ;higher byte of the address, 0x0200LDI ZL,LOW(DataSet2<<1)  ;lower byte of the address, 0x0200LDI XH,HIGH(0x0200); higher byte of the address, 0x0200LDI XL,LOW(0x0200); lower byte of the address, 0x0200LDI R17,6 	; counter//Retrieve the data from the program memoryMain1: 	LPM R16,Z+	ST X+,R16	DEC R17BRNE Main1NOP//ASCII letter A, B, C in the program memory location 0x100 (physical address: 0x200).ORG 0x0100DataSet1: .DB 0x44, 0xB2, 0x73, 0x0FDataSet2: .DB 'T','E','M','P','L','E'DataSet3: .DB "Engr"



// ACTIVITY 2
LDI r16, 0xFF
OUT DDRA, R16

// SETUP POINTERS
LDI ZH,HIGH(0x0300) ;higher byte of the address, 0x0200LDI ZL,LOW(LASTNAME<<1)  ;lower byte of the address, 0x0200LDI XH,HIGH(0x0100); higher byte of the address, 0x0100LDI XL,LOW(0x0100); lower byte of the address, 0x0100LDI R17, 6// counterMAIN4:WAIT:
; wait for the last write to finish
SBIC EECR, EEPE ;check EEPE to see if the last write is finished
RJMP WAIT ;wait more
LDI R18,0x01 ;load a high byte of address to R18
LDI R17,0x00 ;load a low byte of address to R17
OUT EEARH, R18 ;load a high byte of address to EEARH
OUT EEARL, R17 ;load a low byte of address to EEARL
LDI R16,'G' ;load 'G' to R16
OUT EEDR,R16 ;load R16 to EEPROM Data Register
SBI EECR,EEMPE ;set Master Write Enable to one
SBI EECR,EEPE ;set Write Enable to one
SBI EECR,EERE ;set Read Enable to one
IN R16,EEDR ;load EEPROM Data Register to R16
OUT PORTA,R16 ;out R16 to PORTA
HERE: JMP HERE.ORG (0x0300>>1)LASTNAME: .DB "NGUYEN"