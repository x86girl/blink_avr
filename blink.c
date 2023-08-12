#ifndef F_CPU
#define F_CPU 4000000L
#endif

#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
	PORTB = 0b00000001;
	DDRB = 0b00000000;

	while(1)
	{
		! PORTB;
		_delay_ms(125);
	}

	return 0;
}