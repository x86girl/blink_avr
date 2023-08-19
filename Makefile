# Author: Priscila Gutierres
# License: MIT

.DEFAULT_GOAL := blink
DEVICE 	   = atmega328p
MCU = m48p
USB = /dev/ttyACM0
CLOCK      = 4000000
FUSES      = -U lfuse:w:0x42:m -U hfuse:w:0xdf:m -U efuse:w:0xff:m

OBJCOPY = avr-objcopy
AVRDUDE = avrdude

CC = avr-gcc 

CC_FLAGS = -Wall 			\
-Os 						\
-DF_CPU=$(CLOCK) 			\
-mmcu=$(DEVICE)				\

blink.o: blink.c
	$(CC) $(CC_FLAGS) -c blink.c

blink: blink.o
	$(CC) -o $@ $^

install: blink
	$(OBJCOPY) -j .text -j .data -O ihex $^ $^.hex
# $(AVRDUDE) -c avrispmkII -p $(MCU) -U flash:w: $^.hex
	avrdude - -v -patmega328p -carduino -P/dev/ttyUSB0 -b115200 -D -Uflash:w:blink.hex:i


clean:	blink
	rm -f *.o
	rm -f *.hex
	rm -f *.elf
	rm -f $^
