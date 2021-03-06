;
; AssemblerApplication20-XYZregs.asm
;
; Created: 3/8/2021 4:18:20 PM
; Author : KhaiNguyen
;

; Program to store the value $55 into memory locations $140 to $144
/*
      LDI	R19,0x5		;R19 = 5 (R19 for counter)
      LDI	R16,0x55	;load R16 with value 0x55 (value to be copied)
      LDI	YL,0x40		;load the low byte of Y with value 0x40
      LDI	YH,0x1		;load the high byte of Y with value 0x1
L1: ST	Y,R16		;copy R16 to memory location 0x140
      INC	YL		;increment the low byte of Y
      DEC	R19		;decrement the counter
      BRNE  L1		;loop until counter = zero

*/
	
/*  
      LDI	R19,0x5		;R19 = 5 (R19 for counter)
      LDI	R16,0x55	;load R16 with value 0x55 (value to be copied)
      LDI	YL,0x40		;load the low byte of Y with value 0x40
      LDI	YH,0x1		;load the high byte of Y with value 0x1
L1: ST	Y+,R16		;copy R16 to memory location 0x140	- post-increment Y+
//      INC	YL		;increment the low byte of Y
      DEC	R19		;decrement the counter
      BRNE  L1		;loop until counter = zero


*/

/*
.EQU MEM_ADDR=0x0180
LDI R16, $AA			; data
LDI R20, 11			; loop counter --> (0x019F - 0x0180) + 1 = 20 steps
LDI XH, HIGH(MEM_ADDR)	; r26
LDI XL, LOW(MEM_ADDR)	; r27

L1:
ST X+, R16			; stores R16 into SRAM address pointer
DEC R20;
BRNE L1
nop

*/

.EQU MEM_ADDR_1=0x0180
.EQU MEM_ADDR_2=0x0190

LDI R16, 1			; data
LDI R20, 10			; loop counter --> (0x019F - 0x0180) + 1 = 20 steps
LDI XH, HIGH(MEM_ADDR_1)	; r26
LDI XL, LOW(MEM_ADDR_1)	; r27
L1:
ST X+, R16			; stores R16 into SRAM address pointer
DEC R20;
BRNE L1

ldi r20, 10
LDI XH, HIGH(MEM_ADDR_1)	; reset X & Y
LDI XL, LOW(MEM_ADDR_1)
LDI YH, HIGH(MEM_ADDR_2)
LDI YL, LOW(MEM_ADDR_2)	
L2:
LD R17, X+ ; content of SRAM pointed by X
ST Y+, R17
DEC r20
BRNE L2
nop

