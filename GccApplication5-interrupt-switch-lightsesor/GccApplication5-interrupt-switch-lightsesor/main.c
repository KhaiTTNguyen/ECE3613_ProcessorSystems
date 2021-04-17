/*
 * GccApplication5-interrupt-switch-lightsesor.c
 *
 * Created: 4/16/2021 11:31:48 AM
 * Author : Khai Nguyen
 */ 
/*
#include <avr/io.h>
#include <avr/interrupt.h>
// Declare Global Variables
volatile int counter;
int main(void)
{
	counter = 0;// Initialize counter
	DDRB=0X00;//PORTB INPUT
	PORTB=0XFF;//ACTIVATE PULLUPS
	DDRA = 0xFF;//Port A has 8 Leds as outputs
	DDRD = 0;// Port D all inputs
	PORTD |= (1<<2);// Set Pull up resistor PD2 (INT0)
	EIMSK=(1<<INT0);
	EICRA=0X02; //INT0 WILL ACTIVATE Rising EDGE TRIGGER
	sei();// Set Interrupt Flag
	while(1)
	{
		// Wait For Interrupts and Update LEDs
		PORTA = counter;
	}
}
// External Interrupt on Port D Pin 2
ISR(INT0_vect, ISR_BLOCK)
{
	counter++;// Increment counter when pin changes
}
*/

#include <util/delay.h>
#include <avr/interrupt.h>
#include "SSD1306.h"
//#include "SSD1306.c" //Not sure why I don’t need to include this file here

// Declare Global Variables
volatile int counter;
int main(void)
{
	int8_t displayInverted = 1;
	uint8_t dispNum = 0x00;
	char text[] = "TEMPLE MADE ECE";
	OLED_Init();  //initialize the OLED
	_delay_ms(1);
	OLED_Clear(); //clear the display (for good measure)

	sei();
	PORTB = 0xFF;

	DDRA = 0xFF;//Port A has 8 Leds as outputs
	DDRD = 0;// Port D all inputs
	PORTD |= (1<<2);// Set Pull up resistor PD2 (INT0) -- nput from light sensor
	EIMSK=(1<<INT0);
	EICRA=0X02; //INT0 WILL ACTIVATE Rising EDGE TRIGGER
	sei();// Set Interrupt Flag
	OLED_SetCursor(0, 0);        //set the cursor position to (0, 0)
	OLED_Printf("GO OWLS   "); //Print out some text
	counter = 0;// Initialize counter

	while(1)
	{
		// Wait For Interrupts and Update LEDs
		PORTA = counter;
		OLED_SetCursor(4, 0);
		OLED_Printf(" uint8_t dispNum: ");
		OLED_DisplayNumber(C_DECIMAL_U8,counter,3);
		OLED_HorizontalGraph(2,counter*100/256);

	}
}// External Interrupt on Port D Pin 2ISR(INT0_vect, ISR_BLOCK){	counter++;// Increment counter when pin changes}
