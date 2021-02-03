;
; GPR-test.asm
;
; Created: 1/27/2021 11:35:18 AM
; Author : KhaiNguyen
;
; fetch, decode & execute

start:
ldi r20, 0x1f	
ldi r21, 23	
add r20, r21
out ddrc,r20	
in r19,pinb		
lds r2,0x129d	
sts 0x0100,r19
nop

/*
start: 
LDI R17, 0b10001000
LDI R19, 0x6f
LDI R21, 0b11000110
LDI R16, 211
LDI R22, 0x49
LDI R23, 73
nop
*/
/*
add r17, r18  
sts 0x0100,r17 
sts 0x0103,r18 ; --> 3 machine cycles 0x0100 to 0x0103 
sts 0x0105,r31 
*/



;IRAM store register at top R0-R31
;FLASH mem store all OPcodes
; .lss file --> store summary of assembly source code

;                                  start: 
;000000 ea13                      ldi r17, 0xa3 
;000001 ef2f                      ldi r18, 255 
;000002 e3fa                      ldi r31,0b00111010 
;000003 0f12                      add r17, r18  
;000004 9310 0100 (mem loc 4 & 5)                 sts 0x0100,r17 
;000006 9320 0103 (mem loc 6 & 7) sts 0x0103,r18
;000008 93f0 0105                 sts 0x0105,r31
;00000a 0000                      nop
 