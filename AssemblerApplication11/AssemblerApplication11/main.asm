;
; AssemblerApplication11.asm
;
; Created: 2/10/2021 3:30:53 PM
; Author : KhaiNguyen
;
/*
// Activity 1-1s
LDI R16, 0xa1	; load 0xa1 to r16
LDI R17, 0x08	; load 0x08 to r17
LDI R18, 0x9c	; load 0x9c to r18
LDI R19, 0x14	; load 0x14 to r19
LDI R20, 0xf7	; load 0xf7 to 20

ADD R16, R17	; add R17 to R16
ADD R16, R18	; add R18 to R16
ADD R16, R19	; add R19 to R16
ADD R16, R20	; add R20 to R16
*/

// Activity 1-2
	BLOCK1:
	LDI	R20,$27
	LDI	R21,$15
	SUB	R20, R21 ;Look at the Status Register and check by hand
	
	BLOCK2:
	LDI	R20,$20
	LDI	R21,$15
	SUB	R20, R21 ;Look at the Status Register and check by hand 
 	
	BLOCK3:
	LDI	R24,95
	LDI	R25,95
	SUB	R24, R25 ;Look at the Status Register and check by hand
	
	BLOCK4:
	LDI	R22,50
	LDI	R23,70
	SUB	R22, R23 ;Look at the Status Register and check by hand

L1:	RJMP	L1 ;Stay here forever


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

/*
ldi r18, 10 ; for 10 loading times
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

*/

// Activity 3-2
/*
This assembly code loads value $10 to R20. 
Decrement the value by 1 until the value becomes zero. 
Output each value through PORTA if the number becomes an odd number 
and through PORTB if the number is an even number. 
Follow the flowchart 3-2.
*/

/*
LDI R20, 0x10			; load 0x10 - cannot be 0x00
LDI R18, 0				; clear mem
LDI R17, 0b0000001		; masking-register
LOOP:
	MOV R18, R20
	AND R18, R17
	brne odd			; Z bit not on - odd num
	
	OUT PORTB, R20		; even num - out to portB
	DEC R20				; decrement R20
	brne LOOP			; back to loop

	odd: 
		OUT PORTA, R20	; odd num - out to portA
		DEC R20			; decrement R20
		brne LOOP		; back to loop
nop
*/

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