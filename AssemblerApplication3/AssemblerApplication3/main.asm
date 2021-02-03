; ECE_3613_ASM_test.asm
;
; Basic program to turn PORTA LEDs on and off with 1 second frequency
; Author : Jeremy McGinnis
;

ldi R19, 0xff    //load R19 with 255
out DDRA, R19    //set DDRA as all outputs
out PORTA, R19    //set PORTA LEDs High

start:
    in R18, PINA    //read in value of PORTA
    eor R18, R19    //XOR PORTA (255 -> 0 | 0 -> 255)
    out PORTA, R18    //write PORTA with XOR result in R18
    call DELAY        //execute DELAY subroutine
    rjmp start        //go back to start

//1 second delay blocking timer
DELAY:
    ldi r20,32
    L1: LDI R21, 200
        L2: LDI R22, 249
            L3: NOP
            NOP
            NOP
            NOP
            NOP
            NOP
            NOP
            DEC R22
            BRNE L3
        DEC R21
        BRNE L2
    DEC R20
    BRNE L1
RET

