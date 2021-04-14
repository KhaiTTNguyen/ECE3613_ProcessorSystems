/*
 * GccApplication5_servo_Timer0_Timer1.c
 *
 * Created: 4/7/2021 4:44:15 PM
 * Author : Khai Nguyen
 */ 

#include <avr/io.h>
#define F_CPU 16000000UL
#include <util\delay.h>

// ----------- declare subroutines ------------
void P1point3();
void P1point5();
void P1point7();
void P20msec();
void clockwise();
void stop();
void counter_clockwise();

int main (void) {	
	while (1)	{		
		DDRD = 1<<2;			
		PORTD &= ~(1<<2);		// set pinD2 ON
		clockwise();			// rotate clockwise subroutine
		stop();					// stop subroutine
		counter_clockwise();	// rotate counter-clockwise
		stop();					// stop subroutine
	}
}

//=========================wave pulse with 3sec duration======================
void clockwise(){
	int counter = 0;
	while (counter < 142){		// 3sec/(1.3+20)ms = 141 loop iterations
		PORTD = 0b0000100;		// PD2 ON
		P1point3();				// delay 1.3ms
		PORTD = 0b0000000;		// PD2 OFF
		P20msec();				// delay 20ms
		counter+=1;				// count till 142 for 3sec clockwise turn
	}
}
void stop(){
	int counter = 0;
	while (counter < 139){		//  3sec/(1.5+20)ms = 139 loop iterations
		PORTD = 0b0000100;		// PD2 ON
		P1point5();				// delay 1.5ms
		PORTD = 0b0000000;		// PD2 OFF
		P20msec();				// delay 20ms
		counter+=1;
	}
}
void counter_clockwise(){
	int counter = 0;
	while (counter < 138){		//  3sec/(1.7+20)ms = 138 loop iteration
		PORTD = 0b0000100;		// PD2 ON
		P1point7();				// delay 1.5ms
		PORTD = 0b0000000;		// PD2 OFF
		P20msec();				// delay 20ms
		counter+=1;
	}
}
// ================================== define subroutines ==================================
// delay 1.3ms Timer0 CTC
void P1point3(){
	TCNT0 = 0x00;					// initial value
	OCR0B=20;						// (1.3x10^-3/(0.0625x10^-6))/1024 = ~20
	TCCR0B = 0b00001101;			// set up CTC mode, 1024 prescaler
	while((TIFR0&(1<<OCF0B))==0);	//stay here until OCF0B=1 rollover
	TCCR0B = 0;
	TIFR0 = (1<<OCF0B);
}
// delay 1.5ms Timer0 CTC
void P1point5(){
	TCNT0 = 0x00;					// initial value
	OCR0B=23;						// 1.5x10^-3/(0.0625x10^-6)/1024 = ~23
	TCCR0B = 0b00001101;			// set up CTC mode, 1024 prescaler
	while((TIFR0&(1<<OCF0B))==0);	//stay here until OCF0B=1 rollover
	TCCR0B = 0;
	TIFR0 = (1<<OCF0B);
}
// delay 1.7ms Timer0 CTC
void P1point7(){
	TCNT0 = 0x00;					// initial value 
	OCR0B=26;						// 1.7x10^-3/(0.0625x10^-6)/1024 = ~27 
	TCCR0B = 0b00001101;			// set up CTC mode, 1024 prescaler
	while((TIFR0&(1<<OCF0B))==0);	//stay here until OCF0B=1 rollover
	TCCR0B = 0;
	TIFR0 = (1<<OCF0B);
}
// delay 20ms Timer1
void P20msec(){
	TCNT1H = 0xEC;					// high reg 0xEC
	TCNT1L = 0x77;					// low reg 0x77
	TCCR1A = 0x00;					// normal mode initial val = 0x00
	TCCR1B = 0x03;					// prescale 64
	while((TIFR1&(1<<TOV1))==0);	// wait till overflow
	TCCR1A = 0;						// reset
	TCCR1B = 0;
	TIFR1 = (1<< TOV1);
}