CC = gcc
CFLAGS = -std=c11 -Wall -Wextra
DBGCFLAGS = -g -DDEBUG
OBJS = main.o

all : $(OBJS)
	$(CC) $(CFLAGS) -o all $(OBJS)

.PHONY : clean
clean :
	rm -f all
debug : all
	$(CC) $(CFLAGS) $(DBGCFLAGS) -o all $(OBJS)
