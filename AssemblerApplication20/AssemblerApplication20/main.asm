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



//Initializing the Z pointer