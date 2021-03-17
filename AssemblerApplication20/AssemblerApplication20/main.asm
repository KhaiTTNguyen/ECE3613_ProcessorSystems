;
; AssemblerApplication20.asm
;
; Created: 3/17/2021 3:10:32 PM
; Author : KhaiNguyen
;
/*
LDI ZH, HIGH (DataSet1<<1)
LDI ZH, HIGH (DataSet1<<1)
LDI XH, HIGH (0x0100)
LDI XH, LOW (0x0100)
LDI R17,4							; counter

MAIN: LPM R16, Z+
ST X+, R16
DEC R17
BRNE MAIN
NOP 

.ORG 0x100
DataSet1: .DB $44, $B2, $73, $0F
DataSet2: .DB 'T','E','M','P','L','E'
DataSet3: .DB "Engr"


LDI ZH, HIGH (DataSet2<<1)
LDI ZH, HIGH (DataSet2<<1)
LDI XH, HIGH (0x0200)
LDI XH, LOW (0x0200)
LDI R17,6							; counter

MAIN2: LPM R16, Z+
ST X+, R16
DEC R17
BRNE MAIN2
NOP 
*/



//Initializing the Z pointerLDI ZH,HIGH(DataSet1<<1) ;higher byte of the address, 0x0200LDI ZL,LOW(DataSet1<<1)  ;lower byte of the address, 0x0200LDI XH,HIGH(0x0100); higher byte of the address, 0x0100LDI XL,LOW(0x0100); lower byte of the address, 0x0100LDI R17,4 	; counter//Retrieve the data from the program memoryMain: 	LPM R16,Z+	ST X+,R16	DEC R17BRNE MainNOP//Initializing the Z pointerLDI ZH,HIGH(DataSet2<<1) ;higher byte of the address, 0x0200LDI ZL,LOW(DataSet2<<1)  ;lower byte of the address, 0x0200LDI XH,HIGH(0x0200); higher byte of the address, 0x0200LDI XL,LOW(0x0200); lower byte of the address, 0x0200LDI R17,6 	; counter//Retrieve the data from the program memoryMain1: 	LPM R16,Z+	ST X+,R16	DEC R17BRNE Main1NOP//ASCII letter A, B, C in the program memory location 0x100 (physical address: 0x200).ORG 0x0100DataSet1: .DB 0x44, 0xB2, 0x73, 0x0FDataSet2: .DB 'T','E','M','P','L','E'DataSet3: .DB "Engr"
