SHELL = /bin/sh

.PHONY: all clean

TARGETS = get_std_spelling.out

SRC = get_std_spelling.c

LIBPATH = LPATH

all: get_std_spelling.out

get_std_spelling.out: get_std_spelling.c
	gcc -g -Wall -o get_std_spelling.out get_std_spelling.c

clean:
	rm -f $(TARGETS)
