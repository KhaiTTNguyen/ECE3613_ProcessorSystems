;
; AssemblerApplication12.asm
;
; Created: 2/14/2021 7:27:06 PM
; Author : KhaiNguyen
; Add nums using 2 regs/2bytes

/*
.equ n1=1	;start
.equ n2=100 ;end
start:
	ldi r16,n1	;loop counter
	ldi r18,0	; lower byte
	ldi r19,0	; higher byte
	ldi r25,0	; a zero for higer order byte addition.
		loop:
			cpi r16, n2+1	; Z flag=1 if equals
			breq done
			add r18,r16		; r18 for storing
			adc r19,r25		; add w a carry
			inc r16
			rjmp loop
		done:
			nop

*/


        LDI R16,HIGH(RAMEND)	; $(08)FF high byte
        OUT SPH,R16
        LDI R16,LOW(RAMEND)		; $08(FF) low byte
        OUT SPL,R16        
        LDI R20,15
        LDI R21,5
        CALL FUNC_NAME		; stack point at 0x08FF
        INC  R20	
L1:     RJMP  L1			; stuck here for good
FUNC_NAME:
        ADD  R20,R21
        SUBI  R20,3
        RET