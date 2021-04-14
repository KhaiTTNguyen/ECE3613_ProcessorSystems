/*
 * GccApplication5_toggle.c
 *
 * Created: 4/8/2021 7:34:02 PM
 * Author : Khai Nguyen
 */ 


#include <avr/io.h> 
//standard AVR header
#define F_CPU 16000000UL
// Define CPU frequency for delay.h
#include <util/delay.h>
#define PINB0 0
/*
int main(void){	
	unsigned char one, eight, nine, zero;	 
	one=0b00000110;	// two=0b01011011;	// three=0b01001111;	// four=0b01100110;	//five=0b01101101;	//six=0b01111100;	// seven=0b0000111;	
	eight=0b01111111;	
	nine=0b01100111;	
	zero=0b00111111;
	DDRA = 0xFF; //PORTA is output
	PORTB=0xFF;//activate pullups
	DDRB=0x00;//input
	while (1){	
		if(PINB & (1<<PINB0))	{		
			PORTA=zero;		
			_delay_ms(500);		
			PORTA=one;		
			_delay_ms(500);	
		}
		else
		{
			PORTA=nine;
			_delay_ms(500);
			PORTA=eight;
			_delay_ms(500);
		}
	}
	return 0;
}
*/
#include <avr/io.h> //standard AVR header
#define F_CPU 16000000UL// Define CPU frequency for delay.h
#include <util/delay.h>

int main(void)
{
	DDRA = 0xFF; //PORTA is output
	while (1)
	{
		PORTA = 0x0A;
		_delay_ms(200);
		PORTA = 0x00;
		_delay_ms(200);
	}
	return 0;
}
