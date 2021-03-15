/*
 * GccApplication1.c
 *
 * Created: 3/15/2021 11:08:46 AM
 * Author : KhaiNguyen
 */ 

/* Write a C program so that when pin 0 on PORTB is LOW then count up from 0 to 9 on the 7 segment display with a delay between each number of 500 msec. 
Also when when pin 0 on PORTB is HIGH then count Down from 9 to 0 on the 7 segment display with a delay between each number of 1000 msec.*/



/*
#include <avr/io.h>
#include <stdio.h>

int main(void)
{
	// declare variables here
	unsigned char x;
	DDRA=0xff;			// outputport
	DDRB=0x00;			// input port
	PORTB=0xff;			// activate pull up regs 
    // Replace with your application code
    while (1) 
    {
		x=PINB;
		PORTA=x;
    }
}
*/

/*
// Blinky.c
*/

 /* WRITE A PROGRAM TO TOGGLE ALL BITS OF PORTA AT 1000ms. Use the Data Visualizer to view one of the pins on PORTA and show the delay of 1000ms.
*/

/*
#include <avr/io.h> //standard AVR header
#define F_CPU 16000000UL// Define CPU frequency for delay.h
#include <util/delay.h>

int main(void)
{
	DDRA = 0xFF; //PORTA is output

	while (1)
	{
		PORTA = 0xAA;
		_delay_ms(1000);
		PORTA = 0x55;
		_delay_ms(1000);
	}
	return 0;
}
*/