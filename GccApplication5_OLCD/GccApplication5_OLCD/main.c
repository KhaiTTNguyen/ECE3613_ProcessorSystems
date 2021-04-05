/*
 * GccApplication5_OLCD.c
 *
 * Created: 4/5/2021 11:05:08 AM
 * Author : Khai Nguyen
 */ 

# define F_CPU 16000000UL#include <util/delay.h>#include <avr/interrupt.h>		// LCD uses this#include "SSD1306.h"int main (void){	PORTB = 0xFF; //activate pullup PB	DDRB = 0x00;	DDRA = 0xFF;	DDRC = 0xFF;	TCCR1A = 0x00; //output clock source	TCCR1B = 0x06; //output clock source falling edge	TCNT1H = 0x00; //set count to 0	TCNT1L = 0x00; //set count to 0	char text[] = "TEMPLE MADE ECE";	OLED_Init();  //initialize the OLED	_delay_ms(1);	OLED_Clear(); //clear the display (for good measure)	sei();			// set up global interrupts	PORTB = 0xFF;	while (1)	{//repeat forever		do		{			PORTC = TCNT1H;			PORTA = TCNT1L; //place value on pins			//PORTA = TCNT0; //place value on pins			OLED_SetCursor(1, 0);			OLED_DisplayString(text);		// send text to index 1,0			OLED_SetCursor(2, 0);			OLED_Printf(" TCNT1L: ");			OLED_DisplayNumber(C_DECIMAL_U8,TCNT1L,3);	// send TCNT1L text to index 2,0			OLED_SetCursor(3, 0);			OLED_Printf(" TCNT1H: ");			OLED_DisplayNumber(C_DECIMAL_U8,TCNT1H,3);	// send TCNT1H text to index 3,0			OLED_SetCursor(4, 0);			OLED_HorizontalGraph(4,TCNT1L*100/256);		}		while((TIFR1&(1<<TOV1))==0);//wait for TOV1		TIFR1 = (1<<TOV1); // clear
	}
}