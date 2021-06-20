CC            := cc
CFLAGS        := -std=c11\
	        -pedantic\
	        -Wall\
	        -Wextra\
	        -O2\
	        -Wshadow\
	        -Wconversion\
	        -Wstrict-overflow=5\
	        -Wformat=2\
	        -Wfloat-equal
# 	        -g
# 	        -lm
DBGCFLAGS     := -g\
		-DDEBUG
PROG          := prog.out
RM            := rm -f
TAG           := ctags -R
OUTPUT_OPTION = -MMD -MP -o $@

SOURCE := $(wildcard *.c)
OBJS   := $(SOURCE:.c=.o)
DEPS   := $(SOURCE:.c=.d)
.PHONY: all debug clean tags run

all: ${PROG}

${PROG}: ${OBJS}
	${CC} -o ${PROG} ${OBJS}

-include ${DEPS}

debug: clean
debug: CFLAGS += ${DBGCFLAGS}
debug: all

clean:
	${RM} ${PROG} ${OBJS} ${DEPS}

tags:
	${TAG}

run:
	-@./${PROG}
