/*
 * GccApplication4_Timer.c
 *
 * Created: 3/26/2021 11:46:02 AM
 * Author : KhaiNguyen
 */ 


#include <avr/io.h>
int main (void) {

	DDRA = 1<<5;
	PORTA &= ~(1<<5);  //PA5=0
	while (1)
	{
		TCNT0 = -160;				// no presclale?
		TCCR0B = 0x01;				// changed 1 - 256
		while((TIFR0&(1<<TOV0))==0);
		TCCR0B = 0;
		TIFR0 = (1<<TOV0);
		PORTA = PORTA^(1<<5);
	}
}
