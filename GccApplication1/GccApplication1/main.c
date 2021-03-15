/*
 * GccApplication1.c
 *
 * Created: 3/15/2021 11:08:46 AM
 * Author : KhaiNguyen
 */ 


#include <avr/io.h> //standard AVR header#define F_CPU 16000000UL// Define CPU frequency for delay.h#include <util/delay.h>#define PINB0 0int main(void){	unsigned char one, eight, nine, zero;	 one=0b00000110;	// two=0b01011011;	// three=0b01001111;	// four=0b01100110;	//five=0b01101101;	//six=0b01111100;	// seven=0b0000111;	eight=0b01111111;	nine=0b01100111;	zero=0b00111111;DDRA = 0xFF; //PORTA is outputPORTB=0xFF;//activate pullupsDDRB=0x00;//inputwhile (1){	if(PINB & (1<<PINB0))	{		PORTA=zero;		_delay_ms(500);		PORTA=one;		_delay_ms(500);	}		else		{					PORTA=nine;		_delay_ms(500);		PORTA=eight;		_delay_ms(500);		}		}return 0;}


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
// Blinky.c#include <avr/io.h>#include <avr/delay.h>int main (void){// set PORTA for outputDDRA = 0xFF;while(1){	for(int i = 1; i <= 128; i = i*2)	{		PORTA = i;		_delay_ms(500);	}	for(int i = 128; i > 1; i -= i/2)	{		PORTA = i;		_delay_ms(500);	}}}
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