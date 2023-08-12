# Author: Priscila Gutierres
# License: MIT

.DEFAULT_GOAL := blink
DEVICE 	   = attiny2313a
MCU = m48p
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

all: blink
	$(OBJCOPY) -j .text -j .data -O ihex $^ $^.hex
	$(AVRDUDE) -c avrispmkII -p $(MCU) -U flash:w: $^.hex



clean:	blink
	rm -f *.o
	rm -f *.hex
	rm -f *.elf
	rm -f $^