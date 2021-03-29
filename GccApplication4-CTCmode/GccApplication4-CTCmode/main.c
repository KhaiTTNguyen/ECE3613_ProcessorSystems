/*
 * GccApplication4-CTCmode.c
 *
 * Created: 3/29/2021 11:31:48 AM
 * Author : KhaiNguyen
 */ 


#include <avr/io.h>
int main (void) {
	DDRA = 1<<5;
	PORTA &= ~(1<<5);  //PB5=0
	while (1)
	{
		TCNT0 = 0x00;
		OCR0B=125;
		TCCR0B = 0x0B;			// set up orescaler 
		while((TIFR0&(1<<OCF0B))==0);//stay here until OCF0B=1 rollover
		TCCR0B = 0;
		TIFR0 = (1<<OCF0B);
		PORTA = PORTA^(1<<5);
	}
}

