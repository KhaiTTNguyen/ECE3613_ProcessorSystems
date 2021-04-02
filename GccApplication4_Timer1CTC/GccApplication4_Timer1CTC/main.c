/*
 * GccApplication4_Timer1CTC.c
 *
 * Created: 4/2/2021 11:04:37 AM
 * Author : Khai Nguyen
 */ 

#include <avr/io.h>#define F_CPU 16000000UL#include <util\delay.h>int main (void) {	while (1)	{		DDRA = 1<<5;		PORTA ^= (1<<5);  //toggle pa5		TCNT1H = 0x00;		TCNT1L = 0x00;		OCR1BH=0x3E;	// output compare regH 		OCR1BL=0x80;	// output compare regL		TCCR1A = 0x00;		TCCR1B = 0x09;//ctc mode no prescaler		while((TIFR1&(1<<OCF1B))==0);			// wait till output compare flag turn on		TCCR1A = 0;		TCCR1B = 0;		TIFR1 = (1<<OCF1B);	}}

