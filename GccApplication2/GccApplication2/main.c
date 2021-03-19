/*
 * GccApplication2.c
 *
 * Created: 3/19/2021 11:11:49 AM
 * Author : KhaiNguyen
 */ 

#include <avr/io.h>

/*
b)A door sensor is connected to the port B pin 1, and an LED is connected to port A pin 7. Write an AVR C program to monitor the door sensor and, when it opens, turn on the LED. Use a mask on the PORTs so only the specific bits change and leave the rest the same.
*/
/*
#define LED 7
#define SENSOR 1

int main(void)
{
	DDRB=DDRB&~(1<<SENSOR);			// make 11111110 - make pinb1 input, preserve other pins
    PORTB=0xFF;						// pullups
//	DDRA=DDRA|(1<<LED);				// forces pa7 output, preserves byts 0-6		
	DDRA=0xFF;
	PORTA=0x01C;					// put some number on PORTA to see if thye're preserved
	unsigned char test;
	while (1) 
    {
		test=PINB&(1<<SENSOR);		// mask all bits to 0 except pb1
		if(test){
			PORTA=PORTA|(1<<LED);	//
		} else {
			PORTA=PORTA|(0<<LED);	// turn off pa7 if pb1 off
		}
	}
}
*/

/*
#include <avr/io.h> //standard AVR header

#define LED2 2 // define value for LED1
#define LED3 3 // define value for LED2
#define SENSOR 1 // define value for SENSOR

int main(void)

{
	//write code to set up the data direction registers
	DDRB=DDRB&~(1<<SENSOR);			// input - make 0
	PORTB=0xFF;//pullups
	DDRA=DDRA|(1<<LED2)|(1<<LED3);	// output - make 1
	unsigned char test;
	while(1)
	{
		test=PINB&(1<<SENSOR); //mask out all bits except pb1
		if(test)
		{
			PORTA=(1<<LED2)|(0<<LED3); // turn on pa2 off pa3
		}
		else
		{
			PORTA=(0<<LED2)|(1<<LED3); // turn on pa2 off pa3
		}
	}
	return 0;
}
*/

/*
Write an AVR C program using if, else if and else statements to read pins 1 and 0 of Port B and issue an ASCII character to  Port A according to the following table:

pin1 pin0

0      0              send ‘0’ to Port A (notice ASCII ‘0’ is 0x30)

0      1              send ‘1’ to Port A

1      0              send ‘2’ to Port A

1      1              send ‘3’ to Port A
*/
#include <avr/io.h> //standard AVR header

int main(void)
{
	DDRB=0x00;//inputs
	PORTB=0xFF;//pullups
	DDRA=0xFF;//outputs
	while(1)
	{
		if(PINB==0x00)
		{
			PORTA='0';
		}
		else if (PINB==0b00000001)
		{
			PORTA='1';
		} else if (PINB==0b00000010) {
			PORTA='2';			
		} else {
			PORTA='3';
		}
	}
	return 0;
}