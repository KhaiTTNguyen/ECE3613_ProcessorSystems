/*
 * GccApplication2-door sensor.c
 *
 * Created: 3/17/2021 11:05:58 AM
 * Author : KhaiNguyen
 */ 

#include <avr/io.h>
#define LED 7
#define SENSOR 3

int main(void)
{
    /* Replace with your application code */
    DDRB=(0<<SENSOR);			 // make pb3 input bit on portb
	DDRA=(1<<LED);					// make pa7 output bit on porta
	PORTB=0xFF;					// pullups
	while (1) 
    {
		unsigned char test;				// used for input pins
		test=PINB&(1<<SENSOR);			// mask out all bits except pinb @ SENSOR
		if(test){
			PORTA=(1<<LED);			// turn on PA7
		}else{
			PORTA=(0<<LED);			// turn off PA7
		}
    }
}

