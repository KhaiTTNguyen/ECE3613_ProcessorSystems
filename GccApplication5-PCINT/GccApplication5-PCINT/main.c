/*
 * GccApplication5-PCINT.c
 *
 * Created: 4/21/2021 11:22:37 AM
 * Author : Khai Nguyen
 */ 
/*
#include <avr/io.h>#include <avr/interrupt.h>#include "SSD1306.h"//#include "SSD1306.c" //Not sure why I don’t need to include this file here// Declare Global Variablesvolatile int counter;int main(void){	uint8_t dispNum = 0x00;	char text[] = "TEMPLE MADE ECE";	OLED_Init();  //initialize the OLED	_delay_ms(1);	OLED_Clear(); //clear the display (for good measure)	counter = 0;// Initialize counter	DDRA = 0xFF;//Port A has 8 Leds as outputs	DDRB = 0;// Port D all inputs	DDRC = 0;// Port D all inputs	PORTB = 0xFF;// Set Pull up resistor for PD	PORTC = 0xFF;// Set Pull up resistor for PC	PCICR|=(1<<PCIE3);	PCMSK3 |= (1<<PCINT28);// Pin Change Interrupt 1 Mask FOR PPD2	sei();// Set Interrupt Flag	OLED_SetCursor(0, 0);        //set the cursor position to (0, 0)	OLED_Printf("GO OWLS   "); //Print out some text
	while(1)
	{
		OLED_SetCursor(4, 0);
		OLED_Printf(" uint8_t dispNum: ");
		OLED_DisplayNumber(C_DECIMAL_U8,counter,3);
		OLED_HorizontalGraph(2,counter*100/256);
		// Wait For Interrupts and Update LEDs
		PORTA = counter;
	}
}
// Pin Change Interrupt on Port B Bit 0
ISR(PCINT3_vect, ISR_BLOCK)
{
	counter++;// Increment counter when pin changes
}
*/


// joy stick interrupts
#include <avr/io.h>
#define F_CPU 16000000UL
#include <util/delay.h>
#include <avr/interrupt.h>
#include "SSD1306.h"
volatile char joy_input;// joystick port
int main (void) {
	PCICR |= (1<<PCIE1); //Pin change control register
	PCMSK1 |= (1<<PCINT15)|(1<<PCINT14)|(1<<PCINT13)|(1<<PCINT12); //pin change int
	OLED_Init();  //initialize the OLED
	_delay_ms(1);
	OLED_Clear(); //clear the display (for good measure)
	sei();
	while (1)
	{
	}
}
ISR(PCINT1_vect,ISR_BLOCK){
	// Port to PCINT to Direction Table
	//
	// PB[4-7]
	// PB4 = PCINT12 = Left
	// PB5 = PCINT13 = Up
	// PB6 = PCINT14 = Right
	// PB7 = PCINT15 = Down
	//
	// PD0 = PCINT24 = Center
	joy_input = PINB&0b11110000;
	OLED_GoToLine(0);
	switch(joy_input){
		case 0b11100000 :// PB4 =LOW=0 PCINT12 = Left
		OLED_Printf("TEMPLE ECE \nLEFT   \n");
		OLED_DisplayNumber(C_BINARY_U8, joy_input, 8);
		break;
		case 0b11010000 : // PB5 =Low=0  PCINT13 = Up
		OLED_Printf("TEMPLE ECE \nUP     \n");
		OLED_DisplayNumber(C_BINARY_U8, joy_input, 8);
		break;
		case 0b10110000 : // PB6 = LOW=0 PCINT14 = Right

		OLED_Printf("TEMPLE ECE \nRIGHT \n");
		OLED_DisplayNumber(C_BINARY_U8, joy_input, 8);
		break;
		case 0b01110000 : // PB7 =LOW=0  PCINT15 = Down
		OLED_Printf("TEMPLE ECE \nDOWN  \n");
		OLED_DisplayNumber(C_BINARY_U8, joy_input, 8);
		break;
		default :
		OLED_Printf("TEMPLE ECE \nCENTER\n");
		OLED_DisplayNumber(C_BINARY_U8, joy_input, 8);
		break;
	}
	_delay_ms(50);
}
