/*
 * GccApplication6-pin-change-interrupts.c
 *
 * Created: 4/19/2021 11:31:53 AM
 * Author : Khai Nguyen
 */ 

/*
#include <avr/io.h>
#include <avr/interrupt.h>
#include "SSD1306.h"
//#include "SSD1306.c" //Not sure why I don’t need to include this file here
// Declare Global Variables
volatile int counter;
int main(void)
{
	uint8_t dispNum = 0x00;
	char text[] = "TEMPLE MADE ECE";
	OLED_Init();  //initialize the OLED
	_delay_ms(1);
	OLED_Clear(); //clear the display (for good measure)

	counter = 0;// Initialize counter
	DDRA = 0xFF;//Port A has 8 Leds as outputs
	DDRB = 0;// Port B all inputs
	//-----------------PCICR & PCMSK1-----------------------
	PORTB |= (1<<0);// Set Pull up resistor
	PCICR|=(1<<PCIE1);
	PCMSK1 |= (1<<PCINT8);// Pin Change Interrupt 1 Mask FOR PB0
	//--------------------------------------------------
	sei();// Set Interrupt Flag
	OLED_SetCursor(0, 0);        //set the cursor position to (0, 0)
	OLED_Printf("GO OWLS   "); //Print out some text
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
ISR(PCINT1_vect, ISR_BLOCK)
{
	counter++;// Increment counter when pin changes
}
*/
#include <avr/io.h>#include <avr/interrupt.h>#include "SSD1306.h"//#include "SSD1306.c" //Not sure why I don’t need to include this file here// Declare Global Variablesvolatile int counter;int main(void){uint8_t dispNum = 0x00;char text[] = "TEMPLE MADE ECE";OLED_Init();  //initialize the OLED_delay_ms(1);OLED_Clear(); //clear the display (for good measure)counter = 0;// Initialize counterDDRA = 0xFF;//Port A has 8 Leds as outputsDDRB = 0;// Port B all inputsDDRD = 0;// Port C all inputsPORTB = 0xFF;// Set Pull up resistorPORTD = 0xFF;// Set Pull up resistor//------------------------------------------------PCICR|=(1<<PCIE3);				// ------------PCIE2 /PCIE3 depending on which pin change intterupt you usingPCMSK3 |= (1<<PCINT28);// Pin Change Interrupt 2 Mask FOR PC7 //-----------------------------------------------sei();// Set Interrupt FlagOLED_SetCursor(0, 0);        //set the cursor position to (0, 0)OLED_Printf("GO OWLS   "); //Print out some text
while(1){OLED_SetCursor(4, 0);OLED_Printf(" uint8_t dispNum: ");OLED_DisplayNumber(C_DECIMAL_U8,counter,3);OLED_HorizontalGraph(2,counter*100/256);// Wait For Interrupts and Update LEDsPORTA = counter;}}// Pin Change Interrupt on Port C Bit 7ISR(PCINT3_vect, ISR_BLOCK)			// -------------> PCINT2 / PCINT3{counter++;// Increment counter when pin changes}
