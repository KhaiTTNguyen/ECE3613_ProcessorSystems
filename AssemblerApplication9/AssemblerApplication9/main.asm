;
; AssemblerApplication9.asm
;
; Created: 2/8/2021 11:38:22 AM
; Author : KhaiNguyen
;


/*
Write a program to (a) clear R20, then (b) add 0xA2 to R20 20 times using a loop,  and (c) send the sum to PORTB. Use the zero flag and BRNE
*/
/*
clr r20
ldi r16,20
ldi r21,0xA2
loop: 
	add r20,r21
	dec r16
	BRNE loop

out portb, r20
nop
*/


; Show code for a nested loop to perform an action 1 ,000 times.
/*
ldi r16,10 ; outer loop count
ldi r21, 0x1c
L1: 
	ldi r17,100 ; inner loop count
	L2:
		add r20,r21
		dec r17
		BRNE L2
	dec r16
	BRNE L1
nop
*/

ldi r16,100 ; outer loop count
ldi r21, 0x1c
L1: 
	ldi r17,100 ; inner loop count
	
	L2:
		ldi r18,10 ; 2nd-inner loop count
		L3:
			add r20,r21
			dec r18
			BRNE L3
		dec r17
		BRNE L2
			
	dec r16
	BRNE L1
nop