/*
 * GccApplication4.c
 *
 * Created: 4/2/2021 11:38:53 AM
 * Author : Khai Nguyen
 */ 

#include <avr/io.h>

# define F_CPU 16000000UL#include <util/delay.h>#include <avr/interrupt.h>#include "SSD1306.h"//#include "SSD1306.c" //Not sure why I need to include this file here#include <avr/io.h>int main (void){	PORTB= 0x01; //activate pullup PB0	DDRB=0x00;	DDRA = 0xFF;	TCCR0B = 0x06; //output clock source	TCNT0 = 0x00; //set count to 0	char text[] = "TEMPLE MADE ECE";	OLED_Init();  //initialize the OLED	_delay_ms(1);	OLED_Clear(); //clear the display (for good measure)	sei();	PORTB = 0xFF;	while (1)	{		//repeat forever		do		{			PORTA = TCNT0; //place value on pins			OLED_SetCursor(1, 0);			OLED_DisplayString(text);			OLED_SetCursor(4, 0);			OLED_Printf(" uint8_t count: ");			OLED_DisplayNumber(C_DECIMAL_U8,TCNT0,3);			OLED_HorizontalGraph(2,TCNT0*100/256);		}		while((TIFR0&(0x1<<TOV0))==0);//wait for TOV1		TIFR0 = 0x1<TOV0; //clear TOV1	}}
