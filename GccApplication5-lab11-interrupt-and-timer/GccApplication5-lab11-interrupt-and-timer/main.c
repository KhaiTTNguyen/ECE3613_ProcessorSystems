/*
 * GccApplication5-lab11-interrupt-and-timer.c
 *
 * Created: 4/17/2021 1:40:29 PM
 * Author : Khai Nguyen
 */ 
// C-code timer0 overflow ISR to generate a pulse on PORTD pin7 while transferring data from PORTB to PORTA
#include "avr/io.h"
#include "avr/interrupt.h"

/*
int main ( )
{

	DDRB = 0x00;//make PORTB input
	PORTB = 0xFF;//enable pull-up
	DDRA = 0xFF;//make PORTA output
	DDRD = 0xFF;//make PORTD output
	// -------------setup timer0----------------
	TCNT0 = 0x00;					// initial value
	OCR0B=41;						// 0.167ms /.0625?s = 2672 the 2672/64=41 ticks
	TCCR0B = 0x0B;					// ;use 0x0B CTC mode 64 prescaling ; 0b00001011
	TIMSK0 = (1<<OCIE0B);			//enable Timers 0 interrupt
	sei ();							//enable interrupts

	while (1){//wait here
		PORTA = PINB;
	}
}


ISR (TIMER0_COMPB_vect,ISR_BLOCK)   //ISR for Timer0 overflow
{
	PORTD ^= (1<<7);//toggle PORTD.7
	TCNT0=0;
}
*/
# define F_CPU 16000000UL
#include <util/delay.h>
#include <avr/interrupt.h>
#include "SSD1306.h"
//#include "SSD1306.c" //Not sure why I need to include this file here
// Declare Global Variables
volatile int counter;
int main(void)
{
	OLED_Init();  //initialize the OLED
	_delay_ms(1);
	OLED_Clear(); //clear the display (for good measure)
	
	DDRA = 0xFF;//make PORTA output
	
	counter = 0;// Initialize counter
	DDRD = 0;// Port D all inputs
	PORTD |= (1<<2)|(1<<3);// Set Pull up resistor PD2 (INT0) and PD3 (INT1)
	EIMSK=(1<<INT0)|(1<<INT1); //unmask INT0 and INT1
	EICRA=0X0A; //INT0 and INT1 WILL ACTIVATE Rising EDGE TRIGGER
	sei();// Set Interrupt Flag
	OLED_SetCursor(0, 0);        //set the cursor position to (0, 0)
	OLED_Printf("Lab 11 - Act 5   "); //Print out some text

	while(1){
		// Wait For Interrupts and Update LEDs
		OLED_SetCursor(4, 0);
		OLED_Printf("count: ");
		OLED_DisplayNumber(C_DECIMAL_U8,counter,3);
		if (counter>10){
			PORTA = 0x80;
		}else{
			PORTA = 0;
		}
	}
}
// External Interrupt on Port D Pin 2
ISR(INT0_vect, ISR_BLOCK)
{
	counter++;// Increment counter when pin changes
}
// External Interrupt on Port D Pin 3
ISR(INT1_vect, ISR_BLOCK)
{
	counter--;// Increment counter when pin changes
}
