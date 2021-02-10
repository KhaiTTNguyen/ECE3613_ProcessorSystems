;
; AssemblerApplication11.asm
;
; Created: 2/10/2021 3:30:53 PM
; Author : KhaiNguyen
;


// Activity 3-1

/*
This assembly code reads a number from 0 to 3 using PINB. 
Store the corresponding value in the address 0x100, 0x101, 0x102, or 0x0103 in the data memory. 
If the entered number is 0, store $ff into 0x100. 
If the number is 1, store 1 into 0x101. 
If the number is 2, store 2 into 0x102. 
If the number is 3, store 3 into 0x103. 
To complete the operation, we must use a least one branch instruction 
(more than 2 different branch instructions with different flags ? 10 extra points) 
and clear all memory values when you read a new number. 
Follow the flowchart3-1 below. Add a video result of running the code for all cases.  
*/

ldi r18, 10 ; for 4 loading times
load: 
	LDI R16, 0	; clear mem
	IN R16, PINB ; read 0 to 3 
	CPI R16, 0 ; compare immediate
	BREQ store0
	CPI R16, 1 ; compare immediate
	BREQ store1
	CPI R16, 2 ; compare immediate
	BREQ store2
	CPI R16, 3 ; compare immediate
	BREQ store3
	
	store0:
		ldi r16, 0xFF	; load val to r16
		sts 0x100, r16	;store 1 into 0x101
		dec r18			; decrement r18
		brne load		; go back to "load" if r18 is not 0
	store1:
		ldi r16, 1		; load val to r16
		sts 0x101, r16	;store 1 into 0x101
		dec r18			; decrement r18
		brne load		; go back to "load" if r18 is not 0
	store2:
		ldi r16, 2		; load val to r16
		sts 0x102, r16	;store 2 into 0x102
		dec r18			; decrement r18
		brne load		; go back to "load" if r18 is not 0
	store3:
		ldi r16, 3		; load val to r16
		sts 0x103, r16	;store 2 into 0x102
		dec r18			; decrement r18
		brne load		;go back to "load" if r18 is not 0
nop

/*
//Activity 3-3. masking

ldi r16,1 
sts 0x0101,r16
inc r16
sts 0x0102,r16
inc r16
sts 0x0103,r16
inc r16
sts 0x0104,r16
inc r16
sts 0x0105,r16
inc r16
ldi r17,0b00000001; mask register
ldi r18,0; register to hold the count for odd numbers
;test first number
lds r19,0x0101
and r19,r17
breq next1
inc r18
next1:
lds r19,0x0102
and r19,r17
breq next2
inc r18
next2:
lds r19,0x0103
and r19,r17
breq next3
inc r18
next3:
lds r19,0x0104
and r19,r17
breq next4
inc r18
next4:
lds r19,0x0105
and r19,r17
breq next5
inc r18
next5:
nop

*/


/*
Lab2 extra Load 0x48 to R20 using PINB using IN instruction. 
Then, load 0x15 to R21 using PINC using LDS instruction. 
Make the sum of R20 and R21 output through the PORTA using OUT instruction 
and PORTD using STS instructions. 
Upload a file or picture of the memory contents and I/O view after running the code.

 IN & OUT instructions with the I/O address and STS & LDS instructions with the actual memory address (I/O address with offset 0x20).
*/

/*
IN R20, PINB ; 0x48
LDS R21, 0x26 ; 0x02
ADD R20, R21
OUT PORTA, R20
STS 0x2b, R20 ; need to offsett PORTD 0x0b --> 0x2b
NOP

*/