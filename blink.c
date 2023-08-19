#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
        PORTB =  PORTB | (1 <<  PB6);
        DDRB =  DDRB |  (1 << DDB6);

while(1)
{
    PORTB = PORTB ^ (1 << PB6);
    _delay_ms(125);
}

}