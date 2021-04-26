/*
 * GccApplication6-ultrasonic-sensor.c
 *
 * Created: 4/23/2021 11:21:40 AM
 * Author : Khai Nguyen
 */ 

#define F_CPU 16000000UL
#include <util/delay.h>
#include <avr/interrupt.h>
#include "SSD1306.h"
//#include "SSD1306.c" //Not sure why I don’t need to include this file here
// Pin definitions
#define PINGPin PD0
#define ECHOPin PD1
// Variable declarations
volatile int dist = 0;
char str [100];
int count = 0;


int main(void) {
	int8_t displayInverted = 1;
	uint8_t dispNum = 0x00;
	char text[] = "TEMPLE MADE ECE";
	char text1[] = "DR. H is the Man!";
	OLED_Init(); //initialize the OLED
	_delay_ms(1);
	OLED_Clear(); //clear the display (for good measure)
	//set up Pin Change Interrupt Registers
	PORTD |= (1<<0);// Set Pull up resistor PD0
	PORTD |= (1<<1);// Set Pull up resistor PD1
	PCICR |= (1<<PCIE3);// Pin Change Interrupt 1 Mask for PD0 is at PCIE3
	PCIFR|=(1<<PCIF3);// Pin Change Interrupt Flag for PD0 is at PCIF3
	PCMSK3 |= (1<<PCINT24)|(1<<PCINT25) ; //Enable PCINT24 and PCINT25
	//PCMSK3 = (1<<PINGPin);// Unmask PD0 OOPS done line above
	//set up TIMER2 Registers
	TCCR2B = (1<<CS21);// Set TIMER2 to Normal Mode with 1:8 prescaler for 1st output pulse
	TIMSK2 = (1<<TOIE2);// Unmask TIMER2 in Normal Mode
	OCR2B = 255;// Set output compare register to 255


	sei();

	PORTB = 0xFF;


	while (1) {
		dispNum++;
		OLED_SetCursor(0, 0); //set the cursor position to (0, 0)
		OLED_SetCursor(1, 0);
		OLED_DisplayString(text);
		OLED_SetCursor(2, 0);
		OLED_DisplayString(text1);
		OLED_SetCursor(4, 0);
		OLED_Printf(" distance: ");
		OLED_DisplayNumber(C_DECIMAL_U8,dist,3);

		//_delay_ms(100);
	}

	return 0; // never reached
}
ISR(TIMER2_OVF_vect) {
	if (OCR2B == 255) {
		TCCR2B = (1<<CS21);// Set TIMER2 to Normal Mode with 1:8 prescaler
		DDRD |= (1<<PINGPin);// Set data direction of PD0 to output
		PORTD |= (1<<PINGPin);// Send ultrasonic pulse
		OCR2B = 3;// Set output compare register to 3
		return;// Return to main
	}
	else if (OCR2B == 3) {
		PORTD &= ~(1<<PINGPin);// Stop ultrasonic pulse
		OCR2B = 2;// Set output compare register to 5
		return;// Return to main
	}
	else if (OCR2B == 2) {
		DDRD &= ~(1<<ECHOPin);// Set data direction of PB1 to input
		OCR2B = 255;// Set output compare register to 255
		TCCR2B = (1<<CS22)|(1<<CS21);// Set TIMER2 to Normal Mode with 1:256 prescaler
		return;// Return to main
	}
}

ISR(PCINT3_vect) {
	count++;// Increment count
	if (count == 3) TCNT2 = 0;// If ISR executed 3 times, reset timer
	if (count == 4) {// If ISR executed 4 times
		dist = (TCNT2*.214);// Calculate distance
		OCR2B = 255;// Set output compare register to 255
		count = 0;// Reset count
		return;// Return to main
	}
	return;// Return to main
}