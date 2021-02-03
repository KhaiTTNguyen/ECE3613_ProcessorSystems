;
; AssemblerApplication5.asm
;
; Created: 2/3/2021 11:04:32 AM
; Author : KhaiNguyen
;
/*
ldi r17, 0xa3
ldi r18,2 ;loop counter
label:
	add r17,r18
	dec r18 ; dec and brne next to each other --> add, com, mov --> affect flags
	brne label
mov r19,r17
nop

*/

.equ count=0x25
ldi r21, count
ldi r22, count+3

nop