/*
 * GccApplication1.c
 *
 * Created: 3/31/2021 3:31:34 PM
 * Author : Khai Nguyen
 */ 

#include <avr/io.h>

// declare subroutines
void T2point5();
void T7point5();

int main (void) {
	DDRA = 1<<5;
	PORTA &= ~(1<<5);  //PA5=0
	while (1)
	{
		PORTA=0b00100000; // turn on PA5
		T2point5();
		PORTA=0b00000000; // turn off PA5
		T7point5();	
	}
}

// define subroutines
// delay 2.5ms
void T2point5(){
	TCNT0 = 0xD8;	// initial value for TCNT0 = 216 = 0xD8
	TCCR0B = 0x05;	// 1024 prescaler
	while((TIFR0&(1<<TOV0))==0);
	TCCR0B = 0;
	TIFR0 = (1<<TOV0);
}
// delay 7.5ms
void T7point5(){
	TCNT0 = 0x8B;	// initial value for TCNT0 = 139 = 0x8B 
	TCCR0B = 0x05;	// 1024 prescaler
	while((TIFR0&(1<<TOV0))==0);
	TCCR0B = 0;
	TIFR0 = (1<<TOV0);
}