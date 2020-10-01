CC = gcc
CFLAGS = -std=c11\
	 -pedantic\
	 -Wall\
	 -Wextra\
	 -O2\
	 -lm\
	 -Wshadow\
	 -Wconversion\
	 -Wstrict-overflow=5\
	 -Wformat=2\
	 -Wfloat-equal
DBGCFLAGS = -g -DDEBUG
# OBJS = main.o
OBJS = main.c

all : $(OBJS)
	$(CC) $(CFLAGS) -o all $(OBJS)

.PHONY : clean debug
clean :
#	rm -f all $(OBJS)
	rm -f all

# debug : $(OBJS)
# 	$(CC) $(CFLAGS) $(DBGCFLAGS) -o all $(OBJS)
debug : CFLAGS += $(DBGCFLAGS)
debug : all
