;
; AssemblerApplication24test.asm
;
; Created: 4/1/2021 9:00:34 PM
; Author : Khai Nguyen
;


; Replace with your application code
ldi r16,0x12
ldi r17,-14
ldi r18,-10
ldi r19,0xA4
ldi r30,0 ; <------ good practice
add r30,r16
add r30,r17
add r30,r18
add r30,r19
nop