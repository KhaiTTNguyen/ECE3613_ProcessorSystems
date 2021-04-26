/*
 * GccApplication-Finalproject-PWM-Motor.c
 *
 * Created: 4/21/2021 4:08:38 PM
 * Author : Khai Nguyen
 */ 

#define F_CPU 16000000
#include <avr/io.h>
#include <avr/interrupt.h>
#include "i2c.h"
#include "SSD1306.h"

#define up_count PB5	//pin corresponding to "up" position of RHC button
#define down_count PB7	//pin corresponding to "down" position of RHC button
#define DCmotor PE2
//------- variables for DCmotor -------------
volatile char dutyCycle = 0;	//global variable containing selected motor speed value
volatile char lastInput = 0;	//variable to store the last state of PORTB
int count_int = 0;				//set pwm value to 0 (no pwm) initially
double dc_adj=0;	//duty cycle adjusting parameter
int n=1; //speed controller for motor when the motor runs too fast, use 1 when you test your signal.

//------- variables for sensor -------------
#define SensorPin PD2	//opto-interrupter sensor pin
volatile int counter = 0;	//track how many times timer0 has overflowed
volatile int Sensor_counter=0; //count of opto-interrupter reading
volatile double RPM=0; //count of opto-interrupter reading


void OLED_display(){	//this will update the OLED display with the most current info
	OLED_SetCursor(0, 0);
	OLED_Printf("Mode       : ");
	OLED_DisplayNumber(C_DECIMAL_U8,count_int,3);
	OLED_SetCursor(2, 0);
	OLED_Printf("Duty Cycle : ");
	OLED_DisplayNumber(C_DECIMAL_U8,dutyCycle,3);	
	OLED_SetCursor(4, 0);
	OLED_Printf("RPM        : ");
	OLED_DisplayNumber(C_DECIMAL_U8,RPM,6);
}

int main(void){
	//set data direction of used ports
	DDRB = 0x00;	//set port b pins to inputs
	PORTB = 0xA0;	//set port b pins to have pull-up resistors 10100000
	
	// ----------------------------------- interrupt on PD2 for optosensor -------------------------------------
	DDRD &= ~(1<<SensorPin);		//set trigger pin to be an input
	PORTD |= (1<<SensorPin);		//Set trigger pin to have a pull-up resistor
	//---- initialize timer0 --- as refenrence time 
	TCCR0A |= (1<<WGM01);			//set timer0 to be CTC
	TCCR0B |= (1<<CS00)|(1<<CS02);	//set timer0 to a 1024 pre-scaler
	TIMSK0 |= (1<<OCIE0A);			//set timer0A to have an interrupt
	OCR0A = 0xff;					//set timer0A to interrupt when it reaches 0xff - 255
	sei();							//start interrupt routine
	//initialize INT0 (PD2)	----- to get interrupts	 
	EIMSK |= (1<<INT0);				//enable int0 interrupt
	EICRA |= (1<<ISC01);			//set int0 to falling edge
	sei();							//start interrupt routine
	
	// ------------------------------------- DC motor PWM setup --------------------------------------------	
	//configuration
	DDRE |= (1<<DCmotor);//set motor pin to output
	TCNT1 = 0x00;
	OCR1A=0x00;					//full speed: ON-TIME of PWM ----ON time
	OCR1B=0XFFFF;				// OFF TIME
	// initialize timer1 CTC mode
	TCCR1A |= (1<<COM1A0)|(1<<COM1B0);	//enable timer1a and timer1b comparison
	TCCR1B |= (1<<CS10);				//enable timer1 with no pre-scaler
	TIMSK1 |= (1<<OCIE1A)|(1<<OCIE1B);	//enable timer1A and timer1B interrupts
	sei();
		
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
		
		if (count_int == 0){
			OCR1A = 0xFF;
		} else {
			dc_adj = 0.1 * count_int;
			OCR1A = 0xFFFF * dc_adj/n;	//reassign timer1 value for On-time pulse, dividing by 2 is scaling of motor speed	
		}
		OLED_display();	//update OLED display
	}
}


// ---------------- DC motor PWM - Duty cycle control using Timer1 compare match mode interrupt ----------------
ISR(TIMER1_COMPA_vect){	//ISR for when timer1A interrupts
	PORTE &= ~(1<<DCmotor);	//turn off PE2 pin
}
ISR(TIMER1_COMPB_vect){	//ISR for when timer1B interrupts
	PORTE |= (1<<DCmotor);	//turn on PE2 pin
}



//Example 3. Read the sensor reading and display RPM
ISR(TIMER0_COMPA_vect){	//ISR for when timer0 overflows
	counter++;	//increase counter variable
	int k=2; //number of sensor reading per 1 revolution, if you have 2 wheel opening, change to 2
	if(counter >= 200){	//when counter equals 200
		//These are samples of RPM calculation. Use your equation here.
		//Sample 1.
		//RPM = ((Sensor_counter*(60000/(16.32*200 )))/2);	//calculate RPM with eqn ((trig_counts*(milliseconds_in_1_second/(milliseconds_for_1_clock_cycle*number_of_loop_itererations)))/2_triggers_in_1_revolution)
		// Sample2. Sensor count in 3.28sec
		RPM = ((Sensor_counter/((256*0.0625*0.000001*1024)*200))*60)/k; //RPM=((sensor_counter/((timer value)*number_of_loop))*seconds for 1 minute)/number_of_sensor_counts_per_1_revolution);
		Sensor_counter = 0;	//reset trigger_count variable
		counter = 0;	//reset timer0 counter variable
	}
}
ISR(INT0_vect, ISR_BLOCK){	//ISR for when PD2 detects a falling edge
	Sensor_counter++;	//increase trigger counter variable
}
