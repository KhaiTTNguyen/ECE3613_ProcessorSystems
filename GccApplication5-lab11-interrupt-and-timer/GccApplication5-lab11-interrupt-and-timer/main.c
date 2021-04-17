/*
 * GccApplication5-lab11-interrupt-and-timer.c
 *
 * Created: 4/17/2021 1:40:29 PM
 * Author : Khai Nguyen
 */ 

// C-code timer1 overflow ISR to generate a 1.3ms pulse on PORTD pin3 while transferring data from PORTB to PORTA
#include "avr/io.h"
#include "avr/interrupt.h"

int main ( )
{

	DDRB = 0x00;//make PORTB input
	PORTB = 0xFF;//enable pull-up
	DDRA = 0xFF;//make PORTA output
	DDRD = 0xFF;//make PORTD output
	TCCR0A = 0x00;
	TCCR0B = 0x01;//Normal mode, int clk, no prescaler
	//do a 1.3 msec pulse
	TCNT1H = 0xAE;
	TCNT1L = 0xBF;
	TCCR1A = 0x00;
	TCCR1B = 0x01;
	PORTD = 0b0001000;// Toggle portd.3
	TIMSK1 = (1<<TOIE1); //enable Timers 1 interrupt
	sei (); //enable interrupts

	while (1)//wait here
	PORTA = PINB;
}


ISR (TIMER1_OVF_vect)   //ISR for Timer0 overflow
{
	TCNT1H = 0xAE;
	TCNT1L = 0xBF;
	PORTD ^= (1<<3);//toggle PORTD.3
}
