/*
 * GccApplication5-Final2.c
 *
 * Created: 4/26/2021 3:27:14 PM
 * Author : Khai Nguyen
 */ 
#define F_CPU 16000000
#include <avr/io.h>
#include <avr/interrupt.h>
#include "i2c.h"
#include "SSD1306.h"

#define up_count PB5	//pin corresponding to "up" position of RHC button
#define down_count PB7	//pin corresponding to "down" position of RHC button

volatile char dutyCycle = 0;	//global variable containing selected motor speed value
volatile char lastInput = 0;	//variable to store the last state of PORTB
int count_int = 0;				//set pwm value to 0 (no pwm) initially

void OLED_display(){	//this will update the OLED display with the most current info
	OLED_SetCursor(0, 0);
	OLED_Printf("Example of Joystick ");
	OLED_SetCursor(2, 0);
	OLED_Printf("Counter: ");
	OLED_DisplayNumber(C_DECIMAL_U8,count_int,6);
	OLED_SetCursor(4, 0);
	OLED_Printf("Duty Cycle: ");
	OLED_DisplayNumber(C_DECIMAL_U8,dutyCycle,6);
}

int main(void){
	//set data direction of used ports
	DDRB = 0x00;	//set port b pins to inputs
	PORTB = 0xA0;	//set port b pins to have pull-up resistors 10100000
	
	OLED_Init(); //INITIALIZE THE OLED
	OLED_Clear(); //CLEAR THE DISPLAY
	
	while (1) {	//infinite loop
		char joystick = (0b11110000&PINB);	//get high 4 bits of PORTB (contains up and down button)
		joystick = joystick^0xf0;	//invert value of of up and down button (Pullup resistors pull pins high)
		if(lastInput != joystick){		//check if PORTB has been updated
			if(joystick&(1<<up_count)){	//check for up button being pressed
				if(count_int < 10)		//if the PWM value is less than 10,
				count_int++;	//YES: increment it
			}
			if(joystick&(1<<down_count)){	//check for down button being pressed
				if(count_int > 0)			//if the PWM value is more than 0,
				count_int--;	//NO: decrement it
			}
			dutyCycle = count_int*10;//update dutyCycle variable for OLED display
			lastInput = joystick;	//keep the latest PORTB input
		}
		OLED_display();	//update OLED display
	}
}

