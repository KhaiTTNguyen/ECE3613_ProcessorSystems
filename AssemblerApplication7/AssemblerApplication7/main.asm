;
; AssemblerApplication7.asm
;
; Created: 2/5/2021 11:17:05 AM
; Author : KhaiNguyen
;
/*
LDI R20,0x55

OUT PORTA,R20

L1: COM R20

OUT PORTA,R20

JMP L1
*/

/*
Store the numbers $6A and $B4

a) into locations 0x0004 and 0x0006 respectively in Data Memory

b) then do a MOV R0,R4 followed by a MOV R1,R6
*/

ldi r16,0x6A
ldi r17,0xB4
sts 0x0004, r16 ; store to r4
sts 0x0006, r17 ; store to r6
mov r0,r4
MOV R1,R6
