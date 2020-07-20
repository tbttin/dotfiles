CC = gcc
CFLAGS = -std=c11 -Wall -Wextra
CDBGFLAGS = -g -DDEBUG
OBJS = main.o

all : $(OBJS)
	$(CC) $(CFLAGS) -o all $(OBJS)

.PHONY : clean
clean :
	rm -f all
debug : all
	$(CC) $(CFLAGS) $(CDBGFLAGS) -o all $(OBJS)
