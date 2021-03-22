/*
 * GccApplication3.c
 *
 * Created: 3/22/2021 11:08:42 AM
 * Author : KhaiNguyen
 */ 

#include <avr/io.h>
#define F_CPU 16000000UL
#include <util\delay.h>
int main (void) {
	while (1)
	{
		DDRD=0xFF;
		{
			PORTD = 0b00000100;		// turn on pb2
			_delay_ms(1.5);				
			PORTD = 0b00000000;		// turn signal off 
			_delay_ms(20);			// keep on 1.3 sec, off for 20 sec --> clockwise | (1.7 & 20) --> anticlock
		}
	}
}

