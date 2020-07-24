CC = gcc
CFLAGS = -std=c11 -Wall -Wextra
DBGCFLAGS = -g -DDEBUG
OBJS = main.c

all : $(OBJS)
	$(CC) $(CFLAGS) -o all $(OBJS)

.PHONY : clean debug
clean :
	rm -f all
#debug : $(OBJS)
#	$(CC) $(CFLAGS) $(DBGCFLAGS) -o all $(OBJS)
debug : CFLAGS += $(DBGCFLAGS)
debug : all
