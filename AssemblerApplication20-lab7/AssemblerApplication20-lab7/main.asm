;
; AssemblerApplication20-lab7.asm
;
; Created: 3/10/2021 3:06:20 PM
; Author : KhaiNguyen
;
/* ACTIVITY 1. Write a program that uses a LOOP to add the integers from 1 to 100.*/

.equ n1=1			; start here
.equ n2=100			; end here
.def ii=r16			; .def assign to a register	
.def sumHi=r19		; hold higher byte off addition
.def sumLo=r18		; hold lower byte off addition
start:
	ldi ii, n1		; r16=ii=n1=1
	ldi sumHi,0		; init reg to 0
	ldi sumLo,0
	ldi r25,0		; keep adc inside my loop
loop:
	cpi ii,n2+1		; check if we at 101
	breq done
	add sumLo,ii	; add lower order byte
	adc sumHi,r25	; picksup carry (if generated from lower byte)
	inc ii
	rjmp loop
done:
	nop


/* ACT 2 - count the number of elements starting at 0x0100 of 8-bit integers that are a multiple of 4.*/
/*
ldi r16,11					;first number
ldi r17,30					;counter for loop
ldi XL,LOW(SRAM_START)		;LOWER PART OF XL=0X00
ldi XH,HIGH(SRAM_START)		;UPPER PART OF XH=0X01
LOOP:
	ST X+,R16				;PLACES R16 IN SRAM POINTED AT BY X REG
	INC R16					;MOVE TO NEXT NUMBER
	DEC R17
	BRNE LOOP
nop 

; need to reinitialize X-reg, now it's pointing to 0x010*
.def COUNT_DIV4=r19			; counter for #'s divisible by 4
ldi r16,11					; first number
ldi r17,30					; counter for loop
ldi r19, 0					; counter for #'s divisible by 4
ldi XL,LOW(SRAM_START)		; LOWER PART OF XL=0X00
ldi XH,HIGH(SRAM_START)		; UPPER PART OF XH=0X01
DIV4_COUNT_LOOP:
LD R18, X+					; takes contensts
ANDI r18, 0b00000011		; mask all bits except 0&1
CPI r18, 0x00				; check if last 2 bits are both 0
breq inc_count
continue: 
	dec r17
	brne DIV4_COUNT_LOOP
stop: rjmp stop

inc_count:					; loop for incrementing count of #'s divisible by 4
	inc COUNT_DIV4
	rjmp continue
*/


/* ACT 3 - count the number of elements of 8-bit integers that have bits 2,3 and 4 set equal to a 1. */
/*
ldi r16,11					;first number
ldi r17,30					;counter for loop
ldi XL,LOW(SRAM_START)		;LOWER PART OF XL=0X00
ldi XH,HIGH(SRAM_START)		;UPPER PART OF XH=0X01
LOOP:
	ST X+,R16				;PLACES R16 IN SRAM POINTED AT BY X REG
	INC R16					;MOVE TO NEXT NUMBER
	DEC R17
	BRNE LOOP
nop 

; need to reinitialize X-reg, now it's pointing to 0x010*
.def COUNT_0x1C=r19			; counter for #'s where bits 2,3,4 are one's
ldi r16,11					; first number
ldi r17,30					; counter for loop
ldi COUNT_0x1C, 0			; counter for #'s where bits 2,3,4 are one's
ldi XL,LOW(SRAM_START)		; LOWER PART OF XL=0X00
ldi XH,HIGH(SRAM_START)		; UPPER PART OF XH=0X01
COUNT_0x1C_LOOP:
LD R18, X+					; takes contents
ANDI r18, 0x1C				; mask all bits except 2,3,4 - 0x1C = 0b00011100
CPI r18, 0x1C				; check if bits 2,3,4 are one's
breq inc_count
continue: 
	dec r17
	brne COUNT_0x1C_LOOP
stop: rjmp stop

inc_count:					; loop for incrementing count of # where bits 2,3,4 are one's
	inc COUNT_0x1C
	rjmp continue
	*/